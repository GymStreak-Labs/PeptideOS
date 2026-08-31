import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';
import '../../profile/providers/settings_provider.dart';
import '../providers/notification_permission_provider.dart';

/// Persistent recovery card shown when the user wants dose reminders but the
/// OS notification permission is denied. Renders nothing otherwise — it never
/// nags users who deliberately keep reminders off, and it never re-prompts.
class RemindersBlockedBanner extends StatelessWidget {
  const RemindersBlockedBanner({super.key, this.padding = EdgeInsets.zero});

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>().settings;
    final permission = context.watch<NotificationPermissionProvider>();
    if (!settings.notificationsEnabled || !permission.isBlocked) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: padding,
      child: AppCard(
        borderColor: AppColors.warning.withValues(alpha: 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.notifications_off_outlined,
                  color: AppColors.warning,
                  size: AppSpacing.iconMedium,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.remindersBlockedTitle,
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.warning,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.remindersBlockedBody, style: AppTypography.bodySmall),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: () {
                HapticFeedback.selectionClick();
                permission.openSystemSettings();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.warning,
                side: BorderSide(
                  color: AppColors.warning.withValues(alpha: 0.7),
                ),
                minimumSize: const Size.fromHeight(40),
              ),
              icon: const Icon(Icons.settings_outlined, size: 16),
              label: Text(
                l10n.openSettingsAction,
                style: AppTypography.button.copyWith(color: AppColors.warning),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
