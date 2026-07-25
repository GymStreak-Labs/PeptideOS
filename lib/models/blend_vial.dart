/// A user-entered constituent inside a pre-blended vial.
///
/// Amounts deliberately stay in the unit selected by the user. PepMod does
/// not convert between mg, mcg, and IU because doing so would require medical
/// assumptions that do not belong in an educational tracking tool.
class BlendConstituent {
  const BlendConstituent({
    required this.name,
    required this.vialAmount,
    required this.unit,
  });

  final String name;
  final double vialAmount;
  final String unit;

  bool get isValid => name.trim().isNotEmpty && vialAmount > 0;

  Map<String, dynamic> toMap() => <String, dynamic>{
    'name': name,
    'vialAmount': vialAmount,
    'unit': unit,
  };

  factory BlendConstituent.fromMap(Map<String, dynamic> data) {
    return BlendConstituent(
      name: (data['name'] as String?) ?? '',
      vialAmount: (data['vialAmount'] as num?)?.toDouble() ?? 0,
      unit: (data['unit'] as String?) ?? 'mg',
    );
  }
}

/// Immutable snapshot of a pre-blended vial and its user-entered draw.
///
/// U-100 syringes use 100 markings per mL. Keeping [syringeUnitsPerMl] in the
/// snapshot makes the calculation explicit and future-proofs other syringe
/// scales without silently changing historical dose records.
class BlendVial {
  const BlendVial({
    required this.constituents,
    required this.diluentMl,
    required this.drawSyringeUnits,
    this.syringeUnitsPerMl = 100,
  });

  final List<BlendConstituent> constituents;
  final double diluentMl;
  final double drawSyringeUnits;
  final double syringeUnitsPerMl;

  double get drawVolumeMl =>
      syringeUnitsPerMl <= 0 ? 0 : drawSyringeUnits / syringeUnitsPerMl;

  double get drawFraction => diluentMl <= 0 ? 0 : drawVolumeMl / diluentMl;

  bool get isValid =>
      constituents.length >= 2 &&
      constituents.every((item) => item.isValid) &&
      diluentMl > 0 &&
      drawSyringeUnits > 0 &&
      syringeUnitsPerMl > 0 &&
      drawVolumeMl <= diluentMl;

  double amountPerDraw(BlendConstituent constituent) {
    if (!isValid || !constituent.isValid) return 0;
    return constituent.vialAmount * drawFraction;
  }

  BlendVial copyWith({double? drawSyringeUnits}) {
    return BlendVial(
      constituents: [
        for (final item in constituents)
          BlendConstituent(
            name: item.name,
            vialAmount: item.vialAmount,
            unit: item.unit,
          ),
      ],
      diluentMl: diluentMl,
      drawSyringeUnits: drawSyringeUnits ?? this.drawSyringeUnits,
      syringeUnitsPerMl: syringeUnitsPerMl,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'constituents': constituents.map((item) => item.toMap()).toList(),
    'diluentMl': diluentMl,
    'drawSyringeUnits': drawSyringeUnits,
    'syringeUnitsPerMl': syringeUnitsPerMl,
  };

  factory BlendVial.fromMap(Map<String, dynamic> data) {
    return BlendVial(
      constituents: (data['constituents'] as List<dynamic>? ?? const [])
          .whereType<Map<dynamic, dynamic>>()
          .map(
            (item) => BlendConstituent.fromMap(Map<String, dynamic>.from(item)),
          )
          .toList(),
      diluentMl: (data['diluentMl'] as num?)?.toDouble() ?? 0,
      drawSyringeUnits: (data['drawSyringeUnits'] as num?)?.toDouble() ?? 0,
      syringeUnitsPerMl: (data['syringeUnitsPerMl'] as num?)?.toDouble() ?? 100,
    );
  }
}
