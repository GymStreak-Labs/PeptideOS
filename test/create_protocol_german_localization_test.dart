import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/features/protocol/screens/create_protocol_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';

void main() {
  testWidgets('create protocol renders German copy on a narrow phone', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('de'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: CreateProtocolScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Benenne dein Protokoll'), findsOneWidget);
    expect(find.text('Mein Protokoll'), findsOneWidget);
    expect(find.text('WEITER'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
