import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Reusable empty-state tile — cyan glow icon, title, description, optional CTA.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.12),
            border: Border.all(color: AppColors.borderCyan, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 16,
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.primary, size: 36),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(title, style: AppTypography.h2, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
          child: Text(
            description,
            style: AppTypography.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        if (actionLabel != null && onAction != null) ...[
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: actionLabel!,
            onPressed: onAction,
            expanded: false,
          ),
        ],
      ],
    );
  }
}
