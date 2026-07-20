import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../core/services/analytics_service.dart';
import '../../../data/repositories/user_data_repository.dart';
import '../../../data/repositories/user_settings_repository.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/superwall_bridge_service.dart';
import '../../../services/notification_service.dart';
import '../../onboarding/services/onboarding_draft_service.dart';

/// Exposes the current authenticated user and drives a few side-effects on
/// sign-in / sign-out:
///   - Creates `users/{uid}` doc if missing
///   - Ensures a settings doc exists
///   - Identifies the user in Superwall before subscription-gated routing
///   - Identifies the user across analytics / crashlytics / AppRefer
class AuthProvider extends ChangeNotifier {
  AuthProvider({
    AuthService? authService,
    UserDataRepository? userDataRepo,
    UserSettingsRepository? settingsRepo,
    SuperwallBridgeService? superwallBridge,
    AnalyticsService? analytics,
    FirebaseFirestore? firestore,
  }) : _auth = authService ?? AuthService(),
       _userDataRepo = userDataRepo ?? UserDataRepository(),
       _settingsRepo = settingsRepo ?? UserSettingsRepository(),
       _superwallBridge = superwallBridge ?? SuperwallBridgeService.instance,
       _analytics = analytics ?? AnalyticsService(),
       _firestore = firestore ?? FirebaseFirestore.instance {
    _sub = _auth.authStateChanges.listen(_onAuthChanged);
    _currentUser = _auth.currentUser;
  }

  final AuthService _auth;
  final UserDataRepository _userDataRepo;
  final UserSettingsRepository _settingsRepo;
  final SuperwallBridgeService _superwallBridge;
  final AnalyticsService _analytics;
  final FirebaseFirestore _firestore;

  StreamSubscription<User?>? _sub;

  User? _currentUser;
  bool _initialized = false;
  bool _subscriptionIdentityReady = false;
  bool _accountDeletionCompleted = false;
  bool _clearingAppData = false;

  User? get currentUser => _currentUser;
  bool get isSignedIn => _currentUser != null;
  bool get isInitialized => _initialized;
  bool get isSubscriptionIdentityReady => _subscriptionIdentityReady;
  String get uid => _currentUser?.uid ?? '';
  bool get accountDeletionCompleted => _accountDeletionCompleted;
  bool get isClearingAppData => _clearingAppData;

  AuthService get authService => _auth;

  Future<void> _onAuthChanged(User? user) async {
    final previous = _currentUser;
    _currentUser = user;
    _subscriptionIdentityReady = false;
    _initialized = true;
    notifyListeners();

    if (user != null) {
      _accountDeletionCompleted = false;
      try {
        await _ensureUserDoc(user);
        await _settingsRepo.ensure(user.uid);
      } catch (e) {
        debugPrint('AuthProvider user bootstrap failed: $e');
      }
      try {
        await _superwallBridge.identifyUser(
          userId: user.uid,
          installId: _analytics.installId,
        );
      } catch (e) {
        debugPrint('AuthProvider Superwall identify failed: $e');
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
        await _superwallBridge.resetIdentity();
      } catch (e) {
        debugPrint('AuthProvider Superwall reset failed: $e');
      }
      try {
        await _analytics.clearIdentity();
      } catch (_) {}
    }

    _subscriptionIdentityReady = true;
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

  /// Clears user-created tracking data while preserving the signed-in account
  /// and account-level subscription/reviewer flags. Settings are reset last:
  /// that Firestore write routes the app back into onboarding, so it must only
  /// happen after every destructive operation has succeeded.
  Future<void> clearAppData() async {
    if (_clearingAppData) {
      throw StateError('Clear data is already in progress.');
    }
    final user = _currentUser ?? _auth.currentUser;
    if (user == null) {
      throw StateError('A signed-in user is required to clear app data.');
    }

    _clearingAppData = true;
    notifyListeners();
    try {
      final currentSettings = await _settingsRepo.fetchFromServer(user.uid);
      await NotificationService.instance.cancelAll(strict: true);
      await _userDataRepo.deleteAppDataForUser(user.uid);
      await OnboardingDraftService.clear();
      await OnboardingDraftService.setPostAuthPaywallPending(false);
      await _settingsRepo.reset(
        user.uid,
        subscriptionState: currentSettings.subscriptionState,
        reviewAccount: currentSettings.reviewAccount,
      );
    } finally {
      _clearingAppData = false;
      notifyListeners();
    }
  }

  Future<void> deleteAccount({String? password}) async {
    final user = _currentUser ?? _auth.currentUser;
    if (user == null) return;

    await _auth.reauthenticateForAccountDeletion(password: password);
    await _userDataRepo.deleteAllForUser(user.uid);
    await _auth.deleteAccount(password: password);
    _accountDeletionCompleted = true;
    notifyListeners();
  }

  void clearAccountDeletionCompleted() {
    if (!_accountDeletionCompleted) return;
    _accountDeletionCompleted = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
