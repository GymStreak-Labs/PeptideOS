import 'package:apprefer/apprefer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../data/services/subscription_service.dart';
import '../../data/services/superwall_bridge_service.dart';
import 'support_service.dart';

/// Analytics singleton — wraps Firebase Analytics + stamps a stable install ID
/// on Crashlytics, RC, AppRefer, and Gleap so attribution/support can tie
/// installs to users.
///
/// Usage: `AnalyticsService().logPaywallViewed('onboarding');`.
class AnalyticsService {
  AnalyticsService._internal() : _analytics = FirebaseAnalytics.instance;

  factory AnalyticsService() => _instance ??= AnalyticsService._internal();
  static AnalyticsService? _instance;

  static const String _installIdKey = 'peptideos_install_id';

  final FirebaseAnalytics _analytics;
  String? _installId;
  String? _authenticatedUserId;
  String? _authenticatedEmail;
  String? _authenticatedDisplayName;
  String? _authenticatedFirstName;
  String? _authenticatedDateOfBirth;
  String? _advancedMatchingEmail;
  String? _advancedMatchingFirstName;
  String? _advancedMatchingDateOfBirth;

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
        await SubscriptionService.instance.setAttributes({
          'install_id': _installId!,
        });
      } catch (_) {}
      try {
        await SupportService.instance.attachInstallIdentity(_installId!);
      } catch (_) {}
      try {
        await SuperwallBridgeService.instance.setUserAttributes({
          'install_id': _installId!,
        });
      } catch (_) {}
      await syncAppReferIdentity();
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
    _authenticatedUserId = userId;
    _authenticatedEmail = email;
    _authenticatedDisplayName = displayName;
    _authenticatedFirstName = firstName;
    _authenticatedDateOfBirth = dateOfBirth;

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
      final attributes = <String, String>{
        '\$email': email,
        '\$displayName': displayName ?? '',
        'install_id': _installId ?? 'unknown',
        'firebase_uid': userId,
      };
      final appReferId = await AppReferSDK.getDeviceId();
      if (appReferId != null) attributes['appreferId'] = appReferId;
      await SubscriptionService.instance.setAttributes(attributes);
    } catch (_) {}
    try {
      await SuperwallBridgeService.instance.identifyUser(
        userId: userId,
        installId: _installId,
        subscriptionTier: subscriptionTier,
      );
    } catch (_) {}

    try {
      await SupportService.instance.identifyAuthenticatedUser(
        userId: userId,
        email: email,
        displayName: displayName,
        subscriptionTier: subscriptionTier,
      );
      await SupportService.instance.attachCustomData({
        'install_id': _installId ?? 'unknown',
      });
    } catch (_) {}

    await syncAppReferIdentity();
  }

  Future<void> sendAppReferAdvancedMatching({
    required String email,
    String? firstName,
    String? dateOfBirth,
  }) async {
    _advancedMatchingEmail = email;
    _advancedMatchingFirstName = firstName;
    _advancedMatchingDateOfBirth = dateOfBirth;
    await syncAppReferIdentity();
  }

  /// Replays the best known AppRefer identity after SDK configure.
  ///
  /// The AppRefer SDK intentionally ignores identity calls made before
  /// `configure()`, so startup and auth flows store the latest values here and
  /// replay them once main.dart has completed first-frame attribution setup.
  Future<void> syncAppReferIdentity() async {
    try {
      final userId = _nonEmpty(_authenticatedUserId) ?? _nonEmpty(_installId);
      if (userId != null) await AppReferSDK.setUserId(userId);
    } catch (_) {}

    try {
      final email =
          _nonEmpty(_advancedMatchingEmail) ?? _nonEmpty(_authenticatedEmail);
      final firstName =
          _nonEmpty(_advancedMatchingFirstName) ??
          _nonEmpty(_authenticatedFirstName) ??
          _firstToken(_authenticatedDisplayName);
      final dateOfBirth =
          _nonEmpty(_advancedMatchingDateOfBirth) ??
          _nonEmpty(_authenticatedDateOfBirth);
      if (email != null || firstName != null || dateOfBirth != null) {
        await AppReferSDK.setAdvancedMatching(
          email: email,
          firstName: firstName,
          dateOfBirth: dateOfBirth,
        );
      }
    } catch (_) {}

    try {
      final appReferId = await AppReferSDK.getDeviceId();
      if (appReferId != null) {
        await SubscriptionService.instance.setAttributes({
          'appreferId': appReferId,
        });
        await SuperwallBridgeService.instance.setUserAttributes({
          'apprefer_id': appReferId,
        });
      }
    } catch (_) {}
  }

  Future<void> clearIdentity() async {
    try {
      await _analytics.setUserId(id: null);
    } catch (_) {}
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier('');
    } catch (_) {}
    try {
      await SupportService.instance.clearIdentity();
    } catch (_) {}
  }

  // ── Generic event API ──────────────────────────────────────────────────
  Future<void> logEvent(String name, [Map<String, Object>? params]) async {
    try {
      await _analytics.logEvent(name: name, parameters: params);
    } catch (_) {}
    try {
      await SupportService.instance.trackEvent(name, params);
    } catch (_) {}
  }

  Future<void> setUserProperty(String name, String value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (_) {}
  }

  // ── Onboarding / Paywall ───────────────────────────────────────────────
  Future<void> logOnboardingStarted() => logEvent('onboarding_started');
  Future<void> logOnboardingScreenViewed({
    required int stepIndex,
    required int stepPosition,
    required int stepTotal,
    required String stepName,
  }) => logEvent('onboarding_screen_viewed', {
    'step_index': stepIndex,
    'step_position': stepPosition,
    'step_total': stepTotal,
    'step_name': stepName,
  });
  Future<void> logOnboardingCompleted({
    required int stepTotal,
    required int goalCount,
    required int peptideCount,
    required bool hasFirstName,
    required bool hasBirthDate,
    required bool hasExperience,
    required bool hasFrustration,
  }) => logEvent('onboarding_completed', {
    'step_total': stepTotal,
    'goal_count': goalCount,
    'peptide_count': peptideCount,
    'has_first_name': hasFirstName ? 1 : 0,
    'has_birth_date': hasBirthDate ? 1 : 0,
    'has_experience': hasExperience ? 1 : 0,
    'has_frustration': hasFrustration ? 1 : 0,
  });
  Future<void> logPaywallViewed(String source) =>
      logEvent('paywall_viewed', {'source': source});
  Future<void> logPlanSelected(String planId) =>
      logEvent('plan_selected', {'plan_id': planId});
  Future<void> logPurchaseInitiated(String planId) =>
      logEvent('purchase_initiated', {'plan_id': planId});
  Future<void> logPurchaseCompleted(String planId, double price) =>
      logEvent('purchase_completed', {'plan_id': planId, 'price': price});
  Future<void> logPurchaseCancelled(String planId) =>
      logEvent('purchase_cancelled', {'plan_id': planId});
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
  Future<void> logSupportOpened() => logEvent('support_opened');

  String? _firstToken(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed.split(RegExp(r'\s+')).first;
  }

  String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
