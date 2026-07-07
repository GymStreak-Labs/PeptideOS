import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

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

  String get _primaryGoal {
    if (selectedGoals.isEmpty) return 'protocol clarity';
    return selectedGoals.first.toLowerCase();
  }

  String get _primaryNeed {
    if (confidenceNeeds.isEmpty) return 'dose math';
    return confidenceNeeds.first.toLowerCase();
  }

  int get _peptideCount =>
      selectedPeptides.isEmpty ? 2 : selectedPeptides.length;

  @override
  Widget build(BuildContext context) {
    final steps = [
      _RoadmapStep(
        label: 'DAY 1',
        title: 'Your first protocol is organised',
        body: 'Peptides, dose logs, site rotation, and reminders are ready.',
        icon: Icons.flash_on_rounded,
        color: AppColors.primary,
      ),
      _RoadmapStep(
        label: 'WEEK 1',
        title: 'Your library fills around $_primaryGoal',
        body:
            'Plain-English research and tracking notes stay attached to your plan.',
        icon: Icons.menu_book_rounded,
        color: AppColors.secondary,
      ),
      _RoadmapStep(
        label: 'MONTH 1',
        title: 'Your consistency history takes shape',
        body:
            'Adherence, missed doses, and body metrics start forming a cleaner record.',
        icon: Icons.query_stats_rounded,
        color: AppColors.aiInsightBright,
      ),
      _RoadmapStep(
        label: 'MONTH 2',
        title: 'Your full protocol arc is visible',
        body:
            'See what you planned, what happened, and where your records need attention.',
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
              'Here is what\nis ahead.',
              style: AppTypography.h1.copyWith(fontSize: 30),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Built around $_peptideCount tracked peptides and your need for $_primaryNeed.',
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
                  if (index == steps.length) return const _DisclaimerCard();
                  return _RoadmapCard(step: steps[index]);
                },
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            PrimaryButton(label: 'SAVE THIS ROADMAP', onPressed: onNext),
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
  const _DisclaimerCard();

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
              'PepMod keeps records and reminders organised. It does not prescribe, diagnose, or replace clinician guidance.',
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
