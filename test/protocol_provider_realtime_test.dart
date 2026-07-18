import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/models/dose_log.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
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
