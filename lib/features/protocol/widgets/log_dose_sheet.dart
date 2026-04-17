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
      text: widget.dose.amountTaken
          .toStringAsFixed(widget.dose.amountTaken == widget.dose.amountTaken.roundToDouble() ? 0 : 2),
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
      await context.read<DoseLogProvider>().skipDose(widget.dose, notes: _notesCtrl.text);
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
                        borderRadius:
                            BorderRadius.circular(AppSpacing.sheetHandleHeight),
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
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[\d.]')),
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
                                    colorScheme: Theme.of(ctx).colorScheme.copyWith(
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
                                  horizontal: AppSpacing.md, vertical: 14),
                              child: Text(
                                _formatTime(_time),
                                style: AppTypography.tabular
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),

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
                          onTap: () => setState(() =>
                              _site = _site == s.key ? '' : s.key),
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
                        hintStyle: AppTypography.bodyMedium
                            .copyWith(color: AppColors.textDisabled),
                        border: InputBorder.none,
                        isDense: true,
                        filled: false,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),
                  if (alreadyLogged) ...[
                    PrimaryButton(
                      label: 'MARK AS PENDING',
                      onPressed: _undo,
                    ),
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
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.child,
    this.suffix,
  });

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
                  child: Text(suffix!, style: AppTypography.unit.copyWith(fontSize: 14)),
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
