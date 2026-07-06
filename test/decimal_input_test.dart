import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/utils/decimal_input.dart';

void main() {
  group('parseDecimalInput', () {
    test('accepts dot and comma decimal separators', () {
      expect(parseDecimalInput('0.5'), 0.5);
      expect(parseDecimalInput('0,5'), 0.5);
      expect(parseDecimalInput('.5'), 0.5);
      expect(parseDecimalInput(',5'), 0.5);
      expect(parseDecimalInput('12,75'), 12.75);
    });

    test('accepts pasted values with regional grouping', () {
      expect(parseDecimalInput('1,234.5'), 1234.5);
      expect(parseDecimalInput('1.234,5'), 1234.5);
      expect(parseDecimalInput('1 234,5'), 1234.5);
      expect(parseDecimalInput("1'234.5"), 1234.5);
      expect(parseDecimalInput('12,34,567.89'), 1234567.89);
    });

    test('accepts non-ASCII digits and separators from regional keyboards', () {
      expect(parseDecimalInput('٠٫٥'), 0.5);
      expect(parseDecimalInput('۱٬۲۳۴٫۵'), 1234.5);
      expect(parseDecimalInput('１２．５'), 12.5);
    });

    test('rejects empty and malformed values', () {
      expect(parseDecimalInput(''), isNull);
      expect(parseDecimalInput('1,2.3'), isNull);
      expect(parseDecimalInput('1.2,3,4'), isNull);
      expect(parseDecimalInput('abc'), isNull);
      expect(parseDecimalInput('-0.5'), isNull);
    });
  });

  group('DecimalInputFormatter', () {
    test('allows one decimal separator in either locale style', () {
      const formatter = DecimalInputFormatter();

      expect(
        formatter
            .formatEditUpdate(
              const TextEditingValue(text: '0'),
              const TextEditingValue(text: '0,5'),
            )
            .text,
        '0,5',
      );
      expect(
        formatter
            .formatEditUpdate(
              const TextEditingValue(text: '0'),
              const TextEditingValue(text: '0.5'),
            )
            .text,
        '0.5',
      );
    });

    test('rejects a second decimal separator', () {
      const formatter = DecimalInputFormatter();

      expect(
        formatter
            .formatEditUpdate(
              const TextEditingValue(text: '0,5'),
              const TextEditingValue(text: '0,5.1'),
            )
            .text,
        '0,5',
      );
    });

    test('normalizes pasted grouped values while preserving decimal style', () {
      const formatter = DecimalInputFormatter();

      expect(
        formatter
            .formatEditUpdate(
              const TextEditingValue(),
              const TextEditingValue(text: '1.234,5'),
            )
            .text,
        '1234,5',
      );
      expect(
        formatter
            .formatEditUpdate(
              const TextEditingValue(),
              const TextEditingValue(text: '1,234.5'),
            )
            .text,
        '1234.5',
      );
    });

    test('normalizes non-ASCII pasted input', () {
      const formatter = DecimalInputFormatter();

      expect(
        formatter
            .formatEditUpdate(
              const TextEditingValue(),
              const TextEditingValue(text: '۱٬۲۳۴٫۵'),
            )
            .text,
        '1234.5',
      );
    });
  });
}
