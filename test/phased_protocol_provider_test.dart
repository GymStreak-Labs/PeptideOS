import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'phase weekday times materialize separate logs for dose reminders',
    () async {
      final firestore = FakeFirebaseFirestore();
      final doseRepository = DoseLogRepository(firestore: firestore);
      final provider = ProtocolProvider(
        ProtocolRepository(firestore: firestore),
        doseRepository,
        uid: 'phase-test-user',
      );
      addTearDown(provider.dispose);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final protocol = await provider.createProtocol(
        name: 'Custom phase test',
        startDate: today,
        peptides: [
          ProtocolPeptide(
            uuid: 'peptide-phase-test',
            peptideName: 'Custom peptide',
            dosePerInjection: 100,
            doseUnit: 'mcg',
            frequency: 'daily',
            phases: [
              ProtocolPhase(
                uuid: 'phase-weekday-test',
                name: 'User schedule',
                startWeek: 1,
                endWeek: 1,
                dosePerInjection: 100,
                doseUnit: 'mcg',
                frequency: kCustomWeekdayFrequency,
                weekdayDoses: [
                  ProtocolWeekdayDose(
                    weekday: today.weekday,
                    dosePerInjection: 175,
                    doseUnit: 'mcg',
                    syringeUnits: 14,
                    scheduledTimes: const ['07:15', '19:45'],
                  ),
                ],
              ),
            ],
          ),
        ],
      );

      final logs = await doseRepository.fetchRange(
        'phase-test-user',
        today,
        today.add(const Duration(days: 7)),
      );
      final phaseLogs = logs
          .where((log) => log.protocolUuid == protocol.uuid)
          .toList();

      expect(phaseLogs, hasLength(2));
      expect(phaseLogs.map((log) => log.scheduledAt.hour), [7, 19]);
      expect(phaseLogs.map((log) => log.scheduledAt.minute), [15, 45]);
      expect(phaseLogs.every((log) => log.amountTaken == 175), isTrue);
      expect(phaseLogs.every((log) => log.syringeUnits == 14), isTrue);
    },
  );
}
