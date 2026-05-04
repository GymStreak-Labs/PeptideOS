import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/models/user_settings.dart';

void main() {
  test('parses review account and legacy goal fields from Firestore', () {
    final settings = UserSettings.fromMap({
      'onboardingCompleted': true,
      'reviewAccount': true,
      'goals': ['Protocol tracking', 'Unit conversion'],
    });

    expect(settings.onboardingCompleted, isTrue);
    expect(settings.reviewAccount, isTrue);
    expect(settings.selectedGoals, ['Protocol tracking', 'Unit conversion']);
  });

  test('preserves review account flag when serializing settings', () {
    final settings = UserSettings(
      onboardingCompleted: true,
      reviewAccount: true,
      selectedGoals: ['Progress'],
    );

    expect(settings.toMap(), containsPair('reviewAccount', true));
  });
}
