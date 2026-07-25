import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/features/library/screens/reconstitution_screen.dart';
import 'package:peptide_os/models/conversion_workspace.dart';

void main() {
  testWidgets('phone layout visual proof', (tester) async {
    await _loadBundledFonts();
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: RepaintBoundary(
          key: const Key('workspace-golden'),
          child: ReconstitutionScreen(
            initialInput: const ConversionInput(
              vialAmountMg: 5,
              diluentVolumeMl: 2,
              desiredAmount: 250,
              desiredAmountUnit: ConversionAmountUnit.micrograms,
              syringe: ConversionSyringe.units100,
            ),
            savedCalculations: [
              SavedVialCalculation(
                id: 'saved-preview',
                createdAt: DateTime.utc(2026, 7, 25),
                input: const ConversionInput(
                  vialAmountMg: 10,
                  diluentVolumeMl: 2,
                  desiredAmount: 0.5,
                  desiredAmountUnit: ConversionAmountUnit.milligrams,
                  syringe: ConversionSyringe.units50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(const Key('workspace-golden')),
      matchesGoldenFile('goldens/conversion_workspace_top.png'),
    );

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -900),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(const Key('workspace-golden')),
      matchesGoldenFile('goldens/conversion_workspace_result.png'),
    );
    expect(tester.takeException(), isNull);
  });
}

Future<void> _loadBundledFonts() async {
  for (final entry in const {
    'SpaceGrotesk': 'assets/fonts/SpaceGrotesk.ttf',
    'JetBrainsMono': 'assets/fonts/JetBrainsMono.ttf',
    'MaterialIcons': 'fonts/MaterialIcons-Regular.otf',
  }.entries) {
    final loader = FontLoader(entry.key)..addFont(rootBundle.load(entry.value));
    await loader.load();
  }
}
