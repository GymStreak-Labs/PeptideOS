import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Protocol tab — today's doses, next up, completion status.
class ProtocolScreen extends StatelessWidget {
  const ProtocolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // ── Header ───────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.huge,
              AppSpacing.screenHorizontal,
              AppSpacing.base,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good morning', style: AppTypography.bodyMedium),
                const SizedBox(height: AppSpacing.xs),
                Text('Your Protocol', style: AppTypography.h1),
              ],
            ),
          ),
        ),

        // ── One Big Thing — next dose card ───────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: AppCard(
              glowColor: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text('NEXT DOSE', style: AppTypography.labelSmall),
                      const Spacer(),
                      Text('8:00 AM', style: AppTypography.tabular),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.base),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('250', style: AppTypography.heroLarge),
                      const SizedBox(width: AppSpacing.xs),
                      Text('mcg', style: AppTypography.unit),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'BPC-157 · Subcutaneous · Left abdomen',
                    style: AppTypography.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.base),
                  // ── Syringe visual placeholder ─────────────────────
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: AppColors.inputFill,
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '10 units on syringe · 0.5ml',
                    style: AppTypography.disclaimer,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    label: 'Mark as Taken',
                    icon: Icons.check_rounded,
                    onPressed: () {
                      // TODO: dose logging with haptic feedback
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Today's schedule ─────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: Text("Today's Schedule", style: AppTypography.h3),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          sliver: SliverList.separated(
            itemCount: 3,
            separatorBuilder: (_, _) =>
                const SizedBox(height: AppSpacing.cardGap),
            itemBuilder: (context, index) {
              final doses = [
                _DosePreview('BPC-157', '250 mcg', '8:00 AM', true),
                _DosePreview('TB-500', '750 mcg', '8:00 AM', false),
                _DosePreview('BPC-157', '250 mcg', '8:00 PM', false),
              ];
              final dose = doses[index];

              return AppCard(
                glowColor: dose.taken ? AppColors.successGlow : null,
                child: Row(
                  children: [
                    // Status indicator
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dose.taken
                            ? AppColors.success.withValues(alpha: 0.15)
                            : AppColors.inputFill,
                        border: Border.all(
                          color: dose.taken
                              ? AppColors.success
                              : AppColors.border,
                        ),
                      ),
                      child: dose.taken
                          ? const Icon(
                              Icons.check_rounded,
                              size: 16,
                              color: AppColors.success,
                            )
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    // Dose info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dose.name, style: AppTypography.labelLarge),
                          Text(dose.amount, style: AppTypography.bodySmall),
                        ],
                      ),
                    ),
                    Text(dose.time, style: AppTypography.tabular),
                  ],
                ),
              );
            },
          ),
        ),

        // ── AI Insight ───────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: AppCard(
              borderColor: AppColors.aiInsight.withValues(alpha: 0.3),
              glowColor: AppColors.aiInsightGlow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.aiInsight.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'AI INSIGHT',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.aiInsight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Your joint pain scores have dropped 40% in the 2 weeks since starting BPC-157. Keep going — most users see peak results around week 4.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'AI-generated insight based on your logged data. Not medical advice.',
                    style: AppTypography.disclaimer,
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Bottom padding for tab bar ───────────────────────────────
        const SliverToBoxAdapter(
          child: SizedBox(height: AppSpacing.screenBottom),
        ),
      ],
    );
  }
}

class _DosePreview {
  const _DosePreview(this.name, this.amount, this.time, this.taken);
  final String name;
  final String amount;
  final String time;
  final bool taken;
}
