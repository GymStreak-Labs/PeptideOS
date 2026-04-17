import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../data/repositories/user_settings_repository.dart';
import '../../../models/user_settings.dart';

/// Reactive wrapper around the authenticated user's settings document.
///
/// The provider is reconstructed whenever the active UID changes (sign-in /
/// sign-out) — owner is `AuthProvider` in main.dart.
class SettingsProvider extends ChangeNotifier {
  SettingsProvider(this._repo, {required String uid}) : _uid = uid {
    _subscribe();
  }

  final UserSettingsRepository _repo;
  String _uid;
  StreamSubscription<UserSettings>? _sub;

  UserSettings _settings = UserSettings();
  bool _loading = true;

  UserSettings get settings => _settings;
  bool get isLoading => _loading;
  String get uid => _uid;

  /// Swap the underlying UID (e.g., after sign-in). Cancels the old stream
  /// and re-subscribes. Called from the auth provider.
  void setUid(String uid) {
    if (_uid == uid) return;
    _uid = uid;
    _loading = true;
    _settings = UserSettings();
    _subscribe();
  }

  void _subscribe() {
    _sub?.cancel();
    if (_uid.isEmpty) {
      _loading = false;
      notifyListeners();
      return;
    }
    _sub = _repo.watch(_uid).listen(
      (s) {
        _settings = s;
        _loading = false;
        notifyListeners();
      },
      onError: (Object e, StackTrace st) {
        debugPrint('SettingsProvider stream failed: $e');
        _loading = false;
        notifyListeners();
      },
    );
  }

  /// Apply a mutation locally then persist the entire doc. We keep the
  /// mutation API (closure-style) identical to Phase 1 so the UI doesn't need
  /// rewriting — but every call now triggers a Firestore write.
  Future<void> update(void Function(UserSettings s) mutator) async {
    mutator(_settings);
    notifyListeners();
    if (_uid.isEmpty) return;
    try {
      await _repo.save(_uid, _settings);
    } catch (e) {
      debugPrint('SettingsProvider save failed: $e');
    }
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

  /// Wipe the per-user settings doc back to defaults. Used by the "Clear all
  /// data" button. The stream will pick up the new doc contents.
  Future<void> resetAll() async {
    if (_uid.isEmpty) {
      _settings = UserSettings();
      notifyListeners();
      return;
    }
    try {
      await _repo.reset(_uid);
    } catch (e) {
      debugPrint('SettingsProvider reset failed: $e');
    }
  }

  /// Cached subscription tier — written by the subscription provider so the
  /// rest of the app can gate without round-tripping RC.
  Future<void> setSubscriptionState(String state) async {
    if (_settings.subscriptionState == state) return;
    _settings.subscriptionState = state;
    notifyListeners();
    if (_uid.isEmpty) return;
    try {
      await _repo.update(_uid, {'subscriptionState': state});
    } catch (e) {
      debugPrint('SettingsProvider subscription save failed: $e');
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
