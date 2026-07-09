import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:superwallkit_flutter/superwallkit_flutter.dart' as sw;

import 'subscription_service.dart';

/// Owns PepMod's Superwall SDK integration while keeping RevenueCat as the
/// source of truth for purchases and entitlement state.
class SuperwallService {
  SuperwallService._({SubscriptionService? subscriptionService})
    : _subscriptionService =
          subscriptionService ?? SubscriptionService.instance;

  static final SuperwallService instance = SuperwallService._();

  static const String paywallAfterPlanRevealPlacement =
      'paywall_after_plan_reveal';
  static const String onboardingCompletePlacement = 'onboarding_complete';
  static const List<String> postAuthPaywallPlacements = [
    paywallAfterPlanRevealPlacement,
    onboardingCompletePlacement,
  ];

  static const String _iosApiKey = String.fromEnvironment(
    'SUPERWALL_IOS_API_KEY',
  );
  static const String _androidApiKey = String.fromEnvironment(
    'SUPERWALL_ANDROID_API_KEY',
  );

  final SubscriptionService _subscriptionService;
  final _RevenueCatPurchaseController _purchaseController =
      _RevenueCatPurchaseController();

  StreamSubscription<rc.CustomerInfo>? _revenueCatSub;
  StreamSubscription<sw.CustomerInfo>? _superwallCustomerSub;
  Future<void>? _configurationReady;
  bool _configured = false;
  bool _syncingSubscriptionStatus = false;

  bool get isConfigured => _configured;

  bool get hasApiKey {
    final key = _platformApiKey;
    return key.trim().isNotEmpty && !key.startsWith('TODO_');
  }

  Future<void> configure() async {
    if (_configured) return;
    if (!hasApiKey) {
      debugPrint(
        '[SuperwallService] SDK key not configured; using local RC paywall fallback.',
      );
      return;
    }

    try {
      final options = sw.SuperwallOptions()
        ..paywalls.shouldPreload = true
        ..paywalls.shouldShowWebRestorationAlert = false;
      final configurationCompleter = Completer<void>();
      _configurationReady = configurationCompleter.future;

      sw.Superwall.configure(
        _platformApiKey,
        purchaseController: _purchaseController,
        options: options,
        completion: () {
          if (!configurationCompleter.isCompleted) {
            configurationCompleter.complete();
          }
        },
      );
      _configured = true;

      _revenueCatSub = _subscriptionService.customerInfoStream.listen((info) {
        unawaited(syncSubscriptionStatus(info));
      });
      _superwallCustomerSub = sw.Superwall.shared.customerInfoStream.listen((
        _,
      ) {
        unawaited(syncSubscriptionStatus());
      });

      unawaited(_finishConfiguration(configurationCompleter.future));
    } catch (e) {
      debugPrint('[SuperwallService] configure failed: $e');
      _configured = false;
    }
  }

  Future<void> _finishConfiguration(Future<void> nativeReady) async {
    await _waitForNativeConfiguration(nativeReady);
    if (!_configured) return;

    await syncSubscriptionStatus(_subscriptionService.lastKnownCustomerInfo);
    unawaited(
      sw.Superwall.shared.preloadPaywallsForPlacements(
        postAuthPaywallPlacements.toSet(),
      ),
    );
  }

  Future<void> identify(String userId) async {
    if (!_configured || userId.isEmpty) return;
    try {
      await sw.Superwall.shared.identify(userId);
      await sw.Superwall.shared.setUserAttributes({
        'app': 'pepmod',
        'entitlement': SubscriptionService.entitlementId,
      });
      await syncSubscriptionStatus();
    } catch (e) {
      debugPrint('[SuperwallService] identify failed: $e');
    }
  }

  Future<void> reset() async {
    if (!_configured) return;
    try {
      await sw.Superwall.shared.reset();
      await sw.Superwall.shared.setSubscriptionStatus(
        sw.SubscriptionStatus.inactive,
      );
    } catch (e) {
      debugPrint('[SuperwallService] reset failed: $e');
    }
  }

