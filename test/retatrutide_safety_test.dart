import 'dart:convert';
import 'dart:io';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/core/widgets/primary_button.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/peptide_library_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/data/repositories/user_settings_repository.dart';
import 'package:peptide_os/features/library/providers/peptide_provider.dart';
import 'package:peptide_os/features/library/screens/peptide_detail_screen.dart';
import 'package:peptide_os/features/onboarding/services/onboarding_draft_service.dart';
import 'package:peptide_os/features/profile/providers/settings_provider.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/features/protocol/screens/create_protocol_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/peptide.dart';
import 'package:peptide_os/services/peptide_seed_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Peptide retatrutide() => PeptideSeedData.build().firstWhere(
    (peptide) => peptide.slug == 'retatrutide',
  );

  group('investigational library metadata', () {
    test('Retatrutide has no app-authored amount, frequency, or cycle', () {
      final peptide = retatrutide();

      expect(peptide.isInvestigational, isTrue);
      expect(peptide.hasProtocolDefaults, isFalse);
      expect(peptide.requiresExplicitProtocolEntry, isTrue);
      expect(peptide.defaultDoseMcg, 0);
      expect(peptide.defaultFrequency, isEmpty);
      expect(peptide.typicalCycleWeeks, 0);
      expect(peptide.typicalDose, contains('No approved dosing regimen'));
      expect(peptide.typicalDose, isNot(contains('1–12')));
    });

    test('safety flags serialize and legacy Retatrutide fails closed', () {
      final peptide = retatrutide();
      final roundTrip = Peptide.fromMap(peptide.slug, peptide.toMap());
      expect(roundTrip.isInvestigational, isTrue);
      expect(roundTrip.hasProtocolDefaults, isFalse);

      final legacy = Peptide.fromMap('retatrutide', {
        'name': 'Retatrutide',
        'defaultDoseMcg': 2000,
        'defaultFrequency': 'weekly',
      });
      expect(legacy.isInvestigational, isTrue);
      expect(legacy.hasProtocolDefaults, isFalse);
      expect(legacy.requiresExplicitProtocolEntry, isTrue);

      final ordinary = Peptide.fromMap('ordinary-reference', const {});
      expect(ordinary.isInvestigational, isFalse);
      expect(ordinary.hasProtocolDefaults, isTrue);
    });

    test('all locale catalogs remove numeric Retatrutide regimen copy', () {
      for (final locale in [
        'en',
        'de',
        'es',
        'fr',
        'it',
        'ja',
        'ko',
        'pt',
        'pt_BR',
      ]) {
        final catalog =
            jsonDecode(File('lib/l10n/app_$locale.arb').readAsStringSync())
                as Map<String, dynamic>;
        final copy = catalog['peptideContentRetatrutideTypicalDose'] as String;
        expect(
          copy,
          isNot(matches(RegExp(r'1\s*[–—〜~～-]\s*12'))),
          reason: locale,
        );
        expect(
          catalog['investigationalDosingLabel'],
          isNotEmpty,
          reason: locale,
        );
        expect(
          catalog['investigationalProtocolEntryWarning'],
          isNotEmpty,
          reason: locale,
        );
      }
    });
  });

  group('protocol creation guardrails', () {
    test('library draft starts blank and requires amount plus frequency', () {
      final firestore = FakeFirebaseFirestore();
      final provider = ProtocolProvider(
        ProtocolRepository(firestore: firestore),
        DoseLogRepository(firestore: firestore),
        uid: '',
      );
      addTearDown(provider.dispose);

      final draft = buildLibraryProtocolDraft(
        provider: provider,
        peptide: retatrutide(),
        labelColorHex: '#05D9E8',
      );
      expect(draft.dosePerInjection, 0);
      expect(draft.frequency, isEmpty);
      expect(draft.cycleWeeks, 0);
      expect(
        protocolConfigurationHasRequiredInput(
          dose: draft.dosePerInjection,
          frequency: draft.frequency,
        ),
        isFalse,
      );
      expect(
        protocolConfigurationHasRequiredInput(dose: 1, frequency: ''),
        isFalse,
      );
      expect(
        protocolConfigurationHasRequiredInput(dose: 1, frequency: 'weekly'),
        isTrue,
      );
    });

    testWidgets('editor shows warning, blank amount, and disabled save', (
      tester,
    ) async {
      final firestore = FakeFirebaseFirestore();
      final provider = ProtocolProvider(
        ProtocolRepository(firestore: firestore),
        DoseLogRepository(firestore: firestore),
        uid: '',
      );
      addTearDown(provider.dispose);
      final draft = buildLibraryProtocolDraft(
        provider: provider,
        peptide: retatrutide(),
        labelColorHex: '#05D9E8',
      );

      await tester.pumpWidget(
        _testApp(
          Scaffold(
            body: PeptideProtocolConfigSheet(
              initial: draft,
              requiresExplicitProtocolInput: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.textContaining('No approved protocol exists'),
        findsOneWidget,
      );
      expect(
        tester.widget<TextField>(find.byType(TextField).first).controller!.text,
        isEmpty,
      );
      final save = find.byWidgetPredicate(
        (widget) => widget is PrimaryButton && widget.label == 'Save',
      );
      await tester.ensureVisible(save);
      expect(tester.widget<PrimaryButton>(save).onPressed, isNull);
      expect(tester.takeException(), isNull);
    });
  });

  test('onboarding does not auto-create a Retatrutide protocol', () async {
    SharedPreferences.setMockInitialValues({});
    await OnboardingDraftService.save(
      const OnboardingDraft(
        firstName: 'Sam',
        birthDate: '1990-01-01',
        goals: ['Weight management'],
        confidenceNeeds: ['Tracking'],
        experience: 'beginner',
        frustration: 'dose_math',
        selectedPeptides: ['Retatrutide'],
        notificationsEnabled: false,
      ),
    );

    final firestore = FakeFirebaseFirestore();
    final settings = SettingsProvider(
      UserSettingsRepository(firestore: firestore),
      uid: 'user-1',
    );
    final protocols = ProtocolProvider(
      ProtocolRepository(firestore: firestore),
      DoseLogRepository(firestore: firestore),
      uid: 'user-1',
    );
    final doseLogs = DoseLogProvider(
      DoseLogRepository(firestore: firestore),
      uid: 'user-1',
    );
    final library = PeptideProvider(
      PeptideLibraryRepository(firestore: firestore),
    );
    addTearDown(settings.dispose);
    addTearDown(protocols.dispose);
    addTearDown(doseLogs.dispose);
    addTearDown(library.dispose);

    await OnboardingDraftService.replayAfterAuth(
      email: 'sam@example.com',
      defaultProtocolName: 'My protocol',
      settings: settings,
      protocols: protocols,
      doseLogs: doseLogs,
      library: library,
    );
    await Future<void>.delayed(Duration.zero);

    expect(settings.settings.onboardingCompleted, isTrue);
    expect(protocols.all, isEmpty);
    final saved = await firestore
        .collection('users')
        .doc('user-1')
        .collection('protocols')
        .get();
    expect(saved.docs, isEmpty);
  });

  testWidgets('detail page presents status, not a typical regimen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      _testApp(PeptideDetailScreen(peptide: retatrutide())),
    );
    await tester.pumpAndSettle();

    expect(find.text('INVESTIGATIONAL — NO APPROVED DOSING'), findsOneWidget);
    expect(find.textContaining('No approved dosing regimen'), findsOneWidget);
    expect(find.text('TYPICAL DOSE'), findsNothing);
    expect(find.textContaining('1–12 mg'), findsNothing);
    expect(find.textContaining('Weekly'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

Widget _testApp(Widget home) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.dark,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);
