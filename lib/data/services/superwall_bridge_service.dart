import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:superwallkit_flutter/superwallkit_flutter.dart' as sw;

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

/// Authoritative access state reported by Superwall.
///
/// [unknown] is deliberately distinct from [free]: startup, identity changes,
/// offline reads, and SDK errors must never revoke cached premium access.
enum SuperwallAccessStatus { unknown, free, premium }

class SuperwallRestoreResult {
  const SuperwallRestoreResult({
    required this.success,
    required this.isPremium,
    this.error,
  });

  final bool success;
  final bool isPremium;
  final String? error;
}

/// PepMod's Superwall-only subscription service.
///
/// Superwall owns purchases, restore, receipt validation, and entitlement
/// status. No custom purchase controller or secondary subscription SDK is
/// installed.
class SuperwallBridgeService {
  SuperwallBridgeService._();

  static final SuperwallBridgeService instance = SuperwallBridgeService._();

  static const bool enabled = bool.fromEnvironment(
    'SUPERWALL_ENABLED',
    defaultValue: true,
  );
  static const bool forcePremium = bool.fromEnvironment('FORCE_PREMIUM');
  static const String _iosApiKey = String.fromEnvironment(
    'SUPERWALL_IOS_API_KEY',
  );
  static const String _androidApiKey = String.fromEnvironment(
    'SUPERWALL_ANDROID_API_KEY',
  );
  static const String entitlementId = 'premium';
  static const Duration _sdkTimeout = Duration(seconds: 8);

  static bool get hasPlatformApiKey {
    final apiKey = _platformApiKey;
    return apiKey.isNotEmpty && !apiKey.startsWith('TODO_');
  }

  final StreamController<SuperwallAccessStatus> _accessController =
      StreamController<SuperwallAccessStatus>.broadcast();

  StreamSubscription<sw.SubscriptionStatus>? _statusSub;
  Future<void>? _configurationReady;
  bool _configureAttempted = false;
  bool _configured = false;
  bool _identityTransitionInProgress = false;
  String? _identifiedUserId;
  SuperwallAccessStatus _accessStatus = SuperwallAccessStatus.unknown;

  bool get isConfigured => _configured;
  bool get canPresentPaywalls => enabled && _configured;
  Stream<SuperwallAccessStatus> get accessStatusStream =>
      _accessController.stream;
  SuperwallAccessStatus get lastKnownAccessStatus =>
      forcePremium ? SuperwallAccessStatus.premium : _accessStatus;

  Future<void> configure() async {
    if (_configured || _configureAttempted) return;
    _configureAttempted = true;

    if (!enabled) {
      debugPrint('[Superwall] disabled by SUPERWALL_ENABLED=false.');
      return;
    }
    if (!hasPlatformApiKey) {
      debugPrint('[Superwall] platform API key is missing.');
      return;
    }

    try {
      final completer = Completer<void>();
      _configurationReady = completer.future;
      final options = sw.SuperwallOptions()
        ..shouldObservePurchases = false
        ..passIdentifiersToPlayStore = false
        ..paywalls.shouldShowWebRestorationAlert = false
        ..logging.level = kDebugMode ? sw.LogLevel.debug : sw.LogLevel.warn;

      sw.Superwall.configure(
        _platformApiKey,
        options: options,
        completion: () {
          if (!completer.isCompleted) completer.complete();
        },
      );

      _configured = true;
      _statusSub = sw.Superwall.shared.subscriptionStatus.listen(
        _handleSubscriptionStatus,
      );
      unawaited(_refreshAfterConfiguration(completer.future));
    } catch (e) {
      _configured = false;
      debugPrint('[Superwall] configure failed: $e');
    }
  }

  Future<void> _refreshAfterConfiguration(Future<void> nativeReady) async {
    await _waitForNativeConfiguration(nativeReady);
    if (_configured) await refreshAccessStatus();
  }

  Future<SuperwallAccessStatus> identifyUser({
    required String userId,
    String? installId,
    String? appReferId,
    String? subscriptionTier,
  }) async {
    if (!_configured) return lastKnownAccessStatus;
    _beginIdentityTransition(userId);
    await _waitForNativeConfiguration(_configurationReady);
    try {
      await sw.Superwall.shared.identify(userId).timeout(_sdkTimeout);
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
      _identityTransitionInProgress = false;
      return await refreshAccessStatus();
    } catch (e) {
      debugPrint('[Superwall] identify failed: $e');
      return lastKnownAccessStatus;
    }
  }

  Future<void> resetIdentity() async {
    if (!_configured) return;
    try {
      await sw.Superwall.shared.reset().timeout(_sdkTimeout);
    } catch (e) {
      debugPrint('[Superwall] reset failed: $e');
    } finally {
      _identityTransitionInProgress = false;
      _identifiedUserId = null;
      _setAccessStatus(SuperwallAccessStatus.unknown);
    }
  }

  Future<void> setUserAttributes(Map<String, Object> attributes) async {
    if (!_configured || attributes.isEmpty) return;
    try {
      await sw.Superwall.shared
          .setUserAttributes(attributes)
          .timeout(_sdkTimeout);
    } catch (e) {
      debugPrint('[Superwall] setUserAttributes failed: $e');
    }
  }

