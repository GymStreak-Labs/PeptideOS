import 'package:isar/isar.dart';

part 'peptide.g.dart';

/// Peptide category — broad classification used for filtering the library.
enum PeptideCategory {
  healing,
  growthHormone,
  cognitive,
  metabolic,
  aesthetic,
  longevity,
  other,
}

/// A peptide entry in the compound library. Read-only at runtime — seeded on
/// first launch, never mutated by users.
@collection
class Peptide {
  Id id = Isar.autoIncrement;

  /// Stable string identifier (e.g. "bpc-157"). Indexed for fast lookup.
  @Index(unique: true, replace: true)
  late String slug;

  late String name;

  @Enumerated(EnumType.name)
  late PeptideCategory category;

  /// Short one-paragraph factual description. No medical claims.
  late String description;

  /// Human-readable typical dose range (e.g. "250–500 mcg").
  late String typicalDose;

  /// Default dose in mcg used as a sensible starting value when a user
  /// adds this peptide to a protocol.
  late double defaultDoseMcg;

  /// Default frequency key: `daily`, `eod`, `twice_weekly`, `weekly`, `as_needed`.
  late String defaultFrequency;

  /// Typical half-life human string (e.g. "~4 hours"). May be empty.
  late String halfLife;

  /// Usual cycle length in weeks (0 = continuous / no cycle).
  late int typicalCycleWeeks;

  /// Default administration route: `subcutaneous`, `intramuscular`, `oral`, `nasal`.
  late String defaultRoute;

  /// Peptides that are commonly stacked with this one (slugs).
  List<String> commonStack = <String>[];

  /// Extra notes (storage, reconstitution tips, etc.).
  late String notes;

  /// Mandatory disclaimer line shown on the detail screen.
  late String disclaimer;

  Peptide();
}

extension PeptideCategoryLabel on PeptideCategory {
  String get label => switch (this) {
        PeptideCategory.healing => 'Healing',
        PeptideCategory.growthHormone => 'Growth Hormone',
        PeptideCategory.cognitive => 'Cognitive',
        PeptideCategory.metabolic => 'Metabolic',
        PeptideCategory.aesthetic => 'Aesthetic',
        PeptideCategory.longevity => 'Longevity',
        PeptideCategory.other => 'Other',
      };
}
