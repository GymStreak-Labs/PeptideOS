import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/services/analytics_service.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../providers/subscription_provider.dart';

/// Simple bottom-sheet paywall shown when a free-tier user hits the peptide
/// or protocol cap. The heavy onboarding paywall is reserved for first open —
/// this is the in-app "upgrade to unlock more" prompt.
///
/// Returns `true` if the user successfully purchased, `false` otherwise.
Future<bool> showSoftPaywall(
  BuildContext context, {
  required String source,
  required String reason,
}) async {
  AnalyticsService().logPaywallViewed(source);
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _SoftPaywallSheet(source: source, reason: reason),
  );
  return result ?? false;
}

class _SoftPaywallSheet extends StatefulWidget {
  const _SoftPaywallSheet({required this.source, required this.reason});

  final String source;
  final String reason;

  @override
  State<_SoftPaywallSheet> createState() => _SoftPaywallSheetState();
}

class _SoftPaywallSheetState extends State<_SoftPaywallSheet> {
  bool _busy = false;

  Future<void> _subscribe() async {
    if (_busy) return;
    setState(() => _busy = true);
    final sub = context.read<SubscriptionProvider>();
    if (sub.offerings == null) {
      await sub.loadOfferings();
    }
    if (!mounted) return;

    final pkg = sub.defaultUpgradePackage;

    if (pkg == null) {
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Upgrade is not available right now. Please try again later.',
          ),
        ),
      );
      return;
    }

    AnalyticsService().logPurchaseInitiated(pkg.identifier);
    final result = await sub.purchase(pkg);
    if (!mounted) return;
    setState(() => _busy = false);

    if (result.success) {
      Navigator.of(context).pop(true);
    } else if (result.cancelled) {
      // user backed out — leave the sheet open
    } else if (result.error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.error!)));
    }
  }

  Future<void> _restore() async {
    if (_busy) return;
    setState(() => _busy = true);
    final sub = context.read<SubscriptionProvider>();
    final result = await sub.restore();
    if (!mounted) return;
    setState(() => _busy = false);
    if (result.success && result.isPremium) {
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.error ?? 'No purchases found to restore.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.xl,
        AppSpacing.screenHorizontal,
        bottomInset + AppSpacing.xl,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.sheetRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          const SizedBox(height: AppSpacing.xl),
          Text(
            'SYS.UPGRADE // PREMIUM',
            style: AppTypography.systemLabel,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Unlock the full protocol',
            style: AppTypography.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.reason,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          const _Feature(label: 'Unlimited peptides per protocol'),
          const _Feature(label: 'Multiple active protocols'),
          const _Feature(label: 'Reconstitution calculator (all peptides)'),
          const _Feature(label: 'Body metric tracking + charts'),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: _busy ? 'PROCESSING…' : 'UPGRADE NOW',
            isLoading: _busy,
            onPressed: _busy ? null : _subscribe,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: _busy ? null : _restore,
            child: Text(
              'Restore purchases',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: _busy
                ? null
                : () {
                    HapticFeedback.selectionClick();
                    Navigator.of(context).pop(false);
                  },
            child: Text(
              'Not right now',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.primary,
            size: AppSpacing.iconMedium,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
