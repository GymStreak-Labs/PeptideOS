import '../../models/user_settings.dart';

/// Converts body weight at the UI boundary while keeping Firestore values in
/// canonical kilograms.
extension WeightUnitConversion on UnitSystem {
  static const double poundsPerKilogram = 2.2046226218487757;

  String get weightSuffix => this == UnitSystem.metric ? 'kg' : 'lbs';

  double displayWeightFromKg(double kilograms) =>
      this == UnitSystem.metric ? kilograms : kilograms * poundsPerKilogram;

  double storageWeightInKg(double displayWeight) => this == UnitSystem.metric
      ? displayWeight
      : displayWeight / poundsPerKilogram;
}
