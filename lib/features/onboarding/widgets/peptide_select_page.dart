import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Screen 7: Current/Planned Peptides — search and select from database.
class PeptideSelectPage extends StatefulWidget {
  const PeptideSelectPage({
    super.key,
    required this.selectedPeptides,
    required this.onToggle,
    required this.onNext,
  });

  final Set<String> selectedPeptides;
  final ValueChanged<String> onToggle;
  final VoidCallback onNext;

  @override
  State<PeptideSelectPage> createState() => _PeptideSelectPageState();
}

class _PeptideSelectPageState extends State<PeptideSelectPage> {
  String _searchQuery = '';

  static const _allPeptides = [
    'BPC-157',
    'TB-500',
    'Semaglutide',
    'Tirzepatide',
    'Retatrutide',
    'CJC-1295',
    'Ipamorelin',
    'MK-677',
    'GHK-Cu',
    'Epitalon',
    'Thymosin Alpha-1',
    'Semax',
    'Selank',
    'DSIP',
    'PT-141',
    'Melanotan II',
    'AOD-9604',
    'Tesamorelin',
    'Sermorelin',
    'MOTS-c',
    'SS-31',
    'KPV',
    'LL-37',
    'Dihexa',
  ];

  List<String> get _filteredPeptides {
    if (_searchQuery.isEmpty) return _allPeptides;
    return _allPeptides
        .where((p) => p.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

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

            Text(
              'SYS.PROFILE // COMPOUNDS',
              style: AppTypography.systemLabel,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'What peptides are\nyou using?',
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Select current or planned — you can change later',
              style: AppTypography.bodySmall,
            ),

            const SizedBox(height: AppSpacing.base),

            // Search bar
            Container(
              height: AppSpacing.inputHeight,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.inputPadding,
              ),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
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
                  Expanded(
                    child: TextField(
                      onChanged: (v) => setState(() => _searchQuery = v),
                      style: AppTypography.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Search peptides...',
                        hintStyle: AppTypography.bodyMedium
                            .copyWith(color: AppColors.textDisabled),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        filled: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Selected chips
            if (widget.selectedPeptides.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: widget.selectedPeptides.map((p) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          p,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => widget.onToggle(p),
                          child: Icon(
                            Icons.close_rounded,
                            size: 12,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: AppSpacing.md),

            // Peptide list
            Expanded(
              child: ListView.separated(
                itemCount: _filteredPeptides.length,
                padding: EdgeInsets.zero,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final peptide = _filteredPeptides[index];
                  final isSelected =
                      widget.selectedPeptides.contains(peptide);

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      widget.onToggle(peptide);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: AppDurations.fast,
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
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
                                        color: AppColors.primary
                                            .withValues(alpha: 0.3),
                                        blurRadius: 6,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: isSelected
                                ? const Icon(Icons.check_rounded,
                                    size: 14, color: AppColors.primary)
                                : null,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Text(
                            peptide,
                            style: AppTypography.labelLarge.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            PrimaryButton(
              label: widget.selectedPeptides.isEmpty
                  ? 'SKIP FOR NOW'
                  : 'CONTINUE (${widget.selectedPeptides.length} selected)',
              onPressed: onNext,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  void onNext() => widget.onNext();
}
