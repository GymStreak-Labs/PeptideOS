import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../core/services/analytics_service.dart';
import '../../../data/repositories/user_settings_repository.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/subscription_service.dart';

/// Exposes the current authenticated user and drives a few side-effects on
/// sign-in / sign-out:
///   - Creates `users/{uid}` doc if missing
///   - Ensures a settings doc exists
///   - Logs in to RevenueCat with the UID (so purchases attach to the user)
///   - Identifies the user across analytics / crashlytics / AppRefer
class AuthProvider extends ChangeNotifier {
  AuthProvider({
    AuthService? authService,
    UserSettingsRepository? settingsRepo,
    SubscriptionService? subscriptionService,
    AnalyticsService? analytics,
    FirebaseFirestore? firestore,
  })  : _auth = authService ?? AuthService(),
        _settingsRepo = settingsRepo ?? UserSettingsRepository(),
        _subscriptionService =
            subscriptionService ?? SubscriptionService.instance,
        _analytics = analytics ?? AnalyticsService(),
        _firestore = firestore ?? FirebaseFirestore.instance {
    _sub = _auth.authStateChanges.listen(_onAuthChanged);
    _currentUser = _auth.currentUser;
  }

  final AuthService _auth;
  final UserSettingsRepository _settingsRepo;
  final SubscriptionService _subscriptionService;
  final AnalyticsService _analytics;
  final FirebaseFirestore _firestore;

  StreamSubscription<User?>? _sub;

  User? _currentUser;
  bool _initialized = false;

  User? get currentUser => _currentUser;
  bool get isSignedIn => _currentUser != null;
  bool get isInitialized => _initialized;
  String get uid => _currentUser?.uid ?? '';

  AuthService get authService => _auth;

  Future<void> _onAuthChanged(User? user) async {
    final previous = _currentUser;
    _currentUser = user;
    _initialized = true;

    if (user != null) {
      try {
        await _ensureUserDoc(user);
        await _settingsRepo.ensure(user.uid);
      } catch (e) {
        debugPrint('AuthProvider user bootstrap failed: $e');
      }
      try {
        await _subscriptionService.login(user.uid);
      } catch (e) {
        debugPrint('AuthProvider RC login failed: $e');
      }
      try {
        await _analytics.identifyAuthenticatedUser(
          userId: user.uid,
          email: user.email ?? '',
          displayName: user.displayName,
        );
      } catch (e) {
        debugPrint('AuthProvider analytics identify failed: $e');
      }
    } else if (previous != null) {
      try {
        await _subscriptionService.logout();
      } catch (e) {
        debugPrint('AuthProvider RC logout failed: $e');
      }
      try {
        await _analytics.clearIdentity();
      } catch (_) {}
    }

    notifyListeners();
  }

  Future<void> _ensureUserDoc(User user) async {
    final ref = _firestore.collection('users').doc(user.uid);
    final snap = await ref.get();
    final now = FieldValue.serverTimestamp();
    if (!snap.exists) {
      await ref.set({
        'email': user.email ?? '',
        'displayName': user.displayName,
        'photoUrl': user.photoURL,
        'createdAt': now,
        'lastLoginAt': now,
      });
    } else {
      await ref.set({'lastLoginAt': now}, SetOptions(merge: true));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
