import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Wraps RevenueCat with PepMod-specific API keys + entitlement.
///
/// Configure with [configure] once at app startup (in main.dart essential init).
class SubscriptionService {
  SubscriptionService._();

  static final SubscriptionService instance = SubscriptionService._();

  /// RevenueCat entitlement granted to premium users. Matches the identifier
  /// the RC dashboard issues for the PepMod project.
  static const String entitlementId = 'premium';

  // PepMod RevenueCat public SDK keys. These are app-specific public keys
  // from the PepMod RevenueCat project.
  static const String _iosKey = 'appl_XKNkSMbIyAVTRVSBAbNmGqTdllb';

  static const String _androidKey = 'goog_vMyLzNLVaxLKmngFQFYgbMFgSzS';

  static const String specialAnnualPackageId = 'special_annual';
  static const String annualPackageId = r'$rc_annual';
  static const String weeklyPackageId = r'$rc_weekly';
  static const String defaultSpecialOfferOfferingId = 'special_offer';
  static const String specialOfferingMetadataKey = 'special_offering';
  static const String showSpecialOfferMetadataKey =
      'show_special_offer_on_subscription_screen';

  /// Build-time override: bypass RC and treat the user as premium. Set via
  /// `--dart-define=FORCE_PREMIUM=true` for internal test builds.
  static const bool forcePremium = bool.fromEnvironment('FORCE_PREMIUM');

  final StreamController<bool> _premiumController =
      StreamController<bool>.broadcast();

  Stream<bool> get premiumStatusStream => _premiumController.stream;

  bool _configured = false;
  bool get isConfigured => _configured;

  bool _lastKnownPremium = false;
  bool get lastKnownPremium => _lastKnownPremium;

  /// Configure the RC SDK and wire up the customer-info listener.
  /// Call once in main.dart essential init.
  Future<void> configure() async {
    if (_configured) return;
    try {
      final key = Platform.isIOS ? _iosKey : _androidKey;
      if (key.startsWith('TODO_')) {
        debugPrint('[SubscriptionService] RC key not configured; skipping.');
        return;
      }
      await Purchases.configure(PurchasesConfiguration(key));
      Purchases.addCustomerInfoUpdateListener(_handleCustomerInfoUpdate);
      _configured = true;
    } catch (e) {
      debugPrint('[SubscriptionService] configure failed: $e');
    }
  }

  Future<void> login(String userId) async {
    if (!_configured) return;
    try {
      final result = await Purchases.logIn(userId);
      _handleCustomerInfoUpdate(result.customerInfo);
    } catch (e) {
      debugPrint('[SubscriptionService] login failed: $e');
    }
  }

  Future<void> logout() async {
    if (!_configured) return;
    try {
      await Purchases.logOut();
      _lastKnownPremium = false;
      _premiumController.add(false);
    } catch (e) {
      debugPrint('[SubscriptionService] logout failed: $e');
    }
  }

  Future<bool> isPremium() async {
    if (forcePremium) return true;
    if (!_configured) return false;
    try {
      final info = await Purchases.getCustomerInfo();
      final premium = info.entitlements.active.containsKey(entitlementId);
      _lastKnownPremium = premium;
      return premium;
    } catch (e) {
      debugPrint('[SubscriptionService] isPremium failed: $e');
      return _lastKnownPremium;
    }
  }

