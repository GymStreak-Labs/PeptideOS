import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../models/dose_log.dart';
import '../../../services/database_service.dart';

/// Reads + mutates DoseLog entries. The schedule generator lives in
/// ProtocolProvider — this class is purely about "what's on the board
/// right now, and how the user interacts with individual doses".
class DoseLogProvider extends ChangeNotifier {
  DoseLogProvider(this._db) {
    _load();
  }

  final DatabaseService _db;
  final _uuid = const Uuid();

  List<DoseLog> _today = <DoseLog>[];
  List<DoseLog> _recent30 = <DoseLog>[]; // last 30 days, for charts
  bool _loading = true;

  List<DoseLog> get today => _today;
  List<DoseLog> get recent30 => _recent30;
  bool get isLoading => _loading;

  Future<void> _load() async {
    final now = DateTime.now();
    final startToday = DateTime(now.year, now.month, now.day);
    final endToday = startToday.add(const Duration(days: 1));
    final start30 = startToday.subtract(const Duration(days: 30));

    try {
      _today = await _db.doseLogs
          .filter()
          .scheduledAtBetween(startToday, endToday)
          .sortByScheduledAt()
          .findAll();
      _recent30 = await _db.doseLogs
          .filter()
          .scheduledAtBetween(start30, endToday)
          .sortByScheduledAt()
          .findAll();
    } catch (e) {
      debugPrint('DoseLogProvider load failed: $e');
      _today = [];
      _recent30 = [];
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() => _load();

  // ── Stats ────────────────────────────────────────────────────────────────
  int get takenToday => _today.where((d) => d.isTaken).length;
  int get totalToday => _today.length;
  double get adherenceTodayPct {
    if (totalToday == 0) return 0;
    return (takenToday / totalToday) * 100;
  }

  /// Adherence over the last 30 days (excludes skipped, excludes future).
  double get adherence30dPct {
    final now = DateTime.now();
    final scheduled =
        _recent30.where((d) => d.scheduledAt.isBefore(now) && !d.skipped).length;
    if (scheduled == 0) return 0;
    final taken = _recent30.where((d) => d.isTaken).length;
    return (taken / scheduled) * 100;
  }

  /// Consecutive days (ending today) where adherence was >= 100%.
  int get currentStreak {
    final now = DateTime.now();
    final byDay = <DateTime, List<DoseLog>>{};
    for (final d in _recent30) {
      final day = DateTime(d.scheduledAt.year, d.scheduledAt.month, d.scheduledAt.day);
      byDay.putIfAbsent(day, () => []).add(d);
    }

    int streak = 0;
    var cursor = DateTime(now.year, now.month, now.day);
    while (true) {
      final doses = byDay[cursor];
      if (doses == null || doses.isEmpty) break;
      final everyTaken = doses.every((d) => d.isTaken || d.skipped == false && d.isPending);
      // A day counts toward the streak only if every scheduled dose was taken.
      final taken = doses.every((d) => d.isTaken);
      if (!everyTaken || !taken) break;
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  int get totalLogged => _recent30.where((d) => d.isTaken).length;

  // ── Mutations ────────────────────────────────────────────────────────────
  Future<void> logDose(
    DoseLog dose, {
    DateTime? takenAt,
    double? amount,
    String? site,
    String? notes,
  }) async {
    dose.takenAt = takenAt ?? DateTime.now();
    dose.skipped = false;
    if (amount != null) dose.amountTaken = amount;
    if (site != null) dose.injectionSite = site;
    if (notes != null) dose.notes = notes;
    await _save(dose);
  }

  Future<void> skipDose(DoseLog dose, {String? notes}) async {
    dose.skipped = true;
    dose.takenAt = null;
    if (notes != null) dose.notes = notes;
    await _save(dose);
  }

  Future<void> undoDose(DoseLog dose) async {
    dose.takenAt = null;
    dose.skipped = false;
    await _save(dose);
  }

  Future<void> _save(DoseLog dose) async {
    try {
      await _db.isar.writeTxn(() async {
        await _db.doseLogs.put(dose);
      });
      await _load();
    } catch (e) {
      debugPrint('doseLog save failed: $e');
    }
  }

  /// Log an ad-hoc dose that wasn't on the schedule (e.g., "as needed" peptides).
  Future<void> logAdHoc({
    required String protocolUuid,
    required String protocolPeptideUuid,
    required String peptideName,
    required double amount,
    required String units,
    String injectionSite = '',
    String notes = '',
  }) async {
    final now = DateTime.now();
    final dose = DoseLog()
      ..uuid = _uuid.v4()
      ..protocolUuid = protocolUuid
      ..protocolPeptideUuid = protocolPeptideUuid
      ..peptideName = peptideName
      ..scheduledAt = now
      ..takenAt = now
      ..amountTaken = amount
      ..units = units
      ..injectionSite = injectionSite
      ..notes = notes;
    await _save(dose);
  }
}
