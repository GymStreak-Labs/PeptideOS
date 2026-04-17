import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/peptide.dart';
import '../../../models/protocol.dart';
import '../../library/providers/peptide_provider.dart';
import '../../subscription/providers/subscription_provider.dart';
import '../../subscription/screens/soft_paywall_sheet.dart';
import '../providers/dose_log_provider.dart';
import '../providers/protocol_provider.dart';

/// 3-step protocol builder: name → add peptides → start date + review.
class CreateProtocolScreen extends StatefulWidget {
  const CreateProtocolScreen({super.key});

  @override
  State<CreateProtocolScreen> createState() => _CreateProtocolScreenState();
}

class _CreateProtocolScreenState extends State<CreateProtocolScreen> {
  final _pageController = PageController();
  int _step = 0;

  final _nameController = TextEditingController(text: 'My Protocol');
  final List<ProtocolPeptide> _peptides = [];
  DateTime _startDate = DateTime.now();
  bool _saving = false;

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
      await context.read<ProtocolProvider>().createProtocol(
            name: _nameController.text.trim(),
            startDate: _startDate,
            peptides: _peptides,
          );
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
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: AppColors.textPrimary),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SYS.PROTOCOL // NEW',
                          style: AppTypography.systemLabel,
                        ),
                        Text('Build Protocol · Step ${_step + 1} / 3',
                            style: AppTypography.h3),
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
                  horizontal: AppSpacing.screenHorizontal),
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
                                  color: AppColors.primary.withValues(alpha: 0.5),
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
                    onRemove: (p) =>
                        setState(() => _peptides.remove(p)),
                    onEdit: (index, p) => setState(() => _peptides[index] = p),
                  ),
                  _Step3Review(
                    name: _nameController.text,
                    peptides: _peptides,
                    startDate: _startDate,
                    onPickDate: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime.now()
                            .subtract(const Duration(days: 30)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
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
                label: _step == 2 ? 'CREATE PROTOCOL' : 'NEXT',
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
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
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
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add peptides', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Pick from the library and configure dose, frequency, and cycle.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: peptides.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.science_rounded,
                            color: AppColors.textTertiary, size: 36),
                        const SizedBox(height: AppSpacing.base),
                        Text('No peptides yet',
                            style: AppTypography.labelLarge),
                        const SizedBox(height: AppSpacing.xs),
                        Text('Tap + to pick from the library',
                            style: AppTypography.bodySmall),
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
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.biotech_rounded,
                                  color: AppColors.primary),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.peptideName,
                                      style: AppTypography.labelLarge),
                                  Text(
                                    '${_formatAmount(p.dosePerInjection)} ${p.doseUnit} · ${_freqLabel(p.frequency)}',
                                    style: AppTypography.bodySmall.copyWith(
                                      fontFamily: 'JetBrainsMono',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => onRemove(p),
                              icon: Icon(Icons.close_rounded,
                                  color: AppColors.textTertiary,
                                  size: AppSpacing.iconMedium),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              final picked = await _pickPeptide(context);
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
            label: Text('ADD PEPTIDE',
                style: AppTypography.button.copyWith(color: AppColors.primary)),
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
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
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
                      Text(_formatDate(startDate),
                          style: AppTypography.tabular.copyWith(fontSize: 16)),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(Icons.edit_rounded,
                          size: 16, color: AppColors.primary),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.base),
                Text('PEPTIDES (${peptides.length})',
                    style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.xs),
                ...peptides.map((p) => Padding(
                      padding:
                          const EdgeInsets.only(top: AppSpacing.xs),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              '${p.peptideName} · ${_formatAmount(p.dosePerInjection)} ${p.doseUnit} · ${_freqLabel(p.frequency)}',
                              style: AppTypography.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    )),
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
  const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  return '${months[d.month - 1]} ${d.day}, ${d.year}';
}

String _formatAmount(double d) =>
    d == d.roundToDouble() ? d.toStringAsFixed(0) : d.toStringAsFixed(1);

String _freqLabel(String key) =>
    kFrequencies.firstWhere((f) => f.key == key, orElse: () => kFrequencies.first).label;

