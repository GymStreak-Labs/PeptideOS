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

      final schedule = peptide.scheduleForDate(
        protocolStart: DateTime(2026, 6, 20),
        date: DateTime(2026, 6, 24),
      );

      expect(schedule, isNotNull);
      expect(schedule!.dosePerInjection, 250);
      expect(schedule.doseUnit, 'mcg');
      expect(schedule.scheduledTimes, ['08:00']);
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
        frequency: kCustomWeekdayFrequency,
        scheduledTimes: const ['09:00'],
        weekdayDoses: [
          ProtocolWeekdayDose(
            weekday: DateTime.monday,
            dosePerInjection: 1000,
            doseUnit: 'mcg',
            scheduledTimes: const ['07:30'],
          ),
          ProtocolWeekdayDose(
            weekday: DateTime.wednesday,
            dosePerInjection: 1500,
            doseUnit: 'mcg',
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
      expect(monday.scheduledTimes, ['07:30']);
      expect(tuesday, isNull);
      expect(wednesday, isNotNull);
      expect(wednesday!.dosePerInjection, 1500);
      expect(wednesday.scheduledTimes, ['20:15']);
    });

    test('round-trips custom weekday dose maps', () {
      final peptide = ProtocolPeptide(
        uuid: 'pp-1',
        peptideName: 'Semaglutide',
        dosePerInjection: 0.25,
        doseUnit: 'mg',
        frequency: kCustomWeekdayFrequency,
        weekdayDoses: [
          ProtocolWeekdayDose(
            weekday: DateTime.friday,
            dosePerInjection: 0.25,
            doseUnit: 'mg',
            scheduledTimes: const ['08:45'],
          ),
        ],
      );

      final restored = ProtocolPeptide.fromMap(peptide.toMap());

      expect(restored.usesCustomWeekdays, isTrue);
      expect(restored.weekdayDoses.single.weekday, DateTime.friday);
      expect(restored.weekdayDoses.single.dosePerInjection, 0.25);
      expect(restored.weekdayDoses.single.doseUnit, 'mg');
      expect(restored.weekdayDoses.single.scheduledTimes, ['08:45']);
    });
  });
}
