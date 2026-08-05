import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/peptide.dart';
import '../../../l10n/app_localizations.dart';
import '../../protocol/screens/create_protocol_screen.dart';
import '../widgets/syringe_visual.dart';
import '../providers/peptide_provider.dart';
import '../utils/library_labels.dart';

/// Peptide detail — factual description, typical dose, stack info, and an
/// inline reconstitution calculator. CTA to add to a protocol.
class PeptideDetailScreen extends StatelessWidget {
  const PeptideDetailScreen({super.key, required this.peptide});

  final Peptide peptide;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                    tooltip: l10n.back,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.compoundSystemLabel,
                          style: AppTypography.systemLabel,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          peptide.name,
                          style: AppTypography.h2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                  AppSpacing.screenHorizontal,
                  AppSpacing.screenBottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category + half-life chips
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _InfoChip(
                          label: localizedPeptideCategoryLabel(
                            l10n,
                            peptide.category,
                          ),
                        ),
                        if (peptide.halfLife.isNotEmpty)
                          _InfoChip(
                            label: '${l10n.halfLife}: ${peptide.halfLife}',
                          ),
                        if (peptide.typicalCycleWeeks > 0)
                          _InfoChip(
                            label:
                                '${peptide.typicalCycleWeeks} ${l10n.weekCycle}',
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Description
                    Text(peptide.description, style: AppTypography.bodyLarge),
                    const SizedBox(height: AppSpacing.xl),

                    // Typical dose card
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.typicalDose,
                            style: AppTypography.systemLabel,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            peptide.typicalDose,
                            style: AppTypography.heroSmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            '${localizedProtocolRouteLabel(l10n, peptide.defaultRoute)} · ${localizedProtocolFrequencyLabel(l10n, peptide.defaultFrequency)}',
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.cardGap),

                    // Notes (if any)
                    if (peptide.notes.isNotEmpty) ...[
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.notes, style: AppTypography.systemLabel),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              peptide.notes,
                              style: AppTypography.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.cardGap),
                    ],

                    // Common stack
                    if (peptide.commonStack.isNotEmpty) ...[
                      Text(l10n.commonStack, style: AppTypography.systemLabel),
                      const SizedBox(height: AppSpacing.sm),
                      Builder(
                        builder: (ctx) {
                          final provider = ctx.read<PeptideProvider>();
                          final resolved = peptide.commonStack
                              .map((slug) => provider.findBySlug(slug))
                              .where((p) => p != null)
                              .cast<Peptide>()
                              .toList();
                          return Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: [
                              for (final p in resolved)
                                _StackChip(
                                  label: p.name,
                                  onTap: () {
                                    Navigator.of(ctx).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            PeptideDetailScreen(peptide: p),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],

                    // Inline reconstitution calculator
                    Text(
                      l10n.reconstitutionTool,
                      style: AppTypography.systemLabel,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _InlineReconstitutionCalculator(
                      initialDoseMcg: peptide.defaultDoseMcg,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Disclaimer
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.cardRadius,
                        ),
                        border: Border.all(
                          color: AppColors.warning.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: AppColors.warning,
                            size: AppSpacing.iconMedium,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              peptide.disclaimer,
                              style: AppTypography.disclaimer.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Add to protocol CTA
                    PrimaryButton(
                      label: l10n.addToProtocol,
                      icon: Icons.add_rounded,
                      onPressed: () => _addToProtocol(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToProtocol(BuildContext context) {
    HapticFeedback.lightImpact();
    // Opens the protocol builder. User can include this peptide by picking it
    // from the library picker inside the builder.
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const CreateProtocolScreen()));
  }
}

// ── Info chip ─────────────────────────────────────────────────────────────
class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.textSecondary,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _StackChip extends StatelessWidget {
  const _StackChip({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.borderCyan),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.primary,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Inline reconstitution calculator ─────────────────────────────────────
class _InlineReconstitutionCalculator extends StatefulWidget {
  const _InlineReconstitutionCalculator({required this.initialDoseMcg});
  final double initialDoseMcg;

  @override
  State<_InlineReconstitutionCalculator> createState() =>
      _InlineReconstitutionCalculatorState();
}

class _InlineReconstitutionCalculatorState
    extends State<_InlineReconstitutionCalculator> {
  late final TextEditingController _peptideMg;
  late final TextEditingController _waterMl;
  late final TextEditingController _doseMcg;
  bool _didLocalizeInitialValues = false;

  @override
  void initState() {
    super.initState();
    _peptideMg = TextEditingController(text: '5');
    _waterMl = TextEditingController(text: '2');
    _doseMcg = TextEditingController(
      text: widget.initialDoseMcg == widget.initialDoseMcg.roundToDouble()
          ? widget.initialDoseMcg.toStringAsFixed(0)
          : widget.initialDoseMcg.toStringAsFixed(1),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didLocalizeInitialValues) return;
    final locale = AppLocalizations.of(context).localeName;
    _peptideMg.text = NumberFormat('0.##', locale).format(5);
    _waterMl.text = NumberFormat('0.##', locale).format(2);
    _doseMcg.text = NumberFormat('0.#', locale).format(widget.initialDoseMcg);
    _didLocalizeInitialValues = true;
  }

  @override
  void dispose() {
    _peptideMg.dispose();
    _waterMl.dispose();
    _doseMcg.dispose();
    super.dispose();
  }

  double get _mg => parseDecimalInput(_peptideMg.text) ?? 0;
  double get _ml => parseDecimalInput(_waterMl.text) ?? 0;
  double get _dose => parseDecimalInput(_doseMcg.text) ?? 0;

  double get _concentration => _ml <= 0 ? 0 : (_mg * 1000) / _ml; // mcg per ml
  double get _drawMl => _concentration <= 0 ? 0 : _dose / _concentration;
  double get _units => _drawMl * 100;
  double get _fill => (_units / 100).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final unitFormat = NumberFormat('#,##0.0', l10n.localeName);
    final volumeFormat = NumberFormat('#,##0.00', l10n.localeName);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _NumField(
                  label: l10n.vialShort,
                  controller: _peptideMg,
                  onChanged: () => setState(() {}),
                ),
              ),
              const SizedBox(width: AppSpacing.cardGap),
              Expanded(
                child: _NumField(
                  label: l10n.bacShort,
                  controller: _waterMl,
                  onChanged: () => setState(() {}),
                ),
              ),
              const SizedBox(width: AppSpacing.cardGap),
              Expanded(
                child: _NumField(
                  label: l10n.doseShort,
                  controller: _doseMcg,
                  onChanged: () => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.drawTo, style: AppTypography.systemLabel),
                    const SizedBox(height: AppSpacing.xs),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _units.isFinite ? unitFormat.format(_units) : '—',
                            style: AppTypography.heroMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(l10n.units, style: AppTypography.unit),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _drawMl.isFinite
                          ? '${volumeFormat.format(_drawMl)} mL'
                          : '— mL',
                      style: AppTypography.bodySmall.copyWith(
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              SizedBox(
                width: 72,
                child: SyringeVisual(
                  fillFraction: _fill,
                  totalUnits: 100,
                  fillUnits: _units,
                  height: 140,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NumField extends StatelessWidget {
  const _NumField({
    required this.label,
    required this.controller,
    required this.onChanged,
  });
  final String label;
  final TextEditingController controller;
  final VoidCallback onChanged;

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
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: controller,
            onChanged: (_) => onChanged(),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: const [decimalInputFormatter],
            style: AppTypography.heroSmall.copyWith(fontSize: 16),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              filled: false,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
