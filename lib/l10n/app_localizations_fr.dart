// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get libraryTitle => 'Bibliothèque';

  @override
  String get librarySystemLabel => 'SYS.BASE.DONNÉES // COMPOSÉS';

  @override
  String get myCompounds => 'Mes composés';

  @override
  String get unitConverter => 'Convertisseur d’unités';

  @override
  String get openUnitConverter => 'Ouvrir le convertisseur d’unités';

  @override
  String get converterCardTitle => 'CONVERTISSEUR D’UNITÉS';

  @override
  String get converterCardSubtitle => 'Convertir les valeurs du flacon';

  @override
  String get converterCardHint =>
      'Pour la reconstitution, touchez un peptide ci-dessous.';

  @override
  String get searchPeptides => 'Rechercher des peptides...';

  @override
  String get categoryAll => 'Tous';

  @override
  String get categoryHealing => 'Récupération';

  @override
  String get categoryGrowthHormone => 'Hormone de croissance';

  @override
  String get categoryCognitive => 'Cognitif';

  @override
  String get categoryMetabolic => 'Métabolique';

  @override
  String get categoryAesthetic => 'Esthétique';

  @override
  String get categoryLongevity => 'Longévité';

  @override
  String get categoryOther => 'Autre';

  @override
  String get libraryUnavailable => 'Bibliothèque indisponible';

  @override
  String get retry => 'RÉESSAYER';

  @override
  String get noPeptidesFound => 'Aucun peptide trouvé';

  @override
  String get tryDifferentSearch =>
      'Essayez un autre terme ou effacez le filtre.';

  @override
  String get calculationSaved => 'Calcul enregistré dans ce compte.';

  @override
  String get converterIntro =>
      'Saisissez les valeurs de votre flacon, du diluant et de votre plan. PepMod les convertit en volume et en unités de seringue U-100.';

  @override
  String get vialAndDiluent => 'Flacon + diluant';

  @override
  String get iuSourceCaption =>
      'Source : UI indiquées sur votre flacon et mL de diluant ajouté.';

  @override
  String get massSourceCaption =>
      'Source : étiquettes de votre flacon et du diluant.';

  @override
  String get vialAmount => 'QUANTITÉ DU FLACON';

  @override
  String get amountPrintedOnVial => 'Quantité indiquée sur le flacon';

  @override
  String get diluent => 'DILUANT';

  @override
  String get volumeAdded => 'Volume ajouté';

  @override
  String get amountToConvert => 'Quantité à convertir';

  @override
  String get iuAmountCaption =>
      'Saisissez une quantité en UI qui vous a déjà été donnée.';

  @override
  String get massAmountCaption =>
      'Source : quantité qui vous a déjà été donnée.';

  @override
  String get yourSyringe => 'Votre seringue';

  @override
  String get syringeCaption =>
      'Sélectionnez la capacité indiquée sur le corps.';

  @override
  String get educationalConverterDisclaimer =>
      'Outil éducatif de conversion d’unités uniquement. PepMod ne recommande ni quantité ni fréquence. Vérifiez les étiquettes d’origine et confirmez votre calcul auprès d’un professionnel de santé qualifié avant utilisation.';

  @override
  String get back => 'Retour';

  @override
  String get vialWorkspace => 'Espace flacon';

  @override
  String get conversionSystemLabel => 'UTIL.CONVERSION';

  @override
  String get measurementModeSystemLabel => 'MODE.MESURE';

  @override
  String get conversionResultSystemLabel => 'RÉSULTAT.CONVERSION';

  @override
  String get savedVialsSystemLabel => 'FLACONS.ENREGISTRÉS';

  @override
  String get clear => 'EFFACER';

  @override
  String get conversionOnly =>
      'Conversion uniquement — cet espace ne choisit jamais de quantité ni de calendrier.';

  @override
  String get sameUnitFamily =>
      'Utilisez la même famille d’unités que celle du flacon.';

  @override
  String get mass => 'Masse';

  @override
  String get iuOnly => 'UI uniquement';

  @override
  String get iuSafety =>
      'Les UI restent des UI. PepMod ne convertit pas les UI en mg/mcg, ni l’inverse.';

  @override
  String get enterAmount => 'Saisir la quantité';

  @override
  String get drawTo => 'REMPLIR JUSQU’À';

  @override
  String get units => 'unités';

  @override
  String get concentration => 'CONCENTRATION';

  @override
  String get syringeCapacity => 'CAPACITÉ DE LA SERINGUE';

  @override
  String get capacityWarning =>
      'Le volume converti dépasse la capacité de cette seringue. Choisissez la bonne seringue ou vérifiez vos saisies.';

  @override
  String get savePreset => 'ENREGISTRER';

  @override
  String get savedVialsHint =>
      'Touchez un calcul enregistré pour réutiliser ses valeurs.';

  @override
  String get removeSavedCalculation => 'Supprimer le calcul enregistré';

  @override
  String get errorPositiveNumbers =>
      'Saisissez un nombre supérieur à zéro dans chaque champ.';

  @override
  String get errorAmountAboveVial =>
      'La quantité souhaitée dépasse celle saisie pour ce flacon.';

  @override
  String get errorConversion =>
      'Impossible de convertir ces valeurs. Vérifiez chaque saisie.';

  @override
  String get halfLife => 'Demi-vie';

  @override
  String get weekCycle => 'sem. de cycle';

  @override
  String get typicalDose => 'DOSE HABITUELLE';

  @override
  String get notes => 'NOTES';

  @override
  String get commonStack => 'ASSOCIATION.COURANTE';

  @override
  String get reconstitutionTool => 'UTIL.RECONSTITUTION';

  @override
  String get compoundSystemLabel => 'DB.COMPOSÉ';

  @override
  String get addToProtocol => 'AJOUTER AU PROTOCOLE';

  @override
  String get vialShort => 'FLACON (mg)';

  @override
  String get bacShort => 'BAC (mL)';

  @override
  String get doseShort => 'DOSE (mcg)';

  @override
  String get routeSubcutaneous => 'Sous-cutanée';

  @override
  String get routeIntramuscular => 'Intramusculaire';

  @override
  String get routeOral => 'Orale';

  @override
  String get routeNasal => 'Nasale';

  @override
  String get frequencyDaily => 'Tous les jours';

  @override
  String get frequencyEveryOtherDay => 'Un jour sur deux';

  @override
  String get frequencyTwiceWeekly => '2 fois par semaine';

  @override
  String get frequencyWeekly => 'Chaque semaine';

  @override
  String get frequencyAsNeeded => 'Au besoin';
}
