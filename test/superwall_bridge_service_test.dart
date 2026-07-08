import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/services/superwall_bridge_service.dart';

void main() {
  group('SuperwallBridgeService Google Play product normalization', () {
    test('keeps split Google Play product fields unchanged', () {
      final target = SuperwallBridgeService.normalizeGooglePlayProductTarget(
        'peptideos_premium',
        basePlanId: 'annual-special',
        offerId: null,
      );

      expect(target.productId, 'peptideos_premium');
      expect(target.basePlanId, 'annual-special');
      expect(target.offerId, isNull);
    });

    test('splits Superwall packed Google Play product identifiers', () {
      final target = SuperwallBridgeService.normalizeGooglePlayProductTarget(
        'peptideos_premium:annual-special:sw-none',
      );

      expect(target.productId, 'peptideos_premium');
      expect(target.basePlanId, 'annual-special');
      expect(target.offerId, isNull);
    });

    test('preserves real Google Play offer identifiers', () {
      final target = SuperwallBridgeService.normalizeGooglePlayProductTarget(
        'peptideos_premium:weekly:intro-7d',
      );

      expect(target.productId, 'peptideos_premium');
      expect(target.basePlanId, 'weekly');
      expect(target.offerId, 'intro-7d');
    });

    test('prefers explicit base plan over packed fallback', () {
      final target = SuperwallBridgeService.normalizeGooglePlayProductTarget(
        'peptideos_premium:weekly:sw-none',
        basePlanId: 'annual',
      );

      expect(target.productId, 'peptideos_premium');
      expect(target.basePlanId, 'annual');
      expect(target.offerId, isNull);
    });
  });
}
