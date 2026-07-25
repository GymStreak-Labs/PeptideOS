import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/features/library/screens/reconstitution_screen.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/models/conversion_workspace.dart';

void main() {
  group('ConversionInput', () {
    test('converts vial, diluent, and user amount into U-100 units', () {
      const input = ConversionInput(
        vialAmountMg: 5,
        diluentVolumeMl: 2,
        desiredAmount: 250,
        desiredAmountUnit: ConversionAmountUnit.micrograms,
        syringe: ConversionSyringe.units100,
      );

      final result = input.calculate();

      expect(result.isValid, isTrue);
      expect(result.concentrationMcgPerMl, 2500);
      expect(result.drawVolumeMl, closeTo(0.1, 0.000001));
      expect(result.drawUnits, closeTo(10, 0.000001));
      expect(result.formattedDrawUnits, '10');
      expect(result.formattedDrawVolumeMl, '0.1');
    });

    test('converts milligram amount input before calculating', () {
      const input = ConversionInput(
        vialAmountMg: 10,
        diluentVolumeMl: 2,
        desiredAmount: 0.25,
        desiredAmountUnit: ConversionAmountUnit.milligrams,
        syringe: ConversionSyringe.units50,
      );

      final result = input.calculate();

      expect(input.desiredAmountMcg, 250);
      expect(result.drawUnits, closeTo(5, 0.000001));
    });

    test('retains useful precision for small draw-unit results', () {
      const input = ConversionInput(
        vialAmountMg: 20,
        diluentVolumeMl: 1,
        desiredAmount: 12.5,
        desiredAmountUnit: ConversionAmountUnit.micrograms,
        syringe: ConversionSyringe.units30,
      );

      final result = input.calculate();

      expect(result.drawUnits, closeTo(0.0625, 0.000001));
      expect(result.formattedDrawUnits, '0.06');
      expect(result.formattedDrawVolumeMl, '0.001');
    });

    test('flags converted volume above selected syringe capacity', () {
      const input = ConversionInput(
        vialAmountMg: 5,
        diluentVolumeMl: 2,
        desiredAmount: 1000,
        desiredAmountUnit: ConversionAmountUnit.micrograms,
        syringe: ConversionSyringe.units30,
      );

      expect(input.calculate().exceedsSyringeCapacity, isTrue);
    });

    test('rejects zero values and amount above the vial total', () {
      const zero = ConversionInput(
        vialAmountMg: 0,
        diluentVolumeMl: 2,
        desiredAmount: 250,
        desiredAmountUnit: ConversionAmountUnit.micrograms,
        syringe: ConversionSyringe.units100,
      );
      const aboveVial = ConversionInput(
        vialAmountMg: 1,
        diluentVolumeMl: 2,
        desiredAmount: 1.1,
        desiredAmountUnit: ConversionAmountUnit.milligrams,
        syringe: ConversionSyringe.units100,
      );

      expect(zero.calculate().isValid, isFalse);
      expect(aboveVial.calculate().isValid, isFalse);
      expect(aboveVial.calculate().error, contains('greater than'));
    });
  });

  test('saved calculation round-trips through primitive map values', () {
    final original = SavedVialCalculation(
      id: 'calc-1',
      createdAt: DateTime.utc(2026, 7, 25, 10, 30),
      input: const ConversionInput(
        vialAmountMg: 7.5,
        diluentVolumeMl: 1.5,
        desiredAmount: 0.2,
        desiredAmountUnit: ConversionAmountUnit.milligrams,
        syringe: ConversionSyringe.units50,
      ),
    );

    final map = original.toMap();
    final decoded = SavedVialCalculation.fromMap(map);

    expect(map['id'], 'calc-1');
    expect(map['createdAt'], '2026-07-25T10:30:00.000Z');
    expect(map['input'], isA<Map<String, dynamic>>());
    expect(decoded.id, original.id);
    expect(decoded.createdAt, original.createdAt);
    expect(decoded.input.vialAmountMg, 7.5);
    expect(decoded.input.diluentVolumeMl, 1.5);
    expect(decoded.input.desiredAmountUnit, ConversionAmountUnit.milligrams);
    expect(decoded.input.syringe, ConversionSyringe.units50);
  });

  testWidgets('workspace labels sources and saves entered calculation', (
    tester,
  ) async {
    List<SavedVialCalculation>? saved;
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: ReconstitutionScreen(
          onSavedCalculationsChanged: (items) async => saved = items,
        ),
      ),
    );

    expect(find.text('Source: labels on your vial and diluent.'), findsOne);
    expect(find.text('Source: an amount you were already given.'), findsOne);
    expect(
      find.text(
        'Conversion only — this workspace never chooses an amount or schedule.',
      ),
      findsOne,
    );

    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('vial-amount-field')),
        matching: find.byType(TextField),
      ),
      '5',
    );
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('diluent-volume-field')),
        matching: find.byType(TextField),
      ),
      '2',
    );
    await tester.enterText(
      find.byKey(const Key('desired-amount-field')),
      '250',
    );
    await tester.pump();

    await tester.scrollUntilVisible(
      find.byKey(const Key('draw-units-result')),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('10'), findsOne);

    await tester.scrollUntilVisible(
      find.text('SAVE PRESET'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('SAVE PRESET'));
    await tester.pump();

    expect(saved, hasLength(1));
    expect(saved!.single.input.vialAmountMg, 5);
    expect(saved!.single.input.desiredAmount, 250);
    expect(find.text('SAVED.VIALS'), findsOne);
    expect(tester.takeException(), isNull);
  });

  testWidgets('workspace stays overflow-free on a compact phone', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: const ReconstitutionScreen(
          initialInput: ConversionInput(
            vialAmountMg: 5,
            diluentVolumeMl: 2,
            desiredAmount: 250,
            desiredAmountUnit: ConversionAmountUnit.micrograms,
            syringe: ConversionSyringe.units30,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -1000),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
