import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:peptide_os/core/utils/dose_units.dart';
import 'package:peptide_os/core/utils/decimal_input.dart';
import 'package:peptide_os/core/widgets/primary_button.dart';
import 'package:peptide_os/data/repositories/user_settings_repository.dart';
import 'package:peptide_os/data/repositories/dose_log_repository.dart';
import 'package:peptide_os/data/repositories/protocol_repository.dart';
import 'package:peptide_os/features/profile/providers/settings_provider.dart';
import 'package:peptide_os/features/library/screens/reconstitution_screen.dart';
import 'package:peptide_os/features/protocol/screens/create_protocol_screen.dart';
import 'package:peptide_os/features/protocol/widgets/log_dose_sheet.dart';
import 'package:peptide_os/features/protocol/providers/dose_log_provider.dart';
import 'package:peptide_os/features/protocol/providers/protocol_provider.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/conversion_workspace.dart';
import 'package:peptide_os/models/user_settings.dart';
import 'package:peptide_os/models/protocol.dart';
import 'package:peptide_os/models/dose_log.dart';

void main() {
  test(
    'mass conversion preserves small doses, roundtrip and other unit families',
    () {
      for (final mcg in [0.025, 1.0, 25.0, 500.0, 1000000.0]) {
        final mg = convertMassDose(mcg, 'mcg', 'mg');
        expect(convertMassDose(mg, 'mg', 'mcg'), closeTo(mcg, 1e-9));
        expect(
          parseDecimalInput(formatDoseNumber(mg, 'de')),
          closeTo(mg, 1e-12),
        );
      }
      expect(formatDoseNumber(convertMassDose(25, 'mcg', 'mg'), 'en'), '0.025');
      for (final unit in ['IU', 'syringe units', 'mL', 'unknown']) {
        expect(preferredDoseUnit(unit, DoseUnitPreference.mg), unit);
        expect(convertMassDose(25, unit, 'mg'), 25);
      }
      expect(preferredDoseUnit('mg', DoseUnitPreference.original), 'mg');
    },
  );

  test(
    'legacy settings keep original units; preference survives copy and storage',
    () {
      expect(
        UserSettings.fromMap({}).doseUnitPreference,
        DoseUnitPreference.original,
      );
      expect(
        UserSettings.fromMap({
          'doseUnitPreference': 'invalid',
        }).doseUnitPreference,
        DoseUnitPreference.original,
      );
      final settings = UserSettings(doseUnitPreference: DoseUnitPreference.mg);
      expect(
        UserSettings.fromMap(
          settings.copyWith(name: 'Test').toMap(),
        ).doseUnitPreference,
        DoseUnitPreference.mg,
      );
    },
  );

  testWidgets('calculator preference and manual toggle preserve desired mass', (
    tester,
  ) async {
    final settings = _settings();
    await settings.update((s) => s.doseUnitPreference = DoseUnitPreference.mg);
    addTearDown(settings.dispose);
    await tester.binding.setSurfaceSize(const Size(500, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _app(
        settings,
        const ReconstitutionScreen(
          initialInput: ConversionInput(
            vialAmountMg: 5,
            diluentVolumeMl: 2,
            desiredAmount: 25,
            syringe: ConversionSyringe.units100,
          ),
        ),
        locale: const Locale('de'),
      ),
    );
    await tester.pumpAndSettle();
    final field = find.byKey(const Key('desired-amount-field'));
    expect(tester.widget<TextField>(field).controller!.text, '0,025');
    await tester.tap(find.text('mcg').first);
    await tester.pump();
    expect(tester.widget<TextField>(field).controller!.text, '25');
    await tester.tap(find.text('mg').last);
    await tester.pump();
    expect(tester.widget<TextField>(field).controller!.text, '0,025');
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'protocol preference preserves weekdays and inherited phase amount on save',
    (tester) async {
      final settings = _settings();
      await settings.update(
        (s) => s.doseUnitPreference = DoseUnitPreference.mg,
      );
      addTearDown(settings.dispose);
      await tester.binding.setSurfaceSize(const Size(500, 1800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final peptide = ProtocolPeptide(
        peptideName: 'Example',
        dosePerInjection: 25,
        frequency: kCustomWeekdayFrequency,
        weekdayDoses: [ProtocolWeekdayDose(weekday: 1, dosePerInjection: 50)],
        phases: [
          ProtocolPhase(
            uuid: 'phase',
            name: 'Phase',
            startWeek: 1,
            endWeek: 2,
            dosePerInjection: 100,
          ),
          ProtocolPhase(
            uuid: 'phase2',
            name: 'Phase 2',
            startWeek: 3,
            endWeek: 4,
            doseUnit: 'mcg',
          ),
        ],
      );
      await tester.pumpWidget(
        _app(
          settings,
          Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => Scaffold(
                      body: PeptideProtocolConfigSheet(initial: peptide),
                    ),
                  ),
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(find.byType(TextField).first).controller!.text,
        '0.025',
      );
      await tester.ensureVisible(find.byType(PrimaryButton).last);
      await tester.tap(find.byType(PrimaryButton).last);
      await tester.pumpAndSettle();
      expect(peptide.doseUnit, 'mg');
      expect(peptide.dosePerInjection, 0.025);
      expect(peptide.weekdayDoses.single.doseUnit, 'mg');
      expect(peptide.weekdayDoses.single.dosePerInjection, 0.05);
      expect(peptide.phases.first.doseUnit, 'mcg');
      expect(peptide.phases.first.dosePerInjection, 100);
      expect(peptide.phases.last.doseUnit, 'mcg');
      expect(peptide.phases.last.dosePerInjection, 25);
      expect(tester.takeException(), isNull);
    },
  );

  for (final baseUnit in ['mcg', 'IU']) {
    testWidgets(
      'mixed $baseUnit base and independent weekday units survive editor save',
      (tester) async {
        final settings = _settings();
        await settings.update(
          (s) => s.doseUnitPreference = DoseUnitPreference.mg,
        );
        addTearDown(settings.dispose);
        await tester.binding.setSurfaceSize(const Size(500, 1800));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final otherUnit = baseUnit == 'mcg' ? 'IU' : 'mcg';
        final peptide = ProtocolPeptide(
          peptideName: 'Mixed example',
          dosePerInjection: 25,
          doseUnit: baseUnit,
          frequency: kCustomWeekdayFrequency,
          weekdayDoses: [
            ProtocolWeekdayDose(
              weekday: 1,
              dosePerInjection: 50,
              doseUnit: otherUnit,
            ),
          ],
          phases: [
            ProtocolPhase(
              uuid: 'mixed-phase',
              name: 'Mixed phase',
              startWeek: 1,
              endWeek: 2,
              dosePerInjection: 25,
              doseUnit: baseUnit,
              frequency: kCustomWeekdayFrequency,
              weekdayDoses: [
                ProtocolWeekdayDose(
                  weekday: 2,
                  dosePerInjection: 75,
                  doseUnit: otherUnit,
                ),
              ],
            ),
          ],
        );
        await tester.pumpWidget(
          _app(
            settings,
            Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => Scaffold(
                        body: PeptideProtocolConfigSheet(initial: peptide),
                      ),
                    ),
                  ),
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();
        // Open and save the phase as well, exercising its separate weekday editor.
        await tester.ensureVisible(find.text('Mixed phase'));
        await tester.tap(find.text('Mixed phase'));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.byType(PrimaryButton).last);
        await tester.tap(find.byType(PrimaryButton).last);
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.byType(PrimaryButton).last);
        await tester.tap(find.byType(PrimaryButton).last);
        await tester.pumpAndSettle();
        expect(peptide.weekdayDoses.single.doseUnit, otherUnit);
        expect(peptide.weekdayDoses.single.dosePerInjection, 50);
        expect(peptide.phases.single.weekdayDoses.single.doseUnit, otherUnit);
        expect(peptide.phases.single.weekdayDoses.single.dosePerInjection, 75);
        expect(peptide.dosePerInjection, baseUnit == 'mcg' ? 0.025 : 25);
        expect(peptide.doseUnit, baseUnit == 'mcg' ? 'mg' : 'IU');
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('switching protocol to IU requires a fresh explicit amount', (
    tester,
  ) async {
    final settings = _settings();
    addTearDown(settings.dispose);
    await tester.binding.setSurfaceSize(const Size(500, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _app(
        settings,
        Scaffold(
          body: PeptideProtocolConfigSheet(
            initial: ProtocolPeptide(
              peptideName: 'Example',
              dosePerInjection: 25,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('mg').first);
    await tester.pump();
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller!.text,
      '0.025',
    );
    await tester.tap(find.text('IU').first);
    await tester.pump();
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller!.text,
      isEmpty,
    );
    final save = tester.widget<PrimaryButton>(find.byType(PrimaryButton).last);
    expect(save.onPressed, isNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'logging mg stores original mcg amount without changing history units',
    (tester) async {
      final firestore = FakeFirebaseFirestore();
      final settings = _settings(firestore);
      await settings.update(
        (s) => s.doseUnitPreference = DoseUnitPreference.mg,
      );
      final repository = DoseLogRepository(firestore: firestore);
      final doses = DoseLogProvider(repository, uid: 'user');
      final protocols = ProtocolProvider(
        ProtocolRepository(firestore: firestore),
        repository,
        uid: 'user',
      );
      addTearDown(settings.dispose);
      addTearDown(doses.dispose);
      addTearDown(protocols.dispose);
      await tester.binding.setSurfaceSize(const Size(500, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final dose = DoseLog(
        uuid: 'dose',
        protocolUuid: 'p',
        protocolPeptideUuid: 'pp',
        peptideName: 'Example',
        scheduledAt: DateTime.now(),
        amountTaken: 25,
        units: 'mcg',
      );
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: doses),
            ChangeNotifierProvider.value(value: protocols),
          ],
          child: _app(settings, Scaffold(body: LogDoseSheet(dose: dose))),
        ),
      );
      await tester.pumpAndSettle();
      final field = find.byType(TextField).first;
      expect(tester.widget<TextField>(field).controller!.text, '0.025');
      await tester.enterText(field, '0.05');
      final button = find.byWidgetPredicate(
        (widget) =>
            widget is PrimaryButton && widget.icon == Icons.check_rounded,
      );
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
      final stored = await firestore
          .collection('users')
          .doc('user')
          .collection('doseLogs')
          .doc('dose')
          .get();
      expect(stored.data()!['amountTaken'], 50);
      expect(stored.data()!['units'], 'mcg');
      expect(dose.amountTaken, 25);
      expect(dose.units, 'mcg');
      expect(tester.takeException(), isNull);
    },
  );
}

SettingsProvider _settings([FakeFirebaseFirestore? firestore]) =>
    SettingsProvider(
      UserSettingsRepository(firestore: firestore ?? FakeFirebaseFirestore()),
      uid: '',
    );

Widget _app(
  SettingsProvider settings,
  Widget home, {
  Locale locale = const Locale('en'),
}) => ChangeNotifierProvider.value(
  value: settings,
  child: MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);
