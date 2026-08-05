import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/custom_compound_repository.dart';
import 'package:peptide_os/features/library/providers/custom_compound_provider.dart';
import 'package:peptide_os/features/library/screens/custom_compound_library_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/custom_compound.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
    'custom compound library phone layout has a legible primary CTA',
    (tester) async {
      final displayFont = FontLoader('SpaceGrotesk')
        ..addFont(rootBundle.load('assets/fonts/SpaceGrotesk.ttf'));
      final monoFont = FontLoader('JetBrainsMono')
        ..addFont(rootBundle.load('assets/fonts/JetBrainsMono.ttf'));
      final iconFont = FontLoader('MaterialIcons')
        ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
      await Future.wait([displayFont.load(), monoFont.load(), iconFont.load()]);

      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final provider = CustomCompoundProvider(
        _PreviewStore(),
        uid: 'visual-user',
      );
      addTearDown(provider.dispose);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.dark,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const CustomCompoundLibraryScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(find.text('ADD COMPOUND'));
      expect(label.style?.color, AppColors.background);

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('goldens/custom_compounds_phone.png'),
      );
    },
  );
}

class _PreviewStore implements CustomCompoundStore {
  _PreviewStore();

  final _controller = StreamController<List<CustomCompound>>.broadcast(
    sync: true,
  );

  final _compounds = [
    CustomCompound(
      id: 'recovery',
      name: 'Recovery vial',
      vialAmount: 10,
      vialUnit: 'mg',
      trackingUnit: 'mcg',
      route: 'subcutaneous',
      createdAt: DateTime.utc(2026, 7, 25),
      updatedAt: DateTime.utc(2026, 7, 25),
    ),
    CustomCompound(
      id: 'travel',
      name: 'Travel vial',
      vialAmount: 5,
      vialUnit: 'mg',
      trackingUnit: 'mcg',
      route: 'subcutaneous',
      createdAt: DateTime.utc(2026, 7, 25),
      updatedAt: DateTime.utc(2026, 7, 25),
    ),
  ];

  @override
  Stream<List<CustomCompound>> watchAll(String uid) async* {
    yield _compounds;
    yield* _controller.stream;
  }

  @override
  Future<void> upsert(String uid, CustomCompound compound) async {}
}
