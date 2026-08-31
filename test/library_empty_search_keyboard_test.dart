import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/core/widgets/widgets.dart';
import 'package:peptide_os/data/repositories/custom_compound_repository.dart';
import 'package:peptide_os/data/repositories/peptide_library_repository.dart';
import 'package:peptide_os/data/repositories/user_settings_repository.dart';
import 'package:peptide_os/features/library/providers/custom_compound_provider.dart';
import 'package:peptide_os/features/library/providers/peptide_provider.dart';
import 'package:peptide_os/features/library/screens/library_screen.dart';
import 'package:peptide_os/features/profile/providers/settings_provider.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // iPhone-class metrics: 390x844 logical, 34pt home-indicator safe area,
  // 336pt software keyboard.
  const Size phoneSize = Size(390, 844);
  const double safeAreaBottom = 34;
  const double keyboardHeight = 336;

  Future<void> pumpLibraryShell(WidgetTester tester) async {
    // Real fonts, matching device metrics — the flutter_test Ahem fallback
    // renders every glyph square and roughly doubles text width.
    final displayFont = FontLoader('SpaceGrotesk')
      ..addFont(rootBundle.load('assets/fonts/SpaceGrotesk.ttf'));
    final monoFont = FontLoader('JetBrainsMono')
      ..addFont(rootBundle.load('assets/fonts/JetBrainsMono.ttf'));
    await Future.wait([displayFont.load(), monoFont.load()]);

    tester.view.physicalSize = phoneSize;
    tester.view.devicePixelRatio = 1;
    tester.view.padding = const FakeViewPadding(bottom: safeAreaBottom);
    tester.view.viewPadding = const FakeViewPadding(bottom: safeAreaBottom);
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      tester.view.resetPadding();
      tester.view.resetViewPadding();
      tester.view.resetViewInsets();
    });

    final firestore = FakeFirebaseFirestore();
    final peptideProvider = PeptideProvider(
      PeptideLibraryRepository(firestore: firestore),
    );
    final settingsProvider = SettingsProvider(
      UserSettingsRepository(firestore: firestore),
      uid: '',
    );
    final compoundProvider = CustomCompoundProvider(
      FirestoreCustomCompoundRepository(firestore: firestore),
      uid: 'user-1',
    );
    addTearDown(peptideProvider.dispose);
    addTearDown(settingsProvider.dispose);
    addTearDown(compoundProvider.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: peptideProvider),
          ChangeNotifierProvider.value(value: settingsProvider),
          ChangeNotifierProvider.value(value: compoundProvider),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // Mirrors AppShell: tab content + floating glass tab bar in one
          // Scaffold body Stack, so tab-bar occlusion is reproduced.
          home: Scaffold(
            body: Stack(
              children: [
                const LibraryScreen(),
                GlassTabBar(
                  items: const [
                    GlassTabItem(
                      icon: Icons.science_outlined,
                      activeIcon: Icons.science_rounded,
                      label: 'Library',
                    ),
                  ],
                  currentIndex: 0,
                  onTap: (_) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'empty-search CTA and blend hint stay reachable with the keyboard open',
    (tester) async {
      await pumpLibraryShell(tester);

      // Focus the search field and raise the software keyboard.
      await tester.tap(find.byType(TextField).first);
      tester.view.viewInsets = const FakeViewPadding(bottom: keyboardHeight);
      await tester.enterText(find.byType(TextField).first, 'Wolverine');
      await tester.pumpAndSettle();

      final cta = find.text('Create custom compound');
      final hint = find.textContaining('no standard formulation');
      expect(cta, findsOneWidget);
      expect(hint, findsOneWidget);
      expect(
        find.text('Convert vial math now'),
        findsNothing,
        reason:
            'Unrelated tools collapse while an empty keyboard search is active',
      );
      expect(find.text('All'), findsNothing);

      // Empty-search mode collapses unrelated tools and filters while the
      // keyboard is open. One ordinary swipe (not keyboard dismissal) must
      // bring both actions fully above the keyboard and floating tab bar.
      final scrollable = find.byType(Scrollable).first;
      await tester.drag(scrollable, const Offset(0, -440));
      await tester.pumpAndSettle();

      final keyboardTop = phoneSize.height - keyboardHeight;
      final tabBar = find.byType(GlassTabBar);
      final obstructionTop = tabBar.evaluate().isEmpty
          ? keyboardTop
          : tester.getTopLeft(tabBar).dy.clamp(0, keyboardTop).toDouble();

      expect(
        tester.getRect(cta).bottom,
        lessThanOrEqualTo(obstructionTop),
        reason:
            'Create custom compound CTA must be fully visible above the '
            'keyboard and floating tab bar after a normal scroll',
      );
      expect(
        tester.getRect(hint).bottom,
        lessThanOrEqualTo(obstructionTop),
        reason:
            'Vendor-blend hint must be fully visible above the keyboard and '
            'floating tab bar after a normal scroll',
      );

      // Query carryover survives: the CTA still routes into the custom
      // compound editor prefilled with the search term.
      await tester.tap(cta);
      await tester.pumpAndSettle();
      expect(find.text('New compound'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Wolverine'), findsOneWidget);
    },
  );
}
