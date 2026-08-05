// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get libraryTitle => 'Libreria';

  @override
  String get librarySystemLabel => 'SYS.DATABASE // COMPOSTI';

  @override
  String get myCompounds => 'I miei composti';

  @override
  String get unitConverter => 'Convertitore di unità';

  @override
  String get openUnitConverter => 'Apri il convertitore di unità';

  @override
  String get converterCardTitle => 'CONVERTITORE DI UNITÀ';

  @override
  String get converterCardSubtitle => 'Converti i valori del flacone';

  @override
  String get converterCardHint =>
      'Per la ricostituzione, tocca un peptide qui sotto.';

  @override
  String get searchPeptides => 'Cerca peptidi...';

  @override
  String get categoryAll => 'Tutti';

  @override
  String get categoryHealing => 'Recupero';

  @override
  String get categoryGrowthHormone => 'Ormone della crescita';

  @override
  String get categoryCognitive => 'Cognitivo';

  @override
  String get categoryMetabolic => 'Metabolico';

  @override
  String get categoryAesthetic => 'Estetica';

  @override
  String get categoryLongevity => 'Longevità';

  @override
  String get categoryOther => 'Altro';

  @override
  String get libraryUnavailable => 'Libreria non disponibile';

  @override
  String get retry => 'RIPROVA';

  @override
  String get noPeptidesFound => 'Nessun peptide trovato';

  @override
  String get tryDifferentSearch =>
      'Prova un altro termine o cancella il filtro.';

  @override
  String get calculationSaved => 'Calcolo salvato in questo account.';

  @override
  String get converterIntro =>
      'Inserisci i valori del flacone, del diluente e del tuo piano. PepMod li converte in volume e unità per siringa U-100.';

  @override
  String get vialAndDiluent => 'Flacone + diluente';

  @override
  String get iuSourceCaption =>
      'Fonte: UI sul flacone e mL di diluente aggiunto.';

  @override
  String get massSourceCaption =>
      'Fonte: etichette del flacone e del diluente.';

  @override
  String get vialAmount => 'QUANTITÀ NEL FLACONE';

  @override
  String get amountPrintedOnVial => 'Quantità indicata sul flacone';

  @override
  String get diluent => 'DILUENTE';

  @override
  String get volumeAdded => 'Volume aggiunto';

  @override
  String get amountToConvert => 'Quantità da convertire';

  @override
  String get iuAmountCaption =>
      'Inserisci una quantità in UI che ti è già stata indicata.';

  @override
  String get massAmountCaption =>
      'Fonte: una quantità che ti è già stata indicata.';

  @override
  String get yourSyringe => 'La tua siringa';

  @override
  String get syringeCaption => 'Seleziona la capacità indicata sul cilindro.';

  @override
  String get educationalConverterDisclaimer =>
      'Solo strumento didattico per la conversione di unità. PepMod non consiglia quantità o frequenze. Ricontrolla le etichette originali e conferma il calcolo con un professionista sanitario qualificato prima dell’uso.';

  @override
  String get back => 'Indietro';

  @override
  String get vialWorkspace => 'Area flacone';

  @override
  String get conversionSystemLabel => 'UTIL.CONVERSIONE';

  @override
  String get measurementModeSystemLabel => 'MODALITÀ.MISURA';

  @override
  String get conversionResultSystemLabel => 'RISULTATO.CONVERSIONE';

  @override
  String get savedVialsSystemLabel => 'FLACONI.SALVATI';

  @override
  String get clear => 'CANCELLA';

  @override
  String get conversionOnly =>
      'Solo conversione — quest’area non sceglie mai quantità o programmi.';

  @override
  String get sameUnitFamily =>
      'Usa la stessa famiglia di unità indicata sul flacone.';

  @override
  String get mass => 'Massa';

  @override
  String get iuOnly => 'Solo UI';

  @override
  String get iuSafety =>
      'Le UI restano UI. PepMod non converte le UI in mg/mcg o viceversa.';

  @override
  String get enterAmount => 'Inserisci la quantità';

  @override
  String get drawTo => 'RIEMPI FINO A';

  @override
  String get units => 'unità';

  @override
  String get concentration => 'CONCENTRAZIONE';

  @override
  String get syringeCapacity => 'CAPACITÀ DELLA SIRINGA';

  @override
  String get capacityWarning =>
      'Il volume convertito supera la capacità della siringa. Scegli la siringa corretta o ricontrolla i valori.';

  @override
  String get savePreset => 'SALVA PRESET';

  @override
  String get savedVialsHint =>
      'Tocca un calcolo salvato per riutilizzarne i valori.';

  @override
  String get removeSavedCalculation => 'Rimuovi il calcolo salvato';

  @override
  String get errorPositiveNumbers =>
      'Inserisci in ogni campo un numero maggiore di zero.';

  @override
  String get errorAmountAboveVial =>
      'La quantità desiderata supera quella inserita per questo flacone.';

  @override
  String get errorConversion =>
      'Impossibile convertire questi valori. Ricontrolla ogni voce.';

  @override
  String get halfLife => 'Emivita';

  @override
  String get weekCycle => 'sett. di ciclo';

  @override
  String get typicalDose => 'DOSE TIPICA';

  @override
  String get notes => 'NOTE';

  @override
  String get commonStack => 'STACK.COMUNE';

  @override
  String get reconstitutionTool => 'UTIL.RICOSTITUZIONE';

  @override
  String get compoundSystemLabel => 'DB.COMPOSTO';

  @override
  String get addToProtocol => 'AGGIUNGI AL PROTOCOLLO';

  @override
  String get vialShort => 'FLACONE (mg)';

  @override
  String get bacShort => 'BAC (mL)';

  @override
  String get doseShort => 'DOSE (mcg)';

  @override
  String get routeSubcutaneous => 'Sottocutanea';

  @override
  String get routeIntramuscular => 'Intramuscolare';

  @override
  String get routeOral => 'Orale';

  @override
  String get routeNasal => 'Nasale';

  @override
  String get frequencyDaily => 'Ogni giorno';

  @override
  String get frequencyEveryOtherDay => 'A giorni alterni';

  @override
  String get frequencyTwiceWeekly => '2 volte a settimana';

  @override
  String get frequencyWeekly => 'Ogni settimana';

  @override
  String get frequencyAsNeeded => 'Al bisogno';
}
