import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/features/protocol/screens/active_protocol_detail_screen.dart';
import 'package:peptide_os/models/protocol.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firestore = FakeFirebaseFirestore();
  final protocolRepository = ProtocolRepository(firestore: firestore);
  final doseRepository = DoseLogRepository(firestore: firestore);
  final start = DateTime.now().subtract(const Duration(days: 9));
  final protocol = Protocol(
    uuid: 'protocol-phases',
    name: 'Recovery Tracking',
    startDate: DateTime(start.year, start.month, start.day),
    status: ProtocolStatus.active,
    createdAt: start,
    peptides: [
      ProtocolPeptide(
        uuid: 'peptide-1',
        peptideName: 'Custom peptide',
        dosePerInjection: 100,
        doseUnit: 'mcg',
        frequency: 'daily',
        cycleWeeks: 8,
        phases: [
          ProtocolPhase(
            uuid: 'phase-1',
            name: 'Baseline tracking',
            startWeek: 1,
            endWeek: 1,
            dosePerInjection: 100,
            doseUnit: 'mcg',
            frequency: 'daily',
            scheduledTimes: const ['08:00'],
            note: 'Record how the first week fits the existing routine.',
          ),
          ProtocolPhase(
            uuid: 'phase-2',
            name: 'Schedule checkpoint',
            startWeek: 2,
            endWeek: 4,
            dosePerInjection: 125,
            doseUnit: 'mcg',
            frequency: 'eod',
            scheduledTimes: const ['19:30'],
            note: 'User-entered plan; review before making changes.',
          ),
        ],
      ),
    ],
  );
  await protocolRepository.upsert('preview-user', protocol);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProtocolProvider(
            protocolRepository,
            doseRepository,
            uid: 'preview-user',
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DoseLogProvider(doseRepository, uid: 'preview-user'),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: ActiveProtocolDetailScreen(protocol: protocol),
      ),
    ),
  );
}
