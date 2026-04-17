/// A scheduled or completed peptide dose. Stored in Firestore at
/// `users/{uid}/doseLogs/{uuid}`.
class DoseLog {
  DoseLog({
    required this.uuid,
    required this.protocolUuid,
    required this.protocolPeptideUuid,
    required this.peptideName,
    required this.scheduledAt,
    required this.amountTaken,
    required this.units,
    this.takenAt,
    this.injectionSite = '',
    this.notes = '',
    this.skipped = false,
  });

  String uuid;
  String protocolUuid;
  String protocolPeptideUuid;

  /// Cached peptide name so the schedule list doesn't have to join through the
  /// protocol document to render.
  String peptideName;
  DateTime scheduledAt;
  DateTime? takenAt;
  double amountTaken;
  String units;
  String injectionSite;
  String notes;
  bool skipped;

  bool get isTaken => takenAt != null && !skipped;
  bool get isPending => takenAt == null && !skipped;

  /// True if the dose was scheduled for a past moment and hasn't been logged.
  bool isMissed(DateTime now) =>
      isPending && scheduledAt.isBefore(now.subtract(const Duration(hours: 3)));

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uuid': uuid,
        'protocolUuid': protocolUuid,
        'protocolPeptideUuid': protocolPeptideUuid,
        'peptideName': peptideName,
        'scheduledAt': scheduledAt.toIso8601String(),
        'takenAt': takenAt?.toIso8601String(),
        'amountTaken': amountTaken,
        'units': units,
        'injectionSite': injectionSite,
        'notes': notes,
        'skipped': skipped,
      };

  factory DoseLog.fromMap(String id, Map<String, dynamic> data) {
    return DoseLog(
      uuid: (data['uuid'] as String?) ?? id,
      protocolUuid: (data['protocolUuid'] as String?) ?? '',
      protocolPeptideUuid: (data['protocolPeptideUuid'] as String?) ?? '',
      peptideName: (data['peptideName'] as String?) ?? '',
      scheduledAt: _parseDate(data['scheduledAt']) ?? DateTime.now(),
      takenAt: _parseDate(data['takenAt']),
      amountTaken: (data['amountTaken'] as num?)?.toDouble() ?? 0,
      units: (data['units'] as String?) ?? 'mcg',
      injectionSite: (data['injectionSite'] as String?) ?? '',
      notes: (data['notes'] as String?) ?? '',
      skipped: (data['skipped'] as bool?) ?? false,
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
