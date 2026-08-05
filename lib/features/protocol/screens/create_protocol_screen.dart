import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/utils/localized_decimal_input.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/blend_vial.dart';
import '../../../models/peptide.dart';
import '../../../models/protocol.dart';
import '../../../l10n/app_localizations.dart';
import '../../library/providers/custom_compound_provider.dart';
import '../../library/providers/peptide_provider.dart';
import '../../library/screens/custom_compound_library_screen.dart';
import '../../library/utils/localized_peptide_content.dart';
import '../../subscription/providers/subscription_provider.dart';
import '../../subscription/screens/soft_paywall_sheet.dart';
import '../providers/dose_log_provider.dart';
import '../providers/protocol_provider.dart';
import '../widgets/peptide_label_color.dart';

const _customPeptideSlug = 'custom';
const _savedCompoundSlugPrefix = 'custom:';
const _blendVialSlug = 'custom-blend';

/// 3-step protocol builder: name → add peptides → start date + review.
class CreateProtocolScreen extends StatefulWidget {
  const CreateProtocolScreen({super.key, this.initialProtocol});

  final Protocol? initialProtocol;

  @override
  State<CreateProtocolScreen> createState() => _CreateProtocolScreenState();
}

class _CreateProtocolScreenState extends State<CreateProtocolScreen> {
  final _pageController = PageController();
  int _step = 0;

  late final TextEditingController _nameController;
  late final TextEditingController _notesController;
  final List<ProtocolPeptide> _peptides = [];
  DateTime _startDate = DateTime.now();
  bool _saving = false;

  bool get _isEditing => widget.initialProtocol != null;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialProtocol;
    _nameController = TextEditingController(text: initial?.name ?? '');
    _notesController = TextEditingController(text: initial?.notes ?? '');
    if (initial != null) {
      _startDate = initial.startDate;
      _peptides.addAll(initial.peptides.map(_cloneProtocolPeptide));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isEditing && _nameController.text.isEmpty) {
      _nameController.text = AppLocalizations.of(
        context,
      ).createProtocolDefaultName;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _handleAddPeptide(ProtocolPeptide p) async {
    final sub = context.read<SubscriptionProvider>();
    if (!sub.canAddPeptide(_peptides.length)) {
      final purchased = await showSoftPaywall(
        context,
        source: 'peptide_limit',
        reason: AppLocalizations.of(context).createProtocolFreeLimitReason,
      );
      if (!purchased) return;
      if (!mounted) return;
    }
    setState(() => _peptides.add(p));
  }

  void _next() {
    if (_step < 2) {
      setState(() => _step++);
      _pageController.animateToPage(
        _step,
        duration: AppDurations.pageTransition,
        curve: Curves.easeInOut,
      );
    } else {
      _save();
    }
  }

  void _back() {
    if (_step == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() => _step--);
      _pageController.animateToPage(
        _step,
        duration: AppDurations.pageTransition,
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _save() async {
    if (_peptides.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).createProtocolAddOneError),
        ),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final provider = context.read<ProtocolProvider>();
      if (_isEditing) {
        await provider.updateProtocol(
          protocol: widget.initialProtocol!,
          name: _nameController.text.trim(),
          startDate: _startDate,
          peptides: _peptides,
          notes: _notesController.text,
        );
      } else {
        await provider.createProtocol(
          name: _nameController.text.trim(),
          startDate: _startDate,
          peptides: _peptides,
          notes: _notesController.text,
        );
      }
      if (!mounted) return;
      await context.read<DoseLogProvider>().refresh();
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).createProtocolSaveError),
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  bool get _canAdvance {
    switch (_step) {
      case 0:
        return _nameController.text.trim().isNotEmpty;
      case 1:
        return _peptides.isNotEmpty;
      case 2:
        return true;
    }
    return false;
  }

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
                    onPressed: _back,
                    tooltip: l10n.back,
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
                          _isEditing
                              ? 'SYS.PROTOCOL // EDIT'
                              : 'SYS.PROTOCOL // NEW',
                          style: AppTypography.systemLabel,
                        ),
                        Text(
                          _isEditing
                              ? l10n.createProtocolEditStep(_step + 1, 3)
                              : l10n.createProtocolBuildStep(_step + 1, 3),
                          style: AppTypography.h3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Row(
                children: List.generate(3, (i) {
                  final active = i <= _step;
                  return Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.only(right: i < 2 ? 3 : 0),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : AppColors.border,
                        borderRadius: BorderRadius.circular(1),
                        boxShadow: i == _step
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.5,
                                  ),
                                  blurRadius: 4,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Pages
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _Step1Name(
                    controller: _nameController,
                    notesController: _notesController,
                    onChanged: (_) => setState(() {}),
                  ),
                  _Step2Peptides(
                    peptides: _peptides,
                    onAdd: _handleAddPeptide,
                    onRemove: (p) => setState(() => _peptides.remove(p)),
                    onEdit: (index, p) => setState(() => _peptides[index] = p),
                  ),
                  _Step3Review(
                    name: _nameController.text,
                    peptides: _peptides,
                    startDate: _startDate,
                    onPickDate: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: now.subtract(const Duration(days: 365 * 5)),
                        lastDate: now.add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() => _startDate = picked);
                      }
                    },
                  ),
                ],
              ),
            ),
            // Footer
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
              child: PrimaryButton(
                label: _step == 2
                    ? (_isEditing
                          ? l10n.saveChanges
                          : l10n.createProtocolAction)
                    : l10n.nextLabel,
                icon: _step == 2 ? Icons.check_rounded : null,
                isLoading: _saving,
                onPressed: _canAdvance ? _next : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step 1 — Name ──────────────────────────────────────────────────────────
class _Step1Name extends StatelessWidget {
  const _Step1Name({
    required this.controller,
    required this.notesController,
    required this.onChanged,
  });
  final TextEditingController controller;
  final TextEditingController notesController;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        0,
        AppSpacing.screenHorizontal,
        AppSpacing.base,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.createProtocolNameTitle, style: AppTypography.h2),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.createProtocolNameBody, style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.xl),
          Container(
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTypography.h3,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(AppSpacing.md),
                filled: false,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.protocolNotesLabel, style: AppTypography.h3),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.protocolNotesBody,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: notesController,
              minLines: 3,
              maxLines: 5,
              maxLength: 500,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: l10n.protocolNotesHint,
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(AppSpacing.md),
                filled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step 2 — Peptides ──────────────────────────────────────────────────────
class _Step2Peptides extends StatelessWidget {
  const _Step2Peptides({
    required this.peptides,
    required this.onAdd,
    required this.onRemove,
    required this.onEdit,
  });

