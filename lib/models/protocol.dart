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
          .map(
            (e) => ProtocolPeptide.fromMap(
              Map<String, dynamic>.from(e as Map<dynamic, dynamic>),
            ),
          )
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
    this.washoutWeeks = 0,
    this.syringeUnits = 0,
    this.labelColorHex = '',
    List<String>? injectionSites,
    List<String>? scheduledTimes,
    List<ProtocolWeekdayDose>? weekdayDoses,
  }) : injectionSites = injectionSites ?? <String>[],
       scheduledTimes = scheduledTimes ?? <String>['08:00'],
       weekdayDoses = weekdayDoses ?? <ProtocolWeekdayDose>[];

  String uuid;
  String peptideSlug;
  String peptideName;
  double dosePerInjection;
  String doseUnit;
  String frequency;
  String route;
  int cycleWeeks;
  int washoutWeeks;
  double syringeUnits;
  String labelColorHex;
  List<String> injectionSites;
  List<String> scheduledTimes;
  List<ProtocolWeekdayDose> weekdayDoses;

  bool get usesCustomWeekdays =>
      frequency == kCustomWeekdayFrequency && weekdayDoses.isNotEmpty;

  ProtocolDoseSchedule? scheduleForDate({
    required DateTime protocolStart,
    required DateTime date,
  }) {
    final startDay = DateTime(
      protocolStart.year,
      protocolStart.month,
      protocolStart.day,
    );
    final targetDay = DateTime(date.year, date.month, date.day);
    if (targetDay.isBefore(startDay)) return null;
    if (!isInActiveCycle(protocolStart: startDay, date: targetDay)) {
      return null;
    }

    ProtocolWeekdayDose? weekdayDose;
    if (usesCustomWeekdays) {
      for (final dose in weekdayDoses) {
        if (dose.weekday == targetDay.weekday) {
          weekdayDose = dose;
          break;
        }
      }
    }
    if (usesCustomWeekdays && weekdayDose == null) return null;

    if (!usesCustomWeekdays &&
        !isDosingDayForFrequency(frequency, startDay, targetDay)) {
      return null;
    }

    final times = weekdayDose?.scheduledTimes ?? scheduledTimes;
    return ProtocolDoseSchedule(
      dosePerInjection: weekdayDose?.dosePerInjection ?? dosePerInjection,
      doseUnit: weekdayDose?.doseUnit ?? doseUnit,
      syringeUnits: weekdayDose?.syringeUnits ?? syringeUnits,
      scheduledTimes: times.isEmpty ? const <String>['08:00'] : times,
    );
  }

  DateTime? cycleEndDate(DateTime protocolStart) {
    if (cycleWeeks <= 0) return null;
    final startDay = DateTime(
      protocolStart.year,
      protocolStart.month,
      protocolStart.day,
    );
    return startDay.add(Duration(days: cycleWeeks * 7));
  }

  DateTime? washoutEndDate(DateTime protocolStart) {
    final cycleEnd = cycleEndDate(protocolStart);
    if (cycleEnd == null || washoutWeeks <= 0) return cycleEnd;
    return cycleEnd.add(Duration(days: washoutWeeks * 7));
  }

  bool isInActiveCycle({
    required DateTime protocolStart,
    required DateTime date,
  }) {
    final cycleEnd = cycleEndDate(protocolStart);
    if (cycleEnd == null) return true;
    final targetDay = DateTime(date.year, date.month, date.day);
    return targetDay.isBefore(cycleEnd);
  }

  bool isInWashout({required DateTime protocolStart, required DateTime date}) {
    final cycleEnd = cycleEndDate(protocolStart);
    final washoutEnd = washoutEndDate(protocolStart);
    if (cycleEnd == null || washoutEnd == null || washoutWeeks <= 0) {
      return false;
    }
    final targetDay = DateTime(date.year, date.month, date.day);
    return !targetDay.isBefore(cycleEnd) && targetDay.isBefore(washoutEnd);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'uuid': uuid,
    'peptideSlug': peptideSlug,
    'peptideName': peptideName,
    'dosePerInjection': dosePerInjection,
    'doseUnit': doseUnit,
    'frequency': frequency,
    'route': route,
    'cycleWeeks': cycleWeeks,
    'washoutWeeks': washoutWeeks,
    'syringeUnits': syringeUnits,
    'labelColorHex': labelColorHex,
    'injectionSites': injectionSites,
    'scheduledTimes': scheduledTimes,
    'weekdayDoses': weekdayDoses.map((d) => d.toMap()).toList(),
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
      washoutWeeks: (data['washoutWeeks'] as num?)?.toInt() ?? 0,
      syringeUnits: (data['syringeUnits'] as num?)?.toDouble() ?? 0,
      labelColorHex:
          (data['labelColorHex'] as String?) ??
          (data['colorLabelHex'] as String?) ??
          '',
      injectionSites: (data['injectionSites'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      scheduledTimes:
          (data['scheduledTimes'] as List<dynamic>? ?? const ['08:00'])
              .map((e) => e.toString())
              .toList(),
      weekdayDoses: (data['weekdayDoses'] as List<dynamic>? ?? const [])
          .map(
            (e) => ProtocolWeekdayDose.fromMap(
              Map<String, dynamic>.from(e as Map<dynamic, dynamic>),
            ),
          )
          .where((d) => d.isValid)
          .toList(),
    );
  }
}

