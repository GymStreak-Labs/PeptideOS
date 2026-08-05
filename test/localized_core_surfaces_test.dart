import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/features/auth/screens/account_deleted_screen.dart';
import 'package:peptide_os/features/auth/screens/auth_screen.dart';
import 'package:peptide_os/features/auth/screens/email_auth_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('German auth gate stays readable on a narrow phone', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_germanApp(const AuthScreen()));
    await tester.pumpAndSettle();

    expect(find.text('MIT E-MAIL FORTFAHREN'), findsOneWidget);
    expect(find.textContaining('Speichere dein persönliches'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('German email auth and deletion confirmation are localized', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_germanApp(const EmailAuthScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Anmelden'), findsWidgets);
    expect(find.text('E-Mail'), findsOneWidget);
    expect(find.text('Passwort'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(
      _germanApp(AccountDeletedScreen(onContinue: () {})),
    );
    await tester.pumpAndSettle();
    expect(find.text('Konto gelöscht'), findsOneWidget);
    expect(find.text('WEITER'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Widget _germanApp(Widget home) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.dark,
  locale: const Locale('de'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);