  final List<ProtocolPeptide> peptides;
  final ValueChanged<ProtocolPeptide> onAdd;
  final ValueChanged<ProtocolPeptide> onRemove;
  final void Function(int index, ProtocolPeptide p) onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.createProtocolStackTitle, style: AppTypography.h2),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.createProtocolStackBody, style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: peptides.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.science_rounded,
                          color: AppColors.textTertiary,
                          size: 36,
                        ),
                        const SizedBox(height: AppSpacing.base),
                        Text(
                          l10n.createProtocolNoPeptides,
                          style: AppTypography.labelLarge,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.createProtocolPickHint,
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: peptides.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.cardGap),
                    itemBuilder: (context, index) {
                      final p = peptides[index];
                      return AppCard(
                        onTap: () async {
                          final updated = await _editPeptide(context, p);
                          if (updated != null) onEdit(index, updated);
                        },
                        child: Row(
                          children: [
                            PeptideLabelAvatar(hex: p.labelColorHex),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.peptideName,
                                    style: AppTypography.labelLarge,
                                  ),
                                  Text(
                                    _scheduleSummary(context, p),
                                    style: AppTypography.bodySmall.copyWith(
                                      fontFamily: 'JetBrainsMono',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => onRemove(p),
                              tooltip: l10n.removePeptide(p.peptideName),
                              icon: Icon(
                                Icons.close_rounded,
                                color: AppColors.textTertiary,
                                size: AppSpacing.iconMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              final picked = await _pickPeptide(
                context,
                defaultLabelColorHex: defaultPeptideLabelColorHex(
                  peptides.length,
                ),
              );
              if (picked != null) onAdd(picked);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.borderCyan),
              minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
              ),
            ),
            icon: const Icon(Icons.add_rounded),
            label: Text(
              l10n.addToStack,
              style: AppTypography.button.copyWith(color: AppColors.primary),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}

// ── Step 3 — Review ────────────────────────────────────────────────────────
class _Step3Review extends StatelessWidget {
  const _Step3Review({
    required this.name,
    required this.peptides,
    required this.startDate,
    required this.onPickDate,
  });

  final String name;
  final List<ProtocolPeptide> peptides;
  final DateTime startDate;
  final VoidCallback onPickDate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.reviewLabel, style: AppTypography.h2),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.createProtocolReviewBody, style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.nameLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.xs),
                Text(name, style: AppTypography.labelLarge),
                const SizedBox(height: AppSpacing.base),
                Text(l10n.startDateLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.xs),
                GestureDetector(
                  onTap: onPickDate,
                  child: Row(
                    children: [
                      Text(
                        _formatDate(context, startDate),
                        style: AppTypography.tabular.copyWith(fontSize: 16),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        Icons.edit_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.base),
                Text(
                  l10n.peptidesCount(peptides.length),
                  style: AppTypography.systemLabel,
                ),
                const SizedBox(height: AppSpacing.xs),
                ...peptides.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: peptideLabelColor(p.labelColorHex),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            '${p.peptideName} · ${_scheduleSummary(context, p)}',
                            style: AppTypography.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.base),
          Text(
            l10n.educationalTrackingDisclaimer,
            style: AppTypography.disclaimer,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Helpers shared across steps ────────────────────────────────────────────
String _formatDate(BuildContext context, DateTime d) =>
    DateFormat.yMMMd(AppLocalizations.of(context).localeName).format(d);

String _formatAmount(BuildContext context, double d) => NumberFormat(
  d == d.roundToDouble() ? '0' : '0.#',
  AppLocalizations.of(context).localeName,
).format(d);

String _formatStoredTime(BuildContext context, String value) {
  final parts = value.split(':');
  final hour = parts.isNotEmpty ? int.tryParse(parts.first) : null;
  final minute = parts.length > 1 ? int.tryParse(parts[1]) : null;
  if (hour == null || minute == null) return value;
  return TimeOfDay(hour: hour, minute: minute).format(context);
}

String _freqLabel(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context);
  return switch (key) {
    'daily' => l10n.frequencyDaily,
    'every_other_day' => l10n.frequencyEveryOtherDay,
    'twice_weekly' => l10n.frequencyTwiceWeekly,
    'weekly' => l10n.frequencyWeekly,
    'as_needed' => l10n.frequencyAsNeeded,
    kCustomWeekdayFrequency => l10n.customDays,
    _ => l10n.frequencyDaily,
  };
}

String _routeLabel(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context);
  return switch (key) {
    'subcutaneous' => l10n.routeSubcutaneous,
    'intramuscular' => l10n.routeIntramuscular,
    'oral' => l10n.routeOral,
    'nasal' => l10n.routeNasal,
    _ => key,
  };
}

String _weekdayLabel(BuildContext context, int weekday) {
  final locale = AppLocalizations.of(context).localeName;
  final monday = DateTime.utc(2024, 1, 1);
  final safeWeekday = weekday.clamp(DateTime.monday, DateTime.sunday);
  return DateFormat.E(
    locale,
  ).format(monday.add(Duration(days: safeWeekday - 1)));
}

String _scheduleSummary(BuildContext context, ProtocolPeptide p) {
  final l10n = AppLocalizations.of(context);
  final phaseSuffix = p.phases.isEmpty
      ? ''
      : ' · ${l10n.phasesCount(p.phases.length)}';
  if (p.isBlend) {
    return '${l10n.syringeUnitsAmount(_formatAmount(context, p.syringeUnits))} · '
        '${_freqLabel(context, p.frequency)} · '
        '${l10n.compoundsCount(p.blendVial!.constituents.length)}$phaseSuffix';
  }
  if (!p.usesCustomWeekdays) {
    return '${_formatAmount(context, p.dosePerInjection)} ${p.doseUnit} · '
        '${_freqLabel(context, p.frequency)}${_syringeSummary(context, p.syringeUnits)}'
        '$phaseSuffix';
  }
  final days = [...p.weekdayDoses]
    ..sort((a, b) => a.weekday.compareTo(b.weekday));
  final summary = days
      .map(
        (d) =>
            '${_weekdayLabel(context, d.weekday)} ${_formatAmount(context, d.dosePerInjection)} ${d.doseUnit}${_syringeSummary(context, d.syringeUnits)}',
      )
      .join(', ');
  return summary.isEmpty
      ? '${l10n.customDays}$phaseSuffix'
      : '$summary$phaseSuffix';
}

String _syringeSummary(BuildContext context, double value) {
  if (value <= 0) return '';
  return ' · ${AppLocalizations.of(context).syringeUnitsAmount(_formatAmount(context, value))}';
}

ProtocolPeptide _cloneProtocolPeptide(ProtocolPeptide p) {
  return ProtocolPeptide.fromMap(p.toMap());
}

/// Opens the peptide picker and returns a configured ProtocolPeptide.
Future<ProtocolPeptide?> _pickPeptide(
  BuildContext context, {
  required String defaultLabelColorHex,
}) async {
  final slug = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _PeptideLibraryPicker(),
  );
  if (slug == null) return null;
  if (!context.mounted) return null;

  final provider = context.read<ProtocolProvider>();
  final ProtocolPeptide draft;
  if (slug == _blendVialSlug) {
    draft = provider.buildPeptide(
      slug: _blendVialSlug,
      name: AppLocalizations.of(context).customBlend,
      dose: 10,
      unit: 'syringe units',
      frequency: 'as_needed',
      route: 'subcutaneous',
      syringeUnits: 10,
      labelColorHex: defaultLabelColorHex,
      blendVial: const BlendVial(
        constituents: [
          BlendConstituent(name: '', vialAmount: 0, unit: 'mg'),
          BlendConstituent(name: '', vialAmount: 0, unit: 'mg'),
        ],
        diluentMl: 2,
        drawSyringeUnits: 10,
      ),
    );
  } else if (slug.startsWith(_savedCompoundSlugPrefix)) {
    final id = slug.substring(_savedCompoundSlugPrefix.length);
    final compounds = context.read<CustomCompoundProvider>().all;
    final index = compounds.indexWhere((compound) => compound.id == id);
    if (index == -1) return null;
    final compound = compounds[index];
    draft = provider.buildPeptide(
      slug: slug,
      name: compound.name,
      dose: 0,
      unit: compound.trackingUnit,
      frequency: 'as_needed',
      route: compound.route,
      labelColorHex: defaultLabelColorHex,
      sourceCompoundId: compound.id,
      sourceCompoundUpdatedAt: compound.updatedAt,
      vialAmountSnapshot: compound.vialAmount,
      vialUnitSnapshot: compound.vialUnit,
      compoundNotesSnapshot: compound.notes,
    );
  } else if (slug == _customPeptideSlug) {
    draft = provider.buildPeptide(
      slug: _customPeptideSlug,
      name: AppLocalizations.of(context).customPeptide,
      dose: 0,
      frequency: 'as_needed',
      route: 'subcutaneous',
      labelColorHex: defaultLabelColorHex,
    );
  } else {
    final peptide = context.read<PeptideProvider>().findBySlug(slug);
    if (peptide == null) return null;
    draft = provider.buildPeptide(
      slug: peptide.slug,
      name: peptide.name,
      dose: peptide.defaultDoseMcg,
      unit: peptide.defaultDoseUnit,
      frequency: peptide.defaultFrequency,
      route: peptide.defaultRoute,
      cycleWeeks: peptide.typicalCycleWeeks,
      labelColorHex: defaultLabelColorHex,
    );
  }

  return showModalBottomSheet<ProtocolPeptide>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => draft.peptideSlug == _blendVialSlug
        ? BlendVialConfigSheet(initial: draft)
        : _PeptideConfigSheet(initial: draft),
  );
}

Future<ProtocolPeptide?> _editPeptide(
  BuildContext context,
  ProtocolPeptide p,
) async {
  return showModalBottomSheet<ProtocolPeptide>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => p.isBlend
        ? BlendVialConfigSheet(initial: p)
        : _PeptideConfigSheet(initial: p),
  );
}

// ── Picker sheet ────────────────────────────────────────────────────────────
class _PeptideLibraryPicker extends StatefulWidget {
  const _PeptideLibraryPicker();

  @override
  State<_PeptideLibraryPicker> createState() => _PeptideLibraryPickerState();
}

