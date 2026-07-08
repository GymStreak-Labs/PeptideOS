import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:superwallkit_flutter/superwallkit_flutter.dart' as sw;

import 'subscription_service.dart';

class SuperwallPlacements {
  const SuperwallPlacements._();

  static const postAuthOnboarding = 'post_auth_onboarding';
  static const softGateCreateProtocol = 'soft_gate_create_protocol';
  static const softGateAddPeptide = 'soft_gate_add_peptide';
  static const profileUpgrade = 'profile_upgrade';

  static String forSoftGateSource(String source) {
    return switch (source) {
      'protocol_limit' => softGateCreateProtocol,
      'peptide_limit' => softGateAddPeptide,
      _ => profileUpgrade,
    };
  }
}

enum SuperwallPlacementResult {
  unavailable,
  completedPremium,
  completedNoPurchase,
  failed,
}

class SuperwallBridgeService {
  SuperwallBridgeService._()
    : _purchaseController = _RevenueCatSuperwallPurchaseController(
        SubscriptionService.instance,
      );

  static final SuperwallBridgeService instance = SuperwallBridgeService._();

  static const bool enabled = bool.fromEnvironment(
    'SUPERWALL_ENABLED',
    defaultValue: true,
  );
  static const bool forceNativePaywall = bool.fromEnvironment(
    'SUPERWALL_FORCE_NATIVE_PAYWALL',
  );
  static const String _iosApiKey = String.fromEnvironment(
    'SUPERWALL_IOS_API_KEY',
  );
  static const String _androidApiKey = String.fromEnvironment(
    'SUPERWALL_ANDROID_API_KEY',
  );
  static const String entitlementId = String.fromEnvironment(
    'SUPERWALL_ENTITLEMENT_ID',
    defaultValue: SubscriptionService.entitlementId,
  );

  final _RevenueCatSuperwallPurchaseController _purchaseController;
  final SubscriptionService _subscriptionService = SubscriptionService.instance;

  StreamSubscription<bool>? _premiumSub;
  bool _configureAttempted = false;
  bool _configured = false;

  bool get isConfigured => _configured;
  bool get canPresentPaywalls => enabled && !forceNativePaywall && _configured;

  Future<void> configure() async {
    if (_configured || _configureAttempted) return;
    _configureAttempted = true;

    if (!enabled) {
      debugPrint('[SuperwallBridge] disabled by SUPERWALL_ENABLED=false.');
      return;
    }
    if (forceNativePaywall) {
      debugPrint('[SuperwallBridge] native paywall forced by dart-define.');
      return;
    }
    if (!_subscriptionService.isConfigured) {
      debugPrint('[SuperwallBridge] RevenueCat is not configured; skipping.');
      return;
    }

    final apiKey = (Platform.isIOS ? _iosApiKey : _androidApiKey).trim();
    if (apiKey.isEmpty || apiKey.startsWith('TODO_')) {
      debugPrint('[SuperwallBridge] API key missing; native paywall remains.');
      return;
    }

    try {
      final options = sw.SuperwallOptions()
        ..shouldObservePurchases = false
        ..passIdentifiersToPlayStore = false
        ..paywalls.shouldShowWebRestorationAlert = false
        ..logging.level = kDebugMode ? sw.LogLevel.debug : sw.LogLevel.warn;

      sw.Superwall.configure(
        apiKey,
        purchaseController: _purchaseController,
        options: options,
      );

      _configured = true;
      _premiumSub = _subscriptionService.premiumStatusStream.listen(
        (premium) => unawaited(syncPremiumStatus(premium)),
      );
      await syncPremiumStatus(await _subscriptionService.isPremium());
    } catch (e) {
      _configured = false;
      debugPrint('[SuperwallBridge] configure failed: $e');
    }
  }

