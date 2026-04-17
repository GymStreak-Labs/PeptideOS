import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/analytics_service.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/services/auth_service.dart';
import '../providers/auth_provider.dart';

/// Email / password sign-in & account creation flow. Pushed from
/// [AuthScreen] — the AuthProvider's stream will swap the app root once the
/// sign-in succeeds so we simply pop once Firebase reports success.
class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({super.key});

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

enum _Mode { signIn, createAccount, forgotPassword }

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _Mode _mode = _Mode.signIn;
  bool _busy = false;
  String? _error;
  String? _info;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _setMode(_Mode mode) {
    setState(() {
      _mode = mode;
      _error = null;
      _info = null;
    });
  }

  Future<void> _submit() async {
    if (_busy) return;
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    setState(() {
      _busy = true;
      _error = null;
      _info = null;
    });

    final auth = context.read<AuthProvider>().authService;
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      switch (_mode) {
        case _Mode.signIn:
          _logSelected('email_sign_in');
          await auth.signInWithEmail(email: email, password: password);
          break;
        case _Mode.createAccount:
          _logSelected('email_create');
          await auth.createAccountWithEmail(email: email, password: password);
          _logCreated('email');
          break;
        case _Mode.forgotPassword:
          await auth.sendPasswordResetEmail(email);
          if (mounted) {
            setState(() {
              _info = 'Password reset email sent. Check your inbox.';
            });
          }
          break;
      }
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = 'Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _logSelected(String method) {
    try {
      AnalyticsService().logSignInMethodSelected(method);
    } catch (_) {}
  }

  void _logCreated(String method) {
    try {
      AnalyticsService().logAccountCreated(method);
    } catch (_) {}
  }

  String get _title {
    switch (_mode) {
      case _Mode.signIn:
        return 'Sign in';
      case _Mode.createAccount:
        return 'Create account';
      case _Mode.forgotPassword:
        return 'Reset password';
    }
  }

  String get _submitLabel {
    switch (_mode) {
      case _Mode.signIn:
        return 'SIGN IN';
      case _Mode.createAccount:
        return 'CREATE ACCOUNT';
      case _Mode.forgotPassword:
        return 'SEND RESET LINK';
    }
  }

  String? _validateEmail(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Enter your email';
    if (!value.contains('@') || !value.contains('.')) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? v) {
    if (_mode == _Mode.forgotPassword) return null;
    final value = v ?? '';
    if (value.isEmpty) return 'Enter a password';
    if (value.length < 6) return 'At least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: AppColors.textPrimary),
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
        ),
        title: Text(_title, style: AppTypography.h3),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
              children: [
                Text('SYS.AUTH // ${_mode == _Mode.createAccount ? 'NEW_USER' : _mode == _Mode.forgotPassword ? 'RESET' : 'RETURN_USER'}',
                    style: AppTypography.systemLabel),
                const SizedBox(height: AppSpacing.sm),
                Text(_title, style: AppTypography.h1),
                const SizedBox(height: AppSpacing.lg),
                _EmailField(
                  controller: _emailController,
                  validator: _validateEmail,
                  enabled: !_busy,
                ),
                if (_mode != _Mode.forgotPassword) ...[
                  const SizedBox(height: AppSpacing.md),
                  _PasswordField(
                    controller: _passwordController,
                    validator: _validatePassword,
                    enabled: !_busy,
                    onSubmitted: (_) => _submit(),
                  ),
                ],
                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(_error!,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.warning)),
                ],
                if (_info != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(_info!,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.primary)),
                ],
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: _submitLabel,
                  isLoading: _busy,
                  onPressed: _busy ? null : _submit,
                ),
                const SizedBox(height: AppSpacing.md),
                if (_mode == _Mode.signIn)
                  _LinkRow(
                    items: [
                      _LinkItem(
                        label: 'Forgot password?',
                        onTap: () => _setMode(_Mode.forgotPassword),
                      ),
                      _LinkItem(
                        label: 'Create account',
                        onTap: () => _setMode(_Mode.createAccount),
                      ),
                    ],
                  ),
                if (_mode == _Mode.createAccount)
                  Center(
                    child: GestureDetector(
                      onTap: () => _setMode(_Mode.signIn),
                      child: Text(
                        'Already have an account? Sign in',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                if (_mode == _Mode.forgotPassword)
                  Center(
                    child: GestureDetector(
                      onTap: () => _setMode(_Mode.signIn),
                      child: Text(
                        'Back to sign in',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
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

class _EmailField extends StatelessWidget {
  const _EmailField({
    required this.controller,
    required this.validator,
    required this.enabled,
  });

  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      autofillHints: const [AutofillHints.email],
      style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
      cursorColor: AppColors.primary,
      decoration: _inputDecoration(
        label: 'Email',
        icon: Icons.alternate_email_rounded,
      ),
      validator: validator,
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.controller,
    required this.validator,
    required this.enabled,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool enabled;
  final ValueChanged<String> onSubmitted;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: _obscure,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      onFieldSubmitted: widget.onSubmitted,
      style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
      cursorColor: AppColors.primary,
      decoration: _inputDecoration(
        label: 'Password',
        icon: Icons.lock_outline_rounded,
      ).copyWith(
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.textSecondary,
            size: AppSpacing.iconMedium,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}

InputDecoration _inputDecoration({required String label, required IconData icon}) {
  return InputDecoration(
    labelText: label,
    labelStyle: AppTypography.bodyMedium
        .copyWith(color: AppColors.textSecondary),
    prefixIcon: Icon(icon, color: AppColors.textSecondary, size: AppSpacing.iconMedium),
    filled: true,
    fillColor: AppColors.surfaceContainer,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.inputPadding,
      vertical: AppSpacing.md,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
      borderSide: const BorderSide(color: AppColors.warning),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
      borderSide: const BorderSide(color: AppColors.warning, width: 1.5),
    ),
    errorStyle:
        AppTypography.bodySmall.copyWith(color: AppColors.warning),
  );
}

class _LinkItem {
  _LinkItem({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.items});
  final List<_LinkItem> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items
          .map((i) => GestureDetector(
                onTap: i.onTap,
                child: Text(
                  i.label,
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.primary),
                ),
              ))
          .toList(),
    );
  }
}
