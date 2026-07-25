import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/conversion_workspace.dart';
import '../widgets/syringe_visual.dart';

/// A user-input-driven reconstitution unit-conversion workspace.
///
/// This screen converts quantities only. It never selects or recommends an
/// amount, frequency, protocol, or medical action.
class ReconstitutionScreen extends StatefulWidget {
  const ReconstitutionScreen({
    super.key,
    this.initialInput,
    this.savedCalculations = const [],
    this.onSavedCalculationsChanged,
  });

  final ConversionInput? initialInput;
  final List<SavedVialCalculation> savedCalculations;
  final Future<void> Function(List<SavedVialCalculation> calculations)?
  onSavedCalculationsChanged;

  @override
  State<ReconstitutionScreen> createState() => _ReconstitutionScreenState();
}

class _ReconstitutionScreenState extends State<ReconstitutionScreen> {
  late final TextEditingController _vialController;
  late final TextEditingController _diluentController;
  late final TextEditingController _desiredController;
  late ConversionAmountUnit _desiredUnit;
  late ConversionSyringe _syringe;
  late List<SavedVialCalculation> _saved;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialInput;
    _vialController = TextEditingController(
      text: initial == null ? '' : _editableNumber(initial.vialAmountMg),
    );
    _diluentController = TextEditingController(
      text: initial == null ? '' : _editableNumber(initial.diluentVolumeMl),
    );
    _desiredController = TextEditingController(
      text: initial == null ? '' : _editableNumber(initial.desiredAmount),
    );
    _desiredUnit =
        initial?.desiredAmountUnit ?? ConversionAmountUnit.micrograms;
    _syringe = initial?.syringe ?? ConversionSyringe.units100;
    _saved = List<SavedVialCalculation>.from(widget.savedCalculations);
  }

  ConversionInput get _input => ConversionInput(
    vialAmountMg: parseDecimalInput(_vialController.text) ?? 0,
    diluentVolumeMl: parseDecimalInput(_diluentController.text) ?? 0,
    desiredAmount: parseDecimalInput(_desiredController.text) ?? 0,
    desiredAmountUnit: _desiredUnit,
    syringe: _syringe,
  );

  ConversionResult get _result => _input.calculate();

  @override
  void dispose() {
    _vialController.dispose();
    _diluentController.dispose();
    _desiredController.dispose();
    super.dispose();
  }

  Future<void> _saveCalculation() async {
    if (!_result.isValid) return;
    final now = DateTime.now().toUtc();
    final current = _input;
    final item = SavedVialCalculation(
      id: now.microsecondsSinceEpoch.toString(),
      createdAt: now,
      input: current,
    );
    final updated = <SavedVialCalculation>[
      item,
      ..._saved.where((saved) => !_sameInput(saved.input, current)),
    ].take(8).toList();

    setState(() => _saved = updated);
    HapticFeedback.lightImpact();
    await widget.onSavedCalculationsChanged?.call(updated);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Calculation saved to this account.')),
    );
  }

  Future<void> _removeSaved(SavedVialCalculation item) async {
    final updated = _saved.where((saved) => saved.id != item.id).toList();
    setState(() => _saved = updated);
    await widget.onSavedCalculationsChanged?.call(updated);
  }

  void _loadSaved(SavedVialCalculation item) {
    final input = item.input;
    setState(() {
      _vialController.text = _editableNumber(input.vialAmountMg);
      _diluentController.text = _editableNumber(input.diluentVolumeMl);
      _desiredController.text = _editableNumber(input.desiredAmount);
      _desiredUnit = input.desiredAmountUnit;
      _syringe = input.syringe;
    });
    HapticFeedback.selectionClick();
  }

  void _clear() {
    setState(() {
      _vialController.clear();
      _diluentController.clear();
      _desiredController.clear();
      _desiredUnit = ConversionAmountUnit.micrograms;
      _syringe = ConversionSyringe.units100;
    });
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(onClear: _clear),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                  AppSpacing.screenHorizontal,
                  AppSpacing.massive,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter values from your own vial, diluent, and plan. '
                      'PepMod converts those values into volume and U-100 syringe units.',
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const _SafetyBanner(),
                    const SizedBox(height: AppSpacing.xl),
                    _SectionTitle(
                      step: '01',
                      title: 'Vial + diluent',
                      caption: 'Source: labels on your vial and diluent.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _InputField(
                            key: const Key('vial-amount-field'),
                            label: 'VIAL AMOUNT',
                            helper: 'Amount printed on vial',
                            suffix: 'mg',
                            controller: _vialController,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.cardGap),
                        Expanded(
                          child: _InputField(
                            key: const Key('diluent-volume-field'),
                            label: 'DILUENT',
                            helper: 'Volume you added',
                            suffix: 'mL',
                            controller: _diluentController,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _SectionTitle(
                      step: '02',
                      title: 'Amount to convert',
                      caption: 'Source: an amount you were already given.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _DesiredAmountField(
                      controller: _desiredController,
                      unit: _desiredUnit,
                      onUnitChanged: (unit) =>
                          setState(() => _desiredUnit = unit),
                      onChanged: () => setState(() {}),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _SectionTitle(
                      step: '03',
                      title: 'Your syringe',
                      caption: 'Select the capacity printed on the barrel.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _SyringeSelector(
                      value: _syringe,
                      onChanged: (value) => setState(() => _syringe = value),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Text('CONVERSION.RESULT', style: AppTypography.systemLabel),
                    const SizedBox(height: AppSpacing.md),
                    _ResultCard(
                      result: result,
                      syringe: _syringe,
                      onSave: result.isValid ? _saveCalculation : null,
                    ),
                    if (_saved.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xxl),
                      _SavedSection(
                        items: _saved,
                        onLoad: _loadSaved,
                        onRemove: _removeSaved,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'Educational unit-conversion tool only. PepMod does not '
                      'recommend an amount or frequency. Recheck the source '
                      'labels and confirm your calculation with a qualified '
                      'healthcare professional before use.',
                      style: AppTypography.disclaimer.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      textAlign: TextAlign.center,
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
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onClear});

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        0,
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('UTIL.CONVERSION', style: AppTypography.systemLabel),
                Text('Vial workspace', style: AppTypography.h3),
              ],
            ),
          ),
          TextButton(
            onPressed: onClear,
            child: Text(
              'CLEAR',
              style: AppTypography.systemLabel.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SafetyBanner extends StatelessWidget {
  const _SafetyBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.borderCyan),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.calculate_outlined,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Conversion only — this workspace never chooses an amount or schedule.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.step,
    required this.title,
    required this.caption,
  });

  final String step;
  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.borderCyan),
          ),
          child: Text(step, style: AppTypography.systemLabel),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.labelLarge),
              const SizedBox(height: 2),
              Text(caption, style: AppTypography.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    super.key,
    required this.label,
    required this.helper,
    required this.suffix,
    required this.controller,
    required this.onChanged,
  });

  final String label;
  final String helper;
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
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: const [decimalInputFormatter],
                  style: AppTypography.heroSmall.copyWith(fontSize: 19),
                  decoration: const InputDecoration(
                    hintText: '0',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    filled: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: Text(
                  suffix,
                  style: AppTypography.unit.copyWith(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(helper, style: AppTypography.disclaimer, maxLines: 2),
      ],
    );
  }
}

