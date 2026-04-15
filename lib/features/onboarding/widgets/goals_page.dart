import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

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

  static const _goals = [
    _Goal('Recovery', Icons.healing_rounded, 'Injury healing, tissue repair'),
    _Goal('Weight Loss', Icons.trending_down_rounded, 'GLP-1, metabolic'),
    _Goal('Anti-Aging', Icons.auto_awesome_rounded, 'Longevity, skin, hair'),
    _Goal('Muscle Growth', Icons.fitness_center_rounded, 'GH, IGF-1, anabolic'),
    _Goal('Cognitive', Icons.psychology_rounded, 'Focus, memory, neuroprotection'),
    _Goal('Immune', Icons.shield_rounded, 'Thymosin, immune modulation'),
    _Goal('Sleep', Icons.bedtime_rounded, 'DSIP, sleep optimisation'),
    _Goal('Other', Icons.more_horiz_rounded, 'Something else'),
  ];

  @override
  Widget build(BuildContext context) {
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
              'What are you\nusing peptides for?',
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Select all that apply',
              style: AppTypography.bodySmall,
            ),

            const SizedBox(height: AppSpacing.xl),

            // Goals grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.cardGap,
                mainAxisSpacing: AppSpacing.cardGap,
                childAspectRatio: 1.6,
                padding: EdgeInsets.zero,
                children: _goals.map((goal) {
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
              label: 'CONTINUE',
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
