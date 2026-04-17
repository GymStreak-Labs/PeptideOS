import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/services/analytics_service.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/services/auth_service.dart';
import '../providers/auth_provider.dart';
import 'email_auth_screen.dart';

/// Gate shown after onboarding when no Firebase user is signed in.
///
/// The UID gives us attribution + cross-device sync — anonymous mode would
/// leak installs across the RevenueCat / AppRefer boundary, so we require
/// sign-in before the app shell loads.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _busy = false;
  String? _error;

  Future<void> _signInWithApple() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final auth = context.read<AuthProvider>().authService;
    try {
      unawaited(AnalyticsService().logSignInMethodSelected('apple'));
      await auth.signInWithApple();
      if (mounted) {
        unawaited(AnalyticsService().logAccountCreated('apple'));
      }
    } on AuthException catch (e) {
      if (!mounted) return;
      if (e.code != 'apple_sign_in_failed') {
        setState(() => _error = e.message);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Apple sign-in failed. Please try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final auth = context.read<AuthProvider>().authService;
    try {
      unawaited(AnalyticsService().logSignInMethodSelected('google'));
      await auth.signInWithGoogle();
      if (mounted) {
        unawaited(AnalyticsService().logAccountCreated('google'));
      }
    } on AuthException catch (e) {
      if (!mounted) return;
      if (e.code != 'google_sign_in_cancelled') {
        setState(() => _error = e.message);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = 'Google sign-in failed. Please try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _openEmailFlow() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EmailAuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              _HeaderIcon(),
              const SizedBox(height: AppSpacing.xl),
              Text('SYS.AUTH // REQUIRED',
                  style: AppTypography.systemLabel,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.sm),
              Text('Secure your protocol',
                  style: AppTypography.h1, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your protocols sync encrypted to your account so nothing '
                'is lost between devices.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (_error != null) ...[
                Text(
                  _error!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.warning,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              if (Platform.isIOS) ...[
                PrimaryButton(
                  label: 'SIGN IN WITH APPLE',
                  icon: Icons.apple_rounded,
                  isLoading: _busy,
                  onPressed: _busy ? null : _signInWithApple,
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              _GhostButton(
                label: 'CONTINUE WITH GOOGLE',
                icon: Icons.g_mobiledata_rounded,
                onPressed: _busy ? null : _signInWithGoogle,
              ),
              const SizedBox(height: AppSpacing.sm),
              _GhostButton(
                label: 'CONTINUE WITH EMAIL',
                icon: Icons.mail_outline_rounded,
                onPressed: _busy ? null : _openEmailFlow,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'By continuing you accept our Terms and Privacy Policy. '
                'PeptideOS is an educational tool — not medical advice.',
                style: AppTypography.disclaimer,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.25),
              blurRadius: 24,
            ),
          ],
        ),
        child: const Icon(Icons.lock_outline_rounded,
            color: AppColors.primary, size: 32),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return GestureDetector(
      onTap: enabled
          ? () {
              HapticFeedback.lightImpact();
              onPressed!();
            }
          : null,
      child: Container(
        height: AppSpacing.buttonHeight,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          border: Border.all(
            color: enabled
                ? AppColors.border
                : AppColors.border.withValues(alpha: 0.4),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: AppSpacing.iconMedium,
                  color: enabled
                      ? AppColors.textPrimary
                      : AppColors.textDisabled),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: AppTypography.button.copyWith(
                  color: enabled
                      ? AppColors.textPrimary
                      : AppColors.textDisabled,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void unawaited(Future<void> future) {}
