import 'package:apprefer/apprefer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Analytics singleton — wraps Firebase Analytics + stamps a stable install ID
/// on Crashlytics, RC, and AppRefer so attribution can tie installs to users.
///
/// Usage: `AnalyticsService().logPaywallViewed('onboarding');`.
class AnalyticsService {
  AnalyticsService._internal() : _analytics = FirebaseAnalytics.instance;

  factory AnalyticsService() => _instance ??= AnalyticsService._internal();
  static AnalyticsService? _instance;

  static const String _installIdKey = 'peptideos_install_id';

  final FirebaseAnalytics _analytics;
  String? _installId;

  String? get installId => _installId;

  /// Generate or load a persistent install ID and propagate it to
  /// Crashlytics, Analytics, RevenueCat, and AppRefer.
  Future<void> initializeIdentity() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _installId = prefs.getString(_installIdKey);
      if (_installId == null) {
        _installId = const Uuid().v4();
        await prefs.setString(_installIdKey, _installId!);
      }

      try {
        await FirebaseCrashlytics.instance.setUserIdentifier(_installId!);
      } catch (_) {}
      try {
        await _analytics.setUserProperty(name: 'install_id', value: _installId);
      } catch (_) {}
      try {
        await Purchases.setAttributes({'install_id': _installId!});
      } catch (_) {}
      try {
        await AppReferSDK.setUserId(_installId!);
      } catch (_) {}
    } catch (e) {
      debugPrint('AnalyticsService.initializeIdentity failed: $e');
    }
  }

  /// Set authenticated user identity across Analytics, Crashlytics, RC, and
  /// AppRefer. Call after successful auth sign-in.
  Future<void> identifyAuthenticatedUser({
    required String userId,
    required String email,
    String? displayName,
    String? firstName,
    String? dateOfBirth,
    String? subscriptionTier,
  }) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (_) {}
    try {
      await _analytics.setUserProperty(name: 'install_id', value: _installId);
    } catch (_) {}

    try {
      final c = FirebaseCrashlytics.instance;
      await c.setUserIdentifier(userId);
      await c.setCustomKey('email', email);
      await c.setCustomKey('install_id', _installId ?? 'unknown');
      if (subscriptionTier != null) {
        await c.setCustomKey('subscription_tier', subscriptionTier);
      }
    } catch (_) {}

    try {
      await Purchases.setAttributes({
        '\$email': email,
        '\$displayName': displayName ?? '',
        'install_id': _installId ?? 'unknown',
        'firebase_uid': userId,
      });
    } catch (_) {}

    try {
      await AppReferSDK.setUserId(userId);
      await AppReferSDK.setAdvancedMatching(
        email: email,
        firstName: firstName ?? _firstToken(displayName),
        dateOfBirth: dateOfBirth,
      );
    } catch (_) {}
  }

  Future<void> sendAppReferAdvancedMatching({
    required String email,
    String? firstName,
    String? dateOfBirth,
  }) async {
    try {
      await AppReferSDK.setAdvancedMatching(
        email: email,
        firstName: firstName,
        dateOfBirth: dateOfBirth,
      );
    } catch (_) {}
  }

  Future<void> clearIdentity() async {
    try {
      await _analytics.setUserId(id: null);
    } catch (_) {}
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier('');
    } catch (_) {}
  }

  // ── Generic event API ──────────────────────────────────────────────────
  Future<void> logEvent(String name, [Map<String, Object>? params]) async {
    try {
      await _analytics.logEvent(name: name, parameters: params);
    } catch (_) {}
  }

  Future<void> setUserProperty(String name, String value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (_) {}
  }

  // ── Onboarding / Paywall ───────────────────────────────────────────────
  Future<void> logOnboardingStarted() => logEvent('onboarding_started');
  Future<void> logOnboardingCompleted() => logEvent('onboarding_completed');
  Future<void> logPaywallViewed(String source) =>
      logEvent('paywall_viewed', {'source': source});
  Future<void> logPlanSelected(String planId) =>
      logEvent('plan_selected', {'plan_id': planId});
  Future<void> logPurchaseInitiated(String planId) =>
      logEvent('purchase_initiated', {'plan_id': planId});
  Future<void> logPurchaseCompleted(String planId, double price) =>
      logEvent('purchase_completed', {'plan_id': planId, 'price': price});
  Future<void> logPurchaseFailed(String planId, String error) =>
      logEvent('purchase_failed', {'plan_id': planId, 'error': error});
  Future<void> logPurchaseRestored() => logEvent('purchase_restored');

  // ── Auth ───────────────────────────────────────────────────────────────
  Future<void> logSignInMethodSelected(String method) =>
      logEvent('signin_method_selected', {'method': method});
  Future<void> logAccountCreated(String method) =>
      logEvent('account_created', {'method': method});

  // ── Protocol / tracking ────────────────────────────────────────────────
  Future<void> logProtocolCreated(int peptideCount) =>
      logEvent('protocol_created', {'peptide_count': peptideCount});
  Future<void> logDoseLogged(String peptideName) =>
      logEvent('dose_logged', {'peptide_name': peptideName});
  Future<void> logBodyMetricLogged() => logEvent('body_metric_logged');

  String? _firstToken(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed.split(RegExp(r'\s+')).first;
  }
}