class _PeptideLibraryPickerState extends State<_PeptideLibraryPicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final peptides = context.watch<PeptideProvider>().search(
      query: _query,
      localizedTerms: (peptide) =>
          localizedPeptideContent(l10n, peptide).searchTerms(l10n, peptide),
    );
    final normalizedQuery = _query.trim().toLowerCase();
    final customCompounds = context
        .watch<CustomCompoundProvider>()
        .active
        .where(
          (compound) =>
              normalizedQuery.isEmpty ||
              compound.name.toLowerCase().contains(normalizedQuery),
        )
        .toList();
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.sheetRadius),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
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
                    borderRadius: BorderRadius.circular(
                      AppSpacing.sheetHandleHeight,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('PICK.COMPOUND', style: AppTypography.systemLabel),
              const SizedBox(height: AppSpacing.sm),
              Text(l10n.libraryTitle, style: AppTypography.h2),
              const SizedBox(height: AppSpacing.base),
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
                      color: AppColors.textTertiary,
                      size: AppSpacing.iconMedium,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _query = v),
                        style: AppTypography.bodyMedium,
                        decoration: InputDecoration(
                          hintText: l10n.searchCompounds,
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
              ),
              const SizedBox(height: AppSpacing.base),
              Expanded(
                child: ListView.separated(
                  itemCount: peptides.length + customCompounds.length + 2,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) {
                    if (i == 0) {
                      return AppCard(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          Navigator.of(context).pop(_blendVialSlug);
                        },
                        borderColor: AppColors.warning.withValues(alpha: 0.7),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.warning.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.science_rounded,
                                color: AppColors.warning,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.preBlendedVial,
                                    style: AppTypography.labelLarge,
                                  ),
                                  Text(
                                    l10n.preBlendedVialBody,
                                    style: AppTypography.bodySmall,
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
                    if (i == 1) {
                      return AppCard(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          Navigator.of(context).pop(_customPeptideSlug);
                        },
                        borderColor: AppColors.borderCyan,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.oneOffCompound,
                                    style: AppTypography.labelLarge,
                                  ),
                                  Text(
                                    l10n.oneOffCompoundBody,
                                    style: AppTypography.bodySmall,
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
                    final customIndex = i - 2;
                    if (customIndex < customCompounds.length) {
                      final compound = customCompounds[customIndex];
                      return AppCard(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          Navigator.of(
                            context,
                          ).pop('$_savedCompoundSlugPrefix${compound.id}');
                        },
                        borderColor: AppColors.borderCyan,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.inventory_2_outlined,
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
                                    style: AppTypography.labelLarge,
                                  ),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    ).savedVialPreset(
                                      _formatAmount(
                                        context,
                                        compound.vialAmount,
                                      ),
                                      compound.vialUnit,
                                    ),
                                    style: AppTypography.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textTertiary,
                              size: AppSpacing.iconMedium,
                            ),
                          ],
                        ),
                      );
                    }
                    final p = peptides[customIndex - customCompounds.length];
                    return AppCard(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.of(context).pop(p.slug);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.name, style: AppTypography.labelLarge),
                                Text(
                                  p.category.label,
                                  style: AppTypography.bodySmall,
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
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton.icon(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CustomCompoundLibraryScreen(),
                    ),
                  );
                  if (mounted) setState(() {});
                },
                icon: const Icon(Icons.tune_rounded, size: 18),
                label: Text(l10n.manageSavedCompounds),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Pre-blended vial config sheet ──────────────────────────────────────────
class BlendVialConfigSheet extends StatefulWidget {
  const BlendVialConfigSheet({super.key, required this.initial});

  final ProtocolPeptide initial;

  @override
  State<BlendVialConfigSheet> createState() => _BlendVialConfigSheetState();
}

