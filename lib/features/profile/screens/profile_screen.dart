import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/services/analytics_service.dart';
import '../../../core/services/support_service.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/services/auth_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/user_settings.dart';
import '../../../services/notification_service.dart';
import '../../protocol/providers/notification_permission_provider.dart';
import '../../protocol/widgets/reminders_blocked_banner.dart';
import '../../auth/providers/auth_provider.dart';
import '../../protocol/providers/dose_log_provider.dart';
import '../../protocol/providers/protocol_provider.dart';
import '../../progress/providers/body_metric_provider.dart';
import '../../library/screens/custom_compound_library_screen.dart';
import '../../library/providers/custom_compound_provider.dart';
import '../providers/settings_provider.dart';

/// Profile / You tab — user info, subscription, preferences, data, legal.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settingsProvider = context.watch<SettingsProvider>();
    final settings = settingsProvider.settings;
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;
    final accountValue = user?.email?.isNotEmpty == true
        ? user!.email!
        : l10n.signedIn;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.huge,
              AppSpacing.screenHorizontal,
              AppSpacing.base,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.profileSystemLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.profileTitle, style: AppTypography.h1),
              ],
            ),
          ),
        ),

        // Avatar card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: _AvatarCard(
              settings: settings,
              onEdit: () => _editName(context, settings.name),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),

        // ── Account ───────────────────────────────────────────────────
        _SectionHeader(label: l10n.sectionAccount),
        _Tile(
          icon: Icons.person_outline_rounded,
          label: l10n.nameLabel,
          value: settings.name,
          onTap: () => _editName(context, settings.name),
        ),
        _Tile(
          icon: Icons.email_outlined,
          label: l10n.accountLabel,
          value: accountValue,
        ),
        _Tile(
          icon: Icons.person_remove_alt_1_outlined,
          label: l10n.deleteAccount,
          value: l10n.removeAccountData,
          iconColor: AppColors.warning,
          onTap: () => _confirmDeleteAccount(context),
        ),

        // ── Preferences ────────────────────────────────────────────────
        _SectionHeader(label: l10n.sectionPreferences),
        _Tile(
          icon: Icons.straighten_rounded,
          label: l10n.unitsLabel,
          value: settings.units == UnitSystem.metric
              ? l10n.metricLabel
              : l10n.imperialLabel,
          onTap: () {
            settingsProvider.update(
              (s) => s.units = s.units == UnitSystem.metric
                  ? UnitSystem.imperial
                  : UnitSystem.metric,
            );
          },
        ),
        _Tile(
          icon: Icons.science_outlined,
          label: l10n.doseUnitPreferenceLabel,
          value: settings.doseUnitPreference == DoseUnitPreference.original
              ? l10n.doseUnitPreferenceOriginal
              : settings.doseUnitPreference.name,
          onTap: () => _selectDoseUnit(context),
        ),
        _Tile(
          icon: Icons.notifications_outlined,
          label: l10n.notificationsLabel,
          value: settings.notificationsEnabled ? l10n.onLabel : l10n.offLabel,
          trailing: Switch(
            value: settings.notificationsEnabled,
            activeThumbColor: AppColors.primary,
            onChanged: (v) async {
              HapticFeedback.selectionClick();
              await _setNotificationsEnabled(context, v);
            },
          ),
        ),
        _Tile(
          icon: Icons.language_rounded,
          label: l10n.languageLabel,
          value: _languageName(settings.localeCode, l10n),
          onTap: () => _selectLanguage(context, settings.localeCode),
        ),
        const SliverToBoxAdapter(
          child: RemindersBlockedBanner(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
              AppSpacing.screenHorizontal,
              0,
            ),
          ),
        ),

        // ── Data ───────────────────────────────────────────────────────
        _SectionHeader(label: l10n.sectionData),
        _Tile(
          icon: Icons.inventory_2_outlined,
          label: l10n.myCompoundsProfile,
          value: l10n.savedVialPresets,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CustomCompoundLibraryScreen(),
            ),
          ),
        ),
        _Tile(
          icon: Icons.download_rounded,
          label: l10n.exportData,
          value: l10n.copyAsJson,
          onTap: () => _exportData(context),
        ),
        _Tile(
          icon: Icons.delete_outline_rounded,
          label: l10n.clearAllData,
          value: auth.isClearingAppData ? l10n.clearingLabel : l10n.resetApp,
          iconColor: AppColors.warning,
          onTap: auth.isClearingAppData
              ? null
              : () => _confirmClearData(context),
        ),

        // ── Support ────────────────────────────────────────────────────
        _SectionHeader(label: l10n.sectionSupport),
        _Tile(
          icon: Icons.support_agent_rounded,
          label: l10n.contactSupport,
          value: l10n.chatWithUs,
          onTap: () => _openSupport(context),
        ),

        // ── Legal ──────────────────────────────────────────────────────
        _SectionHeader(label: l10n.sectionLegal),
        _Tile(
          icon: Icons.gavel_rounded,
          label: l10n.termsOfService,
          onTap: () => _showLegal(context, _LegalDocument.terms),
        ),
        _Tile(
          icon: Icons.privacy_tip_outlined,
          label: l10n.privacyPolicy,
          onTap: () => _showLegal(context, _LegalDocument.privacy),
        ),
        _Tile(
          icon: Icons.shield_outlined,
          label: l10n.medicalDisclaimer,
          onTap: () => _showLegal(context, _LegalDocument.disclaimer),
        ),

        // ── About ──────────────────────────────────────────────────────
        _SectionHeader(label: l10n.sectionAbout),
        _Tile(
          icon: Icons.info_outline_rounded,
          label: l10n.versionLabel,
          value: '1.0.0',
        ),

        // ── Sign out ───────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: PrimaryButton(
              label: l10n.signOutAction,
              icon: Icons.logout_rounded,
              isDestructive: true,
              onPressed: () => _signOut(context),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: Text(
              l10n.educationalTrackingDisclaimer,
              style: AppTypography.disclaimer,
              textAlign: TextAlign.center,
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: AppSpacing.screenBottom),
        ),
      ],
    );
  }

  Future<void> _editName(BuildContext context, String current) async {
    final controller = TextEditingController(text: current);
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            side: const BorderSide(color: AppColors.border),
          ),
          title: Text(l10n.yourName, style: AppTypography.h3),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: AppTypography.bodyLarge,
            decoration: const InputDecoration(border: UnderlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                l10n.cancelLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
              child: Text(
                l10n.saveLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
    controller.dispose();
    if (!context.mounted) return;
    if (name != null && name.isNotEmpty) {
      await context.read<SettingsProvider>().update((s) => s.name = name);
    }
  }

  Future<void> _exportData(BuildContext context) async {
    final protocols = context.read<ProtocolProvider>().all;
    final logs = context.read<DoseLogProvider>().recent30;
    final metrics = context.read<BodyMetricProvider>().all;
    final customCompounds = context.read<CustomCompoundProvider>().all;

    final payload = {
      'exportedAt': DateTime.now().toIso8601String(),
      'protocols': protocols
          .map(
            (p) => {
              'uuid': p.uuid,
              'name': p.name,
              'status': p.status.name,
              'startDate': p.startDate.toIso8601String(),
              'endDate': p.endDate?.toIso8601String(),
              'peptides': p.peptides
                  .map(
                    (pp) => {
                      'uuid': pp.uuid,
                      'slug': pp.peptideSlug,
                      'name': pp.peptideName,
                      'dose': pp.dosePerInjection,
                      'unit': pp.doseUnit,
                      'frequency': pp.frequency,
                      'route': pp.route,
                      'cycleWeeks': pp.cycleWeeks,
                      'washoutWeeks': pp.washoutWeeks,
                      'syringeUnits': pp.syringeUnits,
                      'labelColorHex': pp.labelColorHex,
                      'scheduledTimes': pp.scheduledTimes,
                      'weekdayDoses': pp.weekdayDoses
                          .map((d) => d.toMap())
                          .toList(),
                    },
                  )
                  .toList(),
            },
          )
          .toList(),
      'doseLogs': logs
          .map(
            (d) => {
              'uuid': d.uuid,
              'protocolUuid': d.protocolUuid,
              'peptideName': d.peptideName,
              'scheduledAt': d.scheduledAt.toIso8601String(),
              'takenAt': d.takenAt?.toIso8601String(),
              'amount': d.amountTaken,
              'units': d.units,
              'site': d.injectionSite,
              'skipped': d.skipped,
              'notes': d.notes,
            },
          )
          .toList(),
      'bodyMetrics': metrics
          .map(
            (m) => {
              'uuid': m.uuid,
              'date': m.date.toIso8601String(),
              'weightKg': m.weightKg,
              'bodyFatPct': m.bodyFatPct,
              'measurements': m.measurements
                  .map((e) => {'key': e.key, 'valueCm': e.valueCm})
                  .toList(),
              'notes': m.notes,
            },
          )
          .toList(),
      'customCompounds': customCompounds
          .map((compound) => {'id': compound.id, ...compound.toMap()})
          .toList(),
    };

    final json = const JsonEncoder.withIndent('  ').convert(payload);
    await Clipboard.setData(ClipboardData(text: json));
    if (!context.mounted) return;
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).dataCopied)),
    );
  }

  Future<void> _confirmClearData(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            side: const BorderSide(color: AppColors.border),
          ),
          title: Text(l10n.clearDataTitle, style: AppTypography.h3),
          content: Text(l10n.clearDataBody, style: AppTypography.bodyMedium),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                l10n.cancelLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(
                l10n.clearLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.warning,
                ),
              ),
            ),
          ],
        );
      },
    );
    if (ok != true) return;
    if (!context.mounted) return;

    final navigator = Navigator.of(context, rootNavigator: true);
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (dialogContext) {
          final l10n = AppLocalizations.of(dialogContext);
          return PopScope(
            canPop: false,
            child: AlertDialog(
              backgroundColor: AppColors.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                side: const BorderSide(color: AppColors.border),
              ),
              title: Text(l10n.clearingDataTitle, style: AppTypography.h3),
              content: Row(
                children: [
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.clearingDataBody,
                      style: AppTypography.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    void closeProgress() {
      if (navigator.mounted && navigator.canPop()) navigator.pop();
    }

    try {
      await context.read<AuthProvider>().clearAppData();
    } catch (e) {
      closeProgress();
      debugPrint('Clear app data failed: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).clearDataFailed)),
      );
      return;
    }
    closeProgress();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).allDataCleared)),
    );
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final auth = context.read<AuthProvider>();
    final accountDeletionFailedMessage = AppLocalizations.of(
      context,
    ).accountDeletionFailed;
    final usesPassword = auth.authService.currentUserUsesPasswordProvider;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            side: const BorderSide(color: AppColors.border),
          ),
          title: Text(l10n.deleteAccountTitle, style: AppTypography.h3),
          content: Text(
            l10n.deleteAccountBody,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                l10n.cancelLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(
                l10n.deleteAccount,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.warning,
                ),
              ),
            ),
          ],
        );
      },
    );
    if (ok != true || !context.mounted) return;

    String? password;
    if (usesPassword) {
      password = await _promptDeletePassword(context);
      if (password == null || !context.mounted) return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            side: const BorderSide(color: AppColors.border),
          ),
          content: Row(
            children: [
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  l10n.deletingAccount,
                  style: AppTypography.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
    final rootNavigator = Navigator.of(context, rootNavigator: true);
    final messenger = ScaffoldMessenger.of(context);

    try {
      await auth.deleteAccount(password: password);
      if (rootNavigator.canPop()) rootNavigator.pop();
    } on AuthException catch (e) {
      debugPrint('Account deletion auth failure (${e.code}): ${e.message}');
      if (rootNavigator.canPop()) rootNavigator.pop();
      messenger.showSnackBar(
        SnackBar(content: Text(accountDeletionFailedMessage)),
      );
    } catch (e) {
      debugPrint('Account deletion failed: $e');
      if (rootNavigator.canPop()) rootNavigator.pop();
      messenger.showSnackBar(
        SnackBar(content: Text(accountDeletionFailedMessage)),
      );
    }
  }

  Future<String?> _promptDeletePassword(BuildContext context) async {
    final controller = TextEditingController();
    final password = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            side: const BorderSide(color: AppColors.border),
          ),
          title: Text(l10n.confirmPassword, style: AppTypography.h3),
          content: TextField(
            controller: controller,
            autofocus: true,
            obscureText: true,
            style: AppTypography.bodyLarge,
            decoration: InputDecoration(
              labelText: l10n.passwordLabel,
              border: const UnderlineInputBorder(),
            ),
            onSubmitted: (value) => Navigator.of(ctx).pop(value.trim()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                l10n.cancelLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
              child: Text(
                l10n.deleteLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.warning,
                ),
              ),
            ),
          ],
        );
      },
    );
    controller.dispose();
    return password;
  }

  Future<void> _selectDoseUnit(BuildContext context) async {
    final provider = context.read<SettingsProvider>();
    final l10n = AppLocalizations.of(context);
    final selected = await showModalBottomSheet<DoseUnitPreference>(
      context: context,
      backgroundColor: AppColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.doseUnitPreferenceLabel, style: AppTypography.h2),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.doseUnitPreferenceDescription,
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.base),
              for (final unit in DoseUnitPreference.values)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    onTap: () => Navigator.of(sheetContext).pop(unit),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            unit == DoseUnitPreference.original
                                ? l10n.doseUnitPreferenceOriginal
                                : unit.name,
                            style: AppTypography.bodyLarge,
                          ),
                        ),
                        if (unit == provider.settings.doseUnitPreference)
                          const Icon(
                            Icons.check_rounded,
                            color: AppColors.primary,
                          ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.doseUnitPreferencePreview,
                style: AppTypography.tabular,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.doseUnitPreferenceIuNote,
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
    if (selected != null) {
      await provider.update(
        (settings) => settings.doseUnitPreference = selected,
      );
    }
  }

  Future<void> _signOut(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          title: Text(l10n.signOutTitle, style: AppTypography.h3),
          content: Text(
            l10n.signOutBody,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                l10n.cancelLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(
                l10n.signOutLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.warning,
                ),
              ),
            ),
          ],
        );
      },
    );
    if (ok != true) return;
    if (!context.mounted) return;
    try {
      await context.read<AuthProvider>().signOut();
    } catch (e) {
      debugPrint('Sign out failed: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).signOutFailed)),
      );
    }
  }

  void _showLegal(BuildContext context, _LegalDocument document) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final l10n = AppLocalizations.of(sheetContext);
        final (title, body) = switch (document) {
          _LegalDocument.terms => (l10n.termsOfService, l10n.termsBody),
          _LegalDocument.privacy => (l10n.privacyPolicy, l10n.privacyBody),
          _LegalDocument.disclaimer => (
            l10n.disclaimerTitle,
            l10n.medicalDisclaimerBody,
          ),
        };
        return _LegalSheet(title: title, body: body);
      },
    );
  }

  Future<void> _openSupport(BuildContext context) async {
    HapticFeedback.selectionClick();
    unawaited(AnalyticsService().logSupportOpened());
    await SupportService.instance.openSupport();
  }

  Future<void> _setNotificationsEnabled(
    BuildContext context,
    bool enabled,
  ) async {
    final settingsProvider = context.read<SettingsProvider>();
    final protocols = context.read<ProtocolProvider>();
    final permissionProvider = context.read<NotificationPermissionProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final notificationsDisabledMessage = AppLocalizations.of(
      context,
    ).notificationsDisabledSystem;

    if (!enabled) {
      await settingsProvider.update((s) => s.notificationsEnabled = false);
      await protocols.syncDoseReminders(enabled: false);
      return;
    }

    final granted = await NotificationService.instance.requestPermission();
    if (!context.mounted) return;

    if (!granted) {
      // Keep the user's intent on so the persistent reminders-blocked banner
      // (with its Open Settings CTA) appears; re-granting in system settings
      // then resumes reminders automatically on return.
      await settingsProvider.update((s) => s.notificationsEnabled = true);
      await permissionProvider.refresh();
      messenger.showSnackBar(
        SnackBar(content: Text(notificationsDisabledMessage)),
      );
      return;
    }

    await settingsProvider.update((s) => s.notificationsEnabled = true);
    await protocols.syncDoseReminders(enabled: true);
    await permissionProvider.refresh();
  }
}

