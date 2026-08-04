import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/data/repositories/peptide_library_repository.dart';
import 'package:peptide_os/data/repositories/user_settings_repository.dart';
import 'package:peptide_os/features/library/providers/peptide_provider.dart';
import 'package:peptide_os/features/library/screens/library_screen.dart';
import 'package:peptide_os/features/profile/providers/settings_provider.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Library makes both calculation paths explicit', (tester) async {
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
    addTearDown(peptideProvider.dispose);
    addTearDown(settingsProvider.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: peptideProvider),
          ChangeNotifierProvider.value(value: settingsProvider),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: LibraryScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('UNIT CONVERTER'), findsOneWidget);
    expect(find.text('Convert vial math now'), findsOneWidget);
    expect(
      find.text('For reconstitution, tap any peptide below.'),
      findsOneWidget,
    );
    final converterSemantics = tester.getSemantics(
      find.bySemanticsLabel('Open unit converter'),
    );
    expect(
      converterSemantics,
      matchesSemantics(
        label: 'Open unit converter',
        isButton: true,
        hasTapAction: true,
      ),
    );
    expect(tester.takeException(), isNull);

    tester.semantics.tap(find.semantics.byLabel('Open unit converter'));
    await tester.pumpAndSettle();
    expect(find.text('Vial workspace'), findsOneWidget);
    expect(find.text('MEASUREMENT.MODE'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('BPC-157'));
    await tester.pumpAndSettle();
    expect(find.text('UTIL.RECONSTITUTION'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
