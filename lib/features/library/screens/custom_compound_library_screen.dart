import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/custom_compound.dart';
import '../../../models/protocol.dart';
import '../providers/custom_compound_provider.dart';
import '../utils/library_labels.dart';

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
    final l10n = AppLocalizations.of(context);
    final amountFormat = NumberFormat('#,##0.##', l10n.localeName);
    final provider = context.watch<CustomCompoundProvider>();
    final compounds = _showArchived ? provider.archived : provider.active;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        onPressed: () => _openEditor(context),
        icon: const Icon(Icons.add_rounded),
        label: Text(
          l10n.addCompound,
          style: AppTypography.button.copyWith(color: AppColors.background),
        ),
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
                            l10n.personalLibrarySystemLabel,
                            style: AppTypography.systemLabel,
                          ),
                          Text(l10n.myCompounds, style: AppTypography.h2),
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
                          l10n.customCompoundIntro,
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
                        _showArchived
                            ? l10n.archivedHeading
                            : l10n.activePresetsHeading,
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
                        _showArchived ? l10n.showActive : l10n.archivedAction,
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
                      l10n.customCompoundsLoadFailed,
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
                                  l10n.compoundVialSummary(
                                    amountFormat.format(compound.vialAmount),
                                    compound.vialUnit,
                                    localizedProtocolRouteLabel(
                                      l10n,
                                      compound.route,
                                    ),
                                  ),
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
                            itemBuilder: (menuContext) {
                              final menuL10n = AppLocalizations.of(menuContext);
                              return [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text(menuL10n.editPreset),
                                ),
                                PopupMenuItem(
                                  value: compound.archived
                                      ? 'restore'
                                      : 'archive',
                                  child: Text(
                                    compound.archived
                                        ? menuL10n.restorePreset
                                        : menuL10n.archivePreset,
                                  ),
                                ),
                              ];
                            },
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
      builder: (sheetContext) => _CustomCompoundEditor(initial: compound),
    );
  }
}

class _EmptyCompounds extends StatelessWidget {
  const _EmptyCompounds({required this.archived});
  final bool archived;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
              archived ? l10n.noArchivedPresets : l10n.noSavedCompounds,
              style: AppTypography.h3,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              archived ? l10n.archivedPresetsHint : l10n.createPresetHint,
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
    final l10n = AppLocalizations.of(context);
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
    } catch (error) {
      debugPrint('Could not save custom compound preset: $error');
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.saveCompoundFailed)));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                Text(
                  l10n.presetCompoundSystemLabel,
                  style: AppTypography.systemLabel,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  widget.initial == null ? l10n.newCompound : l10n.editCompound,
                  style: AppTypography.h2,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.ownVialDetailsHint, style: AppTypography.bodySmall),
                const SizedBox(height: AppSpacing.lg),
                _InputFrame(
                  label: l10n.compoundLabel,
                  child: TextField(
                    controller: _name,
                    onChanged: (_) => setState(() {}),
                    textCapitalization: TextCapitalization.words,
                    style: AppTypography.bodyLarge,
                    decoration: InputDecoration(
                      hintText: l10n.compoundNameExample,
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
                        label: l10n.vialAmount,
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
                        label: l10n.vialUnitLabel,
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
                  label: l10n.trackingUnitLabel,
                  options: const ['mcg', 'mg', 'IU'],
                  selected: _trackingUnit,
                  onSelected: (value) => setState(() => _trackingUnit = value),
                ),
                const SizedBox(height: AppSpacing.base),
                Text(l10n.routeLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final route in kRoutes)
                      _ChoiceChip(
                        label: localizedProtocolRouteLabel(l10n, route.key),
                        selected: _route == route.key,
                        onTap: () => setState(() => _route = route.key),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.base),
                _InputFrame(
                  label: l10n.notesOptional,
                  child: TextField(
                    controller: _notes,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    style: AppTypography.bodyMedium,
                    decoration: InputDecoration(
                      hintText: l10n.compoundNoteExample,
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.all(AppSpacing.md),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.noDoseRecommendation,
                  style: AppTypography.disclaimer,
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: widget.initial == null
                      ? l10n.savePreset
                      : l10n.saveChanges,
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
