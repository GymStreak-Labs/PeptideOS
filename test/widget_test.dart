import 'package:flutter_test/flutter_test.dart';

void main() {
  // Smoke test placeholder.
  //
  // The real app boots via main() which asynchronously opens Isar from the
  // native path_provider directory — that path isn't available in unit-test
  // environments without extra plumbing. Once we add an in-memory DB harness
  // (Phase 2), this file will be rewritten to cover app startup, onboarding
  // routing, and the Protocol home screen.
  test('PeptideOS test harness boots', () {
    expect(2 + 2, equals(4));
  });
}
