import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/dose_log.dart';
import '../../../models/protocol.dart';
import '../providers/dose_log_provider.dart';
import '../providers/protocol_provider.dart';
import 'peptide_label_color.dart';
import 'protocol_localizations.dart';

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
  Future<DoseLog?>? _lastInjectionFuture;
  bool _didLocalizeInitialAmount = false;

  double get _displayAmount => widget.dose.blendSnapshot == null
      ? widget.dose.amountTaken
      : widget.dose.syringeUnits > 0
      ? widget.dose.syringeUnits
      : widget.dose.blendSnapshot!.drawSyringeUnits;

  @override
  void initState() {
    super.initState();
    _amountCtrl = TextEditingController(
      text: _displayAmount.toStringAsFixed(
        _displayAmount == _displayAmount.roundToDouble() ? 0 : 2,
      ),
    );
    _notesCtrl = TextEditingController(text: widget.dose.notes);
    final d = widget.dose.takenAt ?? widget.dose.scheduledAt;
    _time = TimeOfDay(hour: d.hour, minute: d.minute);
    _site = widget.dose.injectionSite;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didLocalizeInitialAmount) {
      _amountCtrl.text = _formatAmount(context.protocolL10n, _displayAmount);
      _didLocalizeInitialAmount = true;
    }
    _lastInjectionFuture ??= context
        .read<DoseLogProvider>()
        .lastInjectionForPeptide(
          protocolPeptideUuid: widget.dose.protocolPeptideUuid,
          excludingDoseUuid: widget.dose.uuid,
        );
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _log() async {
    final amount = parseDecimalInput(_amountCtrl.text) ?? _displayAmount;
    final editedBlend = widget.dose.blendSnapshot?.copyWith(
      drawSyringeUnits: amount,
    );
    if (editedBlend != null && !editedBlend.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.protocolL10n.doseDrawInvalid)),
      );
      return;
    }
    final actualDay = widget.dose.takenAt ?? widget.dose.scheduledAt;
    final takenAt = DateTime(
      actualDay.year,
      actualDay.month,
      actualDay.day,
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
      SnackBar(content: Text(context.protocolL10n.doseGenericError)),
    );
  }

  String _labelColorForDose(List<Protocol> protocols) {
    for (final protocol in protocols) {
      for (final peptide in protocol.peptides) {
        if (peptide.uuid == widget.dose.protocolPeptideUuid) {
          return peptide.labelColorHex;
        }
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final alreadyLogged = widget.dose.isTaken || widget.dose.skipped;
    final labelColorHex = _labelColorForDose(
      context.watch<ProtocolProvider>().all,
    );
    final blendPreview = widget.dose.blendSnapshot?.copyWith(
      drawSyringeUnits: parseDecimalInput(_amountCtrl.text) ?? _displayAmount,
    );
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
                  Text(
                    alreadyLogged
                        ? context.protocolL10n.doseEditSystemLabel
                        : context.protocolL10n.doseLogSystemLabel,
                    style: AppTypography.systemLabel,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      PeptideLabelSwatch(hex: labelColorHex, size: 12),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          widget.dose.peptideName,
                          style: AppTypography.h2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Amount + units
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _LabeledField(
                          label: widget.dose.blendSnapshot != null
                              ? context.protocolL10n.doseDraw
                              : context.protocolL10n.doseAmount,
                          suffix: widget.dose.blendSnapshot != null
                              ? context.protocolL10n.doseUnits
                              : widget.dose.units,
                          child: Semantics(
                            label: widget.dose.blendSnapshot != null
                                ? context.protocolL10n.doseDraw
                                : context.protocolL10n.doseAmount,
                            textField: true,
                            child: TextField(
                              controller: _amountCtrl,
                              onChanged: blendPreview == null
                                  ? null
                                  : (_) => setState(() {}),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: const [decimalInputFormatter],
                              style: AppTypography.heroSmall.copyWith(
                                fontSize: 18,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
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
                      ),
                      const SizedBox(width: AppSpacing.cardGap),
                      Expanded(
                        flex: 3,
                        child: _LabeledField(
                          label: context.protocolL10n.doseTime,
                          child: Semantics(
                            button: true,
                            label: context.protocolL10n.doseChooseTime,
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
                                  _formatTime(context, _time),
                                  style: AppTypography.tabular.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),
                  if (blendPreview case final blend?) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.inputRadius,
                        ),
                        border: Border.all(color: AppColors.borderCyan),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.protocolL10n.doseBlendSnapshot,
                            style: AppTypography.systemLabel,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          if (!blend.isValid)
                            Text(
                              context.protocolL10n.doseDrawInvalid,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.warning,
                              ),
                            )
                          else
                            for (final item in blend.constituents)
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        style: AppTypography.bodySmall,
                                      ),
                                    ),
                                    Text(
                                      '${_formatAmount(context.protocolL10n, blend.amountPerDraw(item))} ${item.unit}',
                                      style: AppTypography.tabular.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  if (widget.dose.syringeUnits > 0) ...[
                    Text(
                      context.protocolL10n.doseSyringeUnitsRecorded(
                        _formatAmount(
                          context.protocolL10n,
                          widget.dose.syringeUnits,
                        ),
                      ),
                      style: AppTypography.bodySmall.copyWith(
                        fontFamily: 'JetBrainsMono',
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],

                  // Injection site rotator
                  Text(
                    context.protocolL10n.doseInjectionSite,
                    style: AppTypography.systemLabel,
                  ),
                  FutureBuilder<DoseLog?>(
                    future: _lastInjectionFuture,
                    builder: (context, snapshot) {
                      final lastInjection = snapshot.data;
                      if (lastInjection == null) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.xs),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.history_rounded,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Flexible(
                              child: Text(
                                context.protocolL10n.doseLastSite(
                                  _siteLabel(
                                    context.protocolL10n,
                                    lastInjection.injectionSite,
                                  ),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final s in kInjectionSites)
                        _SiteChip(
                          label: _siteLabel(context.protocolL10n, s.key),
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
                    label: context.protocolL10n.doseNotes,
                    child: Semantics(
                      label: context.protocolL10n.doseNotes,
                      textField: true,
                      child: TextField(
                        controller: _notesCtrl,
                        maxLines: 2,
                        style: AppTypography.bodyMedium,
                        decoration: InputDecoration(
                          hintText: context.protocolL10n.doseOptional,
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
                  ),

                  const SizedBox(height: AppSpacing.xl),
                  if (alreadyLogged) ...[
                    PrimaryButton(
                      label: context.protocolL10n.doseMarkPending,
                      onPressed: _undo,
                    ),
                    const SizedBox(height: AppSpacing.cardGap),
                  ],
                  PrimaryButton(
                    label: alreadyLogged
                        ? context.protocolL10n.doseSaveChanges
                        : context.protocolL10n.protocolLogDose,
                    icon: Icons.check_rounded,
                    onPressed: _log,
                  ),
                  const SizedBox(height: AppSpacing.cardGap),
                  TextButton(
                    onPressed: _skip,
                    child: Text(
                      context.protocolL10n.doseSkip,
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

  String _formatTime(BuildContext context, TimeOfDay time) =>
      MaterialLocalizations.of(context).formatTimeOfDay(
        time,
        alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
      );

  String _formatAmount(AppLocalizations l10n, double value) {
    final format = NumberFormat.decimalPattern(l10n.localeName)
      ..maximumFractionDigits = 2;
    return format.format(value);
  }

  String _siteLabel(AppLocalizations l10n, String key) =>
      localizedInjectionSiteLabel(l10n, key);
}

/// Recent completed/skipped dose records. Tapping a row reuses
/// [LogDoseSheet], which edits only the record's actual administration fields
/// and leaves its scheduled identity and protocol cross-references intact.
class DoseHistorySheet extends StatelessWidget {
  const DoseHistorySheet({super.key, required this.protocols});

  final List<Protocol> protocols;

  @override
  Widget build(BuildContext context) {
    final logs =
        context
            .watch<DoseLogProvider>()
            .recent30
            .where((dose) => dose.isTaken || dose.skipped)
            .toList()
          ..sort((a, b) => _recordedAt(b).compareTo(_recordedAt(a)));

    return Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SheetHandle(),
              const SizedBox(height: AppSpacing.lg),
              Text(
                context.protocolL10n.doseHistorySystemLabel,
                style: AppTypography.systemLabel,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                context.protocolL10n.doseHistoryTitle,
                style: AppTypography.h2,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.protocolL10n.doseHistoryBody,
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: logs.isEmpty
                    ? Center(
                        child: Text(
                          context.protocolL10n.doseHistoryEmpty,
                          style: AppTypography.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.separated(
                        itemCount: logs.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.cardGap),
                        itemBuilder: (context, index) => _DoseHistoryRow(
                          dose: logs[index],
                          onTap: () => _openEditor(context, logs[index]),
                        ),
                      ),
              ),
              if (protocols.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: context.protocolL10n.doseLogPrevious,
                  icon: Icons.add_rounded,
                  onPressed: () => _openPastDoseSheet(context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, DoseLog dose) async {
    HapticFeedback.lightImpact();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LogDoseSheet(dose: dose),
    );
  }

  Future<void> _openPastDoseSheet(BuildContext context) async {
    HapticFeedback.lightImpact();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LogPastDoseSheet(protocols: protocols),
    );
  }

  static DateTime _recordedAt(DoseLog dose) => dose.takenAt ?? dose.scheduledAt;
}

class _DoseHistoryRow extends StatelessWidget {
  const _DoseHistoryRow({required this.dose, required this.onTap});

  final DoseLog dose;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.protocolL10n;
    final recordedAt = dose.takenAt ?? dose.scheduledAt;
    final statusColor = dose.skipped
        ? AppColors.textTertiary
        : AppColors.primary;

    return AppCard(
      onTap: onTap,
      borderColor: dose.isTaken ? AppColors.borderCyan : AppColors.border,
      child: Row(
        children: [
          Icon(
            dose.skipped ? Icons.remove_rounded : Icons.check_rounded,
            color: statusColor,
            size: AppSpacing.iconMedium,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dose.peptideName, style: AppTypography.labelLarge),
                const SizedBox(height: 2),
                Text(
                  dose.skipped
                      ? l10n.doseHistorySkipped(
                          _formatDateTime(context, recordedAt),
                        )
                      : l10n.doseHistoryTaken(
                          _formatAmount(l10n, dose.amountTaken),
                          dose.units,
                          _formatDateTime(context, recordedAt),
                        ),
                  style: AppTypography.bodySmall.copyWith(
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
                if (dose.injectionSite.isNotEmpty)
                  Text(
                    localizedInjectionSiteLabel(l10n, dose.injectionSite),
                    style: AppTypography.bodySmall,
                  ),
              ],
            ),
          ),
          Text(
            l10n.doseEditAction,
            style: AppTypography.systemLabel.copyWith(
              color: AppColors.primary,
              fontSize: 9,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textTertiary,
            size: AppSpacing.iconMedium,
          ),
        ],
      ),
    );
  }

  static String _formatAmount(AppLocalizations l10n, double value) {
    final format = NumberFormat.decimalPattern(l10n.localeName)
      ..maximumFractionDigits = 2;
    return format.format(value);
  }

  static String _formatDateTime(BuildContext context, DateTime value) {
    final material = MaterialLocalizations.of(context);
    final time = material.formatTimeOfDay(
      TimeOfDay.fromDateTime(value),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
    return '${material.formatShortDate(value)} · $time';
  }
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
  bool _didLocalizeDefaults = false;

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
    if (_targets.isNotEmpty) _applyTargetDefaults(localeAware: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_targets.isNotEmpty && !_didLocalizeDefaults) {
      _applyTargetDefaults();
      _didLocalizeDefaults = true;
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _applyTargetDefaults({bool localeAware = true}) {
    final schedule = _target.peptide.scheduleForDate(
      protocolStart: _target.protocol.startDate,
      date: _date,
    );
    final amount =
        schedule?.dosePerInjection ?? _target.peptide.dosePerInjection;
    final time =
        _firstScheduledTime(schedule?.scheduledTimes) ??
        _firstScheduledTime(_target.peptide.scheduledTimes);
    _amountCtrl.text = localeAware
        ? _formatAmount(context.protocolL10n, amount)
        : amount.toString();
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
      (parseDecimalInput(_amountCtrl.text) ?? 0) > 0;

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
    final amount =
        parseDecimalInput(_amountCtrl.text) ?? _target.peptide.dosePerInjection;
    final blendSnapshot = _target.peptide.blendVial?.copyWith(
      drawSyringeUnits: amount,
    );
    if (blendSnapshot != null && !blendSnapshot.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.protocolL10n.doseDrawInvalid)),
      );
      return;
    }
    final loggedAt = DateTime(
      _date.year,
      _date.month,
      _date.day,
      _time.hour,
      _time.minute,
    );
    if (loggedAt.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.protocolL10n.doseChoosePastTime)),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      await context.read<DoseLogProvider>().logAdHoc(
        protocolUuid: _target.protocol.uuid,
        protocolPeptideUuid: _target.peptide.uuid,
        peptideName: _target.peptide.peptideName,
        amount: amount,
        units: _units,
        syringeUnits: _syringeUnits,
        injectionSite: _site,
        notes: _notesCtrl.text,
        scheduledAt: loggedAt,
        takenAt: loggedAt,
        blendSnapshot: blendSnapshot,
      );
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.protocolL10n.dosePreviousError)),
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
        Text(
          context.protocolL10n.doseLogPreviousSystemLabel,
          style: AppTypography.systemLabel,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(context.protocolL10n.doseNoPeptides, style: AppTypography.h2),
        const SizedBox(height: AppSpacing.base),
        Text(
          context.protocolL10n.doseNoPeptidesBody,
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
          Text(
            context.protocolL10n.doseLogPreviousSystemLabel,
            style: AppTypography.systemLabel,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            context.protocolL10n.doseCorrectHistory,
            style: AppTypography.h2,
          ),
          const SizedBox(height: AppSpacing.lg),
          _LabeledField(
            label: context.protocolL10n.dosePeptide,
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
                  label: context.protocolL10n.doseDate,
                  child: Semantics(
                    button: true,
                    label: context.protocolL10n.doseChooseDate,
                    child: InkWell(
                      onTap: _pickDate,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: 14,
                        ),
                        child: Text(
                          MaterialLocalizations.of(
                            context,
                          ).formatShortDate(_date),
                          style: AppTypography.tabular.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.cardGap),
              Expanded(
                child: _LabeledField(
                  label: context.protocolL10n.doseTime,
                  child: Semantics(
                    button: true,
                    label: context.protocolL10n.doseChooseTime,
                    child: InkWell(
                      onTap: _pickTime,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: 14,
                        ),
                        child: Text(
                          _formatTime(context, _time),
                          style: AppTypography.tabular.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _LabeledField(
            label: context.protocolL10n.doseAmount,
            suffix: _units,
            child: Semantics(
              label: context.protocolL10n.doseAmount,
              textField: true,
              child: TextField(
                controller: _amountCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: const [decimalInputFormatter],
                style: AppTypography.heroSmall.copyWith(fontSize: 18),
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
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
          if (_syringeUnits > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.protocolL10n.doseSyringeUnitsEntry(
                _formatAmount(context.protocolL10n, _syringeUnits),
              ),
              style: AppTypography.bodySmall.copyWith(
                fontFamily: 'JetBrainsMono',
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.protocolL10n.doseInjectionSite,
            style: AppTypography.systemLabel,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final s in kInjectionSites)
                _SiteChip(
                  label: localizedInjectionSiteLabel(
                    context.protocolL10n,
                    s.key,
                  ),
                  selected: _site == s.key,
                  onTap: () =>
                      setState(() => _site = _site == s.key ? '' : s.key),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _LabeledField(
            label: context.protocolL10n.doseNotes,
            child: Semantics(
              label: context.protocolL10n.doseNotes,
              textField: true,
              child: TextField(
                controller: _notesCtrl,
                maxLines: 2,
                style: AppTypography.bodyMedium,
                decoration: InputDecoration(
                  hintText: context.protocolL10n.doseOptional,
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
          ),
          const SizedBox(height: AppSpacing.base),
          Text(
            context.protocolL10n.doseHistoryDisclaimer,
            style: AppTypography.disclaimer,
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: context.protocolL10n.doseLogPrevious,
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

  String _formatAmount(AppLocalizations l10n, double value) {
    final format = NumberFormat.decimalPattern(l10n.localeName)
      ..maximumFractionDigits = 2;
    return format.format(value);
  }

  String _formatTime(BuildContext context, TimeOfDay time) =>
      MaterialLocalizations.of(context).formatTimeOfDay(
        time,
        alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
      );
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
    return Semantics(
      button: true,
      selected: selected,
      label: label,
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
          child: ExcludeSemantics(
            child: Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: selected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