  Future<void> syncSubscriptionStatus([rc.CustomerInfo? customerInfo]) async {
    if (!_configured || _syncingSubscriptionStatus) return;
    _syncingSubscriptionStatus = true;

    try {
      final entitlements = <sw.Entitlement>{};

      if (SubscriptionService.forcePremium) {
        entitlements.add(sw.Entitlement(id: SubscriptionService.entitlementId));
      } else {
        final info =
            customerInfo ?? await _subscriptionService.getCustomerInfo();
        if (info?.entitlements.active.containsKey(
              SubscriptionService.entitlementId,
            ) ??
            false) {
          entitlements.add(
            sw.Entitlement(id: SubscriptionService.entitlementId),
          );
        }
      }

      try {
        final superwallEntitlements = await sw.Superwall.shared
            .getEntitlements();
        entitlements.addAll(superwallEntitlements.web);
      } catch (_) {}

      final merged = sw.Entitlement.mergePrioritized(entitlements);
      if (merged.isEmpty) {
        await sw.Superwall.shared.setSubscriptionStatus(
          sw.SubscriptionStatus.inactive,
        );
      } else {
        await sw.Superwall.shared.setSubscriptionStatus(
          sw.SubscriptionStatusActive(entitlements: merged),
        );
      }
    } catch (e) {
      debugPrint('[SuperwallService] subscription sync failed: $e');
    } finally {
      _syncingSubscriptionStatus = false;
    }
  }

  Future<bool> presentPostAuthPaywall({
    required void Function() onPresented,
    required void Function() onDismissed,
    required void Function(String reason) onUnavailable,
  }) async {
    if (!_configured) return false;
    await _waitForNativeConfiguration(_configurationReady);

    for (final placement in postAuthPaywallPlacements) {
      final canPresent = await _placementHasPaywall(placement);
      if (!canPresent) continue;

      final handler = sw.PaywallPresentationHandler()
        ..onPresent((_) => onPresented())
        ..onDismiss((_, __) => onDismissed())
        ..onError((error) => onUnavailable(error))
        ..onSkip((reason) => onUnavailable(reason.toString()));

      try {
        await sw.Superwall.shared.registerPlacement(
          placement,
          params: const {
            'source': 'post_auth_onboarding',
            'app': 'pepmod',
            'entitlement': SubscriptionService.entitlementId,
          },
          handler: handler,
        );
        return true;
      } catch (e) {
        debugPrint('[SuperwallService] placement $placement failed: $e');
      }
    }

    onUnavailable('No matching Superwall placement was available.');
    return false;
  }

  Future<bool> _placementHasPaywall(String placement) async {
    try {
      final result = await sw.Superwall.shared.getPresentationResult(
        placement,
        params: const {
          'source': 'post_auth_onboarding',
          'app': 'pepmod',
          'entitlement': SubscriptionService.entitlementId,
        },
      );
      return result is sw.PaywallPresentationResult;
    } catch (e) {
      debugPrint('[SuperwallService] placement check $placement failed: $e');
      return false;
    }
  }

  Future<void> _waitForNativeConfiguration(Future<void>? nativeReady) async {
    if (nativeReady == null) return;
    try {
      await nativeReady.timeout(const Duration(seconds: 6));
    } catch (_) {
      debugPrint('[SuperwallService] native configuration still pending.');
    }
  }

  String get _platformApiKey => Platform.isIOS ? _iosApiKey : _androidApiKey;

  void dispose() {
    unawaited(_revenueCatSub?.cancel() ?? Future<void>.value());
    unawaited(_superwallCustomerSub?.cancel() ?? Future<void>.value());
  }
}

class _RevenueCatPurchaseController extends sw.PurchaseController {
  @override
  Future<sw.PurchaseResult> purchaseFromAppStore(String productId) async {
    final product = await _storeProduct(productId);
    if (product == null) {
      return sw.PurchaseResult.failed('Product $productId was not available.');
    }
    return _purchaseWithRevenueCat(
      () => rc.Purchases.purchaseStoreProduct(product),
    );
  }

  @override
  Future<sw.PurchaseResult> purchaseFromGooglePlay(
    String productId,
    String? basePlanId,
    String? offerId,
  ) async {
    final storeProductId = basePlanId == null
        ? productId
        : '$productId:$basePlanId';
    final product = await _storeProduct(storeProductId, fallbackId: productId);
    if (product == null) {
      return sw.PurchaseResult.failed(
        'Product $storeProductId was not available.',
      );
    }

    final option = _subscriptionOption(product, basePlanId, offerId);
    if (option != null) {
      return _purchaseWithRevenueCat(
        () => rc.Purchases.purchaseSubscriptionOption(option),
      );
    }
    return _purchaseWithRevenueCat(
      () => rc.Purchases.purchaseStoreProduct(product),
    );
  }

