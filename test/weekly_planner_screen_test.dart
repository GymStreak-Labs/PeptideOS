import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/features/protocol/screens/weekly_planner_screen.dart';
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
          home: WeeklyPlannerScreen(
            protocols: [protocol],
            initialDate: DateTime(2026, 8, 3),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Aug 3–9'), findsOneWidget);
      expect(find.text('BPC-157'), findsNWidgets(2));
      expect(find.text('07:30'), findsOneWidget);
      expect(find.text('19:30'), findsOneWidget);
      expect(find.text('250 mcg'), findsNWidgets(2));
      expect(find.text('PHASE // FOUNDATION'), findsNWidgets(2));
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('WED'));
      await tester.pumpAndSettle();

      expect(find.text('20:15'), findsOneWidget);
      expect(find.text('300 mcg'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.byTooltip('Next week'));
      await tester.pumpAndSettle();

      expect(find.text('Aug 10–16'), findsOneWidget);
      expect(find.text('WASHOUT'), findsOneWidget);
      expect(find.text('Washout until Aug 17'), findsOneWidget);
      expect(find.text('BPC-157'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
