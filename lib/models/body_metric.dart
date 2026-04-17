/// A body measurement log (weight, body fat %, circumference measurements).
/// Stored in Firestore at `users/{uid}/bodyMetrics/{uuid}`.
class BodyMetric {
  BodyMetric({
    required this.uuid,
    required this.date,
    this.weightKg,
    this.bodyFatPct,
    List<MeasurementEntry>? measurements,
    this.notes = '',
  }) : measurements = measurements ?? <MeasurementEntry>[];

  String uuid;
  DateTime date;
  double? weightKg;
  double? bodyFatPct;

  /// Optional circumference measurements, keyed by site (`waist`, `chest`,
  /// `arm`, etc.). Values are always centimetres — UI converts when needed.
  List<MeasurementEntry> measurements;
  String notes;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uuid': uuid,
        'date': date.toIso8601String(),
        'weightKg': weightKg,
        'bodyFatPct': bodyFatPct,
        'measurements': measurements.map((m) => m.toMap()).toList(),
        'notes': notes,
      };

  factory BodyMetric.fromMap(String id, Map<String, dynamic> data) {
    return BodyMetric(
      uuid: (data['uuid'] as String?) ?? id,
      date: _parseDate(data['date']) ?? DateTime.now(),
      weightKg: (data['weightKg'] as num?)?.toDouble(),
      bodyFatPct: (data['bodyFatPct'] as num?)?.toDouble(),
      measurements: (data['measurements'] as List<dynamic>? ?? const [])
          .map((e) => MeasurementEntry.fromMap(
              Map<String, dynamic>.from(e as Map<dynamic, dynamic>)))
          .toList(),
      notes: (data['notes'] as String?) ?? '',
    );
  }
}

class MeasurementEntry {
  MeasurementEntry({this.key = '', this.valueCm = 0});

  String key;
  double valueCm;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'key': key,
        'valueCm': valueCm,
      };

  factory MeasurementEntry.fromMap(Map<String, dynamic> data) {
    return MeasurementEntry(
      key: (data['key'] as String?) ?? '',
      valueCm: (data['valueCm'] as num?)?.toDouble() ?? 0,
    );
  }
}

DateTime? _parseDate(Object? raw) {
  if (raw == null) return null;
  if (raw is DateTime) return raw;
  if (raw is String) return DateTime.tryParse(raw);
  try {
    final dynamic d = raw;
    final result = d.toDate();
    if (result is DateTime) return result;
  } catch (_) {}
  return null;
}
