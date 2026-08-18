import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/features/onboarding/widgets/paywall_page.dart';
import 'package:peptide_os/features/subscription/paywall_offer_state.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  group('freeTrialDaysFromIntroductoryPrice', () {
    IntroductoryPrice intro({
      double price = 0,
      PeriodUnit unit = PeriodUnit.day,
      int units = 3,
    }) => IntroductoryPrice(price, '\$0.00', 'P3D', 1, unit, units);

    test('no introductory offer means no trial', () {
      expect(freeTrialDaysFromIntroductoryPrice(null), isNull);
    });

    test('a paid introductory price is a discount, not a free trial', () {
      expect(freeTrialDaysFromIntroductoryPrice(intro(price: 0.99)), isNull);
    });

    test('derives days from the store period unit', () {
      expect(freeTrialDaysFromIntroductoryPrice(intro(units: 3)), 3);
      expect(
        freeTrialDaysFromIntroductoryPrice(
          intro(unit: PeriodUnit.week, units: 1),
        ),
        7,
      );
      expect(
        freeTrialDaysFromIntroductoryPrice(
          intro(unit: PeriodUnit.month, units: 1),
        ),
        30,
      );
      expect(
        freeTrialDaysFromIntroductoryPrice(
          intro(unit: PeriodUnit.year, units: 1),
        ),
        365,
      );
    });

    test('rejects malformed offers instead of guessing', () {
      expect(freeTrialDaysFromIntroductoryPrice(intro(units: 0)), isNull);
      expect(
        freeTrialDaysFromIntroductoryPrice(intro(unit: PeriodUnit.unknown)),
        isNull,
      );
    });
  });

  group('freeTrialDaysFromFreePhase (Google Play Billing 5+)', () {
    PricingPhase phase({
      int amountMicros = 0,
      PeriodUnit unit = PeriodUnit.week,
      int value = 1,
      int? cycles = 1,
    }) => PricingPhase(
      Period(unit, value, 'P1W'),
      RecurrenceMode.finiteRecurring,
      cycles,
      Price('\$0.00', amountMicros, 'USD'),
      OfferPaymentMode.freeTrial,
    );

    test('derives days from a zero-price free phase', () {
      expect(freeTrialDaysFromFreePhase(phase()), 7);
      expect(
        freeTrialDaysFromFreePhase(phase(unit: PeriodUnit.day, value: 3)),
        3,
      );
    });

    test('a paid phase or missing phase is not a free trial', () {
      expect(freeTrialDaysFromFreePhase(null), isNull);
      expect(freeTrialDaysFromFreePhase(phase(amountMicros: 990000)), isNull);
    });

    test('rejects malformed phases instead of guessing', () {
      expect(freeTrialDaysFromFreePhase(phase(value: 0)), isNull);
      expect(
        freeTrialDaysFromFreePhase(phase(unit: PeriodUnit.unknown)),
        isNull,
      );
    });
  });

  group('paywall trial copy', () {
    Future<void> pumpPaywall(
      WidgetTester tester, {
      int? annualFreeTrialDays,
    }) async {
      tester.view.physicalSize = const Size(390, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            backgroundColor: AppColors.background,
            body: PaywallPage(
              onSubscribe: (_) async {},
              onRestore: () {},
              // Special offer hidden so the annual plan is pre-selected and
              // its CTA is the one rendered.
              showSpecialOffer: false,
              planPrices: {
                1: PaywallPlanPrice(
                  localizedPrice: 'CA\$79.99',
                  amount: 79.99,
                  currencyCode: 'CAD',
                  freeTrialDays: annualFreeTrialDays,
                ),
                2: const PaywallPlanPrice(
                  localizedPrice: 'CA\$12.99',
                  amount: 12.99,
                  currencyCode: 'CAD',
                ),
              },
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 1200));
      await tester.pump(const Duration(milliseconds: 700));
    }

    testWidgets('renders badge and CTA from the store-derived trial', (
      tester,
    ) async {
      await pumpPaywall(tester, annualFreeTrialDays: 7);
      expect(find.text('7-DAY FREE TRIAL'), findsOneWidget);
      expect(find.text('START FREE TRIAL'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('never promises a trial when the store offer has none', (
      tester,
    ) async {
      await pumpPaywall(tester, annualFreeTrialDays: null);
      expect(find.textContaining('FREE TRIAL'), findsNothing);
      expect(find.text('SUBSCRIBE — CA\$79.99/year'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('paywall source guardrails', () {
    final paywallSource = File(
      'lib/features/onboarding/widgets/paywall_page.dart',
    ).readAsStringSync();

    test('no hardcoded trial durations survive in the paywall', () {
      // Trial length must come from the store offer via freeTrialDays.
      expect(paywallSource, isNot(contains('threeDayFreeTrial')));
      expect(paywallSource, isNot(contains('3-DAY')));
      expect(paywallSource, contains('freeTrialDays'));
    });

    test('paywall gate derives the trial from the RevenueCat product', () {
      final gateSource = File('lib/main.dart').readAsStringSync();
      expect(
        gateSource,
        contains('freeTrialDays: freeTrialDaysFromStoreProduct(product)'),
      );
    });

    test('trial badge string stays store-driven in every locale', () {
      // Each catalog must keep the parameterised trial badge (no locale may
      // regress to a hardcoded length).
      final locales = ['en', 'de', 'es', 'fr', 'it', 'ja', 'ko', 'pt', 'pt_BR'];
      for (final locale in locales) {
        final catalog = File('lib/l10n/app_$locale.arb').readAsStringSync();
        expect(
          catalog,
          contains('"freeTrialBadge"'),
          reason: 'app_$locale.arb must define freeTrialBadge',
        );
        expect(
          catalog,
          isNot(contains('"threeDayFreeTrial"')),
          reason: 'app_$locale.arb must not resurrect the hardcoded trial',
        );
      }
    });
  });
}
