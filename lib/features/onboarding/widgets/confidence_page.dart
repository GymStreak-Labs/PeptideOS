import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Captures what the user needs to feel safe and ready before starting.
class ConfidencePage extends StatelessWidget {
  const ConfidencePage({
    super.key,
    required this.selectedNeeds,
    required this.onToggle,
    required this.onNext,
  });

  final Set<String> selectedNeeds;
  final ValueChanged<String> onToggle;
  final VoidCallback onNext;

  static const _needs = [
    _ConfidenceNeed(
      label: 'Dose math',
      description: 'Vial, water, and syringe units in one place',
      icon: Icons.calculate_rounded,
    ),
    _ConfidenceNeed(
      label: 'Cycle timing',
      description: 'Know what is planned and what is coming next',
      icon: Icons.timeline_rounded,
    ),
    _ConfidenceNeed(
      label: 'Site rotation',
      description: 'Keep every site and dose remembered',
      icon: Icons.location_on_outlined,
    ),
    _ConfidenceNeed(
      label: 'Plain-English info',
      description: 'Research notes without forum chaos',
      icon: Icons.menu_book_rounded,
    ),
    _ConfidenceNeed(
      label: 'Progress signals',
      description: 'See adherence and body metrics over time',
      icon: Icons.query_stats_rounded,
    ),
    _ConfidenceNeed(
      label: 'Safety framing',
      description: 'Clear boundaries and medical disclaimers',
      icon: Icons.verified_user_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final canContinue = selectedNeeds.isNotEmpty;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.huge),
            Text('SYS.READINESS // SIGNALS', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),
            Text(
              'What would make\nyou feel confident?',
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Select all that matter. PepMod will shape your setup around the tracking gaps you want to close.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: _needs.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final need = _needs[index];
                  final selected = selectedNeeds.contains(need.label);
                  return _NeedTile(
                    need: need,
                    selected: selected,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onToggle(need.label);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            PrimaryButton(
              label: 'CONTINUE',
              onPressed: canContinue ? onNext : null,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _NeedTile extends StatelessWidget {
  const _NeedTile({
    required this.need,
    required this.selected,
    required this.onTap,
  });

  final _ConfidenceNeed need;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      borderColor: selected ? AppColors.borderCyan : AppColors.border,
      glowColor: selected ? AppColors.primaryGlow : null,
      child: Row(
        children: [
          AnimatedContainer(
            duration: AppDurations.fast,
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.16)
                  : AppColors.inputFill,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Icon(
              need.icon,
              color: selected ? AppColors.primary : AppColors.textTertiary,
              size: AppSpacing.iconMedium,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(need.label, style: AppTypography.labelLarge),
                const SizedBox(height: 3),
                Text(
                  need.description,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          AnimatedContainer(
            duration: AppDurations.fast,
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.18)
                  : Colors.transparent,
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
                width: selected ? 2 : 1.5,
              ),
            ),
            child: selected
                ? const Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: AppColors.primary,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class _ConfidenceNeed {
  const _ConfidenceNeed({
    required this.label,
    required this.description,
    required this.icon,
  });

  final String label;
  final String description;
  final IconData icon;
}
