import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen 10: Review Request Gate — "Enjoying PepMod so far?"
/// Triggers native review on "LOVE IT", falls through to onNext either way.
class ReviewGatePage extends StatelessWidget {
  const ReviewGatePage({super.key, required this.onNext});

  final VoidCallback onNext;

  Future<void> _handleLoveIt() async {
    HapticFeedback.mediumImpact();
    try {
      final inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
      }
    } catch (_) {
      // Swallow — a failed review prompt shouldn't block onboarding.
    }
    // Small delay so the native dialog has time to appear / dismiss.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    onNext();
  }

  void _handleNeedsWork() {
    HapticFeedback.selectionClick();
    onNext();
  }

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

            // Big star icon with glow halo
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.18),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.1),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.45),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.star_rounded,
                    size: 48,
                    color: AppColors.primary,
                    shadows: [
                      Shadow(
                        color: AppColors.primary.withValues(alpha: 0.6),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xxl),

            Text('SYS.FEEDBACK // CHECK-IN',
                style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),

            Text(
              'Enjoying PepMod\nso far?',
              style: AppTypography.h1.copyWith(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),

            Text(
              'Your feedback helps us improve the platform for every biohacker.',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),

            const Spacer(flex: 3),

            PrimaryButton(
              label: 'LOVE IT',
              icon: Icons.favorite_rounded,
              onPressed: _handleLoveIt,
            ),
            const SizedBox(height: AppSpacing.md),
            _GhostButton(
              label: 'NEEDS WORK',
              onPressed: _handleNeedsWork,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: AppSpacing.buttonHeight,
        constraints: const BoxConstraints(minWidth: double.infinity),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.button.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
