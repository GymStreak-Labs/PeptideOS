import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/services/analytics_service.dart';
import '../../../data/services/superwall_bridge_service.dart';
import '../../profile/providers/settings_provider.dart';

/// Reactive Superwall entitlement state used by PepMod's feature gates.
///
/// A cached premium setting is honored only while Superwall is unresolved.
/// Once Superwall provides an authoritative `premium` or `free` result, that
/// result is persisted and becomes the sole runtime access source.
class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    SuperwallBridgeService? service,
    SettingsProvider? settingsProvider,
    AnalyticsService? analytics,
  }) : _service = service ?? SuperwallBridgeService.instance,
       _settingsProvider = settingsProvider,
       _analytics = analytics ?? AnalyticsService() {
    _status = _service.lastKnownAccessStatus;
    _sub = _service.accessStatusStream.listen(_handleUpdate);
    unawaited(refresh());
  }

  final SuperwallBridgeService _service;
  final AnalyticsService _analytics;
  SettingsProvider? _settingsProvider;
  StreamSubscription<SuperwallAccessStatus>? _sub;

  SuperwallAccessStatus _status = SuperwallAccessStatus.unknown;

  SuperwallAccessStatus get status => _status;
  bool get isAuthoritative => _status != SuperwallAccessStatus.unknown;
  bool get isPremium => resolvePremiumAccess(
    status: _status,
    cachedPremium: _hasCachedPremium,
    forcePremium: SuperwallBridgeService.forcePremium,
  );
  bool get isFree => isAuthoritative && !isPremium;

  static const int freePeptideLimit = 1;
  static const int freeProtocolLimit = 1;

  bool canAddProtocol(int currentCount) =>
      isPremium || currentCount < freeProtocolLimit;

  bool canAddPeptide(int currentCount) =>
      isPremium || currentCount < freePeptideLimit;

  void setSettingsProvider(SettingsProvider settingsProvider) {
    if (identical(_settingsProvider, settingsProvider)) return;
    _settingsProvider = settingsProvider;
    notifyListeners();
  }

  void _handleUpdate(SuperwallAccessStatus status) {
    _status = status;
    if (status == SuperwallAccessStatus.premium) {
      unawaited(_settingsProvider?.setSubscriptionState('premium'));
    } else if (status == SuperwallAccessStatus.free) {
      unawaited(_settingsProvider?.setSubscriptionState('free'));
    }
    // Unknown is intentionally never persisted as free.
    notifyListeners();
  }

  Future<void> refresh() async {
    try {
      _handleUpdate(await _service.refreshAccessStatus());
    } catch (e) {
      debugPrint('SubscriptionProvider refresh failed: $e');
    }
  }

  Future<SuperwallRestoreResult> restore() async {
    final result = await _service.restorePurchases();
    if (result.success) {
      unawaited(_analytics.logPurchaseRestored());
      await refresh();
    }
    return result;
  }

  bool get _hasCachedPremium {
    final raw = _settingsProvider?.settings.subscriptionState
        .trim()
        .toLowerCase();
    return raw == 'premium' || raw == 'pro' || raw == 'active';
  }

  @visibleForTesting
  static bool resolvePremiumAccess({
    required SuperwallAccessStatus status,
    required bool cachedPremium,
    bool forcePremium = false,
  }) {
    if (forcePremium || status == SuperwallAccessStatus.premium) return true;
    return status == SuperwallAccessStatus.unknown && cachedPremium;
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
