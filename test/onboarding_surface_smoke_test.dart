import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/features/onboarding/widgets/confidence_page.dart';
import 'package:peptide_os/features/onboarding/widgets/notification_page.dart';
import 'package:peptide_os/features/onboarding/widgets/paywall_page.dart';
import 'package:peptide_os/features/onboarding/widgets/protocol_roadmap_page.dart';
import 'package:peptide_os/features/protocol/screens/create_protocol_screen.dart';
import 'package:peptide_os/models/blend_vial.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  Future<void> pumpPhoneSurface(
    WidgetTester tester,
    Widget child, {
    Size size = const Size(390, 844),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: Scaffold(backgroundColor: AppColors.background, body: child),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump(const Duration(milliseconds: 700));
  }

  testWidgets('new onboarding surfaces render on phone-sized viewports', (
    tester,
  ) async {
    const goals = {'Recovery', 'Longevity'};
    const confidenceNeeds = {'Dose math', 'Site rotation'};
    const peptides = {'BPC-157', 'TB-500', 'CJC-1295'};

    await pumpPhoneSurface(
      tester,
      ConfidencePage(
        selectedNeeds: confidenceNeeds,
        onToggle: (_) {},
        onNext: () {},
      ),
    );
    expect(tester.takeException(), isNull);

    await pumpPhoneSurface(
      tester,
      const ProtocolRoadmapPage(
        selectedGoals: goals,
        confidenceNeeds: confidenceNeeds,
        selectedPeptides: peptides,
        onNext: _noop,
      ),
    );
    expect(tester.takeException(), isNull);

    await pumpPhoneSurface(
      tester,
      NotificationPage(onEnable: () async => true, onNext: () {}),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('paywall product proof surface renders on phone-sized viewport', (
    tester,
  ) async {
    await pumpPhoneSurface(
      tester,
      PaywallPage(
        onSubscribe: (_) async {},
        onRestore: () {},
        onReviewerBypass: () async {},
        planPrices: _localizedPlanPrices,
      ),
      size: const Size(390, 900),
    );

    expect(
      find.text('Everything to run\nyour protocol right.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('paywall renders localized store prices without USD hardcoding', (
    tester,
  ) async {
    await pumpPhoneSurface(
      tester,
      PaywallPage(
        onSubscribe: (_) async {},
        onRestore: () {},
        onReviewerBypass: () async {},
        planPrices: _localizedPlanPrices,
      ),
      size: const Size(390, 900),
    );

    expect(find.text('CA\$39.99'), findsOneWidget);
    expect(find.text('CA\$79.99'), findsNWidgets(2));
    expect(find.text('CA\$12.99'), findsOneWidget);
    expect(find.text('ACTIVATE PRO - CA\$39.99/year'), findsOneWidget);
    expect(find.text('\$29.99'), findsNothing);
    expect(find.text('\$59.99'), findsNothing);
    expect(find.text('\$9.99'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('seven headline taps trigger reviewer bypass without purchase', (
    tester,
  ) async {
    var bypassCount = 0;
    var purchaseCount = 0;
    await pumpPhoneSurface(
      tester,
      PaywallPage(
        onSubscribe: (_) async => purchaseCount++,
        onRestore: () {},
        onReviewerBypass: () async => bypassCount++,
      ),
      size: const Size(390, 900),
    );

    final headline = find.text('Everything to run\nyour protocol right.');
    for (var tap = 0; tap < 6; tap++) {
      await tester.tap(headline);
    }
    await tester.pump();
    expect(bypassCount, 0);
    expect(purchaseCount, 0);

    await tester.tap(headline);
    await tester.pump();
    expect(bypassCount, 1);
    expect(purchaseCount, 0);
  });

  testWidgets('pre-blended vial editor renders a clear per-draw preview', (
    tester,
  ) async {
    await pumpPhoneSurface(
      tester,
      BlendVialConfigSheet(
        initial: ProtocolPeptide(
          uuid: 'blend-test',
          peptideSlug: 'custom-blend',
          peptideName: 'Recovery blend',
          dosePerInjection: 10,
          doseUnit: 'syringe units',
          frequency: 'twice_weekly',
          syringeUnits: 10,
          blendVial: const BlendVial(
            constituents: [
              BlendConstituent(name: 'Compound A', vialAmount: 10, unit: 'mg'),
              BlendConstituent(name: 'Compound B', vialAmount: 5, unit: 'mg'),
            ],
            diluentMl: 2,
            drawSyringeUnits: 10,
          ),
        ),
      ),
      size: const Size(390, 844),
    );

    expect(find.text('Pre-blended vial'), findsOneWidget);
    expect(find.text('10.0 units = 0.10 mL'), findsOneWidget);
    expect(find.text('0.50 mg'), findsOneWidget);
    expect(find.text('0.25 mg'), findsOneWidget);
    expect(find.text('SAVE BLEND'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

void _noop() {}

const _localizedPlanPrices = <int, PaywallPlanPrice>{
  0: PaywallPlanPrice(
    localizedPrice: 'CA\$39.99',
    amount: 39.99,
    currencyCode: 'CAD',
  ),
  1: PaywallPlanPrice(
    localizedPrice: 'CA\$79.99',
    amount: 79.99,
    currencyCode: 'CAD',
  ),
  2: PaywallPlanPrice(
    localizedPrice: 'CA\$12.99',
    amount: 12.99,
    currencyCode: 'CAD',
  ),
};
