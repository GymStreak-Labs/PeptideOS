// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get libraryTitle => 'Bibliothek';

  @override
  String get librarySystemLabel => 'SYS.DATENBANK // WIRKSTOFFE';

  @override
  String get myCompounds => 'Meine Wirkstoffe';

  @override
  String get unitConverter => 'Einheitenrechner';

  @override
  String get searchPeptides => 'Peptide suchen...';

  @override
  String get categoryAll => 'Alle';

  @override
  String get categoryHealing => 'Regeneration';

  @override
  String get categoryGrowthHormone => 'Wachstumshormon';

  @override
  String get categoryCognitive => 'Kognitiv';

  @override
  String get categoryMetabolic => 'Stoffwechsel';

  @override
  String get categoryAesthetic => 'Ästhetik';

  @override
  String get categoryLongevity => 'Langlebigkeit';

  @override
  String get categoryOther => 'Sonstige';

  @override
  String get libraryUnavailable => 'Bibliothek nicht verfügbar';

  @override
  String get retry => 'ERNEUT VERSUCHEN';

  @override
  String get noPeptidesFound => 'Keine Peptide gefunden';

  @override
  String get tryDifferentSearch =>
      'Versuche einen anderen Suchbegriff oder entferne den Filter.';

  @override
  String get calculationSaved =>
      'Berechnung wurde in diesem Konto gespeichert.';

  @override
  String get converterIntro =>
      'Gib die Werte von deinem Fläschchen, dem Verdünnungsmittel und deinem Plan ein. PepMod rechnet sie in Volumen und U-100-Spritzen-Einheiten um.';

  @override
  String get vialAndDiluent => 'Fläschchen + Verdünnung';

  @override
  String get iuSourceCaption =>
      'Quelle: IE auf dem Fläschchen und hinzugefügte ml Verdünnungsmittel.';

  @override
  String get massSourceCaption =>
      'Quelle: Angaben auf Fläschchen und Verdünnungsmittel.';

  @override
  String get vialAmount => 'INHALT DES FLÄSCHCHENS';

  @override
  String get amountPrintedOnVial => 'Aufgedruckte Menge';

  @override
  String get diluent => 'VERDÜNNUNG';

  @override
  String get volumeAdded => 'Hinzugefügtes Volumen';

  @override
  String get amountToConvert => 'Umzurechnende Menge';

  @override
  String get iuAmountCaption => 'Gib eine bereits vorgegebene IE-Menge ein.';

  @override
  String get massAmountCaption => 'Quelle: eine bereits vorgegebene Menge.';

  @override
  String get yourSyringe => 'Deine Spritze';

  @override
  String get syringeCaption =>
      'Wähle die auf dem Zylinder angegebene Kapazität.';

  @override
  String get educationalConverterDisclaimer =>
      'Nur ein Lernwerkzeug zur Einheitenumrechnung. PepMod empfiehlt weder Menge noch Häufigkeit. Prüfe die Quellenangaben und bestätige die Berechnung vor der Anwendung mit qualifiziertem medizinischem Fachpersonal.';

  @override
  String get back => 'Zurück';

  @override
  String get vialWorkspace => 'Fläschchen-Rechner';

  @override
  String get conversionSystemLabel => 'WERKZEUG.UMRECHNUNG';

  @override
  String get measurementModeSystemLabel => 'MESSMODUS';

  @override
  String get conversionResultSystemLabel => 'UMRECHNUNG.ERGEBNIS';

  @override
  String get savedVialsSystemLabel => 'GESPEICHERTE.FLÄSCHCHEN';

  @override
  String get clear => 'LEEREN';

  @override
  String get conversionOnly =>
      'Nur Umrechnung — dieser Rechner wählt niemals eine Menge oder einen Zeitplan.';

  @override
  String get sameUnitFamily =>
      'Verwende dieselbe Einheitenart wie auf dem Fläschchen.';

  @override
  String get mass => 'Masse';

  @override
  String get iuOnly => 'Nur IE';

  @override
  String get iuSafety =>
      'IE bleibt IE. PepMod rechnet IE nicht in mg/mcg oder zurück um.';

  @override
  String get enterAmount => 'Menge eingeben';

  @override
  String get drawTo => 'AUFZIEHEN BIS';

  @override
  String get units => 'Einheiten';

  @override
  String get concentration => 'KONZENTRATION';

  @override
  String get syringeCapacity => 'SPRITZENKAPAZITÄT';

  @override
  String get capacityWarning =>
      'Das umgerechnete Volumen übersteigt die Kapazität dieser Spritze. Wähle die richtige Spritze oder prüfe deine Eingaben.';

  @override
  String get savePreset => 'SPEICHERN';

  @override
  String get savedVialsHint =>
      'Tippe auf eine gespeicherte Berechnung, um ihre Eingaben wiederzuverwenden.';

  @override
  String get removeSavedCalculation => 'Gespeicherte Berechnung entfernen';

  @override
  String get errorPositiveNumbers =>
      'Gib in jedem Feld eine Zahl größer als null ein.';

  @override
  String get errorAmountAboveVial =>
      'Die gewünschte Menge ist größer als der eingegebene Inhalt des Fläschchens.';

  @override
  String get errorConversion =>
      'Diese Werte konnten nicht umgerechnet werden. Prüfe alle Eingaben.';

  @override
  String get halfLife => 'Halbwertszeit';

  @override
  String get weekCycle => 'Wochen Zyklus';

  @override
  String get typicalDose => 'TYPISCHE DOSIS';

  @override
  String get notes => 'HINWEISE';

  @override
  String get commonStack => 'HÄUFIGE KOMBINATION';

  @override
  String get reconstitutionTool => 'WERKZEUG.REKONSTITUTION';

  @override
  String get compoundSystemLabel => 'DB.WIRKSTOFF';

  @override
  String get addToProtocol => 'ZUM PROTOKOLL HINZUFÜGEN';

  @override
  String get vialShort => 'FLASCHE (mg)';

  @override
  String get bacShort => 'BAC (ml)';

  @override
  String get doseShort => 'DOSIS (mcg)';

  @override
  String get routeSubcutaneous => 'Subkutan';

  @override
  String get routeIntramuscular => 'Intramuskulär';

  @override
  String get routeOral => 'Oral';

  @override
  String get routeNasal => 'Nasal';

  @override
  String get frequencyDaily => 'Täglich';

  @override
  String get frequencyEveryOtherDay => 'Jeden zweiten Tag';

  @override
  String get frequencyTwiceWeekly => '2× pro Woche';

  @override
  String get frequencyWeekly => 'Wöchentlich';

  @override
  String get frequencyAsNeeded => 'Bei Bedarf';
}
