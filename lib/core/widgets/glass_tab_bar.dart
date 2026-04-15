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

/// Custom floating frosted-glass tab bar.
/// Identical appearance on iOS and Android.
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
        borderRadius: BorderRadius.circular(AppSpacing.xl),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppSpacing.tabBarBlur,
            sigmaY: AppSpacing.tabBarBlur,
          ),
          child: Container(
            height: AppSpacing.tabBarHeight,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(AppSpacing.xl),
              border: Border.all(color: AppColors.glassBorder, width: 1),
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
            item.label,
            style: AppTypography.tabLabel.copyWith(
              color: isActive ? AppColors.primary : AppColors.textTertiary,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
