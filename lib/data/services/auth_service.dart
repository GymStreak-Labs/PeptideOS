import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../models/app_user.dart';

/// Thin wrapper over Firebase Auth — mirrors the GymLevels pattern so the rest
/// of the app has a consistent interface regardless of which sign-in provider
/// is used.
class AuthService {
  AuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;
  bool get isSignedIn => currentUser != null;

  // ── Email / password ────────────────────────────────────────────────────
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // ── Apple ────────────────────────────────────────────────────────────────
  Future<UserCredential> signInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      if (appleCredential.givenName != null ||
          appleCredential.familyName != null) {
        final displayName = [
          appleCredential.givenName,
          appleCredential.familyName,
        ].where((n) => n != null).join(' ');
        if (displayName.isNotEmpty) {
          await userCredential.user?.updateDisplayName(displayName);
        }
      }

      return userCredential;
    } on SignInWithAppleAuthorizationException catch (e) {
      throw AuthException(code: 'apple_sign_in_failed', message: e.message);
    }
  }

  // ── Google ───────────────────────────────────────────────────────────────
  Future<UserCredential> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw AuthException(
          code: 'google_sign_in_cancelled',
          message: 'Sign in was cancelled.',
        );
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    } on AuthException {
      rethrow;
    } catch (_) {
      throw AuthException(
        code: 'google_sign_in_failed',
        message: 'Google sign in failed.',
      );
    }
  }

  // ── Sign-out & profile ──────────────────────────────────────────────────
  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
    await _firebaseAuth.signOut();
  }

  Future<void> updateDisplayName(String displayName) async {
    await currentUser?.updateDisplayName(displayName);
  }

  Future<void> deleteAccount() async {
    final user = currentUser;
    if (user == null) return;
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        await _reauthenticate(user);
        await user.delete();
      } else {
        rethrow;
      }
    }
  }

  Future<void> _reauthenticate(User user) async {
    final providerIds = user.providerData.map((p) => p.providerId).toSet();
    if (providerIds.contains('apple.com')) {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
        nonce: nonce,
      );
      final oauth = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      await user.reauthenticateWithCredential(oauth);
    } else if (providerIds.contains('google.com')) {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw AuthException(
          code: 'reauth_cancelled',
          message: 'Re-authentication was cancelled.',
        );
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await user.reauthenticateWithCredential(credential);
    } else {
      throw AuthException(
        code: 'requires_password',
        message: 'Please enter your password to confirm account deletion.',
      );
    }
  }

  // ── Helpers ─────────────────────────────────────────────────────────────
  AppUser? toAppUser(User? firebaseUser) {
    if (firebaseUser == null) return null;
    return AppUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      createdAt: firebaseUser.metadata.creationTime,
      lastLoginAt: firebaseUser.metadata.lastSignInTime,
    );
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }

  AuthException _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthException(
          code: e.code,
          message: 'No user found with this email address.',
        );
      case 'wrong-password':
      case 'invalid-credential':
        return AuthException(
          code: e.code,
          message: 'Incorrect email or password.',
        );
      case 'email-already-in-use':
        return AuthException(
          code: e.code,
          message: 'An account already exists with this email.',
        );
      case 'weak-password':
        return AuthException(
          code: e.code,
          message: 'Password is too weak. Use at least 6 characters.',
        );
      case 'invalid-email':
        return AuthException(
          code: e.code,
          message: 'Invalid email address.',
        );
      default:
        return AuthException(
          code: e.code,
          message: e.message ?? 'An authentication error occurred.',
        );
    }
  }
}

class AuthException implements Exception {
  AuthException({required this.code, required this.message});

  final String code;
  final String message;

  @override
  String toString() => 'AuthException($code): $message';
}
