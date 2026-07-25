import 'package:flutter_test/flutter_test.dart';
import 'package:peptide_os/models/blend_vial.dart';
import 'package:peptide_os/models/dose_log.dart';
import 'package:peptide_os/models/protocol.dart';

void main() {
  const blend = BlendVial(
    constituents: [
      BlendConstituent(name: 'Compound A', vialAmount: 10, unit: 'mg'),
      BlendConstituent(name: 'Compound B', vialAmount: 5, unit: 'mg'),
      BlendConstituent(name: 'Compound C', vialAmount: 1000, unit: 'mcg'),
    ],
    diluentMl: 2,
    drawSyringeUnits: 10,
  );

  test('calculates each constituent from one U-100 draw', () {
    expect(blend.isValid, isTrue);
    expect(blend.drawVolumeMl, closeTo(0.1, 0.0001));
    expect(blend.drawFraction, closeTo(0.05, 0.0001));
    expect(blend.amountPerDraw(blend.constituents[0]), closeTo(0.5, 0.0001));
    expect(blend.amountPerDraw(blend.constituents[1]), closeTo(0.25, 0.0001));
    expect(blend.amountPerDraw(blend.constituents[2]), closeTo(50, 0.0001));
  });

  test('rejects incomplete or impossible blend inputs', () {
    expect(
      const BlendVial(
        constituents: [
          BlendConstituent(name: 'Only one', vialAmount: 10, unit: 'mg'),
        ],
        diluentMl: 2,
        drawSyringeUnits: 10,
      ).isValid,
      isFalse,
    );
    expect(blend.copyWith(drawSyringeUnits: 250).isValid, isFalse);
  });

  test('protocol serialization round-trips blend details', () {
    final peptide = ProtocolPeptide(
      uuid: 'blend-1',
      peptideSlug: 'custom-blend',
      peptideName: 'Recovery blend',
      dosePerInjection: 10,
      doseUnit: 'syringe units',
      frequency: 'weekly',
      syringeUnits: 10,
      blendVial: blend,
    );

    final restored = ProtocolPeptide.fromMap(peptide.toMap());

    expect(restored.isBlend, isTrue);
    expect(restored.blendVial!.constituents, hasLength(3));
    expect(restored.blendVial!.constituents[2].unit, 'mcg');
    expect(
      restored.blendVial!.amountPerDraw(restored.blendVial!.constituents[2]),
      closeTo(50, 0.0001),
    );
  });

  test('dose log keeps an immutable blend snapshot', () {
    final log = DoseLog(
      uuid: 'dose-1',
      protocolUuid: 'protocol-1',
      protocolPeptideUuid: 'blend-1',
      peptideName: 'Recovery blend',
      scheduledAt: DateTime(2026, 7, 25, 8),
      amountTaken: 10,
      units: 'syringe units',
      syringeUnits: 10,
      blendSnapshot: blend,
    );

    final restored = DoseLog.fromMap(log.uuid, log.toMap());
    final edited = restored.copyWith(
      amountTaken: 20,
      blendSnapshot: restored.blendSnapshot!.copyWith(drawSyringeUnits: 20),
    );

    expect(restored.blendSnapshot!.drawSyringeUnits, 10);
    expect(edited.blendSnapshot!.drawSyringeUnits, 20);
    expect(
      edited.blendSnapshot!.amountPerDraw(
        edited.blendSnapshot!.constituents.first,
      ),
      closeTo(1, 0.0001),
    );
  });
}
