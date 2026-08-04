import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/features/protocol/widgets/log_dose_sheet.dart';
import 'package:peptide_os/models/dose_log.dart';
import 'package:peptide_os/models/protocol.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('dose sheet recalls the site for this peptide only', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final now = DateTime.now();
    final firestore = FakeFirebaseFirestore();
    final protocolRepository = ProtocolRepository(firestore: firestore);
    final doseRepository = DoseLogRepository(firestore: firestore);
    final protocol = Protocol(
      uuid: 'protocol',
      name: 'Recovery protocol',
      startDate: now.subtract(const Duration(days: 10)),
      status: ProtocolStatus.active,
      createdAt: now.subtract(const Duration(days: 10)),
      peptides: [
        ProtocolPeptide(
          uuid: 'peptide-a',
          peptideName: 'BPC-157',
          dosePerInjection: 250,
          doseUnit: 'mcg',
          frequency: 'daily',
        ),
        ProtocolPeptide(
          uuid: 'peptide-b',
          peptideName: 'TB-500',
          dosePerInjection: 2,
          doseUnit: 'mg',
          frequency: 'daily',
        ),
      ],
    );
    await protocolRepository.upsert('test-user', protocol);

    DoseLog dose({
      required String uuid,
      required String peptideUuid,
      required String peptideName,
      required DateTime scheduledAt,
      DateTime? takenAt,
      String site = '',
    }) => DoseLog(
      uuid: uuid,
      protocolUuid: protocol.uuid,
      protocolPeptideUuid: peptideUuid,
      peptideName: peptideName,
      scheduledAt: scheduledAt,
      takenAt: takenAt,
      amountTaken: peptideUuid == 'peptide-a' ? 250 : 2,
      units: peptideUuid == 'peptide-a' ? 'mcg' : 'mg',
      injectionSite: site,
    );

    final currentDose = dose(
      uuid: 'current-a',
      peptideUuid: 'peptide-a',
      peptideName: 'BPC-157',
      scheduledAt: now,
    );
    await doseRepository.upsertMany('test-user', [
      currentDose,
      dose(
        uuid: 'previous-a',
        peptideUuid: 'peptide-a',
        peptideName: 'BPC-157',
        scheduledAt: now.subtract(const Duration(days: 45)),
        takenAt: now.subtract(const Duration(days: 45)),
        site: 'left-thigh',
      ),
      dose(
        uuid: 'newer-b',
        peptideUuid: 'peptide-b',
        peptideName: 'TB-500',
        scheduledAt: now.subtract(const Duration(days: 1)),
        takenAt: now.subtract(const Duration(days: 1)),
        site: 'right-glute',
      ),
    ]);

    final protocolProvider = ProtocolProvider(
      protocolRepository,
      doseRepository,
      uid: 'test-user',
    );
    final doseProvider = DoseLogProvider(doseRepository, uid: 'test-user');
    addTearDown(protocolProvider.dispose);
    addTearDown(doseProvider.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: protocolProvider),
          ChangeNotifierProvider.value(value: doseProvider),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          home: Scaffold(body: LogDoseSheet(dose: currentDose)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('LAST SITE FOR THIS PEPTIDE · Left Thigh'),
      findsOneWidget,
    );
    expect(find.text('LAST SITE FOR THIS PEPTIDE · Right Glute'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
