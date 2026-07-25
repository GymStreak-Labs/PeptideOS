import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/models/blend_vial.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  test(
    'pre-blended vial keeps phase-specific weekday draw and time after round-trip',
    () {
      final peptide = ProtocolPeptide(
        uuid: 'blend-entry',
        peptideSlug: 'custom-blend',
        peptideName: 'Recovery blend',
        dosePerInjection: 10,
        doseUnit: 'syringe units',
        frequency: 'twice_weekly',
        syringeUnits: 10,
        blendVial: const BlendVial(
          constituents: [
            BlendConstituent(name: 'Compound A', vialAmount: 10, unit: 'mg'),
            BlendConstituent(name: 'Compound B', vialAmount: 5, unit: 'mg'),
          ],
          diluentMl: 2,
          drawSyringeUnits: 10,
        ),
        phases: [
          ProtocolPhase(
            uuid: 'phase-2',
            name: 'User-entered week two',
            startWeek: 2,
            endWeek: 2,
            frequency: kCustomWeekdayFrequency,
            weekdayDoses: [
              ProtocolWeekdayDose(
                weekday: DateTime.tuesday,
                dosePerInjection: 12,
                doseUnit: 'syringe units',
                syringeUnits: 12,
                scheduledTimes: const ['07:15'],
              ),
              ProtocolWeekdayDose(
                weekday: DateTime.friday,
                dosePerInjection: 15,
                doseUnit: 'syringe units',
                syringeUnits: 15,
                scheduledTimes: const ['19:45', '21:15'],
              ),
            ],
          ),
        ],
      );

      final restored = ProtocolPeptide.fromMap(peptide.toMap());
      final protocolStart = DateTime(2026, 7, 6); // Monday
      final weekTwoTuesday = DateTime(2026, 7, 14);
      final weekTwoWednesday = DateTime(2026, 7, 15);
      final weekTwoFriday = DateTime(2026, 7, 17);

      final tuesday = restored.scheduleForDate(
        protocolStart: protocolStart,
        date: weekTwoTuesday,
      );
      final friday = restored.scheduleForDate(
        protocolStart: protocolStart,
        date: weekTwoFriday,
      );
      final tuesdayBlend = tuesday?.blendVial;

      expect(restored.isBlend, isTrue);
      expect(restored.phases.single.weekdayDoses, hasLength(2));
      expect(tuesday?.scheduledTimes, const ['07:15']);
      expect(tuesdayBlend?.drawSyringeUnits, 12);
      expect(tuesdayBlend, isNotNull);
      final verifiedTuesdayBlend = tuesdayBlend!;
      expect(
        verifiedTuesdayBlend.amountPerDraw(
          verifiedTuesdayBlend.constituents.first,
        ),
        0.6,
      );
      expect(friday?.scheduledTimes, const ['19:45', '21:15']);
      expect(friday?.blendVial?.drawSyringeUnits, 15);
      expect(
        restored.scheduleForDate(
          protocolStart: protocolStart,
          date: weekTwoWednesday,
        ),
        isNull,
      );
    },
  );
}
