import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../models/dose_log.dart';
import '../../../models/protocol.dart';
import '../../../services/database_service.dart';

/// Owns CRUD for [Protocol] plus generation of upcoming [DoseLog] entries.
///
/// Dose log generation runs whenever a protocol is created or the user taps
/// "refresh schedule" — it materialises the next [scheduleHorizonDays] days
/// of doses so the Today view can read from a single table.
class ProtocolProvider extends ChangeNotifier {
  ProtocolProvider(this._db) {
    _load();
  }

  final DatabaseService _db;
  final _uuid = const Uuid();

  /// How far ahead we pre-compute dose entries.
  static const int scheduleHorizonDays = 7;

  List<Protocol> _protocols = <Protocol>[];
  bool _loading = true;

  List<Protocol> get all => _protocols;
  List<Protocol> get active =>
      _protocols.where((p) => p.status == ProtocolStatus.active).toList();
  List<Protocol> get history =>
      _protocols.where((p) => p.status != ProtocolStatus.active).toList();
  bool get isLoading => _loading;
  bool get hasActive => active.isNotEmpty;

  Future<void> _load() async {
    try {
      _protocols =
          await _db.protocols.filter().nameIsNotEmpty().sortByCreatedAtDesc().findAll();
    } catch (e) {
      debugPrint('ProtocolProvider load failed: $e');
      _protocols = [];
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() => _load();

  /// Creates and persists a new protocol, then generates its dose logs.
  Future<Protocol> createProtocol({
    required String name,
    required DateTime startDate,
    required List<ProtocolPeptide> peptides,
  }) async {
    final now = DateTime.now();
    final uuid = _uuid.v4();
    final p = Protocol()
      ..uuid = uuid
      ..name = name.isEmpty ? 'My Protocol' : name
      ..startDate = startDate
      ..status = ProtocolStatus.active
      ..peptides = peptides
      ..createdAt = now;

    try {
      await _db.isar.writeTxn(() async {
        await _db.protocols.put(p);
      });
      await _generateDoseLogs(p);
      await _load();
    } catch (e) {
      debugPrint('createProtocol failed: $e');
      rethrow;
    }
    return p;
  }

  /// Pause an active protocol (no new doses generated, existing ones kept).
  Future<void> pauseProtocol(Protocol p) async {
    await _writeStatus(p, ProtocolStatus.paused);
  }

  Future<void> resumeProtocol(Protocol p) async {
    await _writeStatus(p, ProtocolStatus.active);
    await _generateDoseLogs(p);
  }

  Future<void> endProtocol(Protocol p) async {
    p.endDate = DateTime.now();
    await _writeStatus(p, ProtocolStatus.ended);
    // Remove any future scheduled (unlogged) doses — past logs remain for history.
    try {
      final now = DateTime.now();
      final future = await _db.doseLogs
          .filter()
          .protocolUuidEqualTo(p.uuid)
          .skippedEqualTo(false)
          .takenAtIsNull()
          .scheduledAtGreaterThan(now)
          .findAll();
      await _db.isar.writeTxn(() async {
        for (final d in future) {
          await _db.doseLogs.delete(d.id);
        }
      });
    } catch (e) {
      debugPrint('endProtocol cleanup failed: $e');
    }
  }

  Future<void> deleteProtocol(Protocol p) async {
    try {
      final logs = await _db.doseLogs
          .filter()
          .protocolUuidEqualTo(p.uuid)
          .findAll();
      await _db.isar.writeTxn(() async {
        for (final d in logs) {
          await _db.doseLogs.delete(d.id);
        }
        await _db.protocols.delete(p.id);
      });
      await _load();
    } catch (e) {
      debugPrint('deleteProtocol failed: $e');
    }
  }

  Future<void> _writeStatus(Protocol p, ProtocolStatus status) async {
    p.status = status;
    try {
      await _db.isar.writeTxn(() async {
        await _db.protocols.put(p);
      });
      await _load();
    } catch (e) {
      debugPrint('status write failed: $e');
    }
  }

  /// Generate DoseLog rows for the next [scheduleHorizonDays] days from now.
  /// Existing (takenAt != null or skipped) logs are left untouched.
  Future<void> _generateDoseLogs(Protocol p) async {
    if (p.status != ProtocolStatus.active) return;

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: scheduleHorizonDays));

    final existing = await _db.doseLogs
        .filter()
        .protocolUuidEqualTo(p.uuid)
        .scheduledAtBetween(start, end)
        .findAll();
    final existingKeys = existing
        .map((e) => '${e.protocolPeptideUuid}|${e.scheduledAt.toIso8601String()}')
        .toSet();

    final toInsert = <DoseLog>[];

    for (var day = 0; day < scheduleHorizonDays; day++) {
      final date = start.add(Duration(days: day));
      for (final pp in p.peptides) {
        if (!_isDosingDay(pp.frequency, p.startDate, date)) continue;
        for (final timeStr in pp.scheduledTimes.isEmpty
            ? const ['08:00']
            : pp.scheduledTimes) {
          final parts = timeStr.split(':');
          if (parts.length != 2) continue;
          final hour = int.tryParse(parts[0]) ?? 8;
          final minute = int.tryParse(parts[1]) ?? 0;
          final scheduledAt =
              DateTime(date.year, date.month, date.day, hour, minute);
          final key = '${pp.uuid}|${scheduledAt.toIso8601String()}';
          if (existingKeys.contains(key)) continue;

          final site = pp.injectionSites.isEmpty
              ? ''
              : pp.injectionSites[(day) % pp.injectionSites.length];

          toInsert.add(
            DoseLog()
              ..uuid = _uuid.v4()
              ..protocolUuid = p.uuid
              ..protocolPeptideUuid = pp.uuid
              ..peptideName = pp.peptideName
              ..scheduledAt = scheduledAt
              ..amountTaken = pp.dosePerInjection
              ..units = pp.doseUnit
              ..injectionSite = site,
          );
        }
      }
    }

    if (toInsert.isEmpty) return;
    try {
      await _db.isar.writeTxn(() async {
        await _db.doseLogs.putAll(toInsert);
      });
    } catch (e) {
      debugPrint('generateDoseLogs failed: $e');
    }
  }

