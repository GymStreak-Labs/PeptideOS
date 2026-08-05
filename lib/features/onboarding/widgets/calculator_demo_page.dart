import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';
import '../../library/widgets/syringe_visual.dart';

/// Screen 8: Unit Converter Demo — the "aha moment".
/// Shows the calculator pre-filled with their peptide.
/// Framed as "Unit Converter" not "Dosage Calculator" (Apple 1.4.2).
class CalculatorDemoPage extends StatelessWidget {
  const CalculatorDemoPage({
    super.key,
    required this.peptideName,
    required this.onNext,
  });

  /// First selected peptide name, or default.
  final String peptideName;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Pre-filled demo values
    const peptideMg = 5.0;
    const waterMl = 2.0;
    const doseMcg = 250.0;
    const concentration = (peptideMg * 1000) / waterMl; // 2500
    const drawMl = doseMcg / concentration; // 0.1
    const syringeUnits = drawMl * 100; // 10
    const fillFraction = syringeUnits / 100; // 0.1

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
              'SYS.DEMO // UNIT CONVERTER',
              style: AppTypography.systemLabel,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.calculatorDemoTitle,
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.calculatorDemoBody(peptideName),
              style: AppTypography.bodySmall,
            ),

            const SizedBox(height: AppSpacing.xl),

            // Demo result card
            Expanded(
              child: AppCard(
                borderColor: AppColors.borderCyan,
                glowColor: AppColors.primaryGlow,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Syringe
                    const SyringeVisual(
                      fillFraction: fillFraction,
                      totalUnits: 100,
                      fillUnits: syringeUnits,
                      height: 200,
                    ),
                    const SizedBox(width: AppSpacing.base),

                    // Data
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Input summary
                          _DemoInput(
                            label: l10n.peptideLabel,
                            value: '${peptideMg.toInt()}mg $peptideName',
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _DemoInput(
                            label: l10n.bacWaterLabel,
                            value: '${waterMl.toInt()}ml',
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _DemoInput(
                            label: l10n.doseLabel,
                            value: '${doseMcg.toInt()}mcg',
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Result
                          Text(
                            l10n.drawVolumeLabel,
                            style: AppTypography.systemLabel,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                syringeUnits.toStringAsFixed(1),
                                style: AppTypography.heroMedium.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(l10n.unitsLabel, style: AppTypography.unit),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            l10n.syringeVolume(drawMl.toStringAsFixed(3)),
                            style: AppTypography.bodySmall,
                          ),

                          const SizedBox(height: AppSpacing.base),
                          Text(
                            l10n.calculatorDemoResult,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.unitConversionDisclaimer,
              style: AppTypography.disclaimer,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.base),

            PrimaryButton(label: l10n.continueLabel, onPressed: onNext),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _DemoInput extends StatelessWidget {
  const _DemoInput({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: AppTypography.systemLabel.copyWith(
              fontSize: 8,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        Text(value, style: AppTypography.tabular.copyWith(fontSize: 13)),
      ],
    );
  }
}
