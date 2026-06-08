import 'package:flutter/foundation.dart';
import 'package:gleap_sdk/gleap_sdk.dart';
import 'package:gleap_sdk/models/gleap_user_property_model/gleap_user_property_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// App support wrapper around Gleap with a safe email fallback.
///
/// The SDK token is intentionally injected by build tooling:
/// `--dart-define=GLEAP_SDK_TOKEN=...`.
class SupportService {
  SupportService._();

  static final SupportService instance = SupportService._();

  static const String _gleapSdkToken = String.fromEnvironment(
    'GLEAP_SDK_TOKEN',
  );
  static const String _supportEmail = 'support@gymstreak.com';
  static const String _appName = 'PepMod';

  bool _initialized = false;
  bool _attemptedInit = false;

  bool get isGleapConfigured => _gleapSdkToken.trim().isNotEmpty;
  bool get isReady => _initialized;

  Future<void> initialize() async {
    if (_attemptedInit) return;
    _attemptedInit = true;

    if (!isGleapConfigured) {
      debugPrint('Gleap init skipped: GLEAP_SDK_TOKEN not configured.');
      return;
    }

    try {
      await Gleap.initialize(token: _gleapSdkToken);
      await Gleap.showFeedbackButton(false);
      _initialized = true;
      await _attachAppContext();
    } catch (e) {
      _initialized = false;
      debugPrint('Gleap init failed: $e');
    }
  }

  Future<void> attachInstallIdentity(String installId) async {
    await attachCustomData({'install_id': installId});
  }

  Future<void> identifyAuthenticatedUser({
    required String userId,
    required String email,
    String? displayName,
    String? subscriptionTier,
  }) async {
    if (!_initialized) return;
    try {
      await Gleap.identifyContact(
        userId: userId,
        userProperties: GleapUserProperty(
          email: _nonEmpty(email),
          name: _nonEmpty(displayName),
          plan: _nonEmpty(subscriptionTier),
        ),
      );
      await attachCustomData({
        'firebase_uid': userId,
        if (_nonEmpty(subscriptionTier) != null)
          'subscription_tier': subscriptionTier!.trim(),
      });
    } catch (_) {}
  }

  Future<void> clearIdentity() async {
    if (!_initialized) return;
    try {
      await Gleap.clearIdentity();
    } catch (_) {}
  }

  Future<void> trackEvent(String name, [Map<String, Object>? params]) async {
    if (!_initialized) return;
    try {
      await Gleap.trackEvent(name: name, data: params);
    } catch (_) {}
  }

  Future<void> openSupport() async {
    if (_initialized) {
      try {
        await Gleap.open();
        return;
      } catch (e) {
        debugPrint('Gleap open failed, falling back to email: $e');
      }
    }

    final uri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      queryParameters: {
        'subject': 'PepMod support',
        'body': 'Hi PepMod support,',
      },
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Support email fallback failed: $uri');
    }
  }

  Future<void> attachCustomData(Map<String, Object?> data) async {
    if (!_initialized) return;
    final clean = <String, Object>{};
    for (final entry in data.entries) {
      final value = entry.value;
      if (value == null) continue;
      if (value is String && value.trim().isEmpty) continue;
      clean[entry.key] = value;
    }
    if (clean.isEmpty) return;
    try {
      await Gleap.attachCustomData(customData: clean);
    } catch (_) {}
  }

  Future<void> _attachAppContext() async {
    try {
      final info = await PackageInfo.fromPlatform();
      await attachCustomData({
        'app_name': _appName,
        'app_version': info.version,
        'build_number': info.buildNumber,
        'package_name': info.packageName,
      });
    } catch (_) {
      await attachCustomData({'app_name': _appName});
    }
  }

  String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
