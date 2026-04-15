import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Profile/You tab — vial inventory, subscription, settings, data export.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text('You', style: AppTypography.h1),
              ],
            ),
          ),
        ),

        // ── Vial Inventory Summary ───────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Vial Inventory', style: AppTypography.labelLarge),
                      const Spacer(),
                      Text(
                        'Manage',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _VialRow(
                    name: 'BPC-157',
                    dosesLeft: 18,
                    totalDoses: 30,
                    expiresIn: '12 days',
                    status: _VialStatus.ok,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _VialRow(
                    name: 'TB-500',
                    dosesLeft: 4,
                    totalDoses: 20,
                    expiresIn: '3 days',
                    status: _VialStatus.warning,
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Settings Menu ────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: Text('Settings', style: AppTypography.h3),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          sliver: SliverList.list(
            children: [
              _SettingsItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.notifications_rounded,
                label: 'Notifications',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.star_rounded,
                label: 'Subscription',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.download_rounded,
                label: 'Export Data',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.share_rounded,
                label: 'Share Protocol',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.help_outline_rounded,
                label: 'Support',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.info_outline_rounded,
                label: 'About & Legal',
                onTap: () {},
                showDivider: false,
              ),
            ],
          ),
        ),

        // ── Disclaimer ───────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: Text(
              'PeptideOS is for tracking and educational purposes only. '
              'It does not provide medical advice, diagnosis, or treatment. '
              'Always consult a qualified healthcare provider.',
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
}

// ── Supporting widgets ────────────────────────────────────────────────────

enum _VialStatus { ok, warning, danger }

class _VialRow extends StatelessWidget {
  const _VialRow({
    required this.name,
    required this.dosesLeft,
    required this.totalDoses,
    required this.expiresIn,
    required this.status,
  });

  final String name;
  final int dosesLeft;
  final int totalDoses;
  final String expiresIn;
  final _VialStatus status;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (status) {
      _VialStatus.ok => AppColors.success,
      _VialStatus.warning => AppColors.warning,
      _VialStatus.danger => AppColors.danger,
    };

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTypography.labelMedium),
              Text(
                '$dosesLeft doses left · expires in $expiresIn',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
        // Mini progress bar
        SizedBox(
          width: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: dosesLeft / totalDoses,
              backgroundColor: AppColors.inputFill,
              color: statusColor,
              minHeight: 4,
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: AppSpacing.iconDefault,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(label, style: AppTypography.bodyMedium),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: AppSpacing.iconMedium,
                  color: AppColors.textDisabled,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(),
      ],
    );
  }
}
