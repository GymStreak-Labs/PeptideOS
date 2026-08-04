import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/models/dose_log.dart';

void main() {
  group('fetchLatestInjectionForPeptide', () {
    test(
      'finds an injection older than 30 days on the second query page',
      () async {
        final now = DateTime(2026, 8, 4, 12);
        final repository = DoseLogRepository(
          firestore: FakeFirebaseFirestore(),
        );

        DoseLog dose({
          required String uuid,
          required String peptideUuid,
          required DateTime scheduledAt,
          DateTime? takenAt,
          String site = '',
          bool skipped = false,
        }) => DoseLog(
          uuid: uuid,
          protocolUuid: 'protocol',
          protocolPeptideUuid: peptideUuid,
          peptideName: peptideUuid,
          scheduledAt: scheduledAt,
          takenAt: takenAt,
          amountTaken: 1,
          units: 'mg',
          injectionSite: site,
          skipped: skipped,
        );

        final newerUnusableSites = List.generate(
          25,
          (index) => dose(
            uuid: 'empty-site-$index',
            peptideUuid: 'peptide-a',
            scheduledAt: now.subtract(Duration(days: index + 1)),
            takenAt: now.subtract(Duration(days: index + 1)),
          ),
        );
        await repository.upsertMany('user', [
          ...newerUnusableSites,
          dose(
            uuid: 'newer-other-peptide',
            peptideUuid: 'peptide-b',
            scheduledAt: now.subtract(const Duration(hours: 1)),
            takenAt: now.subtract(const Duration(hours: 1)),
            site: 'right-thigh',
          ),
          dose(
            uuid: 'target-over-30-days',
            peptideUuid: 'peptide-a',
            scheduledAt: now.subtract(const Duration(days: 45)),
            takenAt: now.subtract(const Duration(days: 45)),
            site: 'left-thigh',
          ),
        ]);

        final result = await repository.fetchLatestInjectionForPeptide(
          'user',
          protocolPeptideUuid: 'peptide-a',
        );

        expect(result?.uuid, 'target-over-30-days');
        expect(result?.injectionSite, 'left-thigh');
      },
    );

    test('returns null after multiple pages contain no usable site', () async {
      final now = DateTime(2026, 8, 4, 12);
      final repository = DoseLogRepository(firestore: FakeFirebaseFirestore());
      final unusable = List.generate(
        51,
        (index) => DoseLog(
          uuid: 'empty-site-$index',
          protocolUuid: 'protocol',
          protocolPeptideUuid: 'peptide-a',
          peptideName: 'BPC-157',
          scheduledAt: now.subtract(Duration(hours: index)),
          takenAt: now.subtract(Duration(hours: index)),
          amountTaken: 250,
          units: 'mcg',
        ),
      );
      await repository.upsertMany('user', unusable);

      final result = await repository.fetchLatestInjectionForPeptide(
        'user',
        protocolPeptideUuid: 'peptide-a',
      );

      expect(result, isNull);
    });

    test('orders by takenAt and excludes unusable records', () async {
      final repository = DoseLogRepository(firestore: FakeFirebaseFirestore());
      final now = DateTime(2026, 8, 4, 12);

      DoseLog dose({
        required String uuid,
        required DateTime scheduledAt,
        DateTime? takenAt,
        String site = '',
        bool skipped = false,
      }) => DoseLog(
        uuid: uuid,
        protocolUuid: 'protocol',
        protocolPeptideUuid: 'peptide-a',
        peptideName: 'BPC-157',
        scheduledAt: scheduledAt,
        takenAt: takenAt,
        amountTaken: 250,
        units: 'mcg',
        injectionSite: site,
        skipped: skipped,
      );

      await repository.upsertMany('user', [
        dose(
          uuid: 'scheduled-recently-taken-earlier',
          scheduledAt: now.subtract(const Duration(days: 2)),
          takenAt: now.subtract(const Duration(days: 5)),
          site: 'left-abdomen',
        ),
        dose(
          uuid: 'scheduled-long-ago-taken-latest',
          scheduledAt: now.subtract(const Duration(days: 60)),
          takenAt: now.subtract(const Duration(hours: 1)),
          site: 'right-abdomen',
        ),
        dose(
          uuid: 'excluded-current',
          scheduledAt: now,
          takenAt: now,
          site: 'left-glute',
        ),
        dose(
          uuid: 'skipped',
          scheduledAt: now,
          takenAt: now.add(const Duration(minutes: 1)),
          site: 'right-glute',
          skipped: true,
        ),
        dose(
          uuid: 'empty-site',
          scheduledAt: now,
          takenAt: now.add(const Duration(minutes: 2)),
        ),
        dose(
          uuid: 'pending',
          scheduledAt: now.add(const Duration(days: 1)),
          site: 'right-thigh',
        ),
      ]);

      final result = await repository.fetchLatestInjectionForPeptide(
        'user',
        protocolPeptideUuid: 'peptide-a',
        excludingDoseUuid: 'excluded-current',
      );

      expect(result?.uuid, 'scheduled-long-ago-taken-latest');
      expect(result?.injectionSite, 'right-abdomen');
    });
  });
}
