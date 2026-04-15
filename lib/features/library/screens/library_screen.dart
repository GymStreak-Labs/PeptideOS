import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Library tab — peptide database, community protocols, reconstitution calculator.
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
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
                Text('Library', style: AppTypography.h1),
                const SizedBox(height: AppSpacing.md),
                // Search bar
                Container(
                  height: AppSpacing.inputHeight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.inputPadding,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.inputFill,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.inputRadius),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        size: AppSpacing.iconMedium,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Search peptides, protocols...',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Quick actions ────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _QuickAction(
                    icon: Icons.science_rounded,
                    label: 'Reconstitution\nCalculator',
                    color: AppColors.peptide,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: AppSpacing.cardGap),
                Expanded(
                  child: _QuickAction(
                    icon: Icons.auto_awesome_rounded,
                    label: 'Protocol\nBuilder',
                    color: AppColors.primary,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Peptide Database ─────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Text('Peptide Database', style: AppTypography.h3),
                const Spacer(),
                Text(
                  'See all',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          sliver: SliverList.separated(
            itemCount: 5,
            separatorBuilder: (_, _) =>
                const SizedBox(height: AppSpacing.cardGap),
            itemBuilder: (context, index) {
              final peptides = [
                _PeptideItem('BPC-157', 'Recovery · Healing', 'Clinical Trials', AppColors.success),
                _PeptideItem('TB-500', 'Recovery · Anti-inflammatory', 'Clinical Trials', AppColors.success),
                _PeptideItem('Semaglutide', 'Weight Loss · GLP-1', 'FDA Approved', AppColors.primary),
                _PeptideItem('Tirzepatide', 'Weight Loss · GLP-1/GIP', 'FDA Approved', AppColors.primary),
                _PeptideItem('CJC-1295', 'Growth Hormone · Anti-aging', 'Animal Studies', AppColors.warning),
              ];
              final peptide = peptides[index];

              return AppCard(
                onTap: () {},
                child: Row(
                  children: [
                    // Peptide icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: peptide.evidenceColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.biotech_rounded,
                        color: peptide.evidenceColor,
                        size: AppSpacing.iconDefault,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(peptide.name, style: AppTypography.labelLarge),
                          const SizedBox(height: 2),
                          Text(peptide.category, style: AppTypography.bodySmall),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: peptide.evidenceColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        peptide.evidence,
                        style: AppTypography.labelSmall.copyWith(
                          color: peptide.evidenceColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: AppSpacing.screenBottom),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: AppSpacing.iconLarge),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PeptideItem {
  const _PeptideItem(this.name, this.category, this.evidence, this.evidenceColor);
  final String name;
  final String category;
  final String evidence;
  final Color evidenceColor;
}
