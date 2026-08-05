import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';

/// Screen 6: Biggest Frustration — from real community research.
/// Names their exact pain point. Single select.
class FrustrationPage extends StatelessWidget {
  const FrustrationPage({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.onNext,
  });

  final String selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final frustrations = [
      l10n.frustrationMath,
      l10n.frustrationSchedule,
      l10n.frustrationProgress,
      l10n.frustrationStacking,
      l10n.frustrationForgetting,
      l10n.frustrationTrust,
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.huge),

            Text('SYS.PROFILE // PAIN POINT', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.onboardingFrustrationTitle,
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.onboardingFrustrationBody,
              style: AppTypography.bodySmall,
            ),

            const SizedBox(height: AppSpacing.xl),

            Expanded(
              child: ListView.separated(
                itemCount: frustrations.length,
                padding: EdgeInsets.zero,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final frustration = frustrations[index];
                  final isSelected = selected == frustration;

                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onSelect(frustration);
                    },
                    child: AnimatedContainer(
                      duration: AppDurations.fast,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.base,
                        vertical: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.cardRadius,
                        ),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: isSelected ? 1.5 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.15,
                                  ),
                                  blurRadius: 12,
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              frustration,
                              style: AppTypography.bodyMedium.copyWith(
                                color: isSelected
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          AnimatedContainer(
                            duration: AppDurations.fast,
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.15)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.border,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 6,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: isSelected
                                ? const Center(
                                    child: Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: AppColors.primary,
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            PrimaryButton(
              label: l10n.continueLabel,
              onPressed: selected.isNotEmpty ? onNext : null,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
