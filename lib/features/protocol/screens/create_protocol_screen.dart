import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/blend_vial.dart';
import '../../../models/peptide.dart';
import '../../../models/protocol.dart';
import '../../library/providers/custom_compound_provider.dart';
import '../../library/providers/peptide_provider.dart';
import '../../library/screens/custom_compound_library_screen.dart';
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
  final List<ProtocolPeptide> _peptides = [];
  DateTime _startDate = DateTime.now();
  bool _saving = false;

  bool get _isEditing => widget.initialProtocol != null;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialProtocol;
    _nameController = TextEditingController(
      text: initial?.name ?? 'My Protocol',
    );
    if (initial != null) {
      _startDate = initial.startDate;
      _peptides.addAll(initial.peptides.map(_cloneProtocolPeptide));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleAddPeptide(ProtocolPeptide p) async {
    final sub = context.read<SubscriptionProvider>();
    if (!sub.canAddPeptide(_peptides.length)) {
      final purchased = await showSoftPaywall(
        context,
        source: 'peptide_limit',
        reason:
            'Free plan is limited to one peptide per protocol. Upgrade to '
            'stack multiple compounds.',
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
        const SnackBar(content: Text('Add at least one peptide.')),
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
        );
      } else {
        await provider.createProtocol(
          name: _nameController.text.trim(),
          startDate: _startDate,
          peptides: _peptides,
        );
      }
      if (!mounted) return;
      await context.read<DoseLogProvider>().refresh();
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save protocol. Try again.')),
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
                          '${_isEditing ? 'Edit' : 'Build'} Protocol · Step ${_step + 1} / 3',
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
                    ? (_isEditing ? 'SAVE CHANGES' : 'CREATE PROTOCOL')
                    : 'NEXT',
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
  const _Step1Name({required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name your protocol', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Give it a memorable label — e.g. "Recovery Stack" or "Q2 Shred".',
            style: AppTypography.bodyMedium,
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Build your stack', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Add one peptide or stack multiple compounds. Configure each label, dose, frequency, and cycle.',
            style: AppTypography.bodyMedium,
          ),
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
                          'No peptides yet',
                          style: AppTypography.labelLarge,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Tap + to pick from the library',
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
                                    _scheduleSummary(p),
                                    style: AppTypography.bodySmall.copyWith(
                                      fontFamily: 'JetBrainsMono',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => onRemove(p),
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
              'ADD TO STACK',
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Review', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Confirm the protocol details. You can edit anytime from the Manage view.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NAME', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.xs),
                Text(name, style: AppTypography.labelLarge),
                const SizedBox(height: AppSpacing.base),
                Text('START DATE', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.xs),
                GestureDetector(
                  onTap: onPickDate,
                  child: Row(
                    children: [
                      Text(
                        _formatDate(startDate),
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
                  'PEPTIDES (${peptides.length})',
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
                            '${p.peptideName} · ${_scheduleSummary(p)}',
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
            'Educational tracking only. Always consult a qualified healthcare provider.',
            style: AppTypography.disclaimer,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Helpers shared across steps ────────────────────────────────────────────
String _formatDate(DateTime d) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[d.month - 1]} ${d.day}, ${d.year}';
}

String _formatAmount(double d) =>
    d == d.roundToDouble() ? d.toStringAsFixed(0) : d.toStringAsFixed(1);

String _freqLabel(String key) => kFrequencies
    .firstWhere((f) => f.key == key, orElse: () => kFrequencies.first)
    .label;

String _weekdayLabel(int weekday) => switch (weekday) {
  DateTime.monday => 'Mon',
  DateTime.tuesday => 'Tue',
  DateTime.wednesday => 'Wed',
  DateTime.thursday => 'Thu',
  DateTime.friday => 'Fri',
  DateTime.saturday => 'Sat',
  DateTime.sunday => 'Sun',
  _ => 'Day',
};

String _scheduleSummary(ProtocolPeptide p) {
  final phaseSuffix = p.phases.isEmpty
      ? ''
      : ' · ${p.phases.length} ${p.phases.length == 1 ? 'phase' : 'phases'}';
  if (p.isBlend) {
    return '${_formatAmount(p.syringeUnits)} syringe units · '
        '${_freqLabel(p.frequency)} · '
        '${p.blendVial!.constituents.length} compounds$phaseSuffix';
  }
  if (!p.usesCustomWeekdays) {
    return '${_formatAmount(p.dosePerInjection)} ${p.doseUnit} · '
        '${_freqLabel(p.frequency)}${_syringeSummary(p.syringeUnits)}'
        '$phaseSuffix';
  }
  final days = [...p.weekdayDoses]
    ..sort((a, b) => a.weekday.compareTo(b.weekday));
  final summary = days
      .map(
        (d) =>
            '${_weekdayLabel(d.weekday)} ${_formatAmount(d.dosePerInjection)} ${d.doseUnit}${_syringeSummary(d.syringeUnits)}',
      )
      .join(', ');
  return summary.isEmpty ? 'Custom days$phaseSuffix' : '$summary$phaseSuffix';
}

String _syringeSummary(double value) {
  if (value <= 0) return '';
  return ' · ${_formatAmount(value)} syringe units';
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
      name: 'Custom blend',
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
      name: 'Custom peptide',
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
    final peptides = context.watch<PeptideProvider>().search(query: _query);
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
              Text('Library', style: AppTypography.h2),
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
                          hintText: 'Search compounds...',
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
                                    'Pre-blended vial',
                                    style: AppTypography.labelLarge,
                                  ),
                                  Text(
                                    'One vial · one draw · multiple compounds',
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
                                    'One-off compound',
                                    style: AppTypography.labelLarge,
                                  ),
                                  Text(
                                    'Use once without saving a preset',
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
                                    '${_formatAmount(compound.vialAmount)} ${compound.vialUnit} vial · Saved preset',
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
                label: const Text('Manage saved compounds'),
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

  @override
  void initState() {
    super.initState();
    final blend = widget.initial.blendVial;
    _nameCtrl = TextEditingController(text: widget.initial.peptideName);
    _diluentCtrl = TextEditingController(
      text: _formatEditableAmount(blend?.diluentMl ?? 2),
    );
    _drawCtrl = TextEditingController(
      text: _formatEditableAmount(
        blend?.drawSyringeUnits ?? widget.initial.syringeUnits,
      ),
    );
    _cycleWeeksCtrl = TextEditingController(
      text: widget.initial.cycleWeeks > 0
          ? widget.initial.cycleWeeks.toString()
          : '',
    );
    _washoutWeeksCtrl = TextEditingController(
      text: widget.initial.washoutWeeks > 0
          ? widget.initial.washoutWeeks.toString()
          : '',
    );
    final source = blend?.constituents ?? const <BlendConstituent>[];
    if (source.length >= 2) {
      _constituents.addAll(
        source.map(_BlendConstituentControllers.fromConstituent),
      );
    } else {
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
                Text('Pre-blended vial', style: AppTypography.h2),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Enter exactly what is printed on the vial. PepMod converts the draw into a per-compound snapshot.',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: AppSpacing.lg),
                _FieldLabel(
                  label: 'BLEND NAME',
                  child: TextField(
                    controller: _nameCtrl,
                    onChanged: (_) => setState(() {}),
                    textCapitalization: TextCapitalization.words,
                    style: AppTypography.bodyLarge,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Recovery blend',
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
                    Text('VIAL CONTENTS', style: AppTypography.systemLabel),
                    const Spacer(),
                    Text(
                      '${_constituents.length} compounds',
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
                    '+ ADD COMPOUND',
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
                        label: 'DILUENT VOLUME',
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
                        label: 'DRAW',
                        child: TextField(
                          controller: _drawCtrl,
                          onChanged: (_) => setState(() {}),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: const [decimalInputFormatter],
                          style: AppTypography.tabular.copyWith(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: '10',
                            suffixText: 'units',
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
                  'Uses U-100 syringe markings (100 units = 1 mL). Values are user-entered tracking data.',
                  style: AppTypography.disclaimer,
                ),
                const SizedBox(height: AppSpacing.base),
                _BlendPreview(blend: blend),
                const SizedBox(height: AppSpacing.lg),
                Text('SCHEDULE', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final option in kFrequencies)
                      _Chip(
                        label: option.label,
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
                          label: _weekdayLabel(weekday),
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
                        label: time,
                        canRemove: _times.length > 1,
                        onTap: () => _editTime(time),
                        onRemove: () => setState(() {
                          if (_times.length > 1) _times.remove(time);
                        }),
                      ),
                    _Chip(label: 'Add time', selected: false, onTap: _addTime),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('ROUTE', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final option in kRoutes)
                      _Chip(
                        label: option.label,
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
                        label: 'CYCLE WEEKS',
                        child: TextField(
                          controller: _cycleWeeksCtrl,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: AppTypography.tabular.copyWith(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: 'None',
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
                        label: 'REST WEEKS',
                        child: TextField(
                          controller: _washoutWeeksCtrl,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: AppTypography.tabular.copyWith(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: 'None',
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
                Text('LABEL COLOR', style: AppTypography.systemLabel),
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
                  'Unit conversion only. PepMod does not recommend a blend, dose, frequency, or reconstitution method.',
                  style: AppTypography.disclaimer.copyWith(
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: 'SAVE BLEND',
                  onPressed: _canSave ? _save : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
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

  static String _formatEditableAmount(double value) =>
      value == value.roundToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
}

class _BlendConstituentControllers {
  _BlendConstituentControllers({
    String name = '',
    String amount = '',
    this.unit = 'mg',
  }) : name = TextEditingController(text: name),
       amount = TextEditingController(text: amount);

  factory _BlendConstituentControllers.fromConstituent(
    BlendConstituent constituent,
  ) {
    return _BlendConstituentControllers(
      name: constituent.name,
      amount: constituent.vialAmount == constituent.vialAmount.roundToDouble()
          ? constituent.vialAmount.toStringAsFixed(0)
          : constituent.vialAmount.toStringAsFixed(2),
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
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('COMPOUND ${index + 1}', style: AppTypography.systemLabel),
              const Spacer(),
              if (canRemove)
                TextButton(
                  onPressed: onRemove,
                  child: Text(
                    'REMOVE',
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
            decoration: const InputDecoration(
              hintText: 'Name from vial label',
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
                  decoration: const InputDecoration(
                    hintText: 'Vial amount',
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

  String _amount(double value) {
    if (value >= 100) return value.toStringAsFixed(0);
    if (value >= 10) return value.toStringAsFixed(1);
    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: blend.isValid ? AppColors.borderCyan : AppColors.border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DRAW PREVIEW', style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.sm),
          if (!blend.isValid)
            Text(
              blend.drawVolumeMl > blend.diluentMl && blend.diluentMl > 0
                  ? 'Draw cannot exceed the vial volume.'
                  : 'Complete at least two compounds, diluent volume, and draw.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            )
          else ...[
            Text(
              '${_amount(blend.drawSyringeUnits)} units = '
              '${_amount(blend.drawVolumeMl)} mL',
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
                      '${_amount(blend.amountPerDraw(constituent))} '
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
  bool get _isCustomPeptide =>
      widget.initial.peptideSlug == _customPeptideSlug ||
      widget.initial.peptideSlug.startsWith(_savedCompoundSlugPrefix);

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initial.peptideName);
    _doseCtrl = TextEditingController(
      text: _formatAmount(widget.initial.dosePerInjection),
    );
    _syringeUnitsCtrl = TextEditingController(
      text: widget.initial.syringeUnits > 0
          ? _formatAmount(widget.initial.syringeUnits)
          : '',
    );
    _cycleWeeksCtrl = TextEditingController(
      text: widget.initial.cycleWeeks > 0
          ? widget.initial.cycleWeeks.toString()
          : '',
    );
    _washoutWeeksCtrl = TextEditingController(
      text: widget.initial.washoutWeeks > 0
          ? widget.initial.washoutWeeks.toString()
          : '',
    );
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
    for (final weekday in _selectedWeekdays) {
      _ensureWeekdayController(weekday);
    }
    _phases =
        widget.initial.phases
            .map((phase) => ProtocolPhase.fromMap(phase.toMap()))
            .toList()
          ..sort((a, b) => a.startWeek.compareTo(b.startWeek));
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
      text: _formatAmount(existing?.dosePerInjection ?? _parsedBaseDose),
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
          name: 'Phase ${_phases.length + 1}',
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
            'This protocol cycle ends after week $_parsedCycleWeeks. '
            'Keep phase weeks inside that window.',
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
        const SnackBar(content: Text('Phase week ranges cannot overlap.')),
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
                              ? 'Custom peptide'
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
                              '${_formatAmount(widget.initial.vialAmountSnapshot)} '
                              '${widget.initial.vialUnitSnapshot} vial preset · '
                              'copied into this protocol',
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
                      label: 'NAME',
                      child: TextField(
                        controller: _nameCtrl,
                        onChanged: (_) => setState(() {}),
                        textCapitalization: TextCapitalization.words,
                        style: AppTypography.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Enter peptide name',
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

                  Text('LABEL COLOR', style: AppTypography.systemLabel),
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
                  Text(
                    'Match this color to the pen or vial label you use in real life.',
                    style: AppTypography.disclaimer,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Dose + unit
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _FieldLabel(
                          label: 'DOSE',
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
                          label: 'UNIT',
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
                    label: 'SYRINGE UNITS OPTIONAL',
                    child: TextField(
                      controller: _syringeUnitsCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: const [decimalInputFormatter],
                      style: AppTypography.tabular.copyWith(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'e.g. 12.5',
                        hintStyle: AppTypography.bodySmall.copyWith(
                          color: AppColors.textDisabled,
                        ),
                        suffixText: 'syringe units',
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
                    'Optional user-entered U-100 syringe markings for tracking only.',
                    style: AppTypography.disclaimer,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Frequency
                  Text('FREQUENCY', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final f in kFrequencies)
                        _Chip(
                          label: f.label,
                          selected: _frequency == f.key,
                          onTap: () => _selectFrequency(f.key),
                        ),
                    ],
                  ),
                  if (_frequency == kCustomWeekdayFrequency) ...[
                    const SizedBox(height: AppSpacing.base),
                    Text('CUSTOM DAYS', style: AppTypography.systemLabel),
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
                            label: _weekdayLabel(weekday),
                            selected: _selectedWeekdays.contains(weekday),
                            onTap: () => _toggleWeekday(weekday),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.base),
                    if (_selectedWeekdays.isEmpty)
                      Text(
                        'Select at least one day to schedule this peptide.',
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
                                label: '${_weekdayLabel(weekday)} DOSE',
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
                      'Only selected weekdays are scheduled. Amounts are user-entered tracking values, not dosing advice.',
                      style: AppTypography.disclaimer,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),

                  // Route
                  Text('ROUTE', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final r in kRoutes)
                        _Chip(
                          label: r.label,
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
                          label: 'CYCLE WEEKS',
                          child: TextField(
                            controller: _cycleWeeksCtrl,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: AppTypography.tabular.copyWith(fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'None',
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
                          label: 'REST WEEKS',
                          child: TextField(
                            controller: _washoutWeeksCtrl,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: AppTypography.tabular.copyWith(fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'None',
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
                    'Cycle and rest windows organize tracking history. PepMod will not schedule future doses after the cycle window ends.',
                    style: AppTypography.disclaimer,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  Text('WEEK-TO-WEEK PHASES', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Optional date windows can override this base amount and schedule. Outside them, the base schedule continues.',
                    style: AppTypography.bodySmall,
                  ),
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
                      'A phase extends beyond the $_parsedCycleWeeks-week cycle. Adjust the phase or cycle window.',
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
                      'ADD PHASE',
                      style: AppTypography.button.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Weeks are counted from the protocol start date. Saved phase notes and change reminders are tracking aids only.',
                    style: AppTypography.disclaimer,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Reminder times
                  Text('REMINDER TIMES', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final time in _times)
                        _TimeChip(
                          label: time,
                          canRemove: _times.length > 1,
                          onTap: () => _editTime(time),
                          onRemove: () => _removeTime(time),
                        ),
                      _Chip(
                        label: 'Add time',
                        selected: false,
                        onTap: _addTime,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Each selected time creates its own tracking row and reminder on scheduled days.',
                    style: AppTypography.disclaimer,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  PrimaryButton(
                    label: 'SAVE',
                    onPressed: _canSave ? _save : null,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
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
    final weeks = phase.startWeek == phase.endWeek
        ? 'WEEK ${phase.startWeek}'
        : 'WEEKS ${phase.startWeek}–${phase.endWeek}';
    final amount =
        phase.frequency == kCustomWeekdayFrequency &&
            phase.weekdayDoses.isNotEmpty
        ? 'Per-day amounts'
        : phase.dosePerInjection == null
        ? 'Base amount'
        : '${_formatAmount(phase.dosePerInjection!)} ${phase.doseUnit ?? ''}';
    final frequency = phase.frequency == null
        ? 'base schedule'
        : _freqLabel(phase.frequency!);
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
            tooltip: 'Remove phase',
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

  @override
  void initState() {
    super.initState();
    final phase = widget.initial;
    _nameCtrl = TextEditingController(text: phase.name);
    _startWeekCtrl = TextEditingController(text: '${phase.startWeek}');
    _endWeekCtrl = TextEditingController(text: '${phase.endWeek}');
    _doseCtrl = TextEditingController(
      text: _formatAmount(phase.dosePerInjection ?? widget.fallbackDose),
    );
    _syringeCtrl = TextEditingController(
      text: (phase.syringeUnits ?? 0) > 0
          ? _formatAmount(phase.syringeUnits!)
          : '',
    );
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
      _weekdayDoseCtrls[dose.weekday] = TextEditingController(
        text: _formatAmount(dose.dosePerInjection),
      );
      _weekdayTimes[dose.weekday] = _normalizePhaseTimes(dose.scheduledTimes);
    }
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
                Text('Week-to-week override', style: AppTypography.h2),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Enter only the tracking schedule you already intend to follow. PepMod does not recommend amounts.',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: AppSpacing.lg),
                _FieldLabel(
                  label: 'PHASE NAME',
                  child: TextField(
                    controller: _nameCtrl,
                    onChanged: (_) => setState(() {}),
                    style: AppTypography.bodyLarge,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Week 1 tracking',
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
                        label: 'START WEEK',
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
                        label: 'END WEEK',
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
                            ? 'DEFAULT AMOUNT'
                            : 'TRACKED AMOUNT',
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
                        label: 'UNIT',
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
                  label: 'SYRINGE UNITS OPTIONAL',
                  child: TextField(
                    controller: _syringeCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: const [decimalInputFormatter],
                    style: AppTypography.tabular,
                    decoration: const InputDecoration(
                      hintText: 'Optional',
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.all(AppSpacing.md),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('PHASE SCHEDULE', style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final frequency in kFrequencies)
                      _Chip(
                        label: frequency.label,
                        selected: _frequency == frequency.key,
                        onTap: () => setState(() => _frequency = frequency.key),
                      ),
                  ],
                ),
                if (_frequency == kCustomWeekdayFrequency) ...[
                  const SizedBox(height: AppSpacing.base),
                  Text('CUSTOM DAYS', style: AppTypography.systemLabel),
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
                          label: _weekdayLabel(weekday),
                          selected: _selectedWeekdays.contains(weekday),
                          onTap: () => _toggleWeekday(weekday),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.base),
                  if (_selectedWeekdays.isEmpty)
                    Text(
                      'Select at least one day. PepMod will not choose a schedule for you.',
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
                  Text('REMINDER TIMES', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final time in _times)
                        _TimeChip(
                          label: time,
                          canRemove: _times.length > 1,
                          onTap: () => _editTime(time),
                          onRemove: () => setState(() => _times.remove(time)),
                        ),
                      _Chip(
                        label: 'Add time',
                        selected: false,
                        onTap: _addTime,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.base),
                _FieldLabel(
                  label: 'CHANGE NOTE OPTIONAL',
                  child: TextField(
                    controller: _noteCtrl,
                    minLines: 2,
                    maxLines: 3,
                    style: AppTypography.bodyMedium,
                    decoration: const InputDecoration(
                      hintText: 'Your own context for this phase',
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.all(AppSpacing.md),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'A neutral phase-change reminder is scheduled for 9:00 AM when protocol reminders are enabled.',
                  style: AppTypography.disclaimer,
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: 'SAVE PHASE',
                  onPressed: _canSave ? _save : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
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
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_weekdayLabel(weekday).toUpperCase()} SCHEDULE',
            style: AppTypography.systemLabel,
          ),
          const SizedBox(height: AppSpacing.sm),
          _FieldLabel(
            label: 'TRACKED AMOUNT',
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
          Text('REMINDER TIMES', style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final time in times)
                _TimeChip(
                  label: time,
                  canRemove: times.length > 1,
                  onTap: () => onEditTime(time),
                  onRemove: () => onRemoveTime(time),
                ),
              _Chip(label: 'Add time', selected: false, onTap: onAddTime),
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
    final weekdays = selectedWeekdays.toList()..sort();
    return AppCard(
      borderColor: AppColors.borderCyan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PHASE PREVIEW', style: AppTypography.systemLabel),
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
                      _weekdayLabel(weekday).toUpperCase(),
                      style: AppTypography.systemLabel.copyWith(fontSize: 9),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${amountControllers[weekday]?.text.trim().isEmpty ?? true ? 'Amount required' : '${amountControllers[weekday]!.text.trim()} $unit'}'
                      ' · ${(timesByWeekday[weekday] ?? const <String>[]).join(', ')}',
                      style: AppTypography.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          Text(
            'Preview of your entries only. No schedule is recommended by PepMod.',
            style: AppTypography.disclaimer,
          ),
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
    return GestureDetector(
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
              GestureDetector(
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
            ],
          ],
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
    return GestureDetector(
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
    return GestureDetector(
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
