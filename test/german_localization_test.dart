import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/peptide_library_repository.dart';
import 'package:peptide_os/features/library/providers/peptide_provider.dart';
import 'package:peptide_os/features/library/screens/library_screen.dart';
import 'package:peptide_os/features/library/screens/reconstitution_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('German Library surface renders without overflow', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final provider = PeptideProvider(
      PeptideLibraryRepository(firestore: FakeFirebaseFirestore()),
    );
    addTearDown(provider.dispose);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: _germanApp(const Scaffold(body: LibraryScreen())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Bibliothek'), findsOneWidget);
    expect(find.text('Peptide suchen...'), findsOneWidget);
    expect(find.text('Alle'), findsOneWidget);
    expect(find.text('Regeneration'), findsWidgets);
    expect(find.byTooltip('Einheitenrechner'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'German converter accepts a decimal comma and keeps safety copy visible',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 568));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_germanApp(const ReconstitutionScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Fläschchen-Rechner'), findsOneWidget);
      expect(
        find.text(
          'Nur Umrechnung — dieser Rechner wählt niemals eine Menge oder einen Zeitplan.',
        ),
        findsOneWidget,
      );
      expect(find.text('Umzurechnende Menge'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('vial-amount-field')),
          matching: find.byType(TextField),
        ),
        '5',
      );
      await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('diluent-volume-field')),
          matching: find.byType(TextField),
        ),
        '2',
      );
      await tester.enterText(
        find.byKey(const Key('desired-amount-field')),
        '250,0',
      );
      await tester.pump();

      await tester.scrollUntilVisible(
        find.byKey(const Key('draw-units-result')),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('10'), findsOneWidget);
      expect(find.text('Einheiten'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}

Widget _germanApp(Widget home) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.dark,
  locale: const Locale('de'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);
