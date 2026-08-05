import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:peptide_os/data/repositories/body_metric_repository.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/progress/providers/body_metric_provider.dart';
import 'package:peptide_os/features/progress/screens/progress_screen.dart';
import 'package:peptide_os/features/progress/widgets/log_metric_sheet.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Intl.defaultLocale = 'de';
  });

  tearDown(() {
    Intl.defaultLocale = null;
  });

  testWidgets('German progress screen fits a narrow phone', (tester) async {
    await _useNarrowPhone(tester);
    final firestore = FakeFirebaseFirestore();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => DoseLogProvider(
              DoseLogRepository(firestore: firestore),
              uid: '',
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => BodyMetricProvider(
              BodyMetricRepository(firestore: firestore),
              uid: '',
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => ProtocolProvider(
              ProtocolRepository(firestore: firestore),
              DoseLogRepository(firestore: firestore),
              uid: '',
            ),
          ),
        ],
        child: const _LocalizedHarness(home: ProgressScreen()),
      ),
    );
    await tester.pump();

    expect(find.text('Fortschritt'), findsOneWidget);
    expect(find.text('30 TAGE'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Keine Gewichtsdaten'),
      180,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();
    expect(find.text('Keine Gewichtsdaten'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('German measurement sheet fits and validates on a narrow phone', (
    tester,
  ) async {
    await _useNarrowPhone(tester);
    final provider = BodyMetricProvider(
      BodyMetricRepository(firestore: FakeFirebaseFirestore()),
      uid: '',
    );
    addTearDown(provider.dispose);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const _LocalizedHarness(home: Scaffold(body: LogMetricSheet())),
      ),
    );
    await tester.pump();

    expect(find.text('Neuer Messwert'), findsOneWidget);
    expect(find.text('KÖRPERFETT'), findsOneWidget);
    expect(find.text('SPEICHERN'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('SPEICHERN'));
    await tester.pump();

    expect(find.text('Gib mindestens einen Wert ein.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _useNarrowPhone(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(320, 568);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
}

class _LocalizedHarness extends StatelessWidget {
  const _LocalizedHarness({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('de'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    );
  }
}
