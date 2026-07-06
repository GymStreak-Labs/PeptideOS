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
    bool notificationsEnabled = false,
  }) : _uid = uid,
       _notificationsEnabled = notificationsEnabled {
    _subscribe();
  }

  final ProtocolRepository _protocolRepo;
  final DoseLogRepository _doseLogRepo;
  final _uuid = const Uuid();
  String _uid;
  bool _notificationsEnabled;
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

  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
  }

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
    _sub = _protocolRepo
        .watchAll(_uid)
        .listen(
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
      await _rescheduleProtocolReminders(p);
    } catch (e) {
      debugPrint('createProtocol failed: $e');
      rethrow;
    }
    return p;
  }

  Future<void> updateProtocol({
    required Protocol protocol,
    required String name,
    required DateTime startDate,
    required List<ProtocolPeptide> peptides,
  }) async {
    if (_uid.isEmpty) return;

    await NotificationService.instance.cancelProtocolRemindersForProtocol(
      protocol,
    );

    protocol
      ..name = name.isEmpty ? 'My Protocol' : name
      ..startDate = startDate
      ..peptides = peptides;

    try {
      await _protocolRepo.upsert(_uid, protocol);
      await _deleteFuturePendingDoseLogs(protocol);
      await _generateDoseLogs(protocol);
      await _rescheduleProtocolReminders(protocol);
    } catch (e) {
      debugPrint('updateProtocol failed: $e');
      rethrow;
    }
  }

  Future<void> pauseProtocol(Protocol p) async {
    p.status = ProtocolStatus.paused;
    await _persist(p);
    await NotificationService.instance.cancelProtocolRemindersForProtocol(p);
  }

  Future<void> resumeProtocol(Protocol p) async {
    p.status = ProtocolStatus.active;
    await _persist(p);
    await _generateDoseLogs(p);
    await _rescheduleProtocolReminders(p);
  }

  Future<void> endProtocol(Protocol p) async {
    p.endDate = DateTime.now();
    p.status = ProtocolStatus.ended;
    await _persist(p);
    await NotificationService.instance.cancelProtocolRemindersForProtocol(p);

    if (_uid.isEmpty) return;
    try {
      final now = DateTime.now();
      final logs = await _doseLogRepo.fetchByProtocol(_uid, p.uuid);
      final toDelete = <String>[];
      for (final d in logs) {
        if (d.takenAt == null && !d.skipped && d.scheduledAt.isAfter(now)) {
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
      await NotificationService.instance.cancelProtocolRemindersForProtocol(p);
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

  Future<void> syncDoseReminders({required bool enabled}) async {
    _notificationsEnabled = enabled;
    if (_uid.isEmpty) return;

    try {
      if (enabled) {
        await regenerateSchedules();
      }

      final now = DateTime.now();
      final futurePending = <DoseLog>[];
      for (final p in active) {
        final logs = await _doseLogRepo.fetchByProtocol(_uid, p.uuid);
        futurePending.addAll(
          logs.where((d) => d.isPending && d.scheduledAt.isAfter(now)),
        );
      }

      for (final d in futurePending) {
        if (enabled) {
          await NotificationService.instance.scheduleDoseReminder(d);
        } else {
          await NotificationService.instance.cancelDoseReminder(d.uuid);
        }
      }
    } catch (e) {
      debugPrint('syncDoseReminders failed: $e');
    }
  }

  Future<void> _deleteFuturePendingDoseLogs(Protocol p) async {
    if (_uid.isEmpty) return;
    final now = DateTime.now();
    final logs = await _doseLogRepo.fetchByProtocol(_uid, p.uuid);
    final toDelete = <String>[];
    for (final d in logs) {
      if (d.takenAt == null && !d.skipped && d.scheduledAt.isAfter(now)) {
        toDelete.add(d.uuid);
        await NotificationService.instance.cancelDoseReminder(d.uuid);
      }
    }
    await _doseLogRepo.deleteMany(_uid, toDelete);
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
        .map(
          (e) => '${e.protocolPeptideUuid}|${e.scheduledAt.toIso8601String()}',
        )
        .toSet();

    final toInsert = <DoseLog>[];

    for (var day = 0; day < scheduleHorizonDays; day++) {
      final date = start.add(Duration(days: day));
      for (final pp in p.peptides) {
        final schedule = pp.scheduleForDate(
          protocolStart: p.startDate,
          date: date,
        );
        if (schedule == null) continue;

        for (final timeStr in schedule.scheduledTimes) {
          final parts = timeStr.split(':');
          if (parts.length != 2) continue;
          final hour = int.tryParse(parts[0]) ?? 8;
          final minute = int.tryParse(parts[1]) ?? 0;
          final scheduledAt = DateTime(
            date.year,
            date.month,
            date.day,
            hour,
            minute,
          );
          final key = '${pp.uuid}|${scheduledAt.toIso8601String()}';
          if (existingKeys.contains(key)) continue;

          final site = pp.injectionSites.isEmpty
              ? ''
              : pp.injectionSites[day % pp.injectionSites.length];

          toInsert.add(
            DoseLog(
              uuid: _uuid.v4(),
              protocolUuid: p.uuid,
              protocolPeptideUuid: pp.uuid,
              peptideName: pp.peptideName,
              scheduledAt: scheduledAt,
              amountTaken: schedule.dosePerInjection,
              units: schedule.doseUnit,
              syringeUnits: schedule.syringeUnits,
              injectionSite: site,
            ),
          );
        }
      }
    }

    if (toInsert.isEmpty) return;
    try {
      await _doseLogRepo.upsertMany(_uid, toInsert);
      // Fire notifications for future doses only — respect user setting.
      if (_notificationsEnabled) {
        for (final d in toInsert) {
          unawaited(NotificationService.instance.scheduleDoseReminder(d));
        }
      }
    } catch (e) {
      debugPrint('generateDoseLogs failed: $e');
    }
  }

  Future<void> regenerateSchedules() async {
    for (final p in active) {
      await _generateDoseLogs(p);
      await _rescheduleProtocolReminders(p);
    }
  }

  Future<void> _rescheduleProtocolReminders(Protocol p) async {
    if (p.status != ProtocolStatus.active) return;
    await NotificationService.instance.cancelProtocolRemindersForProtocol(p);
    for (final peptide in p.peptides) {
      final cycleEnd = peptide.cycleEndDate(p.startDate);
      if (cycleEnd == null) continue;
      await NotificationService.instance.scheduleProtocolReminder(
        protocolUuid: p.uuid,
        protocolPeptideUuid: peptide.uuid,
        peptideName: peptide.peptideName,
        kind: ProtocolReminderKind.cycleEnds,
        scheduledAt: DateTime(cycleEnd.year, cycleEnd.month, cycleEnd.day, 9),
      );

      final washoutEnd = peptide.washoutEndDate(p.startDate);
      if (washoutEnd == null || washoutEnd == cycleEnd) continue;
      await NotificationService.instance.scheduleProtocolReminder(
        protocolUuid: p.uuid,
        protocolPeptideUuid: peptide.uuid,
        peptideName: peptide.peptideName,
        kind: ProtocolReminderKind.washoutEnds,
        scheduledAt: DateTime(
          washoutEnd.year,
          washoutEnd.month,
          washoutEnd.day,
          9,
        ),
      );
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
    int washoutWeeks = 0,
    double syringeUnits = 0,
    List<String>? times,
    List<String>? sites,
    List<ProtocolWeekdayDose>? weekdayDoses,
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
      washoutWeeks: washoutWeeks,
      syringeUnits: syringeUnits,
      scheduledTimes: times ?? const ['08:00'],
      injectionSites: sites ?? const [],
      weekdayDoses: weekdayDoses ?? const [],
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
