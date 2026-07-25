/// Unit used for the amount the user wants to convert.
enum ConversionAmountUnit {
  micrograms('mcg'),
  milligrams('mg');

  const ConversionAmountUnit(this.label);
  final String label;
}

/// The label family used on both sides of the conversion.
///
/// International units are intentionally isolated from mass. PepMod can
/// convert IU-per-mL to a draw volume, but never IU to or from mg/mcg.
enum ConversionQuantityMode {
  mass('Mass', 'mg / mcg'),
  internationalUnits('IU', 'IU only');

  const ConversionQuantityMode(this.label, this.caption);
  final String label;
  final String caption;
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
    double? vialAmount,
    double? vialAmountMg,
    required this.diluentVolumeMl,
    required this.desiredAmount,
    this.desiredAmountUnit = ConversionAmountUnit.micrograms,
    this.quantityMode = ConversionQuantityMode.mass,
    required this.syringe,
  }) : assert(vialAmount != null || vialAmountMg != null),
       vialAmount = vialAmount ?? vialAmountMg ?? 0;

  /// Amount printed on the vial, in mg for mass mode or IU for IU mode.
  final double vialAmount;
  final double diluentVolumeMl;
  final double desiredAmount;
  final ConversionAmountUnit desiredAmountUnit;
  final ConversionQuantityMode quantityMode;
  final ConversionSyringe syringe;

  /// Compatibility accessor for call sites and saved records created before
  /// explicit quantity modes were introduced.
  double get vialAmountMg => vialAmount;

  double get desiredAmountMcg =>
      desiredAmountUnit == ConversionAmountUnit.milligrams
      ? desiredAmount * 1000
      : desiredAmount;

  double get comparableDesiredAmount =>
      quantityMode == ConversionQuantityMode.internationalUnits
      ? desiredAmount
      : desiredAmountMcg;

  double get comparableVialAmount =>
      quantityMode == ConversionQuantityMode.internationalUnits
      ? vialAmount
      : vialAmount * 1000;

  ConversionResult calculate() {
    if (!_isPositiveFinite(vialAmount) ||
        !_isPositiveFinite(diluentVolumeMl) ||
        !_isPositiveFinite(desiredAmount)) {
      return const ConversionResult.invalid(
        'Enter a number greater than zero in every field.',
      );
    }

    if (comparableDesiredAmount > comparableVialAmount) {
      return const ConversionResult.invalid(
        'Desired amount is greater than the amount entered for this vial.',
      );
    }

    final concentrationPerMl = comparableVialAmount / diluentVolumeMl;
    final drawVolumeMl = comparableDesiredAmount / concentrationPerMl;
    final drawUnits = drawVolumeMl * 100;

    if (!concentrationPerMl.isFinite ||
        !drawVolumeMl.isFinite ||
        !drawUnits.isFinite) {
      return const ConversionResult.invalid(
        'These values could not be converted. Recheck each entry.',
      );
    }

    return ConversionResult(
      concentrationPerMl: concentrationPerMl,
      drawVolumeMl: drawVolumeMl,
      drawUnits: drawUnits,
      exceedsSyringeCapacity: drawUnits > syringe.capacityUnits,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'vialAmount': vialAmount,
    'diluentVolumeMl': diluentVolumeMl,
    'desiredAmount': desiredAmount,
    'desiredAmountUnit': desiredAmountUnit.name,
    'quantityMode': quantityMode.name,
    'syringe': syringe.name,
  };

  factory ConversionInput.fromMap(Map<String, dynamic> data) {
    return ConversionInput(
      vialAmount: _asDouble(data['vialAmount'] ?? data['vialAmountMg']),
      diluentVolumeMl: _asDouble(data['diluentVolumeMl']),
      desiredAmount: _asDouble(data['desiredAmount']),
      desiredAmountUnit: _enumByName(
        ConversionAmountUnit.values,
        data['desiredAmountUnit'],
        ConversionAmountUnit.micrograms,
      ),
      quantityMode: _enumByName(
        ConversionQuantityMode.values,
        data['quantityMode'],
        ConversionQuantityMode.mass,
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
    required this.concentrationPerMl,
    required this.drawVolumeMl,
    required this.drawUnits,
    required this.exceedsSyringeCapacity,
  }) : error = null;

  const ConversionResult.invalid(this.error)
    : concentrationPerMl = 0,
      drawVolumeMl = 0,
      drawUnits = 0,
      exceedsSyringeCapacity = false;

  final double concentrationPerMl;
  final double drawVolumeMl;
  final double drawUnits;
  final bool exceedsSyringeCapacity;
  final String? error;

  bool get isValid => error == null;

  double get concentrationMcgPerMl => concentrationPerMl;

  /// Keeps small draw values readable without implying false precision.
  String get formattedDrawUnits => _formatNumber(drawUnits, maxDecimals: 2);
  String get formattedDrawVolumeMl =>
      _formatNumber(drawVolumeMl, maxDecimals: 3);
  String get formattedConcentration =>
      _formatNumber(concentrationPerMl, maxDecimals: 1);
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
      '${_formatNumber(input.vialAmount, maxDecimals: 2)} '
      '${input.quantityMode == ConversionQuantityMode.internationalUnits ? 'IU' : 'mg'} + '
      '${_formatNumber(input.diluentVolumeMl, maxDecimals: 2)} mL';

  String get detail =>
      '${_formatNumber(input.desiredAmount, maxDecimals: 2)} '
      '${input.quantityMode == ConversionQuantityMode.internationalUnits ? 'IU' : input.desiredAmountUnit.label} '
      '· ${input.syringe.capacityUnits}u';

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
