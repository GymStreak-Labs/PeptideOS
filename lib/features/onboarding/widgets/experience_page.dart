import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Experience level selection.
/// "How experienced are you with peptides?"
class ExperiencePage extends StatelessWidget {
  const ExperiencePage({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.onNext,
  });

  final String selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onNext;

  static const _levels = [
    _Level(
      'First Time',
      'NOVICE',
      'Never used peptides before. I need guidance on everything.',
      Icons.school_rounded,
    ),
    _Level(
      'Some Experience',
      'INTERMEDIATE',
      'Used 1-3 peptides. Comfortable with basics, want to optimise.',
      Icons.trending_up_rounded,
    ),
    _Level(
      'Advanced',
      'VETERAN',
      'Experienced with multiple protocols and stacking. Looking for tracking + insights.',
      Icons.military_tech_rounded,
    ),
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

            Text('SYS.PROFILE // EXPERIENCE', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),
            Text(
              'How experienced\nare you?',
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Experience options
            ..._levels.map((level) {
              final isSelected = selected == level.label;
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.cardGap),
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onSelect(level.label);
                  },
                  child: AnimatedContainer(
                    duration: AppDurations.fast,
                    padding: const EdgeInsets.all(AppSpacing.base),
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
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: (isSelected ? AppColors.primary : AppColors.textTertiary)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            level.icon,
                            color: isSelected ? AppColors.primary : AppColors.textTertiary,
                            size: AppSpacing.iconDefault,
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
                                    level.label,
                                    style: AppTypography.labelLarge.copyWith(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Text(
                                    level.tag,
                                    style: AppTypography.systemLabel.copyWith(
                                      fontSize: 8,
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.textDisabled,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                level.description,
                                style: AppTypography.bodySmall,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        // Selection indicator
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
                                      color: AppColors.primary.withValues(alpha: 0.4),
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
                ),
              );
            }),

            const Spacer(),

            PrimaryButton(
              label: 'CONTINUE',
              onPressed: selected.isNotEmpty ? onNext : null,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _Level {
  const _Level(this.label, this.tag, this.description, this.icon);
  final String label;
  final String tag;
  final String description;
  final IconData icon;
}
