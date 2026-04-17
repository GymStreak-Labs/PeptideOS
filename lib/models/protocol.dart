/// Lifecycle status of a protocol.
enum ProtocolStatus { active, paused, ended }

/// A named multi-peptide regimen tracked by the user. Stored in Firestore at
/// `users/{uid}/protocols/{uuid}`.
class Protocol {
  Protocol({
    required this.uuid,
    required this.name,
    required this.startDate,
    required this.status,
    required this.peptides,
    required this.createdAt,
    this.endDate,
  });

  /// Stable UUID string — used as the Firestore doc ID and referenced from
  /// dose logs. Keeps IDs opaque so they survive any future migrations.
  String uuid;
  String name;
  DateTime startDate;
  DateTime? endDate;
  ProtocolStatus status;

  /// Embedded peptide entries (one per peptide in this protocol). Stored as a
  /// nested array on the protocol document — matches the UI usage and keeps
  /// a single document read per protocol.
  List<ProtocolPeptide> peptides;
  DateTime createdAt;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uuid': uuid,
        'name': name,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'status': status.name,
        'peptides': peptides.map((p) => p.toMap()).toList(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory Protocol.fromMap(String id, Map<String, dynamic> data) {
    return Protocol(
      uuid: (data['uuid'] as String?) ?? id,
      name: (data['name'] as String?) ?? 'My Protocol',
      startDate: _parseDate(data['startDate']) ?? DateTime.now(),
      endDate: _parseDate(data['endDate']),
      status: _parseStatus(data['status'] as String?),
      peptides: (data['peptides'] as List<dynamic>? ?? const [])
          .map((e) => ProtocolPeptide.fromMap(
              Map<String, dynamic>.from(e as Map<dynamic, dynamic>)))
          .toList(),
      createdAt: _parseDate(data['createdAt']) ?? DateTime.now(),
    );
  }

  static ProtocolStatus _parseStatus(String? raw) {
    for (final s in ProtocolStatus.values) {
      if (s.name == raw) return s;
    }
    return ProtocolStatus.active;
  }
}

DateTime? _parseDate(Object? raw) {
  if (raw == null) return null;
  if (raw is DateTime) return raw;
  if (raw is String) return DateTime.tryParse(raw);
  // Firestore Timestamp arrives as a dynamic object with toDate() — handle via
  // dynamic dispatch without importing cloud_firestore in the model layer.
  try {
    final dynamic d = raw;
    final result = d.toDate();
    if (result is DateTime) return result;
  } catch (_) {}
  return null;
}

/// A single peptide within a protocol — dose, frequency, cycle info.
class ProtocolPeptide {
  ProtocolPeptide({
    this.uuid = '',
    this.peptideSlug = '',
    this.peptideName = '',
    this.dosePerInjection = 0,
    this.doseUnit = 'mcg',
    this.frequency = 'daily',
    this.route = 'subcutaneous',
    this.cycleWeeks = 0,
    List<String>? injectionSites,
    List<String>? scheduledTimes,
  })  : injectionSites = injectionSites ?? <String>[],
        scheduledTimes = scheduledTimes ?? <String>['08:00'];

  String uuid;
  String peptideSlug;
  String peptideName;
  double dosePerInjection;
  String doseUnit;
  String frequency;
  String route;
  int cycleWeeks;
  List<String> injectionSites;
  List<String> scheduledTimes;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uuid': uuid,
        'peptideSlug': peptideSlug,
        'peptideName': peptideName,
        'dosePerInjection': dosePerInjection,
        'doseUnit': doseUnit,
        'frequency': frequency,
        'route': route,
        'cycleWeeks': cycleWeeks,
        'injectionSites': injectionSites,
        'scheduledTimes': scheduledTimes,
      };

  factory ProtocolPeptide.fromMap(Map<String, dynamic> data) {
    return ProtocolPeptide(
      uuid: (data['uuid'] as String?) ?? '',
      peptideSlug: (data['peptideSlug'] as String?) ?? '',
      peptideName: (data['peptideName'] as String?) ?? '',
      dosePerInjection: (data['dosePerInjection'] as num?)?.toDouble() ?? 0,
      doseUnit: (data['doseUnit'] as String?) ?? 'mcg',
      frequency: (data['frequency'] as String?) ?? 'daily',
      route: (data['route'] as String?) ?? 'subcutaneous',
      cycleWeeks: (data['cycleWeeks'] as num?)?.toInt() ?? 0,
      injectionSites: (data['injectionSites'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      scheduledTimes: (data['scheduledTimes'] as List<dynamic>? ??
              const ['08:00'])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

extension ProtocolStatusLabel on ProtocolStatus {
  String get label => switch (this) {
        ProtocolStatus.active => 'Active',
        ProtocolStatus.paused => 'Paused',
        ProtocolStatus.ended => 'Ended',
      };
}

/// Available frequency options, keyed to the stored `frequency` string.
const kFrequencies = <({String key, String label, int daysPerWeek})>[
  (key: 'daily', label: 'Daily', daysPerWeek: 7),
  (key: 'eod', label: 'Every other day', daysPerWeek: 4),
  (key: 'twice_weekly', label: '2x per week', daysPerWeek: 2),
  (key: 'weekly', label: 'Weekly', daysPerWeek: 1),
  (key: 'as_needed', label: 'As needed', daysPerWeek: 0),
];

const kRoutes = <({String key, String label})>[
  (key: 'subcutaneous', label: 'Subcutaneous'),
  (key: 'intramuscular', label: 'Intramuscular'),
  (key: 'oral', label: 'Oral'),
  (key: 'nasal', label: 'Nasal'),
];

const kInjectionSites = <({String key, String label})>[
  (key: 'left-abdomen', label: 'Left Abdomen'),
  (key: 'right-abdomen', label: 'Right Abdomen'),
  (key: 'left-thigh', label: 'Left Thigh'),
  (key: 'right-thigh', label: 'Right Thigh'),
  (key: 'left-delt', label: 'Left Deltoid'),
  (key: 'right-delt', label: 'Right Deltoid'),
];