class ProtocolWeekdayDose {
  ProtocolWeekdayDose({
    required this.weekday,
    required this.dosePerInjection,
    this.doseUnit = 'mcg',
    this.syringeUnits = 0,
    List<String>? scheduledTimes,
  }) : scheduledTimes = scheduledTimes ?? <String>['08:00'];

  int weekday;
  double dosePerInjection;
  String doseUnit;
  double syringeUnits;
  List<String> scheduledTimes;

  bool get isValid =>
      weekday >= DateTime.monday &&
      weekday <= DateTime.sunday &&
      dosePerInjection > 0;

  Map<String, dynamic> toMap() => <String, dynamic>{
    'weekday': weekday,
    'dosePerInjection': dosePerInjection,
    'doseUnit': doseUnit,
    'syringeUnits': syringeUnits,
    'scheduledTimes': scheduledTimes,
  };

  factory ProtocolWeekdayDose.fromMap(Map<String, dynamic> data) {
    return ProtocolWeekdayDose(
      weekday: (data['weekday'] as num?)?.toInt() ?? 0,
      dosePerInjection: (data['dosePerInjection'] as num?)?.toDouble() ?? 0,
      doseUnit: (data['doseUnit'] as String?) ?? 'mcg',
      syringeUnits: (data['syringeUnits'] as num?)?.toDouble() ?? 0,
      scheduledTimes:
          (data['scheduledTimes'] as List<dynamic>? ?? const ['08:00'])
              .map((e) => e.toString())
              .toList(),
    );
  }
}

class ProtocolDoseSchedule {
  const ProtocolDoseSchedule({
    required this.dosePerInjection,
    required this.doseUnit,
    required this.syringeUnits,
    required this.scheduledTimes,
  });

  final double dosePerInjection;
  final String doseUnit;
  final double syringeUnits;
  final List<String> scheduledTimes;
}

extension ProtocolStatusLabel on ProtocolStatus {
  String get label => switch (this) {
    ProtocolStatus.active => 'Active',
    ProtocolStatus.paused => 'Paused',
    ProtocolStatus.ended => 'Ended',
  };
}

/// Available frequency options, keyed to the stored `frequency` string.
const kCustomWeekdayFrequency = 'custom_weekdays';

const kFrequencies = <({String key, String label, int daysPerWeek})>[
  (key: 'daily', label: 'Daily', daysPerWeek: 7),
  (key: 'eod', label: 'Every other day', daysPerWeek: 4),
  (key: 'twice_weekly', label: '2x per week', daysPerWeek: 2),
  (key: 'weekly', label: 'Weekly', daysPerWeek: 1),
  (key: kCustomWeekdayFrequency, label: 'Custom days', daysPerWeek: 0),
  (key: 'as_needed', label: 'As needed', daysPerWeek: 0),
];

bool isDosingDayForFrequency(String frequency, DateTime start, DateTime day) {
  switch (frequency) {
    case 'daily':
      return true;
    case 'eod':
      final diff = day
          .difference(DateTime(start.year, start.month, start.day))
          .inDays;
      return diff.isEven;
    case 'twice_weekly':
      return day.weekday == DateTime.monday || day.weekday == DateTime.thursday;
    case 'weekly':
      final diff = day
          .difference(DateTime(start.year, start.month, start.day))
          .inDays;
      return diff % 7 == 0;
    case 'as_needed':
    default:
      return false;
  }
}

const kRoutes = <({String key, String label})>[
  (key: 'subcutaneous', label: 'Subcutaneous'),
  (key: 'intramuscular', label: 'Intramuscular'),
  (key: 'oral', label: 'Oral'),
  (key: 'nasal', label: 'Nasal'),
  (key: 'topical', label: 'Topical'),
];

const kInjectionSites = <({String key, String label})>[
  (key: 'left-abdomen', label: 'Left Abdomen'),
  (key: 'right-abdomen', label: 'Right Abdomen'),
  (key: 'left-thigh', label: 'Left Thigh'),
  (key: 'right-thigh', label: 'Right Thigh'),
  (key: 'left-delt', label: 'Left Deltoid'),
  (key: 'right-delt', label: 'Right Deltoid'),
  (key: 'left-glute', label: 'Left Glute'),
  (key: 'right-glute', label: 'Right Glute'),
  (key: 'left-triceps', label: 'Left Triceps'),
  (key: 'right-triceps', label: 'Right Triceps'),
];
