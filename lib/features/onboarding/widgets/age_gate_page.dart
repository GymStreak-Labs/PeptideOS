import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Age gate — mandatory first screen. 18+ required.
/// Apple compliance: must be the very first interaction.
class AgeGatePage extends StatelessWidget {
  const AgeGatePage({super.key, required this.onConfirmed});

  final VoidCallback onConfirmed;

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

            // Shield icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.warning.withValues(alpha: 0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: const Icon(
                Icons.verified_user_rounded,
                size: 36,
                color: AppColors.warning,
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            Text('SYS.AUTH // AGE VERIFICATION', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),

            Text(
              'Age\nVerification',
              style: AppTypography.h1.copyWith(fontSize: 32),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              'PepMod is designed for adults aged 18 and over. By continuing, you confirm that you are at least 18 years old.',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),

            const Spacer(flex: 3),

            PrimaryButton(
              label: 'I AM 18 OR OLDER',
              onPressed: onConfirmed,
            ),

            const SizedBox(height: AppSpacing.md),

            TextButton(
              onPressed: () {
                // Show dialog explaining they can't use the app
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Age Requirement'),
                    content: const Text(
                      'PepMod requires users to be 18 years or older. '
                      'Please consult a healthcare provider for peptide guidance.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'I am under 18',
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
