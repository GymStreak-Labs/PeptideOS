import 'package:flutter/foundation.dart';

import '../../../models/user_settings.dart';
import '../../../services/database_service.dart';

/// Reactive wrapper around the singleton UserSettings row.
class SettingsProvider extends ChangeNotifier {
  SettingsProvider(this._db) {
    _load();
  }

  final DatabaseService _db;

  UserSettings _settings = UserSettings()..id = 1;
  bool _loading = true;

  UserSettings get settings => _settings;
  bool get isLoading => _loading;

  Future<void> _load() async {
    try {
      _settings = await _db.getUserSettings();
    } catch (e) {
      debugPrint('SettingsProvider load failed: $e');
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> update(void Function(UserSettings s) mutator) async {
    mutator(_settings);
    try {
      await _db.saveUserSettings(_settings);
    } catch (e) {
      debugPrint('settings save failed: $e');
    }
    notifyListeners();
  }

  Future<void> completeOnboarding({
    required List<String> goals,
    required String experience,
    required String frustration,
  }) async {
    await update((s) {
      s.selectedGoals = goals;
      s.experience = experience;
      s.frustration = frustration;
      s.onboardingCompleted = true;
    });
  }

  Future<void> resetAll() async {
    await _db.clearAllUserData();
    await _load();
  }
}