class _DesiredAmountField extends StatelessWidget {
  const _DesiredAmountField({
    required this.controller,
    required this.unit,
    required this.onUnitChanged,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ConversionAmountUnit unit;
  final ValueChanged<ConversionAmountUnit> onUnitChanged;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              key: const Key('desired-amount-field'),
              controller: controller,
              onChanged: (_) => onChanged(),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: const [decimalInputFormatter],
              style: AppTypography.heroSmall.copyWith(fontSize: 20),
              decoration: const InputDecoration(
                hintText: 'Enter amount',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                filled: false,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          _UnitToggle(unit: unit, onChanged: onUnitChanged),
        ],
      ),
    );
  }
}

class _UnitToggle extends StatelessWidget {
  const _UnitToggle({required this.unit, required this.onChanged});

  final ConversionAmountUnit unit;
  final ValueChanged<ConversionAmountUnit> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final option in ConversionAmountUnit.values)
            GestureDetector(
              onTap: () => onChanged(option),
              child: AnimatedContainer(
                duration: AppDurations.fast,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: option == unit
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: option == unit
                      ? Border.all(color: AppColors.borderCyan)
                      : null,
                ),
                child: Text(
                  option.label,
                  style: AppTypography.tabular.copyWith(
                    fontSize: 12,
                    color: option == unit
                        ? AppColors.primary
                        : AppColors.textTertiary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SyringeSelector extends StatelessWidget {
  const _SyringeSelector({required this.value, required this.onChanged});

  final ConversionSyringe value;
  final ValueChanged<ConversionSyringe> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.inputHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ConversionSyringe>(
          key: const Key('syringe-selector'),
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.surfaceContainer,
          icon: const Icon(Icons.expand_more_rounded, color: AppColors.primary),
          style: AppTypography.tabular.copyWith(fontSize: 14),
          items: [
            for (final syringe in ConversionSyringe.values)
              DropdownMenuItem(
                value: syringe,
                child: Text('U-100 · ${syringe.label}'),
              ),
          ],
          onChanged: (next) {
            if (next != null) onChanged(next);
          },
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.result,
    required this.syringe,
    required this.onSave,
  });

  final ConversionResult result;
  final ConversionSyringe syringe;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    if (!result.isValid) {
      return AppCard(
        child: Row(
          children: [
            const Icon(
              Icons.keyboard_alt_outlined,
              color: AppColors.textTertiary,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(result.error!, style: AppTypography.bodyMedium),
            ),
          ],
        ),
      );
    }

    final warning = result.exceedsSyringeCapacity;
    final accent = warning ? AppColors.warning : AppColors.primary;
    return AppCard(
      borderColor: accent.withValues(alpha: 0.55),
      glowColor: warning ? AppColors.warningGlow : AppColors.primaryGlow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DRAW TO', style: AppTypography.systemLabel),
                    const SizedBox(height: AppSpacing.sm),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            result.formattedDrawUnits,
                            key: const Key('draw-units-result'),
                            style: AppTypography.heroLarge.copyWith(
                              color: accent,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text('units', style: AppTypography.unit),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${result.formattedDrawVolumeMl} mL',
                      style: AppTypography.tabular.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _DataRow(
                      label: 'CONCENTRATION',
                      value: '${result.formattedConcentration} mcg/mL',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _DataRow(
                      label: 'SYRINGE CAPACITY',
                      value: '${syringe.capacityUnits} units',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: 92,
                child: SyringeVisual(
                  fillFraction: (result.drawUnits / syringe.capacityUnits)
                      .clamp(0, 1),
                  totalUnits: syringe.capacityUnits,
                  fillUnits: result.drawUnits,
                  syringeType: _visualType(syringe),
                  height: 190,
                ),
              ),
            ],
          ),
          if (warning) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.warning.withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                'The converted volume is larger than this syringe capacity. '
                'Choose the correct syringe or recheck your entries.',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.warning,
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.base),
          PrimaryButton(label: 'SAVE PRESET', onPressed: onSave),
        ],
      ),
    );
  }
}

