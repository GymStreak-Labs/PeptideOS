import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/custom_compound.dart';
import '../../../models/protocol.dart';
import '../providers/custom_compound_provider.dart';

class CustomCompoundLibraryScreen extends StatefulWidget {
  const CustomCompoundLibraryScreen({super.key});

  @override
  State<CustomCompoundLibraryScreen> createState() =>
      _CustomCompoundLibraryScreenState();
}

class _CustomCompoundLibraryScreenState
    extends State<CustomCompoundLibraryScreen> {
  bool _showArchived = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomCompoundProvider>();
    final compounds = _showArchived ? provider.archived : provider.active;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        onPressed: () => _openEditor(context),
        icon: const Icon(Icons.add_rounded),
        label: Text('NEW PRESET', style: AppTypography.button),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.sm,
                  AppSpacing.sm,
                  AppSpacing.screenHorizontal,
                  AppSpacing.base,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SYS.LIBRARY // PERSONAL',
                            style: AppTypography.systemLabel,
                          ),
                          Text('My compounds', style: AppTypography.h2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: AppCard(
                  borderColor: AppColors.borderCyan,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.inventory_2_outlined,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Save labels and vial sizes you enter yourself. '
                          'Presets are tracking shortcuts—not dose guidance.',
                          style: AppTypography.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.base,
                  AppSpacing.screenHorizontal,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _showArchived ? 'ARCHIVED' : 'ACTIVE PRESETS',
                        style: AppTypography.systemLabel,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          setState(() => _showArchived = !_showArchived),
                      icon: Icon(
                        _showArchived
                            ? Icons.inventory_2_outlined
                            : Icons.archive_outlined,
                        size: 17,
                      ),
                      label: Text(
                        _showArchived ? 'Show active' : 'Archived',
                        style: AppTypography.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Text(
                      provider.error!,
                      style: AppTypography.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            else if (compounds.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyCompounds(archived: _showArchived),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                sliver: SliverList.separated(
                  itemCount: compounds.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.cardGap),
                  itemBuilder: (_, index) {
                    final compound = compounds[index];
                    return AppCard(
                      onTap: () => _openEditor(context, compound),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.borderCyan),
                            ),
                            child: const Icon(
                              Icons.science_outlined,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  compound.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.labelLarge,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${_amount(compound.vialAmount)} ${compound.vialUnit} vial'
                                  ' · ${_routeLabel(compound.route)}',
                                  style: AppTypography.bodySmall.copyWith(
                                    fontFamily: 'JetBrainsMono',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            color: AppColors.surfaceContainer,
                            iconColor: AppColors.textTertiary,
                            onSelected: (value) async {
                              if (value == 'edit') {
                                await _openEditor(context, compound);
                              } else {
                                await provider.setArchived(
                                  compound,
                                  value == 'archive',
                                );
                              }
                            },
                            itemBuilder: (_) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit preset'),
                              ),
                              PopupMenuItem(
                                value: compound.archived
                                    ? 'restore'
                                    : 'archive',
                                child: Text(
                                  compound.archived ? 'Restore' : 'Archive',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.screenBottom + 72),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openEditor(
    BuildContext context, [
    CustomCompound? compound,
  ]) async {
    HapticFeedback.selectionClick();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CustomCompoundEditor(initial: compound),
    );
  }
}

class _EmptyCompounds extends StatelessWidget {
  const _EmptyCompounds({required this.archived});
  final bool archived;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              archived ? Icons.archive_outlined : Icons.science_outlined,
              color: AppColors.textTertiary,
              size: 42,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              archived ? 'No archived presets' : 'No saved compounds',
              style: AppTypography.h3,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              archived
                  ? 'Archived presets stay here until you restore them.'
                  : 'Create a reusable label and vial-size preset.',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomCompoundEditor extends StatefulWidget {
  const _CustomCompoundEditor({this.initial});
  final CustomCompound? initial;

  @override
  State<_CustomCompoundEditor> createState() => _CustomCompoundEditorState();
}

class _CustomCompoundEditorState extends State<_CustomCompoundEditor> {
  late final TextEditingController _name;
  late final TextEditingController _vialAmount;
  late final TextEditingController _notes;
  late String _vialUnit;
  late String _trackingUnit;
  late String _route;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _name = TextEditingController(text: initial?.name ?? '');
    _vialAmount = TextEditingController(
      text: initial == null ? '' : _amount(initial.vialAmount),
    );
    _notes = TextEditingController(text: initial?.notes ?? '');
    _vialUnit = initial?.vialUnit ?? 'mg';
    _trackingUnit = initial?.trackingUnit ?? 'mcg';
    _route = initial?.route ?? 'subcutaneous';
  }

  @override
  void dispose() {
    _name.dispose();
    _vialAmount.dispose();
    _notes.dispose();
    super.dispose();
  }

  bool get _valid =>
      _name.text.trim().isNotEmpty &&
      (parseDecimalInput(_vialAmount.text) ?? 0) > 0;

  Future<void> _save() async {
    if (!_valid || _saving) return;
    setState(() => _saving = true);
    try {
      await context.read<CustomCompoundProvider>().save(
        existing: widget.initial,
        name: _name.text,
        vialAmount: parseDecimalInput(_vialAmount.text)!,
        vialUnit: _vialUnit,
        trackingUnit: _trackingUnit,
        route: _route,
        notes: _notes.text,
      );
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save preset. Try again.')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.9,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.sheetRadius),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: AppSpacing.sheetHandleWidth,
                    height: AppSpacing.sheetHandleHeight,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('PRESET.COMPOUND', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  widget.initial == null ? 'New compound' : 'Edit compound',
                  style: AppTypography.h2,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Enter only the details printed on your own vial.',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: AppSpacing.lg),
                _InputFrame(
                  label: 'COMPOUND LABEL',
                  child: TextField(
                    controller: _name,
                    onChanged: (_) => setState(() {}),
                    textCapitalization: TextCapitalization.words,
                    style: AppTypography.bodyLarge,
                    decoration: const InputDecoration(
                      hintText: 'e.g. My compound',
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.base),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _InputFrame(
                        label: 'VIAL AMOUNT',
                        child: TextField(
                          controller: _vialAmount,
                          onChanged: (_) => setState(() {}),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: const [decimalInputFormatter],
                          style: AppTypography.tabular.copyWith(fontSize: 18),
                          decoration: const InputDecoration(
                            hintText: '0',
                            border: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.cardGap),
                    Expanded(
                      flex: 3,
                      child: _ChoiceRow(
                        label: 'VIAL UNIT',
                        options: const ['mcg', 'mg', 'IU'],
                        selected: _vialUnit,
                        onSelected: (value) =>
                            setState(() => _vialUnit = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.base),
                _ChoiceRow(
                  label: 'TRACKING UNIT',
                  options: const ['mcg', 'mg', 'IU'],
                  selected: _trackingUnit,
                  onSelected: (value) => setState(() => _trackingUnit = value),
                ),
                const SizedBox(height: AppSpacing.base),
                Text('ROUTE', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final route in kRoutes)
                      _ChoiceChip(
                        label: route.label,
                        selected: _route == route.key,
                        onTap: () => setState(() => _route = route.key),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.base),
                _InputFrame(
                  label: 'NOTES OPTIONAL',
                  child: TextField(
                    controller: _notes,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    style: AppTypography.bodyMedium,
                    decoration: const InputDecoration(
                      hintText: 'Label or storage note',
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.all(AppSpacing.md),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'No dosing recommendation is created. Protocol amounts are '
                  'always entered separately by you.',
                  style: AppTypography.disclaimer,
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: widget.initial == null
                      ? 'SAVE PRESET'
                      : 'SAVE CHANGES',
                  icon: Icons.check_rounded,
                  isLoading: _saving,
                  onPressed: _valid ? _save : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputFrame extends StatelessWidget {
  const _InputFrame({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.systemLabel),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
            border: Border.all(color: AppColors.border),
          ),
          child: child,
        ),
      ],
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.label,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.systemLabel),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (final option in options)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: option == options.last ? 0 : 4,
                  ),
                  child: _ChoiceChip(
                    label: option,
                    selected: selected == option,
                    onTap: () => onSelected(option),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
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
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.inputFill,
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.labelMedium.copyWith(
            color: selected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

String _amount(double value) => value == value.roundToDouble()
    ? value.toStringAsFixed(0)
    : value.toStringAsFixed(2).replaceFirst(RegExp(r'0+$'), '');

String _routeLabel(String route) => kRoutes
    .firstWhere(
      (candidate) => candidate.key == route,
      orElse: () => kRoutes.first,
    )
    .label;
