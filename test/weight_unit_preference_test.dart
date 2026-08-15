import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:peptide_os/core/utils/weight_units.dart';
import 'package:peptide_os/data/repositories/body_metric_repository.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/data/repositories/user_settings_repository.dart';
import 'package:peptide_os/features/profile/providers/settings_provider.dart';
import 'package:peptide_os/features/progress/providers/body_metric_provider.dart';
import 'package:peptide_os/features/progress/screens/progress_screen.dart';
import 'package:peptide_os/features/progress/widgets/log_metric_sheet.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/user_settings.dart';

void main() {
  test('weight conversion round-trips through canonical kilograms', () {
    const kilograms = 100.0;

    final pounds = UnitSystem.imperial.displayWeightFromKg(kilograms);

    expect(pounds, closeTo(220.462262, 0.000001));
    expect(
      UnitSystem.imperial.storageWeightInKg(pounds),
      closeTo(kilograms, 0.000001),
    );
    expect(UnitSystem.metric.displayWeightFromKg(kilograms), kilograms);
    expect(UnitSystem.metric.storageWeightInKg(kilograms), kilograms);
  });

  testWidgets('imperial weight input is labelled in lbs and stored as kg', (
    tester,
  ) async {
    final firestore = FakeFirebaseFirestore();
    final settings = SettingsProvider(
      UserSettingsRepository(firestore: firestore),
      uid: '',
    );
    await settings.update((value) => value.units = UnitSystem.imperial);
    final metrics = BodyMetricProvider(
      BodyMetricRepository(firestore: firestore),
      uid: 'test-user',
    );
    addTearDown(settings.dispose);
    addTearDown(metrics.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: metrics),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: LogMetricSheet()),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('lbs'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '220.462262');
    await tester.tap(find.text('SAVE'));
    await tester.pumpAndSettle();

    final snapshot = await firestore
        .collection('users')
        .doc('test-user')
        .collection('bodyMetrics')
        .get();
    expect(snapshot.docs, hasLength(1));
    expect(snapshot.docs.single.data()['weightKg'], closeTo(100, 0.000001));
  });

  testWidgets('changing units immediately converts existing weight history', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final firestore = FakeFirebaseFirestore();
    await firestore
        .collection('users')
        .doc('test-user')
        .collection('bodyMetrics')
        .doc('metric-1')
        .set({
          'uuid': 'metric-1',
          'date': DateTime(2026, 8, 7).toIso8601String(),
          'weightKg': 100.0,
        });
    final settings = SettingsProvider(
      UserSettingsRepository(firestore: firestore),
      uid: '',
    );
    final metrics = BodyMetricProvider(
      BodyMetricRepository(firestore: firestore),
      uid: 'test-user',
    );
    final doseLogs = DoseLogProvider(
      DoseLogRepository(firestore: firestore),
      uid: 'test-user',
    );
    final protocols = ProtocolProvider(
      ProtocolRepository(firestore: firestore),
      DoseLogRepository(firestore: firestore),
      uid: 'test-user',
    );
    addTearDown(settings.dispose);
    addTearDown(metrics.dispose);
    addTearDown(doseLogs.dispose);
    addTearDown(protocols.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: metrics),
          ChangeNotifierProvider.value(value: doseLogs),
          ChangeNotifierProvider.value(value: protocols),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: ProgressScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('100.0 kg'),
      180,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('100.0 kg'), findsOneWidget);

    await settings.update((value) => value.units = UnitSystem.imperial);
    await tester.pump();

    expect(find.text('100.0 kg'), findsNothing);
    expect(find.text('220.5 lbs'), findsOneWidget);
  });
}
