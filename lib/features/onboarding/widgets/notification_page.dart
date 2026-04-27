import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen 11: Notification Permission warm-up.
/// Explains the value BEFORE the system prompt fires.
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Notification bell with glow
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_active_rounded,
                size: 36,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            Text('SYS.NOTIFY // SETUP', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),

            Text(
              'Never miss\na dose.',
              style: AppTypography.h1.copyWith(fontSize: 32),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              'Get discreet reminders exactly when your next dose is due. No peptide names in notifications — just a gentle nudge.',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Mock notification preview
            AppCard(
              borderColor: AppColors.borderCyan,
              child: Row(
                children: [
                  // App icon placeholder
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.biotech_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'PepMod',
                              style: AppTypography.labelMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'now',
                              style: AppTypography.disclaimer,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Time for your morning protocol',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 3),

            PrimaryButton(
              label: 'ENABLE NOTIFICATIONS',
              onPressed: () {
                // TODO: request notification permission, then proceed
                onNext();
              },
            ),

            const SizedBox(height: AppSpacing.md),

            TextButton(
              onPressed: onNext,
              child: Text(
                'Maybe later',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textDisabled,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
