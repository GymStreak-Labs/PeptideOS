import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_settings.dart';

/// Firestore CRUD for the per-user settings document.
///
/// Stored at `users/{uid}/settings/profile` — always a single doc per user.
class UserSettingsRepository {
  UserSettingsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _docId = 'profile';

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _doc(String uid) => _firestore
      .collection('users')
      .doc(uid)
      .collection('settings')
      .doc(_docId);

  Stream<UserSettings> watch(String uid) {
    return _doc(uid).snapshots().map((snap) {
      final data = snap.data();
      if (data == null) return UserSettings();
      return UserSettings.fromMap(data);
    });
  }

  Future<UserSettings> fetch(String uid) async {
    final snap = await _doc(uid).get();
    final data = snap.data();
    if (data == null) return UserSettings();
    return UserSettings.fromMap(data);
  }

  /// Server-authoritative read for destructive flows that preserve selected
  /// account-level fields. This must fail offline instead of falling back to a
  /// stale cache and overwriting reviewer/subscription flags.
  Future<UserSettings> fetchFromServer(String uid) async {
    final snap = await _doc(uid).get(const GetOptions(source: Source.server));
    final data = snap.data();
    if (data == null) return UserSettings();
    return UserSettings.fromMap(data);
  }

  Future<void> save(String uid, UserSettings settings) async {
    await _doc(uid).set(settings.toMap());
  }

  Future<void> update(String uid, Map<String, dynamic> patch) async {
    await _doc(uid).set(patch, SetOptions(merge: true));
  }

  /// Ensure a settings doc exists on first sign-in. No-op if already present.
  Future<UserSettings> ensure(String uid) async {
    final snap = await _doc(uid).get();
    if (snap.exists) {
      return UserSettings.fromMap(snap.data() ?? const {});
    }
    final fresh = UserSettings();
    await _doc(uid).set(fresh.toMap());
    return fresh;
  }

  /// Resets personal preferences/onboarding while keeping account-level flags.
  Future<void> reset(
    String uid, {
    required String subscriptionState,
    required bool reviewAccount,
  }) async {
    await save(
      uid,
      UserSettings(
        subscriptionState: subscriptionState,
        reviewAccount: reviewAccount,
      ),
    );
  }
}
