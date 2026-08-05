import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/features/protocol/screens/active_protocol_detail_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/protocol.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('protocol notes round-trip and remain backward compatible', () {
    final protocol = _protocol(notes: 'Review sleep and recovery notes.');

    final restored = Protocol.fromMap(protocol.uuid, protocol.toMap());
    final legacy = Protocol.fromMap('legacy', {
      'name': 'Legacy protocol',
      'startDate': DateTime(2026, 1, 1).toIso8601String(),
      'status': 'active',
      'peptides': <Map<String, dynamic>>[],
      'createdAt': DateTime(2026, 1, 1).toIso8601String(),
    });

    expect(restored.notes, 'Review sleep and recovery notes.');
    expect(legacy.notes, isEmpty);
  });

  testWidgets(
    'manage view exposes protocol notes and upcoming phase checkpoints',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final firestore = FakeFirebaseFirestore();
      final protocolRepository = ProtocolRepository(firestore: firestore);
      final doseRepository = DoseLogRepository(firestore: firestore);
      final protocol = _protocol(
        notes: 'Track sleep quality and discuss questions at the next review.',
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
            locale: const Locale('de'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.dark,
            home: ActiveProtocolDetailScreen(
              protocol: protocol,
              timelineDate: DateTime(2026, 1, 2),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('NOTIZEN // PROTOKOLL'), findsOneWidget);
      expect(
        find.text(
          'Track sleep quality and discuss questions at the next review.',
        ),
        findsOneWidget,
      );

      await tester.ensureVisible(find.text('ÄNDERUNGSERINNERUNGEN'));
      await tester.pumpAndSettle();

      expect(find.text('ÄNDERUNGSERINNERUNGEN'), findsOneWidget);
      expect(find.text('BPC-157 · Schedule review'), findsOneWidget);
      expect(find.text('15. Jan. 2026 · 09:00'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}

Protocol _protocol({required String notes}) {
  return Protocol(
    uuid: 'protocol-notes',
    name: 'Recovery tracking',
    notes: notes,
    startDate: DateTime(2026, 1, 1),
    status: ProtocolStatus.active,
    createdAt: DateTime(2026, 1, 1),
    peptides: [
      ProtocolPeptide(
        uuid: 'bpc',
        peptideName: 'BPC-157',
        dosePerInjection: 250,
        doseUnit: 'mcg',
        frequency: 'daily',
        cycleWeeks: 8,
        phases: [
          ProtocolPhase(
            uuid: 'baseline',
            name: 'Baseline',
            startWeek: 1,
            endWeek: 2,
            dosePerInjection: 250,
            doseUnit: 'mcg',
            frequency: 'daily',
          ),
          ProtocolPhase(
            uuid: 'schedule-review',
            name: 'Schedule review',
            startWeek: 3,
            endWeek: 4,
            dosePerInjection: 250,
            doseUnit: 'mcg',
            frequency: 'daily',
          ),
        ],
      ),
    ],
  );
}
