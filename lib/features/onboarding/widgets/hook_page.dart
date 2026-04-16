import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen 2: The Hook — emotional mirror.
/// Speaks to their inner monologue. Makes them feel understood.
class HookPage extends StatelessWidget {
  const HookPage({super.key, required this.onNext});

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

            Text(
              'SYS.INIT // CONNECT',
              style: AppTypography.systemLabel,
            ),
            const SizedBox(height: AppSpacing.xl),

            Text(
              "You've done the research.",
              style: AppTypography.h2.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              "You've read the Reddit threads.\nYou've watched the YouTube videos.",
              style: AppTypography.h2.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.xxl),

            Text(
              "Now you're staring at\na vial and a syringe\nthinking...",
              style: AppTypography.h1.copyWith(
                fontSize: 24,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.lg),

            // The key question — in cyan
            Text(
              '"Am I doing this right?"',
              style: AppTypography.h1.copyWith(
                fontSize: 26,
                color: AppColors.primary,
                fontStyle: FontStyle.italic,
                shadows: [
                  Shadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 16,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.xxxl),

            Text(
              "That's exactly why\nwe built PeptideOS.",
              style: AppTypography.h2.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(flex: 3),

            PrimaryButton(
              label: 'CONTINUE',
              onPressed: onNext,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
