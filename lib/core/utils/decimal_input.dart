import 'package:flutter/services.dart';

double? parseDecimalInput(String value) {
  final normalized = _normalizeDecimalInput(value);
  if (normalized == null || normalized.isEmpty) return null;
  return double.tryParse(normalized);
}

const decimalInputFormatter = DecimalInputFormatter();

class DecimalInputFormatter extends TextInputFormatter {
  const DecimalInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final sanitized = _sanitizeDecimalInputForEditing(newValue.text);
    if (sanitized == null) return oldValue;

    final oldHadSeparator =
        oldValue.text.contains('.') || oldValue.text.contains(',');
    final newHasBoth =
        newValue.text.contains('.') && newValue.text.contains(',');
    final isSingleCharacterEdit =
        (newValue.text.length - oldValue.text.length).abs() <= 1;
    if (oldHadSeparator && newHasBoth && isSingleCharacterEdit) {
      return oldValue;
    }

    if (sanitized == newValue.text) return newValue;
    return TextEditingValue(
      text: sanitized,
      selection: TextSelection.collapsed(offset: sanitized.length),
    );
  }
}

String? _normalizeDecimalInput(String value) {
  final sanitized = _sanitizeDecimalInputForEditing(value);
  if (sanitized == null || sanitized.isEmpty) return sanitized;

  final separator = _decimalSeparatorFor(sanitized);
  if (separator == null) return sanitized;
  return sanitized.replaceFirst(separator, '.');
}

String? _sanitizeDecimalInputForEditing(String value) {
  var text = _canonicalizeDigitsAndSeparators(value).trim();
  if (text.isEmpty) return '';

  text = text.replaceAll(RegExp(r"[\s\u00A0\u2007\u202F'`_\u2019]"), '');
  if (text.isEmpty) return '';
  if (!RegExp(r'^[0-9.,]+$').hasMatch(text)) return null;

  final commaCount = _countOccurrences(text, ',');
  final dotCount = _countOccurrences(text, '.');
  if (commaCount == 0 && dotCount == 0) return text;

  if (commaCount > 0 && dotCount > 0) {
    final decimalSeparator = text.lastIndexOf(',') > text.lastIndexOf('.')
        ? ','
        : '.';
    final groupingSeparator = decimalSeparator == ',' ? '.' : ',';
    if (_countOccurrences(text, decimalSeparator) > 1) return null;

    final decimalIndex = text.lastIndexOf(decimalSeparator);
    final integerPart = text.substring(0, decimalIndex);
    final fractionPart = text.substring(decimalIndex + 1);
    if (fractionPart.contains(groupingSeparator)) return null;
    if (!_validGroupedInteger(integerPart, groupingSeparator)) return null;

    final normalizedInteger = integerPart.replaceAll(groupingSeparator, '');
    if (normalizedInteger.isEmpty && fractionPart.isEmpty) return null;
    return '$normalizedInteger$decimalSeparator$fractionPart';
  }

  final separator = commaCount > 0 ? ',' : '.';
  final separatorCount = _countOccurrences(text, separator);
  if (separatorCount == 1) {
    final parts = text.split(separator);
    if (parts.length != 2) return null;
    if (parts.first.isEmpty && parts.last.isEmpty) return null;
    return text;
  }

  final groups = text.split(separator);
  if (!_looksLikeGroupedInteger(groups)) return null;
  return groups.join();
}

String _canonicalizeDigitsAndSeparators(String value) {
  final buffer = StringBuffer();
  for (final rune in value.runes) {
    final digit = _asciiDigitFor(rune);
    if (digit != null) {
      buffer.writeCharCode(digit);
      continue;
    }

    switch (rune) {
      case 0x066B: // Arabic decimal separator.
      case 0xFF0E: // Fullwidth full stop.
      case 0xFE52: // Small full stop.
        buffer.write('.');
        break;
      case 0xFF0C: // Fullwidth comma.
      case 0xFE50: // Small comma.
      case 0xFE10: // Presentation-form comma.
        buffer.write(',');
        break;
      case 0x066C: // Arabic thousands separator.
      case 0x200E: // Left-to-right mark.
      case 0x200F: // Right-to-left mark.
      case 0x061C: // Arabic letter mark.
        break;
      default:
        buffer.writeCharCode(rune);
    }
  }
  return buffer.toString();
}

int? _asciiDigitFor(int rune) {
  if (rune >= 0x30 && rune <= 0x39) return rune;
  if (rune >= 0x0660 && rune <= 0x0669) return 0x30 + rune - 0x0660;
  if (rune >= 0x06F0 && rune <= 0x06F9) return 0x30 + rune - 0x06F0;
  if (rune >= 0xFF10 && rune <= 0xFF19) return 0x30 + rune - 0xFF10;
  return null;
}

String? _decimalSeparatorFor(String text) {
  final commaIndex = text.lastIndexOf(',');
  final dotIndex = text.lastIndexOf('.');
  if (commaIndex < 0 && dotIndex < 0) return null;
  return commaIndex > dotIndex ? ',' : '.';
}

int _countOccurrences(String text, String character) {
  return text.split(character).length - 1;
}

bool _validGroupedInteger(String value, String separator) {
  if (!value.contains(separator)) return RegExp(r'^\d*$').hasMatch(value);
  return _looksLikeGroupedInteger(value.split(separator));
}

bool _looksLikeGroupedInteger(List<String> groups) {
  if (groups.length < 2) return false;
  if (groups.any(
    (group) => group.isEmpty || !RegExp(r'^\d+$').hasMatch(group),
  )) {
    return false;
  }

  final westernGrouping =
      groups.first.length <= 3 &&
      groups.skip(1).every((group) => group.length == 3);
  if (westernGrouping) return true;

  return groups.length >= 3 &&
      groups.first.length <= 3 &&
      groups.last.length == 3 &&
      groups
          .skip(1)
          .take(groups.length - 2)
          .every((group) => group.length == 2);
}
