import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/core/utils/decimal_input.dart';
import 'package:peptide_os/core/utils/localized_decimal_input.dart';
import 'package:peptide_os/features/protocol/screens/create_protocol_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/blend_vial.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  test('German editable decimals use commas and remain parseable', () {
    final value = formatLocalizedDecimalInput(
      12.5,
      localeName: 'de',
      maximumFractionDigits: 2,
    );

    expect(value, '12,5');
    expect(parseDecimalInput(value), 12.5);
    expect(
      formatLocalizedDecimalInput(
        1250,
        localeName: 'de',
        maximumFractionDigits: 2,
      ),
      '1250',
    );
  });

  testWidgets('German blend editor localizes every prefilled decimal', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        locale: const Locale('de'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlendVialConfigSheet(
            initial: ProtocolPeptide(
              uuid: 'locale-blend',
              peptideSlug: 'custom-blend',
              peptideName: 'Test blend',
              dosePerInjection: 7.5,
              doseUnit: 'syringe units',
              frequency: 'daily',
              route: 'subcutaneous',
              syringeUnits: 7.5,
              scheduledTimes: const ['08:00'],
              blendVial: const BlendVial(
                constituents: [
                  BlendConstituent(
                    name: 'Compound A',
                    vialAmount: 10.5,
                    unit: 'mg',
                  ),
                  BlendConstituent(
                    name: 'Compound B',
                    vialAmount: 5.25,
                    unit: 'mg',
                  ),
                ],
                diluentMl: 2.5,
                drawSyringeUnits: 7.5,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final editableValues = tester
        .widgetList<EditableText>(find.byType(EditableText))
        .map((field) => field.controller.text)
        .toList();

    expect(editableValues, containsAll(['2,5', '7,5', '10,5', '5,25']));
    expect(editableValues, isNot(contains('2.5')));
    expect(editableValues, isNot(contains('7.5')));
    expect(editableValues, isNot(contains('10.5')));
    expect(editableValues, isNot(contains('5.25')));
    expect(tester.takeException(), isNull);
  });
}
