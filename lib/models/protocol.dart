import 'package:isar/isar.dart';

part 'protocol.g.dart';

/// Lifecycle status of a protocol.
enum ProtocolStatus { active, paused, ended }

/// A named multi-peptide regimen tracked by the user.
@collection
class Protocol {
  Id id = Isar.autoIncrement;

  /// Stable UUID string — used to reference from DoseLog without depending on
  /// autoIncrement Isar ids.
  @Index(unique: true, replace: true)
  late String uuid;

  late String name;

  late DateTime startDate;

  DateTime? endDate;

  @Enumerated(EnumType.name)
  late ProtocolStatus status;

  /// Embedded peptide entries (one per peptide in this protocol).
  List<ProtocolPeptide> peptides = <ProtocolPeptide>[];

  late DateTime createdAt;

  Protocol();
}

/// A single peptide within a protocol — dose, frequency, cycle info.
@embedded
class ProtocolPeptide {
  /// UUID — used to correlate dose logs back to the specific protocol entry.
  String uuid = '';

  /// Reference to the library Peptide (slug).
  String peptideSlug = '';

  /// Cached display name so the UI doesn't need to hit the library each render.
  String peptideName = '';

  /// Dose amount per injection.
  double dosePerInjection = 0;

  /// Dose unit: `mcg` or `mg`.
  String doseUnit = 'mcg';

  /// Frequency key: `daily`, `eod`, `twice_weekly`, `weekly`, `as_needed`.
  String frequency = 'daily';

  /// Administration route: `subcutaneous`, `intramuscular`, `oral`, `nasal`.
  String route = 'subcutaneous';

  /// Cycle length in weeks (0 = continuous).
  int cycleWeeks = 0;

  /// Injection site rotation list (`left-abdomen`, `right-abdomen`, `left-thigh`,
  /// `right-thigh`, `left-delt`, `right-delt`). Empty = no rotation.
  List<String> injectionSites = <String>[];

  /// Preferred times for this peptide on its dosing days, as "HH:mm" strings.
  List<String> scheduledTimes = <String>['08:00'];

  ProtocolPeptide();
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
