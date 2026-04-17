/// Units preference.
enum UnitSystem { metric, imperial }

/// Per-user settings / profile. Persisted to Firestore at
/// `users/{uid}/settings/profile`. A single document per user.
class UserSettings {
  UserSettings({
    this.name = 'Biohacker',
    this.units = UnitSystem.metric,
    this.notificationsEnabled = false,
    this.onboardingCompleted = false,
    this.darkMode = true,
    this.subscriptionState = 'free',
    List<String>? selectedGoals,
    this.experience = '',
    this.frustration = '',
  }) : selectedGoals = selectedGoals ?? <String>[];

  /// Display name — defaults to "Biohacker" if nothing supplied in onboarding.
  String name;
  UnitSystem units;
  bool notificationsEnabled;
  bool onboardingCompleted;
  bool darkMode;

  /// Cached subscription state: `free` / `premium`. Firestore copy of the
  /// RevenueCat entitlement so UI can gate without waiting on RC.
  String subscriptionState;
  List<String> selectedGoals;
  String experience;
  String frustration;

  UserSettings copyWith({
    String? name,
    UnitSystem? units,
    bool? notificationsEnabled,
    bool? onboardingCompleted,
    bool? darkMode,
    String? subscriptionState,
    List<String>? selectedGoals,
    String? experience,
    String? frustration,
  }) {
    return UserSettings(
      name: name ?? this.name,
      units: units ?? this.units,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      darkMode: darkMode ?? this.darkMode,
      subscriptionState: subscriptionState ?? this.subscriptionState,
      selectedGoals: selectedGoals ?? this.selectedGoals,
      experience: experience ?? this.experience,
      frustration: frustration ?? this.frustration,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'units': units.name,
        'notificationsEnabled': notificationsEnabled,
        'onboardingCompleted': onboardingCompleted,
        'darkMode': darkMode,
        'subscriptionState': subscriptionState,
        'selectedGoals': selectedGoals,
        'experience': experience,
        'frustration': frustration,
      };

  factory UserSettings.fromMap(Map<String, dynamic> data) {
    return UserSettings(
      name: (data['name'] as String?) ?? 'Biohacker',
      units: _parseUnits(data['units'] as String?),
      notificationsEnabled: (data['notificationsEnabled'] as bool?) ?? false,
      onboardingCompleted: (data['onboardingCompleted'] as bool?) ?? false,
      darkMode: (data['darkMode'] as bool?) ?? true,
      subscriptionState: (data['subscriptionState'] as String?) ?? 'free',
      selectedGoals: (data['selectedGoals'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      experience: (data['experience'] as String?) ?? '',
      frustration: (data['frustration'] as String?) ?? '',
    );
  }

  static UnitSystem _parseUnits(String? raw) {
    for (final u in UnitSystem.values) {
      if (u.name == raw) return u;
    }
    return UnitSystem.metric;
  }
}
