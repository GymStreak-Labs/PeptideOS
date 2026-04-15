import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/theme.dart';

/// Tab item definition for [GlassTabBar].
class GlassTabItem {
  const GlassTabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// Custom floating cyberpunk glass tab bar.
/// Deep navy base with cyan border glow on active state.
class GlassTabBar extends StatelessWidget {
  const GlassTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<GlassTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Positioned(
      left: AppSpacing.screenHorizontal,
      right: AppSpacing.screenHorizontal,
      bottom: bottomPadding + AppSpacing.sm,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.base),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppSpacing.tabBarBlur,
            sigmaY: AppSpacing.tabBarBlur,
          ),
          child: Container(
            height: AppSpacing.tabBarHeight,
            decoration: BoxDecoration(
              color: AppColors.glassNavBar,
              borderRadius: BorderRadius.circular(AppSpacing.base),
              border: Border.all(color: AppColors.border, width: 1),
              // Subtle cyan glow underneath
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isActive = index == currentIndex;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (index != currentIndex) {
                        HapticFeedback.selectionClick();
                        onTap(index);
                      }
                    },
                    child: _TabItem(
                      item: item,
                      isActive: isActive,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.item,
    required this.isActive,
  });

  final GlassTabItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: Curves.easeOut,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Active indicator line above icon
          AnimatedContainer(
            duration: AppDurations.fast,
            width: isActive ? 20 : 0,
            height: 2,
            margin: const EdgeInsets.only(bottom: AppSpacing.xs),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.6),
                        blurRadius: 6,
                      ),
                    ]
                  : null,
            ),
          ),
          AnimatedSwitcher(
            duration: AppDurations.fast,
            child: Icon(
              isActive ? item.activeIcon : item.icon,
              key: ValueKey(isActive),
              size: AppSpacing.iconDefault,
              color: isActive ? AppColors.primary : AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.label.toUpperCase(),
            style: AppTypography.tabLabel.copyWith(
              color: isActive ? AppColors.primary : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
