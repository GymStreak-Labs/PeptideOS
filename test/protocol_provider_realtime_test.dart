import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/models/blend_vial.dart';
import 'package:peptide_os/models/dose_log.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'pausing a protocol updates history before persistence completes',
    () async {
      final protocolRepository = _ProtocolDataSource();
      final provider = ProtocolProvider(
        protocolRepository,
        _DoseLogDataSource(),
        uid: 'user-1',
      );
      addTearDown(provider.dispose);
      addTearDown(protocolRepository.dispose);

      final protocol = Protocol(
        uuid: 'protocol-1',
        name: 'Recovery',
        startDate: DateTime(2026, 7, 1),
        status: ProtocolStatus.active,
        peptides: const [],
        createdAt: DateTime(2026, 7, 1),
      );
      protocolRepository.emit([protocol]);
      await Future<void>.delayed(Duration.zero);

      var notifications = 0;
      provider.addListener(() => notifications++);

      final pause = provider.pauseProtocol(protocol);

      expect(protocolRepository.upsertStarted, isTrue);
      expect(protocolRepository.upsertCompleted, isFalse);
      expect(provider.history, [protocol]);
      expect(notifications, 1);

      protocolRepository.completeUpsert();
      await pause;
    },
  );

  test(
    'dose logging updates local status before persistence completes',
    () async {
      final repository = _DelayedDoseLogDataSource();
      final provider = DoseLogProvider(repository, uid: 'user-1');
      addTearDown(provider.dispose);
      addTearDown(repository.dispose);
      final now = DateTime.now();
      final dose = DoseLog(
        uuid: 'dose-1',
        protocolUuid: 'protocol-1',
        protocolPeptideUuid: 'peptide-1',
        peptideName: 'BPC-157',
        scheduledAt: DateTime(now.year, now.month, now.day, 8),
        amountTaken: 250,
        units: 'mcg',
      );
      repository.emit([dose]);
      await Future<void>.delayed(Duration.zero);

      final save = provider.logDose(dose, takenAt: now);

      expect(repository.upsertStarted, isTrue);
      expect(provider.today.single.isTaken, isTrue);
      repository.completeUpsert();
      await save;
    },
  );

  test(
    'blend logging edits draw units without replacing peptide amount',
    () async {
      final repository = _DelayedDoseLogDataSource();
      final provider = DoseLogProvider(repository, uid: 'user-1');
      addTearDown(provider.dispose);
      addTearDown(repository.dispose);
      final now = DateTime.now();
      final dose = DoseLog(
        uuid: 'blend-dose',
        protocolUuid: 'protocol-1',
        protocolPeptideUuid: 'blend-1',
        peptideName: 'Blend',
        scheduledAt: DateTime(now.year, now.month, now.day, 8),
        amountTaken: 250,
        units: 'mcg',
        syringeUnits: 10,
        blendSnapshot: BlendVial(
          diluentMl: 2,
          drawSyringeUnits: 10,
          constituents: [
            BlendConstituent(name: 'BPC-157', vialAmount: 5, unit: 'mg'),
            BlendConstituent(name: 'TB-500', vialAmount: 5, unit: 'mg'),
          ],
        ),
      );
      repository.emit([dose]);
      await Future<void>.delayed(Duration.zero);

      final save = provider.logDose(dose, takenAt: now, amount: 12);

      final updated = provider.today.single;
      expect(updated.amountTaken, 250);
      expect(updated.syringeUnits, 12);
      expect(updated.blendSnapshot?.drawSyringeUnits, 12);
      repository.completeUpsert();
      await save;
    },
  );
}

class _ProtocolDataSource implements ProtocolDataSource {
  final _controller = StreamController<List<Protocol>>.broadcast();
  final _upsertCompleter = Completer<void>();

  bool upsertStarted = false;
  bool get upsertCompleted => _upsertCompleter.isCompleted;

  void emit(List<Protocol> protocols) => _controller.add(protocols);
  void completeUpsert() => _upsertCompleter.complete();
  void dispose() => _controller.close();

  @override
  Stream<List<Protocol>> watchAll(String uid) => _controller.stream;

  @override
  Future<List<Protocol>> fetchAllOnce(String uid) async => const [];

  @override
  Future<void> upsert(String uid, Protocol protocol) {
    upsertStarted = true;
    return _upsertCompleter.future;
  }

  @override
  Future<void> delete(String uid, String protocolUuid) async {}
}

class _DoseLogDataSource implements DoseLogDataSource {
  @override
  Future<DoseLog?> fetchLatestInjectionForPeptide(
    String uid, {
    required String protocolPeptideUuid,
    String? excludingDoseUuid,
  }) async => null;

  @override
  Stream<List<DoseLog>> watchRange(String uid, DateTime start, DateTime end) =>
      const Stream.empty();

  @override
  Future<List<DoseLog>> fetchRange(
    String uid,
    DateTime start,
    DateTime end,
  ) async => const [];

  @override
  Future<List<DoseLog>> fetchByProtocol(
    String uid,
    String protocolUuid,
  ) async => const [];

  @override
  Future<void> upsert(String uid, DoseLog log) async {}

  @override
  Future<void> upsertMany(String uid, List<DoseLog> logs) async {}

  @override
  Future<void> delete(String uid, String uuid) async {}

  @override
  Future<void> deleteMany(String uid, List<String> uuids) async {}
}

class _DelayedDoseLogDataSource implements DoseLogDataSource {
  final _controller = StreamController<List<DoseLog>>.broadcast();
  final _upsertCompleter = Completer<void>();
  bool upsertStarted = false;

  void emit(List<DoseLog> logs) => _controller.add(logs);
  void completeUpsert() => _upsertCompleter.complete();
  void dispose() => _controller.close();

  @override
  Stream<List<DoseLog>> watchRange(String uid, DateTime start, DateTime end) =>
      _controller.stream;

  @override
  Future<void> upsert(String uid, DoseLog log) {
    upsertStarted = true;
    return _upsertCompleter.future;
  }

  @override
  Future<List<DoseLog>> fetchRange(
    String uid,
    DateTime start,
    DateTime end,
  ) async => const [];

  @override
  Future<List<DoseLog>> fetchByProtocol(
    String uid,
    String protocolUuid,
  ) async => const [];

  @override
  Future<DoseLog?> fetchLatestInjectionForPeptide(
    String uid, {
    required String protocolPeptideUuid,
    String? excludingDoseUuid,
  }) async => null;

  @override
  Future<void> upsertMany(String uid, List<DoseLog> logs) async {}

  @override
  Future<void> delete(String uid, String uuid) async {}

  @override
  Future<void> deleteMany(String uid, List<String> uuids) async {}
}
