/// A user-owned compound and vial preset.
///
/// These records are reusable input shortcuts only. They deliberately do not
/// contain suggested doses or frequencies. A protocol copies the selected
/// values into its own [ProtocolPeptide] snapshot, so later preset edits never
/// rewrite historical tracking data.
class CustomCompound {
  const CustomCompound({
    required this.id,
    required this.name,
    required this.vialAmount,
    required this.vialUnit,
    required this.trackingUnit,
    required this.route,
    this.notes = '',
    this.archived = false,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final double vialAmount;
  final String vialUnit;
  final String trackingUnit;
  final String route;
  final String notes;
  final bool archived;
  final DateTime createdAt;
  final DateTime updatedAt;

  CustomCompound copyWith({
    String? name,
    double? vialAmount,
    String? vialUnit,
    String? trackingUnit,
    String? route,
    String? notes,
    bool? archived,
    DateTime? updatedAt,
  }) {
    return CustomCompound(
      id: id,
      name: name ?? this.name,
      vialAmount: vialAmount ?? this.vialAmount,
      vialUnit: vialUnit ?? this.vialUnit,
      trackingUnit: trackingUnit ?? this.trackingUnit,
      route: route ?? this.route,
      notes: notes ?? this.notes,
      archived: archived ?? this.archived,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'name': name,
    'vialAmount': vialAmount,
    'vialUnit': vialUnit,
    'trackingUnit': trackingUnit,
    'route': route,
    'notes': notes,
    'archived': archived,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory CustomCompound.fromMap(String id, Map<String, dynamic> data) {
    final now = DateTime.now();
    return CustomCompound(
      id: id,
      name: (data['name'] as String?)?.trim() ?? '',
      vialAmount: (data['vialAmount'] as num?)?.toDouble() ?? 0,
      vialUnit: _allowedUnit(data['vialUnit'], fallback: 'mg'),
      trackingUnit: _allowedUnit(data['trackingUnit'], fallback: 'mcg'),
      route: (data['route'] as String?) ?? 'subcutaneous',
      notes: (data['notes'] as String?) ?? '',
      archived: (data['archived'] as bool?) ?? false,
      createdAt: _parseDate(data['createdAt']) ?? now,
      updatedAt: _parseDate(data['updatedAt']) ?? now,
    );
  }

  static String _allowedUnit(Object? raw, {required String fallback}) {
    final value = raw?.toString();
    return const {'mcg', 'mg', 'IU'}.contains(value) ? value! : fallback;
  }
}

DateTime? _parseDate(Object? raw) {
  if (raw is DateTime) return raw;
  if (raw is String) return DateTime.tryParse(raw);
  try {
    final dynamic value = raw;
    final parsed = value.toDate();
    if (parsed is DateTime) return parsed;
  } catch (_) {}
  return null;
}
