import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Capture identity fields before the paywall so they can be replayed after
/// auth and sent to AppRefer advanced matching.
class ProfileIdentityPage extends StatefulWidget {
  const ProfileIdentityPage({
    super.key,
    required this.firstName,
    required this.birthDate,
    required this.onFirstNameChanged,
    required this.onBirthDateChanged,
    required this.onNext,
  });

  final String firstName;
  final String birthDate;
  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onBirthDateChanged;
  final VoidCallback onNext;

  @override
  State<ProfileIdentityPage> createState() => _ProfileIdentityPageState();
}

class _ProfileIdentityPageState extends State<ProfileIdentityPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _yearController;
  late final TextEditingController _monthController;
  late final TextEditingController _dayController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    final parts = widget.birthDate.split('-');
    _yearController = TextEditingController(
      text: parts.length == 3 ? parts[0] : '',
    );
    _monthController = TextEditingController(
      text: parts.length == 3 ? parts[1] : '',
    );
    _dayController = TextEditingController(
      text: parts.length == 3 ? parts[2] : '',
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  void _syncBirthDate() {
    final year = _yearController.text.trim();
    final month = _monthController.text.trim().padLeft(2, '0');
    final day = _dayController.text.trim().padLeft(2, '0');
    final candidate = '$year-$month-$day';
    widget.onBirthDateChanged(_isValidDate(candidate) ? candidate : '');
    setState(() {});
  }

  bool _isValidDate(String raw) {
    final parts = raw.split('-');
    if (parts.length != 3) return false;
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) return false;
    if (year < 1900 || month < 1 || month > 12 || day < 1 || day > 31) {
      return false;
    }
    final date = DateTime(year, month, day);
    if (date.year != year || date.month != month || date.day != day) {
      return false;
    }
    final now = DateTime.now();
    final eighteenthBirthday = DateTime(year + 18, month, day);
    return !eighteenthBirthday.isAfter(now);
  }

  bool get _canContinue =>
      _firstNameController.text.trim().isNotEmpty &&
      _isValidDate(
        '${_yearController.text.trim()}-'
        '${_monthController.text.trim().padLeft(2, '0')}-'
        '${_dayController.text.trim().padLeft(2, '0')}',
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.huge),
            Text('SYS.PROFILE // IDENTITY', style: AppTypography.systemLabel),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Let’s personalise\nyour protocol',
              style: AppTypography.h1.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'This helps us personalise your profile and improve attribution matching after sign-in.',
              style: AppTypography.bodySmall,
            ),
            const SizedBox(height: AppSpacing.xl),
            _CyberInput(
              controller: _firstNameController,
              label: 'FIRST NAME',
              hint: 'Joe',
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) {
                widget.onFirstNameChanged(value.trim());
                setState(() {});
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'DATE OF BIRTH',
              style: AppTypography.systemLabel.copyWith(
                color: AppColors.textTertiary,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _CyberInput(
                    controller: _yearController,
                    label: 'YEAR',
                    hint: '1990',
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) => _syncBirthDate(),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _CyberInput(
                    controller: _monthController,
                    label: 'MM',
                    hint: '04',
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) => _syncBirthDate(),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _CyberInput(
                    controller: _dayController,
                    label: 'DD',
                    hint: '23',
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) => _syncBirthDate(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              _canContinue
                  ? 'Stored as encrypted account profile data after sign-in.'
                  : 'Enter a valid 18+ birth date to continue.',
              style: AppTypography.disclaimer.copyWith(
                color: _canContinue ? AppColors.primary : AppColors.warning,
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: 'CONTINUE',
              onPressed: _canContinue ? widget.onNext : null,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _CyberInput extends StatelessWidget {
  const _CyberInput({
    required this.controller,
    required this.label,
    required this.hint,
    required this.onChanged,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLength,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      onChanged: onChanged,
      cursorColor: AppColors.primary,
      style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        counterText: '',
        labelText: label,
        hintText: hint,
        labelStyle: AppTypography.systemLabel.copyWith(
          color: AppColors.textTertiary,
          fontSize: 10,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textDisabled,
        ),
        filled: true,
        fillColor: AppColors.surfaceContainer,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
