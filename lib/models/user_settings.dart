import 'conversion_workspace.dart';

/// Units preference.
enum UnitSystem { metric, imperial }

/// Per-user settings / profile. Persisted to Firestore at
/// `users/{uid}/settings/profile`. A single document per user.
class UserSettings {
  UserSettings({
    this.name = 'Biohacker',
    this.firstName = '',
    this.birthDate = '',
    this.units = UnitSystem.metric,
    this.localeCode = '',
    this.notificationsEnabled = false,
    this.onboardingCompleted = false,
    this.darkMode = true,
    this.subscriptionState = 'free',
    this.reviewAccount = false,
    List<String>? selectedGoals,
    List<String>? confidenceNeeds,
    List<SavedVialCalculation>? savedVialCalculations,
    this.experience = '',
    this.frustration = '',
  }) : selectedGoals = selectedGoals ?? <String>[],
       confidenceNeeds = confidenceNeeds ?? <String>[],
       savedVialCalculations =
           savedVialCalculations ?? <SavedVialCalculation>[];

  /// Display name — defaults to "Biohacker" if nothing supplied in onboarding.
  String name;
  String firstName;

  /// ISO-8601 date only (`yyyy-MM-dd`) captured during onboarding.
  String birthDate;
  UnitSystem units;

  /// Empty follows the device language; otherwise an app-supported locale.
  String localeCode;
  bool notificationsEnabled;
  bool onboardingCompleted;
  bool darkMode;

  /// Cached subscription state: `free` / `premium`. Firestore copy of the
  /// RevenueCat entitlement so UI can gate without waiting on RC.
  String subscriptionState;
  bool reviewAccount;
  List<String> selectedGoals;
  List<String> confidenceNeeds;
  List<SavedVialCalculation> savedVialCalculations;
  String experience;
  String frustration;

  UserSettings copyWith({
    String? name,
    String? firstName,
    String? birthDate,
    UnitSystem? units,
    String? localeCode,
    bool? notificationsEnabled,
    bool? onboardingCompleted,
    bool? darkMode,
    String? subscriptionState,
    bool? reviewAccount,
    List<String>? selectedGoals,
    List<String>? confidenceNeeds,
    List<SavedVialCalculation>? savedVialCalculations,
    String? experience,
    String? frustration,
  }) {
    return UserSettings(
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      birthDate: birthDate ?? this.birthDate,
      units: units ?? this.units,
      localeCode: localeCode ?? this.localeCode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      darkMode: darkMode ?? this.darkMode,
      subscriptionState: subscriptionState ?? this.subscriptionState,
      reviewAccount: reviewAccount ?? this.reviewAccount,
      selectedGoals: selectedGoals ?? this.selectedGoals,
      confidenceNeeds: confidenceNeeds ?? this.confidenceNeeds,
      savedVialCalculations:
          savedVialCalculations ?? this.savedVialCalculations,
      experience: experience ?? this.experience,
      frustration: frustration ?? this.frustration,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'name': name,
    'firstName': firstName,
    'birthDate': birthDate,
    'units': units.name,
    'localeCode': localeCode,
    'notificationsEnabled': notificationsEnabled,
    'onboardingCompleted': onboardingCompleted,
    'darkMode': darkMode,
    'subscriptionState': subscriptionState,
    'reviewAccount': reviewAccount,
    'selectedGoals': selectedGoals,
    'confidenceNeeds': confidenceNeeds,
    'savedVialCalculations': savedVialCalculations
        .map((item) => item.toMap())
        .toList(),
    'experience': experience,
    'frustration': frustration,
  };

  factory UserSettings.fromMap(Map<String, dynamic> data) {
    return UserSettings(
      name: (data['name'] as String?) ?? 'Biohacker',
      firstName: (data['firstName'] as String?) ?? '',
      birthDate: (data['birthDate'] as String?) ?? '',
      units: _parseUnits(data['units'] as String?),
      localeCode: (data['localeCode'] as String?) ?? '',
      notificationsEnabled: (data['notificationsEnabled'] as bool?) ?? false,
      onboardingCompleted: (data['onboardingCompleted'] as bool?) ?? false,
      darkMode: (data['darkMode'] as bool?) ?? true,
      subscriptionState: (data['subscriptionState'] as String?) ?? 'free',
      reviewAccount: (data['reviewAccount'] as bool?) ?? false,
      selectedGoals:
          ((data['selectedGoals'] ?? data['goals']) as List<dynamic>? ??
                  const [])
              .map((e) => e.toString())
              .toList(),
      confidenceNeeds: (data['confidenceNeeds'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      savedVialCalculations:
          (data['savedVialCalculations'] as List<dynamic>? ?? const [])
              .whereType<Map>()
              .map(
                (item) => SavedVialCalculation.fromMap(
                  Map<String, dynamic>.from(item),
                ),
              )
              .where((item) => item.id.isNotEmpty)
              .take(8)
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