  bool _isDosingDay(String frequency, DateTime start, DateTime day) {
    switch (frequency) {
      case 'daily':
        return true;
      case 'eod':
        final diff = day.difference(DateTime(start.year, start.month, start.day)).inDays;
        return diff.isEven;
      case 'twice_weekly':
        // Mon & Thu (1 & 4). Adjustable in future.
        return day.weekday == DateTime.monday || day.weekday == DateTime.thursday;
      case 'weekly':
        final diff = day.difference(DateTime(start.year, start.month, start.day)).inDays;
        return diff % 7 == 0;
      case 'as_needed':
      default:
        return false;
    }
  }

  /// Re-generate dose logs for all active protocols — call after significant
  /// changes (e.g. opening the app after a long gap).
  Future<void> regenerateSchedules() async {
    for (final p in active) {
      await _generateDoseLogs(p);
    }
  }

  /// Convenience — build a ProtocolPeptide with a fresh UUID.
  ProtocolPeptide buildPeptide({
    required String slug,
    required String name,
    required double dose,
    String unit = 'mcg',
    String frequency = 'daily',
    String route = 'subcutaneous',
    int cycleWeeks = 0,
    List<String>? times,
    List<String>? sites,
  }) {
    return ProtocolPeptide()
      ..uuid = _uuid.v4()
      ..peptideSlug = slug
      ..peptideName = name
      ..dosePerInjection = dose
      ..doseUnit = unit
      ..frequency = frequency
      ..route = route
      ..cycleWeeks = cycleWeeks
      ..scheduledTimes = times ?? ['08:00']
      ..injectionSites = sites ?? [];
  }
}
