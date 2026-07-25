import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/features/protocol/screens/active_protocol_detail_screen.dart';
import 'package:peptide_os/models/protocol.dart';
import 'package:provider/provider.dart';

void main() {
  setUpAll(() async {
    await (FontLoader(
      'SpaceGrotesk',
    )..addFont(rootBundle.load('assets/fonts/SpaceGrotesk.ttf'))).load();
    await (FontLoader(
      'JetBrainsMono',
    )..addFont(rootBundle.load('assets/fonts/JetBrainsMono.ttf'))).load();
  });

  testWidgets('phase timeline is clear at a narrow phone size', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final firestore = FakeFirebaseFirestore();
    final protocolRepository = ProtocolRepository(firestore: firestore);
    final doseRepository = DoseLogRepository(firestore: firestore);
    final start = DateTime(2026, 7, 16);
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
    await protocolRepository.upsert('test-user', protocol);
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
          home: ActiveProtocolDetailScreen(
            protocol: protocol,
            timelineDate: DateTime(2026, 7, 25),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('PHASE.TIMELINE'));
    await tester.pumpAndSettle();

    expect(find.text('Baseline tracking'), findsOneWidget);
    expect(find.text('Schedule checkpoint'), findsOneWidget);
    expect(find.text('CURRENT'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/phased_protocol_timeline.png'),
    );

    await tester.tap(find.text('EDIT PROTOCOL'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Custom peptide').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('WEEK-TO-WEEK PHASES'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Schedule checkpoint'));
    await tester.pumpAndSettle();

    expect(find.text('Week-to-week override'), findsOneWidget);
    expect(find.text('SAVE PHASE'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/phased_protocol_editor.png'),
    );
  });
}
