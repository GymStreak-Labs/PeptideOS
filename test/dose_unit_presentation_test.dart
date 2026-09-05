import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:peptide_os/core/utils/dose_presentation.dart';
import 'package:peptide_os/data/repositories/user_settings_repository.dart';
import 'package:peptide_os/features/profile/providers/settings_provider.dart';
import 'package:peptide_os/features/protocol/screens/weekly_planner_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/protocol.dart';
import 'package:peptide_os/models/user_settings.dart';

void main() {
  testWidgets(
    'planner reacts to mass preference without changing schedules or syringe units',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final settings = SettingsProvider(
        UserSettingsRepository(firestore: FakeFirebaseFirestore()),
        uid: '',
      );
      addTearDown(settings.dispose);
      final day = DateTime(2026, 9, 7);
      final protocol = Protocol(
        uuid: 'unit-protocol',
        name: 'Unit protocol',
        startDate: day,
        createdAt: day,
        status: ProtocolStatus.active,
        peptides: [
          ProtocolPeptide(
            uuid: 'mcg',
            peptideName: 'Microgram compound',
            dosePerInjection: 500,
            doseUnit: 'mcg',
            syringeUnits: 10,
            scheduledTimes: ['08:00'],
          ),
          ProtocolPeptide(
            uuid: 'mg',
            peptideName: 'Milligram compound',
            dosePerInjection: 2.5,
            doseUnit: 'mg',
            syringeUnits: 12,
            scheduledTimes: ['09:00'],
          ),
          ProtocolPeptide(
            uuid: 'iu',
            peptideName: 'Activity compound',
            dosePerInjection: 4,
            doseUnit: 'IU',
            syringeUnits: 8,
            scheduledTimes: ['10:00'],
          ),
        ],
      );
      final storedBefore = protocol.toMap();
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: settings,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: WeeklyPlannerScreen(protocols: [protocol], initialDate: day),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('500 mcg · 10 Units'), findsOneWidget);
      expect(find.text('2.5 mg · 12 Units'), findsOneWidget);
      expect(find.text('4 IU · 8 Units'), findsOneWidget);

      await settings.update(
        (s) => s.doseUnitPreference = DoseUnitPreference.mg,
      );
      await tester.pumpAndSettle();
      expect(find.text('0.5 mg · 10 Units'), findsOneWidget);
      expect(find.text('2.5 mg · 12 Units'), findsOneWidget);
      expect(find.text('4 IU · 8 Units'), findsOneWidget);
      expect(protocol.toMap(), storedBefore);

      await settings.update(
        (s) => s.doseUnitPreference = DoseUnitPreference.mcg,
      );
      await tester.pumpAndSettle();
      expect(find.text('500 mcg · 10 Units'), findsOneWidget);
      expect(find.text('2500 mcg · 12 Units'), findsOneWidget);
      expect(find.text('4 IU · 8 Units'), findsOneWidget);
      expect(protocol.toMap(), storedBefore);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'presentation keeps original units without settings provider and localizes fractional doses',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('de'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Builder(
              builder: (context) => Column(
                children: [
                  Text(context.displayDose(0.0005, 'mg')),
                  Text(context.displayDose(500, 'mcg')),
                  Text(context.displayDose(4, 'IU')),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('0,0005 mg'), findsOneWidget);
      expect(find.text('500 mcg'), findsOneWidget);
      expect(find.text('4 IU'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
