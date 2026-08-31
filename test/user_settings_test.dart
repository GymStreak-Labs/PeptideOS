import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/models/user_settings.dart';
import 'package:peptide_os/models/conversion_workspace.dart';

void main() {
  test('parses review account and legacy goal fields from Firestore', () {
    final settings = UserSettings.fromMap({
      'onboardingCompleted': true,
      'reviewAccount': true,
      'goals': ['Protocol tracking', 'Unit conversion'],
      'confidenceNeeds': ['Dose math', 'Site rotation'],
    });

    expect(settings.onboardingCompleted, isTrue);
    expect(settings.reviewAccount, isTrue);
    expect(settings.selectedGoals, ['Protocol tracking', 'Unit conversion']);
    expect(settings.confidenceNeeds, ['Dose math', 'Site rotation']);
  });

  test('preserves review account flag when serializing settings', () {
    final settings = UserSettings(
      onboardingCompleted: true,
      reviewAccount: true,
      selectedGoals: ['Progress'],
      confidenceNeeds: ['Plain-English info'],
    );

    expect(settings.toMap(), containsPair('reviewAccount', true));
    expect(
      settings.toMap(),
      containsPair('confidenceNeeds', ['Plain-English info']),
    );
  });

  test(
    'persists an explicit app locale and defaults legacy users to system',
    () {
      final restored = UserSettings.fromMap(
        UserSettings(localeCode: 'es').toMap(),
      );
      expect(restored.localeCode, 'es');
      expect(
        UserSettings.fromMap(const <String, dynamic>{}).localeCode,
        isEmpty,
      );
    },
  );

  test('saved vial calculations serialize as Firestore-safe primitives', () {
    final settings = UserSettings(
      savedVialCalculations: [
        SavedVialCalculation(
          id: 'saved-1',
          createdAt: DateTime.utc(2026, 7, 25),
          input: const ConversionInput(
            vialAmountMg: 5,
            diluentVolumeMl: 2,
            desiredAmount: 250,
            desiredAmountUnit: ConversionAmountUnit.micrograms,
            syringe: ConversionSyringe.units100,
          ),
        ),
        SavedVialCalculation(
          id: 'saved-iu',
          createdAt: DateTime.utc(2026, 7, 25),
          input: const ConversionInput(
            vialAmount: 10000,
            diluentVolumeMl: 2,
            desiredAmount: 250,
            quantityMode: ConversionQuantityMode.internationalUnits,
            syringe: ConversionSyringe.units30,
          ),
        ),
      ],
    );

    final map = settings.toMap();
    final encoded = map['savedVialCalculations'] as List<dynamic>;
    expect(encoded, everyElement(isA<Map<String, dynamic>>()));
    expect(
      (encoded.first as Map<String, dynamic>)['input'],
      isA<Map<String, dynamic>>(),
    );

    final restored = UserSettings.fromMap(map);
    expect(restored.savedVialCalculations, hasLength(2));
    expect(restored.savedVialCalculations.first.id, 'saved-1');
    expect(
      restored.savedVialCalculations.first.input.syringe,
      ConversionSyringe.units100,
    );
    expect(
      restored.savedVialCalculations.last.input.quantityMode,
      ConversionQuantityMode.internationalUnits,
    );
  });
}