class _BlendVialConfigSheetState extends State<BlendVialConfigSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _diluentCtrl;
  late final TextEditingController _drawCtrl;
  late final TextEditingController _cycleWeeksCtrl;
  late final TextEditingController _washoutWeeksCtrl;
  final List<_BlendConstituentControllers> _constituents = [];
  late String _frequency;
  late String _route;
  late String _labelColorHex;
  late List<String> _times;
  late Set<int> _selectedWeekdays;
  bool _initialNumbersLocalized = false;

  @override
  void initState() {
    super.initState();
    final blend = widget.initial.blendVial;
    _nameCtrl = TextEditingController(text: widget.initial.peptideName);
    _diluentCtrl = TextEditingController();
    _drawCtrl = TextEditingController();
    _cycleWeeksCtrl = TextEditingController();
    _washoutWeeksCtrl = TextEditingController();
    final source = blend?.constituents ?? const <BlendConstituent>[];
    if (source.length < 2) {
      _constituents
        ..add(_BlendConstituentControllers())
        ..add(_BlendConstituentControllers());
    }
    _frequency = widget.initial.frequency;
    _route = widget.initial.route;
    _labelColorHex = widget.initial.labelColorHex.isEmpty
        ? defaultPeptideLabelColorHex(0)
        : widget.initial.labelColorHex;
    _times = _normalizeTimes(widget.initial.scheduledTimes);
    _selectedWeekdays = widget.initial.weekdayDoses
        .map((dose) => dose.weekday)
        .toSet();
    if (_frequency == kCustomWeekdayFrequency && _selectedWeekdays.isEmpty) {
      _selectedWeekdays.add(DateTime.now().weekday);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialNumbersLocalized) return;
    final localeName = AppLocalizations.of(context).localeName;
    final blend = widget.initial.blendVial;
    _diluentCtrl.text = formatLocalizedDecimalInput(
      blend?.diluentMl ?? 2,
      localeName: localeName,
    );
    _drawCtrl.text = formatLocalizedDecimalInput(
      blend?.drawSyringeUnits ?? widget.initial.syringeUnits,
      localeName: localeName,
    );
    if (widget.initial.cycleWeeks > 0) {
      _cycleWeeksCtrl.text = formatLocalizedDecimalInput(
        widget.initial.cycleWeeks.toDouble(),
        localeName: localeName,
        maximumFractionDigits: 0,
      );
    }
    if (widget.initial.washoutWeeks > 0) {
      _washoutWeeksCtrl.text = formatLocalizedDecimalInput(
        widget.initial.washoutWeeks.toDouble(),
        localeName: localeName,
        maximumFractionDigits: 0,
      );
    }
    final source = blend?.constituents ?? const <BlendConstituent>[];
    if (source.length >= 2) {
      _constituents.addAll(
        source.map(
          (constituent) => _BlendConstituentControllers.fromConstituent(
            constituent,
            localeName: localeName,
          ),
        ),
      );
    }
    _initialNumbersLocalized = true;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _diluentCtrl.dispose();
    _drawCtrl.dispose();
    _cycleWeeksCtrl.dispose();
    _washoutWeeksCtrl.dispose();
    for (final constituent in _constituents) {
      constituent.dispose();
    }
    super.dispose();
  }

  double get _diluentMl => parseDecimalInput(_diluentCtrl.text) ?? 0;
  double get _drawUnits => parseDecimalInput(_drawCtrl.text) ?? 0;

  BlendVial get _blend => BlendVial(
    constituents: _constituents
        .map((controllers) => controllers.toConstituent())
        .toList(),
    diluentMl: _diluentMl,
    drawSyringeUnits: _drawUnits,
  );

  bool get _canSave =>
      _nameCtrl.text.trim().isNotEmpty &&
      _blend.isValid &&
      _times.isNotEmpty &&
      (_frequency != kCustomWeekdayFrequency || _selectedWeekdays.isNotEmpty);

  void _addConstituent() {
    HapticFeedback.selectionClick();
    setState(() => _constituents.add(_BlendConstituentControllers()));
  }

  void _removeConstituent(int index) {
    if (_constituents.length <= 2) return;
    HapticFeedback.selectionClick();
    final removed = _constituents.removeAt(index);
    removed.dispose();
    setState(() {});
  }

  void _toggleWeekday(int weekday) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_selectedWeekdays.contains(weekday)) {
        _selectedWeekdays.remove(weekday);
      } else {
        _selectedWeekdays.add(weekday);
      }
    });
  }

  Future<void> _addTime() async {
    final picked = await _pickTime(_times.isEmpty ? '08:00' : _times.last);
    if (picked == null) return;
    setState(() => _times = _normalizeTimes([..._times, picked]));
  }

  Future<void> _editTime(String current) async {
    final picked = await _pickTime(current);
    if (picked == null) return;
    setState(() {
      _times = _normalizeTimes([
        for (final value in _times)
          if (value == current) picked else value,
      ]);
    });
  }

  Future<String?> _pickTime(String value) async {
    final parts = value.split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 8,
        minute: int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0,
      ),
    );
    if (picked == null) return null;
    return '${picked.hour.toString().padLeft(2, '0')}:'
        '${picked.minute.toString().padLeft(2, '0')}';
  }

  List<String> _normalizeTimes(List<String> values) {
    final result = <String>{};
    for (final value in values) {
      final parts = value.split(':');
      if (parts.length != 2) continue;
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);
      if (hour == null || minute == null) continue;
      if (hour < 0 || hour > 23 || minute < 0 || minute > 59) continue;
      result.add(
        '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}',
      );
    }
    return result.isEmpty ? <String>['08:00'] : (result.toList()..sort());
  }

  void _save() {
    final blend = _blend;
    if (!blend.isValid) return;
    final updated = ProtocolPeptide.fromMap(widget.initial.toMap())
      ..peptideSlug = _blendVialSlug
      ..peptideName = _nameCtrl.text.trim()
      ..dosePerInjection = _drawUnits
      ..doseUnit = 'syringe units'
      ..frequency = _frequency
      ..route = _route
      ..cycleWeeks = (int.tryParse(_cycleWeeksCtrl.text) ?? 0)
          .clamp(0, 104)
          .toInt()
      ..washoutWeeks = (int.tryParse(_washoutWeeksCtrl.text) ?? 0)
          .clamp(0, 52)
          .toInt()
      ..syringeUnits = _drawUnits
      ..labelColorHex = _labelColorHex
      ..scheduledTimes = _times
      ..weekdayDoses = _frequency == kCustomWeekdayFrequency
          ? [
              for (final weekday in (_selectedWeekdays.toList()..sort()))
                ProtocolWeekdayDose(
                  weekday: weekday,
                  dosePerInjection: _drawUnits,
                  doseUnit: 'syringe units',
                  syringeUnits: _drawUnits,
                  scheduledTimes: _times,
                ),
            ]
          : <ProtocolWeekdayDose>[]
      ..blendVial = blend;
    Navigator.of(context).pop(updated);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final blend = _blend;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.92,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.sheetRadius),
          ),
          border: Border.all(color: AppColors.border),
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
                      borderRadius: BorderRadius.circular(
                        AppSpacing.sheetHandleHeight,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('CONFIG.BLEND', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.preBlendedVial, style: AppTypography.h2),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.blendConfigBody, style: AppTypography.bodySmall),
                const SizedBox(height: AppSpacing.lg),
                _FieldLabel(
                  label: l10n.blendNameLabel,
                  child: TextField(
                    controller: _nameCtrl,
                    onChanged: (_) => setState(() {}),
                    textCapitalization: TextCapitalization.words,
                    style: AppTypography.bodyLarge,
                    decoration: InputDecoration(
                      hintText: l10n.blendNameHint,
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Text(
                      l10n.vialContentsLabel,
                      style: AppTypography.systemLabel,
                    ),
                    const Spacer(),
                    Text(
                      l10n.compoundsCount(_constituents.length),
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                for (var index = 0; index < _constituents.length; index++) ...[
                  _BlendConstituentEditor(
                    index: index,
                    controllers: _constituents[index],
                    canRemove: _constituents.length > 2,
                    onChanged: () => setState(() {}),
                    onRemove: () => _removeConstituent(index),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                OutlinedButton(
                  onPressed: _addConstituent,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.borderCyan),
                    minimumSize: const Size.fromHeight(44),
                  ),
                  child: Text(
                    l10n.addCompound,
                    style: AppTypography.button.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: _FieldLabel(
                        label: l10n.diluentVolumeLabel,
                        child: TextField(
                          controller: _diluentCtrl,
                          onChanged: (_) => setState(() {}),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: const [decimalInputFormatter],
                          style: AppTypography.tabular.copyWith(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: '2',
                            suffixText: 'mL',
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
                      child: _FieldLabel(
                        label: l10n.drawLabel,
                        child: TextField(
                          controller: _drawCtrl,
                          onChanged: (_) => setState(() {}),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: const [decimalInputFormatter],
                          style: AppTypography.tabular.copyWith(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: '10',
                            suffixText: l10n.units,
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
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.u100TrackingDisclaimer,
                  style: AppTypography.disclaimer,
                ),
                const SizedBox(height: AppSpacing.base),
                _BlendPreview(blend: blend),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.scheduleLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final option in kFrequencies)
                      _Chip(
                        label: _freqLabel(context, option.key),
                        selected: _frequency == option.key,
                        onTap: () => setState(() {
                          _frequency = option.key;
                          if (_frequency == kCustomWeekdayFrequency &&
                              _selectedWeekdays.isEmpty) {
                            _selectedWeekdays.add(DateTime.now().weekday);
                          }
                        }),
                      ),
                  ],
                ),
                if (_frequency == kCustomWeekdayFrequency) ...[
                  const SizedBox(height: AppSpacing.base),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (
                        var weekday = DateTime.monday;
                        weekday <= DateTime.sunday;
                        weekday++
                      )
                        _Chip(
                          label: _weekdayLabel(context, weekday),
                          selected: _selectedWeekdays.contains(weekday),
                          onTap: () => _toggleWeekday(weekday),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.base),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final time in _times)
                      _TimeChip(
                        label: _formatStoredTime(context, time),
                        canRemove: _times.length > 1,
                        onTap: () => _editTime(time),
                        onRemove: () => setState(() {
                          if (_times.length > 1) _times.remove(time);
                        }),
                      ),
                    _Chip(
                      label: l10n.addTime,
                      selected: false,
                      onTap: _addTime,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.routeLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final option in kRoutes)
                      _Chip(
                        label: _routeLabel(context, option.key),
                        selected: _route == option.key,
                        onTap: () => setState(() => _route = option.key),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: _FieldLabel(
                        label: l10n.cycleWeeksLabel,
                        child: TextField(
                          controller: _cycleWeeksCtrl,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: AppTypography.tabular.copyWith(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: l10n.noneLabel,
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
                      child: _FieldLabel(
                        label: l10n.restWeeksLabel,
                        child: TextField(
                          controller: _washoutWeeksCtrl,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: AppTypography.tabular.copyWith(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: l10n.noneLabel,
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
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.labelColorLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final hex in kPeptideLabelColorHexes)
                      _ColorChip(
                        hex: hex,
                        selected: _labelColorHex == hex,
                        onTap: () => setState(() => _labelColorHex = hex),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.base),
                Text(
                  l10n.blendSafetyDisclaimer,
                  style: AppTypography.disclaimer.copyWith(
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: l10n.saveBlend,
                  onPressed: _canSave ? _save : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      l10n.cancelLabel,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BlendConstituentControllers {
  _BlendConstituentControllers({
    String name = '',
    String amount = '',
    this.unit = 'mg',
  }) : name = TextEditingController(text: name),
       amount = TextEditingController(text: amount);

  factory _BlendConstituentControllers.fromConstituent(
    BlendConstituent constituent, {
    required String localeName,
  }) {
    return _BlendConstituentControllers(
      name: constituent.name,
      amount: formatLocalizedDecimalInput(
        constituent.vialAmount,
        localeName: localeName,
      ),
      unit: constituent.unit,
    );
  }

  final TextEditingController name;
  final TextEditingController amount;
  String unit;

  BlendConstituent toConstituent() => BlendConstituent(
    name: name.text.trim(),
    vialAmount: parseDecimalInput(amount.text) ?? 0,
    unit: unit,
  );

  void dispose() {
    name.dispose();
    amount.dispose();
  }
}

class _BlendConstituentEditor extends StatelessWidget {
  const _BlendConstituentEditor({
    required this.index,
    required this.controllers,
    required this.canRemove,
    required this.onChanged,
    required this.onRemove,
  });

  final int index;
  final _BlendConstituentControllers controllers;
  final bool canRemove;
  final VoidCallback onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                l10n.compoundNumber(index + 1),
                style: AppTypography.systemLabel,
              ),
              const Spacer(),
              if (canRemove)
                TextButton(
                  onPressed: onRemove,
                  child: Text(
                    l10n.removeLabel,
                    style: AppTypography.systemLabel.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 9,
                    ),
                  ),
                ),
            ],
          ),
          TextField(
            controller: controllers.name,
            onChanged: (_) => onChanged(),
            textCapitalization: TextCapitalization.words,
            style: AppTypography.bodyLarge,
            decoration: InputDecoration(
              hintText: l10n.vialLabelNameHint,
              border: InputBorder.none,
              filled: false,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controllers.amount,
                  onChanged: (_) => onChanged(),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: const [decimalInputFormatter],
                  style: AppTypography.tabular.copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: l10n.vialAmountHint,
                    border: InputBorder.none,
                    filled: false,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: 92,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controllers.unit,
                    isExpanded: true,
                    icon: Text(
                      'v',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    dropdownColor: AppColors.surfaceContainer,
                    style: AppTypography.labelMedium,
                    items: const [
                      DropdownMenuItem(value: 'mcg', child: Text('mcg')),
                      DropdownMenuItem(value: 'mg', child: Text('mg')),
                      DropdownMenuItem(value: 'IU', child: Text('IU')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      controllers.unit = value;
                      onChanged();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BlendPreview extends StatelessWidget {
  const _BlendPreview({required this.blend});

  final BlendVial blend;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String amount(double value) => NumberFormat(
      value >= 100
          ? '0'
          : value >= 10
          ? '0.#'
          : '0.##',
      l10n.localeName,
    ).format(value);
    return AppCard(
      borderColor: blend.isValid ? AppColors.borderCyan : AppColors.border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.drawPreviewLabel, style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.sm),
          if (!blend.isValid)
            Text(
              blend.drawVolumeMl > blend.diluentMl && blend.diluentMl > 0
                  ? l10n.drawExceedsVialError
                  : l10n.blendIncompleteError,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            )
          else ...[
            Text(
              l10n.drawPreviewValue(
                amount(blend.drawSyringeUnits),
                amount(blend.drawVolumeMl),
              ),
              style: AppTypography.tabular.copyWith(
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            for (final constituent in blend.constituents)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        constituent.name,
                        style: AppTypography.bodyMedium,
                      ),
                    ),
                    Text(
                      '${amount(blend.amountPerDraw(constituent))} '
                      '${constituent.unit}',
                      style: AppTypography.tabular.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

// ── Peptide config sheet ────────────────────────────────────────────────────
class _PeptideConfigSheet extends StatefulWidget {
  const _PeptideConfigSheet({required this.initial});
  final ProtocolPeptide initial;

  @override
  State<_PeptideConfigSheet> createState() => _PeptideConfigSheetState();
}

class _PeptideConfigSheetState extends State<_PeptideConfigSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _doseCtrl;
  late final TextEditingController _syringeUnitsCtrl;
  late final TextEditingController _cycleWeeksCtrl;
  late final TextEditingController _washoutWeeksCtrl;
  final Map<int, TextEditingController> _weekdayDoseCtrls = {};
  late String _unit;
  late String _frequency;
  late String _route;
  late String _labelColorHex;
  late List<String> _times;
  late Set<int> _selectedWeekdays;
  late List<ProtocolPhase> _phases;
  bool _initialNumbersLocalized = false;
  bool get _isCustomPeptide =>
      widget.initial.peptideSlug == _customPeptideSlug ||
      widget.initial.peptideSlug.startsWith(_savedCompoundSlugPrefix);

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initial.peptideName);
    _doseCtrl = TextEditingController();
    _syringeUnitsCtrl = TextEditingController();
    _cycleWeeksCtrl = TextEditingController();
    _washoutWeeksCtrl = TextEditingController();
    _unit = widget.initial.doseUnit;
    _frequency = widget.initial.frequency;
    _route = widget.initial.route;
    _labelColorHex = widget.initial.labelColorHex.isNotEmpty
        ? widget.initial.labelColorHex
        : defaultPeptideLabelColorHex(0);
    _times = _normalizeTimes(
      widget.initial.scheduledTimes.isEmpty
          ? _firstWeekdayTimes(widget.initial.weekdayDoses)
          : widget.initial.scheduledTimes,
    );
    _selectedWeekdays = widget.initial.weekdayDoses
        .map((d) => d.weekday)
        .toSet();
    if (_frequency == kCustomWeekdayFrequency && _selectedWeekdays.isEmpty) {
      _selectedWeekdays = {DateTime.now().weekday};
    }
    _phases =
        widget.initial.phases
            .map((phase) => ProtocolPhase.fromMap(phase.toMap()))
            .toList()
          ..sort((a, b) => a.startWeek.compareTo(b.startWeek));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialNumbersLocalized) return;
    final localeName = AppLocalizations.of(context).localeName;
    _doseCtrl.text = formatLocalizedDecimalInput(
      widget.initial.dosePerInjection,
      localeName: localeName,
      maximumFractionDigits: 1,
    );
    if (widget.initial.syringeUnits > 0) {
      _syringeUnitsCtrl.text = formatLocalizedDecimalInput(
        widget.initial.syringeUnits,
        localeName: localeName,
        maximumFractionDigits: 1,
      );
    }
    if (widget.initial.cycleWeeks > 0) {
      _cycleWeeksCtrl.text = formatLocalizedDecimalInput(
        widget.initial.cycleWeeks.toDouble(),
        localeName: localeName,
        maximumFractionDigits: 0,
      );
    }
    if (widget.initial.washoutWeeks > 0) {
      _washoutWeeksCtrl.text = formatLocalizedDecimalInput(
        widget.initial.washoutWeeks.toDouble(),
        localeName: localeName,
        maximumFractionDigits: 0,
      );
    }
    for (final weekday in _selectedWeekdays) {
      _ensureWeekdayController(weekday);
    }
    _initialNumbersLocalized = true;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _doseCtrl.dispose();
    _syringeUnitsCtrl.dispose();
    _cycleWeeksCtrl.dispose();
    _washoutWeeksCtrl.dispose();
    for (final controller in _weekdayDoseCtrls.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _ensureWeekdayController(int weekday) {
    if (_weekdayDoseCtrls.containsKey(weekday)) return;
    ProtocolWeekdayDose? existing;
    for (final dose in widget.initial.weekdayDoses) {
      if (dose.weekday == weekday) {
        existing = dose;
        break;
      }
    }
    _weekdayDoseCtrls[weekday] = TextEditingController(
      text: formatLocalizedDecimalInput(
        existing?.dosePerInjection ?? _parsedBaseDose,
        localeName: AppLocalizations.of(context).localeName,
        maximumFractionDigits: 1,
      ),
    );
  }

  double get _parsedBaseDose =>
      parseDecimalInput(_doseCtrl.text) ?? widget.initial.dosePerInjection;

  double get _parsedSyringeUnits =>
      parseDecimalInput(_syringeUnitsCtrl.text) ?? 0;

  int get _parsedCycleWeeks => int.tryParse(_cycleWeeksCtrl.text) ?? 0;

  int get _parsedWashoutWeeks => int.tryParse(_washoutWeeksCtrl.text) ?? 0;

  List<String> _firstWeekdayTimes(List<ProtocolWeekdayDose> doses) {
    if (doses.isEmpty) return const <String>['08:00'];
    return doses.first.scheduledTimes;
  }

  List<String> _normalizeTimes(List<String> times) {
    final normalized = <String>{};
    for (final time in times) {
      final parts = time.split(':');
      if (parts.length != 2) continue;
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);
      if (hour == null || minute == null) continue;
      if (hour < 0 || hour > 23 || minute < 0 || minute > 59) continue;
      normalized.add(
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
      );
    }
    return normalized.isEmpty ? <String>['08:00'] : normalized.toList()
      ..sort();
  }

  void _selectFrequency(String frequency) {
    setState(() {
      _frequency = frequency;
      if (_frequency == kCustomWeekdayFrequency && _selectedWeekdays.isEmpty) {
        _selectedWeekdays.add(DateTime.now().weekday);
        _ensureWeekdayController(DateTime.now().weekday);
      }
    });
  }

  void _toggleWeekday(int weekday) {
    setState(() {
      if (_selectedWeekdays.contains(weekday)) {
        _selectedWeekdays.remove(weekday);
      } else {
        _selectedWeekdays.add(weekday);
        _ensureWeekdayController(weekday);
      }
    });
  }

  Future<void> _addTime() async {
    final picked = await _pickTimeOfDay(_times.isEmpty ? '08:00' : _times.last);
    if (picked == null) return;
    setState(() => _times = _normalizeTimes([..._times, picked]));
  }

  Future<void> _editTime(String current) async {
    final picked = await _pickTimeOfDay(current);
    if (picked == null) return;
    setState(() {
      _times = _normalizeTimes([
        for (final t in _times)
          if (t == current) picked else t,
      ]);
    });
  }

  void _removeTime(String time) {
    if (_times.length == 1) return;
    setState(() => _times = _times.where((t) => t != time).toList());
  }

  Future<void> _editPhase([int? index]) async {
    final previous = index == null ? null : _phases[index];
    final nextWeek = _phases.isEmpty ? 1 : _phases.last.endWeek + 1;
    final draft =
        previous ??
        ProtocolPhase(
          uuid: const Uuid().v4(),
          name: AppLocalizations.of(context).phaseNumber(_phases.length + 1),
          startWeek: nextWeek,
          endWeek: nextWeek,
          dosePerInjection: _parsedBaseDose,
          doseUnit: _unit,
          syringeUnits: _parsedSyringeUnits,
          frequency: _frequency,
          scheduledTimes: _times,
        );
    final result = await showModalBottomSheet<ProtocolPhase>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _PhaseConfigSheet(
        initial: ProtocolPhase.fromMap(draft.toMap()),
        fallbackDose: _parsedBaseDose,
        fallbackUnit: _unit,
        fallbackFrequency: _frequency,
        fallbackTimes: _times,
      ),
    );
    if (result == null || !mounted) return;
    if (_parsedCycleWeeks > 0 && result.endWeek > _parsedCycleWeeks) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(
              context,
            ).phaseOutsideCycleError(_parsedCycleWeeks),
          ),
        ),
      );
      return;
    }
    final overlaps = _phases.asMap().entries.any(
      (entry) =>
          entry.key != index &&
          result.startWeek <= entry.value.endWeek &&
          result.endWeek >= entry.value.startWeek,
    );
    if (overlaps) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).phaseOverlapError)),
      );
      return;
    }
    setState(() {
      if (index == null) {
        _phases.add(result);
      } else {
        _phases[index] = result;
      }
      _phases.sort((a, b) => a.startWeek.compareTo(b.startWeek));
    });
  }

  Future<String?> _pickTimeOfDay(String current) async {
    final parts = current.split(':');
    final initial = TimeOfDay(
      hour: int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 8,
      minute: int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0,
    );
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return null;
    return '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
  }

  List<ProtocolWeekdayDose> _buildWeekdayDoses(double fallbackDose) {
    final weekdays = _selectedWeekdays.toList()..sort();
    return [
      for (final weekday in weekdays)
        ProtocolWeekdayDose(
          weekday: weekday,
          dosePerInjection:
              parseDecimalInput(_weekdayDoseCtrls[weekday]?.text ?? '') ??
              fallbackDose,
          doseUnit: _unit,
          syringeUnits: _parsedSyringeUnits > 0 ? _parsedSyringeUnits : 0,
          scheduledTimes: _times,
        ),
    ];
  }

  bool get _canSave {
    if (_isCustomPeptide && _nameCtrl.text.trim().isEmpty) return false;
    if (_parsedBaseDose <= 0) return false;
    if (_frequency == kCustomWeekdayFrequency && _selectedWeekdays.isEmpty) {
      return false;
    }
    if (_parsedCycleWeeks > 0 &&
        _phases.any((phase) => phase.endWeek > _parsedCycleWeeks)) {
      return false;
    }
    return _times.isNotEmpty;
  }

  void _save() {
    final dose = _parsedBaseDose;
    final weekdayDoses = _frequency == kCustomWeekdayFrequency
        ? _buildWeekdayDoses(dose)
        : <ProtocolWeekdayDose>[];
    final updated = widget.initial
      ..peptideName = _isCustomPeptide
          ? _nameCtrl.text.trim()
          : widget.initial.peptideName
      ..dosePerInjection = dose
      ..doseUnit = _unit
      ..frequency = _frequency
      ..route = _route
      ..cycleWeeks = _parsedCycleWeeks.clamp(0, 104).toInt()
      ..washoutWeeks = _parsedWashoutWeeks.clamp(0, 52).toInt()
      ..syringeUnits = _parsedSyringeUnits > 0 ? _parsedSyringeUnits : 0
      ..labelColorHex = _labelColorHex
      ..scheduledTimes = _times
      ..weekdayDoses = weekdayDoses
      ..phases = _phases;
    Navigator.of(context).pop(updated);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.sheetRadius),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: AppSpacing.sheetHandleWidth,
                      height: AppSpacing.sheetHandleHeight,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.sheetHandleHeight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('CONFIG.PEPTIDE', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _isCustomPeptide
                        ? _nameCtrl.text.trim().isEmpty
                              ? l10n.customPeptide
                              : _nameCtrl.text.trim()
                        : widget.initial.peptideName,
                    style: AppTypography.h2,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  if (widget.initial.sourceCompoundId.isNotEmpty) ...[
                    AppCard(
                      borderColor: AppColors.borderCyan,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.inventory_2_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              l10n.copiedVialPreset(
                                _formatAmount(
                                  context,
                                  widget.initial.vialAmountSnapshot,
                                ),
                                widget.initial.vialUnitSnapshot,
                              ),
                              style: AppTypography.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],

                  if (_isCustomPeptide) ...[
                    _FieldLabel(
                      label: l10n.nameLabel,
                      child: TextField(
                        controller: _nameCtrl,
                        onChanged: (_) => setState(() {}),
                        textCapitalization: TextCapitalization.words,
                        style: AppTypography.bodyLarge,
                        decoration: InputDecoration(
                          hintText: l10n.enterPeptideName,
                          hintStyle: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textDisabled,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],

                  Text(l10n.labelColorLabel, style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final hex in kPeptideLabelColorHexes)
                        _ColorChip(
                          hex: hex,
                          selected: _labelColorHex == hex,
                          onTap: () => setState(() => _labelColorHex = hex),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(l10n.labelColorBody, style: AppTypography.disclaimer),
                  const SizedBox(height: AppSpacing.lg),

                  // Dose + unit
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _FieldLabel(
                          label: l10n.doseLabel,
                          child: TextField(
                            controller: _doseCtrl,
                            onChanged: (_) => setState(() {}),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: const [decimalInputFormatter],
                            style: AppTypography.heroSmall.copyWith(
                              fontSize: 18,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              filled: false,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.cardGap),
                      Expanded(
                        child: _FieldLabel(
                          label: l10n.unitLabel,
                          child: _SegmentedToggle(
                            options: const ['mcg', 'mg', 'IU'],
                            selected: _unit,
                            onSelect: (v) => setState(() => _unit = v),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.base),
                  _FieldLabel(
                    label: l10n.syringeUnitsOptional,
                    child: TextField(
                      controller: _syringeUnitsCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: const [decimalInputFormatter],
                      style: AppTypography.tabular.copyWith(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: l10n.syringeUnitsHint,
                        hintStyle: AppTypography.bodySmall.copyWith(
                          color: AppColors.textDisabled,
                        ),
                        suffixText: l10n.syringeUnitsLabel,
                        suffixStyle: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        filled: false,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.syringeUnitsDisclaimer,
                    style: AppTypography.disclaimer,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Frequency
                  Text(l10n.frequencyLabel, style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final f in kFrequencies)
                        _Chip(
                          label: _freqLabel(context, f.key),
                          selected: _frequency == f.key,
                          onTap: () => _selectFrequency(f.key),
                        ),
                    ],
                  ),
                  if (_frequency == kCustomWeekdayFrequency) ...[
                    const SizedBox(height: AppSpacing.base),
                    Text(
                      l10n.customDays.toUpperCase(),
                      style: AppTypography.systemLabel,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (
                          var weekday = DateTime.monday;
                          weekday <= DateTime.sunday;
                          weekday++
                        )
                          _Chip(
                            label: _weekdayLabel(context, weekday),
                            selected: _selectedWeekdays.contains(weekday),
                            onTap: () => _toggleWeekday(weekday),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.base),
                    if (_selectedWeekdays.isEmpty)
                      Text(
                        l10n.selectDayError,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.warning,
                        ),
                      )
                    else
                      Column(
                        children: [
                          for (final weekday
                              in (_selectedWeekdays.toList()..sort()))
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: _FieldLabel(
                                label: AppLocalizations.of(
                                  context,
                                ).weekdayDose(_weekdayLabel(context, weekday)),
                                child: TextField(
                                  controller: _weekdayDoseCtrls[weekday],
                                  onChanged: (_) => setState(() {}),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  inputFormatters: const [
                                    decimalInputFormatter,
                                  ],
                                  style: AppTypography.tabular.copyWith(
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    suffixText: _unit,
                                    suffixStyle: AppTypography.bodySmall
                                        .copyWith(
                                          color: AppColors.textTertiary,
                                        ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    filled: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.md,
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.customDaysDisclaimer,
                      style: AppTypography.disclaimer,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),

                  // Route
                  Text(l10n.routeLabel, style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final r in kRoutes)
                        _Chip(
                          label: _routeLabel(context, r.key),
                          selected: _route == r.key,
                          onTap: () => setState(() => _route = r.key),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Cycle + rest windows
                  Row(
                    children: [
                      Expanded(
                        child: _FieldLabel(
                          label: l10n.cycleWeeksLabel,
                          child: TextField(
                            controller: _cycleWeeksCtrl,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: AppTypography.tabular.copyWith(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: l10n.noneLabel,
                              border: InputBorder.none,
                              isDense: true,
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
                        child: _FieldLabel(
                          label: l10n.restWeeksLabel,
                          child: TextField(
                            controller: _washoutWeeksCtrl,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: AppTypography.tabular.copyWith(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: l10n.noneLabel,
                              border: InputBorder.none,
                              isDense: true,
                              filled: false,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.cycleWindowDisclaimer,
                    style: AppTypography.disclaimer,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  Text(l10n.weekToWeekPhases, style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Text(l10n.phasesBody, style: AppTypography.bodySmall),
                  if (_phases.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.base),
                    for (var index = 0; index < _phases.length; index++) ...[
                      _PhaseSummaryCard(
                        phase: _phases[index],
                        onEdit: () => _editPhase(index),
                        onDelete: () => setState(() => _phases.removeAt(index)),
                      ),
                      if (index < _phases.length - 1)
                        const SizedBox(height: AppSpacing.sm),
                    ],
                  ],
                  if (_parsedCycleWeeks > 0 &&
                      _phases.any(
                        (phase) => phase.endWeek > _parsedCycleWeeks,
                      )) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.phaseExtendsWarning(_parsedCycleWeeks),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  OutlinedButton.icon(
                    onPressed: _editPhase,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.borderCyan),
                      minimumSize: const Size.fromHeight(44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.buttonRadius,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: Text(
                      l10n.addPhase,
                      style: AppTypography.button.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(l10n.phasesDisclaimer, style: AppTypography.disclaimer),
                  const SizedBox(height: AppSpacing.lg),

                  // Reminder times
                  Text(
                    l10n.reminderTimesLabel,
                    style: AppTypography.systemLabel,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final time in _times)
                        _TimeChip(
                          label: _formatStoredTime(context, time),
                          canRemove: _times.length > 1,
                          onTap: () => _editTime(time),
                          onRemove: () => _removeTime(time),
                        ),
                      _Chip(
                        label: l10n.addTime,
                        selected: false,
                        onTap: _addTime,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(l10n.reminderTimesBody, style: AppTypography.disclaimer),
                  const SizedBox(height: AppSpacing.xl),

                  PrimaryButton(
                    label: l10n.saveLabel,
                    onPressed: _canSave ? _save : null,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      l10n.cancelLabel,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhaseSummaryCard extends StatelessWidget {
  const _PhaseSummaryCard({
    required this.phase,
    required this.onEdit,
    required this.onDelete,
  });

  final ProtocolPhase phase;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final weeks = phase.startWeek == phase.endWeek
        ? l10n.weekNumber(phase.startWeek)
        : l10n.weekRange(phase.startWeek, phase.endWeek);
    final amount =
        phase.frequency == kCustomWeekdayFrequency &&
            phase.weekdayDoses.isNotEmpty
        ? l10n.perDayAmounts
        : phase.dosePerInjection == null
        ? l10n.baseAmount
        : '${_formatAmount(context, phase.dosePerInjection!)} ${phase.doseUnit ?? ''}';
    final frequency = phase.frequency == null
        ? l10n.baseSchedule
        : _freqLabel(context, phase.frequency!);
    return AppCard(
      onTap: onEdit,
      borderColor: AppColors.borderCyan,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weeks, style: AppTypography.systemLabel),
                const SizedBox(height: 2),
                Text(phase.name, style: AppTypography.labelLarge),
                Text('$amount · $frequency', style: AppTypography.bodySmall),
                if (phase.note.trim().isNotEmpty)
                  Text(
                    phase.note.trim(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.disclaimer,
                  ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.removePhase,
            onPressed: onDelete,
            icon: const Icon(
              Icons.close_rounded,
              size: 18,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseConfigSheet extends StatefulWidget {
  const _PhaseConfigSheet({
    required this.initial,
    required this.fallbackDose,
    required this.fallbackUnit,
    required this.fallbackFrequency,
    required this.fallbackTimes,
  });

  final ProtocolPhase initial;
  final double fallbackDose;
  final String fallbackUnit;
  final String fallbackFrequency;
  final List<String> fallbackTimes;

  @override
  State<_PhaseConfigSheet> createState() => _PhaseConfigSheetState();
}

class _PhaseConfigSheetState extends State<_PhaseConfigSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _startWeekCtrl;
  late final TextEditingController _endWeekCtrl;
  late final TextEditingController _doseCtrl;
  late final TextEditingController _syringeCtrl;
  late final TextEditingController _noteCtrl;
  late String _unit;
  late String _frequency;
  late List<String> _times;
  late Set<int> _selectedWeekdays;
  final Map<int, TextEditingController> _weekdayDoseCtrls = {};
  final Map<int, List<String>> _weekdayTimes = {};
  bool _initialNumbersLocalized = false;

  @override
  void initState() {
    super.initState();
    final phase = widget.initial;
    _nameCtrl = TextEditingController(text: phase.name);
    _startWeekCtrl = TextEditingController();
    _endWeekCtrl = TextEditingController();
    _doseCtrl = TextEditingController();
    _syringeCtrl = TextEditingController();
    _noteCtrl = TextEditingController(text: phase.note);
    _unit = phase.doseUnit ?? widget.fallbackUnit;
    _frequency = phase.frequency ?? widget.fallbackFrequency;
    _times = _normalizePhaseTimes(
      phase.scheduledTimes.isEmpty
          ? widget.fallbackTimes
          : phase.scheduledTimes,
    );
    _selectedWeekdays = phase.weekdayDoses.map((dose) => dose.weekday).toSet();
    for (final dose in phase.weekdayDoses) {
      _weekdayTimes[dose.weekday] = _normalizePhaseTimes(dose.scheduledTimes);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialNumbersLocalized) return;
    final localeName = AppLocalizations.of(context).localeName;
    final phase = widget.initial;
    _startWeekCtrl.text = formatLocalizedDecimalInput(
      phase.startWeek.toDouble(),
      localeName: localeName,
      maximumFractionDigits: 0,
    );
    _endWeekCtrl.text = formatLocalizedDecimalInput(
      phase.endWeek.toDouble(),
      localeName: localeName,
      maximumFractionDigits: 0,
    );
    _doseCtrl.text = formatLocalizedDecimalInput(
      phase.dosePerInjection ?? widget.fallbackDose,
      localeName: localeName,
      maximumFractionDigits: 1,
    );
    if ((phase.syringeUnits ?? 0) > 0) {
      _syringeCtrl.text = formatLocalizedDecimalInput(
        phase.syringeUnits!,
        localeName: localeName,
        maximumFractionDigits: 1,
      );
    }
    for (final dose in phase.weekdayDoses) {
      _weekdayDoseCtrls[dose.weekday] = TextEditingController(
        text: formatLocalizedDecimalInput(
          dose.dosePerInjection,
          localeName: localeName,
          maximumFractionDigits: 1,
        ),
      );
    }
    _initialNumbersLocalized = true;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _startWeekCtrl.dispose();
    _endWeekCtrl.dispose();
    _doseCtrl.dispose();
    _syringeCtrl.dispose();
    _noteCtrl.dispose();
    for (final controller in _weekdayDoseCtrls.values) {
      controller.dispose();
    }
    super.dispose();
  }

  List<String> _normalizePhaseTimes(List<String> times) {
    final result = <String>{};
    for (final time in times) {
      final parts = time.split(':');
      final hour = parts.isNotEmpty ? int.tryParse(parts[0]) : null;
      final minute = parts.length > 1 ? int.tryParse(parts[1]) : null;
      if (hour == null ||
          minute == null ||
          hour < 0 ||
          hour > 23 ||
          minute < 0 ||
          minute > 59) {
        continue;
      }
      result.add(
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
      );
    }
    return result.isEmpty ? <String>['08:00'] : result.toList()
      ..sort();
  }

  Future<void> _addTime() async {
    final current = _times.isEmpty ? '08:00' : _times.last;
    final parts = current.split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.first) ?? 8,
        minute: int.tryParse(parts.last) ?? 0,
      ),
    );
    if (picked == null) return;
    final value =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    setState(() => _times = _normalizePhaseTimes([..._times, value]));
  }

  Future<void> _editTime(String current) async {
    final parts = current.split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.first) ?? 8,
        minute: int.tryParse(parts.last) ?? 0,
      ),
    );
    if (picked == null) return;
    final value =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    setState(() {
      _times = _normalizePhaseTimes([
        for (final time in _times)
          if (time == current) value else time,
      ]);
    });
  }

  void _toggleWeekday(int weekday) {
    setState(() {
      if (_selectedWeekdays.remove(weekday)) return;
      _selectedWeekdays.add(weekday);
      _weekdayDoseCtrls.putIfAbsent(
        weekday,
        () => TextEditingController(text: _doseCtrl.text),
      );
      _weekdayTimes.putIfAbsent(weekday, () => List<String>.from(_times));
    });
  }

  Future<void> _addWeekdayTime(int weekday) async {
    final times = _weekdayTimes[weekday] ?? <String>['08:00'];
    final current = times.last;
    final parts = current.split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.first) ?? 8,
        minute: int.tryParse(parts.last) ?? 0,
      ),
    );
    if (picked == null) return;
    final value =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    setState(() {
      _weekdayTimes[weekday] = _normalizePhaseTimes([...times, value]);
    });
  }

  Future<void> _editWeekdayTime(int weekday, String current) async {
    final parts = current.split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.first) ?? 8,
        minute: int.tryParse(parts.last) ?? 0,
      ),
    );
    if (picked == null) return;
    final value =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    final times = _weekdayTimes[weekday] ?? <String>[current];
    setState(() {
      _weekdayTimes[weekday] = _normalizePhaseTimes([
        for (final time in times)
          if (time == current) value else time,
      ]);
    });
  }

  bool get _customWeekdaysAreValid {
    if (_selectedWeekdays.isEmpty) return false;
    for (final weekday in _selectedWeekdays) {
      final amount = parseDecimalInput(_weekdayDoseCtrls[weekday]?.text ?? '');
      if (amount == null || amount <= 0) return false;
      if ((_weekdayTimes[weekday] ?? const <String>[]).isEmpty) return false;
    }
    return true;
  }

  List<ProtocolWeekdayDose> _buildWeekdayDoses() {
    final weekdays = _selectedWeekdays.toList()..sort();
    final syringeUnits = parseDecimalInput(_syringeCtrl.text) ?? 0;
    return [
      for (final weekday in weekdays)
        ProtocolWeekdayDose(
          weekday: weekday,
          dosePerInjection: parseDecimalInput(
            _weekdayDoseCtrls[weekday]?.text ?? '',
          )!,
          doseUnit: _unit,
          syringeUnits: syringeUnits,
          scheduledTimes: _weekdayTimes[weekday]!,
        ),
    ];
  }

  bool get _canSave {
    final start = int.tryParse(_startWeekCtrl.text) ?? 0;
    final end = int.tryParse(_endWeekCtrl.text) ?? 0;
    final dose = parseDecimalInput(_doseCtrl.text) ?? 0;
    return _nameCtrl.text.trim().isNotEmpty &&
        start > 0 &&
        end >= start &&
        dose > 0 &&
        (_frequency == kCustomWeekdayFrequency
            ? _customWeekdaysAreValid
            : _times.isNotEmpty);
  }

  void _save() {
    final start = int.parse(_startWeekCtrl.text).clamp(1, 104).toInt();
    final end = int.parse(_endWeekCtrl.text).clamp(start, 104).toInt();
    Navigator.of(context).pop(
      widget.initial
        ..name = _nameCtrl.text.trim()
        ..startWeek = start
        ..endWeek = end
        ..note = _noteCtrl.text.trim()
        ..dosePerInjection = parseDecimalInput(_doseCtrl.text)
        ..doseUnit = _unit
        ..syringeUnits = parseDecimalInput(_syringeCtrl.text)
        ..frequency = _frequency
        ..scheduledTimes = _times
        ..weekdayDoses = _frequency == kCustomWeekdayFrequency
            ? _buildWeekdayDoses()
            : <ProtocolWeekdayDose>[],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
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
                      borderRadius: BorderRadius.circular(
                        AppSpacing.sheetHandleHeight,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('CONFIG.PHASE', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.phaseOverrideTitle, style: AppTypography.h2),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.phaseOverrideBody, style: AppTypography.bodySmall),
                const SizedBox(height: AppSpacing.lg),
                _FieldLabel(
                  label: l10n.phaseNameLabel,
                  child: TextField(
                    controller: _nameCtrl,
                    onChanged: (_) => setState(() {}),
                    style: AppTypography.bodyLarge,
                    decoration: InputDecoration(
                      hintText: l10n.phaseNameHint,
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.all(AppSpacing.md),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.base),
                Row(
                  children: [
                    Expanded(
                      child: _FieldLabel(
                        label: l10n.startWeekLabel,
                        child: TextField(
                          controller: _startWeekCtrl,
                          onChanged: (_) => setState(() {}),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: AppTypography.tabular,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.all(AppSpacing.md),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.cardGap),
                    Expanded(
                      child: _FieldLabel(
                        label: l10n.endWeekLabel,
                        child: TextField(
                          controller: _endWeekCtrl,
                          onChanged: (_) => setState(() {}),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: AppTypography.tabular,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.all(AppSpacing.md),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.base),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _FieldLabel(
                        label: _frequency == kCustomWeekdayFrequency
                            ? l10n.defaultAmountLabel
                            : l10n.trackedAmountLabel,
                        child: TextField(
                          controller: _doseCtrl,
                          onChanged: (_) => setState(() {}),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: const [decimalInputFormatter],
                          style: AppTypography.tabular,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.all(AppSpacing.md),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.cardGap),
                    Expanded(
                      child: _FieldLabel(
                        label: l10n.unitLabel,
                        child: _SegmentedToggle(
                          options: const ['mcg', 'mg', 'IU'],
                          selected: _unit,
                          onSelect: (value) => setState(() => _unit = value),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.base),
                _FieldLabel(
                  label: l10n.syringeUnitsOptional,
                  child: TextField(
                    controller: _syringeCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: const [decimalInputFormatter],
                    style: AppTypography.tabular,
                    decoration: InputDecoration(
                      hintText: l10n.optionalLabel,
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.all(AppSpacing.md),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.phaseScheduleLabel, style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final frequency in kFrequencies)
                      _Chip(
                        label: _freqLabel(context, frequency.key),
                        selected: _frequency == frequency.key,
                        onTap: () => setState(() => _frequency = frequency.key),
                      ),
                  ],
                ),
                if (_frequency == kCustomWeekdayFrequency) ...[
                  const SizedBox(height: AppSpacing.base),
                  Text(
                    l10n.customDays.toUpperCase(),
                    style: AppTypography.systemLabel,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (
                        var weekday = DateTime.monday;
                        weekday <= DateTime.sunday;
                        weekday++
                      )
                        _Chip(
                          label: _weekdayLabel(context, weekday),
                          selected: _selectedWeekdays.contains(weekday),
                          onTap: () => _toggleWeekday(weekday),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.base),
                  if (_selectedWeekdays.isEmpty)
                    Text(
                      l10n.phaseSelectDayError,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.warning,
                      ),
                    )
                  else
                    for (final weekday
                        in (_selectedWeekdays.toList()..sort())) ...[
                      _PhaseWeekdayEditor(
                        weekday: weekday,
                        amountController: _weekdayDoseCtrls[weekday]!,
                        unit: _unit,
                        times: _weekdayTimes[weekday]!,
                        onAmountChanged: (_) => setState(() {}),
                        onEditTime: (time) => _editWeekdayTime(weekday, time),
                        onRemoveTime: (time) {
                          final times = _weekdayTimes[weekday]!;
                          if (times.length == 1) return;
                          setState(() => times.remove(time));
                        },
                        onAddTime: () => _addWeekdayTime(weekday),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                  if (_selectedWeekdays.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    _PhaseSchedulePreview(
                      unit: _unit,
                      selectedWeekdays: _selectedWeekdays,
                      amountControllers: _weekdayDoseCtrls,
                      timesByWeekday: _weekdayTimes,
                    ),
                  ],
                ] else ...[
                  const SizedBox(height: AppSpacing.base),
                  Text(
                    l10n.reminderTimesLabel,
                    style: AppTypography.systemLabel,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final time in _times)
                        _TimeChip(
                          label: _formatStoredTime(context, time),
                          canRemove: _times.length > 1,
                          onTap: () => _editTime(time),
                          onRemove: () => setState(() => _times.remove(time)),
                        ),
                      _Chip(
                        label: l10n.addTime,
                        selected: false,
                        onTap: _addTime,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.base),
                _FieldLabel(
                  label: l10n.changeNoteOptional,
                  child: TextField(
                    controller: _noteCtrl,
                    minLines: 2,
                    maxLines: 3,
                    style: AppTypography.bodyMedium,
                    decoration: InputDecoration(
                      hintText: l10n.changeNoteHint,
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.all(AppSpacing.md),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.phaseReminderBody, style: AppTypography.disclaimer),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: l10n.savePhase,
                  onPressed: _canSave ? _save : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      l10n.cancelLabel,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhaseWeekdayEditor extends StatelessWidget {
  const _PhaseWeekdayEditor({
    required this.weekday,
    required this.amountController,
    required this.unit,
    required this.times,
    required this.onAmountChanged,
    required this.onEditTime,
    required this.onRemoveTime,
    required this.onAddTime,
  });

  final int weekday;
  final TextEditingController amountController;
  final String unit;
  final List<String> times;
  final ValueChanged<String> onAmountChanged;
  final ValueChanged<String> onEditTime;
  final ValueChanged<String> onRemoveTime;
  final VoidCallback onAddTime;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(
              context,
            ).weekdaySchedule(_weekdayLabel(context, weekday).toUpperCase()),
            style: AppTypography.systemLabel,
          ),
          const SizedBox(height: AppSpacing.sm),
          _FieldLabel(
            label: l10n.trackedAmountLabel,
            child: TextField(
              controller: amountController,
              onChanged: onAmountChanged,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: const [decimalInputFormatter],
              style: AppTypography.tabular,
              decoration: InputDecoration(
                suffixText: unit,
                suffixStyle: AppTypography.bodySmall,
                border: InputBorder.none,
                filled: false,
                contentPadding: const EdgeInsets.all(AppSpacing.md),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.reminderTimesLabel, style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final time in times)
                _TimeChip(
                  label: _formatStoredTime(context, time),
                  canRemove: times.length > 1,
                  onTap: () => onEditTime(time),
                  onRemove: () => onRemoveTime(time),
                ),
              _Chip(label: l10n.addTime, selected: false, onTap: onAddTime),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhaseSchedulePreview extends StatelessWidget {
  const _PhaseSchedulePreview({
    required this.unit,
    required this.selectedWeekdays,
    required this.amountControllers,
    required this.timesByWeekday,
  });

  final String unit;
  final Set<int> selectedWeekdays;
  final Map<int, TextEditingController> amountControllers;
  final Map<int, List<String>> timesByWeekday;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final weekdays = selectedWeekdays.toList()..sort();
    return AppCard(
      borderColor: AppColors.borderCyan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.phasePreviewLabel, style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.sm),
          for (final weekday in weekdays)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 34,
                    child: Text(
                      _weekdayLabel(context, weekday).toUpperCase(),
                      style: AppTypography.systemLabel.copyWith(fontSize: 9),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${amountControllers[weekday]?.text.trim().isEmpty ?? true ? l10n.amountRequired : '${amountControllers[weekday]!.text.trim()} $unit'}'
                      ' · ${(timesByWeekday[weekday] ?? const <String>[]).map((time) => _formatStoredTime(context, time)).join(', ')}',
                      style: AppTypography.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          Text(l10n.phasePreviewDisclaimer, style: AppTypography.disclaimer),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.child});
  final String label;
  final Widget child;

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
          clipBehavior: Clip.antiAlias,
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

class _SegmentedToggle extends StatelessWidget {
  const _SegmentedToggle({
    required this.options,
    required this.selected,
    required this.onSelect,
  });
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((o) {
        final isOn = o == selected;
        return Expanded(
          child: Semantics(
            button: true,
            selected: isOn,
            label: AppLocalizations.of(context).selectOption(o),
            excludeSemantics: true,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                onSelect(o);
              },
              child: AnimatedContainer(
                duration: AppDurations.fast,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isOn
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    o,
                    style: AppTypography.labelMedium.copyWith(
                      color: isOn ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({
    required this.label,
    required this.canRemove,
    required this.onTap,
    required this.onRemove,
  });

  final String label;
  final bool canRemove;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: l10n.editTime(label),
      excludeSemantics: true,
      child: GestureDetector(
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
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.primary, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 6,
              ),
            ],
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
              if (canRemove) ...[
                const SizedBox(width: AppSpacing.xs),
                Semantics(
                  button: true,
                  label: l10n.removeTime(label),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onRemove();
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColors.primary,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
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

class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.hex,
    required this.selected,
    required this.onTap,
  });

  final String hex;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = peptideLabelColor(hex);
    return Semantics(
      button: true,
      selected: selected,
      label: AppLocalizations.of(context).colorOption(hex),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: AnimatedContainer(
          duration: AppDurations.fast,
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: selected ? 0.26 : 0.14),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? color : AppColors.border,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.28),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: PeptideLabelSwatch(
              hex: hex,
              size: 18,
              borderColor: AppColors.background,
            ),
          ),
        ),
      ),
    );
  }
}

/// Static helper that returns a fallback peptide if the library lookup fails.
/// Not currently used — here to explicitly satisfy linter if extended later.
// ignore: unused_element
Peptide _fallbackPeptide() {
  return Peptide(
    slug: 'custom',
    name: 'Custom',
    category: PeptideCategory.other,
    description: '',
    typicalDose: '',
    defaultDoseMcg: 250,
    defaultFrequency: 'daily',
    halfLife: '',
    typicalCycleWeeks: 0,
    defaultRoute: 'subcutaneous',
    notes: '',
    disclaimer: '',
    commonStack: const <String>[],
  );
}
