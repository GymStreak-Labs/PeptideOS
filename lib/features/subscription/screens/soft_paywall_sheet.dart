import 'package:flutter/material.dart';

import '../../../core/services/analytics_service.dart';
import '../../../data/services/superwall_bridge_service.dart';

/// Registers the matching Superwall placement when a free-tier limit is hit.
/// Returns true only after Superwall reports the `premium` entitlement.
Future<bool> showSoftPaywall(
  BuildContext context, {
  required String source,
  required String reason,
}) async {
  AnalyticsService().logPaywallViewed(source);
  final bridge = SuperwallBridgeService.instance;
  final result = await bridge.presentPlacement(
    SuperwallPlacements.forSoftGateSource(source),
    params: {'source': source, 'reason': reason, 'surface': 'soft_gate'},
  );

  if (result == SuperwallPlacementResult.completedPremium) return true;
  if (result == SuperwallPlacementResult.completedNoPurchase) return false;
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Upgrade is not available right now. Please try again.'),
      ),
    );
  }
  return false;
}
