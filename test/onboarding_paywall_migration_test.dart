import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/features/onboarding/services/onboarding_draft_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('an unversioned update latch never paywalls an existing user', () async {
    SharedPreferences.setMockInitialValues({
      'pepmod_post_auth_paywall_pending_v1': true,
    });

    expect(await OnboardingDraftService.isPostAuthPaywallPending(), isFalse);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('pepmod_post_auth_paywall_pending_v1'), isFalse);
  });

  test(
    'a newly completed onboarding keeps its paywall across restart',
    () async {
      SharedPreferences.setMockInitialValues({});

      await OnboardingDraftService.setPostAuthPaywallPending(true);

      expect(await OnboardingDraftService.isPostAuthPaywallPending(), isTrue);
    },
  );

  test('completing the paywall clears the versioned latch', () async {
    SharedPreferences.setMockInitialValues({});
    await OnboardingDraftService.setPostAuthPaywallPending(true);

    await OnboardingDraftService.setPostAuthPaywallPending(false);

    expect(await OnboardingDraftService.isPostAuthPaywallPending(), isFalse);
  });
}
