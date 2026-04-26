import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Wraps RevenueCat. Mirrors GymLevels' service API with PeptideOS-specific
/// API keys + entitlement.
///
/// Configure with [configure] once at app startup (in main.dart essential init).
class SubscriptionService {
  SubscriptionService._();

  static final SubscriptionService instance = SubscriptionService._();

  /// RevenueCat entitlement granted to premium users. Matches the identifier
  /// the RC dashboard issues for the PeptideOS project.
  static const String entitlementId = 'premium';

  // TODO_RC_IOS_KEY — replace with the real iOS RC public key once the
  // RevenueCat project is created. Never reuse GymLevels' keys.
  static const String _iosKey = 'TODO_RC_IOS_KEY';

  // TODO_RC_ANDROID_KEY — replace with the real Android RC key.
  static const String _androidKey = 'TODO_RC_ANDROID_KEY';

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
      final premium = info.entitlements.active.containsKey(entitlementId);
      return PurchaseResult(success: premium, customerInfo: info);
    } on PurchasesErrorCode catch (e) {
      return PurchaseResult(
        success: false,
        error: _handlePurchaseError(e),
        cancelled: e == PurchasesErrorCode.purchaseCancelledError,
      );
    } catch (_) {
      return PurchaseResult(
        success: false,
        error: 'An unexpected error occurred.',
      );
    }
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
      final premium = info.entitlements.active.containsKey(entitlementId);
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
    final premium = info.entitlements.active.containsKey(entitlementId);
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
