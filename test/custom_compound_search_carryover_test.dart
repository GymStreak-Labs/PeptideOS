import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/custom_compound_repository.dart';
import 'package:peptide_os/data/repositories/peptide_library_repository.dart';
import 'package:peptide_os/data/repositories/user_settings_repository.dart';
import 'package:peptide_os/features/library/providers/custom_compound_provider.dart';
import 'package:peptide_os/features/library/providers/peptide_provider.dart';
import 'package:peptide_os/features/library/screens/custom_compound_library_screen.dart';
import 'package:peptide_os/features/library/screens/library_screen.dart';
import 'package:peptide_os/features/library/utils/library_labels.dart';
import 'package:peptide_os/features/profile/providers/settings_provider.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('blend alias detection', () {
    test('recognises popular vendor blend names case-insensitively', () {
      expect(isKnownBlendAlias('klow'), isTrue);
      expect(isKnownBlendAlias('GLOW'), isTrue);
      expect(isKnownBlendAlias('  Wolverine  '), isTrue);
      expect(isKnownBlendAlias('bpc-157'), isFalse);
      expect(isKnownBlendAlias(''), isFalse);
    });
  });

  Future<void> pumpLibrary(WidgetTester tester, {Widget? home}) async {
    // Real fonts, matching device metrics — the flutter_test Ahem fallback
    // renders every glyph square and roughly doubles text width.
    final displayFont = FontLoader('SpaceGrotesk')
      ..addFont(rootBundle.load('assets/fonts/SpaceGrotesk.ttf'));
    final monoFont = FontLoader('JetBrainsMono')
      ..addFont(rootBundle.load('assets/fonts/JetBrainsMono.ttf'));
    await Future.wait([displayFont.load(), monoFont.load()]);

    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
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
          home: Scaffold(body: home ?? const LibraryScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'blend-name search offers custom compound creation with the query '
    'carried into the editor',
    (tester) async {
      await pumpLibrary(tester);

      await tester.enterText(find.byType(TextField).first, 'klow');
      await tester.pumpAndSettle();

      // No invented KLOW preset — the empty state routes to self-creation.
      expect(find.text('Create custom compound'), findsOneWidget);
      expect(find.textContaining('no standard formulation'), findsOneWidget);

      await tester.tap(find.text('Create custom compound'));
      await tester.pumpAndSettle();

      // The editor opens directly with the search term prefilled as name.
      expect(find.text('New compound'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'klow'), findsOneWidget);
    },
  );

  testWidgets(
    'non-blend search still offers creation but without the blend hint',
    (tester) async {
      await pumpLibrary(tester);

      await tester.enterText(find.byType(TextField).first, 'my mystery vial');
      await tester.pumpAndSettle();

      expect(find.text('Create custom compound'), findsOneWidget);
      expect(find.textContaining('no standard formulation'), findsNothing);
    },
  );

  testWidgets('library results suppress the creation empty state', (
    tester,
  ) async {
    await pumpLibrary(tester);

    await tester.enterText(find.byType(TextField).first, 'BPC');
    await tester.pumpAndSettle();

    expect(find.text('BPC-157'), findsWidgets);
    expect(find.text('Create custom compound'), findsNothing);
  });

  testWidgets(
    'custom compound screen opens the editor prefilled via initialEditorName',
    (tester) async {
      await pumpLibrary(
        tester,
        home: const CustomCompoundLibraryScreen(initialEditorName: 'GLOW'),
      );

      expect(find.text('New compound'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'GLOW'), findsOneWidget);
    },
  );
}