  Future<SuperwallPlacementResult> presentPlacement(
    String placement, {
    Map<String, Object>? params,
  }) async {
    if (!canPresentPaywalls) return SuperwallPlacementResult.unavailable;
    await _waitForNativeConfiguration(_configurationReady);

    try {
      final before = await refreshAccessStatus();
      if (before == SuperwallAccessStatus.premium) {
        return SuperwallPlacementResult.completedPremium;
      }
      if (before == SuperwallAccessStatus.unknown) {
        return SuperwallPlacementResult.unavailable;
      }

      await sw.Superwall.shared.registerPlacement(placement, params: params);
      final after = await refreshAccessStatus();
      return after == SuperwallAccessStatus.premium
          ? SuperwallPlacementResult.completedPremium
          : SuperwallPlacementResult.completedNoPurchase;
    } catch (e) {
      debugPrint('[Superwall] placement "$placement" failed: $e');
      return SuperwallPlacementResult.failed;
    }
  }

  Future<SuperwallRestoreResult> restorePurchases() async {
    if (!_configured) {
      return const SuperwallRestoreResult(
        success: false,
        isPremium: false,
        error: 'Subscription service is not configured yet.',
      );
    }

    try {
      final result = await sw.Superwall.shared.restorePurchases().timeout(
        _sdkTimeout,
      );
      if (result is sw.RestorationResultFailed) {
        return SuperwallRestoreResult(
          success: false,
          isPremium: false,
          error: result.error,
        );
      }
      final status = await refreshAccessStatus();
      return SuperwallRestoreResult(
        success: true,
        isPremium: status == SuperwallAccessStatus.premium,
      );
    } catch (e) {
      debugPrint('[Superwall] restore failed: $e');
      return const SuperwallRestoreResult(
        success: false,
        isPremium: false,
        error: 'Failed to restore purchases.',
      );
    }
  }

  Future<SuperwallAccessStatus> refreshAccessStatus() async {
    if (forcePremium) {
      _setAccessStatus(SuperwallAccessStatus.premium);
      return SuperwallAccessStatus.premium;
    }
    if (!_configured) return lastKnownAccessStatus;
    try {
      final status = await sw.Superwall.shared.getSubscriptionStatus().timeout(
        _sdkTimeout,
      );
      return _applySubscriptionStatus(status);
    } catch (e) {
      debugPrint('[Superwall] subscription status refresh failed: $e');
      return lastKnownAccessStatus;
    }
  }

  Future<void> dispose() async {
    await _statusSub?.cancel();
    _statusSub = null;
  }

  void _beginIdentityTransition(String userId) {
    if (_identifiedUserId == userId) return;
    _identifiedUserId = userId;
    _identityTransitionInProgress = true;
    _setAccessStatus(SuperwallAccessStatus.unknown);
  }

  void _handleSubscriptionStatus(sw.SubscriptionStatus status) {
    // Native SDKs can briefly emit the anonymous user's inactive status while
    // identify() is switching to the Firebase UID. Ignoring that event avoids
    // overwriting a legacy subscriber's cached Pro access during an update.
    if (_identityTransitionInProgress) return;
    final access = _applySubscriptionStatus(status);
    if (access == SuperwallAccessStatus.unknown) return;
    unawaited(
      setUserAttributes({
        'subscription_tier': access == SuperwallAccessStatus.premium
            ? 'premium'
            : 'free',
      }),
    );
  }

  SuperwallAccessStatus _applySubscriptionStatus(sw.SubscriptionStatus status) {
    final classified = classifySubscriptionStatus(
      status,
      requiredEntitlementId: entitlementId,
    );
    // Unknown is non-authoritative. Preserve the current state unless an
    // identity transition explicitly reset it to unknown.
    if (classified != SuperwallAccessStatus.unknown) {
      _setAccessStatus(classified);
    }
    return lastKnownAccessStatus;
  }

  void _setAccessStatus(SuperwallAccessStatus status) {
    if (_accessStatus == status) return;
    _accessStatus = status;
    _accessController.add(lastKnownAccessStatus);
  }

  @visibleForTesting
  static SuperwallAccessStatus classifySubscriptionStatus(
    sw.SubscriptionStatus status, {
    required String requiredEntitlementId,
  }) {
    return switch (status) {
      sw.SubscriptionStatusUnknown() => SuperwallAccessStatus.unknown,
      sw.SubscriptionStatusInactive() => SuperwallAccessStatus.free,
      sw.SubscriptionStatusActive(:final entitlements) =>
        entitlements.any(
              (entitlement) =>
                  entitlement.id == requiredEntitlementId &&
                  entitlement.isActive,
            )
            ? SuperwallAccessStatus.premium
            : SuperwallAccessStatus.free,
    };
  }

  static String get _platformApiKey =>
      (Platform.isIOS ? _iosApiKey : _androidApiKey).trim();

  Future<void> _waitForNativeConfiguration(Future<void>? nativeReady) async {
    if (nativeReady == null) return;
    try {
      await nativeReady.timeout(const Duration(seconds: 6));
    } catch (_) {
      debugPrint('[Superwall] native configuration still pending.');
    }
  }

  static String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
