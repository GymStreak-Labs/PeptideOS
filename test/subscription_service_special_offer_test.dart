import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/services/subscription_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  group('SubscriptionService special offer metadata', () {
    test('defaults to showing the special offer for legacy metadata', () {
      expect(
        SubscriptionService.shouldShowSpecialOfferFromMetadata(const {}),
        isTrue,
      );
    });

    test('hides or shows special offer from RevenueCat metadata flag', () {
      expect(
        SubscriptionService.shouldShowSpecialOfferFromMetadata(const {
          'show_special_offer_on_subscription_screen': false,
        }),
        isFalse,
      );
      expect(
        SubscriptionService.shouldShowSpecialOfferFromMetadata(const {
          'show_special_offer_on_subscription_screen': 'false',
        }),
        isFalse,
      );
      expect(
        SubscriptionService.shouldShowSpecialOfferFromMetadata(const {
          'show_special_offer_on_subscription_screen': true,
        }),
        isTrue,
      );
    });

    test('selects special offering id from RevenueCat metadata', () {
      expect(
        SubscriptionService.specialOfferingIdFromMetadata(const {}),
        'special_offer',
      );
      expect(
        SubscriptionService.specialOfferingIdFromMetadata(const {
          'special_offering': 'discount_test_a',
        }),
        'discount_test_a',
      );
      expect(
        SubscriptionService.specialOfferingIdFromMetadata(const {
          'special_offering': '  discount_test_b  ',
        }),
        'discount_test_b',
      );
    });
  });

  group('SubscriptionService package selection', () {
    final service = SubscriptionService.instance;

    test('uses special offering package when metadata shows the offer', () {
      final offerings = _offerings(
        currentMetadata: const {
          'show_special_offer_on_subscription_screen': true,
        },
      );

      expect(service.shouldShowSpecialOffer(offerings), isTrue);
      expect(
        service.packageForOnboardingPlan(offerings, 0)?.identifier,
        SubscriptionService.specialAnnualPackageId,
      );
      expect(
        service.defaultUpgradePackage(offerings)?.identifier,
        SubscriptionService.specialAnnualPackageId,
      );
    });

    test('falls back to annual when metadata hides the special offer', () {
      final offerings = _offerings(
        currentMetadata: const {
          'show_special_offer_on_subscription_screen': false,
        },
        includeCurrentSpecial: true,
      );

      expect(service.shouldShowSpecialOffer(offerings), isFalse);
      expect(service.specialOfferOffering(offerings), isNull);
      expect(
        service.packageForOnboardingPlan(offerings, 0)?.identifier,
        SubscriptionService.annualPackageId,
      );
      expect(
        service.defaultUpgradePackage(offerings)?.identifier,
        SubscriptionService.annualPackageId,
      );
    });

    test('honors alternate special offering metadata', () {
      final offerings = _offerings(
        currentMetadata: const {'special_offering': 'discount_test_a'},
        specialOfferingId: 'discount_test_a',
      );

      expect(
        service.specialOfferOffering(offerings)?.identifier,
        'discount_test_a',
      );
      expect(
        service
            .packageForOnboardingPlan(offerings, 0)
            ?.presentedOfferingContext
            .offeringIdentifier,
        'discount_test_a',
      );
    });
  });
}

Offerings _offerings({
  Map<String, Object> currentMetadata = const {},
  String specialOfferingId = SubscriptionService.defaultSpecialOfferOfferingId,
  bool includeCurrentSpecial = false,
}) {
  final annual = _package(
    SubscriptionService.annualPackageId,
    PackageType.annual,
    'com.gymstreaklabs.peptideos.annual',
    59.99,
    '\$59.99',
    'default',
  );
  final weekly = _package(
    SubscriptionService.weeklyPackageId,
    PackageType.weekly,
    'com.gymstreaklabs.peptideos.weekly',
    9.99,
    '\$9.99',
    'default',
  );
  final currentSpecial = _package(
    SubscriptionService.specialAnnualPackageId,
    PackageType.custom,
    'com.gymstreaklabs.peptideos.special_annual.current',
    29.99,
    '\$29.99',
    'default',
  );
  final special = _package(
    SubscriptionService.specialAnnualPackageId,
    PackageType.custom,
    'com.gymstreaklabs.peptideos.special_annual',
    29.99,
    '\$29.99',
    specialOfferingId,
  );

  final currentPackages = [
    if (includeCurrentSpecial) currentSpecial,
    annual,
    weekly,
  ];
  final current = Offering(
    'default',
    'Default',
    currentMetadata,
    currentPackages,
    annual: annual,
    weekly: weekly,
  );
  final specialOffering = Offering(
    specialOfferingId,
    'Special offer',
    const {'countdown_seconds': 900},
    [special],
  );

  return Offerings({
    'default': current,
    specialOfferingId: specialOffering,
  }, current: current);
}

Package _package(
  String identifier,
  PackageType packageType,
  String productIdentifier,
  double price,
  String priceString,
  String offeringIdentifier,
) {
  return Package(
    identifier,
    packageType,
    StoreProduct(
      productIdentifier,
      'PepMod Premium',
      'PepMod Premium',
      price,
      priceString,
      'USD',
    ),
    PresentedOfferingContext(offeringIdentifier, null, null),
  );
}
