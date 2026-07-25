/// Unit used for the amount the user wants to convert.
enum ConversionAmountUnit {
  micrograms('mcg'),
  milligrams('mg');

  const ConversionAmountUnit(this.label);
  final String label;
}

/// Common U-100 insulin syringe capacities.
///
/// U-100 means 100 syringe units per millilitre. Capacity changes what can fit
/// in one syringe; it does not change the unit conversion.
enum ConversionSyringe {
  units30(capacityUnits: 30, volumeMl: 0.3, label: '0.3 mL / 30 unit'),
  units50(capacityUnits: 50, volumeMl: 0.5, label: '0.5 mL / 50 unit'),
  units100(capacityUnits: 100, volumeMl: 1, label: '1 mL / 100 unit');

  const ConversionSyringe({
    required this.capacityUnits,
    required this.volumeMl,
    required this.label,
  });

  final int capacityUnits;
  final double volumeMl;
  final String label;
}

/// User-provided values for a reconstitution unit conversion.
class ConversionInput {
  const ConversionInput({
    required this.vialAmountMg,
    required this.diluentVolumeMl,
    required this.desiredAmount,
    required this.desiredAmountUnit,
    required this.syringe,
  });

  final double vialAmountMg;
  final double diluentVolumeMl;
  final double desiredAmount;
  final ConversionAmountUnit desiredAmountUnit;
  final ConversionSyringe syringe;

  double get desiredAmountMcg =>
      desiredAmountUnit == ConversionAmountUnit.milligrams
      ? desiredAmount * 1000
      : desiredAmount;

  ConversionResult calculate() {
    if (!_isPositiveFinite(vialAmountMg) ||
        !_isPositiveFinite(diluentVolumeMl) ||
        !_isPositiveFinite(desiredAmount)) {
      return const ConversionResult.invalid(
        'Enter a number greater than zero in every field.',
      );
    }

    final vialAmountMcg = vialAmountMg * 1000;
    if (desiredAmountMcg > vialAmountMcg) {
      return const ConversionResult.invalid(
        'Desired amount is greater than the amount entered for this vial.',
      );
    }

    final concentrationMcgPerMl = vialAmountMcg / diluentVolumeMl;
    final drawVolumeMl = desiredAmountMcg / concentrationMcgPerMl;
    final drawUnits = drawVolumeMl * 100;

    if (!concentrationMcgPerMl.isFinite ||
        !drawVolumeMl.isFinite ||
        !drawUnits.isFinite) {
      return const ConversionResult.invalid(
        'These values could not be converted. Recheck each entry.',
      );
    }

    return ConversionResult(
      concentrationMcgPerMl: concentrationMcgPerMl,
      drawVolumeMl: drawVolumeMl,
      drawUnits: drawUnits,
      exceedsSyringeCapacity: drawUnits > syringe.capacityUnits,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'vialAmountMg': vialAmountMg,
    'diluentVolumeMl': diluentVolumeMl,
    'desiredAmount': desiredAmount,
    'desiredAmountUnit': desiredAmountUnit.name,
    'syringe': syringe.name,
  };

  factory ConversionInput.fromMap(Map<String, dynamic> data) {
    return ConversionInput(
      vialAmountMg: _asDouble(data['vialAmountMg']),
      diluentVolumeMl: _asDouble(data['diluentVolumeMl']),
      desiredAmount: _asDouble(data['desiredAmount']),
      desiredAmountUnit: _enumByName(
        ConversionAmountUnit.values,
        data['desiredAmountUnit'],
        ConversionAmountUnit.micrograms,
      ),
      syringe: _enumByName(
        ConversionSyringe.values,
        data['syringe'],
        ConversionSyringe.units100,
      ),
    );
  }

  static bool _isPositiveFinite(double value) => value.isFinite && value > 0;
}

class ConversionResult {
  const ConversionResult({
    required this.concentrationMcgPerMl,
    required this.drawVolumeMl,
    required this.drawUnits,
    required this.exceedsSyringeCapacity,
  }) : error = null;

  const ConversionResult.invalid(this.error)
    : concentrationMcgPerMl = 0,
      drawVolumeMl = 0,
      drawUnits = 0,
      exceedsSyringeCapacity = false;

  final double concentrationMcgPerMl;
  final double drawVolumeMl;
  final double drawUnits;
  final bool exceedsSyringeCapacity;
  final String? error;

  bool get isValid => error == null;

  /// Keeps small draw values readable without implying false precision.
  String get formattedDrawUnits => _formatNumber(drawUnits, maxDecimals: 2);
  String get formattedDrawVolumeMl =>
      _formatNumber(drawVolumeMl, maxDecimals: 3);
  String get formattedConcentration =>
      _formatNumber(concentrationMcgPerMl, maxDecimals: 1);
}

/// A reusable, user-scoped calculation snapshot.
class SavedVialCalculation {
  const SavedVialCalculation({
    required this.id,
    required this.createdAt,
    required this.input,
  });

  final String id;
  final DateTime createdAt;
  final ConversionInput input;

  String get label =>
      '${_formatNumber(input.vialAmountMg, maxDecimals: 2)} mg + '
      '${_formatNumber(input.diluentVolumeMl, maxDecimals: 2)} mL';

  String get detail =>
      '${_formatNumber(input.desiredAmount, maxDecimals: 2)} '
      '${input.desiredAmountUnit.label} · ${input.syringe.capacityUnits}u';

  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'input': input.toMap(),
  };

  factory SavedVialCalculation.fromMap(Map<String, dynamic> data) {
    final rawInput = data['input'];
    return SavedVialCalculation(
      id: data['id']?.toString() ?? '',
      createdAt:
          DateTime.tryParse(data['createdAt']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      input: ConversionInput.fromMap(
        rawInput is Map
            ? Map<String, dynamic>.from(rawInput)
            : const <String, dynamic>{},
      ),
    );
  }
}

double _asDouble(Object? value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

T _enumByName<T extends Enum>(List<T> values, Object? raw, T fallback) {
  final name = raw?.toString();
  for (final value in values) {
    if (value.name == name) return value;
  }
  return fallback;
}

String _formatNumber(double value, {required int maxDecimals}) {
  if (!value.isFinite) return '—';
  final fixed = value.toStringAsFixed(maxDecimals);
  return fixed.replaceFirst(RegExp(r'\.?0+$'), '');
}
