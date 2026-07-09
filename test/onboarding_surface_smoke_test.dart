import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/features/onboarding/widgets/confidence_page.dart';
import 'package:peptide_os/features/onboarding/widgets/notification_page.dart';
import 'package:peptide_os/features/onboarding/widgets/paywall_page.dart';
import 'package:peptide_os/features/onboarding/widgets/protocol_roadmap_page.dart';

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
      PaywallPage(onSubscribe: (_) async {}, onRestore: () {}),
      size: const Size(390, 900),
    );

    expect(
      find.text('Keep every dose and\nreminder in one clear plan.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}

void _noop() {}