  Future<void> identifyUser({
    required String userId,
    String? installId,
    String? appReferId,
    String? subscriptionTier,
  }) async {
    if (!_configured) return;
    try {
      await sw.Superwall.shared.identify(userId);
      final attributes = <String, Object>{'firebase_uid': userId};
      final resolvedInstallId = _nonEmpty(installId);
      final resolvedAppReferId = _nonEmpty(appReferId);
      final resolvedSubscriptionTier = _nonEmpty(subscriptionTier);
      if (resolvedInstallId != null) {
        attributes['install_id'] = resolvedInstallId;
      }
      if (resolvedAppReferId != null) {
        attributes['apprefer_id'] = resolvedAppReferId;
      }
      if (resolvedSubscriptionTier != null) {
        attributes['subscription_tier'] = resolvedSubscriptionTier;
      }
      await setUserAttributes(attributes);
    } catch (e) {
      debugPrint('[SuperwallBridge] identify failed: $e');
    }
  }

  Future<void> resetIdentity() async {
    if (!_configured) return;
    try {
      await sw.Superwall.shared.reset();
      await syncPremiumStatus(false);
    } catch (e) {
      debugPrint('[SuperwallBridge] reset failed: $e');
    }
  }

  Future<void> setUserAttributes(Map<String, Object> attributes) async {
    if (!_configured || attributes.isEmpty) return;
    try {
      await sw.Superwall.shared.setUserAttributes(attributes);
    } catch (e) {
      debugPrint('[SuperwallBridge] setUserAttributes failed: $e');
    }
  }

  Future<void> syncPremiumStatus(bool premium) async {
    if (!_configured) return;
    try {
      await sw.Superwall.shared.setSubscriptionStatus(
        premium
            ? sw.SubscriptionStatusActive(
                entitlements: {sw.Entitlement(id: entitlementId)},
              )
            : sw.SubscriptionStatusInactive(),
      );
      await sw.Superwall.shared.setUserAttributes({
        'subscription_tier': premium ? 'premium' : 'free',
      });
    } catch (e) {
      debugPrint('[SuperwallBridge] syncPremiumStatus failed: $e');
    }
  }

  Future<SuperwallPlacementResult> presentPlacement(
    String placement, {
    Map<String, Object>? params,
  }) async {
    if (!canPresentPaywalls) return SuperwallPlacementResult.unavailable;

    try {
      await sw.Superwall.shared.registerPlacement(placement, params: params);
      final premium = await _subscriptionService.isPremium();
      await syncPremiumStatus(premium);
      return premium
          ? SuperwallPlacementResult.completedPremium
          : SuperwallPlacementResult.completedNoPurchase;
    } catch (e) {
      debugPrint('[SuperwallBridge] placement "$placement" failed: $e');
      return SuperwallPlacementResult.failed;
    }
  }

  Future<bool> restorePurchases() async {
    if (!_configured) return false;
    try {
      await sw.Superwall.shared.restorePurchases();
      final premium = await _subscriptionService.isPremium();
      await syncPremiumStatus(premium);
      return premium;
    } catch (e) {
      debugPrint('[SuperwallBridge] restore failed: $e');
      return false;
    }
  }

  Future<void> dispose() async {
    await _premiumSub?.cancel();
    _premiumSub = null;
  }

  static String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}

class _RevenueCatSuperwallPurchaseController extends sw.PurchaseController {
  _RevenueCatSuperwallPurchaseController(this._subscriptionService);

  final SubscriptionService _subscriptionService;

  @override
  Future<sw.PurchaseResult> purchaseFromAppStore(String productId) async {
    try {
      final product = await _storeProduct(productId);
      if (product == null) {
        return sw.PurchaseResult.failed('Product unavailable: $productId');
      }

      final info = await rc.Purchases.purchaseStoreProduct(product);
      return _handleCustomerInfo(info);
    } on PlatformException catch (e) {
      return _mapPurchaseError(e);
    } catch (e) {
      return sw.PurchaseResult.failed(e.toString());
    }
  }

