import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Friendly profile step used to personalise onboarding copy.
class FirstNamePage extends StatefulWidget {
  const FirstNamePage({
    super.key,
    required this.firstName,
    required this.onChanged,
    required this.onNext,
  });

  final String firstName;
  final ValueChanged<String> onChanged;
  final VoidCallback onNext;

  @override
  State<FirstNamePage> createState() => _FirstNamePageState();
}

class _FirstNamePageState extends State<FirstNamePage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.firstName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canContinue => _controller.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              0,
              AppSpacing.screenHorizontal,
              MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xxl,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.huge),
                    Text(
                      'SYS.PROFILE // START',
                      style: AppTypography.systemLabel,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'What should\nwe call you?',
                      style: AppTypography.h1.copyWith(fontSize: 28),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'We’ll use this to make your protocol feel less like a spreadsheet and more like your own system.',
                      style: AppTypography.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _CyberInput(
                      controller: _controller,
                      label: 'FIRST NAME',
                      hint: 'Joe',
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) {
                        widget.onChanged(value.trim());
                        setState(() {});
                      },
                    ),
                    const Spacer(),
                    PrimaryButton(
                      label: 'CONTINUE',
                      onPressed: _canContinue ? widget.onNext : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      cursorColor: AppColors.primary,
      style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
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
