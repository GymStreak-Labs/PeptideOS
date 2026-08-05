import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';

/// Sells the user's future protocol arc before auth and paywall.
class ProtocolRoadmapPage extends StatelessWidget {
  const ProtocolRoadmapPage({
    super.key,
    required this.selectedGoals,
    required this.confidenceNeeds,
    required this.selectedPeptides,
    required this.onNext,
  });

  final Set<String> selectedGoals;
  final Set<String> confidenceNeeds;
  final Set<String> selectedPeptides;
  final VoidCallback onNext;

  String _primaryGoal(AppLocalizations l10n) {
    if (selectedGoals.isEmpty) return l10n.protocolClarity;
    return selectedGoals.first.toLowerCase();
  }

  String _primaryNeed(AppLocalizations l10n) {
    if (confidenceNeeds.isEmpty) return l10n.confidenceDoseMath.toLowerCase();
    return confidenceNeeds.first.toLowerCase();
  }

  int get _peptideCount =>
      selectedPeptides.isEmpty ? 2 : selectedPeptides.length;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final steps = [
      _RoadmapStep(
        label: l10n.dayOne,
        title: l10n.roadmapDayOneTitle,
        body: l10n.roadmapDayOneBody,
        icon: Icons.flash_on_rounded,
        color: AppColors.primary,
      ),
      _RoadmapStep(
        label: l10n.weekOne,
        title: l10n.roadmapWeekOneTitle(_primaryGoal(l10n)),
        body: l10n.roadmapWeekOneBody,
        icon: Icons.menu_book_rounded,
        color: AppColors.secondary,
      ),
      _RoadmapStep(
        label: l10n.monthOne,
        title: l10n.roadmapMonthOneTitle,
        body: l10n.roadmapMonthOneBody,
        icon: Icons.query_stats_rounded,
        color: AppColors.aiInsightBright,
      ),
      _RoadmapStep(
        label: l10n.monthTwo,
        title: l10n.roadmapMonthTwoTitle,
        body: l10n.roadmapMonthTwoBody,
        icon: Icons.timeline_rounded,
        color: AppColors.primary,
      ),
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
            Text(
              'SYS.ROADMAP // FIRST 60 DAYS',
              style: AppTypography.systemLabel,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.roadmapTitle,
              style: AppTypography.h1.copyWith(fontSize: 30),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.roadmapBody(_peptideCount, _primaryNeed(l10n)),
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: steps.length + 1,
                separatorBuilder: (_, index) => index >= steps.length - 1
                    ? const SizedBox(height: AppSpacing.md)
                    : const _TimelineConnector(),
                itemBuilder: (context, index) {
                  if (index == steps.length) {
                    return _DisclaimerCard(text: l10n.roadmapDisclaimer);
                  }
                  return _RoadmapCard(step: steps[index]);
                },
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            PrimaryButton(label: l10n.saveRoadmap, onPressed: onNext),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _RoadmapCard extends StatelessWidget {
  const _RoadmapCard({required this.step});

  final _RoadmapStep step;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: step.color.withValues(alpha: 0.36),
      glowColor: step.color.withValues(alpha: 0.08),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: step.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: step.color.withValues(alpha: 0.34)),
            ),
            child: Icon(
              step.icon,
              color: step.color,
              size: AppSpacing.iconMedium,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.label,
                  style: AppTypography.systemLabel.copyWith(
                    color: step.color,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(step.title, style: AppTypography.labelLarge),
                const SizedBox(height: 3),
                Text(
                  step.body,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineConnector extends StatelessWidget {
  const _TimelineConnector();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 18,
          color: AppColors.primary.withValues(alpha: 0.32),
        ),
      ),
    );
  }
}

class _DisclaimerCard extends StatelessWidget {
  const _DisclaimerCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            color: AppColors.textTertiary,
            size: AppSpacing.iconMedium,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTypography.disclaimer.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoadmapStep {
  const _RoadmapStep({
    required this.label,
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });

  final String label;
  final String title;
  final String body;
  final IconData icon;
  final Color color;
}
