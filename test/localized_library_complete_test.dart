import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/custom_compound_repository.dart';
import 'package:peptide_os/features/library/providers/custom_compound_provider.dart';
import 'package:peptide_os/features/library/screens/custom_compound_library_screen.dart';
import 'package:peptide_os/features/library/screens/reconstitution_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/conversion_workspace.dart';
import 'package:peptide_os/models/custom_compound.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('German personal library and editor fit a narrow phone', (
    tester,
  ) async {
    await _useNarrowPhone(tester);
    final provider = CustomCompoundProvider(_EmptyCompoundStore(), uid: 'u1');
    addTearDown(provider.dispose);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const _GermanHarness(home: CustomCompoundLibraryScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Meine Wirkstoffe'), findsOneWidget);
    expect(find.text('Keine gespeicherten Wirkstoffe'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('WIRKSTOFF HINZUFÜGEN'));
    await tester.pumpAndSettle();

    expect(find.text('Neuer Wirkstoff'), findsOneWidget);
    expect(find.text('WIRKSTOFFBEZEICHNUNG'), findsOneWidget);
    expect(find.text('ANWENDUNGSART'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('German saved conversion uses locale-aware decimals', (
    tester,
  ) async {
    await _useNarrowPhone(tester);
    final saved = SavedVialCalculation(
      id: 'saved-1',
      createdAt: DateTime.utc(2026, 8, 5),
      input: const ConversionInput(
        vialAmount: 1.5,
        diluentVolumeMl: 2.5,
        desiredAmount: 0.25,
        desiredAmountUnit: ConversionAmountUnit.milligrams,
        syringe: ConversionSyringe.units50,
      ),
    );

    await tester.pumpWidget(
      _GermanHarness(home: ReconstitutionScreen(savedCalculations: [saved])),
    );
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('1,5 mg + 2,5 ml'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();

    expect(find.text('1,5 mg + 2,5 ml'), findsOneWidget);
    expect(find.text('0,25 mg · 50 E'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _useNarrowPhone(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(320, 568);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
}

class _GermanHarness extends StatelessWidget {
  const _GermanHarness({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.dark,
      locale: const Locale('de'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    );
  }
}

class _EmptyCompoundStore implements CustomCompoundStore {
  @override
  Stream<List<CustomCompound>> watchAll(String uid) =>
      Stream.value(const <CustomCompound>[]);

  @override
  Future<void> upsert(String uid, CustomCompound compound) async {}
}
