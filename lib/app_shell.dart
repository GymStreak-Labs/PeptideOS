import 'package:flutter/material.dart';
import 'core/widgets/widgets.dart';
import 'features/protocol/screens/protocol_screen.dart';
import 'features/progress/screens/progress_screen.dart';
import 'features/library/screens/library_screen.dart';
import 'features/profile/screens/profile_screen.dart';

/// Main app shell with floating glass tab bar and tab content.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  static const _tabs = [
    GlassTabItem(
      icon: Icons.medical_services_outlined,
      activeIcon: Icons.medical_services_rounded,
      label: 'Protocol',
    ),
    GlassTabItem(
      icon: Icons.insights_outlined,
      activeIcon: Icons.insights_rounded,
      label: 'Progress',
    ),
    GlassTabItem(
      icon: Icons.science_outlined,
      activeIcon: Icons.science_rounded,
      label: 'Library',
    ),
    GlassTabItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'You',
    ),
  ];

  static const _screens = [
    ProtocolScreen(),
    ProgressScreen(),
    LibraryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Tab content ────────────────────────────────────────────
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: KeyedSubtree(
              key: ValueKey(_currentIndex),
              child: _screens[_currentIndex],
            ),
          ),

          // ── Floating glass tab bar ─────────────────────────────────
          GlassTabBar(
            items: _tabs,
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        ],
      ),
    );
  }
}
