import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../widgets/syringe_visual.dart';

/// Reconstitution Calculator — the #1 feature.
/// "Unit conversion tool" (not "dosage calculator" — Apple 1.4.2 compliance).
///
/// Flow: Enter peptide mg → enter BAC water ml → enter desired dose mcg
///       → see exact syringe units with visual diagram.
class ReconstitutionScreen extends StatefulWidget {
  const ReconstitutionScreen({super.key});

  @override
  State<ReconstitutionScreen> createState() => _ReconstitutionScreenState();
}

class _ReconstitutionScreenState extends State<ReconstitutionScreen> {
  final _peptideMgController = TextEditingController(text: '5');
  final _waterMlController = TextEditingController(text: '2');
  final _doseMcgController = TextEditingController(text: '250');

  double get _peptideMg => double.tryParse(_peptideMgController.text) ?? 0;
  double get _waterMl => double.tryParse(_waterMlController.text) ?? 0;
  double get _doseMcg => double.tryParse(_doseMcgController.text) ?? 0;

  // ── Calculations ─────────────────────────────────────────────────────
  /// Concentration in mcg per ml after reconstitution.
  double get _concentrationMcgPerMl {
    if (_waterMl <= 0) return 0;
    return (_peptideMg * 1000) / _waterMl; // mg to mcg
  }

  /// Volume to draw in ml for the desired dose.
  double get _drawVolumeMl {
    if (_concentrationMcgPerMl <= 0) return 0;
    return _doseMcg / _concentrationMcgPerMl;
  }

  /// Syringe units (assuming 100-unit / 1ml insulin syringe).
  double get _syringeUnits => _drawVolumeMl * 100;

  /// How many doses per vial.
  int get _dosesPerVial {
    if (_doseMcg <= 0) return 0;
    return ((_peptideMg * 1000) / _doseMcg).floor();
  }

  /// Fill fraction for the syringe visual.
  double get _fillFraction => (_syringeUnits / 100).clamp(0.0, 1.0);

  /// Whether the dose seems unusually high.
  bool get _isDoseWarning => _syringeUnits > 50;

  /// Whether the dose seems dangerously high.
  bool get _isDoseDanger => _syringeUnits > 80;

