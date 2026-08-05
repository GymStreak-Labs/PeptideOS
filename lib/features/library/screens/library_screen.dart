import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/peptide.dart';
import '../../../models/conversion_workspace.dart';
import '../../../l10n/app_localizations.dart';
import '../../protocol/widgets/empty_state.dart';
import '../../profile/providers/settings_provider.dart';
import '../providers/peptide_provider.dart';
import '../utils/library_labels.dart';
import '../utils/localized_peptide_content.dart';
import 'custom_compound_library_screen.dart';
import 'peptide_detail_screen.dart';
import 'reconstitution_screen.dart';

/// Library tab — searchable peptide database with category filters.
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _query = '';
  PeptideCategory? _category;

  void _openUnitConverter() {
    HapticFeedback.lightImpact();
    final settingsProvider = context.read<SettingsProvider>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReconstitutionScreen(
          savedCalculations: settingsProvider.settings.savedVialCalculations,
          onSavedCalculationsChanged: (calculations) => settingsProvider.update(
            (settings) => settings.savedVialCalculations =
                List<SavedVialCalculation>.from(calculations),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<PeptideProvider>();
    final results = provider.search(
      query: _query,
      category: _category,
      localizedTerms: (peptide) =>
          localizedPeptideContent(l10n, peptide).searchTerms(l10n, peptide),
    );

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surfaceContainer,
      onRefresh: provider.refresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.huge,
                AppSpacing.screenHorizontal,
                AppSpacing.base,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.librarySystemLabel,
                          style: AppTypography.systemLabel,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(l10n.libraryTitle, style: AppTypography.h1),
                      ],
                    ),
                  ),
                  _HeaderIconButton(
                    icon: Icons.inventory_2_outlined,
                    tooltip: l10n.myCompounds,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CustomCompoundLibraryScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Search
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: _SearchBar(
                value: _query,
                hint: l10n.searchPeptides,
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.md,
                AppSpacing.screenHorizontal,
                0,
              ),
              child: _ConversionToolsCard(onTap: _openUnitConverter),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // Category chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                children: [
                  _CategoryChip(
                    label: l10n.categoryAll,
                    selected: _category == null,
                    onTap: () => setState(() => _category = null),
                  ),
                  for (final cat in PeptideCategory.values)
                    if (cat != PeptideCategory.other)
                      Padding(
                        padding: const EdgeInsets.only(left: AppSpacing.sm),
                        child: _CategoryChip(
                          label: localizedPeptideCategoryLabel(l10n, cat),
                          selected: _category == cat,
                          onTap: () => setState(
                            () => _category = cat == _category ? null : cat,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // Loading
          if (provider.isLoading)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            )
          else if (provider.error != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: EmptyState(
                  icon: Icons.error_outline_rounded,
                  title: l10n.libraryUnavailable,
                  description: l10n.libraryLoadFailed,
                  actionLabel: l10n.retry,
                  onAction: provider.refresh,
                ),
              ),
            )
          else if (results.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: EmptyState(
                  icon: Icons.search_off_rounded,
                  title: l10n.noPeptidesFound,
                  description: l10n.tryDifferentSearch,
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              sliver: SliverList.separated(
                itemCount: results.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.cardGap),
                itemBuilder: (_, i) {
                  final p = results[i];
                  return _PeptideCard(
                    peptide: p,
                    categoryLabel: localizedPeptideCategoryLabel(
                      l10n,
                      p.category,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PeptideDetailScreen(peptide: p),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.screenBottom),
          ),
        ],
      ),
    );
  }
}

// ── Search bar ────────────────────────────────────────────────────────────
class _ConversionToolsCard extends StatelessWidget {
  const _ConversionToolsCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: l10n.openUnitConverter,
      onTap: onTap,
      excludeSemantics: true,
      child: AppCard(
        onTap: onTap,
        borderColor: AppColors.borderCyan,
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                border: Border.all(color: AppColors.borderCyan),
              ),
              child: const Icon(
                Icons.calculate_rounded,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.converterCardTitle,
                    style: AppTypography.systemLabel.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    l10n.converterCardSubtitle,
                    style: AppTypography.labelLarge,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.converterCardHint,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.primary,
              size: AppSpacing.iconMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.value,
    required this.hint,
    required this.onChanged,
  });
  final String value;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.inputHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.inputPadding),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: AppColors.textTertiary,
            size: AppSpacing.iconMedium,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: AppTypography.bodyMedium,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textDisabled,
                ),
                border: InputBorder.none,
                isDense: true,
                filled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Category chip ─────────────────────────────────────────────────────────
class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 6,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Peptide card ──────────────────────────────────────────────────────────
class _PeptideCard extends StatelessWidget {
  const _PeptideCard({
    required this.peptide,
    required this.categoryLabel,
    required this.onTap,
  });
  final Peptide peptide;
  final String categoryLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderCyan),
            ),
            child: const Icon(
              Icons.biotech_rounded,
              color: AppColors.primary,
              size: AppSpacing.iconLarge,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(peptide.name, style: AppTypography.labelLarge),
                const SizedBox(height: 2),
                Text(
                  categoryLabel,
                  style: AppTypography.systemLabel.copyWith(fontSize: 10),
                ),
                const SizedBox(height: 4),
                Text(
                  peptide.typicalDose,
                  style: AppTypography.bodySmall.copyWith(
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textTertiary,
            size: AppSpacing.iconMedium,
          ),
        ],
      ),
    );
  }
}

// ── Header icon button ────────────────────────────────────────────────────
class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
  });
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          border: Border.all(color: AppColors.borderCyan),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.primary, size: AppSpacing.iconLarge),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
