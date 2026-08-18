import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../data/services/subscription_service.dart';
import '../../../core/services/analytics_service.dart';
import '../../profile/providers/settings_provider.dart';
import '../paywall_offer_state.dart';

/// Fetches the current user's introductory-offer eligibility for a set of
/// product identifiers. Injectable for tests; defaults to
/// [SubscriptionService.checkTrialEligibility].
typedef TrialEligibilityChecker =
    Future<Map<String, IntroEligibility>> Function(
      List<String> productIdentifiers,
    );

/// Exposes premium status + offerings to the UI. Subscribes to the underlying
/// [SubscriptionService] stream so paywall + gating re-render on entitlement
/// changes.
class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    SubscriptionService? service,
    SettingsProvider? settingsProvider,
    AnalyticsService? analytics,
    TrialEligibilityChecker? trialEligibilityChecker,
    bool? isApplePlatform,
    @visibleForTesting Future<Offerings?> Function()? offeringsLoader,
  }) : _service = service ?? SubscriptionService.instance,
       _settingsProvider = settingsProvider,
       _analytics = analytics ?? AnalyticsService(),
       _offeringsLoader = offeringsLoader,
       _trialEligibilityChecker = trialEligibilityChecker,
       _isApplePlatform =
           isApplePlatform ??
           (!kIsWeb &&
               (defaultTargetPlatform == TargetPlatform.iOS ||
                   defaultTargetPlatform == TargetPlatform.macOS)) {
    _isPremium = _service.lastKnownPremium;
    _sub = _service.premiumStatusStream.listen(_handleUpdate);
    unawaited(refresh());
  }

  final SubscriptionService _service;
  final SettingsProvider? _settingsProvider;
  final AnalyticsService _analytics;
  final TrialEligibilityChecker? _trialEligibilityChecker;
  final bool _isApplePlatform;
  final Future<Offerings?> Function()? _offeringsLoader;

  StreamSubscription<bool>? _sub;

  bool _isPremium = false;
  bool _loadingOfferings = false;
  Offerings? _offerings;
  SubscriptionErrorCode? _offeringsErrorCode;
  bool _disposed = false;

  /// Current user's introductory-offer eligibility, keyed by product
  /// identifier. Missing entries mean unknown, which fails closed.
  final Map<String, TrialEligibility> _trialEligibility = {};

  /// Invalidates in-flight eligibility fetches when offerings are reloaded so
  /// a stale response can never resurrect trial copy for replaced products.
  int _trialEligibilityGeneration = 0;

  bool get isPremium => _isPremium;
  bool get isFree => !_isPremium;
  bool get isLoadingOfferings => _loadingOfferings;
  Offerings? get offerings => _offerings;
  SubscriptionErrorCode? get offeringsErrorCode => _offeringsErrorCode;
  bool get showSpecialOffer => _service.shouldShowSpecialOffer(_offerings);

  /// Onboarding paywall plan index:
  /// 0 = special annual, 1 = annual, 2 = weekly.
  Package? packageForOnboardingPlan(int planIndex) {
    return _service.packageForOnboardingPlan(_offerings, planIndex);
  }

  Package? get defaultUpgradePackage =>
      _service.defaultUpgradePackage(_offerings);

  /// Per-free-user hard limits. Enforced by the UI through [canAddPeptide] /
  /// [canAddProtocol] before calling into the data providers.
  static const int freePeptideLimit = 1;
  static const int freeProtocolLimit = 1;

  bool canAddProtocol(int currentCount) =>
      _isPremium || currentCount < freeProtocolLimit;

  bool canAddPeptide(int currentCount) =>
      _isPremium || currentCount < freePeptideLimit;

  void _handleUpdate(bool premium) {
    _isPremium = premium;
    _settingsProvider?.setSubscriptionState(premium ? 'premium' : 'free');
    notifyListeners();
  }

  Future<void> refresh() async {
    try {
      final premium = await _service.isPremium();
      _handleUpdate(premium);
    } catch (e) {
      debugPrint('SubscriptionProvider refresh failed: $e');
    }
  }

  Future<void> loadOfferings() async {
    // Eligibility belongs to the current offerings snapshot. Clear it before
    // loading so a previous eligible result cannot flash on a refreshed
    // product while the new check is in flight.
    _trialEligibility.clear();
    _trialEligibilityGeneration++;
    _loadingOfferings = true;
    _offeringsErrorCode = null;
    notifyListeners();
    try {
      final o = await (_offeringsLoader ?? _service.getOfferings)();
      _offerings = o;
      if (o == null) {
        _offeringsErrorCode = SubscriptionErrorCode.plansUnavailable;
      }
    } catch (e) {
      _offeringsErrorCode = SubscriptionErrorCode.plansUnavailable;
      debugPrint('SubscriptionProvider loadOfferings failed: $e');
    }
    _loadingOfferings = false;
    if (_disposed) return;
    notifyListeners();
    await _refreshTrialEligibility();
  }

  /// Introductory-offer eligibility of the current user for a product, or
  /// [TrialEligibility.unknown] while unfetched/unresolved. Only
  /// [TrialEligibility.eligible] may ever surface trial copy.
  TrialEligibility trialEligibilityFor(String productIdentifier) =>
      _trialEligibility[productIdentifier] ?? TrialEligibility.unknown;

  /// The free trial the current user can actually start for [product], or
  /// null when no trial may be advertised. See [resolveTrialOffer] for the
  /// platform semantics.
  StoreTrialOffer? trialOfferForProduct(StoreProduct product) =>
      resolveTrialOffer(
        product: product,
        isApplePlatform: _isApplePlatform,
        eligibilityFor: trialEligibilityFor,
      );

  /// Re-checks Apple introductory-offer eligibility for the products shown on
  /// the paywall. Android derives trials from Play-filtered subscription
  /// options instead, so no call is made there.
  Future<void> _refreshTrialEligibility() async {
    final generation = ++_trialEligibilityGeneration;
    // Reset first so replaced products fail closed until re-confirmed.
    _trialEligibility.clear();
    if (!_isApplePlatform) return;

    final ids = <String>{};
    for (final planIndex in const [0, 1, 2]) {
      final product = packageForOnboardingPlan(planIndex)?.storeProduct;
      if (product == null) continue;
      if (trialOfferFromIntroductoryPrice(product.introductoryPrice) != null) {
        ids.add(product.identifier);
      }
    }
    if (ids.isEmpty) return;

    Map<String, IntroEligibility> result;
    try {
      final checker =
          _trialEligibilityChecker ?? _service.checkTrialEligibility;
      result = await checker(ids.toList(growable: false));
    } catch (e) {
      debugPrint('SubscriptionProvider trial eligibility check failed: $e');
      return; // Unknown — trial copy stays suppressed.
    }
    if (_disposed || generation != _trialEligibilityGeneration) return;

    for (final entry in result.entries) {
      _trialEligibility[entry.key] = switch (entry.value.status) {
        IntroEligibilityStatus.introEligibilityStatusEligible =>
          TrialEligibility.eligible,
        IntroEligibilityStatus.introEligibilityStatusIneligible ||
        IntroEligibilityStatus.introEligibilityStatusNoIntroOfferExists =>
          TrialEligibility.ineligible,
        IntroEligibilityStatus.introEligibilityStatusUnknown =>
          TrialEligibility.unknown,
      };
    }
    notifyListeners();
  }

  Future<PurchaseResult> purchase(Package package) async {
    unawaited(_analytics.logPurchaseInitiated(package.identifier));
    final result = await _service.purchasePackage(package);
    if (result.success) {
      final product = package.storeProduct;
      unawaited(
        _analytics.logPurchaseCompleted(package.identifier, product.price),
      );
    } else if (result.cancelled) {
      unawaited(_analytics.logPurchaseCancelled(package.identifier));
    } else {
      unawaited(
        _analytics.logPurchaseFailed(
          package.identifier,
          result.errorCode?.name ?? 'unknown',
        ),
      );
    }
    return result;
  }

  Future<RestoreResult> restore() async {
    final result = await _service.restorePurchases();
    if (result.success) {
      unawaited(_analytics.logPurchaseRestored());
    }
    return result;
  }

  @override
  void dispose() {
    _disposed = true;
    _sub?.cancel();
    super.dispose();
  }
}
