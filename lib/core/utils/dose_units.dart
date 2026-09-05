import '../../models/user_settings.dart';
import 'localized_decimal_input.dart';

/// Only mass units are interchangeable. IU and syringe units are independent.
bool isMassDoseUnit(String unit) => unit == 'mcg' || unit == 'mg';

/// Converts an amount only within the mass family. Other unit families retain
/// their amount; callers must never present that as an IU/mass equivalence.
double convertMassDose(double amount, String from, String to) {
  if (from == to || !isMassDoseUnit(from) || !isMassDoseUnit(to)) return amount;
  return from == 'mg' ? amount * 1000 : amount / 1000;
}

String preferredDoseUnit(String storedUnit, DoseUnitPreference preference) =>
    !isMassDoseUnit(storedUnit) || preference == DoseUnitPreference.original
    ? storedUnit
    : preference.name;

/// Extra precision matters for small doses expressed in mg (e.g. 25 mcg).
String formatDoseNumber(double amount, String locale) =>
    formatLocalizedDecimalInput(
      amount,
      localeName: locale,
      maximumFractionDigits: 12,
    );
