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
        injectionSite: 'left-abdomen',
        notes: 'Logged after midnight',
      );

      final restored = DoseLog.fromMap(log.uuid, log.toMap());

      expect(restored.uuid, 'dose-1');
      expect(restored.scheduledAt, loggedAt);
      expect(restored.takenAt, loggedAt);
      expect(restored.isTaken, isTrue);
      expect(restored.skipped, isFalse);
      expect(restored.notes, 'Logged after midnight');
    });
  });
}
