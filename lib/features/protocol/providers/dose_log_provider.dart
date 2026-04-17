import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/dose_log_repository.dart';
import '../../../models/dose_log.dart';

/// Reactive view over today + last-30-day dose logs. Reads from Firestore via
/// the repo; writes mutate the document and rely on the stream to notify.
class DoseLogProvider extends ChangeNotifier {
  DoseLogProvider(this._repo, {required String uid}) : _uid = uid {
    _subscribe();
  }

  final DoseLogRepository _repo;
  final _uuid = const Uuid();
  String _uid;

  StreamSubscription<List<DoseLog>>? _todaySub;
  StreamSubscription<List<DoseLog>>? _rangeSub;

  List<DoseLog> _today = <DoseLog>[];
  List<DoseLog> _recent30 = <DoseLog>[];
  bool _loading = true;

  List<DoseLog> get today => _today;
  List<DoseLog> get recent30 => _recent30;
  bool get isLoading => _loading;

  void setUid(String uid) {
    if (_uid == uid) return;
    _uid = uid;
    _loading = true;
    _today = <DoseLog>[];
    _recent30 = <DoseLog>[];
    _subscribe();
  }

  void _subscribe() {
    _todaySub?.cancel();
    _rangeSub?.cancel();
    if (_uid.isEmpty) {
      _loading = false;
      notifyListeners();
      return;
    }
    final now = DateTime.now();
    final startToday = DateTime(now.year, now.month, now.day);
    final endToday = startToday.add(const Duration(days: 1));
    final start30 = startToday.subtract(const Duration(days: 30));

    _todaySub = _repo.watchRange(_uid, startToday, endToday).listen(
      (items) {
        _today = items;
        _loading = false;
        notifyListeners();
      },
      onError: (Object e, StackTrace st) {
        debugPrint('DoseLogProvider today stream failed: $e');
        _today = <DoseLog>[];
        _loading = false;
        notifyListeners();
      },
    );
    _rangeSub = _repo.watchRange(_uid, start30, endToday).listen(
      (items) {
        _recent30 = items;
        notifyListeners();
      },
      onError: (Object e, StackTrace st) {
        debugPrint('DoseLogProvider 30d stream failed: $e');
        _recent30 = <DoseLog>[];
        notifyListeners();
      },
    );
  }

  Future<void> refresh() async {
    // Streams self-refresh — kept for API compatibility.
    notifyListeners();
  }

  // ── Stats ────────────────────────────────────────────────────────────────
  int get takenToday => _today.where((d) => d.isTaken).length;
  int get totalToday => _today.length;
  double get adherenceTodayPct {
    if (totalToday == 0) return 0;
    return (takenToday / totalToday) * 100;
  }

  double get adherence30dPct {
    final now = DateTime.now();
    final scheduled =
        _recent30.where((d) => d.scheduledAt.isBefore(now) && !d.skipped).length;
    if (scheduled == 0) return 0;
    final taken = _recent30.where((d) => d.isTaken).length;
    return (taken / scheduled) * 100;
  }

  int get currentStreak {
    final now = DateTime.now();
    final byDay = <DateTime, List<DoseLog>>{};
    for (final d in _recent30) {
      final day =
          DateTime(d.scheduledAt.year, d.scheduledAt.month, d.scheduledAt.day);
      byDay.putIfAbsent(day, () => []).add(d);
    }

    int streak = 0;
    var cursor = DateTime(now.year, now.month, now.day);
    while (true) {
      final doses = byDay[cursor];
      if (doses == null || doses.isEmpty) break;
      final everyTaken =
          doses.every((d) => d.isTaken || (!d.skipped && d.isPending));
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
    if (_uid.isEmpty) return;
    try {
      await _repo.upsert(_uid, dose);
    } catch (e) {
      debugPrint('doseLog save failed: $e');
    }
  }

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
    final dose = DoseLog(
      uuid: _uuid.v4(),
      protocolUuid: protocolUuid,
      protocolPeptideUuid: protocolPeptideUuid,
      peptideName: peptideName,
      scheduledAt: now,
      takenAt: now,
      amountTaken: amount,
      units: units,
      injectionSite: injectionSite,
      notes: notes,
    );
    await _save(dose);
  }

  @override
  void dispose() {
    _todaySub?.cancel();
    _rangeSub?.cancel();
    super.dispose();
  }
}
