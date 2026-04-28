import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/user_settings.dart';
import '../../auth/providers/auth_provider.dart';
import '../../protocol/providers/dose_log_provider.dart';
import '../../protocol/providers/protocol_provider.dart';
import '../../progress/providers/body_metric_provider.dart';
import '../providers/settings_provider.dart';

/// Profile / You tab — user info, subscription, preferences, data, legal.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final settings = settingsProvider.settings;

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
                Text('SYS.USER // PROFILE', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Text('You', style: AppTypography.h1),
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
        _SectionHeader(label: 'ACCOUNT'),
        _Tile(
          icon: Icons.person_outline_rounded,
          label: 'Name',
          value: settings.name,
          onTap: () => _editName(context, settings.name),
        ),
        _Tile(
          icon: Icons.email_outlined,
          label: 'Sign in',
          value: 'Not signed in',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign-in coming soon.')),
            );
          },
        ),

        // ── Preferences ────────────────────────────────────────────────
        _SectionHeader(label: 'PREFERENCES'),
        _Tile(
          icon: Icons.straighten_rounded,
          label: 'Units',
          value: settings.units == UnitSystem.metric ? 'Metric' : 'Imperial',
          onTap: () {
            settingsProvider.update(
              (s) => s.units = s.units == UnitSystem.metric
                  ? UnitSystem.imperial
                  : UnitSystem.metric,
            );
          },
        ),
        _Tile(
          icon: Icons.notifications_outlined,
          label: 'Notifications',
          value: settings.notificationsEnabled ? 'On' : 'Off',
          trailing: Switch(
            value: settings.notificationsEnabled,
            activeThumbColor: AppColors.primary,
            onChanged: (v) async {
              HapticFeedback.selectionClick();
              await settingsProvider.update((s) => s.notificationsEnabled = v);
            },
          ),
        ),

        // ── Data ───────────────────────────────────────────────────────
        _SectionHeader(label: 'DATA'),
        _Tile(
          icon: Icons.download_rounded,
          label: 'Export data',
          value: 'Copy as JSON',
          onTap: () => _exportData(context),
        ),
        _Tile(
          icon: Icons.delete_outline_rounded,
          label: 'Clear all data',
          value: 'Reset app',
          iconColor: AppColors.warning,
          onTap: () => _confirmClearData(context),
        ),

        // ── Legal ──────────────────────────────────────────────────────
        _SectionHeader(label: 'LEGAL'),
        _Tile(
          icon: Icons.gavel_rounded,
          label: 'Terms of Service',
          onTap: () => _showLegal(context, 'Terms of Service', _termsText),
        ),
        _Tile(
          icon: Icons.privacy_tip_outlined,
          label: 'Privacy Policy',
          onTap: () => _showLegal(context, 'Privacy Policy', _privacyText),
        ),
        _Tile(
          icon: Icons.shield_outlined,
          label: 'Medical disclaimer',
          onTap: () => _showLegal(context, 'Disclaimer', _disclaimerText),
        ),

        // ── About ──────────────────────────────────────────────────────
        _SectionHeader(label: 'ABOUT'),
        _Tile(
          icon: Icons.info_outline_rounded,
          label: 'Version',
          value: '1.0.0',
        ),

        // ── Sign out ───────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: PrimaryButton(
              label: 'SIGN OUT',
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
              'Educational tracking only. Not medical advice.',
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
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Text('Your name', style: AppTypography.h3),
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
              'Cancel',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
            child: Text(
              'Save',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
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
                      'scheduledTimes': pp.scheduledTimes,
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
    };

    final json = const JsonEncoder.withIndent('  ').convert(payload);
    await Clipboard.setData(ClipboardData(text: json));
    if (!context.mounted) return;
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data copied to clipboard.')));
  }

  Future<void> _confirmClearData(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Text('Clear all data?', style: AppTypography.h3),
        content: Text(
          'This deletes all protocols, dose logs, and body metrics. The peptide library is preserved. This cannot be undone.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancel',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Clear',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
    if (ok != true) return;
    if (!context.mounted) return;

    await context.read<SettingsProvider>().resetAll();
    if (!context.mounted) return;
    await context.read<ProtocolProvider>().refresh();
    if (!context.mounted) return;
    await context.read<DoseLogProvider>().refresh();
    if (!context.mounted) return;
    await context.read<BodyMetricProvider>().refresh();
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('All data cleared.')));
  }

  Future<void> _signOut(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        title: Text('Sign out?', style: AppTypography.h3),
        content: Text(
          'Your protocols stay saved and sync back when you sign in again.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancel',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Sign out',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
    if (ok != true) return;
    if (!context.mounted) return;
    try {
      await context.read<AuthProvider>().signOut();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign out failed: $e')));
    }
  }

  void _showLegal(BuildContext context, String title, String body) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LegalSheet(title: title, body: body),
    );
  }
}

// ── Avatar card ───────────────────────────────────────────────────────────
class _AvatarCard extends StatelessWidget {
  const _AvatarCard({required this.settings, required this.onEdit});
  final UserSettings settings;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
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
                    isPro ? 'PRO' : 'FREE',
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
                Text('SYS.LEGAL', style: AppTypography.systemLabel),
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

const _termsText =
    'PepMod is provided for educational and tracking purposes only. It is not a medical device and does not provide medical advice, diagnosis, prescriptions, or treatment recommendations. '
    'By using PepMod, you are responsible for your own records, decisions, and consultation with qualified healthcare professionals.\n\n'
    'Subscriptions renew automatically unless cancelled through the App Store or Google Play before the renewal period. Refunds are handled by the store where you purchased.\n\n'
    'Full Terms: https://appstorecopilot.com/legal/yzh32x5v/terms';

const _privacyText =
    'PepMod uses Firebase for authentication and cloud data storage, RevenueCat for subscriptions, AppRefer and Meta/Facebook App Events for attribution, and Firebase/Crashlytics for analytics and diagnostics. '
    'We do not sell your personal information. You can request account/data deletion from within the app or by contacting support.\n\n'
    'Full Privacy Policy: https://appstorecopilot.com/legal/yzh32x5v/privacy';

const _disclaimerText =
    'PepMod is a wellness and tracking tool — NOT a medical device. '
    'Nothing in this app constitutes medical advice, diagnosis, prescription, or treatment recommendation. '
    'Peptides described in the library are for educational purposes only. '
    'Always consult a qualified healthcare provider before starting, changing, or stopping any regimen. '
    'If you experience any adverse effects, seek medical attention immediately.';