String _languageName(String code, AppLocalizations l10n) => switch (code) {
  'en' => 'English',
  'es' => 'Español',
  'fr' => 'Français',
  'it' => 'Italiano',
  'de' => 'Deutsch',
  'ja' => '日本語',
  'ko' => '한국어',
  'pt' => 'Português',
  'pt_BR' => 'Português (Brasil)',
  _ => l10n.languageSystemDefault,
};

Future<void> _selectLanguage(BuildContext context, String selected) async {
  final l10n = AppLocalizations.of(context);
  final options = <(String, String)>[
    ('', l10n.languageSystemDefault),
    ('en', 'English'),
    ('es', 'Español'),
    ('fr', 'Français'),
    ('it', 'Italiano'),
    ('de', 'Deutsch'),
    ('ja', '日本語'),
    ('ko', '한국어'),
    ('pt', 'Português'),
    ('pt_BR', 'Português (Brasil)'),
  ];
  final next = await showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.surfaceContainer,
    isScrollControlled: true,
    builder: (sheetContext) => FractionallySizedBox(
      heightFactor: 0.78,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(l10n.selectLanguageTitle, style: AppTypography.h2),
            ),
            Expanded(
              child: ListView(
                key: const Key('language-options-list'),
                children: [
                  for (final option in options)
                    ListTile(
                      title: Text(option.$2, style: AppTypography.bodyLarge),
                      trailing: option.$1 == selected
                          ? const Icon(
                              Icons.check_rounded,
                              color: AppColors.primary,
                            )
                          : null,
                      onTap: () => Navigator.of(sheetContext).pop(option.$1),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  if (next == null || !context.mounted) return;
  HapticFeedback.selectionClick();
  await context.read<SettingsProvider>().update((s) => s.localeCode = next);
}

// ── Avatar card ───────────────────────────────────────────────────────────
class _AvatarCard extends StatelessWidget {
  const _AvatarCard({required this.settings, required this.onEdit});
  final UserSettings settings;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isPro =
        settings.subscriptionState == 'pro' ||
        settings.subscriptionState == 'active';
    return AppCard(
      onTap: onEdit,
      borderColor: AppColors.borderCyan,
      glowColor: AppColors.primaryGlow,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.15),
              border: Border.all(color: AppColors.borderCyan),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Icon(
              Icons.person_rounded,
              color: AppColors.primary,
              size: AppSpacing.iconXLarge,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(settings.name, style: AppTypography.h3),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: (isPro ? AppColors.primary : AppColors.textTertiary)
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color:
                          (isPro ? AppColors.primary : AppColors.textTertiary)
                              .withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    isPro ? l10n.planPro : l10n.planFree,
                    style: AppTypography.systemLabel.copyWith(
                      color: isPro ? AppColors.primary : AppColors.textTertiary,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.edit_rounded,
            color: AppColors.textTertiary,
            size: AppSpacing.iconMedium,
          ),
        ],
      ),
    );
  }
}

// ── Section header ────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.xl,
          AppSpacing.screenHorizontal,
          AppSpacing.sm,
        ),
        child: Text(label, style: AppTypography.systemLabel),
      ),
    );
  }
}

// ── Settings tile ─────────────────────────────────────────────────────────
class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.label,
    this.value,
    this.iconColor,
    this.trailing,
    this.onTap,
  });
  final IconData icon;
  final String label;
  final String? value;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          0,
          AppSpacing.screenHorizontal,
          AppSpacing.cardGap,
        ),
        child: AppCard(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: AppSpacing.iconDefault,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTypography.labelLarge),
                    if (value != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        value!,
                        style: AppTypography.bodySmall.copyWith(
                          fontFamily: 'JetBrainsMono',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else if (onTap != null)
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textTertiary,
                  size: AppSpacing.iconMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegalSheet extends StatelessWidget {
  const _LegalSheet({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FractionallySizedBox(
      heightFactor: 0.75,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.sheetRadius),
          ),
          border: Border.all(color: AppColors.border),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: AppSpacing.sheetHandleWidth,
                    height: AppSpacing.sheetHandleHeight,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.sheetHandleHeight,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.legalSystemLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Text(title, style: AppTypography.h2),
                const SizedBox(height: AppSpacing.lg),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(body, style: AppTypography.bodyMedium),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _LegalDocument { terms, privacy, disclaimer }
