import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/theme.dart';

/// Primary action button with haptic feedback.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isDestructive = false,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isDestructive;
  final bool expanded;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.instant,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails _) => _controller.forward();
  void _handleTapUp(TapUpDetails _) => _controller.reverse();
  void _handleTapCancel() => _controller.reverse();

  void _handleTap() {
    HapticFeedback.lightImpact();
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDestructive ? AppColors.danger : AppColors.primary;
    final enabled = widget.onPressed != null && !widget.isLoading;

    return GestureDetector(
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: enabled ? _handleTap : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          height: AppSpacing.buttonHeight,
          constraints: widget.expanded
              ? const BoxConstraints(minWidth: double.infinity)
              : null,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonHorizontalPadding,
          ),
          decoration: BoxDecoration(
            color: enabled ? bgColor : bgColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textInverse,
                    ),
                  )
                : Row(
                    mainAxisSize:
                        widget.expanded ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: AppSpacing.iconMedium,
                          color: AppColors.textInverse,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                      ],
                      Text(
                        widget.label,
                        style: AppTypography.button.copyWith(
                          color: AppColors.textInverse,
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
