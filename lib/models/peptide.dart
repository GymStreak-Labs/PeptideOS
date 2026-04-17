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
/// first launch into `peptideLibrary/{slug}`, never mutated by users.
class Peptide {
  Peptide({
    required this.slug,
    required this.name,
    required this.category,
    required this.description,
    required this.typicalDose,
    required this.defaultDoseMcg,
    required this.defaultFrequency,
    required this.halfLife,
    required this.typicalCycleWeeks,
    required this.defaultRoute,
    required this.commonStack,
    required this.notes,
    required this.disclaimer,
  });

  /// Stable string identifier (e.g. "bpc-157"). Doubles as the Firestore doc ID.
  final String slug;
  final String name;
  final PeptideCategory category;

  /// Short one-paragraph factual description. No medical claims.
  final String description;

  /// Human-readable typical dose range (e.g. "250–500 mcg").
  final String typicalDose;

  /// Default dose in mcg used as a sensible starting value when a user
  /// adds this peptide to a protocol.
  final double defaultDoseMcg;

  /// Default frequency key: `daily`, `eod`, `twice_weekly`, `weekly`, `as_needed`.
  final String defaultFrequency;

  /// Typical half-life human string (e.g. "~4 hours"). May be empty.
  final String halfLife;

  /// Usual cycle length in weeks (0 = continuous / no cycle).
  final int typicalCycleWeeks;

  /// Default administration route: `subcutaneous`, `intramuscular`, `oral`, `nasal`.
  final String defaultRoute;

  /// Peptides that are commonly stacked with this one (slugs).
  final List<String> commonStack;

  /// Extra notes (storage, reconstitution tips, etc.).
  final String notes;

  /// Mandatory disclaimer line shown on the detail screen.
  final String disclaimer;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'slug': slug,
        'name': name,
        'category': category.name,
        'description': description,
        'typicalDose': typicalDose,
        'defaultDoseMcg': defaultDoseMcg,
        'defaultFrequency': defaultFrequency,
        'halfLife': halfLife,
        'typicalCycleWeeks': typicalCycleWeeks,
        'defaultRoute': defaultRoute,
        'commonStack': commonStack,
        'notes': notes,
        'disclaimer': disclaimer,
      };

  factory Peptide.fromMap(String id, Map<String, dynamic> data) {
    return Peptide(
      slug: (data['slug'] as String?) ?? id,
      name: (data['name'] as String?) ?? '',
      category: _parseCategory(data['category'] as String?),
      description: (data['description'] as String?) ?? '',
      typicalDose: (data['typicalDose'] as String?) ?? '',
      defaultDoseMcg: (data['defaultDoseMcg'] as num?)?.toDouble() ?? 0,
      defaultFrequency: (data['defaultFrequency'] as String?) ?? 'daily',
      halfLife: (data['halfLife'] as String?) ?? '',
      typicalCycleWeeks: (data['typicalCycleWeeks'] as num?)?.toInt() ?? 0,
      defaultRoute: (data['defaultRoute'] as String?) ?? 'subcutaneous',
      commonStack: (data['commonStack'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      notes: (data['notes'] as String?) ?? '',
      disclaimer: (data['disclaimer'] as String?) ?? '',
    );
  }

  static PeptideCategory _parseCategory(String? raw) {
    if (raw == null) return PeptideCategory.other;
    for (final c in PeptideCategory.values) {
      if (c.name == raw) return c;
    }
    return PeptideCategory.other;
  }
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