/// Opens the peptide picker and returns a configured ProtocolPeptide.
Future<ProtocolPeptide?> _pickPeptide(BuildContext context) async {
  final slug = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _PeptideLibraryPicker(),
  );
  if (slug == null) return null;
  if (!context.mounted) return null;

  final peptide = context.read<PeptideProvider>().findBySlug(slug);
  if (peptide == null) return null;

  final provider = context.read<ProtocolProvider>();
  final draft = provider.buildPeptide(
    slug: peptide.slug,
    name: peptide.name,
    dose: peptide.defaultDoseMcg,
    frequency: peptide.defaultFrequency,
    route: peptide.defaultRoute,
    cycleWeeks: peptide.typicalCycleWeeks,
  );

  return showModalBottomSheet<ProtocolPeptide>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _PeptideConfigSheet(initial: draft),
  );
}

Future<ProtocolPeptide?> _editPeptide(
    BuildContext context, ProtocolPeptide p) async {
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
                    borderRadius: BorderRadius.circular(AppSpacing.sheetHandleHeight),
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
                    horizontal: AppSpacing.inputPadding),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded,
                        color: AppColors.textTertiary,
                        size: AppSpacing.iconMedium),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _query = v),
                        style: AppTypography.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'Search peptides...',
                          hintStyle: AppTypography.bodyMedium
                              .copyWith(color: AppColors.textDisabled),
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
                  itemCount: peptides.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) {
                    final p = peptides[i];
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
                                Text(p.category.label,
                                    style: AppTypography.bodySmall),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              color: AppColors.textTertiary,
                              size: AppSpacing.iconMedium),
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
  late final TextEditingController _doseCtrl;
  late String _unit;
  late String _frequency;
  late String _route;
  late String _time;

  @override
  void initState() {
    super.initState();
    _doseCtrl = TextEditingController(
        text: _formatAmount(widget.initial.dosePerInjection));
    _unit = widget.initial.doseUnit;
    _frequency = widget.initial.frequency;
    _route = widget.initial.route;
    _time = widget.initial.scheduledTimes.isEmpty
        ? '08:00'
        : widget.initial.scheduledTimes.first;
  }

  @override
  void dispose() {
    _doseCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final dose = double.tryParse(_doseCtrl.text) ?? widget.initial.dosePerInjection;
    final updated = widget.initial
      ..dosePerInjection = dose
      ..doseUnit = _unit
      ..frequency = _frequency
      ..route = _route
      ..scheduledTimes = [_time];
    Navigator.of(context).pop(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.sheetRadius)),
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
                            AppSpacing.sheetHandleHeight),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('CONFIG.PEPTIDE', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Text(widget.initial.peptideName,
                      style: AppTypography.h2),
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
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))
                            ],
                            style: AppTypography.heroSmall.copyWith(fontSize: 18),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              filled: false,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.cardGap),
                      Expanded(
                        child: _FieldLabel(
                          label: 'UNIT',
                          child: _SegmentedToggle(
                            options: const ['mcg', 'mg'],
                            selected: _unit,
                            onSelect: (v) => setState(() => _unit = v),
                          ),
                        ),
                      ),
                    ],
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
                          onTap: () => setState(() => _frequency = f.key),
                        ),
                    ],
                  ),
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

                  // Time
                  _FieldLabel(
                    label: 'TIME',
                    child: InkWell(
                      onTap: () async {
                        final parts = _time.split(':');
                        final initial = TimeOfDay(
                          hour: int.tryParse(parts[0]) ?? 8,
                          minute: int.tryParse(parts[1]) ?? 0,
                        );
                        final t = await showTimePicker(
                            context: context, initialTime: initial);
                        if (t != null) {
                          setState(() => _time =
                              '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md, vertical: 14),
                        child: Text(_time,
                            style:
                                AppTypography.tabular.copyWith(fontSize: 18)),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  PrimaryButton(label: 'SAVE', onPressed: _save),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel',
                        style: AppTypography.labelMedium
                            .copyWith(color: AppColors.textTertiary)),
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
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
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
