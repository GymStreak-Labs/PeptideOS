import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';

/// Personalised Results Summary - "Your protocol is ready."
/// Echoes the user's inputs back at them. The sunk-cost payoff.
class ResultsSummaryPage extends StatelessWidget {
  const ResultsSummaryPage({
    super.key,
    required this.selectedGoals,
    required this.confidenceNeeds,
    required this.experienceLevel,
    required this.frustration,
    required this.selectedPeptides,
    required this.onNext,
  });

  final Set<String> selectedGoals;
  final Set<String> confidenceNeeds;
  final String experienceLevel;
  final String frustration;
  final Set<String> selectedPeptides;
  final VoidCallback onNext;

  String _goalsDisplay(AppLocalizations l10n) {
    if (selectedGoals.isEmpty) return l10n.defaultGoals;
    return selectedGoals.join(' · ');
  }

  String _experienceDisplay(AppLocalizations l10n) =>
      experienceLevel.isEmpty ? l10n.experienceIntermediate : experienceLevel;

  String _frustrationDisplay(AppLocalizations l10n) =>
      frustration.isEmpty ? l10n.defaultFrustration : frustration;

  String _confidenceDisplay(AppLocalizations l10n) {
    if (confidenceNeeds.isEmpty) return l10n.defaultConfidence;
    return confidenceNeeds.join(' · ');
  }

  String _peptidesDisplay(AppLocalizations l10n) {
    if (selectedPeptides.isEmpty) return 'BPC-157, TB-500';
    final list = selectedPeptides.toList();
    if (list.length <= 3) return list.join(', ');
    final shown = list.take(3).join(', ');
    final more = list.length - 3;
    return l10n.moreCount(shown, more);
  }

  int get _peptideCount =>
      selectedPeptides.isEmpty ? 2 : selectedPeptides.length;

  int get _dosesPerDay {
    if (selectedPeptides.isEmpty) return 2;
    return selectedPeptides.length;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.huge),

            Text('SYS.PROFILE // COMPILED', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.protocolPreviewTitle,
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.basedOnInputs,
              style: AppTypography.systemLabel.copyWith(
                color: AppColors.primary,
                fontSize: 11,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Card 1 — user inputs
                    AppCard(
                      borderColor: AppColors.border,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SummaryRow(
                            label: l10n.goalsLabel,
                            value: _goalsDisplay(l10n),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _SummaryRow(
                            label: l10n.experienceLabel,
                            value: _experienceDisplay(l10n),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _SummaryRow(
                            label: l10n.frustrationLabel,
                            value: _frustrationDisplay(l10n),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _SummaryRow(
                            label: l10n.confidenceLabel,
                            value: _confidenceDisplay(l10n),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _SummaryRow(
                            label: l10n.peptidesLabel,
                            value: _peptidesDisplay(l10n),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.base),

                    // Card 2 — protocol includes
                    AppCard(
                      borderColor: AppColors.borderCyan,
                      glowColor: AppColors.primaryGlow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.protocolIncludes,
                            style: AppTypography.systemLabel.copyWith(
                              fontSize: 10,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            children: [
                              _DataTile(
                                value: '$_dosesPerDay',
                                label: l10n.dosesPerDay,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _DataTile(
                                value: '$_peptideCount',
                                label: l10n.peptidesTracked,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _DataTile(value: '12', label: l10n.weekDuration),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    Text(
                      l10n.resultsSummaryBody,
                      style: AppTypography.bodyMedium.copyWith(height: 1.6),
                    ),

                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.base),

            PrimaryButton(label: l10n.seeWhatsInside, onPressed: onNext),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: AppTypography.systemLabel.copyWith(
              fontSize: 10,
              color: AppColors.textTertiary,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _DataTile extends StatelessWidget {
  const _DataTile({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.heroSmall.copyWith(
                fontSize: 24,
                color: AppColors.primary,
                shadows: [
                  Shadow(
                    color: AppColors.primary.withValues(alpha: 0.6),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.systemLabel.copyWith(
                fontSize: 8,
                color: AppColors.textTertiary,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
