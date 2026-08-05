import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';

/// Goals selection — multi-select grid.
/// "What are you using peptides for?"
class GoalsPage extends StatelessWidget {
  const GoalsPage({
    super.key,
    required this.selectedGoals,
    required this.onToggle,
    required this.onNext,
  });

  final Set<String> selectedGoals;
  final ValueChanged<String> onToggle;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final goals = [
      _Goal(l10n.goalRecovery, Icons.healing_rounded, l10n.goalRecoveryDetail),
      _Goal(
        l10n.goalWeightLoss,
        Icons.trending_down_rounded,
        l10n.goalWeightLossDetail,
      ),
      _Goal(
        l10n.goalAntiAging,
        Icons.auto_awesome_rounded,
        l10n.goalAntiAgingDetail,
      ),
      _Goal(
        l10n.goalMuscleGrowth,
        Icons.fitness_center_rounded,
        l10n.goalMuscleGrowthDetail,
      ),
      _Goal(
        l10n.goalCognitive,
        Icons.psychology_rounded,
        l10n.goalCognitiveDetail,
      ),
      _Goal(l10n.goalImmune, Icons.shield_rounded, l10n.goalImmuneDetail),
      _Goal(l10n.goalSleep, Icons.bedtime_rounded, l10n.goalSleepDetail),
      _Goal(l10n.goalOther, Icons.more_horiz_rounded, l10n.goalOtherDetail),
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

            Text('SYS.PROFILE // GOALS', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.onboardingGoalsTitle,
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.selectAllThatApply, style: AppTypography.bodySmall),

            const SizedBox(height: AppSpacing.xl),

            // Goals grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.cardGap,
                mainAxisSpacing: AppSpacing.cardGap,
                childAspectRatio: 1.6,
                padding: EdgeInsets.zero,
                children: goals.map((goal) {
                  final isSelected = selectedGoals.contains(goal.label);
                  return _GoalChip(
                    goal: goal,
                    isSelected: isSelected,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onToggle(goal.label);
                    },
                  );
                }).toList(),
              ),
            ),

            PrimaryButton(
              label: l10n.continueLabel,
              onPressed: selectedGoals.isNotEmpty ? onNext : null,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _Goal {
  const _Goal(this.label, this.icon, this.subtitle);
  final String label;
  final IconData icon;
  final String subtitle;
}

class _GoalChip extends StatelessWidget {
  const _GoalChip({
    required this.goal,
    required this.isSelected,
    required this.onTap,
  });

  final _Goal goal;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              goal.icon,
              size: AppSpacing.iconDefault,
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              goal.label,
              style: AppTypography.labelLarge.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            Text(
              goal.subtitle,
              style: AppTypography.disclaimer.copyWith(
                color: AppColors.textTertiary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
