import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:peptide_os/features/auth/screens/auth_screen.dart';
import 'package:peptide_os/features/auth/screens/email_auth_screen.dart';
import 'package:peptide_os/features/onboarding/widgets/first_name_page.dart';

void main() {
  testWidgets('first-name step focuses and advertises given-name autofill', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FirstNamePage(
            firstName: '',
            isActive: true,
            onChanged: (_) {},
            onNext: () {},
          ),
        ),
      ),
    );
    await tester.pump();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.focusNode?.hasFocus, isTrue);
    expect(field.autofillHints, contains(AutofillHints.givenName));
    expect(field.keyboardType, TextInputType.name);
    expect(field.decoration?.labelText, 'First name');
  });

  testWidgets('inactive first-name page does not steal focus', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FirstNamePage(
            firstName: '',
            isActive: false,
            onChanged: (_) {},
            onNext: () {},
          ),
        ),
      ),
    );
    await tester.pump();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.focusNode?.hasFocus, isFalse);
  });

  testWidgets('onboarding email entry defaults to account creation', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: AuthScreen(createAccountByDefault: true)),
    );

    await tester.tap(find.text('CONTINUE WITH EMAIL'));
    await tester.pumpAndSettle();

    expect(find.text('Create account'), findsWidgets);
    expect(find.text('CREATE ACCOUNT'), findsOneWidget);
    expect(find.text('Already have an account? Sign in'), findsOneWidget);
  });

  testWidgets('email auth still supports returning-user sign in', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: EmailAuthScreen(initialMode: EmailAuthMode.signIn),
      ),
    );

    expect(find.text('SIGN IN'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });
}
