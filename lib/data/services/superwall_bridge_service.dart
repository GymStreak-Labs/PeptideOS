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
  static const bool handlesPurchases = bool.fromEnvironment(
    'SUPERWALL_HANDLES_PURCHASES',
    defaultValue: true,
  );
  static const bool allowNativeFallback = bool.fromEnvironment(
    'SUPERWALL_ALLOW_NATIVE_FALLBACK',
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

  static bool get releaseRequiresPlatformApiKey =>
      enabled && !forceNativePaywall;

  static bool get canUseNativeFallback =>
      allowNativeFallback || !handlesPurchases;

  static bool get hasPlatformApiKey {
    final apiKey = _platformApiKey;
    return apiKey.isNotEmpty && !apiKey.startsWith('TODO_');
  }

  final _RevenueCatSuperwallPurchaseController _purchaseController;
  final SubscriptionService _subscriptionService = SubscriptionService.instance;

  StreamSubscription<bool>? _premiumSub;
  StreamSubscription<sw.SubscriptionStatus>? _superwallStatusSub;
  Future<void>? _configurationReady;
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
    if (!handlesPurchases && !_subscriptionService.isConfigured) {
      debugPrint('[SuperwallBridge] RevenueCat is not configured; skipping.');
      return;
    }

    final apiKey = _platformApiKey;
    if (!hasPlatformApiKey) {
      debugPrint('[SuperwallBridge] API key missing; native paywall remains.');
      return;
    }

    try {
      final configurationCompleter = Completer<void>();
      _configurationReady = configurationCompleter.future;
      final options = sw.SuperwallOptions()
        ..shouldObservePurchases = false
        ..passIdentifiersToPlayStore = false
        ..paywalls.shouldShowWebRestorationAlert = false
        ..logging.level = kDebugMode ? sw.LogLevel.debug : sw.LogLevel.warn;

      sw.Superwall.configure(
        apiKey,
        purchaseController: handlesPurchases ? null : _purchaseController,
        options: options,
        completion: () {
          if (!configurationCompleter.isCompleted) {
            configurationCompleter.complete();
          }
        },
      );

      _configured = true;
      if (handlesPurchases) {
        _superwallStatusSub = sw.Superwall.shared.subscriptionStatus.listen(
          _handleSuperwallSubscriptionStatus,
        );
      } else {
        _premiumSub = _subscriptionService.premiumStatusStream.listen(
          (premium) => unawaited(syncPremiumStatus(premium)),
        );
      }
      unawaited(_syncAfterNativeConfiguration(configurationCompleter.future));
    } catch (e) {
      _configured = false;
      debugPrint('[SuperwallBridge] configure failed: $e');
    }
  }

  Future<void> _syncAfterNativeConfiguration(Future<void> nativeReady) async {
    await _waitForNativeConfiguration(nativeReady);
    if (!_configured) return;
    if (handlesPurchases) {
      await _refreshSuperwallPremiumStatus();
    } else {
      await syncPremiumStatus(await _subscriptionService.isPremium());
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
      _subscriptionService.syncExternalPremiumStatus(false);
      if (!handlesPurchases) await syncPremiumStatus(false);
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
      if (!handlesPurchases) {
        await sw.Superwall.shared.setSubscriptionStatus(
          premium
              ? sw.SubscriptionStatusActive(
                  entitlements: {sw.Entitlement(id: entitlementId)},
                )
              : sw.SubscriptionStatusInactive(),
        );
      }
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
    await _waitForNativeConfiguration(_configurationReady);

    try {
      if (await _hasPremiumAccess()) {
        return SuperwallPlacementResult.completedPremium;
      }
      await sw.Superwall.shared.registerPlacement(placement, params: params);
      final premium = await _hasPremiumAccess();
      if (!handlesPurchases) await syncPremiumStatus(premium);
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
      var premium = await _hasPremiumAccess();
      if (!premium &&
          SubscriptionService.legacyRevenueCatAccessFallback &&
          _subscriptionService.isConfigured) {
        final rcResult = await _subscriptionService.restorePurchases();
        premium = rcResult.success && rcResult.isPremium;
      }
      if (!handlesPurchases) await syncPremiumStatus(premium);
      await setUserAttributes({
        'subscription_tier': premium ? 'premium' : 'free',
      });
      return premium;
    } catch (e) {
      debugPrint('[SuperwallBridge] restore failed: $e');
      return false;
    }
  }

  Future<void> dispose() async {
    await _premiumSub?.cancel();
    _premiumSub = null;
    await _superwallStatusSub?.cancel();
    _superwallStatusSub = null;
  }

  Future<bool> _hasPremiumAccess() async {
    if (SubscriptionService.forcePremium) return true;
    if (handlesPurchases) {
      final superwallPremium = await _refreshSuperwallPremiumStatus();
      if (superwallPremium) return true;
    }
    if (!handlesPurchases ||
        SubscriptionService.legacyRevenueCatAccessFallback) {
      return _subscriptionService.isRevenueCatPremium();
    }
    return _subscriptionService.isPremium();
  }

  Future<bool> _refreshSuperwallPremiumStatus() async {
    if (!_configured) return false;
    try {
      final status = await sw.Superwall.shared.getSubscriptionStatus();
      return _syncSuperwallStatus(status);
    } catch (e) {
      debugPrint('[SuperwallBridge] subscription status refresh failed: $e');
      return false;
    }
  }

  void _handleSuperwallSubscriptionStatus(sw.SubscriptionStatus status) {
    final premium = _syncSuperwallStatus(status);
    unawaited(
      setUserAttributes({'subscription_tier': premium ? 'premium' : 'free'}),
    );
  }

  bool _syncSuperwallStatus(sw.SubscriptionStatus status) {
    final premium = status.isActive;
    _subscriptionService.syncExternalPremiumStatus(premium);
    return premium;
  }

  @visibleForTesting
  static ({String productId, String? basePlanId, String? offerId})
  normalizeGooglePlayProductTarget(
    String productId, {
    String? basePlanId,
    String? offerId,
  }) {
    final rawProductId = _trimOrNull(productId) ?? productId;
    var targetProductId = rawProductId;
    var targetBasePlanId = _trimOrNull(basePlanId);
    var targetOfferId = normalizeGooglePlayOfferId(offerId);

    final segments = rawProductId.split(':');
    if (segments.length >= 2) {
      targetProductId = segments.first.trim();
      targetBasePlanId ??= _trimOrNull(segments[1]);
      if (segments.length >= 3) {
        targetOfferId ??= normalizeGooglePlayOfferId(
          segments.sublist(2).join(':'),
        );
      }
    }

    return (
      productId: targetProductId,
      basePlanId: targetBasePlanId,
      offerId: targetOfferId,
    );
  }

  @visibleForTesting
  static String? normalizeGooglePlayOfferId(String? offerId) {
    final trimmed = _trimOrNull(offerId);
    if (trimmed == null) return null;
    final lower = trimmed.toLowerCase();
    if (lower == 'sw-none' || lower == 'none' || lower == 'null') {
      return null;
    }
    return trimmed;
  }

  static String? _nonEmpty(String? value) {
    return _trimOrNull(value);
  }

  static String get _platformApiKey =>
      (Platform.isIOS ? _iosApiKey : _androidApiKey).trim();

  Future<void> _waitForNativeConfiguration(Future<void>? nativeReady) async {
    if (nativeReady == null) return;
    try {
      await nativeReady.timeout(const Duration(seconds: 6));
    } catch (_) {
      debugPrint('[SuperwallBridge] native configuration still pending.');
    }
  }

  static String? _trimOrNull(String? value) {
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
      final target = SuperwallBridgeService.normalizeGooglePlayProductTarget(
        productId,
        basePlanId: basePlanId,
        offerId: offerId,
      );
      final product = await _storeProduct(
        target.productId,
        basePlanId: target.basePlanId,
      );
      if (product == null) {
        return sw.PurchaseResult.failed(
          'Product unavailable: ${target.productId}',
        );
      }

      final option = selectGoogleSubscriptionOption(
        product,
        basePlanId: target.basePlanId,
        offerId: target.offerId,
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
    final normalizedOfferId = SuperwallBridgeService.normalizeGooglePlayOfferId(
      offerId,
    );
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

  Future<rc.StoreProduct?> _storeProduct(
    String productId, {
    String? basePlanId,
  }) async {
    final normalizedBasePlanId = _trimOrNull(basePlanId);
    final identifiers = {
      productId,
      if (normalizedBasePlanId != null) '$productId:$normalizedBasePlanId',
    }.toList(growable: false);
    final products = await _allStoreProducts(identifiers);
    if (products.isEmpty) return null;
    if (normalizedBasePlanId != null) {
      final requestedStoreProductId = '$productId:$normalizedBasePlanId';
      for (final product in products) {
        if (product.identifier == requestedStoreProductId) return product;
      }
      for (final product in products) {
        if (product.identifier == productId) return product;
      }
    }
    return products.first;
  }

  Future<List<rc.StoreProduct>> _allStoreProducts(
    List<String> productIdentifiers,
  ) async {
    final subscriptionProducts = await rc.Purchases.getProducts(
      productIdentifiers,
      productCategory: rc.ProductCategory.subscription,
    );
    final nonSubscriptionProducts = await rc.Purchases.getProducts(
      productIdentifiers,
      productCategory: rc.ProductCategory.nonSubscription,
    );
    return [...subscriptionProducts, ...nonSubscriptionProducts];
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
