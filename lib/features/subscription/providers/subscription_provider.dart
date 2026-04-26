import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../data/services/subscription_service.dart';
import '../../../core/services/analytics_service.dart';
import '../../profile/providers/settings_provider.dart';

/// Exposes premium status + offerings to the UI. Subscribes to the underlying
/// [SubscriptionService] stream so paywall + gating re-render on entitlement
/// changes.
class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    SubscriptionService? service,
    SettingsProvider? settingsProvider,
    AnalyticsService? analytics,
  }) : _service = service ?? SubscriptionService.instance,
       _settingsProvider = settingsProvider,
       _analytics = analytics ?? AnalyticsService() {
    _isPremium = _service.lastKnownPremium;
    _sub = _service.premiumStatusStream.listen(_handleUpdate);
    unawaited(refresh());
  }

  final SubscriptionService _service;
  final SettingsProvider? _settingsProvider;
  final AnalyticsService _analytics;

  StreamSubscription<bool>? _sub;

  bool _isPremium = false;
  bool _loadingOfferings = false;
  Offerings? _offerings;
  String? _offeringsError;

  bool get isPremium => _isPremium;
  bool get isFree => !_isPremium;
  bool get isLoadingOfferings => _loadingOfferings;
  Offerings? get offerings => _offerings;
  String? get offeringsError => _offeringsError;

  /// Onboarding paywall plan index:
  /// 0 = special annual, 1 = annual, 2 = weekly.
  Package? packageForOnboardingPlan(int planIndex) {
    return switch (planIndex) {
      0 =>
        _packageByIdentifier(SubscriptionService.specialAnnualPackageId) ??
            _packageByIdentifier(SubscriptionService.annualPackageId),
      1 => _packageByIdentifier(SubscriptionService.annualPackageId),
      2 => _packageByIdentifier(SubscriptionService.weeklyPackageId),
      _ => defaultUpgradePackage,
    };
  }

  Package? get defaultUpgradePackage {
    return _packageByIdentifier(SubscriptionService.specialAnnualPackageId) ??
        _packageByIdentifier(SubscriptionService.annualPackageId) ??
        _packageByIdentifier(SubscriptionService.weeklyPackageId) ??
        _firstAvailablePackage;
  }

  Package? _packageByIdentifier(String identifier) {
    final packages = _offerings?.current?.availablePackages;
    if (packages == null) return null;
    for (final package in packages) {
      if (package.identifier == identifier) return package;
    }
    return null;
  }

  Package? get _firstAvailablePackage {
    final packages = _offerings?.current?.availablePackages;
    if (packages == null || packages.isEmpty) return null;
    return packages.first;
  }

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
    _loadingOfferings = true;
    _offeringsError = null;
    notifyListeners();
    try {
      final o = await _service.getOfferings();
      _offerings = o;
      if (o == null) {
        _offeringsError = 'Unable to load plans. Check your connection.';
      }
    } catch (e) {
      _offeringsError = 'Unable to load plans.';
      debugPrint('SubscriptionProvider loadOfferings failed: $e');
    }
    _loadingOfferings = false;
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
    } else if (!result.cancelled) {
      unawaited(
        _analytics.logPurchaseFailed(
          package.identifier,
          result.error ?? 'unknown',
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
    _sub?.cancel();
    super.dispose();
  }
}
