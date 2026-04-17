import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/body_metric_repository.dart';
import '../../../models/body_metric.dart';

/// CRUD for body metrics (weight, body fat, circumference measurements).
class BodyMetricProvider extends ChangeNotifier {
  BodyMetricProvider(this._repo, {required String uid}) : _uid = uid {
    _subscribe();
  }

  final BodyMetricRepository _repo;
  final _uuid = const Uuid();
  String _uid;
  StreamSubscription<List<BodyMetric>>? _sub;

  List<BodyMetric> _entries = <BodyMetric>[];
  bool _loading = true;

  List<BodyMetric> get all => _entries;
  bool get isLoading => _loading;

  BodyMetric? get latest => _entries.isEmpty ? null : _entries.first;

  double? get latestWeightKg {
    for (final e in _entries) {
      if (e.weightKg != null) return e.weightKg;
    }
    return null;
  }

  void setUid(String uid) {
    if (_uid == uid) return;
    _uid = uid;
    _loading = true;
    _entries = <BodyMetric>[];
    _subscribe();
  }

  void _subscribe() {
    _sub?.cancel();
    if (_uid.isEmpty) {
      _loading = false;
      notifyListeners();
      return;
    }
    _sub = _repo.watchAll(_uid).listen(
      (items) {
        _entries = items;
        _loading = false;
        notifyListeners();
      },
      onError: (Object e, StackTrace st) {
        debugPrint('BodyMetricProvider stream failed: $e');
        _loading = false;
        notifyListeners();
      },
    );
  }

  Future<void> refresh() async {
    // Firestore streams auto-refresh; this is a no-op kept for API compatibility.
    notifyListeners();
  }

  Future<BodyMetric> logMetric({
    DateTime? date,
    double? weightKg,
    double? bodyFatPct,
    List<MeasurementEntry>? measurements,
    String notes = '',
  }) async {
    final entry = BodyMetric(
      uuid: _uuid.v4(),
      date: date ?? DateTime.now(),
      weightKg: weightKg,
      bodyFatPct: bodyFatPct,
      measurements: measurements ?? <MeasurementEntry>[],
      notes: notes,
    );

    if (_uid.isEmpty) return entry;
    try {
      await _repo.upsert(_uid, entry);
    } catch (e) {
      debugPrint('logMetric failed: $e');
    }
    return entry;
  }

  Future<void> deleteMetric(BodyMetric entry) async {
    if (_uid.isEmpty) return;
    try {
      await _repo.delete(_uid, entry.uuid);
    } catch (e) {
      debugPrint('deleteMetric failed: $e');
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