  @override
  Future<sw.PurchaseResult> purchaseFromGooglePlay(
    String productId,
    String? basePlanId,
    String? offerId,
  ) async {
    try {
      final product = await _storeProduct(productId);
      if (product == null) {
        return sw.PurchaseResult.failed('Product unavailable: $productId');
      }

      final option = selectGoogleSubscriptionOption(
        product,
        basePlanId: basePlanId,
        offerId: offerId,
      );
      final info = option == null
          ? await rc.Purchases.purchaseStoreProduct(product)
          : await rc.Purchases.purchaseSubscriptionOption(option);
      return _handleCustomerInfo(info);
    } on PlatformException catch (e) {
      return _mapPurchaseError(e);
    } catch (e) {
      return sw.PurchaseResult.failed(e.toString());
    }
  }

  @override
  Future<sw.RestorationResult> restorePurchases() async {
    try {
      final info = await rc.Purchases.restorePurchases();
      _subscriptionService.syncCustomerInfo(info);
      unawaited(
        SuperwallBridgeService.instance.syncPremiumStatus(
          SubscriptionService.customerInfoHasPremium(info),
        ),
      );
      return sw.RestorationResult.restored;
    } on PlatformException catch (e) {
      return sw.RestorationResult.failed(_errorMessage(e));
    } catch (e) {
      return sw.RestorationResult.failed(e.toString());
    }
  }

  @visibleForTesting
  static rc.SubscriptionOption? selectGoogleSubscriptionOption(
    rc.StoreProduct product, {
    String? basePlanId,
    String? offerId,
  }) {
    final options = product.subscriptionOptions;
    if (options == null || options.isEmpty) return product.defaultOption;

    final normalizedBasePlanId = _trimOrNull(basePlanId);
    final normalizedOfferId = _trimOrNull(offerId);
    if (normalizedBasePlanId == null) {
      return product.defaultOption ?? options.first;
    }

    final targetOptionId = normalizedOfferId == null
        ? normalizedBasePlanId
        : '$normalizedBasePlanId:$normalizedOfferId';
    for (final option in options) {
      if (option.id == targetOptionId) return option;
    }
    for (final option in options) {
      if (option.storeProductId == '${product.identifier}:$targetOptionId') {
        return option;
      }
    }
    for (final option in options) {
      if (option.id == normalizedBasePlanId) return option;
    }
    for (final option in options) {
      if (option.storeProductId ==
          '${product.identifier}:$normalizedBasePlanId') {
        return option;
      }
    }
    return product.defaultOption ?? options.first;
  }

  Future<rc.StoreProduct?> _storeProduct(String productId) async {
    final products = await rc.Purchases.getProducts([productId]);
    if (products.isEmpty) return null;
    return products.first;
  }

  sw.PurchaseResult _handleCustomerInfo(rc.CustomerInfo info) {
    _subscriptionService.syncCustomerInfo(info);
    final premium = SubscriptionService.customerInfoHasPremium(info);
    unawaited(SuperwallBridgeService.instance.syncPremiumStatus(premium));
    return premium
        ? sw.PurchaseResult.purchased
        : sw.PurchaseResult.failed('Premium entitlement was not granted.');
  }

  sw.PurchaseResult _mapPurchaseError(PlatformException error) {
    final code = rc.PurchasesErrorHelper.getErrorCode(error);
    return switch (code) {
      rc.PurchasesErrorCode.purchaseCancelledError =>
        sw.PurchaseResult.cancelled,
      rc.PurchasesErrorCode.paymentPendingError => sw.PurchaseResult.pending,
      _ => sw.PurchaseResult.failed(_errorMessage(error)),
    };
  }

  static String _errorMessage(PlatformException error) {
    return error.message?.trim().isNotEmpty == true
        ? error.message!.trim()
        : error.code;
  }

  static String? _trimOrNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