  @override
  void dispose() {
    _peptideMgController.dispose();
    _waterMlController.dispose();
    _doseMcgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.screenHorizontal,
                0,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UTIL.RECONSTITUTION',
                        style: AppTypography.systemLabel,
                      ),
                      Text('Unit Converter', style: AppTypography.h3),
                    ],
                  ),
                ],
              ),
            ),

            // ── Scrollable content ───────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xl),

                    // ── Input section ────────────────────────────────
                    Text('INPUT.PARAMETERS', style: AppTypography.systemLabel),
                    const SizedBox(height: AppSpacing.md),

                    // Row 1: Peptide mg + Water ml
                    Row(
                      children: [
                        Expanded(
                          child: _InputField(
                            label: 'PEPTIDE',
                            suffix: 'mg',
                            controller: _peptideMgController,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.cardGap),
                        Expanded(
                          child: _InputField(
                            label: 'BAC WATER',
                            suffix: 'ml',
                            controller: _waterMlController,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.cardGap),

                    // Row 2: Desired dose mcg (full width)
                    _InputField(
                      label: 'DESIRED DOSE',
                      suffix: 'mcg',
                      controller: _doseMcgController,
                      onChanged: (_) => setState(() {}),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // ── Result section ───────────────────────────────
                    Text('OUTPUT.RESULT', style: AppTypography.systemLabel),
                    const SizedBox(height: AppSpacing.md),

                    // Main result card with syringe
                    AppCard(
                      borderColor: _isDoseDanger
                          ? AppColors.danger.withValues(alpha: 0.5)
                          : _isDoseWarning
                              ? AppColors.warning.withValues(alpha: 0.5)
                              : AppColors.borderCyan,
                      glowColor: _isDoseDanger
                          ? AppColors.dangerGlow
                          : _isDoseWarning
                              ? AppColors.warningGlow
                              : AppColors.primaryGlow,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Syringe visual
                          AnimatedSwitcher(
                            duration: AppDurations.syringeFill,
                            child: SyringeVisual(
                              key: ValueKey(_fillFraction.toStringAsFixed(2)),
                              fillFraction: _fillFraction,
                              totalUnits: 100,
                              fillUnits: _syringeUnits,
                              height: 220,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.base),

                          // Data readout
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('DRAW VOLUME',
                                    style: AppTypography.systemLabel),
                                const SizedBox(height: AppSpacing.sm),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      _syringeUnits.toStringAsFixed(1),
                                      style: AppTypography.heroMedium.copyWith(
                                        color: _isDoseDanger
                                            ? AppColors.danger
                                            : _isDoseWarning
                                                ? AppColors.warning
                                                : AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.xs),
                                    Text('units', style: AppTypography.unit),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  '${_drawVolumeMl.toStringAsFixed(3)} ml',
                                  style: AppTypography.tabular.copyWith(
                                    fontSize: 14,
                                    color: AppColors.textTertiary,
                                  ),
                                ),

                                const SizedBox(height: AppSpacing.lg),
                                _DataRow(
                                  label: 'CONCENTRATION',
                                  value:
                                      '${_concentrationMcgPerMl.toStringAsFixed(0)} mcg/ml',
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                _DataRow(
                                  label: 'DOSES/VIAL',
                                  value: '$_dosesPerVial doses',
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                _DataRow(
                                  label: 'SYRINGE',
                                  value: '1ml / 100 unit',
                                ),

                                // Warning
                                if (_isDoseWarning || _isDoseDanger) ...[
                                  const SizedBox(height: AppSpacing.base),
                                  Container(
                                    padding: const EdgeInsets.all(
                                        AppSpacing.sm),
                                    decoration: BoxDecoration(
                                      color: (_isDoseDanger
                                              ? AppColors.danger
                                              : AppColors.warning)
                                          .withValues(alpha: 0.1),
                                      borderRadius:
                                          BorderRadius.circular(6),
                                      border: Border.all(
                                        color: (_isDoseDanger
                                                ? AppColors.danger
                                                : AppColors.warning)
                                            .withValues(alpha: 0.3),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.warning_rounded,
                                          size: 14,
                                          color: _isDoseDanger
                                              ? AppColors.danger
                                              : AppColors.warning,
                                        ),
                                        const SizedBox(
                                            width: AppSpacing.xs),
                                        Expanded(
                                          child: Text(
                                            _isDoseDanger
                                                ? 'Very high volume. Verify with provider.'
                                                : 'Higher than typical. Double-check values.',
                                            style: AppTypography
                                                .disclaimer
                                                .copyWith(
                                              color: _isDoseDanger
                                                  ? AppColors.danger
                                                  : AppColors.warning,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Disclaimer ───────────────────────────────────
                    const SizedBox(height: AppSpacing.base),
                    Text(
                      'Unit conversion tool for reference only. Always verify calculations with your healthcare provider before administering any substance.',
                      style: AppTypography.disclaimer,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppSpacing.massive),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Supporting widgets ────────────────────────────────────────────────────

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.suffix,
    required this.controller,
    required this.onChanged,
  });

  final String label;
  final String suffix;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.systemLabel.copyWith(
            color: AppColors.textTertiary,
            fontSize: 9,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: AppSpacing.inputHeight,
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                  ],
                  style: AppTypography.heroSmall.copyWith(fontSize: 20),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    filled: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: Text(
                  suffix,
                  style: AppTypography.unit.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.systemLabel.copyWith(
            color: AppColors.textTertiary,
            fontSize: 9,
          ),
        ),
        Text(
          value,
          style: AppTypography.tabular.copyWith(fontSize: 13),
        ),
      ],
    );
  }
}
