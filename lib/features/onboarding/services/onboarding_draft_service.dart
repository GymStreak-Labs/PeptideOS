import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/analytics_service.dart';
import '../../../features/library/providers/peptide_provider.dart';
import '../../../features/profile/providers/settings_provider.dart';
import '../../../features/protocol/providers/dose_log_provider.dart';
import '../../../features/protocol/providers/protocol_provider.dart';
import '../../../models/peptide.dart';
import '../../../models/protocol.dart';

/// Local handoff between pre-auth onboarding and post-auth Firestore state.
///
/// Onboarding intentionally collects personalization before sign-in, then
/// shows auth before the paywall so AppRefer / RevenueCat purchases attach to
/// a stable Firebase UID. The selected protocol/profile data is staged here,
/// then replayed once Firebase gives us that UID.
class OnboardingDraftService {
  OnboardingDraftService._();

  static const String _draftKey = 'peptideos_onboarding_draft_v1';
  static const String _postAuthPaywallPendingKey =
      'pepmod_post_auth_paywall_pending_v1';

  static Future<void> save(OnboardingDraft draft) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_draftKey, jsonEncode(draft.toMap()));
  }

  static Future<OnboardingDraft?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_draftKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;
      return OnboardingDraft.fromMap(data);
    } catch (e) {
      debugPrint('OnboardingDraftService.load failed: $e');
      return null;
    }
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftKey);
  }

  static Future<bool> hasDraft() async => (await load()) != null;

  static Future<void> setPostAuthPaywallPending(bool pending) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_postAuthPaywallPendingKey, pending);
  }

  static Future<bool> isPostAuthPaywallPending() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_postAuthPaywallPendingKey) ?? false;
  }

  static Future<void> replayAfterAuth({
    required String email,
    required SettingsProvider settings,
    required ProtocolProvider protocols,
    required DoseLogProvider doseLogs,
    required PeptideProvider library,
  }) async {
    if (settings.uid.isEmpty || protocols.uid.isEmpty) return;
    final draft = await load();
    if (draft == null) return;

    try {
      await settings.completeOnboarding(
        name: draft.firstName,
        birthDate: draft.birthDate,
        goals: draft.goals,
        experience: draft.experience,
        frustration: draft.frustration,
      );

      await AnalyticsService().sendAppReferAdvancedMatching(
        email: email,
        firstName: draft.firstName,
        dateOfBirth: draft.birthDate,
      );

      if (draft.selectedPeptides.isNotEmpty && protocols.all.isEmpty) {
        if (library.all.isEmpty) {
          await library.refresh();
        }
        final peptideEntries = <ProtocolPeptide>[];
        for (final name in draft.selectedPeptides) {
          final lib = _findLibraryPeptide(library, name);
          if (lib == null) continue;
          peptideEntries.add(
            protocols.buildPeptide(
              slug: lib.slug,
              name: lib.name,
              dose: lib.defaultDoseMcg,
              frequency: lib.defaultFrequency,
              route: lib.defaultRoute,
              cycleWeeks: lib.typicalCycleWeeks,
            ),
          );
        }

        if (peptideEntries.isNotEmpty) {
          await protocols.createProtocol(
            name: 'My Protocol',
            startDate: DateTime.now(),
            peptides: peptideEntries,
          );
          await doseLogs.refresh();
        }
      }

      await clear();
    } catch (e) {
      debugPrint('OnboardingDraftService.replayAfterAuth failed: $e');
    }
  }

  static Peptide? _findLibraryPeptide(PeptideProvider library, String name) {
    final needle = name.toLowerCase();
    for (final p in library.all) {
      if (p.name.toLowerCase() == needle || p.slug.toLowerCase() == needle) {
        return p;
      }
    }
    return null;
  }
}

class OnboardingDraft {
  const OnboardingDraft({
    required this.firstName,
    required this.birthDate,
    required this.goals,
    required this.experience,
    required this.frustration,
    required this.selectedPeptides,
  });

  final String firstName;

  /// ISO-8601 date only (`yyyy-MM-dd`) for AppRefer advanced matching.
  final String birthDate;
  final List<String> goals;
  final String experience;
  final String frustration;
  final List<String> selectedPeptides;

  Map<String, dynamic> toMap() => <String, dynamic>{
    'firstName': firstName,
    'birthDate': birthDate,
    'goals': goals,
    'experience': experience,
    'frustration': frustration,
    'selectedPeptides': selectedPeptides,
  };

  factory OnboardingDraft.fromMap(Map<String, dynamic> data) {
    return OnboardingDraft(
      firstName: (data['firstName'] as String?) ?? '',
      birthDate: (data['birthDate'] as String?) ?? '',
      goals: (data['goals'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      experience: (data['experience'] as String?) ?? '',
      frustration: (data['frustration'] as String?) ?? '',
      selectedPeptides: (data['selectedPeptides'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
