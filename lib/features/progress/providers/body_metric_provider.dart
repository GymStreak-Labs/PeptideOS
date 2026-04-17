import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../models/body_metric.dart';
import '../../../services/database_service.dart';

/// CRUD for body metrics (weight, body fat, circumference measurements).
class BodyMetricProvider extends ChangeNotifier {
  BodyMetricProvider(this._db) {
    _load();
  }

  final DatabaseService _db;
  final _uuid = const Uuid();

  List<BodyMetric> _entries = <BodyMetric>[];
  bool _loading = true;

  List<BodyMetric> get all => _entries;
  bool get isLoading => _loading;

  BodyMetric? get latest => _entries.isEmpty ? null : _entries.first;

  /// Most recent weight entry (in kg).
  double? get latestWeightKg {
    for (final e in _entries) {
      if (e.weightKg != null) return e.weightKg;
    }
    return null;
  }

  Future<void> _load() async {
    try {
      _entries = await _db.bodyMetrics
          .filter()
          .dateGreaterThan(DateTime.fromMillisecondsSinceEpoch(0))
          .sortByDateDesc()
          .findAll();
    } catch (e) {
      debugPrint('BodyMetricProvider load failed: $e');
      _entries = [];
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() => _load();

  Future<BodyMetric> logMetric({
    DateTime? date,
    double? weightKg,
    double? bodyFatPct,
    List<MeasurementEntry>? measurements,
    String notes = '',
  }) async {
    final entry = BodyMetric()
      ..uuid = _uuid.v4()
      ..date = date ?? DateTime.now()
      ..weightKg = weightKg
      ..bodyFatPct = bodyFatPct
      ..measurements = measurements ?? <MeasurementEntry>[]
      ..notes = notes;

    try {
      await _db.isar.writeTxn(() async {
        await _db.bodyMetrics.put(entry);
      });
      await _load();
    } catch (e) {
      debugPrint('logMetric failed: $e');
    }
    return entry;
  }

  Future<void> deleteMetric(BodyMetric entry) async {
    try {
      await _db.isar.writeTxn(() async {
        await _db.bodyMetrics.delete(entry.id);
      });
      await _load();
    } catch (e) {
      debugPrint('deleteMetric failed: $e');
    }
  }
}
