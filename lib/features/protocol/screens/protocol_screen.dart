import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Protocol tab — today's doses, next up, completion status.
/// "Clinical Cyberpunk" — HUD-style data readout meets health tracker.
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
                Text(
                  'SYS.PROTOCOL // ACTIVE',
                  style: AppTypography.systemLabel,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text('Your Protocol', style: AppTypography.h1),
              ],
            ),
          ),
        ),

        // ── One Big Thing — next dose card (cyberpunk HUD style) ─────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: AppCard(
              borderColor: AppColors.borderCyan,
              glowColor: AppColors.primaryGlow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Pulsing status dot
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.6),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text('NEXT DOSE', style: AppTypography.systemLabel),
                      const Spacer(),
                      Text('08:00', style: AppTypography.tabular),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Hero dose number
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '250',
                        style: AppTypography.heroLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text('mcg', style: AppTypography.unit),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'BPC-157 · Subcutaneous · Left abdomen',
                    style: AppTypography.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.base),
                  // ── Syringe fill bar (cyan glow) ───────────────────
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.inputFill,
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: AppColors.primary,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '10 units · 0.5ml',
                    style: AppTypography.disclaimer,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    label: 'ADMINISTER',
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
            child: Text(
              'SCHEDULE // TODAY',
              style: AppTypography.systemLabel,
            ),
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
                _DosePreview('BPC-157', '250 mcg', '08:00', true),
                _DosePreview('TB-500', '750 mcg', '08:00', false),
                _DosePreview('BPC-157', '250 mcg', '20:00', false),
              ];
              final dose = doses[index];

              return AppCard(
                borderColor: dose.taken ? AppColors.borderCyan : null,
                child: Row(
                  children: [
                    // Status indicator — cyberpunk hollow circle / filled
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dose.taken
                            ? AppColors.primary.withValues(alpha: 0.12)
                            : Colors.transparent,
                        border: Border.all(
                          color: dose.taken
                              ? AppColors.primary
                              : AppColors.border,
                          width: dose.taken ? 1.5 : 1,
                        ),
                        boxShadow: dose.taken
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                ),
                              ]
                            : null,
                      ),
                      child: dose.taken
                          ? const Icon(
                              Icons.check_rounded,
                              size: 16,
                              color: AppColors.primary,
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
                          Text(
                            dose.amount,
                            style: AppTypography.bodySmall.copyWith(
                              fontFamily: 'JetBrainsMono',
                            ),
                          ),
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

        // ── AI Insight (purple glow) ─────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: AppCard(
              borderColor: AppColors.aiInsightBright.withValues(alpha: 0.3),
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
                          color: AppColors.aiInsightBright.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.aiInsightBright.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          'AI.INSIGHT',
                          style: AppTypography.systemLabel.copyWith(
                            color: AppColors.aiInsightBright,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Your joint pain scores have dropped 40% in the 2 weeks since starting BPC-157. Peak results typically occur around week 4.',
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
