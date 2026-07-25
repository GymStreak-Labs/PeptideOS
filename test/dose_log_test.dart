import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/models/dose_log.dart';

void main() {
  group('DoseLog', () {
    test('round-trips a historical completed dose', () {
      final loggedAt = DateTime(2026, 6, 25, 23, 45);
      final log = DoseLog(
        uuid: 'dose-1',
        protocolUuid: 'protocol-1',
        protocolPeptideUuid: 'pp-1',
        peptideName: 'BPC-157',
        scheduledAt: loggedAt,
        takenAt: loggedAt,
        amountTaken: 250,
        units: 'mcg',
        syringeUnits: 12.5,
        injectionSite: 'left-abdomen',
        notes: 'Logged after midnight',
      );

      final restored = DoseLog.fromMap(log.uuid, log.toMap());

      expect(restored.uuid, 'dose-1');
      expect(restored.scheduledAt, loggedAt);
      expect(restored.takenAt, loggedAt);
      expect(restored.isTaken, isTrue);
      expect(restored.skipped, isFalse);
      expect(restored.syringeUnits, 12.5);
      expect(restored.notes, 'Logged after midnight');
    });

    test('editable copy preserves schedule identity and cross-references', () {
      final scheduledAt = DateTime(2026, 7, 10, 8);
      final takenAt = DateTime(2026, 7, 10, 8, 15);
      final log = DoseLog(
        uuid: 'dose-2',
        protocolUuid: 'protocol-2',
        protocolPeptideUuid: 'pp-2',
        peptideName: 'TB-500',
        scheduledAt: scheduledAt,
        takenAt: takenAt,
        amountTaken: 500,
        units: 'mcg',
        syringeUnits: 10,
        injectionSite: 'left-thigh',
        notes: 'Original',
      );

      final edited = log.copyWith(
        takenAt: DateTime(2026, 7, 10, 9, 30),
        amountTaken: 450,
        injectionSite: 'right-thigh',
        notes: 'Corrected',
      );

      expect(edited.uuid, log.uuid);
      expect(edited.protocolUuid, log.protocolUuid);
      expect(edited.protocolPeptideUuid, log.protocolPeptideUuid);
      expect(edited.peptideName, log.peptideName);
      expect(edited.scheduledAt, scheduledAt);
      expect(edited.units, 'mcg');
      expect(edited.syringeUnits, 10);
      expect(edited.takenAt, DateTime(2026, 7, 10, 9, 30));
      expect(edited.amountTaken, 450);
      expect(edited.injectionSite, 'right-thigh');
      expect(edited.notes, 'Corrected');

      expect(log.takenAt, takenAt);
      expect(log.amountTaken, 500);
      expect(log.injectionSite, 'left-thigh');
      expect(log.notes, 'Original');
    });

    test(
      'status correction can clear actual time without changing schedule',
      () {
        final scheduledAt = DateTime(2026, 7, 11, 20);
        final log = DoseLog(
          uuid: 'dose-3',
          protocolUuid: 'protocol-3',
          protocolPeptideUuid: 'pp-3',
          peptideName: 'BPC-157',
          scheduledAt: scheduledAt,
          takenAt: DateTime(2026, 7, 11, 20, 5),
          amountTaken: 250,
          units: 'mcg',
        );

        final skipped = log.copyWith(clearTakenAt: true, skipped: true);

        expect(skipped.takenAt, isNull);
        expect(skipped.skipped, isTrue);
        expect(skipped.scheduledAt, scheduledAt);
        expect(log.isTaken, isTrue);
      },
    );
  });
}
