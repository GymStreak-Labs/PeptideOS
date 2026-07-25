import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/peptide.dart';
import '../../../models/protocol.dart';
import '../../library/providers/peptide_provider.dart';
import '../../subscription/providers/subscription_provider.dart';
import '../../subscription/screens/soft_paywall_sheet.dart';
import '../providers/dose_log_provider.dart';
import '../providers/protocol_provider.dart';
import '../widgets/peptide_label_color.dart';

const _customPeptideSlug = 'custom';

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
  if (!p.usesCustomWeekdays) {
    return '${_formatAmount(p.dosePerInjection)} ${p.doseUnit} · '
        '${_freqLabel(p.frequency)}${_syringeSummary(p.syringeUnits)}';
  }
  final days = [...p.weekdayDoses]
    ..sort((a, b) => a.weekday.compareTo(b.weekday));
  final summary = days
      .map(
        (d) =>
            '${_weekdayLabel(d.weekday)} ${_formatAmount(d.dosePerInjection)} ${d.doseUnit}${_syringeSummary(d.syringeUnits)}',
      )
      .join(', ');
  return summary.isEmpty ? 'Custom days' : summary;
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
  if (slug == _customPeptideSlug) {
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
    builder: (_) => _PeptideConfigSheet(initial: draft),
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
    builder: (_) => _PeptideConfigSheet(initial: p),
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
              Text('PICK.PEPTIDE', style: AppTypography.systemLabel),
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
                          hintText: 'Search peptides...',
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
                  itemCount: peptides.length + 1,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) {
                    if (i == 0) {
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
                                    'Custom peptide',
                                    style: AppTypography.labelLarge,
                                  ),
                                  Text(
                                    'Track your own entry',
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
                    final p = peptides[i - 1];
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
            ],
          ),
        ),
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
  bool get _isCustomPeptide => widget.initial.peptideSlug == _customPeptideSlug;

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
      ..weekdayDoses = weekdayDoses;
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
