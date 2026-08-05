import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/core/theme/theme.dart';
import 'package:peptide_os/features/protocol/screens/create_protocol_screen.dart';
import 'package:peptide_os/l10n/app_localizations.dart';
import 'package:peptide_os/models/blend_vial.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  testWidgets('pre-blended vial editor phone layout', (tester) async {
    final displayFont = FontLoader('SpaceGrotesk')
      ..addFont(rootBundle.load('assets/fonts/SpaceGrotesk.ttf'));
    final monoFont = FontLoader('JetBrainsMono')
      ..addFont(rootBundle.load('assets/fonts/JetBrainsMono.ttf'));
    await Future.wait([displayFont.load(), monoFont.load()]);

    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          backgroundColor: AppColors.background,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: BlendVialConfigSheet(
              initial: ProtocolPeptide(
                uuid: 'visual-blend',
                peptideSlug: 'custom-blend',
                peptideName: 'Recovery blend',
                dosePerInjection: 10,
                doseUnit: 'syringe units',
                frequency: 'twice_weekly',
                route: 'subcutaneous',
                syringeUnits: 10,
                labelColorHex: '#05D9E8',
                scheduledTimes: const ['08:00'],
                blendVial: const BlendVial(
                  constituents: [
                    BlendConstituent(
                      name: 'Compound A',
                      vialAmount: 10,
                      unit: 'mg',
                    ),
                    BlendConstituent(
                      name: 'Compound B',
                      vialAmount: 5,
                      unit: 'mg',
                    ),
                    BlendConstituent(
                      name: 'Compound C',
                      vialAmount: 1000,
                      unit: 'mcg',
                    ),
                  ],
                  diluentMl: 2,
                  drawSyringeUnits: 10,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/blend_vial_editor_phone.png'),
    );

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -1000),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/blend_vial_editor_preview_phone.png'),
    );

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -520),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/blend_vial_editor_schedule_phone.png'),
    );
  });
}
