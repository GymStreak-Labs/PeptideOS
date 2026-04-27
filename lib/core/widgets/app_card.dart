import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Standard content card for PepMod.
/// Dark surface with subtle border, no shadow. Press state lightens.
class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderColor,
    this.glowColor,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? borderColor;

  /// Optional glow colour for the card border (e.g., dose status).
  final Color? glowColor;
  final EdgeInsetsGeometry? margin;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveBorder = widget.glowColor ?? widget.borderColor ?? AppColors.border;

    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => setState(() => _pressed = true) : null,
      onTapUp: widget.onTap != null ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: widget.onTap != null ? () => setState(() => _pressed = false) : null,
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        curve: Curves.easeOut,
        margin: widget.margin,
        padding: widget.padding ?? const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: _pressed ? AppColors.inputFill : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: effectiveBorder, width: 1),
          boxShadow: widget.glowColor != null
              ? [
                  BoxShadow(
                    color: widget.glowColor!.withValues(alpha: 0.15),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: widget.child,
      ),
    );
  }
}
