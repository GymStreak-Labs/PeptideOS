import 'package:provider/provider.dart';
import '../../../core/utils/dose_units.dart';
import '../../../core/utils/dose_presentation.dart';
import '../../../models/user_settings.dart';
import '../../profile/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/utils/localized_decimal_input.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';
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
    this.onApplyResult,
  });

  final ConversionInput? initialInput;
  final List<SavedVialCalculation> savedCalculations;
  final Future<void> Function(List<SavedVialCalculation> calculations)?
  onSavedCalculationsChanged;
  final ValueChanged<ConversionResult>? onApplyResult;

  @override
  State<ReconstitutionScreen> createState() => _ReconstitutionScreenState();
}

class _ReconstitutionScreenState extends State<ReconstitutionScreen> {
  late final TextEditingController _vialController;
  late final TextEditingController _diluentController;
  late final TextEditingController _desiredController;
  late ConversionAmountUnit _desiredUnit;
  late ConversionQuantityMode _quantityMode;
  late ConversionSyringe _syringe;
  late List<SavedVialCalculation> _saved;
  bool _initialNumbersLocalized = false;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialInput;
    _vialController = TextEditingController();
    _diluentController = TextEditingController();
    _desiredController = TextEditingController();
    _desiredUnit =
        initial?.desiredAmountUnit ?? ConversionAmountUnit.micrograms;
    _quantityMode = initial?.quantityMode ?? ConversionQuantityMode.mass;
    _syringe = initial?.syringe ?? ConversionSyringe.units100;
    _saved = List<SavedVialCalculation>.from(widget.savedCalculations);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialNumbersLocalized) return;
    final initial = widget.initialInput;
    if (initial != null) {
      final localeName = AppLocalizations.of(context).localeName;
      _vialController.text = formatLocalizedDecimalInput(
        initial.vialAmountMg,
        localeName: localeName,
      );
      _diluentController.text = formatLocalizedDecimalInput(
        initial.diluentVolumeMl,
        localeName: localeName,
      );
      _desiredController.text = formatLocalizedDecimalInput(
        initial.desiredAmount,
        maximumFractionDigits: 12,
        localeName: localeName,
      );
    }
    if (_quantityMode == ConversionQuantityMode.mass) {
      _changeDesiredUnit(_preferredUnit(_desiredUnit));
    }
    _initialNumbersLocalized = true;
  }

  ConversionAmountUnit _preferredUnit(ConversionAmountUnit original) {
    final preference =
        context.read<SettingsProvider?>()?.settings.doseUnitPreference ??
        DoseUnitPreference.original;
    return preferredDoseUnit(original.label, preference) == 'mg'
        ? ConversionAmountUnit.milligrams
        : ConversionAmountUnit.micrograms;
  }

  void _changeDesiredUnit(ConversionAmountUnit next) {
    if (next == _desiredUnit) return;
    final amount = parseDecimalInput(_desiredController.text);
    _desiredController.text = amount == null
        ? ''
        : formatDoseNumber(
            convertMassDose(amount, _desiredUnit.label, next.label),
            AppLocalizations.of(context).localeName,
          );
    _desiredUnit = next;
  }

  ConversionInput get _input => ConversionInput(
    vialAmount: parseDecimalInput(_vialController.text) ?? 0,
    diluentVolumeMl: parseDecimalInput(_diluentController.text) ?? 0,
    desiredAmount: parseDecimalInput(_desiredController.text) ?? 0,
    desiredAmountUnit: _desiredUnit,
    quantityMode: _quantityMode,
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
    final calculationSavedMessage = AppLocalizations.of(
      context,
    ).calculationSaved;
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(calculationSavedMessage)));
  }

  Future<void> _removeSaved(SavedVialCalculation item) async {
    final updated = _saved.where((saved) => saved.id != item.id).toList();
    setState(() => _saved = updated);
    await widget.onSavedCalculationsChanged?.call(updated);
  }

  void _loadSaved(SavedVialCalculation item) {
    final input = item.input;
    final localeName = AppLocalizations.of(context).localeName;
    setState(() {
      _vialController.text = formatLocalizedDecimalInput(
        input.vialAmount,
        localeName: localeName,
      );
      _diluentController.text = formatLocalizedDecimalInput(
        input.diluentVolumeMl,
        localeName: localeName,
      );
      _desiredController.text = formatLocalizedDecimalInput(
        input.desiredAmount,
        maximumFractionDigits: 12,
        localeName: localeName,
      );
      _desiredUnit = input.desiredAmountUnit;
      _quantityMode = input.quantityMode;
      if (_quantityMode == ConversionQuantityMode.mass) {
        _changeDesiredUnit(_preferredUnit(_desiredUnit));
      }
      _syringe = input.syringe;
    });
    HapticFeedback.selectionClick();
  }

  void _clear() {
    setState(() {
      _vialController.clear();
      _diluentController.clear();
      _desiredController.clear();
      _desiredUnit = _preferredUnit(ConversionAmountUnit.micrograms);
      _quantityMode = ConversionQuantityMode.mass;
      _syringe = ConversionSyringe.units100;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                    Text(l10n.converterIntro, style: AppTypography.bodyMedium),
                    const SizedBox(height: AppSpacing.sm),
                    const _SafetyBanner(),
                    const SizedBox(height: AppSpacing.xl),
                    _QuantityModeSelector(
                      value: _quantityMode,
                      onChanged: (mode) {
                        setState(() {
                          _quantityMode = mode;
                          if (mode ==
                              ConversionQuantityMode.internationalUnits) {
                            _desiredUnit = ConversionAmountUnit.micrograms;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _SectionTitle(
                      step: '01',
                      title: l10n.vialAndDiluent,
                      caption:
                          _quantityMode ==
                              ConversionQuantityMode.internationalUnits
                          ? l10n.iuSourceCaption
                          : l10n.massSourceCaption,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _InputField(
                            key: const Key('vial-amount-field'),
                            label: l10n.vialAmount,
                            helper: l10n.amountPrintedOnVial,
                            suffix:
                                _quantityMode ==
                                    ConversionQuantityMode.internationalUnits
                                ? 'IU'
                                : 'mg',
                            controller: _vialController,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.cardGap),
                        Expanded(
                          child: _InputField(
                            key: const Key('diluent-volume-field'),
                            label: l10n.diluent,
                            helper: l10n.volumeAdded,
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
                      title: l10n.amountToConvert,
                      caption:
                          _quantityMode ==
                              ConversionQuantityMode.internationalUnits
                          ? l10n.iuAmountCaption
                          : l10n.massAmountCaption,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _DesiredAmountField(
                      controller: _desiredController,
                      unit: _desiredUnit,
                      quantityMode: _quantityMode,
                      onUnitChanged: (unit) =>
                          setState(() => _changeDesiredUnit(unit)),
                      onChanged: () => setState(() {}),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _SectionTitle(
                      step: '03',
                      title: l10n.yourSyringe,
                      caption: l10n.syringeCaption,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _SyringeSelector(
                      value: _syringe,
                      onChanged: (value) => setState(() => _syringe = value),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      l10n.conversionResultSystemLabel,
                      style: AppTypography.systemLabel,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ResultCard(
                      result: result,
                      syringe: _syringe,
                      quantityMode: _quantityMode,
                      onSave: result.isValid ? _saveCalculation : null,
                      onApply: result.isValid && !result.exceedsSyringeCapacity
                          ? () => widget.onApplyResult?.call(result)
                          : null,
                      showApply: widget.onApplyResult != null,
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
                      l10n.educationalConverterDisclaimer,
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
    final l10n = AppLocalizations.of(context);
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
            tooltip: l10n.back,
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
                Text(
                  l10n.conversionSystemLabel,
                  style: AppTypography.systemLabel,
                ),
                Text(l10n.vialWorkspace, style: AppTypography.h3),
              ],
            ),
          ),
          TextButton(
            onPressed: onClear,
            child: Text(
              l10n.clear,
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
    final l10n = AppLocalizations.of(context);
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
              l10n.conversionOnly,
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

class _QuantityModeSelector extends StatelessWidget {
  const _QuantityModeSelector({required this.value, required this.onChanged});

  final ConversionQuantityMode value;
  final ValueChanged<ConversionQuantityMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.measurementModeSystemLabel, style: AppTypography.systemLabel),
        const SizedBox(height: AppSpacing.xs),
        Text(l10n.sameUnitFamily, style: AppTypography.bodySmall),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            for (final mode in ConversionQuantityMode.values) ...[
              if (mode != ConversionQuantityMode.values.first)
                const SizedBox(width: AppSpacing.cardGap),
              Expanded(
                child: GestureDetector(
                  key: Key('quantity-mode-${mode.name}'),
                  onTap: () => onChanged(mode),
                  child: AnimatedContainer(
                    duration: AppDurations.fast,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: mode == value
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.inputFill,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.inputRadius,
                      ),
                      border: Border.all(
                        color: mode == value
                            ? AppColors.borderCyan
                            : AppColors.border,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mode == ConversionQuantityMode.mass
                              ? l10n.mass
                              : 'IU',
                          style: AppTypography.labelLarge.copyWith(
                            color: mode == value
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          mode == ConversionQuantityMode.mass
                              ? 'mg / mcg'
                              : l10n.iuOnly,
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        if (value == ConversionQuantityMode.internationalUnits) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.iuSafety,
            key: const Key('iu-mode-safety-copy'),
            style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
          ),
        ],
      ],
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
    required this.quantityMode,
    required this.onUnitChanged,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ConversionAmountUnit unit;
  final ConversionQuantityMode quantityMode;
  final ValueChanged<ConversionAmountUnit> onUnitChanged;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
              decoration: InputDecoration(
                hintText: l10n.enterAmount,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                filled: false,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          if (quantityMode == ConversionQuantityMode.internationalUnits)
            const _FixedIuBadge()
          else
            _UnitToggle(unit: unit, onChanged: onUnitChanged),
        ],
      ),
    );
  }
}

class _FixedIuBadge extends StatelessWidget {
  const _FixedIuBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderCyan),
      ),
      child: Text(
        'IU',
        style: AppTypography.tabular.copyWith(
          fontSize: 12,
          color: AppColors.primary,
        ),
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
    final l10n = AppLocalizations.of(context);
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
                child: Text(
                  l10n.syringeOption(
                    _localizedNumber(
                      syringe.volumeMl,
                      l10n.localeName,
                      maxDecimals: 1,
                    ),
                    _localizedNumber(
                      syringe.capacityUnits.toDouble(),
                      l10n.localeName,
                      maxDecimals: 0,
                    ),
                  ),
                ),
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
    required this.quantityMode,
    required this.onSave,
    required this.onApply,
    required this.showApply,
  });

  final ConversionResult result;
  final ConversionSyringe syringe;
  final ConversionQuantityMode quantityMode;
  final VoidCallback? onSave;
  final VoidCallback? onApply;
  final bool showApply;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
              child: Text(
                _localizedError(l10n, result.errorCode!),
                style: AppTypography.bodyMedium,
              ),
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
                    Text(l10n.drawTo, style: AppTypography.systemLabel),
                    const SizedBox(height: AppSpacing.sm),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _localizedNumber(
                              result.drawUnits,
                              l10n.localeName,
                              maxDecimals: 2,
                            ),
                            key: const Key('draw-units-result'),
                            style: AppTypography.heroLarge.copyWith(
                              color: accent,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(l10n.units, style: AppTypography.unit),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${_localizedNumber(result.drawVolumeMl, l10n.localeName, maxDecimals: 3)} mL',
                      style: AppTypography.tabular.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _DataRow(
                      label: l10n.concentration,
                      value:
                          '${context.displayDose(result.concentrationPerMl, quantityMode == ConversionQuantityMode.internationalUnits ? 'IU' : 'mcg')}/mL',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _DataRow(
                      label: l10n.syringeCapacity,
                      value: '${syringe.capacityUnits} ${l10n.units}',
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
                l10n.capacityWarning,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.warning,
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.base),
          if (showApply) ...[
            PrimaryButton(label: l10n.addToProtocol, onPressed: onApply),
            const SizedBox(height: AppSpacing.sm),
          ],
          PrimaryButton(label: l10n.savePreset, onPressed: onSave),
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
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.savedVialsSystemLabel, style: AppTypography.systemLabel),
        const SizedBox(height: AppSpacing.xs),
        Text(l10n.savedVialsHint, style: AppTypography.bodySmall),
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
                      Text(
                        _savedCalculationLabel(l10n, item),
                        style: AppTypography.labelLarge,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _savedCalculationDetail(context, item),
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: l10n.removeSavedCalculation,
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
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: AppTypography.systemLabel.copyWith(
              color: AppColors.textTertiary,
              fontSize: 8,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              maxLines: 1,
              style: AppTypography.tabular.copyWith(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}

bool _sameInput(ConversionInput a, ConversionInput b) =>
    a.vialAmount == b.vialAmount &&
    a.diluentVolumeMl == b.diluentVolumeMl &&
    a.desiredAmount == b.desiredAmount &&
    a.desiredAmountUnit == b.desiredAmountUnit &&
    a.quantityMode == b.quantityMode &&
    a.syringe == b.syringe;

String _localizedError(AppLocalizations l10n, ConversionError error) =>
    switch (error) {
      ConversionError.positiveNumbersRequired => l10n.errorPositiveNumbers,
      ConversionError.amountAboveVial => l10n.errorAmountAboveVial,
      ConversionError.conversionFailed => l10n.errorConversion,
    };

String _savedCalculationLabel(
  AppLocalizations l10n,
  SavedVialCalculation item,
) => l10n.savedCalculationLabel(
  _localizedNumber(item.input.vialAmount, l10n.localeName, maxDecimals: 2),
  item.input.quantityMode == ConversionQuantityMode.internationalUnits
      ? 'IU'
      : 'mg',
  _localizedNumber(item.input.diluentVolumeMl, l10n.localeName, maxDecimals: 2),
);

String _savedCalculationDetail(
  BuildContext context,
  SavedVialCalculation item,
) {
  final l10n = AppLocalizations.of(context);
  final unit =
      item.input.quantityMode == ConversionQuantityMode.internationalUnits
      ? 'IU'
      : item.input.desiredAmountUnit.label;
  return l10n.savedCalculationDetail(
    context.displayDoseNumber(item.input.desiredAmount, unit),
    context.displayDoseUnit(unit),
    _localizedNumber(
      item.input.syringe.capacityUnits.toDouble(),
      l10n.localeName,
      maxDecimals: 0,
    ),
  );
}

String _localizedNumber(
  double value,
  String locale, {
  required int maxDecimals,
}) {
  if (!value.isFinite) return '—';
  final pattern = switch (maxDecimals) {
    0 => '0',
    1 => '0.#',
    2 => '0.##',
    _ => '0.###',
  };
  final format = NumberFormat(pattern, locale)..turnOffGrouping();
  return format.format(value);
}

SyringeType _visualType(ConversionSyringe syringe) => switch (syringe) {
  ConversionSyringe.units30 => SyringeType.insulin30,
  ConversionSyringe.units50 => SyringeType.insulin50,
  ConversionSyringe.units100 => SyringeType.insulin100,
};
