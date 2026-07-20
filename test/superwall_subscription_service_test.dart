import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/services/superwall_bridge_service.dart';
import 'package:peptide_os/features/subscription/providers/subscription_provider.dart';
import 'package:superwallkit_flutter/superwallkit_flutter.dart' as sw;

void main() {
  group('Superwall identity readiness', () {
    test('rejects anonymous status before Firebase identification', () {
      expect(
        SuperwallBridgeService.hasResolvedIdentityFor(
          identifiedUserId: null,
          identityTransitionInProgress: false,
        ),
        isFalse,
      );
    });

    test('rejects status while Firebase identity is switching', () {
      expect(
        SuperwallBridgeService.hasResolvedIdentityFor(
          identifiedUserId: 'firebase-user',
          identityTransitionInProgress: true,
        ),
        isFalse,
      );
    });

    test('accepts status only after Firebase identity resolves', () {
      expect(
        SuperwallBridgeService.hasResolvedIdentityFor(
          identifiedUserId: 'firebase-user',
          identityTransitionInProgress: false,
        ),
        isTrue,
      );
    });
  });

  group('Superwall premium entitlement classification', () {
    test('requires the premium entitlement', () {
      final status = sw.SubscriptionStatusActive(
        entitlements: {sw.Entitlement(id: 'other')},
      );

      expect(
        SuperwallBridgeService.classifySubscriptionStatus(
          status,
          requiredEntitlementId: 'premium',
        ),
        SuperwallAccessStatus.free,
      );
    });

    test('accepts premium among multiple active entitlements', () {
      final status = sw.SubscriptionStatusActive(
        entitlements: {
          sw.Entitlement(id: 'other'),
          sw.Entitlement(id: 'premium'),
        },
      );

      expect(
        SuperwallBridgeService.classifySubscriptionStatus(
          status,
          requiredEntitlementId: 'premium',
        ),
        SuperwallAccessStatus.premium,
      );
    });

    test('rejects an inactive premium entitlement', () {
      final status = sw.SubscriptionStatusActive(
        entitlements: {sw.Entitlement(id: 'premium', isActive: false)},
      );

      expect(
        SuperwallBridgeService.classifySubscriptionStatus(
          status,
          requiredEntitlementId: 'premium',
        ),
        SuperwallAccessStatus.free,
      );
    });

    test('keeps unknown distinct from inactive', () {
      expect(
        SuperwallBridgeService.classifySubscriptionStatus(
          sw.SubscriptionStatusUnknown(),
          requiredEntitlementId: 'premium',
        ),
        SuperwallAccessStatus.unknown,
      );
      expect(
        SuperwallBridgeService.classifySubscriptionStatus(
          sw.SubscriptionStatusInactive(),
          requiredEntitlementId: 'premium',
        ),
        SuperwallAccessStatus.free,
      );
    });
  });

  group('existing-user access protection', () {
    test('preserves cached premium while Superwall is unresolved', () {
      expect(
        SubscriptionProvider.resolvePremiumAccess(
          status: SuperwallAccessStatus.unknown,
          cachedPremium: true,
        ),
        isTrue,
      );
    });

    test('does not upgrade cached-free users while unresolved', () {
      expect(
        SubscriptionProvider.resolvePremiumAccess(
          status: SuperwallAccessStatus.unknown,
          cachedPremium: false,
        ),
        isFalse,
      );
    });

    test('authoritative Superwall state replaces the cache', () {
      expect(
        SubscriptionProvider.resolvePremiumAccess(
          status: SuperwallAccessStatus.premium,
          cachedPremium: false,
        ),
        isTrue,
      );
      expect(
        SubscriptionProvider.resolvePremiumAccess(
          status: SuperwallAccessStatus.free,
          cachedPremium: true,
        ),
        isFalse,
      );
    });
  });
}