  @override
  Future<sw.RestorationResult> restorePurchases() async {
    try {
      final info = await rc.Purchases.restorePurchases();
      await _syncCustomerInfo(info);
      if (_hasPremiumEntitlement(info)) {
        return sw.RestorationResult.restored;
      }
      return sw.RestorationResult.failed('No active subscription found.');
    } on PlatformException catch (e) {
      return sw.RestorationResult.failed(_messageForPlatformException(e));
    } catch (e) {
      return sw.RestorationResult.failed(e.toString());
    }
  }

  Future<rc.StoreProduct?> _storeProduct(
    String productId, {
    String? fallbackId,
  }) async {
    final ids = <String>{productId, ?fallbackId};
    final products = await rc.Purchases.getProducts(ids.toList());
    for (final id in ids) {
      for (final product in products) {
        if (product.identifier == id) return product;
      }
    }
    return products.isEmpty ? null : products.first;
  }

  rc.SubscriptionOption? _subscriptionOption(
    rc.StoreProduct product,
    String? basePlanId,
    String? offerId,
  ) {
    final options = product.subscriptionOptions;
    if (options == null || options.isEmpty) return product.defaultOption;

    if (basePlanId != null && offerId != null) {
      final optionId = '$basePlanId:$offerId';
      for (final option in options) {
        if (option.id == optionId) return option;
      }
    }

    if (basePlanId != null) {
      for (final option in options) {
        if (option.id == basePlanId) return option;
      }
    }

    return product.defaultOption ?? options.first;
  }

  Future<sw.PurchaseResult> _purchaseWithRevenueCat(
    Future<rc.CustomerInfo> Function() purchase,
  ) async {
    try {
      final info = await purchase();
      await _syncCustomerInfo(info);
      if (_hasPremiumEntitlement(info)) {
        return sw.PurchaseResult.purchased;
      }
      return sw.PurchaseResult.failed(
        'Purchase completed, but premium entitlement was not active.',
      );
    } on PlatformException catch (e) {
      return _purchaseResultForPlatformException(e);
    } catch (e) {
      return sw.PurchaseResult.failed(e.toString());
    }
  }

  Future<sw.PurchaseResult> _purchaseResultForPlatformException(
    PlatformException exception,
  ) async {
    final code = rc.PurchasesErrorHelper.getErrorCode(exception);
    switch (code) {
      case rc.PurchasesErrorCode.purchaseCancelledError:
        return sw.PurchaseResult.cancelled;
      case rc.PurchasesErrorCode.paymentPendingError:
        return sw.PurchaseResult.pending;
      case rc.PurchasesErrorCode.productAlreadyPurchasedError:
        final info = await SubscriptionService.instance.getCustomerInfo();
        if (info != null && _hasPremiumEntitlement(info)) {
          await _syncCustomerInfo(info);
          return sw.PurchaseResult.purchased;
        }
        return sw.PurchaseResult.failed(
          _messageForPlatformException(exception),
        );
      default:
        return sw.PurchaseResult.failed(
          _messageForPlatformException(exception),
        );
    }
  }

  Future<void> _syncCustomerInfo(rc.CustomerInfo info) async {
    SubscriptionService.instance.syncCustomerInfo(info);
    await SuperwallService.instance.syncSubscriptionStatus(info);
  }

  bool _hasPremiumEntitlement(rc.CustomerInfo info) =>
      info.entitlements.active.containsKey(SubscriptionService.entitlementId);

  String _messageForPlatformException(PlatformException exception) {
    try {
      final code = rc.PurchasesErrorHelper.getErrorCode(exception);
      switch (code) {
        case rc.PurchasesErrorCode.purchaseNotAllowedError:
          return 'Purchases are not allowed on this device.';
        case rc.PurchasesErrorCode.productNotAvailableForPurchaseError:
          return 'This product is not available for purchase.';
        case rc.PurchasesErrorCode.networkError:
        case rc.PurchasesErrorCode.offlineConnectionError:
          return 'Network error. Please check your connection.';
        default:
          return exception.message ?? 'Purchase failed. Please try again.';
      }
    } catch (_) {
      return exception.message ?? 'Purchase failed. Please try again.';
    }
  }
}
