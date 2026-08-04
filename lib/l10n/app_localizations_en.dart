// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get libraryTitle => 'Library';

  @override
  String get librarySystemLabel => 'SYS.DATABASE // COMPOUNDS';

  @override
  String get myCompounds => 'My compounds';

  @override
  String get unitConverter => 'Unit converter';

  @override
  String get openUnitConverter => 'Open unit converter';

  @override
  String get converterCardTitle => 'UNIT CONVERTER';

  @override
  String get converterCardSubtitle => 'Convert vial math now';

  @override
  String get converterCardHint => 'For reconstitution, tap any peptide below.';

  @override
  String get searchPeptides => 'Search peptides...';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryHealing => 'Healing';

  @override
  String get categoryGrowthHormone => 'Growth Hormone';

  @override
  String get categoryCognitive => 'Cognitive';

  @override
  String get categoryMetabolic => 'Metabolic';

  @override
  String get categoryAesthetic => 'Aesthetic';

  @override
  String get categoryLongevity => 'Longevity';

  @override
  String get categoryOther => 'Other';

  @override
  String get libraryUnavailable => 'Library unavailable';

  @override
  String get retry => 'RETRY';

  @override
  String get noPeptidesFound => 'No peptides found';

  @override
  String get tryDifferentSearch =>
      'Try a different search term or clear the filter.';

  @override
  String get calculationSaved => 'Calculation saved to this account.';

  @override
  String get converterIntro =>
      'Enter values from your own vial, diluent, and plan. PepMod converts those values into volume and U-100 syringe units.';

  @override
  String get vialAndDiluent => 'Vial + diluent';

  @override
  String get iuSourceCaption =>
      'Source: IU on your vial and mL of diluent added.';

  @override
  String get massSourceCaption => 'Source: labels on your vial and diluent.';

  @override
  String get vialAmount => 'VIAL AMOUNT';

  @override
  String get amountPrintedOnVial => 'Amount printed on vial';

  @override
  String get diluent => 'DILUENT';

  @override
  String get volumeAdded => 'Volume you added';

  @override
  String get amountToConvert => 'Amount to convert';

  @override
  String get iuAmountCaption => 'Enter an IU amount you were already given.';

  @override
  String get massAmountCaption => 'Source: an amount you were already given.';

  @override
  String get yourSyringe => 'Your syringe';

  @override
  String get syringeCaption => 'Select the capacity printed on the barrel.';

  @override
  String get educationalConverterDisclaimer =>
      'Educational unit-conversion tool only. PepMod does not recommend an amount or frequency. Recheck the source labels and confirm your calculation with a qualified healthcare professional before use.';

  @override
  String get back => 'Back';

  @override
  String get vialWorkspace => 'Vial workspace';

  @override
  String get conversionSystemLabel => 'UTIL.CONVERSION';

  @override
  String get measurementModeSystemLabel => 'MEASUREMENT.MODE';

  @override
  String get conversionResultSystemLabel => 'CONVERSION.RESULT';

  @override
  String get savedVialsSystemLabel => 'SAVED.VIALS';

  @override
  String get clear => 'CLEAR';

  @override
  String get conversionOnly =>
      'Conversion only — this workspace never chooses an amount or schedule.';

  @override
  String get sameUnitFamily => 'Use the same unit family printed on the vial.';

  @override
  String get mass => 'Mass';

  @override
  String get iuOnly => 'IU only';

  @override
  String get iuSafety =>
      'IU stays IU. PepMod does not convert IU to or from mg/mcg.';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get drawTo => 'DRAW TO';

  @override
  String get units => 'units';

  @override
  String get concentration => 'CONCENTRATION';

  @override
  String get syringeCapacity => 'SYRINGE CAPACITY';

  @override
  String get capacityWarning =>
      'The converted volume is larger than this syringe capacity. Choose the correct syringe or recheck your entries.';

  @override
  String get savePreset => 'SAVE PRESET';

  @override
  String get savedVialsHint => 'Tap a saved calculation to reuse its inputs.';

  @override
  String get removeSavedCalculation => 'Remove saved calculation';

  @override
  String get errorPositiveNumbers =>
      'Enter a number greater than zero in every field.';

  @override
  String get errorAmountAboveVial =>
      'Desired amount is greater than the amount entered for this vial.';

  @override
  String get errorConversion =>
      'These values could not be converted. Recheck each entry.';

  @override
  String get halfLife => 'Half-life';

  @override
  String get weekCycle => 'wk cycle';

  @override
  String get typicalDose => 'TYPICAL DOSE';

  @override
  String get notes => 'NOTES';

  @override
  String get commonStack => 'COMMON.STACK';

  @override
  String get reconstitutionTool => 'UTIL.RECONSTITUTION';

  @override
  String get compoundSystemLabel => 'DB.COMPOUND';

  @override
  String get addToProtocol => 'ADD TO PROTOCOL';

  @override
  String get vialShort => 'VIAL (mg)';

  @override
  String get bacShort => 'BAC (mL)';

  @override
  String get doseShort => 'DOSE (mcg)';

  @override
  String get routeSubcutaneous => 'Subcutaneous';

  @override
  String get routeIntramuscular => 'Intramuscular';

  @override
  String get routeOral => 'Oral';

  @override
  String get routeNasal => 'Nasal';

  @override
  String get frequencyDaily => 'Daily';

  @override
  String get frequencyEveryOtherDay => 'Every other day';

  @override
  String get frequencyTwiceWeekly => '2x per week';

  @override
  String get frequencyWeekly => 'Weekly';

  @override
  String get frequencyAsNeeded => 'As needed';
}
