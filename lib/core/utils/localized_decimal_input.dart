import 'package:intl/intl.dart';

/// Formats a decimal for an editable field without grouping separators.
///
/// Keeping grouping disabled makes the value unambiguous while editing, and
/// [parseDecimalInput] accepts the locale-specific decimal separator emitted
/// here.
String formatLocalizedDecimalInput(
  double value, {
  required String localeName,
  int maximumFractionDigits = 2,
}) {
  assert(maximumFractionDigits >= 0);
  final fractionPattern = maximumFractionDigits == 0
      ? ''
      : '.${List.filled(maximumFractionDigits, '#').join()}';
  return (NumberFormat(
    '0$fractionPattern',
    localeName,
  )..turnOffGrouping()).format(value);
}