class _SavedSection extends StatelessWidget {
  const _SavedSection({
    required this.items,
    required this.onLoad,
    required this.onRemove,
  });

  final List<SavedVialCalculation> items;
  final ValueChanged<SavedVialCalculation> onLoad;
  final Future<void> Function(SavedVialCalculation) onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SAVED.VIALS', style: AppTypography.systemLabel),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Tap a saved calculation to reuse its inputs.',
          style: AppTypography.bodySmall,
        ),
        const SizedBox(height: AppSpacing.md),
        for (final item in items) ...[
          AppCard(
            onTap: () => onLoad(item),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.science_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.label, style: AppTypography.labelLarge),
                      const SizedBox(height: 2),
                      Text(item.detail, style: AppTypography.bodySmall),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Remove saved calculation',
                  onPressed: () => onRemove(item),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textTertiary,
                    size: 19,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.cardGap),
        ],
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
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTypography.systemLabel.copyWith(
              color: AppColors.textTertiary,
              fontSize: 8,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(value, style: AppTypography.tabular.copyWith(fontSize: 12)),
      ],
    );
  }
}

bool _sameInput(ConversionInput a, ConversionInput b) =>
    a.vialAmountMg == b.vialAmountMg &&
    a.diluentVolumeMl == b.diluentVolumeMl &&
    a.desiredAmount == b.desiredAmount &&
    a.desiredAmountUnit == b.desiredAmountUnit &&
    a.syringe == b.syringe;

String _editableNumber(double value) {
  if (value == value.roundToDouble()) return value.toStringAsFixed(0);
  return value.toString().replaceFirst(RegExp(r'\.?0+$'), '');
}

SyringeType _visualType(ConversionSyringe syringe) => switch (syringe) {
  ConversionSyringe.units30 => SyringeType.insulin30,
  ConversionSyringe.units50 => SyringeType.insulin50,
  ConversionSyringe.units100 => SyringeType.insulin100,
};