  Future<Offerings?> getOfferings() async {
    if (!_configured) return null;
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('[SubscriptionService] getOfferings failed: $e');
      return null;
    }
  }

  /// Returns whether the current/default offering metadata allows showing the
  /// mobile special-offer card. A missing metadata key preserves legacy
  /// behavior once offerings are loaded.
  bool shouldShowSpecialOffer(Offerings? offerings) {
    if (offerings == null) return false;
    return shouldShowSpecialOfferFromMetadata(
      offerings.current?.metadata ?? const <String, Object?>{},
    );
  }

  /// Returns the configured special offer, or null when current-offering
  /// metadata explicitly hides it.
  Offering? specialOfferOffering(Offerings? offerings) {
    if (offerings == null || !shouldShowSpecialOffer(offerings)) return null;
    final metadata = offerings.current?.metadata ?? const <String, Object?>{};
    return offerings.all[specialOfferingIdFromMetadata(metadata)];
  }

  Package? packageForOnboardingPlan(Offerings? offerings, int planIndex) {
    return switch (planIndex) {
      0 =>
        _specialAnnualPackage(offerings) ??
            _packageByIdentifier(offerings?.current, annualPackageId) ??
            _packageByIdentifier(offerings?.current, weeklyPackageId) ??
            _firstNonSpecialPackage(offerings?.current),
      1 => _packageByIdentifier(offerings?.current, annualPackageId),
      2 => _packageByIdentifier(offerings?.current, weeklyPackageId),
      _ => defaultUpgradePackage(offerings),
    };
  }

  Package? defaultUpgradePackage(Offerings? offerings) {
    return _specialAnnualPackage(offerings) ??
        _packageByIdentifier(offerings?.current, annualPackageId) ??
        _packageByIdentifier(offerings?.current, weeklyPackageId) ??
        _firstNonSpecialPackage(offerings?.current);
  }

  Package? _specialAnnualPackage(Offerings? offerings) {
    if (!shouldShowSpecialOffer(offerings)) return null;
    final specialOffering = specialOfferOffering(offerings);
    return _packageByIdentifier(specialOffering, specialAnnualPackageId) ??
        _firstPackage(specialOffering) ??
        _packageByIdentifier(offerings?.current, specialAnnualPackageId);
  }

  static Package? _packageByIdentifier(Offering? offering, String identifier) {
    final packages = offering?.availablePackages;
    if (packages == null) return null;
    for (final package in packages) {
      if (package.identifier == identifier) return package;
    }
    return null;
  }

  static Package? _firstPackage(Offering? offering) {
    final packages = offering?.availablePackages;
    if (packages == null || packages.isEmpty) return null;
    return packages.first;
  }

  static Package? _firstNonSpecialPackage(Offering? offering) {
    final packages = offering?.availablePackages;
    if (packages == null) return null;
    for (final package in packages) {
      if (package.identifier != specialAnnualPackageId) return package;
    }
    return null;
  }

  @visibleForTesting
  static bool shouldShowSpecialOfferFromMetadata(
    Map<String, Object?> metadata,
  ) {
    return parseMetadataBool(metadata[showSpecialOfferMetadataKey]) ?? true;
  }

  @visibleForTesting
  static String specialOfferingIdFromMetadata(Map<String, Object?> metadata) {
    final value = metadata[specialOfferingMetadataKey];
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
    return defaultSpecialOfferOfferingId;
  }

  @visibleForTesting
  static bool? parseMetadataBool(Object? value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      switch (value.trim().toLowerCase()) {
        case 'true':
        case '1':
        case 'yes':
        case 'y':
        case 'on':
          return true;
        case 'false':
        case '0':
        case 'no':
        case 'n':
        case 'off':
          return false;
      }
    }
    return null;
  }

  /// Attach RevenueCat subscriber attributes only after the SDK is configured.
  /// The Purchases Flutter plugin can hard-fail natively if called before
  /// configure(), so all app code should route attribute writes through here
  /// instead of calling [Purchases.setAttributes] directly.
  Future<void> setAttributes(Map<String, String> attributes) async {
    if (!_configured) return;
    try {
      await Purchases.setAttributes(attributes);
    } catch (e) {
      debugPrint('[SubscriptionService] setAttributes failed: $e');
    }
  }

  Future<PurchaseResult> purchasePackage(Package package) async {
    if (!_configured) {
      return PurchaseResult(
        success: false,
        error: 'Subscription service is not configured yet.',
      );
    }
    try {
      final info = await Purchases.purchasePackage(package);
      _handleCustomerInfoUpdate(info);
      final premium = customerInfoHasPremium(info);
      return PurchaseResult(success: premium, customerInfo: info);
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      return PurchaseResult(
        success: false,
        error: _handlePurchaseError(code),
        cancelled: code == PurchasesErrorCode.purchaseCancelledError,
      );
    } catch (_) {
      return PurchaseResult(
        success: false,
        error: 'An unexpected error occurred.',
      );
    }
  }

  void syncCustomerInfo(CustomerInfo info) {
    _handleCustomerInfoUpdate(info);
  }

  static bool customerInfoHasPremium(CustomerInfo info) {
    return info.entitlements.active.containsKey(entitlementId);
  }

  Future<RestoreResult> restorePurchases() async {
    if (!_configured) {
      return RestoreResult(
        success: false,
        isPremium: false,
        error: 'Subscription service is not configured yet.',
      );
    }
    try {
      final info = await Purchases.restorePurchases();
      _handleCustomerInfoUpdate(info);
      final premium = customerInfoHasPremium(info);
      return RestoreResult(success: true, isPremium: premium);
    } catch (_) {
      return RestoreResult(
        success: false,
        isPremium: false,
        error: 'Failed to restore purchases.',
      );
    }
  }

  void _handleCustomerInfoUpdate(CustomerInfo info) {
    final premium = customerInfoHasPremium(info);
    _lastKnownPremium = premium;
    _premiumController.add(premium);
  }

  String _handlePurchaseError(PurchasesErrorCode error) {
    switch (error) {
      case PurchasesErrorCode.purchaseCancelledError:
        return 'Purchase was cancelled.';
      case PurchasesErrorCode.purchaseNotAllowedError:
        return 'Purchases are not allowed on this device.';
      case PurchasesErrorCode.purchaseInvalidError:
        return 'The purchase was invalid.';
      case PurchasesErrorCode.productNotAvailableForPurchaseError:
        return 'This product is not available for purchase.';
      case PurchasesErrorCode.networkError:
        return 'Network error. Please check your connection.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  void dispose() {
    _premiumController.close();
  }
}

class PurchaseResult {
  PurchaseResult({
    required this.success,
    this.customerInfo,
    this.error,
    this.cancelled = false,
  });

  final bool success;
  final CustomerInfo? customerInfo;
  final String? error;
  final bool cancelled;
}

class RestoreResult {
  RestoreResult({required this.success, required this.isPremium, this.error});

  final bool success;
  final bool isPremium;
  final String? error;
}
