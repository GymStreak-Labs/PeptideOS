import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Generic onboarding page with icon, title, body, and CTA button.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.systemLabel,
    required this.title,
    required this.body,
    required this.icon,
    required this.buttonLabel,
    required this.onNext,
    this.iconColor,
  });

  final String systemLabel;
  final String title;
  final String body;
  final IconData icon;
  final String buttonLabel;
  final VoidCallback onNext;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppColors.primary;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Icon with glow
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.2),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(icon, size: 36, color: color),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // System label
            Text(systemLabel, style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),

            // Title
            Text(
              title,
              style: AppTypography.h1.copyWith(fontSize: 32),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.lg),

            // Body
            Text(
              body,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),

            const Spacer(flex: 3),

            // CTA
            PrimaryButton(
              label: buttonLabel,
              onPressed: onNext,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
