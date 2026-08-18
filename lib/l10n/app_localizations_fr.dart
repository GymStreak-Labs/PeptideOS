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

  @override
  String get tabProtocol => 'Protocole';

  @override
  String get tabProgress => 'Progrès';

  @override
  String get tabLibrary => 'Bibliothèque';

  @override
  String get tabYou => 'Vous';

  @override
  String get continueLabel => 'CONTINUER';

  @override
  String get processingLabel => 'TRAITEMENT…';

  @override
  String get authAppleFailed =>
      'La connexion Apple a échoué. Veuillez réessayer.';

  @override
  String get authGoogleFailed =>
      'La connexion à Google a échoué. Veuillez réessayer.';

  @override
  String get authGenericError =>
      'Quelque chose s\'est mal passé. Veuillez réessayer.';

  @override
  String get authUserNotFound =>
      'Aucun utilisateur trouvé avec cette adresse email.';

  @override
  String get authIncorrectCredentials => 'Email ou mot de passe incorrect.';

  @override
  String get authAccountExists => 'Un compte existe déjà avec cet email.';

  @override
  String get authWeakPassword =>
      'Le mot de passe est trop faible. Utilisez au moins 6 caractères.';

  @override
  String get authInvalidEmail => 'Adresse e-mail invalide.';

  @override
  String get authAppleUnavailable =>
      'La connexion avec Apple n\'est pas activée pour cette application.';

  @override
  String get authRequiredTitle => 'Enregistrez votre\nprotocole personnalisé';

  @override
  String get authRequiredBody =>
      'Conservez votre feuille de route, votre calendrier, vos journaux de doses et vos rappels attachés à votre compte avant le déverrouillage du protocole.';

  @override
  String get continueWithEmail => 'CONTINUER AVEC L’E-MAIL';

  @override
  String get signInWithApple => 'SE CONNECTER AVEC APPLE';

  @override
  String get continueWithGoogle => 'CONTINUER AVEC GOOGLE';

  @override
  String get authTermsDisclaimer =>
      'En continuant, vous acceptez nos Conditions d’utilisation et notre Politique de confidentialité. PepMod est un outil éducatif, pas un avis médical.';

  @override
  String get signIn => 'Se connecter';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get signInAction => 'SE CONNECTER';

  @override
  String get createAccountAction => 'CRÉER UN COMPTE';

  @override
  String get sendResetLink => 'ENVOYER LE LIEN DE RÉINITIALISATION';

  @override
  String get passwordResetSent =>
      'E-mail de réinitialisation du mot de passe envoyé. Vérifiez votre boîte de réception.';

  @override
  String get enterEmail => 'Saisissez votre e-mail';

  @override
  String get enterValidEmail => 'Saisissez une adresse e-mail valide';

  @override
  String get enterPassword => 'Entrez un mot de passe';

  @override
  String get passwordMinLength => 'Au moins 6 caractères';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ? Se connecter';

  @override
  String get backToSignIn => 'Retour à la connexion';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get showPassword => 'Afficher le mot de passe';

  @override
  String get hidePassword => 'Masquer le mot de passe';

  @override
  String get accountDeletedTitle => 'Compte supprimé';

  @override
  String get accountDeletedBody =>
      'Votre compte PepMod et les données d\'application enregistrées ont été supprimées.';

  @override
  String get subscriptionUnavailable =>
      'Les plans d\'abonnement ne sont pas disponibles pour le moment. Veuillez réessayer.';

  @override
  String get upgradeUnavailable =>
      'La mise à niveau n\'est pas disponible pour le moment. Veuillez réessayer plus tard.';

  @override
  String get noPurchasesToRestore => 'Aucun achat trouvé à restaurer.';

  @override
  String get subscriptionErrorServiceUnavailable =>
      'Les achats sont temporairement indisponibles. Veuillez réessayer sous peu.';

  @override
  String get subscriptionErrorPlansUnavailable =>
      'Les plans d\'abonnement n\'ont pas pu être chargés. Vérifiez votre connexion et réessayez.';

  @override
  String get subscriptionErrorPurchaseCancelled => 'Achat annulé.';

  @override
  String get subscriptionErrorPurchaseNotAllowed =>
      'Les achats ne sont pas autorisés sur cet appareil.';

  @override
  String get subscriptionErrorPurchaseInvalid =>
      'L\'achat n\'a pas pu être finalisé. Veuillez vérifier votre compte et réessayer.';

  @override
  String get subscriptionErrorProductUnavailable =>
      'Cet abonnement n\'est pas disponible pour le moment. Veuillez choisir un autre plan ou réessayer plus tard.';

  @override
  String get subscriptionErrorNetwork =>
      'Vous êtes hors ligne. Vérifiez votre connexion et réessayez.';

  @override
  String get subscriptionErrorPurchaseFailed =>
      'L\'achat a échoué. Veuillez réessayer.';

  @override
  String get subscriptionErrorRestoreFailed =>
      'Les achats n\'ont pas pu être restaurés. Vérifiez votre connexion et réessayez.';

  @override
  String get unlockFullProtocol => 'Débloquez le protocole complet';

  @override
  String get premiumUnlimitedPeptides => 'Peptides illimités par protocole';

  @override
  String get premiumMultipleProtocols => 'Plusieurs protocoles actifs';

  @override
  String get premiumCalculator =>
      'Calculateur de reconstitution (tous les peptides)';

  @override
  String get premiumMetrics => 'Suivi des métriques corporelles + graphiques';

  @override
  String get upgradeNow => 'METTRE À NIVEAU MAINTENANT';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get notRightNow => 'Pas maintenant';

  @override
  String get protocolWeeklyPlanner => 'Planificateur hebdomadaire';

  @override
  String get protocolDoseHistory => 'Historique des doses';

  @override
  String get protocolCreate => 'Créer un protocole';

  @override
  String get protocolManage => 'GÉRER';

  @override
  String get protocolYourProtocol => 'Votre protocole';

  @override
  String get protocolNoActive => 'Aucun protocole actif';

  @override
  String get protocolNoActiveBody =>
      'Créez votre premier protocole pour commencer à suivre les doses et à renforcer l’observance.';

  @override
  String get protocolStartFirst => 'DÉMARRER LE PREMIER PROTOCOLE';

  @override
  String get protocolScheduleTodaySystemLabel => 'PROGRAMME // AUJOURD’HUI';

  @override
  String get protocolAdherenceTodaySystemLabel => 'OBSERVANCE // AUJOURD’HUI';

  @override
  String get protocolNoDosesScheduledToday => 'Aucune dose prévue aujourd\'hui';

  @override
  String protocolDosesTaken(int taken, int total) {
    return '$taken sur $total doses prises';
  }

  @override
  String get protocolNextDose => 'PROCHAINE DOSE';

  @override
  String protocolInTime(String duration) {
    return 'Dans $duration';
  }

  @override
  String protocolDurationHoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String protocolDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get protocolLogDose => 'ENREGISTRER LA DOSE';

  @override
  String get protocolNow => 'maintenant';

  @override
  String get protocolMissed => 'MANQUÉ';

  @override
  String get protocolSkipped => 'SAUTÉ';

  @override
  String get protocolNoDosesToday => 'Pas de doses aujourd\'hui';

  @override
  String get protocolNoDosesTodayBody =>
      'Votre protocole ne prévoit aucune dose pour aujourd’hui.';

  @override
  String get protocolFreeLimit =>
      'L’offre gratuite est limitée à un protocole. Passez à Premium pour suivre plusieurs associations à la fois.';

  @override
  String protocolSyringeUnitsSuffix(String amount) {
    return ' · $amount unités de seringue';
  }

  @override
  String get injectionSiteLeftAbdomen => 'Abdomen gauche';

  @override
  String get injectionSiteRightAbdomen => 'Abdomen droit';

  @override
  String get injectionSiteLeftThigh => 'Cuisse gauche';

  @override
  String get injectionSiteRightThigh => 'Cuisse droite';

  @override
  String get injectionSiteLeftGlute => 'Fessier gauche';

  @override
  String get injectionSiteRightGlute => 'Fessier droit';

  @override
  String get injectionSiteLeftTriceps => 'Triceps gauche';

  @override
  String get injectionSiteRightTriceps => 'Triceps droit';

  @override
  String get injectionSiteLeftDeltoid => 'Deltoïde gauche';

  @override
  String get injectionSiteRightDeltoid => 'Deltoïde droit';

  @override
  String get plannerToday => 'AUJOURD\'HUI';

  @override
  String get plannerBack => 'Retour';

  @override
  String get plannerPreviousWeek => 'La semaine précédente';

  @override
  String get plannerNextWeek => 'La semaine prochaine';

  @override
  String plannerScheduledCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count doses programmées',
      one: '$count dose programmée',
    );
    return '$_temp0';
  }

  @override
  String get plannerTrackingDisclaimer =>
      'Suivi uniquement. Ce calendrier reflète votre protocole enregistré et ne fournit pas de conseils de dosage.';

  @override
  String get plannerWashoutPeriod => 'Période de pause';

  @override
  String plannerWashoutUntil(String date) {
    return 'Pause jusqu’au $date';
  }

  @override
  String get plannerNoScheduledDoses => 'Aucune dose programmée';

  @override
  String get plannerNothingPlanned =>
      'Rien n\'est prévu à partir de vos protocoles enregistrés.';

  @override
  String get activatePro => 'ACTIVER PRO';

  @override
  String activateProPrice(String price) {
    return 'ACTIVER PRO — $price/an';
  }

  @override
  String get annualAccess => 'Accès annuel';

  @override
  String get annualLabel => 'Annuel';

  @override
  String get averageRating => 'NOTE MOYENNE';

  @override
  String get bacWaterLabel => 'EAU BAC';

  @override
  String get basedOnInputs => 'Basé sur vos entrées //';

  @override
  String get bestValue => 'Meilleur rapport qualité-prix';

  @override
  String get birthDateInvalid =>
      'Entrez une date valide pour une personne âgée de 18 ans ou plus.';

  @override
  String get birthDateValid => 'Âge vérifié';

  @override
  String calculatorDemoBody(String peptideName) {
    return 'Voici comment cela fonctionne avec $peptideName';
  }

  @override
  String get calculatorDemoResult =>
      'C’est tout. Saisissez vos valeurs,\nobtenez les unités exactes de la seringue.';

  @override
  String get calculatorDemoTitle => 'Fini les\ncalculs complexes.';

  @override
  String get confidenceCycleTiming => 'Calendrier des cycles';

  @override
  String get confidenceCycleTimingDetail =>
      'Voir clairement les dates du protocole et les fenêtres de planification';

  @override
  String get confidenceDoseMath => 'Calcul de dose';

  @override
  String get confidenceDoseMathDetail =>
      'Regroupez le flacon, l’eau, la dose et les unités de prélèvement';

  @override
  String get confidenceLabel => 'CONFIANCE';

  @override
  String get confidencePlainInfo => 'Informations en langage simple';

  @override
  String get confidencePlainInfoDetail =>
      'Lisez des notes de recherche sans encombrement';

  @override
  String get confidenceProgressSignals => 'Signaux de progrès';

  @override
  String get confidenceProgressSignalsDetail =>
      'Voir l\'observance et les mesures corporelles au fil du temps';

  @override
  String get confidenceSafetyFraming => 'Encadrement de sécurité';

  @override
  String get confidenceSafetyFramingDetail =>
      'Gardez les informations éducatives et les avertissements bien visibles';

  @override
  String get confidenceSiteRotation => 'Rotation des sites';

  @override
  String get confidenceSiteRotationDetail =>
      'Rappelez-vous où chaque dose a été enregistrée';

  @override
  String get connectingToStore => 'CONNEXION À LA BOUTIQUE…';

  @override
  String continueSelected(int count) {
    return 'CONTINUER ($count)';
  }

  @override
  String get customProtocol => 'Protocole personnalisé';

  @override
  String get dateOfBirthLabel => 'DATE DE NAISSANCE';

  @override
  String get dayOne => 'JOUR 1';

  @override
  String get dayShortLabel => 'DD';

  @override
  String get defaultConfidence => 'Calcul des doses · Rotation des sites';

  @override
  String get defaultFrustration => 'Doses manquantes';

  @override
  String get defaultGoals => 'Récupération · Longévité';

  @override
  String get doseLabel => 'DOSE';

  @override
  String get dosesLogged => 'DOSES ENREGISTRÉES';

  @override
  String get dosesPerDay => 'DOSES/JOUR';

  @override
  String get drawVolumeLabel => 'VOLUME À PRÉLEVER';

  @override
  String get durationLabel => 'DURÉE';

  @override
  String get experienceAdvanced => 'Avancé';

  @override
  String get experienceAdvancedDetail =>
      'Je suis à l\'aise dans la gestion de protocoles détaillés';

  @override
  String get experienceFirstTime => 'Première fois';

  @override
  String get experienceFirstTimeDetail =>
      'Je suis nouveau dans le suivi des peptides';

  @override
  String get experienceIntermediate => 'INTERMÉDIAIRE';

  @override
  String get experienceLabel => 'EXPÉRIENCE';

  @override
  String get experienceNovice => 'NOVICE';

  @override
  String get experienceSome => 'Une certaine expérience';

  @override
  String get experienceSomeDetail => 'J\'ai suivi un ou deux protocoles';

  @override
  String get experienceVeteran => 'VÉTÉRAN';

  @override
  String get featureDoseMathBody =>
      'Conservez la taille du flacon, le volume d’eau, la dose et les unités à prélever à côté du protocole que vous suivez réellement.';

  @override
  String get featureDoseMathTitle => 'Calcul des doses\nEn contexte';

  @override
  String get featureProtocolArcBody =>
      'Consultez les doses planifiées, les doses enregistrées, l’observance et les mesures corporelles dans un seul calendrier.';

  @override
  String get featureProtocolArcTitle => 'Arc protocolaire\nAu fil du temps';

  @override
  String get featureShowcaseTitle =>
      'Tout ce dont vous avez besoin.\nUne application.';

  @override
  String get featureSiteRotationBody =>
      'Mémorisez chaque site que vous enregistrez et conservez l’historique de rotation attaché à l’enregistrement de dose.';

  @override
  String get featureSiteRotationTitle => 'Site d\'injection\nRotation';

  @override
  String get firstNameExample => 'par ex. Alex';

  @override
  String get firstNameLabel => 'PRÉNOM';

  @override
  String get frustrationForgetting => 'Oublier des doses';

  @override
  String get frustrationLabel => 'FRUSTRATION';

  @override
  String get frustrationMath => 'Calculs de flacon et de seringue';

  @override
  String get frustrationProgress => 'Voir si je reste régulier';

  @override
  String get frustrationSchedule => 'Respecter précisément le calendrier';

  @override
  String get frustrationStacking => 'Gestion de plusieurs peptides';

  @override
  String get frustrationTrust => 'Trouver des informations fiables';

  @override
  String get goalAntiAging => 'Vieillir en bonne santé';

  @override
  String get goalAntiAgingDetail =>
      'Organisez les dossiers axés sur la longévité';

  @override
  String get goalCognitive => 'Soutien cognitif';

  @override
  String get goalCognitiveDetail =>
      'Suivez la concentration et les performances mentales';

  @override
  String get goalImmune => 'Soutien immunitaire';

  @override
  String get goalImmuneDetail =>
      'Gardez les protocoles axés sur le système immunitaire organisés';

  @override
  String get goalMuscleGrowth => 'Croissance musculaire';

  @override
  String get goalMuscleGrowthDetail =>
      'Suivez les objectifs d’entraînement et de croissance';

  @override
  String get goalOther => 'Autre';

  @override
  String get goalOtherDetail => 'Définir un objectif de suivi différent';

  @override
  String get goalRecovery => 'Récupération';

  @override
  String get goalRecoveryDetail =>
      'Suivez les données et routines de récupération';

  @override
  String get goalSleep => 'Sommeil';

  @override
  String get goalSleepDetail =>
      'Suivez les objectifs et les habitudes liés au sommeil';

  @override
  String get goalWeightLoss => 'Perte de poids';

  @override
  String get goalWeightLossDetail =>
      'Suivez les objectifs métaboliques et les progrès';

  @override
  String get goalsLabel => 'OBJECTIFS';

  @override
  String get iUnderstand => 'JE COMPRENDS';

  @override
  String get lastThreeDaysAgo => 'Dernier : il y a 3 jours';

  @override
  String get leftAbdomen => 'Abdomen gauche';

  @override
  String get loveIt => 'J’ADORE';

  @override
  String get maybeLater => 'Peut-être plus tard';

  @override
  String get monthOne => 'MOIS 1';

  @override
  String get monthShortLabel => 'MM';

  @override
  String get monthTwo => 'MOIS 2';

  @override
  String moreCount(String shown, int count) {
    return '$shown + $count autres';
  }

  @override
  String get needsWork => 'À AMÉLIORER';

  @override
  String get notificationBody =>
      'Recevez des rappels discrets lorsqu’une fenêtre planifiée de votre protocole arrive à échéance. Aucun nom de peptide dans les notifications, juste un rappel discret.';

  @override
  String get notificationTitle => 'Gardez vos horaires de dose\nbien visibles.';

  @override
  String get nowLabel => 'maintenant';

  @override
  String get ok => 'D\'ACCORD';

  @override
  String get onboardingAgeConfirmed => 'J\'AI 18 ANS OU PLUS';

  @override
  String get onboardingAgeRequirementBody =>
      'Vous devez avoir 18 ans ou plus pour utiliser PepMod.';

  @override
  String get onboardingAgeRequirementTitle => 'Condition d\'âge';

  @override
  String get onboardingAgeVerificationBody =>
      'PepMod est destiné aux adultes âgés de 18 ans et plus.';

  @override
  String get onboardingAgeVerificationTitle =>
      'Tout d\'abord, confirmez\nvotre âge.';

  @override
  String get onboardingAheadBody =>
      'Répondez à quelques questions et PepMod organisera un aperçu de suivi personnalisé.';

  @override
  String get onboardingAheadTitle =>
      'Voir votre protocole\navant de commencer.';

  @override
  String get onboardingBirthDateBody =>
      'Cela confirme que vous remplissez la condition d’âge.';

  @override
  String get onboardingBirthDateTitle => 'Quand êtes-vous né?';

  @override
  String get onboardingConfidenceBody =>
      'Choisissez tout ce que PepMod devrait rendre plus clair.';

  @override
  String get onboardingConfidenceTitle =>
      'Sur quoi voulez-vous\nplus de confiance ?';

  @override
  String get onboardingConversionValueBody =>
      'Convertissez les valeurs de votre flacon et de votre plan en volume et en unités de seringue.';

  @override
  String get onboardingConversionValueTitle =>
      'Des calculs de flacon\nplus faciles à vérifier.';

  @override
  String get onboardingDisclaimerBody =>
      'PepMod aide à organiser les données, les rappels et les conversions d’unités. Il ne pose aucun diagnostic, ne prescrit rien et ne remplace pas les conseils d’un professionnel de santé qualifié.';

  @override
  String get onboardingDisclaimerTitle =>
      'Conçu pour la clarté.\nPas d\'ordonnances.';

  @override
  String get onboardingExperienceTitle => 'Quelle est votre\nexpérience ?';

  @override
  String get onboardingFrustrationBody =>
      'Choisissez le plus gros point de friction.';

  @override
  String get onboardingFrustrationTitle =>
      'Qu’est-ce qui vous semble\nle plus difficile aujourd’hui ?';

  @override
  String get onboardingGoalsTitle => 'Quels sont vos\nobjectifs principaux ?';

  @override
  String get onboardingGuidedStartBody =>
      'Nous adapterons la configuration à vos objectifs, à votre expérience et aux enregistrements que vous souhaitez conserver.';

  @override
  String get onboardingGuidedStartTitle =>
      'Un démarrage guidé,\nconçu autour de vous.';

  @override
  String get onboardingHookAnswer =>
      'PepMod garde la réponse à côté de votre protocole.';

  @override
  String get onboardingHookQuestion => 'Combien d’unités\nprélever ?';

  @override
  String get onboardingHookResearch => 'BIBLIOTHÈQUE DE RECHERCHE';

  @override
  String get onboardingHookSources => 'Sources liées aux preuves';

  @override
  String get onboardingHookVial => 'FLACON + DILUANT';

  @override
  String get onboardingNameBody =>
      'Nous l\'utiliserons pour personnaliser votre expérience PepMod.';

  @override
  String get onboardingNameTitle => 'Que devrions-nous\nt\'appeler ?';

  @override
  String get onboardingPeptideSelectBody =>
      'Choisissez les peptides que vous utilisez ou que vous souhaitez garder sur votre radar.';

  @override
  String get onboardingPeptideSelectTitle => 'Que suivez-vous ?';

  @override
  String get onboardingProgressValueBody =>
      'Regroupez l’observance, l’historique des doses et les mesures corporelles dans un seul enregistrement clair.';

  @override
  String get onboardingProgressValueTitle =>
      'Voir l\'arc complet\nau fil du temps.';

  @override
  String get onboardingProtocolValueBody =>
      'Planifiez les horaires, enregistrez les doses et conservez les détails joints à chaque protocole.';

  @override
  String get onboardingProtocolValueTitle =>
      'Gardez chaque protocole\nau même endroit.';

  @override
  String get onboardingUnder18 => 'J\'AI MOINS DE 18 ANS';

  @override
  String get openingPermission => 'OUVERTURE DE L’AUTORISATION…';

  @override
  String get paywallArcBody =>
      'Voyez ce qui était planifié, ce qui a été enregistré et ce qui mérite un suivi plus rigoureux.';

  @override
  String get paywallArcTitle => 'REGARDER L\'ARC AU FIL DU TEMPS';

  @override
  String get paywallBody =>
      'Calcul de dose, rotation des sites, rappels et historique du protocole, réunis dans un seul dossier.';

  @override
  String get paywallDoseMathBody =>
      'Regroupez le flacon, l’eau, la dose et les unités à prélever pour vérifier plus facilement chaque saisie.';

  @override
  String get paywallDoseMathTitle => 'MAÎTRISEZ VOS CALCULS DE DOSE';

  @override
  String get paywallPreviewDisclaimer =>
      'Conçu pour les enregistrements, les rappels et la clarté de l\'unité, et non pour les conseils médicaux.';

  @override
  String get paywallRotationBody =>
      'Chaque site, cycle et rappel reste attaché à l\'enregistrement du protocole.';

  @override
  String get paywallRotationTitle => 'NE PERDEZ JAMAIS VOTRE ROTATION';

  @override
  String get paywallTitle => 'Tout pour suivre\ncorrectement votre protocole.';

  @override
  String get paywallValueNote =>
      'Un calcul de flacon confus peut faire perdre du temps et du produit. PepMod conserve les calculs près du journal pour vous permettre de revérifier vos données avant de vous fier à d’anciennes notes.';

  @override
  String get peptideLabel => 'PEPTIDE';

  @override
  String get peptidesLabel => 'PEPTIDES';

  @override
  String get peptidesTracked => 'PEPTIDES\nSUIVI';

  @override
  String get perWeek => '/semaine';

  @override
  String get perYear => '/année';

  @override
  String get privacyLabel => 'Confidentialité';

  @override
  String processingGoals(int count) {
    return 'ANALYSE DE $count OBJECTIFS…';
  }

  @override
  String processingPeptides(int count) {
    return 'LIAISON DE $count DOSSIERS DE PEPTIDES…';
  }

  @override
  String get processingProtocol => 'CRÉATION DE VOTRE PROTOCOLE…';

  @override
  String get processingSchedule => 'ORGANISATION DE VOTRE CALENDRIER…';

  @override
  String get processingTitle => 'Construire votre\nprotocole';

  @override
  String get progressLabel => 'Progrès';

  @override
  String get protocolClarity => 'clarté du protocole';

  @override
  String get protocolIncludes => 'VOTRE PROTOCOLE COMPREND //';

  @override
  String get protocolPreviewTitle => 'Votre protocole\nest prêt.';

  @override
  String get protocolReady => 'PRÊT POUR LE PROTOCOLE //';

  @override
  String get protocolReminderReady => 'Le rappel du protocole est prêt';

  @override
  String get protocolReservedFor =>
      'VOTRE PROTOCOLE PERSONNALISÉ EST RÉSERVÉ PENDANT';

  @override
  String get restorePurchase => 'Restaurer l\'achat';

  @override
  String get resultsSummaryBody =>
      'Nous conserverons ensemble les journaux de dose, les calculs de reconstitution et les enregistrements de tendances au fur et à mesure que vos données s\'accumulent.';

  @override
  String get reviewGateBody =>
      'Vos commentaires nous aident à améliorer la plateforme pour chaque biohacker.';

  @override
  String get reviewGateTitle => 'Vous appréciez PepMod\njusqu’ici ?';

  @override
  String roadmapBody(int count, String need) {
    return 'Construit autour des peptides suivis $count et de votre besoin en $need.';
  }

  @override
  String get roadmapDayOneBody =>
      'Les peptides, les journaux de doses, la rotation des sites et les rappels sont prêts.';

  @override
  String get roadmapDayOneTitle => 'Votre premier protocole est organisé';

  @override
  String get roadmapDisclaimer =>
      'PepMod organise vos données et rappels. Il ne prescrit pas, ne diagnostique pas et ne remplace pas les conseils d’un professionnel de santé qualifié.';

  @override
  String get roadmapMonthOneBody =>
      'L\'observance, les doses oubliées et les paramètres corporels commencent à former un dossier plus propre.';

  @override
  String get roadmapMonthOneTitle =>
      'Votre historique de cohérence prend forme';

  @override
  String get roadmapMonthTwoBody =>
      'Découvrez ce que vous aviez prévu, ce qui s\'est passé et où vos dossiers nécessitent une attention particulière.';

  @override
  String get roadmapMonthTwoTitle =>
      'Votre arc protocolaire complet est visible';

  @override
  String get roadmapTitle => 'Voici ce qui\nvous attend.';

  @override
  String get roadmapWeekOneBody =>
      'Les notes de recherche et de suivi en langage clair restent jointes à votre plan.';

  @override
  String roadmapWeekOneTitle(String goal) {
    return 'Votre bibliothèque s’enrichit autour de $goal';
  }

  @override
  String savePercent(int percent) {
    return 'ÉCONOMISEZ $percent %';
  }

  @override
  String get saveRoadmap => 'SAUVEGARDER CETTE FEUILLE DE ROUTE';

  @override
  String get schedulePreview => 'APERÇU DU HORAIRE';

  @override
  String get seeWhatsInside => 'VOIR CE QU\'IL Y A À L\'INTÉRIEUR';

  @override
  String get selectAllThatApply => 'Sélectionnez tout ce qui s\'applique.';

  @override
  String get siteMap => 'Plan du site';

  @override
  String get skipForNow => 'PASSER POUR L’INSTANT';

  @override
  String get socialProofBody =>
      'Rejoignez des milliers de personnes qui suivent de réels progrès.';

  @override
  String get socialProofTitle =>
      'Approuvé par\nbiohackers dans le monde entier';

  @override
  String get specialOffer => 'OFFRE SPÉCIALE';

  @override
  String get startFreeTrial => 'COMMENCER UN ESSAI GRATUIT';

  @override
  String get subscribeLabel => 'S\'ABONNER';

  @override
  String subscribePrice(String price) {
    return 'ABONNEZ-VOUS — $price/semaine';
  }

  @override
  String subscribeAnnualPrice(String price) {
    return 'ABONNEZ-VOUS — $price/an';
  }

  @override
  String get subscribeToActivate => 'Abonnez-vous pour activer votre protocole';

  @override
  String get subscriptionRenewalDisclaimer =>
      'L\'abonnement se renouvelle automatiquement sauf annulation au moins 24 heures avant la fin de la période en cours. Gérer dans Paramètres > Identifiant Apple > Abonnements.';

  @override
  String syringeVolume(String volume) {
    return '$volume mL sur une seringue de 1 mL';
  }

  @override
  String get termsLabel => 'Conditions';

  @override
  String get testimonialOne =>
      'J’ai enfin arrêté d’oublier des doses. Le convertisseur de reconstitution m’a évité à lui seul des heures de calculs dans des feuilles de calcul.';

  @override
  String get testimonialThree =>
      'Le tracker de peptides le plus clair que j’aie utilisé. On sent qu’il a été conçu pour les utilisateurs exigeants.';

  @override
  String get testimonialTwo =>
      'Les informations hebdomadaires ont révélé un problème de calendrier que je n’avais pas remarqué depuis des mois. Ça a tout changé.';

  @override
  String get thirtyDayAdherence => 'Observance sur 30 jours';

  @override
  String get timelineLabel => 'Chronologie';

  @override
  String get trackedLabel => 'suivi';

  @override
  String get turnOnReminders => 'ACTIVER LES RAPPELS';

  @override
  String get unitConversionDisclaimer =>
      'Outil de conversion d’unités fourni à titre indicatif uniquement. Vérifiez toujours auprès d’un professionnel de santé qualifié.';

  @override
  String get unitsLabel => 'Unités';

  @override
  String get unitsToDraw => 'Unités à prélever';

  @override
  String get unlockPepMod => 'DÉBLOQUER PEPMOD';

  @override
  String get usersLabel => 'UTILISATEURS';

  @override
  String get viewLabel => 'VOIR';

  @override
  String get weekDuration => 'SEMAINE\nDURÉE';

  @override
  String get weekOne => 'SEMAINE 1';

  @override
  String get weeklyLabel => 'Hebdomadaire';

  @override
  String weeksCount(int count) {
    return '$count semaines';
  }

  @override
  String get yearLabel => 'ANNÉE';

  @override
  String get profileTitle => 'Vous';

  @override
  String get signedIn => 'Connecté';

  @override
  String get sectionAccount => 'COMPTE';

  @override
  String get sectionPreferences => 'PRÉFÉRENCES';

  @override
  String get sectionData => 'DONNÉES';

  @override
  String get sectionSupport => 'ASSISTANCE';

  @override
  String get sectionLegal => 'LÉGAL';

  @override
  String get sectionAbout => 'À PROPOS';

  @override
  String get nameLabel => 'Nom';

  @override
  String get accountLabel => 'Compte';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get removeAccountData => 'Supprimer le compte et les données';

  @override
  String get metricLabel => 'Métrique';

  @override
  String get imperialLabel => 'Impérial';

  @override
  String get notificationsLabel => 'Notifications';

  @override
  String get onLabel => 'Activé';

  @override
  String get offLabel => 'Désactivé';

  @override
  String get myCompoundsProfile => 'Mes composés';

  @override
  String get savedVialPresets => 'Préréglages de flacons enregistrés';

  @override
  String get exportData => 'Exporter des données';

  @override
  String get copyAsJson => 'Copier en JSON';

  @override
  String get clearAllData => 'Effacer toutes les données';

  @override
  String get clearingLabel => 'EFFACEMENT…';

  @override
  String get resetApp => 'Réinitialiser l\'application';

  @override
  String get contactSupport => 'Contacter l\'assistance';

  @override
  String get chatWithUs => 'Discutez avec nous';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get medicalDisclaimer => 'Avis de non-responsabilité médicale';

  @override
  String get disclaimerTitle => 'Clause de non-responsabilité';

  @override
  String get versionLabel => 'Version';

  @override
  String get signOutAction => 'SE DÉCONNECTER';

  @override
  String get educationalTrackingDisclaimer =>
      'Suivi pédagogique uniquement. Pas un avis médical.';

  @override
  String get yourName => 'Votre nom';

  @override
  String get cancelLabel => 'Annuler';

  @override
  String get saveLabel => 'Sauvegarder';

  @override
  String get dataCopied => 'Données copiées dans le presse-papiers.';

  @override
  String get clearDataTitle => 'Effacer toutes les données ?';

  @override
  String get clearDataBody =>
      'Cela supprime tous les protocoles, journaux de dose et mesures corporelles, puis redémarre l\'intégration. Votre compte, votre abonnement et votre bibliothèque de peptides sont conservés. Cela ne peut pas être annulé.';

  @override
  String get clearLabel => 'Effacer';

  @override
  String get clearingDataTitle => 'Effacement des données…';

  @override
  String get clearingDataBody =>
      'Gardez PepMod ouvert pendant que vos données de suivi sont supprimées.';

  @override
  String get clearDataFailed =>
      'Impossible d\'effacer les données. Vérifiez votre connexion et réessayez.';

  @override
  String get allDataCleared => 'Toutes les données effacées.';

  @override
  String get deleteAccountTitle => 'Supprimer le compte ?';

  @override
  String get deleteAccountBody =>
      'Cela supprime définitivement votre compte PepMod, vos paramètres, vos protocoles, vos journaux de dose et vos mesures corporelles. Cela ne peut pas être annulé.';

  @override
  String get deletingAccount => 'Suppression du compte…';

  @override
  String get accountDeletionFailed =>
      'La suppression du compte a échoué. Veuillez réessayer.';

  @override
  String get confirmPassword => 'Confirmez le mot de passe';

  @override
  String get deleteLabel => 'Supprimer';

  @override
  String get signOutTitle => 'Se déconnecter?';

  @override
  String get signOutBody =>
      'Vos protocoles restent enregistrés et synchronisés lorsque vous vous reconnectez.';

  @override
  String get signOutLabel => 'Se déconnecter';

  @override
  String get signOutFailed => 'Échec de la déconnexion. Veuillez réessayer.';

  @override
  String get notificationsDisabledSystem =>
      'Les notifications sont désactivées dans les paramètres système.';

  @override
  String get planPro => 'PRO';

  @override
  String get planFree => 'GRATUIT';

  @override
  String get termsBody =>
      'PepMod est fourni uniquement à des fins éducatives et de suivi. Il ne s\'agit pas d\'un dispositif médical et ne fournit aucun avis médical, diagnostic, prescription ou recommandation de traitement. En utilisant PepMod, vous êtes responsable de vos propres dossiers, décisions et consultations avec des professionnels de la santé qualifiés.\n\nLes abonnements se renouvellent automatiquement, sauf annulation via l\'App Store ou Google Play avant la période de renouvellement. Les remboursements sont traités par le magasin où vous avez acheté.\n\nConditions complètes : https://appstorecopilot.com/legal/yzh32x5v/terms';

  @override
  String get privacyBody =>
      'PepMod utilise Firebase pour l\'authentification et le stockage de données dans le cloud, RevenueCat pour les abonnements, AppRefer et Meta/Facebook App Events pour l\'attribution, et Firebase/Crashlytics pour l\'analyse et les diagnostics. Nous ne vendons pas vos informations personnelles. Vous pouvez supprimer votre compte et les données d\'application enregistrées depuis l\'application.\n\nPolitique de confidentialité complète : https://appstorecopilot.com/legal/yzh32x5v/privacy';

  @override
  String get medicalDisclaimerBody =>
      'PepMod est un outil de bien-être et de suivi – PAS un dispositif médical. Rien dans cette application ne constitue un avis médical, un diagnostic, une prescription ou une recommandation de traitement. Les peptides décrits dans la bibliothèque sont uniquement destinés à des fins éducatives. Consultez toujours un professionnel de la santé qualifié avant de commencer, de modifier ou d\'arrêter un régime. Si vous ressentez des effets indésirables, consultez immédiatement un médecin.';

  @override
  String get profileSystemLabel => 'SYS.UTILISATEUR // PROFIL';

  @override
  String get legalSystemLabel => 'SYS.LÉGAL';

  @override
  String get progressTitle => 'Progrès';

  @override
  String get progressSystemLabel => 'SYS.PROGRÈS // BIOMÉTRIE';

  @override
  String get doseHistoryTooltip => 'Ouvrir l’historique des doses';

  @override
  String get logMeasurementTooltip => 'Enregistrer une mesure';

  @override
  String get thirtyDayLabel => '30 JOURS';

  @override
  String get adherenceLabel => 'observance';

  @override
  String get streakLabel => 'SÉRIE';

  @override
  String get daysLabel => 'jours';

  @override
  String get totalLabel => 'TOTAL';

  @override
  String get dosesLabel => 'doses';

  @override
  String get protocolHistoryLabel => 'HISTORIQUE.PROTOCOLES';

  @override
  String get noProtocolsYet =>
      'Pas encore de protocoles. Créez-en un à partir de l’onglet Protocole.';

  @override
  String get adherenceChartLabel => 'OBSERVANCE // 30.JOURS';

  @override
  String get thirtyDaysAgo => 'il y a 30 jours';

  @override
  String get todayLabel => 'aujourd\'hui';

  @override
  String get noWeightData => 'Aucune donnée de poids';

  @override
  String get logFirstMeasurement =>
      'Enregistrez votre première mesure pour voir les tendances ici.';

  @override
  String get logMeasurementAction => 'ENREGISTRER UNE MESURE';

  @override
  String get weightTrendLabel => 'POIDS // TENDANCE';

  @override
  String weightKgValue(String weight) {
    return '$weight kg';
  }

  @override
  String get statusActive => 'ACTIF';

  @override
  String get statusPaused => 'EN PAUSE';

  @override
  String get statusEnded => 'TERMINÉ';

  @override
  String protocolPeptideCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count peptides',
      one: '1 peptide',
    );
    return '$_temp0';
  }

  @override
  String get enterOneMetric => 'Entrez au moins une valeur.';

  @override
  String get saveMetricFailed =>
      'Échec de l\'enregistrement. Essayer à nouveau.';

  @override
  String get newMeasurement => 'Nouvelle mesure';

  @override
  String get weightLabel => 'POIDS';

  @override
  String get bodyFatLabel => 'GRAISSE CORPORELLE';

  @override
  String get measurementsCmLabel => 'MESURES (cm)';

  @override
  String get waistLabel => 'TAILLE';

  @override
  String get chestLabel => 'POITRINE';

  @override
  String get armLabel => 'BRAS';

  @override
  String get saveAction => 'SAUVEGARDER';

  @override
  String get logMetricSystemLabel => 'LOG.MÉTRIQUE';

  @override
  String get activeLastSevenDays => '7 DERNIERS JOURS';

  @override
  String get activeAllTime => 'TOUT LE TEMPS';

  @override
  String get activeAdherence => 'observance';

  @override
  String get activeStarted => 'COMMENCÉ';

  @override
  String get activeEnded => 'TERMINÉ';

  @override
  String activeStackCount(int count) {
    return 'ASSOCIATION ($count)';
  }

  @override
  String get activeEditProtocol => 'MODIFIER LE PROTOCOLE';

  @override
  String get activePauseProtocol => 'METTRE LE PROTOCOLE EN PAUSE';

  @override
  String get activeEndProtocol => 'TERMINER LE PROTOCOLE';

  @override
  String get activeResumeProtocol => 'REPRENDRE LE PROTOCOLE';

  @override
  String get activeDeleteProtocol => 'SUPPRIMER LE PROTOCOLE';

  @override
  String get activeTrackingDisclaimer =>
      'Suivi pédagogique uniquement. Consultez un professionnel de la santé qualifié avant d’apporter des modifications.';

  @override
  String get activeEndQuestion => 'Terminer le protocole ?';

  @override
  String get activeEndBody =>
      'Les futures doses seront supprimées. Les journaux passés restent dans votre historique. Cela ne peut pas être annulé.';

  @override
  String get activeEndAction => 'TERMINER';

  @override
  String get activeDeleteQuestion => 'Supprimer le protocole ?';

  @override
  String get activeDeleteBody =>
      'Cela supprime définitivement le protocole et tous ses journaux de doses. Cela ne peut pas être annulé.';

  @override
  String get activeDeleteAction => 'SUPPRIMER';

  @override
  String get cancel => 'Annuler';

  @override
  String get activeStatusActive => 'ACTIF';

  @override
  String get activeStatusPaused => 'EN PAUSE';

  @override
  String get activeStatusEnded => 'TERMINÉ';

  @override
  String get activeNotesLabel => 'REMARQUES // PROTOCOLE';

  @override
  String get activeChangeReminders => 'RAPPELS DE CHANGEMENT';

  @override
  String get activeChangeRemindersBody =>
      'Lorsque les notifications sont activées, PepMod planifie un point de contrôle local à 9h00 pour chaque changement de phase à venir.';

  @override
  String activePhaseAnchor(String date) {
    return 'Les plages de semaines sont ancrées à $date.';
  }

  @override
  String activeWeek(int week) {
    return 'SEMAINE $week';
  }

  @override
  String activeWeeks(int start, int end) {
    return 'SEMAINES $start–$end';
  }

  @override
  String get activePerDayAmounts => 'Quantités quotidiennes';

  @override
  String get activeBaseAmount => 'Quantité de base';

  @override
  String get activeCurrent => 'ACTUEL';

  @override
  String get activeBaseSchedule => 'Calendrier de base';

  @override
  String get activeCustomDays => 'Jours personnalisés';

  @override
  String get activeContinuousTracking => 'Suivi continu';

  @override
  String get activeNoFixedCycle => 'Pas de fenêtre de cycle fixe';

  @override
  String activeCycleProgress(int week, int total) {
    return 'Semaine $week de $total';
  }

  @override
  String activeCycleEnds(String date) {
    return 'Fin du cycle $date';
  }

  @override
  String activeRestProgress(int week, int total) {
    return 'Semaine de repos $week du $total';
  }

  @override
  String activeRestEnds(String date) {
    return 'La fenêtre de repos se termine $date';
  }

  @override
  String get activeCycleComplete => 'Cycle terminé';

  @override
  String activeCompletedDate(String date) {
    return 'Terminé $date';
  }

  @override
  String activeRestEnded(String date) {
    return 'La fenêtre de repos s\'est terminée le $date';
  }

  @override
  String get activeNoHistory =>
      'Aucun protocole suspendu ou terminé pour l\'instant.';

  @override
  String activeCompoundsCount(int count) {
    return 'Composés $count';
  }

  @override
  String activeSyringeUnits(String amount) {
    return '$amount unités de seringue';
  }

  @override
  String activeCycleWeeks(int count) {
    return 'Cycle de $count sem.';
  }

  @override
  String activeRestWeeks(int count) {
    return '$count sem. de repos';
  }

  @override
  String get activePerDraw => 'PAR PRÉLÈVEMENT';

  @override
  String activeVialSummary(String volume) {
    return 'Flacon de $volume mL · U-100';
  }

  @override
  String get addCompound => 'AJOUTER UN COMPOSÉ';

  @override
  String get addPhase => 'AJOUTER UNE PHASE';

  @override
  String get addTime => 'Ajouter du temps';

  @override
  String get addToStack => 'AJOUTER À L’ASSOCIATION';

  @override
  String get amountRequired => 'Quantité requise';

  @override
  String get baseAmount => 'Quantité de base';

  @override
  String get baseSchedule => 'horaire de base';

  @override
  String get blendConfigBody =>
      'Saisissez exactement ce qui figure sur le flacon. PepMod convertit le prélèvement en un aperçu par composé.';

  @override
  String get blendIncompleteError =>
      'Renseignez au moins deux composés, le volume de diluant et la quantité à prélever.';

  @override
  String get blendNameHint => 'par ex. Mélange de récupération';

  @override
  String get blendNameLabel => 'NOM DU MÉLANGE';

  @override
  String get blendSafetyDisclaimer =>
      'Conversion d\'unité uniquement. PepMod ne recommande pas de méthode de mélange, de dose, de fréquence ou de reconstitution.';

  @override
  String get changeNoteHint => 'Votre propre contexte pour cette phase';

  @override
  String get changeNoteOptional => 'NOTE DE MODIFICATION (FACULTATIF)';

  @override
  String colorOption(String hex) {
    return 'Option couleur $hex';
  }

  @override
  String compoundNumber(int number) {
    return 'COMPOSÉ $number';
  }

  @override
  String compoundsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count composés',
      one: '1 composé',
    );
    return '$_temp0';
  }

  @override
  String copiedVialPreset(String amount, String unit) {
    return '$amount $unit préréglage du flacon · copié dans ce protocole';
  }

  @override
  String get createProtocolAction => 'CRÉER UN PROTOCOLE';

  @override
  String get createProtocolAddOneError => 'Ajoutez au moins un peptide.';

  @override
  String createProtocolBuildStep(int step, int total) {
    return 'Construire le protocole · Étape $step / $total';
  }

  @override
  String get createProtocolDefaultName => 'Mon protocole';

  @override
  String createProtocolEditStep(int step, int total) {
    return 'Modifier le protocole · Étape $step / $total';
  }

  @override
  String get createProtocolFreeLimitReason =>
      'L’offre gratuite est limitée à un peptide par protocole. Passez à Premium pour associer plusieurs composés.';

  @override
  String get createProtocolNameBody =>
      'Donnez-lui un nom facile à reconnaître, par ex. « Association récupération » ou « Q2 Shred ».';

  @override
  String get createProtocolNameTitle => 'Nommez votre protocole';

  @override
  String get createProtocolNoPeptides => 'Pas encore de peptides';

  @override
  String get createProtocolPickHint =>
      'Appuyez sur + pour choisir dans la bibliothèque';

  @override
  String get createProtocolReviewBody =>
      'Confirmez les détails du protocole. Vous pouvez modifier à tout moment à partir de la vue Gérer.';

  @override
  String get createProtocolSaveError =>
      'Échec de l\'enregistrement du protocole. Essayer à nouveau.';

  @override
  String get createProtocolStackBody =>
      'Ajoutez un peptide ou associez plusieurs composés. Configurez l’étiquette, la quantité, la fréquence et le cycle de chacun.';

  @override
  String get createProtocolStackTitle => 'Créez votre association';

  @override
  String get customBlend => 'Mélange personnalisé';

  @override
  String get customDays => 'Jours personnalisés';

  @override
  String get customDaysDisclaimer =>
      'Seuls les jours sélectionnés sont programmés. Les quantités sont des valeurs de suivi saisies par l’utilisateur, pas des conseils de dosage.';

  @override
  String get customPeptide => 'Peptide personnalisé';

  @override
  String get cycleWeeksLabel => 'SEMAINES DE CYCLE';

  @override
  String get cycleWindowDisclaimer =>
      'Les fenêtres de cycle et de repos organisent l’historique de suivi. PepMod ne planifiera pas les futures doses après la fin de la fenêtre du cycle.';

  @override
  String get defaultAmountLabel => 'QUANTITÉ PAR DÉFAUT';

  @override
  String get diluentVolumeLabel => 'VOLUME DE DILUANT';

  @override
  String get drawExceedsVialError =>
      'Le tirage ne peut pas dépasser le volume du flacon.';

  @override
  String get drawLabel => 'PRÉLÈVEMENT';

  @override
  String get drawPreviewLabel => 'APERÇU DU PRÉLÈVEMENT';

  @override
  String drawPreviewValue(String units, String volume) {
    return '$units unités = $volume mL';
  }

  @override
  String editTime(String time) {
    return 'Modifier l\'heure $time';
  }

  @override
  String get endWeekLabel => 'FIN DE SEMAINE';

  @override
  String get enterPeptideName => 'Entrez le nom du peptide';

  @override
  String get frequencyLabel => 'FRÉQUENCE';

  @override
  String get labelColorBody =>
      'Faites correspondre cette couleur à l’étiquette du stylo ou du flacon que vous utilisez dans la vraie vie.';

  @override
  String get labelColorLabel => 'COULEUR DE L\'ÉTIQUETTE';

  @override
  String get manageSavedCompounds => 'Gérer les composés enregistrés';

  @override
  String get nextLabel => 'SUIVANT';

  @override
  String get noneLabel => 'Aucun';

  @override
  String get oneOffCompound => 'Composé unique';

  @override
  String get oneOffCompoundBody =>
      'Utiliser une fois sans enregistrer de préréglage';

  @override
  String get optionalLabel => 'Facultatif';

  @override
  String peptidesCount(int count) {
    return 'PEPTIDES ($count)';
  }

  @override
  String get perDayAmounts => 'Quantités quotidiennes';

  @override
  String phaseExtendsWarning(int weeks) {
    return 'Une phase s’étend au-delà du cycle de $weeks semaines. Ajustez la fenêtre de phase ou de cycle.';
  }

  @override
  String get phaseNameHint => 'par ex. Suivi de la semaine 1';

  @override
  String get phaseNameLabel => 'NOM DE LA PHASE';

  @override
  String phaseNumber(int number) {
    return 'Phase $number';
  }

  @override
  String phaseOutsideCycleError(int weeks) {
    return 'Ce cycle de protocole se termine après la semaine $weeks. Gardez les semaines de phase à l’intérieur de cette fenêtre.';
  }

  @override
  String get phaseOverlapError =>
      'Les plages de semaines de phases ne peuvent pas se chevaucher.';

  @override
  String get phaseOverrideBody =>
      'Saisissez uniquement le calendrier de suivi que vous avez déjà l’intention de respecter. PepMod ne recommande aucune quantité.';

  @override
  String get phaseOverrideTitle => 'Remplacement hebdomadaire';

  @override
  String get phasePreviewDisclaimer =>
      'Aperçu de vos entrées uniquement. Aucun planning n\'est recommandé par PepMod.';

  @override
  String get phasePreviewLabel => 'APERÇU DES PHASES';

  @override
  String get phaseReminderBody =>
      'Un rappel de changement de phase neutre est programmé à 9h00 lorsque les rappels de protocole sont activés.';

  @override
  String get phaseScheduleLabel => 'CALENDRIER DES PHASES';

  @override
  String get phaseSelectDayError =>
      'Sélectionnez au moins un jour. PepMod ne choisira pas d\'horaire à votre place.';

  @override
  String get phasesBody =>
      'Des fenêtres de dates facultatives peuvent remplacer cette quantité et ce calendrier de base. En dehors de ces fenêtres, le calendrier de base continue.';

  @override
  String phasesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count phases',
      one: '1 phase',
    );
    return '$_temp0';
  }

  @override
  String get phasesDisclaimer =>
      'Les semaines sont comptées à partir de la date de début du protocole. Les notes de phase enregistrées et les rappels de modification ne sont que des aides au suivi.';

  @override
  String get preBlendedVial => 'Flacon pré-mélangé';

  @override
  String get preBlendedVialBody => 'Un flacon · un tirage · plusieurs composés';

  @override
  String get protocolNotesBody =>
      'Enregistrez le contexte que vous souhaitez voir lors de l’examen de ce protocole.';

  @override
  String get protocolNotesHint =>
      'par ex. questions, contexte de suivi ou notes du clinicien';

  @override
  String get protocolNotesLabel => 'Notes de protocole';

  @override
  String get reminderTimesBody =>
      'Chaque heure sélectionnée crée sa propre ligne de suivi et son propre rappel les jours planifiés.';

  @override
  String get reminderTimesLabel => 'HORAIRES DE RAPPEL';

  @override
  String get removeLabel => 'RETIRER';

  @override
  String removePeptide(String name) {
    return 'Supprimer $name';
  }

  @override
  String get removePhase => 'Supprimer la phase';

  @override
  String removeTime(String time) {
    return 'Supprimer l\'heure $time';
  }

  @override
  String get restWeeksLabel => 'SEMAINES DE REPOS';

  @override
  String get reviewLabel => 'Revoir';

  @override
  String get routeLabel => 'VOIE';

  @override
  String get saveBlend => 'ENREGISTRER LE MÉLANGE';

  @override
  String get saveChanges => 'ENREGISTRER LES MODIFICATIONS';

  @override
  String get savePhase => 'ENREGISTRER LA PHASE';

  @override
  String savedVialPreset(String amount, String unit) {
    return 'Flacon $amount $unit · Préréglage enregistré';
  }

  @override
  String get scheduleLabel => 'CALENDRIER';

  @override
  String get searchCompounds => 'Rechercher des composés...';

  @override
  String get selectDayError =>
      'Sélectionnez au moins un jour pour programmer ce peptide.';

  @override
  String selectOption(String option) {
    return 'Sélectionnez $option';
  }

  @override
  String get startDateLabel => 'DATE DE DÉBUT';

  @override
  String get startWeekLabel => 'DÉBUT DE LA SEMAINE';

  @override
  String syringeUnitsAmount(String amount) {
    return '$amount unités de seringue';
  }

  @override
  String get syringeUnitsDisclaimer =>
      'Marquages ​​​​facultatifs de la seringue U-100 saisis par l’utilisateur pour le suivi uniquement.';

  @override
  String get syringeUnitsHint => 'par ex. 12,5';

  @override
  String get syringeUnitsLabel => 'unités de seringue';

  @override
  String get syringeUnitsOptional => 'UNITÉS DE SERINGUE (FACULTATIF)';

  @override
  String get trackedAmountLabel => 'QUANTITÉ SUIVIE';

  @override
  String get u100TrackingDisclaimer =>
      'Utilise les graduations de seringue U-100 (100 unités = 1 mL). Les valeurs sont des données de suivi saisies par l’utilisateur.';

  @override
  String get unitLabel => 'UNITÉ';

  @override
  String get vialAmountHint => 'Quantité du flacon';

  @override
  String get vialContentsLabel => 'CONTENU DU FLACON';

  @override
  String get vialLabelNameHint => 'Nom figurant sur l\'étiquette du flacon';

  @override
  String weekNumber(int week) {
    return 'SEMAINE $week';
  }

  @override
  String weekRange(int start, int end) {
    return 'SEMAINES $start–$end';
  }

  @override
  String get weekToWeekPhases => 'PHASES SEMAINE PAR SEMAINE';

  @override
  String weekdayDose(String weekday) {
    return '$weekday DOSE';
  }

  @override
  String weekdaySchedule(String weekday) {
    return '$weekday HORAIRE';
  }

  @override
  String get doseDrawInvalid =>
      'Le tirage doit être supérieur à zéro et à l’intérieur du flacon.';

  @override
  String get doseGenericError =>
      'Quelque chose s\'est mal passé. Essayer à nouveau.';

  @override
  String get doseEditSystemLabel => 'MODIFIER.DOSE';

  @override
  String get doseLogSystemLabel => 'LOG.DOSE';

  @override
  String get doseDraw => 'PRÉLÈVEMENT';

  @override
  String get doseAmount => 'QUANTITÉ';

  @override
  String get doseUnits => 'unités';

  @override
  String get doseTime => 'HEURE';

  @override
  String get doseChooseTime => 'Choisissez l’heure de la dose';

  @override
  String get doseBlendSnapshot => 'INSTANTANÉ DE MÉLANGE // PAR TIRAGE';

  @override
  String doseSyringeUnitsRecorded(String amount) {
    return '$amount unités de seringue enregistrées pour cette dose.';
  }

  @override
  String get doseInjectionSite => 'SITE D\'INJECTION';

  @override
  String doseLastSite(String site) {
    return 'DERNIER SITE POUR CE PEPTIDE · $site';
  }

  @override
  String get doseNotes => 'REMARQUES';

  @override
  String get doseOptional => 'Facultatif...';

  @override
  String get doseMarkPending => 'MARQUER COMME EN ATTENTE';

  @override
  String get doseSaveChanges => 'ENREGISTRER LES MODIFICATIONS';

  @override
  String get doseSkip => 'IGNORER CETTE DOSE';

  @override
  String get doseHistorySystemLabel => 'HISTORIQUE.DOSES // 30.JOURS';

  @override
  String get doseHistoryTitle => 'Doses enregistrées';

  @override
  String get doseHistoryBody =>
      'Appuyez sur un enregistrement pour corriger sa quantité, son heure réelle, son site d\'injection, ses notes ou son statut.';

  @override
  String get doseHistoryEmpty =>
      'Aucune dose enregistrée au cours des 30 derniers jours.';

  @override
  String get doseLogPrevious => 'ENREGISTRER UNE DOSE PASSÉE';

  @override
  String doseHistorySkipped(String dateTime) {
    return 'Ignoré · $dateTime';
  }

  @override
  String doseHistoryTaken(String amount, String units, String dateTime) {
    return '$amount $units · $dateTime';
  }

  @override
  String get doseEditAction => 'MODIFIER';

  @override
  String get doseChoosePastTime =>
      'Choisissez une heure passée pour l’enregistrement.';

  @override
  String get dosePreviousError =>
      'Impossible d\'enregistrer la dose précédente. Essayer à nouveau.';

  @override
  String get doseLogPreviousSystemLabel => 'ENREGISTRER.PASSÉE';

  @override
  String get doseNoPeptides => 'Aucun peptide disponible';

  @override
  String get doseNoPeptidesBody =>
      'Ajoutez un peptide à un protocole actif avant d’enregistrer l’historique.';

  @override
  String get doseCorrectHistory => 'Corriger l’historique des doses';

  @override
  String get dosePeptide => 'PEPTIDE';

  @override
  String get doseDate => 'DATE';

  @override
  String get doseChooseDate => 'Choisissez la date de prise';

  @override
  String doseSyringeUnitsEntry(String amount) {
    return '$amount unités de seringue enregistrées pour cette entrée.';
  }

  @override
  String get doseHistoryDisclaimer =>
      'Les journaux historiques sont uniquement des enregistrements de suivi personnels. Ils ne modifient pas les conseils médicaux ni les recommandations posologiques.';

  @override
  String get notificationChannelName => 'Rappels de doses';

  @override
  String get notificationChannelDescription =>
      'Rappels programmés pour vos doses de protocole de peptide actif.';

  @override
  String get notificationDoseTitle => 'Il est temps de prendre votre dose';

  @override
  String get notificationDoseBody =>
      'Votre rappel de protocole programmé est prêt.';

  @override
  String get notificationCycleTitle => 'Point de contrôle du protocole';

  @override
  String get notificationCycleBody =>
      'Un rappel de fenêtre de cycle est dû aujourd\'hui. Passez en revue votre plan de suivi.';

  @override
  String get notificationRestTitle =>
      'Point de contrôle de la période de repos';

  @override
  String get notificationRestBody =>
      'Un rappel de période de repos est dû aujourd\'hui. Passez en revue votre plan de suivi.';

  @override
  String get notificationPhaseTitle =>
      'Point de contrôle de la phase du protocole';

  @override
  String get notificationPhaseBody =>
      'Une nouvelle phase de suivi démarre aujourd’hui. Vérifiez votre emploi du temps enregistré.';

  @override
  String get personalLibrarySystemLabel => 'SYS.BIBLIOTHÈQUE // PERSONNELLE';

  @override
  String get customCompoundIntro =>
      'Enregistrez les noms et tailles de flacon que vous saisissez vous-même. Les préréglages sont des raccourcis de suivi, pas des conseils de dose.';

  @override
  String get archivedHeading => 'ARCHIVÉ';

  @override
  String get activePresetsHeading => 'PRÉRÉGLAGES ACTIFS';

  @override
  String get showActive => 'Afficher actif';

  @override
  String get archivedAction => 'Archivé';

  @override
  String get customCompoundsLoadFailed =>
      'Impossible de charger vos composés. Essayer à nouveau.';

  @override
  String get libraryLoadFailed =>
      'Impossible de charger la bibliothèque de peptides. Essayer à nouveau.';

  @override
  String compoundVialSummary(String amount, String unit, String route) {
    return 'Flacon $amount $unit · $route';
  }

  @override
  String get editPreset => 'Modifier le préréglage';

  @override
  String get restorePreset => 'Restaurer';

  @override
  String get archivePreset => 'Archiver';

  @override
  String get noArchivedPresets => 'Aucun préréglage archivé';

  @override
  String get noSavedCompounds => 'Aucun composé enregistré';

  @override
  String get archivedPresetsHint =>
      'Les préréglages archivés restent ici jusqu\'à ce que vous les restauriez.';

  @override
  String get createPresetHint =>
      'Créez une étiquette réutilisable et un préréglage de taille de flacon.';

  @override
  String get presetCompoundSystemLabel => 'COMPOSÉ PRÉRÉGLÉ';

  @override
  String get newCompound => 'Nouveau composé';

  @override
  String get editCompound => 'Modifier le composé';

  @override
  String get ownVialDetailsHint =>
      'Entrez uniquement les détails imprimés sur votre propre flacon.';

  @override
  String get compoundLabel => 'NOM DU COMPOSÉ';

  @override
  String get compoundNameExample => 'par ex. Mon complexe';

  @override
  String get vialUnitLabel => 'UNITÉ FLACON';

  @override
  String get trackingUnitLabel => 'UNITÉ DE SUIVI';

  @override
  String get notesOptional => 'REMARQUES OPTIONNELLES';

  @override
  String get compoundNoteExample => 'Étiquette ou note de stockage';

  @override
  String get noDoseRecommendation =>
      'Aucune recommandation posologique n’est créée. Vous saisissez toujours les quantités du protocole séparément.';

  @override
  String get saveCompoundFailed =>
      'Impossible d\'enregistrer le préréglage. Essayer à nouveau.';

  @override
  String get routeTopical => 'Topique';

  @override
  String get frequencyCustomDays => 'Jours personnalisés';

  @override
  String savedCalculationLabel(
    String vialAmount,
    String vialUnit,
    String diluentVolume,
  ) {
    return '$vialAmount $vialUnit + $diluentVolume mL';
  }

  @override
  String savedCalculationDetail(
    String desiredAmount,
    String desiredUnit,
    String capacity,
  ) {
    return '$desiredAmount $desiredUnit · ${capacity}u';
  }

  @override
  String syringeOption(String volume, String capacity) {
    return 'U-100 · $volume mL / $capacity unités';
  }

  @override
  String get peptideContentHcgDescription =>
      'La gonadotrophine chorionique humaine (HCG) est une hormone glycoprotéique utilisée dans des cadres cliniques réglementés et fréquemment évoquée aux côtés des protocoles de peptides. Cette fiche est fournie à titre de référence neutre de suivi pour les calendriers saisis par l\'utilisateur.';

  @override
  String get peptideContentHcgTypicalDose => 'UI saisies par l\'utilisateur';

  @override
  String get peptideContentHcgHalfLife => '~24-36 heures';

  @override
  String get peptideContentHcgNotes =>
      'Soumis à prescription dans de nombreuses juridictions. Ne consignez que ce qui a déjà été indiqué par un professionnel de santé qualifié ; PepMod ne fournit aucune recommandation posologique concernant l’HCG.';

  @override
  String get peptideContentBpc157Description =>
      'Le BPC-157 (Body Protection Compound 157) est un peptide synthétique de 15 acides aminés dérivé d\'une protéine présente dans le suc gastrique. Il a été étudié dans des modèles animaux pour son rôle dans la réparation des tissus mous et de la muqueuse intestinale. Les données cliniques chez l\'humain restent limitées.';

  @override
  String get peptideContentBpc157TypicalDose => '250 à 500 µg';

  @override
  String get peptideContentBpc157HalfLife => '~4 heures';

  @override
  String get peptideContentBpc157Notes =>
      'Reconstituer avec de l\'eau bactériostatique et conserver au réfrigérateur. Souvent associé au TB-500 dans les protocoles de récupération des tendons et ligaments étudiés chez l\'animal.';

  @override
  String get peptideContentTb500Description =>
      'Le TB-500 est un fragment synthétique de la protéine naturelle thymosine bêta-4. Dans des études animales, il a été examiné pour son rôle dans la migration cellulaire et la régénération tissulaire. Il est largement utilisé hors indication par des chercheurs et en contexte vétérinaire.';

  @override
  String get peptideContentTb500TypicalDose =>
      '2–5 mg par semaine en phase de charge, puis 2 mg en entretien';

  @override
  String get peptideContentTb500HalfLife => '~2 jours';

  @override
  String get peptideContentTb500Notes =>
      'Souvent associé au BPC-157 dans les protocoles ciblant les tissus mous. Une répartition de la dose deux fois par semaine est courante en raison de la longue demi-vie.';

  @override
  String get peptideContentGhkCuDescription =>
      'Le GHK-Cu (peptide de cuivre) est un tripeptide naturel liant le cuivre, présent dans le plasma humain. Il a été étudié dans des applications cosmétiques topiques pour le remodelage cutané et la signalisation des follicules pileux.';

  @override
  String get peptideContentGhkCuTypicalDose => '1 à 2 mg';

  @override
  String get peptideContentGhkCuHalfLife => '~1 heure';

  @override
  String get peptideContentGhkCuNotes =>
      'Également utilisé par voie topique dans des formulations de soins de la peau. Les doses sous-cutanées sont généralement inférieures aux concentrations topiques.';

  @override
  String get peptideContentEpitalonDescription =>
      'Epitalon est un tétrapeptide synthétique analogue de l’épithalamine, un peptide extrait de la glande pinéale. Des recherches russes ont exploré ses effets sur l’activité de la télomérase et la régulation circadienne.';

  @override
  String get peptideContentEpitalonTypicalDose => '5–10 mg par jour de cycle';

  @override
  String get peptideContentEpitalonHalfLife => '~30 minutes';

  @override
  String get peptideContentEpitalonNotes =>
      'Généralement utilisé en courts cycles pulsés (par exemple 10 à 20 jours d\'utilisation, puis plusieurs mois d\'arrêt), sur la base de protocoles de recherche russes sur la longévité.';

  @override
  String get peptideContentSemaglutideDescription =>
      'Semaglutide est un agoniste des récepteurs GLP-1 initialement développé pour le diabète de type 2, puis approuvé pour la gestion chronique du poids sous les noms de marque Ozempic et Wegovy. Il ralentit la vidange gastrique et module la signalisation de l’appétit.';

  @override
  String get peptideContentSemaglutideTypicalDose =>
      '0,25–2,4 mg par semaine (titration progressive)';

  @override
  String get peptideContentSemaglutideHalfLife => '~7 jours';

  @override
  String get peptideContentSemaglutideNotes =>
      'Soumis à prescription dans la plupart des pays. Le schéma de titration débute à faible dose et augmente toutes les 4 semaines afin de limiter les effets secondaires gastro-intestinaux.';

  @override
  String get peptideContentTirzepatideDescription =>
      'Tirzepatide est un double agoniste des récepteurs GIP/GLP-1 approuvé pour le diabète de type 2 (Mounjaro) et l’obésité (Zepbound). Les essais cliniques ont montré des réductions de poids plus importantes qu’avec les agonistes simples du GLP-1.';

  @override
  String get peptideContentTirzepatideTypicalDose =>
      '2,5–15 mg par semaine (titration progressive)';

  @override
  String get peptideContentTirzepatideHalfLife => '~5 jours';

  @override
  String get peptideContentTirzepatideNotes =>
      'Soumis à prescription dans la plupart des pays. La titration standard se fait par paliers de 4 semaines. Injecté par voie sous-cutanée une fois par semaine.';

  @override
  String get peptideContentRetatrutideDescription =>
      'Retatrutide est un triple agoniste expérimental ciblant les récepteurs GIP, GLP-1 et du glucagon. Les essais de phase 2 ont rapporté des réductions de poids supérieures à celles des thérapies existantes à base de GLP-1.';

  @override
  String get peptideContentRetatrutideTypicalDose =>
      'Doses d\'essai de 1 à 12 mg par semaine';

  @override
  String get peptideContentRetatrutideHalfLife => '~6 jours';

  @override
  String get peptideContentRetatrutideNotes =>
      'Toujours en phase expérimentale — non approuvé par la FDA au moment de la rédaction. Toute utilisation en dehors d\'un essai clinique relève strictement de la recherche.';

  @override
  String get peptideContentIpamorelinDescription =>
      'Ipamorelin est un pentapeptide mimétique de la ghréline et un sécrétagogue sélectif de l’hormone de croissance. Il a été étudié pour sa capacité à stimuler une libération pulsatile de GH avec un effet minimal sur le cortisol ou la prolactine.';

  @override
  String get peptideContentIpamorelinTypicalDose => '200–300 mcg par injection';

  @override
  String get peptideContentIpamorelinHalfLife => '~2 heures';

  @override
  String get peptideContentIpamorelinNotes =>
      'Souvent associé au CJC-1295 (sans DAC) pour un pic de GH synergique. Le moment d’utilisation généralement rapporté est avant le coucher et/ou avant l’entraînement, à jeun.';

  @override
  String get peptideContentCjc1295DacDescription =>
      'Le CJC-1295 est un analogue synthétique de la GHRH. La variante DAC (Drug Affinity Complex) se lie à l\'albumine sérique, prolongeant sa demi-vie et produisant des taux de GH soutenus plutôt que des pics ponctuels.';

  @override
  String get peptideContentCjc1295DacTypicalDose => '1–2 mg par semaine';

  @override
  String get peptideContentCjc1295DacHalfLife => '~8 jours';

  @override
  String get peptideContentCjc1295DacNotes =>
      'Action prolongée — généralement dosé une à deux fois par semaine. Élève le niveau de base de GH/IGF-1 plutôt que de produire des pics marqués.';

  @override
  String get peptideContentCjc1295NoDacDescription =>
      'Le CJC-1295 sans DAC — également connu sous le nom de Mod-GRF(1-29) — est un analogue de la GHRH à demi-vie courte. Il est généralement associé à un GHRP tel que l\'Ipamoréline pour déclencher une libération pulsatile naturelle de GH.';

  @override
  String get peptideContentCjc1295NoDacTypicalDose => '100 mcg par injection';

  @override
  String get peptideContentCjc1295NoDacHalfLife => '~30 minutes';

  @override
  String get peptideContentCjc1295NoDacNotes =>
      'Action courte — à associer à un GHRP (Ipamoréline, GHRP-2, GHRP-6) pour amplifier les pics de GH. Généralement dosé 1 à 3 fois par jour, à jeun.';

  @override
  String get peptideContentTesamorelinDescription =>
      'Tesamorelin est un analogue stabilisé de la GHRH approuvé pour réduire l’excès de graisse viscérale abdominale dans la lipodystrophie associée au VIH (nom commercial Egrifta). Il a également été étudié dans des contextes de vieillissement cognitif.';

  @override
  String get peptideContentTesamorelinTypicalDose => '1–2 mg par jour';

  @override
  String get peptideContentTesamorelinHalfLife => '~30 minutes';

  @override
  String get peptideContentTesamorelinNotes =>
      'Médicament sur ordonnance. Principalement étudié pour la réduction du tissu adipeux viscéral. Administré une fois par jour par voie sous-cutanée.';

  @override
  String get peptideContentMotsCDescription =>
      'Le MOTS-c est un peptide d\'origine mitochondriale codé dans le gène MT-RNR1. La recherche a étudié son rôle dans l\'homéostasie métabolique, la sensibilité à l\'insuline et la physiologie de l\'exercice.';

  @override
  String get peptideContentMotsCTypicalDose => '5–10 mg 2 à 3x par semaine';

  @override
  String get peptideContentMotsCHalfLife => '~90 minutes';

  @override
  String get peptideContentMotsCNotes =>
      'Recherche encore émergente. Certains utilisateurs rapportent une amélioration de la récupération à l\'effort et des marqueurs métaboliques dans des journaux d\'auto-expérimentation.';

  @override
  String get peptideContentCerebrolysinDescription =>
      'Cerebrolysin est un mélange de peptides et d’acides aminés de faible poids moléculaire dérivés de tissu cérébral porcin. Il est prescrit dans plusieurs pays européens et asiatiques pour des indications neurodégénératives et de récupération après un AVC.';

  @override
  String get peptideContentCerebrolysinTypicalDose =>
      'Ampoules de 5–30 ml (cadre clinique)';

  @override
  String get peptideContentCerebrolysinHalfLife => 'Variable (mélange)';

  @override
  String get peptideContentCerebrolysinNotes =>
      'Généralement administré en cure sous supervision clinique. Non disponible aux États-Unis. Recherche sur l\'AVC ischémique et la maladie d\'Alzheimer.';

  @override
  String get peptideContentSelankDescription =>
      'Le Selank est un heptapeptide synthétique développé en Russie comme analogue du peptide immunomodulateur tuftsine. Il a été étudié pour ses effets anxiolytiques sans la sédation ni la dépendance associées aux benzodiazépines.';

  @override
  String get peptideContentSelankTypicalDose =>
      '250–500 mcg par voie intranasale';

  @override
  String get peptideContentSelankHalfLife => '~quelques minutes (systémique)';

  @override
  String get peptideContentSelankNotes =>
      'Le plus souvent administré par voie intranasale. La recherche russe se concentre sur l\'anxiété et l\'attention. Demi-vie courte mais effets rapportés durant plusieurs heures.';

  @override
  String get peptideContentSemaxDescription =>
      'Le Semax est un heptapeptide synthétique dérivé d\'un fragment de l\'ACTH (4–10). La recherche russe a étudié ses effets nootropiques et neuroprotecteurs, en particulier dans des protocoles de récupération post-AVC.';

  @override
  String get peptideContentSemaxTypicalDose =>
      '250–1000 mcg par voie intranasale';

  @override
  String get peptideContentSemaxHalfLife => '~30 minutes';

  @override
  String get peptideContentSemaxNotes =>
      'L\'administration intranasale est typique. Approuvé en Russie pour l\'AVC ischémique. Souvent cyclé avec le Selank pour des effets complémentaires.';

  @override
  String get peptideContentMelanotanIiDescription =>
      'Le Melanotan II est un analogue synthétique de l\'hormone alpha-mélanotrope (α-MSH). Il a été initialement développé comme agent de bronzage sans exposition solaire et a également été associé à des effets sur l\'appétit et la libido.';

  @override
  String get peptideContentMelanotanIiTypicalDose =>
      '250–1000 mcg en charge, puis entretien';

  @override
  String get peptideContentMelanotanIiHalfLife => '~1 heure';

  @override
  String get peptideContentMelanotanIiNotes =>
      'Non approuvé pour un usage médical. Les effets secondaires courants rapportés incluent des nausées et un assombrissement des grains de beauté existants. Tout grain de beauté nouveau ou évolutif doit être évalué par un dermatologue.';

  @override
  String get peptideContentPt141Description =>
      'PT-141, également connu sous le nom de Bremelanotide et commercialisé sous le nom de Vyleesi, est un agoniste des récepteurs à la mélanocortine approuvé par la FDA pour le trouble du désir sexuel hypoactif chez les femmes préménopausées. Il agit sur des voies du système nerveux central.';

  @override
  String get peptideContentPt141TypicalDose => '1,25–1,75 mg au besoin';

  @override
  String get peptideContentPt141HalfLife => '~2 heures';

  @override
  String get peptideContentPt141Notes =>
      'Médicament sur ordonnance sur certains marchés. Pris au besoin plutôt que selon un calendrier fixe. Les effets secondaires courants incluent des nausées et des hausses transitoires de la tension artérielle.';

  @override
  String get peptideContentDsipDescription =>
      'Le peptide inducteur du sommeil delta (DSIP) est un nonapeptide isolé du cerveau de lapin dans les années 1970. Il a été étudié pour ses rôles possibles dans la régulation du sommeil, la modulation de la douleur et la réponse au stress, bien que ses mécanismes restent mal compris.';

  @override
  String get peptideContentDsipTypicalDose => '100–500 mcg avant le coucher';

  @override
  String get peptideContentDsipHalfLife => '~7 minutes';

  @override
  String get peptideContentDsipNotes =>
      'Généralement administré avant le coucher. Demi-vie plasmatique courte mais les effets rapportés peuvent durer plus longtemps. La base de données probantes reste limitée.';

  @override
  String get peptideContentThymosinAlpha1Description =>
      'La Thymosin Alpha-1 est un peptide de 28 acides aminés initialement isolé du tissu thymique. Elle a été approuvée dans plusieurs pays comme thérapie immunomodulatrice d\'appoint (nom commercial Zadaxin) pour les hépatites B et C.';

  @override
  String get peptideContentThymosinAlpha1TypicalDose =>
      '1,6 mg deux fois par semaine';

  @override
  String get peptideContentThymosinAlpha1HalfLife => '~2 heures';

  @override
  String get peptideContentThymosinAlpha1Notes =>
      'Utilisée sur plusieurs marchés internationaux dans le cadre de protocoles d\'immunomodulation. Généralement administrée deux fois par semaine. La recherche se poursuit dans diverses indications.';

  @override
  String get peptideContentNadPlusDescription =>
      'Le NAD+ (nicotinamide adénine dinucléotide) est une coenzyme centrale du métabolisme énergétique cellulaire et de la réparation de l\'ADN. Le NAD+ injectable et ses précurseurs (NR, NMN) sont étudiés dans le contexte de la santé mitochondriale et du vieillissement.';

  @override
  String get peptideContentNadPlusTypicalDose =>
      '100–500 mg IV ou sous-cutané par séance';

  @override
  String get peptideContentNadPlusHalfLife => '~90 minutes';

  @override
  String get peptideContentNadPlusNotes =>
      'Techniquement une coenzyme plutôt qu\'un peptide, mais couramment regroupé avec les protocoles de longévité. Une perfusion lente est recommandée pour minimiser les bouffées de chaleur et l\'inconfort.';

  @override
  String get peptideContentSermorelinDescription =>
      'Sermorelin est un analogue synthétique de l’hormone de libération de l’hormone de croissance (GHRH). Il a été utilisé en clinique comme agent diagnostique de la réserve en hormone de croissance et est couramment évoqué dans les milieux du bien-être comme peptide de soutien de l’axe GH.';

  @override
  String get peptideContentSermorelinTypicalDose =>
      '100–300 mcg avant le coucher';

  @override
  String get peptideContentSermorelinHalfLife => '~10 à 20 minutes';

  @override
  String get peptideContentSermorelinNotes =>
      'Souvent comparé au CJC-1295 sans DAC car les deux agissent sur la voie de la GHRH. Sa courte demi-vie explique que les prises en soirée soient courantes dans les protocoles non cliniques.';

  @override
  String get peptideContentAod9604Description =>
      'L\'AOD-9604 est un fragment modifié de l\'hormone de croissance humaine, dérivé de la région 176–191. Il a été étudié pour la signalisation métabolique et lipolytique, mais les données humaines publiées restent limitées et contrastées.';

  @override
  String get peptideContentAod9604TypicalDose => '250–500 mcg par jour';

  @override
  String get peptideContentAod9604HalfLife => '~30 minutes';

  @override
  String get peptideContentAod9604Notes =>
      'Également appelé fragment HGH 176–191 dans certaines discussions. Ce n\'est pas un médicament amaigrissant approuvé ; utiliser un langage de suivi neutre et éviter toute garantie de résultat.';

  @override
  String get peptideContentKpvDescription =>
      'Le KPV est une courte séquence tripeptidique (lysine-proline-valine) dérivée de l\'hormone alpha-mélanotrope. Il est évoqué dans des contextes de recherche pour la signalisation immunitaire et de la barrière intestinale.';

  @override
  String get peptideContentKpvTypicalDose => '250–500 mcg par jour';

  @override
  String get peptideContentKpvHalfLife => 'Pas bien établie';

  @override
  String get peptideContentKpvNotes =>
      'Apparaît dans les discussions sur la santé intestinale et l\'usage topique, y compris dans des protocoles informels combinés au BPC-157. Les données de dosage humain sont limitées, les protocoles doivent donc rester prudents.';

  @override
  String get peptideContentSs31Description =>
      'Le SS-31, également connu sous le nom d\'Elamipretide, est un tétrapeptide ciblant les mitochondries, étudié pour ses interactions avec la cardiolipine et la fonction membranaire mitochondriale. La recherche clinique s\'est concentrée sur des affections mitochondriales et cardiaques rares.';

  @override
  String get peptideContentSs31TypicalDose => 'Les protocoles d\'essai varient';

  @override
  String get peptideContentSs31HalfLife => '~4 heures';

  @override
  String get peptideContentSs31Notes =>
      'Expérimental dans de nombreux contextes. Les protocoles communautaires diffèrent souvent des formulations des essais cliniques et doivent être considérés comme réservés à la recherche.';

  @override
  String get peptideContentLl37Description =>
      'Le LL-37 est un peptide antimicrobien humain de la famille des cathélicidines impliqué dans la signalisation immunitaire innée. Il est évoqué dans les communautés de recherche pour les voies de défense de l\'hôte et de réponse tissulaire, mais les considérations de sécurité sont importantes.';

  @override
  String get peptideContentLl37TypicalDose =>
      'Les protocoles de recherche varient';

  @override
  String get peptideContentLl37HalfLife => 'Pas bien établie';

  @override
  String get peptideContentLl37Notes =>
      'Hautement expérimental en dehors de la recherche contrôlée. Comme les peptides antimicrobiens peuvent affecter la signalisation immunitaire, un cadrage éducatif prudent est important.';

  @override
  String get peptideContentDihexaDescription =>
      'Le Dihexa est un analogue peptidique dérivé de l\'angiotensine IV, actif par voie orale, étudié en préclinique pour la signalisation du facteur de croissance des hépatocytes/c-Met et l\'activité synaptogénique. Les données humaines de sécurité et d\'efficacité ne sont pas établies.';

  @override
  String get peptideContentDihexaTypicalDose =>
      'Réservé à la recherche ; les protocoles varient';

  @override
  String get peptideContentDihexaHalfLife => 'Pas bien établie';

  @override
  String get peptideContentDihexaNotes =>
      'Populaire dans les discussions nootropiques mais très expérimental. À considérer comme une entrée de composé de recherche plutôt qu\'un protocole suggéré.';

  @override
  String get peptideContentGhrp2Description =>
      'Le GHRP-2 est un peptide de libération de l\'hormone de croissance synthétique agissant comme agoniste du récepteur de la ghréline. Il a été étudié pour la sécrétion de GH, la signalisation de l\'appétit et les tests endocriniens.';

  @override
  String get peptideContentGhrp2TypicalDose => '100–300 mcg par injection';

  @override
  String get peptideContentGhrp2HalfLife => '~20 à 30 minutes';

  @override
  String get peptideContentGhrp2Notes =>
      'Souvent associé à un analogue de la GHRH tel que le CJC-1295 sans DAC ou la Sermoréline. Il peut affecter davantage l\'appétit, le cortisol et la prolactine que l\'Ipamoréline.';

  @override
  String get peptideContentGhrp6Description =>
      'Le GHRP-6 est un hexapeptide synthétique et agoniste du récepteur de la ghréline étudié pour la libération d\'hormone de croissance et la signalisation de l\'appétit. C\'est l\'un des plus anciens peptides de la famille des GHRP.';

  @override
  String get peptideContentGhrp6TypicalDose => '100–300 mcg par injection';

  @override
  String get peptideContentGhrp6HalfLife => '~20 à 30 minutes';

  @override
  String get peptideContentGhrp6Notes =>
      'L\'usage communautaire met souvent l\'accent sur la stimulation de l\'appétit. Des options plus sélectives comme l\'Ipamoréline sont généralement préférées lorsque les effets sur l\'appétit ne sont pas souhaités.';

  @override
  String get peptideContentHexarelinDescription =>
      'Hexarelin est un sécrétagogue synthétique de l’hormone de croissance et un agoniste du récepteur de la ghréline étudié pour la libération de GH et les signaux cardiovasculaires en recherche. Il est généralement considéré comme l’un des GHRP les plus puissants.';

  @override
  String get peptideContentHexarelinTypicalDose => '100–200 mcg par injection';

  @override
  String get peptideContentHexarelinHalfLife => '~70 minutes';

  @override
  String get peptideContentHexarelinNotes =>
      'Souvent cyclé de manière plus prudente que l\'Ipamoréline en raison de sa puissance et des préoccupations de désensibilisation évoquées dans les communautés de recherche.';

  @override
  String get peptideContentIgf1Lr3Description =>
      'L\'IGF-1 LR3 est un analogue modifié du facteur de croissance insulinique de type 1, avec des substitutions d\'acides aminés qui réduisent l\'affinité pour les protéines de liaison et prolongent l\'activité. Il est surtout évoqué dans des contextes de recherche avancée sur la performance et la croissance cellulaire.';

  @override
  String get peptideContentIgf1Lr3TypicalDose =>
      '20–50 mcg par jour dans les protocoles de recherche';

  @override
  String get peptideContentIgf1Lr3HalfLife => '~20–30 heures';

  @override
  String get peptideContentIgf1Lr3Notes =>
      'Composé de recherche à risque plus élevé. Les préoccupations potentielles liées à la glycémie et à la signalisation de croissance tissulaire rendent la supervision médicale particulièrement importante.';

  @override
  String get peptideContentIgf1DesDescription =>
      'L\'IGF-1 DES est un analogue de l\'IGF-1 plus court, dépourvu des trois premiers acides aminés. Il est évoqué comme variante d\'IGF à action plus courte dans la recherche sur la signalisation tissulaire locale.';

  @override
  String get peptideContentIgf1DesTypicalDose =>
      '20–50 mcg dans les protocoles de recherche';

  @override
  String get peptideContentIgf1DesHalfLife => '~20 à 30 minutes';

  @override
  String get peptideContentIgf1DesNotes =>
      'Très avancé et expérimental. Éviter les suggestions de protocole générales car les données de sécurité humaine et la surveillance appropriée restent limitées.';

  @override
  String get peptideContentPegMgfDescription =>
      'Le PEG-MGF est une variante pégylée du facteur de croissance mécanique, un peptide variant d\'épissage de l\'IGF-1. La pégylation vise à prolonger le temps de circulation par rapport au MGF non modifié.';

  @override
  String get peptideContentPegMgfTypicalDose =>
      '100–300 mcg par semaine dans les protocoles de recherche';

  @override
  String get peptideContentPegMgfHalfLife => 'Prolongée par la PEGylation';

  @override
  String get peptideContentPegMgfNotes =>
      'Courant dans les forums de performance mais non approuvé comme thérapie. À considérer comme une entrée de recherche avancée avec des paramètres de suivi prudents par défaut.';

  @override
  String get peptideContentMk677Description =>
      'Le MK-677, également connu sous le nom d\'Ibutaморен, est un agoniste du récepteur de la ghréline actif par voie orale et sécrétagogue de l\'hormone de croissance. Ce n\'est pas un peptide, mais il est couramment évoqué aux côtés des peptides de l\'axe GH.';

  @override
  String get peptideContentMk677TypicalDose => '10–25 mg par jour';

  @override
  String get peptideContentMk677HalfLife => '~24 heures';

  @override
  String get peptideContentMk677Notes =>
      'Composé apparenté, pas un peptide. Les discussions communautaires mentionnent souvent l\'appétit, la rétention d\'eau, le sommeil et le suivi de la glycémie.';

  @override
  String get peptideContentFiveAmino1mqDescription =>
      'Le 5-Amino-1MQ est une petite molécule inhibitrice de la NNMT évoquée dans les communautés métaboliques et de composition corporelle. Ce n\'est pas un peptide, mais il apparaît souvent dans des protocoles de longévité et de perte de graisse proches des peptides.';

  @override
  String get peptideContentFiveAmino1mqTypicalDose => '25–100 mg par jour';

  @override
  String get peptideContentFiveAmino1mqHalfLife => 'Pas bien établie';

  @override
  String get peptideContentFiveAmino1mqNotes =>
      'Composé apparenté, pas un peptide. Les données humaines sont limitées ; éviter les affirmations sur les résultats de perte de graisse ou de sensibilité à l\'insuline.';

  @override
  String get peptideContentTesofensineDescription =>
      'La Tesofensine est un inhibiteur oral de recapture des monoamines étudié pour l\'obésité et les affections neurodégénératives. Ce n\'est pas un peptide, mais elle est fréquemment évoquée dans les communautés de gestion du poids à proximité des composés GLP-1.';

  @override
  String get peptideContentTesofensineTypicalDose =>
      '0,25–0,5 mg par jour dans les études';

  @override
  String get peptideContentTesofensineHalfLife => '~9 jours';

  @override
  String get peptideContentTesofensineNotes =>
      'Composé apparenté, pas un peptide. Comme il affecte les voies des neurotransmetteurs, la tension artérielle et la fréquence cardiaque, le dépistage des interactions est important.';

  @override
  String get peptideContentRu58841Description =>
      'Le RU-58841 est un antiandrogène topique non stéroïdien étudié pour la signalisation des récepteurs aux androgènes dans le contexte des follicules pileux. Ce n\'est pas un peptide, mais il est souvent évoqué dans les communautés esthétiques proches des peptides.';

  @override
  String get peptideContentRu58841TypicalDose =>
      'Topique 25–50 mg par jour dans des protocoles informels';

  @override
  String get peptideContentRu58841HalfLife => 'Pas bien établie';

  @override
  String get peptideContentRu58841Notes =>
      'Composé apparenté, pas un peptide et non un médicament approuvé. Les préoccupations relatives au contrôle qualité et à l\'exposition systémique sont des sujets de discussion courants.';

  @override
  String get peptideContentEducationalDisclaimer =>
      'À titre éducatif uniquement. Ceci ne constitue pas un avis médical. Les peptides de recherche ne sont pas approuvés pour un usage humain dans la plupart des juridictions — consultez toujours un professionnel de santé qualifié.';

  @override
  String get twiceWeeklyPickDaysHint =>
      'Choisis exactement deux jours de la semaine pour ce planning.';

  @override
  String get selectExactlyTwoDaysError =>
      'Sélectionne exactement deux jours pour un planning de 2 fois par semaine.';

  @override
  String get remindersBlockedTitle => 'Les rappels sont bloqués';

  @override
  String get remindersBlockedBody =>
      'Les rappels de dose sont activés dans PepMod, mais les notifications sont désactivées dans les réglages système : ils ne peuvent donc pas être envoyés.';

  @override
  String get openSettingsAction => 'Ouvrir les réglages';

  @override
  String freeTrialBadgeDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ESSAI GRATUIT DE $count JOURS',
      one: 'ESSAI GRATUIT DE $count JOUR',
    );
    return '$_temp0';
  }

  @override
  String freeTrialBadgeWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ESSAI GRATUIT DE $count SEMAINES',
      one: 'ESSAI GRATUIT DE $count SEMAINE',
    );
    return '$_temp0';
  }

  @override
  String freeTrialBadgeMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ESSAI GRATUIT DE $count MOIS',
      one: 'ESSAI GRATUIT DE $count MOIS',
    );
    return '$_temp0';
  }

  @override
  String freeTrialBadgeYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ESSAI GRATUIT DE $count ANS',
      one: 'ESSAI GRATUIT DE $count AN',
    );
    return '$_temp0';
  }

  @override
  String get createCustomCompoundAction => 'Créer un composé personnalisé';

  @override
  String get noPeptidesFoundCreateHint =>
      'Aucun résultat dans la bibliothèque de référence. Tu peux quand même le suivre comme composé personnalisé.';

  @override
  String get blendSearchHint =>
      'Les noms de mélanges comme celui-ci n\'ont pas de formulation standard — le contenu varie selon le fournisseur. Crée-le ici comme composé personnalisé, ou comme flacon pré-mélangé lors de la création d\'un protocole, en saisissant le contenu réel de ton flacon.';

  @override
  String get typicalDoseReferenceNote =>
      'Plage de référence publiée à titre éducatif — ni une recommandation ni une instruction.';

  @override
  String get peptideContentTestosteroneDescription =>
      'La testostérone est une hormone androgène endogène. Les préparations injectables d\'esters (comme le cypionate et l\'énanthate) sont des médicaments sur ordonnance utilisés en hormonothérapie supervisée par un clinicien. Cette fiche est une référence de suivi neutre pour des plannings saisis par l\'utilisateur.';

  @override
  String get peptideContentTestosteroneTypicalDose =>
      'mg saisis par l\'utilisateur';

  @override
  String get peptideContentTestosteroneHalfLife => 'Dépend de l\'ester';

  @override
  String get peptideContentTestosteroneNotes =>
      'Sur ordonnance uniquement et substance contrôlée dans de nombreuses juridictions. Ne suis que ce qui a été prescrit par un professionnel de santé qualifié ; PepMod ne fournit aucune indication de dosage de testostérone.';

  @override
  String get peptideContentGlutathioneDescription =>
      'Le glutathion est un tripeptide naturel (glutamate-cystéine-glycine) qui agit comme antioxydant intracellulaire majeur. Les formes injectables sont utilisées dans certains cadres cliniques et de bien-être. Cette fiche est une référence de suivi neutre pour des plannings saisis par l\'utilisateur.';

  @override
  String get peptideContentGlutathioneTypicalDose =>
      'mg saisis par l\'utilisateur';

  @override
  String get peptideContentGlutathioneHalfLife => 'Courte (systémique)';

  @override
  String get peptideContentGlutathioneNotes =>
      'Le statut réglementaire du glutathion injectable varie selon les pays. Suis les quantités exactement telles qu\'obtenues et prescrites ; PepMod ne fournit aucune indication de dosage pour ce composé.';

  @override
  String get peptideContentKisspeptin10Description =>
      'La kisspeptine-10 est un fragment de dix acides aminés du neuropeptide kisspeptine, étudié en recherche pour son rôle dans la signalisation de la GnRH et la régulation de l\'axe reproducteur. Les données humaines hors études contrôlées sont limitées. Cette fiche est une référence de suivi neutre pour des plannings saisis par l\'utilisateur.';

  @override
  String get peptideContentKisspeptin10TypicalDose =>
      'Saisi par l\'utilisateur';

  @override
  String get peptideContentKisspeptin10HalfLife => '~minutes (rapporté)';

  @override
  String get peptideContentKisspeptin10Notes =>
      'Composé de recherche sans protocoles établis. Ne suis que des quantités saisies par l\'utilisateur ; PepMod ne fournit aucune indication de dosage pour ce composé.';

  @override
  String get peptideContentSluPp332Description =>
      'Le SLU-PP-332 est un agoniste ERR expérimental à petite molécule étudié en préclinique dans la recherche en physiologie de l\'exercice. Ce n\'est pas un peptide et il n\'existe pas de données établies de sécurité ou d\'efficacité chez l\'humain. Cette fiche est une référence de suivi neutre pour des plannings saisis par l\'utilisateur.';

  @override
  String get peptideContentSluPp332TypicalDose => 'Saisi par l\'utilisateur';

  @override
  String get peptideContentSluPp332HalfLife => 'Mal établie';

  @override
  String get peptideContentSluPp332Notes =>
      'Composé de recherche hautement expérimental sans essais chez l\'humain. Composé apparenté, pas un peptide. Ne suis que des quantités saisies par l\'utilisateur ; PepMod ne fournit aucune indication de dosage pour ce composé.';
}
