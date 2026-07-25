import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  group('ProtocolPeptide scheduleForDate', () {
    test('keeps legacy daily protocols backward compatible', () {
      final peptide = ProtocolPeptide.fromMap({
        'uuid': 'pp-1',
        'peptideName': 'BPC-157',
        'dosePerInjection': 250,
        'doseUnit': 'mcg',
        'frequency': 'daily',
      });

      expect(peptide.weekdayDoses, isEmpty);
      expect(peptide.labelColorHex, isEmpty);

      final schedule = peptide.scheduleForDate(
        protocolStart: DateTime(2026, 6, 20),
        date: DateTime(2026, 6, 24),
      );

      expect(schedule, isNotNull);
      expect(schedule!.dosePerInjection, 250);
      expect(schedule.doseUnit, 'mcg');
      expect(schedule.scheduledTimes, ['08:00']);
      expect(peptide.phases, isEmpty);
    });

    test('does not schedule any frequency before the protocol start date', () {
      final peptide = ProtocolPeptide(
        peptideName: 'TB-500',
        dosePerInjection: 2.5,
        doseUnit: 'mg',
        frequency: 'daily',
      );

      final schedule = peptide.scheduleForDate(
        protocolStart: DateTime(2026, 6, 25),
        date: DateTime(2026, 6, 24),
      );

      expect(schedule, isNull);
    });

    test('anchors every other day schedules to the protocol start date', () {
      final peptide = ProtocolPeptide(
        peptideName: 'CJC-1295',
        dosePerInjection: 100,
        doseUnit: 'mcg',
        frequency: 'eod',
      );

      expect(
        peptide.scheduleForDate(
          protocolStart: DateTime(2026, 6, 22),
          date: DateTime(2026, 6, 22),
        ),
        isNotNull,
      );
      expect(
        peptide.scheduleForDate(
          protocolStart: DateTime(2026, 6, 22),
          date: DateTime(2026, 6, 23),
        ),
        isNull,
      );
      expect(
        peptide.scheduleForDate(
          protocolStart: DateTime(2026, 6, 22),
          date: DateTime(2026, 6, 24),
        ),
        isNotNull,
      );
    });

    test('uses selected weekdays and per-day amounts for custom schedules', () {
      final peptide = ProtocolPeptide(
        peptideName: 'GHK-Cu',
        dosePerInjection: 1000,
        doseUnit: 'mcg',
        syringeUnits: 12.5,
        frequency: kCustomWeekdayFrequency,
        scheduledTimes: const ['09:00', '21:00'],
        weekdayDoses: [
          ProtocolWeekdayDose(
            weekday: DateTime.monday,
            dosePerInjection: 1000,
            doseUnit: 'mcg',
            syringeUnits: 10,
            scheduledTimes: const ['07:30', '19:30'],
          ),
          ProtocolWeekdayDose(
            weekday: DateTime.wednesday,
            dosePerInjection: 1500,
            doseUnit: 'mcg',
            syringeUnits: 15,
            scheduledTimes: const ['20:15'],
          ),
        ],
      );

      final monday = peptide.scheduleForDate(
        protocolStart: DateTime(2026, 6, 22),
        date: DateTime(2026, 6, 22),
      );
      final tuesday = peptide.scheduleForDate(
        protocolStart: DateTime(2026, 6, 22),
        date: DateTime(2026, 6, 23),
      );
      final wednesday = peptide.scheduleForDate(
        protocolStart: DateTime(2026, 6, 22),
        date: DateTime(2026, 6, 24),
      );

      expect(monday, isNotNull);
      expect(monday!.dosePerInjection, 1000);
      expect(monday.syringeUnits, 10);
      expect(monday.scheduledTimes, ['07:30', '19:30']);
      expect(tuesday, isNull);
      expect(wednesday, isNotNull);
      expect(wednesday!.dosePerInjection, 1500);
      expect(wednesday.syringeUnits, 15);
      expect(wednesday.scheduledTimes, ['20:15']);
    });

    test(
      'cycle windows stop future schedule generation and expose washout',
      () {
        final peptide = ProtocolPeptide(
          peptideName: 'BPC-157',
          dosePerInjection: 250,
          frequency: 'daily',
          cycleWeeks: 2,
          washoutWeeks: 1,
        );
        final start = DateTime(2026, 6, 1);

        expect(
          peptide.scheduleForDate(
            protocolStart: start,
            date: DateTime(2026, 6, 14),
          ),
          isNotNull,
        );
        expect(
          peptide.scheduleForDate(
            protocolStart: start,
            date: DateTime(2026, 6, 15),
          ),
          isNull,
        );
        expect(
          peptide.isInWashout(
            protocolStart: start,
            date: DateTime(2026, 6, 16),
          ),
          isTrue,
        );
        expect(peptide.cycleEndDate(start), DateTime(2026, 6, 15));
        expect(peptide.washoutEndDate(start), DateTime(2026, 6, 22));
      },
    );

    test('round-trips custom weekday dose maps', () {
      final peptide = ProtocolPeptide(
        uuid: 'pp-1',
        peptideName: 'Semaglutide',
        dosePerInjection: 0.25,
        doseUnit: 'mg',
        syringeUnits: 8,
        frequency: kCustomWeekdayFrequency,
        cycleWeeks: 8,
        washoutWeeks: 4,
        labelColorHex: '#FF2A6D',
        weekdayDoses: [
          ProtocolWeekdayDose(
            weekday: DateTime.friday,
            dosePerInjection: 0.25,
            doseUnit: 'mg',
            syringeUnits: 8,
            scheduledTimes: const ['08:45'],
          ),
        ],
      );

      final restored = ProtocolPeptide.fromMap(peptide.toMap());

      expect(restored.usesCustomWeekdays, isTrue);
      expect(restored.syringeUnits, 8);
      expect(restored.cycleWeeks, 8);
      expect(restored.washoutWeeks, 4);
      expect(restored.labelColorHex, '#FF2A6D');
      expect(restored.weekdayDoses.single.weekday, DateTime.friday);
      expect(restored.weekdayDoses.single.dosePerInjection, 0.25);
      expect(restored.weekdayDoses.single.doseUnit, 'mg');
      expect(restored.weekdayDoses.single.syringeUnits, 8);
      expect(restored.weekdayDoses.single.scheduledTimes, ['08:45']);
    });

    test('applies amount and schedule overrides only inside phase weeks', () {
      final peptide = ProtocolPeptide(
        uuid: 'pp-phase',
        peptideName: 'Custom peptide',
        dosePerInjection: 100,
        doseUnit: 'mcg',
        frequency: 'daily',
        scheduledTimes: const ['08:00'],
        phases: [
          ProtocolPhase(
            uuid: 'phase-1',
            name: 'Weeks 2–3',
            startWeek: 2,
            endWeek: 3,
            dosePerInjection: 150,
            doseUnit: 'mcg',
            syringeUnits: 12,
            frequency: 'weekly',
            scheduledTimes: const ['19:30'],
            note: 'User-entered tracking change',
          ),
        ],
      );
      final start = DateTime(2026, 6, 1);

      final week1 = peptide.scheduleForDate(
        protocolStart: start,
        date: DateTime(2026, 6, 2),
      );
      final phaseStart = peptide.scheduleForDate(
        protocolStart: start,
        date: DateTime(2026, 6, 8),
      );
      final phaseOffDay = peptide.scheduleForDate(
        protocolStart: start,
        date: DateTime(2026, 6, 9),
      );
      final afterPhase = peptide.scheduleForDate(
        protocolStart: start,
        date: DateTime(2026, 6, 22),
      );

      expect(week1?.dosePerInjection, 100);
      expect(phaseStart?.dosePerInjection, 150);
      expect(phaseStart?.syringeUnits, 12);
      expect(phaseStart?.scheduledTimes, ['19:30']);
      expect(phaseOffDay, isNull);
      expect(afterPhase?.dosePerInjection, 100);
      expect(afterPhase?.scheduledTimes, ['08:00']);
    });

    test('anchors every-other-day overrides to their phase start', () {
      final peptide = ProtocolPeptide(
        dosePerInjection: 100,
        frequency: 'daily',
        phases: [
          ProtocolPhase(
            uuid: 'phase-eod',
            name: 'Phase EOD',
            startWeek: 2,
            endWeek: 2,
            dosePerInjection: 125,
            doseUnit: 'mcg',
            frequency: 'eod',
            scheduledTimes: const ['09:00'],
          ),
        ],
      );
      final start = DateTime(2026, 6, 1);

      expect(
        peptide.scheduleForDate(
          protocolStart: start,
          date: DateTime(2026, 6, 8),
        ),
        isNotNull,
      );
      expect(
        peptide.scheduleForDate(
          protocolStart: start,
          date: DateTime(2026, 6, 9),
        ),
        isNull,
      );
      expect(
        peptide.scheduleForDate(
          protocolStart: start,
          date: DateTime(2026, 6, 10),
        ),
        isNotNull,
      );
    });

    test(
      'uses phase-specific custom weekdays, amounts, and reminder times',
      () {
        final peptide = ProtocolPeptide(
          dosePerInjection: 100,
          doseUnit: 'mcg',
          frequency: 'daily',
          scheduledTimes: const ['08:00'],
          phases: [
            ProtocolPhase(
              uuid: 'phase-custom',
              name: 'Custom tracking window',
              startWeek: 2,
              endWeek: 3,
              dosePerInjection: 100,
              doseUnit: 'mcg',
              frequency: kCustomWeekdayFrequency,
              weekdayDoses: [
                ProtocolWeekdayDose(
                  weekday: DateTime.tuesday,
                  dosePerInjection: 125,
                  doseUnit: 'mcg',
                  syringeUnits: 10,
                  scheduledTimes: const ['07:15'],
                ),
                ProtocolWeekdayDose(
                  weekday: DateTime.friday,
                  dosePerInjection: 175,
                  doseUnit: 'mcg',
                  syringeUnits: 14,
                  scheduledTimes: const ['19:45', '21:15'],
                ),
              ],
            ),
          ],
        );
        final start = DateTime(2026, 6, 1);

        final monday = peptide.scheduleForDate(
          protocolStart: start,
          date: DateTime(2026, 6, 8),
        );
        final tuesday = peptide.scheduleForDate(
          protocolStart: start,
          date: DateTime(2026, 6, 9),
        );
        final friday = peptide.scheduleForDate(
          protocolStart: start,
          date: DateTime(2026, 6, 12),
        );

        expect(monday, isNull);
        expect(tuesday?.dosePerInjection, 125);
        expect(tuesday?.syringeUnits, 10);
        expect(tuesday?.scheduledTimes, ['07:15']);
        expect(friday?.dosePerInjection, 175);
        expect(friday?.syringeUnits, 14);
        expect(friday?.scheduledTimes, ['19:45', '21:15']);

        final restored = ProtocolPeptide.fromMap(peptide.toMap());
        final restoredPhase = restored.phases.single;
        expect(restoredPhase.frequency, kCustomWeekdayFrequency);
        expect(restoredPhase.weekdayDoses, hasLength(2));
        expect(restoredPhase.weekdayDoses.last.scheduledTimes, [
          '19:45',
          '21:15',
        ]);
      },
    );

    test('round-trips phase configuration without migrating legacy fields', () {
      final peptide = ProtocolPeptide(
        uuid: 'pp-1',
        peptideName: 'Custom peptide',
        dosePerInjection: 2,
        doseUnit: 'mg',
        frequency: 'twice_weekly',
        phases: [
          ProtocolPhase(
            uuid: 'phase-2',
            name: 'Second window',
            startWeek: 4,
            endWeek: 6,
            note: 'Review saved tracking plan',
            dosePerInjection: 2.5,
            doseUnit: 'mg',
            syringeUnits: 15,
            frequency: 'weekly',
            scheduledTimes: const ['07:15', '20:15'],
          ),
        ],
      );

      final map = peptide.toMap();
      final restored = ProtocolPeptide.fromMap(map);
      final phase = restored.phases.single;

      expect(restored.frequency, 'twice_weekly');
      expect(restored.dosePerInjection, 2);
      expect(phase.uuid, 'phase-2');
      expect(phase.name, 'Second window');
      expect(phase.startWeek, 4);
      expect(phase.endWeek, 6);
      expect(phase.note, 'Review saved tracking plan');
      expect(phase.dosePerInjection, 2.5);
      expect(phase.syringeUnits, 15);
      expect(phase.frequency, 'weekly');
      expect(phase.scheduledTimes, ['07:15', '20:15']);
    });

    test('cloned peptide maps can be edited without mutating the source', () {
      final source = ProtocolPeptide(
        uuid: 'pp-1',
        peptideName: 'TB-500',
        dosePerInjection: 2.5,
        doseUnit: 'mg',
        frequency: kCustomWeekdayFrequency,
        weekdayDoses: [
          ProtocolWeekdayDose(
            weekday: DateTime.monday,
            dosePerInjection: 2.5,
            doseUnit: 'mg',
          ),
        ],
      );

      final clone = ProtocolPeptide.fromMap(source.toMap())
        ..dosePerInjection = 5
        ..weekdayDoses.first.dosePerInjection = 5;

      expect(clone.uuid, source.uuid);
      expect(source.dosePerInjection, 2.5);
      expect(source.weekdayDoses.single.dosePerInjection, 2.5);
      expect(clone.weekdayDoses.single.dosePerInjection, 5);
    });
  });
}
