import 'package:isar/isar.dart';

part 'dose_log.g.dart';

/// A scheduled or completed peptide dose.
@collection
class DoseLog {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String protocolUuid;

  @Index()
  late String protocolPeptideUuid;

  /// Cached peptide name so the schedule list doesn't have to join through
  /// the protocol to render.
  late String peptideName;

  @Index()
  late DateTime scheduledAt;

  DateTime? takenAt;

  /// Actual amount administered. Defaults to the protocol's prescribed dose
  /// but can be overridden at log time.
  late double amountTaken;

  /// `mcg` or `mg`.
  late String units;

  /// Injection site key (see `kInjectionSites`).
  String injectionSite = '';

  String notes = '';

  bool skipped = false;

  DoseLog();

  bool get isTaken => takenAt != null && !skipped;
  bool get isPending => takenAt == null && !skipped;

  /// True if the dose was scheduled for a past moment and hasn't been logged.
  bool isMissed(DateTime now) =>
      isPending && scheduledAt.isBefore(now.subtract(const Duration(hours: 3)));
}
