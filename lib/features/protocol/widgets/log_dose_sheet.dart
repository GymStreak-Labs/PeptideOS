import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/dose_log.dart';
import '../../../models/protocol.dart';
import '../providers/dose_log_provider.dart';

/// Bottom sheet that lets a user log / edit / skip a scheduled dose.
class LogDoseSheet extends StatefulWidget {
  const LogDoseSheet({super.key, required this.dose});

  final DoseLog dose;

  @override
  State<LogDoseSheet> createState() => _LogDoseSheetState();
}

class _LogDoseSheetState extends State<LogDoseSheet> {
  late final TextEditingController _amountCtrl;
  late final TextEditingController _notesCtrl;
  late TimeOfDay _time;
  late String _site;

  @override
  void initState() {
    super.initState();
    _amountCtrl = TextEditingController(
      text: widget.dose.amountTaken.toStringAsFixed(
        widget.dose.amountTaken == widget.dose.amountTaken.roundToDouble()
            ? 0
            : 2,
      ),
    );
    _notesCtrl = TextEditingController(text: widget.dose.notes);
    final d = widget.dose.takenAt ?? widget.dose.scheduledAt;
    _time = TimeOfDay(hour: d.hour, minute: d.minute);
    _site = widget.dose.injectionSite;
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _log() async {
    final amount = double.tryParse(_amountCtrl.text) ?? widget.dose.amountTaken;
    final scheduled = widget.dose.scheduledAt;
    final takenAt = DateTime(
      scheduled.year,
      scheduled.month,
      scheduled.day,
      _time.hour,
      _time.minute,
    );

    try {
      await context.read<DoseLogProvider>().logDose(
        widget.dose,
        takenAt: takenAt,
        amount: amount,
        site: _site,
        notes: _notesCtrl.text,
      );
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      Navigator.of(context).pop();
    } catch (_) {
      _showError();
    }
  }

  Future<void> _skip() async {
    try {
      await context.read<DoseLogProvider>().skipDose(
        widget.dose,
        notes: _notesCtrl.text,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      _showError();
    }
  }

  Future<void> _undo() async {
    try {
      await context.read<DoseLogProvider>().undoDose(widget.dose);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      _showError();
    }
  }

  void _showError() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Something went wrong. Try again.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final alreadyLogged = widget.dose.isTaken || widget.dose.skipped;
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
          border: Border.all(color: AppColors.border),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                  Text('LOG.DOSE', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Text(widget.dose.peptideName, style: AppTypography.h2),
                  const SizedBox(height: AppSpacing.lg),

                  // Amount + units
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _LabeledField(
                          label: 'AMOUNT',
                          suffix: widget.dose.units,
                          child: TextField(
                            controller: _amountCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[\d.]'),
                              ),
                            ],
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
                        flex: 3,
                        child: _LabeledField(
                          label: 'TIME',
                          child: InkWell(
                            onTap: () async {
                              final t = await showTimePicker(
                                context: context,
                                initialTime: _time,
                                builder: (ctx, child) => Theme(
                                  data: Theme.of(ctx).copyWith(
                                    colorScheme: Theme.of(ctx).colorScheme
                                        .copyWith(
                                          primary: AppColors.primary,
                                          surface: AppColors.surfaceContainer,
                                        ),
                                  ),
                                  child: child ?? const SizedBox.shrink(),
                                ),
                              );
                              if (t != null) setState(() => _time = t);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: 14,
                              ),
                              child: Text(
                                _formatTime(_time),
                                style: AppTypography.tabular.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),
                  if (widget.dose.syringeUnits > 0) ...[
                    Text(
                      '${_formatAmount(widget.dose.syringeUnits)} syringe units recorded for this dose.',
                      style: AppTypography.bodySmall.copyWith(
                        fontFamily: 'JetBrainsMono',
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],

                  // Injection site rotator
                  Text('INJECTION.SITE', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final s in kInjectionSites)
                        _SiteChip(
                          label: s.label,
                          selected: _site == s.key,
                          onTap: () => setState(
                            () => _site = _site == s.key ? '' : s.key,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Notes
                  _LabeledField(
                    label: 'NOTES',
                    child: TextField(
                      controller: _notesCtrl,
                      maxLines: 2,
                      style: AppTypography.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Optional...',
                        hintStyle: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textDisabled,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        filled: false,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),
                  if (alreadyLogged) ...[
                    PrimaryButton(label: 'MARK AS PENDING', onPressed: _undo),
                    const SizedBox(height: AppSpacing.cardGap),
                  ],
                  PrimaryButton(
                    label: 'LOG DOSE',
                    icon: Icons.check_rounded,
                    onPressed: _log,
                  ),
                  const SizedBox(height: AppSpacing.cardGap),
                  TextButton(
                    onPressed: _skip,
                    child: Text(
                      'Skip this dose',
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

  String _formatTime(TimeOfDay t) {
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  String _formatAmount(double d) =>
      d == d.roundToDouble() ? d.toStringAsFixed(0) : d.toStringAsFixed(2);
}

class LogPastDoseSheet extends StatefulWidget {
  const LogPastDoseSheet({super.key, required this.protocols});

  final List<Protocol> protocols;

  @override
  State<LogPastDoseSheet> createState() => _LogPastDoseSheetState();
}

class _LogPastDoseSheetState extends State<LogPastDoseSheet> {
  late final TextEditingController _amountCtrl;
  late final TextEditingController _notesCtrl;
  late final List<_PastDoseTarget> _targets;
  late DateTime _date;
  late TimeOfDay _time;
  int _selectedIndex = 0;
  String _site = '';
  bool _saving = false;

  _PastDoseTarget get _target => _targets[_selectedIndex];

  @override
  void initState() {
    super.initState();
    _targets = [
      for (final protocol in widget.protocols)
        for (final peptide in protocol.peptides)
          _PastDoseTarget(protocol: protocol, peptide: peptide),
    ];
    final now = DateTime.now();
    _date = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(const Duration(days: 1));
    _amountCtrl = TextEditingController();
    _notesCtrl = TextEditingController();
    _time = TimeOfDay(hour: now.hour, minute: now.minute);
    if (_targets.isNotEmpty) _applyTargetDefaults();
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _applyTargetDefaults() {
    final schedule = _target.peptide.scheduleForDate(
      protocolStart: _target.protocol.startDate,
      date: _date,
    );
    final amount =
        schedule?.dosePerInjection ?? _target.peptide.dosePerInjection;
    final time =
        _firstScheduledTime(schedule?.scheduledTimes) ??
        _firstScheduledTime(_target.peptide.scheduledTimes);
    _amountCtrl.text = _formatAmount(amount);
    if (time != null) _time = _parseTime(time);
  }

  String get _units {
    final schedule = _target.peptide.scheduleForDate(
      protocolStart: _target.protocol.startDate,
      date: _date,
    );
    return schedule?.doseUnit ?? _target.peptide.doseUnit;
  }

  double get _syringeUnits {
    final schedule = _target.peptide.scheduleForDate(
      protocolStart: _target.protocol.startDate,
      date: _date,
    );
    return schedule?.syringeUnits ?? _target.peptide.syringeUnits;
  }

  bool get _canSave =>
      _targets.isNotEmpty &&
      !_saving &&
      (double.tryParse(_amountCtrl.text) ?? 0) > 0;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: today.subtract(const Duration(days: 30)),
      lastDate: today,
    );
    if (picked == null) return;
    setState(() {
      _date = picked;
      _applyTargetDefaults();
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(ctx).colorScheme.copyWith(
            primary: AppColors.primary,
            surface: AppColors.surfaceContainer,
          ),
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _save() async {
    if (!_canSave) return;
    final loggedAt = DateTime(
      _date.year,
      _date.month,
      _date.day,
      _time.hour,
      _time.minute,
    );
    if (loggedAt.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choose a past time to log.')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      await context.read<DoseLogProvider>().logAdHoc(
        protocolUuid: _target.protocol.uuid,
        protocolPeptideUuid: _target.peptide.uuid,
        peptideName: _target.peptide.peptideName,
        amount:
            double.tryParse(_amountCtrl.text) ??
            _target.peptide.dosePerInjection,
        units: _units,
        syringeUnits: _syringeUnits,
        injectionSite: _site,
        notes: _notesCtrl.text,
        scheduledAt: loggedAt,
        takenAt: loggedAt,
      );
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not log previous dose. Try again.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
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
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: _targets.isEmpty ? _emptyState(context) : _form(context),
          ),
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SheetHandle(),
        const SizedBox(height: AppSpacing.lg),
        Text('LOG.PREVIOUS', style: AppTypography.systemLabel),
        const SizedBox(height: AppSpacing.sm),
        Text('No peptides available', style: AppTypography.h2),
        const SizedBox(height: AppSpacing.base),
        Text(
          'Add a peptide to an active protocol before logging history.',
          style: AppTypography.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SheetHandle(),
          const SizedBox(height: AppSpacing.lg),
          Text('LOG.PREVIOUS', style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.sm),
          Text('Correct dose history', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.lg),
          _LabeledField(
            label: 'PEPTIDE',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _selectedIndex,
                  isExpanded: true,
                  dropdownColor: AppColors.surfaceContainer,
                  iconEnabledColor: AppColors.primary,
                  style: AppTypography.bodyMedium,
                  items: [
                    for (var i = 0; i < _targets.length; i++)
                      DropdownMenuItem<int>(
                        value: i,
                        child: Text(
                          '${_targets[i].peptide.peptideName} · ${_targets[i].protocol.name}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedIndex = value;
                      _applyTargetDefaults();
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _LabeledField(
                  label: 'DATE',
                  child: InkWell(
                    onTap: _pickDate,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 14,
                      ),
                      child: Text(
                        _formatDate(_date),
                        style: AppTypography.tabular.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.cardGap),
              Expanded(
                child: _LabeledField(
                  label: 'TIME',
                  child: InkWell(
                    onTap: _pickTime,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 14,
                      ),
                      child: Text(
                        _formatTime(_time),
                        style: AppTypography.tabular.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _LabeledField(
            label: 'AMOUNT',
            suffix: _units,
            child: TextField(
              controller: _amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
              ],
              style: AppTypography.heroSmall.copyWith(fontSize: 18),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              ),
            ),
          ),
          if (_syringeUnits > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${_formatAmount(_syringeUnits)} syringe units recorded for this entry.',
              style: AppTypography.bodySmall.copyWith(
                fontFamily: 'JetBrainsMono',
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Text('INJECTION.SITE', style: AppTypography.systemLabel),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final s in kInjectionSites)
                _SiteChip(
                  label: s.label,
                  selected: _site == s.key,
                  onTap: () =>
                      setState(() => _site = _site == s.key ? '' : s.key),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _LabeledField(
            label: 'NOTES',
            child: TextField(
              controller: _notesCtrl,
              maxLines: 2,
              style: AppTypography.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Optional...',
                hintStyle: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textDisabled,
                ),
                border: InputBorder.none,
                isDense: true,
                filled: false,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.base),
          Text(
            'Historical logs are personal tracking records only. They do not change medical guidance or dosing recommendations.',
            style: AppTypography.disclaimer,
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'LOG PREVIOUS DOSE',
            icon: Icons.history_rounded,
            isLoading: _saving,
            onPressed: _canSave ? _save : null,
          ),
        ],
      ),
    );
  }

  String? _firstScheduledTime(List<String>? times) {
    if (times == null || times.isEmpty) return null;
    return times.first;
  }

  TimeOfDay _parseTime(String value) {
    final parts = value.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 8,
      minute: int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0,
    );
  }

  String _formatAmount(double d) =>
      d == d.roundToDouble() ? d.toStringAsFixed(0) : d.toStringAsFixed(2);

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
    return '${months[d.month - 1]} ${d.day}';
  }

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class _PastDoseTarget {
  const _PastDoseTarget({required this.protocol, required this.peptide});

  final Protocol protocol;
  final ProtocolPeptide peptide;
}

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppSpacing.sheetHandleWidth,
        height: AppSpacing.sheetHandleHeight,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(AppSpacing.sheetHandleHeight),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child, this.suffix});

  final String label;
  final Widget child;
  final String? suffix;

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
          child: Row(
            children: [
              Expanded(child: child),
              if (suffix != null)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: Text(
                    suffix!,
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

class _SiteChip extends StatelessWidget {
  const _SiteChip({
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
