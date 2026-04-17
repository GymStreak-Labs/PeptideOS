import 'package:isar/isar.dart';

part 'user_settings.g.dart';

/// Units preference.
enum UnitSystem { metric, imperial }

/// Singleton user settings / profile. We always read/write the entry with
/// `id == 1` — there is only ever one.
@collection
class UserSettings {
  Id id = 1;

  /// Display name — defaults to "Biohacker" if nothing supplied in onboarding.
  String name = 'Biohacker';

  @Enumerated(EnumType.name)
  UnitSystem units = UnitSystem.metric;

  bool notificationsEnabled = false;
  bool onboardingCompleted = false;
  bool darkMode = true; // dark-mode-first — toggle reserved for Phase 2.

  /// Hard-coded FREE for Phase 1. Wired in Phase 2 via RevenueCat.
  String subscriptionState = 'free';

  List<String> selectedGoals = <String>[];
  String experience = '';
  String frustration = '';

  UserSettings();
}
