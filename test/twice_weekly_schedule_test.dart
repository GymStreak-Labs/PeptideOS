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
import 'package:peptide_os/features/onboarding/services/onboarding_draft_service.dart';
import 'package:peptide_os/features/profile/providers/settings_provider.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/features/protocol/screens/create_protocol_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/blend_vial.dart';
import 'package:peptide_os/models/protocol.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('legacy twice_weekly frequency', () {
    test('always doses Monday and Thursday regardless of start date', () {
      // Existing protocols stored with the legacy key must never shift days.
      for (final start in [
        DateTime(2026, 8, 3), // Monday
        DateTime(2026, 8, 5), // Wednesday
        DateTime(2026, 8, 9), // Sunday
      ]) {
        for (var offset = 0; offset < 14; offset++) {
          final day = start.add(Duration(days: offset));
          expect(
            isDosingDayForFrequency('twice_weekly', start, day),
            day.weekday == DateTime.monday || day.weekday == DateTime.thursday,
            reason: 'start=$start day=$day',
          );
        }
      }
    });

    test('legacy weekday pair constant matches the historical schedule', () {
      expect(kLegacyTwiceWeeklyWeekdays, {DateTime.monday, DateTime.thursday});
    });

    test('2x per week remains a selectable frequency option', () {
      final twiceWeekly = kFrequencies.firstWhere(
        (f) => f.key == kTwiceWeeklyFrequency,
      );
      expect(twiceWeekly.daysPerWeek, 2);
    });

    test('explicit two-day custom_weekdays schedule round-trips', () {
      final peptide = ProtocolPeptide(
        uuid: 'p-1',
        peptideSlug: 'tb-500',
        peptideName: 'TB-500',
        dosePerInjection: 2000,
        doseUnit: 'mcg',
        frequency: kCustomWeekdayFrequency,
        weekdayDoses: [
          ProtocolWeekdayDose(
            weekday: DateTime.monday,
            dosePerInjection: 2000,
            doseUnit: 'mcg',
          ),
          ProtocolWeekdayDose(
            weekday: DateTime.thursday,
            dosePerInjection: 2000,
            doseUnit: 'mcg',
          ),
        ],
      );

      final restored = ProtocolPeptide.fromMap(peptide.toMap());
      expect(restored.frequency, kCustomWeekdayFrequency);
      expect(restored.weekdayDoses.map((d) => d.weekday).toList(), [
        DateTime.monday,
        DateTime.thursday,
      ]);
    });
  });

  group('blend editor twice-weekly persistence', () {
    ProtocolPeptide legacyBlend() => ProtocolPeptide(
      uuid: 'legacy-blend',
      peptideSlug: 'custom-blend',
      peptideName: 'Recovery blend',
      dosePerInjection: 10,
      doseUnit: 'syringe units',
      frequency: kTwiceWeeklyFrequency,
      route: 'subcutaneous',
      syringeUnits: 10,
      scheduledTimes: const ['08:00'],
      blendVial: const BlendVial(
        constituents: [
          BlendConstituent(name: 'Compound A', vialAmount: 10, unit: 'mg'),
          BlendConstituent(name: 'Compound B', vialAmount: 5, unit: 'mg'),
        ],
        diluentMl: 2,
        drawSyringeUnits: 10,
      ),
    );

    Future<Future<ProtocolPeptide?>> openSheet(WidgetTester tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      late Future<ProtocolPeptide?> result;
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  result = showModalBottomSheet<ProtocolPeptide>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) =>
                        BlendVialConfigSheet(initial: legacyBlend()),
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      return result;
    }

    Finder saveButton() => find.byWidgetPredicate(
      (w) => w is PrimaryButton && w.label == 'SAVE BLEND',
    );

    testWidgets(
      'legacy blend surfaces Mon/Thu and saves as explicit custom weekdays',
      (tester) async {
        final result = await openSheet(tester);

        // The historical implicit days are shown as an editable selection.
        expect(
          find.text('Pick exactly two weekdays for this schedule.'),
          findsOneWidget,
        );
        expect(find.text('Mon'), findsOneWidget);
        expect(find.text('Thu'), findsOneWidget);

        await tester.ensureVisible(saveButton());
        await tester.pumpAndSettle();
        await tester.tap(saveButton());
        await tester.pumpAndSettle();

        final saved = await result;
        expect(saved, isNotNull);
        expect(saved!.frequency, kCustomWeekdayFrequency);
        expect(saved.weekdayDoses.map((d) => d.weekday).toList(), [
          DateTime.monday,
          DateTime.thursday,
        ]);
        expect(saved.scheduledTimes, ['08:00']);
      },
    );

    testWidgets('changing the day pair persists the new explicit selection', (
      tester,
    ) async {
      final result = await openSheet(tester);

      // Deselect Thursday: exactly-two validation blocks saving.
      await tester.ensureVisible(find.text('Thu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Thu'));
      await tester.pump();
      expect(
        find.text('Select exactly two days for a 2x per week schedule.'),
        findsOneWidget,
      );
      expect(tester.widget<PrimaryButton>(saveButton()).onPressed, isNull);

      await tester.tap(find.text('Wed'));
      await tester.pump();
      await tester.ensureVisible(saveButton());
      await tester.pumpAndSettle();
      await tester.tap(saveButton());
      await tester.pumpAndSettle();

      final saved = await result;
      expect(saved!.frequency, kCustomWeekdayFrequency);
      expect(saved.weekdayDoses.map((d) => d.weekday).toList(), [
        DateTime.monday,
        DateTime.wednesday,
      ]);
    });
  });

  group('onboarding draft replay', () {
    test(
      'twice-weekly library defaults become explicit Mon/Thu weekday doses',
      () async {
        SharedPreferences.setMockInitialValues({});
        await OnboardingDraftService.save(
          const OnboardingDraft(
            firstName: 'Sam',
            birthDate: '1990-01-01',
            goals: ['Recovery'],
            confidenceNeeds: ['Dose math'],
            experience: 'beginner',
            frustration: 'dose_math',
            selectedPeptides: ['TB-500'],
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

        expect(protocols.all, hasLength(1));
        final entry = protocols.all.single.peptides.single;
        expect(entry.peptideSlug, 'tb-500');
        // Never persist the implicit legacy key for new protocols.
        expect(entry.frequency, kCustomWeekdayFrequency);
        expect(entry.weekdayDoses.map((d) => d.weekday).toList(), [
          DateTime.monday,
          DateTime.thursday,
        ]);
        expect(
          entry.weekdayDoses.every((d) => d.dosePerInjection == 2000),
          isTrue,
        );
      },
    );
  });
}
