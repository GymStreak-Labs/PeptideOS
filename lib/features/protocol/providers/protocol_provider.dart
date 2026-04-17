import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/dose_log_repository.dart';
import '../../../data/repositories/protocol_repository.dart';
import '../../../models/dose_log.dart';
import '../../../models/protocol.dart';
import '../../../services/notification_service.dart';

/// Owns CRUD for [Protocol] plus generation of upcoming [DoseLog] entries.
///
/// Dose log generation runs whenever a protocol is created or the user taps
/// "refresh schedule" — it materialises the next [scheduleHorizonDays] days
/// of doses so the Today view can read from a single Firestore collection.
class ProtocolProvider extends ChangeNotifier {
  ProtocolProvider(
    this._protocolRepo,
    this._doseLogRepo, {
    required String uid,
  }) : _uid = uid {
    _subscribe();
  }

  final ProtocolRepository _protocolRepo;
  final DoseLogRepository _doseLogRepo;
  final _uuid = const Uuid();
  String _uid;
  StreamSubscription<List<Protocol>>? _sub;

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
  String get uid => _uid;

  void setUid(String uid) {
    if (_uid == uid) return;
    _uid = uid;
    _loading = true;
    _protocols = <Protocol>[];
    _subscribe();
  }

  void _subscribe() {
    _sub?.cancel();
    if (_uid.isEmpty) {
      _loading = false;
      notifyListeners();
      return;
    }
    _sub = _protocolRepo.watchAll(_uid).listen(
      (items) {
        _protocols = items;
        _loading = false;
        notifyListeners();
      },
      onError: (Object e, StackTrace st) {
        debugPrint('ProtocolProvider stream failed: $e');
        _loading = false;
        _protocols = <Protocol>[];
        notifyListeners();
      },
    );
  }

  Future<void> refresh() async {
    if (_uid.isEmpty) return;
    try {
      _protocols = await _protocolRepo.fetchAllOnce(_uid);
      _loading = false;
    } catch (e) {
      debugPrint('ProtocolProvider refresh failed: $e');
    }
    notifyListeners();
  }

  Future<Protocol> createProtocol({
    required String name,
    required DateTime startDate,
    required List<ProtocolPeptide> peptides,
  }) async {
    final now = DateTime.now();
    final p = Protocol(
      uuid: _uuid.v4(),
      name: name.isEmpty ? 'My Protocol' : name,
      startDate: startDate,
      status: ProtocolStatus.active,
      peptides: peptides,
      createdAt: now,
    );

    if (_uid.isEmpty) return p;
    try {
      await _protocolRepo.upsert(_uid, p);
      await _generateDoseLogs(p);
    } catch (e) {
      debugPrint('createProtocol failed: $e');
      rethrow;
    }
    return p;
  }

  Future<void> pauseProtocol(Protocol p) async {
    p.status = ProtocolStatus.paused;
    await _persist(p);
  }

  Future<void> resumeProtocol(Protocol p) async {
    p.status = ProtocolStatus.active;
    await _persist(p);
    await _generateDoseLogs(p);
  }

  Future<void> endProtocol(Protocol p) async {
    p.endDate = DateTime.now();
    p.status = ProtocolStatus.ended;
    await _persist(p);

    if (_uid.isEmpty) return;
    try {
      final now = DateTime.now();
      final logs = await _doseLogRepo.fetchByProtocol(_uid, p.uuid);
      final toDelete = <String>[];
      for (final d in logs) {
        if (d.takenAt == null &&
            !d.skipped &&
            d.scheduledAt.isAfter(now)) {
          toDelete.add(d.uuid);
          await NotificationService.instance.cancelDoseReminder(d.uuid);
        }
      }
      await _doseLogRepo.deleteMany(_uid, toDelete);
    } catch (e) {
      debugPrint('endProtocol cleanup failed: $e');
    }
  }

  Future<void> deleteProtocol(Protocol p) async {
    if (_uid.isEmpty) return;
    try {
      final logs = await _doseLogRepo.fetchByProtocol(_uid, p.uuid);
      for (final d in logs) {
        await NotificationService.instance.cancelDoseReminder(d.uuid);
      }
      await _doseLogRepo.deleteMany(_uid, logs.map((d) => d.uuid).toList());
      await _protocolRepo.delete(_uid, p.uuid);
    } catch (e) {
      debugPrint('deleteProtocol failed: $e');
    }
  }

  Future<void> _persist(Protocol p) async {
    if (_uid.isEmpty) return;
    try {
      await _protocolRepo.upsert(_uid, p);
    } catch (e) {
      debugPrint('Protocol persist failed: $e');
    }
  }

  /// Generate DoseLog rows for the next [scheduleHorizonDays] days from now.
  /// Existing (takenAt != null or skipped) logs are left untouched.
  Future<void> _generateDoseLogs(Protocol p) async {
    if (_uid.isEmpty) return;
    if (p.status != ProtocolStatus.active) return;

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: scheduleHorizonDays));

    final existing = await _doseLogRepo.fetchRange(_uid, start, end);
    final existingKeys = existing
        .where((d) => d.protocolUuid == p.uuid)
        .map((e) => '${e.protocolPeptideUuid}|${e.scheduledAt.toIso8601String()}')
        .toSet();

    final toInsert = <DoseLog>[];

    for (var day = 0; day < scheduleHorizonDays; day++) {
      final date = start.add(Duration(days: day));
      for (final pp in p.peptides) {
        if (!_isDosingDay(pp.frequency, p.startDate, date)) continue;
        final times = pp.scheduledTimes.isEmpty
            ? const ['08:00']
            : pp.scheduledTimes;
        for (final timeStr in times) {
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
              : pp.injectionSites[day % pp.injectionSites.length];

          toInsert.add(DoseLog(
            uuid: _uuid.v4(),
            protocolUuid: p.uuid,
            protocolPeptideUuid: pp.uuid,
            peptideName: pp.peptideName,
            scheduledAt: scheduledAt,
            amountTaken: pp.dosePerInjection,
            units: pp.doseUnit,
            injectionSite: site,
          ));
        }
      }
    }

    if (toInsert.isEmpty) return;
    try {
      await _doseLogRepo.upsertMany(_uid, toInsert);
      // Fire notifications for future doses only — respect user setting.
      for (final d in toInsert) {
        unawaited(NotificationService.instance.scheduleDoseReminder(d));
      }
    } catch (e) {
      debugPrint('generateDoseLogs failed: $e');
    }
  }

  bool _isDosingDay(String frequency, DateTime start, DateTime day) {
    switch (frequency) {
      case 'daily':
        return true;
      case 'eod':
        final diff =
            day.difference(DateTime(start.year, start.month, start.day)).inDays;
        return diff.isEven;
      case 'twice_weekly':
        return day.weekday == DateTime.monday || day.weekday == DateTime.thursday;
      case 'weekly':
        final diff =
            day.difference(DateTime(start.year, start.month, start.day)).inDays;
        return diff % 7 == 0;
      case 'as_needed':
      default:
        return false;
    }
  }

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
    return ProtocolPeptide(
      uuid: _uuid.v4(),
      peptideSlug: slug,
      peptideName: name,
      dosePerInjection: dose,
      doseUnit: unit,
      frequency: frequency,
      route: route,
      cycleWeeks: cycleWeeks,
      scheduledTimes: times ?? const ['08:00'],
      injectionSites: sites ?? const [],
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
