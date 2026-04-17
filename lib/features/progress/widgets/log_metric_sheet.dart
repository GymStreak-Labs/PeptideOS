import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/body_metric.dart';
import '../providers/body_metric_provider.dart';

/// Bottom sheet for logging a body metric snapshot — weight, body fat,
/// plus optional waist / chest / arm measurements.
class LogMetricSheet extends StatefulWidget {
  const LogMetricSheet({super.key});

  @override
  State<LogMetricSheet> createState() => _LogMetricSheetState();
}

class _LogMetricSheetState extends State<LogMetricSheet> {
  final _weightCtrl = TextEditingController();
  final _bfCtrl = TextEditingController();
  final _waistCtrl = TextEditingController();
  final _chestCtrl = TextEditingController();
  final _armCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _weightCtrl.dispose();
    _bfCtrl.dispose();
    _waistCtrl.dispose();
    _chestCtrl.dispose();
    _armCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final weight = double.tryParse(_weightCtrl.text);
    final bf = double.tryParse(_bfCtrl.text);
    final waist = double.tryParse(_waistCtrl.text);
    final chest = double.tryParse(_chestCtrl.text);
    final arm = double.tryParse(_armCtrl.text);

    if (weight == null && bf == null && waist == null && chest == null && arm == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter at least one value.')),
      );
      return;
    }

    setState(() => _saving = true);
    final measurements = <MeasurementEntry>[];
    if (waist != null) {
      measurements.add(MeasurementEntry()
        ..key = 'waist'
        ..valueCm = waist);
    }
    if (chest != null) {
      measurements.add(MeasurementEntry()
        ..key = 'chest'
        ..valueCm = chest);
    }
    if (arm != null) {
      measurements.add(MeasurementEntry()
        ..key = 'arm'
        ..valueCm = arm);
    }

    try {
      await context.read<BodyMetricProvider>().logMetric(
            weightKg: weight,
            bodyFatPct: bf,
            measurements: measurements,
          );
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save. Try again.')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  Text('LOG.METRIC', style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Text('New Measurement', style: AppTypography.h2),
                  const SizedBox(height: AppSpacing.lg),

                  Row(
                    children: [
                      Expanded(
                        child: _Field(
                          label: 'WEIGHT',
                          suffix: 'kg',
                          controller: _weightCtrl,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.cardGap),
                      Expanded(
                        child: _Field(
                          label: 'BODY FAT',
                          suffix: '%',
                          controller: _bfCtrl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('MEASUREMENTS (cm)',
                      style: AppTypography.systemLabel),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: _Field(
                          label: 'WAIST',
                          suffix: 'cm',
                          controller: _waistCtrl,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.cardGap),
                      Expanded(
                        child: _Field(
                          label: 'CHEST',
                          suffix: 'cm',
                          controller: _chestCtrl,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.cardGap),
                      Expanded(
                        child: _Field(
                          label: 'ARM',
                          suffix: 'cm',
                          controller: _armCtrl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: 'SAVE',
                    icon: Icons.check_rounded,
                    onPressed: _saving ? null : _save,
                    isLoading: _saving,
                  ),
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

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.suffix,
    required this.controller,
  });
  final String label;
  final String suffix;
  final TextEditingController controller;

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
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))
                  ],
                  style: AppTypography.heroSmall.copyWith(fontSize: 17),
                  decoration: const InputDecoration(
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
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: Text(suffix,
                    style: AppTypography.unit.copyWith(fontSize: 13)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
