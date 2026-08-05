import 'dart:convert';
import 'dart:io';

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

const _newLocales = <Locale>[
  Locale('es'),
  Locale('fr'),
  Locale('it'),
  Locale('ja'),
  Locale('ko'),
  Locale('pt'),
  Locale('pt', 'BR'),
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('every locale has the same message keys as English', () {
    final english = _messageKeys('lib/l10n/app_en.arb');
    final localeFiles = <String>[
      'lib/l10n/app_de.arb',
      'lib/l10n/app_es.arb',
      'lib/l10n/app_fr.arb',
      'lib/l10n/app_it.arb',
      'lib/l10n/app_ja.arb',
      'lib/l10n/app_ko.arb',
      'lib/l10n/app_pt.arb',
      'lib/l10n/app_pt_BR.arb',
    ];

    for (final path in localeFiles) {
      expect(_messageKeys(path), english, reason: '$path must have key parity');
    }
  });

  test('generated delegate exposes every requested locale', () {
    final english = lookupAppLocalizations(const Locale('en'));
    for (final locale in _newLocales) {
      final localized = lookupAppLocalizations(locale);
      expect(
        AppLocalizations.supportedLocales.contains(locale),
        isTrue,
        reason: '${locale.toLanguageTag()} is missing from generated locales',
      );
      expect(
        localized.libraryTitle,
        isNot(english.libraryTitle),
        reason: '${locale.toLanguageTag()} fell back to English',
      );
      final representativeSurfaces = <(String, String, String)>[
        ('auth', localized.authRequiredTitle, english.authRequiredTitle),
        ('paywall', localized.paywallTitle, english.paywallTitle),
        ('protocol', localized.protocolCreate, english.protocolCreate),
        ('progress', localized.progressTitle, english.progressTitle),
        ('profile', localized.profileTitle, english.profileTitle),
        ('library', localized.addCompound, english.addCompound),
        (
          'notifications',
          localized.notificationDoseTitle,
          english.notificationDoseTitle,
        ),
        (
          'purchase errors',
          localized.subscriptionErrorNetwork,
          english.subscriptionErrorNetwork,
        ),
        (
          'reference content',
          localized.peptideContentBpc157Description,
          english.peptideContentBpc157Description,
        ),
      ];
      for (final (surface, value, englishValue) in representativeSurfaces) {
        expect(
          value,
          isNot(englishValue),
          reason: '${locale.toLanguageTag()} has English fallback on $surface',
        );
      }
    }
  });

  for (final locale in _newLocales) {
    testWidgets(
      '${locale.toLanguageTag()} Library and converter fit a narrow phone',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(320, 568));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        final provider = PeptideProvider(
          PeptideLibraryRepository(firestore: FakeFirebaseFirestore()),
        );
        addTearDown(provider.dispose);

        final l10n = lookupAppLocalizations(locale);
        await tester.pumpWidget(
          ChangeNotifierProvider.value(
            value: provider,
            child: _localizedApp(locale, const Scaffold(body: LibraryScreen())),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(l10n.libraryTitle), findsOneWidget);
        expect(find.bySemanticsLabel(l10n.openUnitConverter), findsOneWidget);
        await tester.scrollUntilVisible(
          find.text('BPC-157'),
          180,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        expect(
          find.text(l10n.peptideContentBpc157TypicalDose),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(
          _localizedApp(locale, const ReconstitutionScreen()),
        );
        await tester.pumpAndSettle();

        expect(find.text(l10n.conversionOnly), findsOneWidget);
        expect(find.text(l10n.amountToConvert), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }
}

Set<String> _messageKeys(String path) {
  final contents =
      jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return contents.keys.where((key) => !key.startsWith('@')).toSet();
}

Widget _localizedApp(Locale locale, Widget home) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.dark,
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);
