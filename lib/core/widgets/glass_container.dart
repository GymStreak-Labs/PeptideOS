import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// A frosted-glass surface container.
/// Core building block of the PeptideOS glassmorphism design.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.blur = 24,
    this.opacity = 0.1,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double blur;
  final double opacity;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(AppSpacing.cardRadius);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(AppSpacing.cardPadding),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: opacity),
            borderRadius: radius,
            border: Border.all(
              color: borderColor ?? AppColors.glassBorder,
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
