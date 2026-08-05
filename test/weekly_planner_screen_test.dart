import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/features/protocol/screens/weekly_planner_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'shows the exact custom schedule, phase, next week, and washout state',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final protocol = Protocol(
        uuid: 'protocol-1',
        name: 'Recovery protocol',
        startDate: DateTime(2026, 8, 3),
        status: ProtocolStatus.active,
        createdAt: DateTime(2026, 8, 1),
        peptides: [
          ProtocolPeptide(
            uuid: 'bpc',
            peptideName: 'BPC-157',
            dosePerInjection: 250,
            doseUnit: 'mcg',
            frequency: kCustomWeekdayFrequency,
            cycleWeeks: 1,
            washoutWeeks: 1,
            weekdayDoses: [
              ProtocolWeekdayDose(
                weekday: DateTime.monday,
                dosePerInjection: 250,
                scheduledTimes: const ['07:30', '19:30'],
              ),
              ProtocolWeekdayDose(
                weekday: DateTime.wednesday,
                dosePerInjection: 300,
                scheduledTimes: const ['20:15'],
              ),
            ],
            phases: [
              ProtocolPhase(
                uuid: 'phase-1',
                name: 'Foundation',
                startWeek: 1,
                endWeek: 1,
                frequency: kCustomWeekdayFrequency,
                weekdayDoses: [
                  ProtocolWeekdayDose(
                    weekday: DateTime.monday,
                    dosePerInjection: 250,
                    scheduledTimes: const ['07:30', '19:30'],
                  ),
                  ProtocolWeekdayDose(
                    weekday: DateTime.wednesday,
                    dosePerInjection: 300,
                    scheduledTimes: const ['20:15'],
                  ),
                ],
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: WeeklyPlannerScreen(
            protocols: [protocol],
            initialDate: DateTime(2026, 8, 3),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining(' – '), findsOneWidget);
      expect(find.text('BPC-157'), findsNWidgets(2));
      expect(find.text('07:30'), findsOneWidget);
      expect(find.text('19:30'), findsOneWidget);
      expect(find.text('250 mcg'), findsNWidgets(2));
      expect(find.text('PHASE // FOUNDATION'), findsNWidgets(2));
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('W'));
      await tester.pumpAndSettle();

      expect(find.text('20:15'), findsOneWidget);
      expect(find.text('300 mcg'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.byTooltip('Next week'));
      await tester.pumpAndSettle();

      expect(find.textContaining(' – '), findsOneWidget);
      expect(find.text('WASHOUT'), findsOneWidget);
      expect(find.textContaining('Washout until'), findsOneWidget);
      expect(find.text('BPC-157'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('de'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: WeeklyPlannerScreen(
            protocols: [protocol],
            initialDate: DateTime(2026, 8, 3),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('HEUTE'), findsOneWidget);
      expect(find.byTooltip('Nächste Woche'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'ending then resuming reopens the planner and generated schedule together',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final firestore = FakeFirebaseFirestore();
      final protocolRepository = ProtocolRepository(firestore: firestore);
      final doseRepository = DoseLogRepository(firestore: firestore);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));
      final protocol = Protocol(
        uuid: 'resume-protocol',
        name: 'Resume test',
        startDate: today,
        endDate: today,
        status: ProtocolStatus.ended,
        createdAt: today,
        peptides: [
          ProtocolPeptide(
            uuid: 'resume-peptide',
            peptideName: 'Tracked peptide',
            dosePerInjection: 125,
            doseUnit: 'mcg',
            frequency: 'daily',
            scheduledTimes: const ['09:15'],
          ),
        ],
      );
      await protocolRepository.upsert('resume-test-user', protocol);
      final provider = ProtocolProvider(
        protocolRepository,
        doseRepository,
        uid: 'resume-test-user',
      );
      addTearDown(provider.dispose);

      await provider.resumeProtocol(protocol);

      expect(protocol.status, ProtocolStatus.active);
      expect(protocol.endDate, isNull);

      final persisted = await protocolRepository.fetchAllOnce(
        'resume-test-user',
      );
      expect(persisted, hasLength(1));
      expect(persisted.single.status, ProtocolStatus.active);
      expect(persisted.single.endDate, isNull);

      final generated = await doseRepository.fetchRange(
        'resume-test-user',
        tomorrow,
        tomorrow.add(const Duration(days: 1)),
      );
      expect(generated, hasLength(1));
      expect(generated.single.peptideName, 'Tracked peptide');
      expect(generated.single.scheduledAt.hour, 9);
      expect(generated.single.scheduledAt.minute, 15);

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: WeeklyPlannerScreen(
            protocols: persisted,
            initialDate: tomorrow,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Tracked peptide'), findsOneWidget);
      expect(find.text('09:15'), findsOneWidget);
      expect(find.text('125 mcg'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
