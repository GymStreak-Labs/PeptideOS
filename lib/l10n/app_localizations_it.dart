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

  @override
  String get tabProtocol => 'Protocollo';

  @override
  String get tabProgress => 'Progressi';

  @override
  String get tabLibrary => 'Biblioteca';

  @override
  String get tabYou => 'Tu';

  @override
  String get continueLabel => 'CONTINUARE';

  @override
  String get processingLabel => 'ELABORAZIONE...';

  @override
  String get authAppleFailed => 'Accesso con Apple non riuscito. Riprova.';

  @override
  String get authGoogleFailed => 'Accesso con Google non riuscito. Riprova.';

  @override
  String get authGenericError => 'Si è verificato un problema. Riprova.';

  @override
  String get authUserNotFound =>
      'Nessun utente trovato con questo indirizzo email.';

  @override
  String get authIncorrectCredentials => 'E-mail o password errati.';

  @override
  String get authAccountExists => 'Esiste già un account con questa email.';

  @override
  String get authWeakPassword =>
      'La password è troppo debole. Utilizza almeno 6 caratteri.';

  @override
  String get authInvalidEmail => 'Indirizzo e-mail non valido.';

  @override
  String get authAppleUnavailable =>
      'L\'accesso con Apple non è abilitato per questa app.';

  @override
  String get authRequiredTitle => 'Salva il tuo\nprotocollo personalizzato';

  @override
  String get authRequiredBody =>
      'Salva sul tuo account il percorso, il programma, i registri delle dosi e i promemoria prima di sbloccare il protocollo.';

  @override
  String get continueWithEmail => 'CONTINUA CON L’E-MAIL';

  @override
  String get signInWithApple => 'ACCEDI CON APPLE';

  @override
  String get continueWithGoogle => 'CONTINUA CON GOOGLE';

  @override
  String get authTermsDisclaimer =>
      'Continuando, accetti i nostri Termini e l’Informativa sulla privacy. PepMod è uno strumento educativo, non un consiglio medico.';

  @override
  String get signIn => 'Accedi';

  @override
  String get createAccount => 'Creare un account';

  @override
  String get resetPassword => 'Reimposta la password';

  @override
  String get signInAction => 'ACCEDI';

  @override
  String get createAccountAction => 'CREARE UN ACCOUNT';

  @override
  String get sendResetLink => 'INVIA LINK DI RESET';

  @override
  String get passwordResetSent =>
      'E-mail di reimpostazione della password inviata. Controlla la tua casella di posta.';

  @override
  String get enterEmail => 'Inserisci la tua email';

  @override
  String get enterValidEmail => 'Inserisci un\'e-mail valida';

  @override
  String get enterPassword => 'Inserisci una password';

  @override
  String get passwordMinLength => 'Almeno 6 caratteri';

  @override
  String get forgotPassword => 'Password dimenticata?';

  @override
  String get alreadyHaveAccount => 'Hai già un account? Accedi';

  @override
  String get backToSignIn => 'Torna all’accesso';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Password';

  @override
  String get showPassword => 'Mostra password';

  @override
  String get hidePassword => 'Nascondi la password';

  @override
  String get accountDeletedTitle => 'Conto eliminato';

  @override
  String get accountDeletedBody =>
      'Il tuo account PepMod e i dati dell\'app salvati sono stati rimossi.';

  @override
  String get subscriptionUnavailable =>
      'I piani di abbonamento non sono disponibili al momento. Per favore riprova.';

  @override
  String get upgradeUnavailable =>
      'L\'aggiornamento non è disponibile al momento. Per favore riprova più tardi.';

  @override
  String get noPurchasesToRestore => 'Nessun acquisto trovato da ripristinare.';

  @override
  String get subscriptionErrorServiceUnavailable =>
      'Gli acquisti sono temporaneamente non disponibili. Riprova tra poco.';

  @override
  String get subscriptionErrorPlansUnavailable =>
      'Impossibile caricare i piani di abbonamento. Controlla la connessione e riprova.';

  @override
  String get subscriptionErrorPurchaseCancelled => 'Acquisto annullato.';

  @override
  String get subscriptionErrorPurchaseNotAllowed =>
      'Gli acquisti non sono consentiti su questo dispositivo.';

  @override
  String get subscriptionErrorPurchaseInvalid =>
      'Impossibile completare l\'acquisto. Controlla il tuo account e riprova.';

  @override
  String get subscriptionErrorProductUnavailable =>
      'Questo abbonamento non è disponibile al momento. Scegli un altro piano o riprova più tardi.';

  @override
  String get subscriptionErrorNetwork =>
      'Sei offline. Controlla la connessione e riprova.';

  @override
  String get subscriptionErrorPurchaseFailed =>
      'Acquisto non riuscito. Riprova.';

  @override
  String get subscriptionErrorRestoreFailed =>
      'Impossibile ripristinare gli acquisti. Controlla la connessione e riprova.';

  @override
  String get unlockFullProtocol => 'Sblocca il protocollo completo';

  @override
  String get premiumUnlimitedPeptides => 'Peptidi illimitati per protocollo';

  @override
  String get premiumMultipleProtocols => 'Protocolli attivi multipli';

  @override
  String get premiumCalculator =>
      'Calcolatore per la ricostituzione (tutti i peptidi)';

  @override
  String get premiumMetrics => 'Monitoraggio delle metriche corporee + grafici';

  @override
  String get upgradeNow => 'AGGIORNA ORA';

  @override
  String get restorePurchases => 'Ripristina gli acquisti';

  @override
  String get notRightNow => 'Non adesso';

  @override
  String get protocolWeeklyPlanner => 'Pianificatore settimanale';

  @override
  String get protocolDoseHistory => 'Cronologia delle dosi';

  @override
  String get protocolCreate => 'Crea protocollo';

  @override
  String get protocolManage => 'GESTISCI';

  @override
  String get protocolYourProtocol => 'Il tuo protocollo';

  @override
  String get protocolNoActive => 'Nessun protocollo attivo';

  @override
  String get protocolNoActiveBody =>
      'Crea il tuo primo protocollo per iniziare a monitorare le dosi e sviluppare l\'aderenza.';

  @override
  String get protocolStartFirst => 'AVVIO PRIMO PROTOCOLLO';

  @override
  String get protocolScheduleTodaySystemLabel => 'PROGRAMMA // OGGI';

  @override
  String get protocolAdherenceTodaySystemLabel => 'ADERENZA // OGGI';

  @override
  String get protocolNoDosesScheduledToday => 'Nessuna dose prevista oggi';

  @override
  String protocolDosesTaken(int taken, int total) {
    return '$taken dosi assunte su $total';
  }

  @override
  String get protocolNextDose => 'PROSSIMA DOSE';

  @override
  String protocolInTime(String duration) {
    return 'Tra $duration';
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
  String get protocolLogDose => 'REGISTRA DOSE';

  @override
  String get protocolNow => 'Ora';

  @override
  String get protocolMissed => 'MANCATA';

  @override
  String get protocolSkipped => 'SALTATO';

  @override
  String get protocolNoDosesToday => 'Nessuna dose oggi';

  @override
  String get protocolNoDosesTodayBody =>
      'Il tuo protocollo non prevede dosi per oggi.';

  @override
  String get protocolFreeLimit =>
      'Il piano gratuito è limitato a un protocollo. Passa a Premium per seguire più combinazioni contemporaneamente.';

  @override
  String protocolSyringeUnitsSuffix(String amount) {
    return ' · $amount unità di siringa';
  }

  @override
  String get injectionSiteLeftAbdomen => 'Addome sinistro';

  @override
  String get injectionSiteRightAbdomen => 'Addome destro';

  @override
  String get injectionSiteLeftThigh => 'Coscia sinistra';

  @override
  String get injectionSiteRightThigh => 'Coscia destra';

  @override
  String get injectionSiteLeftGlute => 'Gluteo sinistro';

  @override
  String get injectionSiteRightGlute => 'Gluteo destro';

  @override
  String get injectionSiteLeftTriceps => 'Tricipite sinistro';

  @override
  String get injectionSiteRightTriceps => 'Tricipite destro';

  @override
  String get injectionSiteLeftDeltoid => 'Deltoide sinistro';

  @override
  String get injectionSiteRightDeltoid => 'Deltoide destro';

  @override
  String get plannerToday => 'OGGI';

  @override
  String get plannerBack => 'Indietro';

  @override
  String get plannerPreviousWeek => 'La settimana precedente';

  @override
  String get plannerNextWeek => 'La prossima settimana';

  @override
  String plannerScheduledCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dosi programmate',
      one: '$count dose programmata',
    );
    return '$_temp0';
  }

  @override
  String get plannerTrackingDisclaimer =>
      'Solo monitoraggio. Questo calendario riflette il protocollo salvato e non fornisce indicazioni sul dosaggio.';

  @override
  String get plannerWashoutPeriod => 'Periodo di pausa';

  @override
  String plannerWashoutUntil(String date) {
    return 'Pausa fino al $date';
  }

  @override
  String get plannerNoScheduledDoses => 'Nessuna dose programmata';

  @override
  String get plannerNothingPlanned =>
      'Non è previsto nulla dai protocolli salvati.';

  @override
  String get activatePro => 'ATTIVA PRO';

  @override
  String activateProPrice(String price) {
    return 'ATTIVA PRO — $price/anno';
  }

  @override
  String get annualAccess => 'Accesso annuale';

  @override
  String get annualLabel => 'Annuale';

  @override
  String get averageRating => 'VALUTAZIONE MEDIA';

  @override
  String get bacWaterLabel => 'ACQUA BAC';

  @override
  String get basedOnInputs => 'In base ai tuoi input //';

  @override
  String get bestValue => 'Miglior rapporto qualità/prezzo';

  @override
  String get birthDateInvalid =>
      'Inserisci una data valida per qualcuno di età pari o superiore a 18 anni.';

  @override
  String get birthDateValid => 'Età verificata';

  @override
  String calculatorDemoBody(String peptideName) {
    return 'Ecco come funziona con $peptideName';
  }

  @override
  String get calculatorDemoResult =>
      'Tutto qui. Inserisci i valori,\notterrai le unità esatte della siringa.';

  @override
  String get calculatorDemoTitle => 'Basta con i\ncalcoli complicati.';

  @override
  String get confidenceCycleTiming => 'Tempi del ciclo';

  @override
  String get confidenceCycleTimingDetail =>
      'Visualizza chiaramente le date del protocollo e le finestre di pianificazione';

  @override
  String get confidenceDoseMath => 'Calcolo della dose';

  @override
  String get confidenceDoseMathDetail =>
      'Tieni insieme fiala, acqua, dose e unità di prelievo';

  @override
  String get confidenceLabel => 'FIDUCIA';

  @override
  String get confidencePlainInfo => 'Informazioni in linguaggio semplice';

  @override
  String get confidencePlainInfoDetail =>
      'Leggi gli appunti di ricerca senza confusione';

  @override
  String get confidenceProgressSignals => 'Segnali di progresso';

  @override
  String get confidenceProgressSignalsDetail =>
      'Visualizza l\'aderenza e le metriche corporee nel tempo';

  @override
  String get confidenceSafetyFraming => 'Informazioni sulla sicurezza';

  @override
  String get confidenceSafetyFramingDetail =>
      'Mantieni visibili le linee guida educative e le dichiarazioni di non responsabilità';

  @override
  String get confidenceSiteRotation => 'Rotazione del sito';

  @override
  String get confidenceSiteRotationDetail =>
      'Ricordare dove è stata registrata ciascuna dose';

  @override
  String get connectingToStore => 'CONNESSIONE ALLO STORE…';

  @override
  String continueSelected(int count) {
    return 'CONTINUA ($count)';
  }

  @override
  String get customProtocol => 'Protocollo personalizzato';

  @override
  String get dateOfBirthLabel => 'DATA DI NASCITA';

  @override
  String get dayOne => 'GIORNO 1';

  @override
  String get dayShortLabel => 'GG';

  @override
  String get defaultConfidence => 'Matematica della dose · Rotazione del sito';

  @override
  String get defaultFrustration => 'Dosi mancanti';

  @override
  String get defaultGoals => 'Recupero · Longevità';

  @override
  String get doseLabel => 'DOSE';

  @override
  String get dosesLogged => 'DOSI REGISTRATE';

  @override
  String get dosesPerDay => 'DOSI/GIORNO';

  @override
  String get drawVolumeLabel => 'VOLUME DA PRELEVARE';

  @override
  String get durationLabel => 'DURATA';

  @override
  String get experienceAdvanced => 'Avanzato';

  @override
  String get experienceAdvancedDetail =>
      'Mi sento a mio agio nel gestire protocolli dettagliati';

  @override
  String get experienceFirstTime => 'Prima volta';

  @override
  String get experienceFirstTimeDetail =>
      'Sono nuovo nel monitoraggio dei peptidi';

  @override
  String get experienceIntermediate => 'INTERMEDIO';

  @override
  String get experienceLabel => 'ESPERIENZA';

  @override
  String get experienceNovice => 'NOVIZIO';

  @override
  String get experienceSome => 'Qualche esperienza';

  @override
  String get experienceSomeDetail => 'Ho monitorato uno o due protocolli';

  @override
  String get experienceVeteran => 'VETERANO';

  @override
  String get featureDoseMathBody =>
      'Conserva le dimensioni della fiala, il volume dell\'acqua, la dose e le unità da aspirare accanto al protocollo che stai effettivamente monitorando.';

  @override
  String get featureDoseMathTitle => 'Matematica della dose\nNel contesto';

  @override
  String get featureProtocolArcBody =>
      'Visualizza le dosi pianificate, le dosi registrate, l\'aderenza e le metriche corporee integrate in un\'unica sequenza temporale.';

  @override
  String get featureProtocolArcTitle => 'Arco del Protocollo\nNel tempo';

  @override
  String get featureShowcaseTitle =>
      'Tutto ciò di cui hai bisogno.\nUn\'applicazione.';

  @override
  String get featureSiteRotationBody =>
      'Ricorda ogni sito che registri e mantieni la cronologia delle rotazioni allegata al record della dose.';

  @override
  String get featureSiteRotationTitle => 'Sito di iniezione\nRotazione';

  @override
  String get firstNameExample => 'es. Alex';

  @override
  String get firstNameLabel => 'NOME DI BATTESIMO';

  @override
  String get frustrationForgetting => 'Dimenticare le dosi';

  @override
  String get frustrationLabel => 'FRUSTRAZIONE';

  @override
  String get frustrationMath => 'Calcoli di fiala e siringa';

  @override
  String get frustrationProgress => 'Capire se sono costante';

  @override
  String get frustrationSchedule => 'Rispettare con precisione il programma';

  @override
  String get frustrationStacking => 'Gestione di più peptidi';

  @override
  String get frustrationTrust => 'Trovare informazioni affidabili';

  @override
  String get goalAntiAging => 'Invecchiamento sano';

  @override
  String get goalAntiAgingDetail =>
      'Organizzare record incentrati sulla longevità';

  @override
  String get goalCognitive => 'Supporto cognitivo';

  @override
  String get goalCognitiveDetail =>
      'Monitorare la concentrazione e le prestazioni mentali';

  @override
  String get goalImmune => 'Supporto immunitario';

  @override
  String get goalImmuneDetail =>
      'Mantieni organizzati i protocolli incentrati sul sistema immunitario';

  @override
  String get goalMuscleGrowth => 'Crescita muscolare';

  @override
  String get goalMuscleGrowthDetail =>
      'Monitora gli obiettivi di allenamento e crescita';

  @override
  String get goalOther => 'Altro';

  @override
  String get goalOtherDetail => 'Imposta un obiettivo di monitoraggio diverso';

  @override
  String get goalRecovery => 'Recupero';

  @override
  String get goalRecoveryDetail => 'Monitora dati e routine di recupero';

  @override
  String get goalSleep => 'Sonno';

  @override
  String get goalSleepDetail =>
      'Tieni traccia degli obiettivi e dei modelli relativi al sonno';

  @override
  String get goalWeightLoss => 'Perdita di peso';

  @override
  String get goalWeightLossDetail =>
      'Tieni traccia degli obiettivi e dei progressi metabolici';

  @override
  String get goalsLabel => 'OBIETTIVI';

  @override
  String get iUnderstand => 'CAPISCO';

  @override
  String get lastThreeDaysAgo => 'Ultimo: 3 giorni fa';

  @override
  String get leftAbdomen => 'Addome sinistro';

  @override
  String get loveIt => 'LO ADORO';

  @override
  String get maybeLater => 'Forse più tardi';

  @override
  String get monthOne => 'MESE 1';

  @override
  String get monthShortLabel => 'MM';

  @override
  String get monthTwo => 'MESE 2';

  @override
  String moreCount(String shown, int count) {
    return '$shown +$count altro';
  }

  @override
  String get needsWork => 'DA MIGLIORARE';

  @override
  String get notificationBody =>
      'Ricevi promemoria discreti quando è prevista una finestra del protocollo. Nessun nome di peptide nelle notifiche, solo un leggero promemoria.';

  @override
  String get notificationTitle =>
      'Tieni gli orari delle dosi\nsempre visibili.';

  @override
  String get nowLabel => 'Ora';

  @override
  String get ok => 'OK';

  @override
  String get onboardingAgeConfirmed => 'HO 18 ANNI O PIÙ';

  @override
  String get onboardingAgeRequirementBody =>
      'Devi avere almeno 18 anni per utilizzare PepMod.';

  @override
  String get onboardingAgeRequirementTitle => 'Requisito di età';

  @override
  String get onboardingAgeVerificationBody =>
      'PepMod è destinato agli adulti dai 18 anni in su.';

  @override
  String get onboardingAgeVerificationTitle =>
      'Innanzitutto, conferma\nla tua età.';

  @override
  String get onboardingAheadBody =>
      'Rispondi ad alcune domande e PepMod organizzerà un\'anteprima del tracciamento personalizzata.';

  @override
  String get onboardingAheadTitle =>
      'Vedi il tuo protocollo\nprima di iniziare.';

  @override
  String get onboardingBirthDateBody =>
      'Ciò conferma che soddisfi i requisiti di età.';

  @override
  String get onboardingBirthDateTitle => 'Quando sei\nnato/a?';

  @override
  String get onboardingConfidenceBody =>
      'Scegli tutto ciò che PepMod dovrebbe rendere più chiaro.';

  @override
  String get onboardingConfidenceTitle => 'Dove desideri\npiù sicurezza?';

  @override
  String get onboardingConversionValueBody =>
      'Converti i valori della fiala e del tuo piano in volume e unità di siringa.';

  @override
  String get onboardingConversionValueTitle =>
      'Calcoli della fiala\npiù facili da verificare.';

  @override
  String get onboardingDisclaimerBody =>
      'PepMod aiuta a organizzare dati, promemoria e conversioni di unità. Non formula diagnosi, non prescrive e non sostituisce il parere di un operatore sanitario qualificato.';

  @override
  String get onboardingDisclaimerTitle =>
      'Costruito per chiarezza.\nNon prescrizioni.';

  @override
  String get onboardingExperienceTitle => 'Quanta esperienza\nhai?';

  @override
  String get onboardingFrustrationBody =>
      'Scegli il punto di attrito maggiore.';

  @override
  String get onboardingFrustrationTitle =>
      'Cosa ti sembra\npiù difficile oggi?';

  @override
  String get onboardingGoalsTitle => 'Quali sono i tuoi\nobiettivi principali?';

  @override
  String get onboardingGuidedStartBody =>
      'Personalizzeremo la configurazione in base ai tuoi obiettivi, alla tua esperienza e ai record che desideri conservare.';

  @override
  String get onboardingGuidedStartTitle =>
      'Un inizio guidato,\npensato per te.';

  @override
  String get onboardingHookAnswer =>
      'PepMod mantiene la risposta accanto al tuo protocollo.';

  @override
  String get onboardingHookQuestion => 'Quante unità\nprelevare?';

  @override
  String get onboardingHookResearch => 'BIBLIOTECA DI RICERCA';

  @override
  String get onboardingHookSources => 'Fonti legate alle prove';

  @override
  String get onboardingHookVial => 'FLACONCINO + DILUENTE';

  @override
  String get onboardingNameBody =>
      'Lo useremo per personalizzare la tua esperienza PepMod.';

  @override
  String get onboardingNameTitle => 'Cosa dovremmo\nchiamarti?';

  @override
  String get onboardingPeptideSelectBody =>
      'Scegli i peptidi che usi o che desideri tenere sul tuo radar.';

  @override
  String get onboardingPeptideSelectTitle => 'Cosa stai\nmonitorando?';

  @override
  String get onboardingProgressValueBody =>
      'Raccogli l\'aderenza, la cronologia della dose e le metriche corporee in un unico record chiaro.';

  @override
  String get onboardingProgressValueTitle =>
      'Guarda l\'arco completo\nnel tempo.';

  @override
  String get onboardingProtocolValueBody =>
      'Pianifica gli orari, registra le dosi e mantieni i dettagli allegati a ciascun protocollo.';

  @override
  String get onboardingProtocolValueTitle =>
      'Mantieni ogni protocollo\nin un posto.';

  @override
  String get onboardingUnder18 => 'HO MENO DI 18 ANNI';

  @override
  String get openingPermission => 'APERTURA AUTORIZZAZIONE…';

  @override
  String get paywallArcBody =>
      'Scopri cosa era pianificato, cosa è stato registrato e cosa richiede un monitoraggio più accurato.';

  @override
  String get paywallArcTitle => 'GUARDA L\'ARCO NEL TEMPO';

  @override
  String get paywallBody =>
      'Calcolo della dose, rotazione dei siti, promemoria e cronologia del protocollo, tutto in un unico registro.';

  @override
  String get paywallDoseMathBody =>
      'Tieni insieme fiala, acqua, dose e unità da prelevare per verificare più facilmente ogni registrazione.';

  @override
  String get paywallDoseMathTitle => 'CALCOLA CORRETTAMENTE LA DOSE';

  @override
  String get paywallPreviewDisclaimer =>
      'Costruito per registrazioni, promemoria e chiarezza delle unità, non per consigli medici.';

  @override
  String get paywallRotationBody =>
      'Ogni sito, ciclo e promemoria rimane allegato al record del protocollo.';

  @override
  String get paywallRotationTitle => 'NON PERDERE MAI LA ROTAZIONE';

  @override
  String get paywallTitle =>
      'Tutto ciò che serve per seguire\ncorrettamente il tuo protocollo.';

  @override
  String get paywallValueNote =>
      'Un calcolo confuso delle fiale può far perdere tempo e prodotto. PepMod conserva i calcoli accanto al registro in modo da poter ricontrollare i record prima di agire su vecchie note.';

  @override
  String get peptideLabel => 'PEPTIDE';

  @override
  String get peptidesLabel => 'PEPTIDI';

  @override
  String get peptidesTracked => 'PEPTIDI\nMONITORATI';

  @override
  String get perWeek => '/settimana';

  @override
  String get perYear => '/anno';

  @override
  String get privacyLabel => 'Privacy';

  @override
  String processingGoals(int count) {
    return 'ANALISI DI $count OBIETTIVI…';
  }

  @override
  String processingPeptides(int count) {
    return 'COLLEGAMENTO DI $count REGISTRI DI PEPTIDI…';
  }

  @override
  String get processingProtocol => 'CREAZIONE DEL TUO PROTOCOLLO…';

  @override
  String get processingSchedule => 'ORGANIZZAZIONE DEL TUO PROGRAMMA…';

  @override
  String get processingTitle => 'Costruisci il tuo\nprotocollo';

  @override
  String get progressLabel => 'Progressi';

  @override
  String get protocolClarity => 'chiarezza del protocollo';

  @override
  String get protocolIncludes => 'IL TUO PROTOCOLLO INCLUDE //';

  @override
  String get protocolPreviewTitle => 'Il tuo protocollo\nè pronto.';

  @override
  String get protocolReady => 'PROTOCOLLO PRONTO //';

  @override
  String get protocolReminderReady => 'Il promemoria del protocollo è pronto';

  @override
  String get protocolReservedFor =>
      'IL TUO PROTOCOLLO PERSONALIZZATO È RISERVATO PER';

  @override
  String get restorePurchase => 'Ripristina acquisto';

  @override
  String get resultsSummaryBody =>
      'Terremo insieme i registri delle dosi, i calcoli di ricostituzione e i record delle tendenze man mano che i tuoi dati vengono creati.';

  @override
  String get reviewGateBody =>
      'Il tuo feedback ci aiuta a migliorare la piattaforma per ogni biohacker.';

  @override
  String get reviewGateTitle => 'Ti piace PepMod\nfinora?';

  @override
  String roadmapBody(int count, String need) {
    return 'Costruito attorno ai peptidi tracciati $count e alla tua esigenza di $need.';
  }

  @override
  String get roadmapDayOneBody =>
      'Peptidi, registri delle dosi, rotazione dei siti e promemoria sono pronti.';

  @override
  String get roadmapDayOneTitle => 'Il tuo primo protocollo è organizzato';

  @override
  String get roadmapDisclaimer =>
      'PepMod mantiene organizzati registri e promemoria. Non prescrive, non diagnostica e non sostituisce le indicazioni di un operatore sanitario qualificato.';

  @override
  String get roadmapMonthOneBody =>
      'L\'aderenza, le dosi mancate e le metriche corporee iniziano a formare un registro più pulito.';

  @override
  String get roadmapMonthOneTitle => 'La tua storia di coerenza prende forma';

  @override
  String get roadmapMonthTwoBody =>
      'Scopri cosa hai pianificato, cosa è successo e dove i tuoi record richiedono attenzione.';

  @override
  String get roadmapMonthTwoTitle => 'L\'intero arco del protocollo è visibile';

  @override
  String get roadmapTitle => 'Ecco cosa\nti aspetta.';

  @override
  String get roadmapWeekOneBody =>
      'Le note di ricerca e monitoraggio in un linguaggio semplice restano allegate al tuo piano.';

  @override
  String roadmapWeekOneTitle(String goal) {
    return 'La tua libreria cresce intorno a $goal';
  }

  @override
  String savePercent(int percent) {
    return 'RISPARMIA $percent%';
  }

  @override
  String get saveRoadmap => 'SALVA QUESTA ROADMAP';

  @override
  String get schedulePreview => 'ANTEPRIMA DEL PROGRAMMA';

  @override
  String get seeWhatsInside => 'GUARDA COSA C\'È DENTRO';

  @override
  String get selectAllThatApply => 'Seleziona tutto ciò che si applica.';

  @override
  String get siteMap => 'MAPPA DEI SITI';

  @override
  String get skipForNow => 'SALTA PER ORA';

  @override
  String get socialProofBody =>
      'Unisciti a migliaia di persone che monitorano i progressi reali.';

  @override
  String get socialProofTitle => 'Scelto da\nbiohacker in tutto il mondo';

  @override
  String get specialOffer => 'OFFERTA SPECIALE';

  @override
  String get startFreeTrial => 'INIZIA LA PROVA GRATUITA';

  @override
  String get subscribeLabel => 'ISCRIVITI';

  @override
  String subscribePrice(String price) {
    return 'ISCRIVITI — $price/settimana';
  }

  @override
  String subscribeAnnualPrice(String price) {
    return 'ISCRIVITI — $price/anno';
  }

  @override
  String get subscribeToActivate => 'Iscriviti per attivare il tuo protocollo';

  @override
  String get subscriptionRenewalDisclaimer =>
      'L\'abbonamento si rinnova automaticamente a meno che non venga annullato almeno 24 ore prima della fine del periodo corrente. Gestisci in Impostazioni > ID Apple > Abbonamenti.';

  @override
  String syringeVolume(String volume) {
    return '$volume mL su una siringa da 1 mL';
  }

  @override
  String get termsLabel => 'Termini';

  @override
  String get testimonialOne =>
      'Finalmente ho smesso di saltare le dosi. Il solo calcolatore di ricostituzione mi ha fatto risparmiare ore di calcoli sui fogli di calcolo.';

  @override
  String get testimonialThree =>
      'Il tracciatore di peptidi più pulito che abbia mai usato. Sembra che sia stato creato per utenti seri, perché lo era.';

  @override
  String get testimonialTwo =>
      'Gli approfondimenti settimanali hanno rilevato un problema di tempistica che non avevo notato per mesi. Punto di svolta.';

  @override
  String get thirtyDayAdherence => 'Aderenza 30 giorni';

  @override
  String get timelineLabel => 'Cronologia';

  @override
  String get trackedLabel => 'monitorati';

  @override
  String get turnOnReminders => 'ATTIVA I PROMEMORIA';

  @override
  String get unitConversionDisclaimer =>
      'Strumento di conversione delle unità fornito solo a titolo indicativo. Verifica sempre con un operatore sanitario qualificato.';

  @override
  String get unitsLabel => 'Unità';

  @override
  String get unitsToDraw => 'Unità da prelevare';

  @override
  String get unlockPepMod => 'SBLOCCA PEPMOD';

  @override
  String get usersLabel => 'UTENTI';

  @override
  String get viewLabel => 'VEDI';

  @override
  String get weekDuration => 'SETTIMANA\nDURATA';

  @override
  String get weekOne => 'SETTIMANA 1';

  @override
  String get weeklyLabel => 'Settimanale';

  @override
  String weeksCount(int count) {
    return '$count settimane';
  }

  @override
  String get yearLabel => 'ANNO';

  @override
  String get profileTitle => 'Tu';

  @override
  String get signedIn => 'Effettuato l\'accesso';

  @override
  String get sectionAccount => 'ACCOUNT';

  @override
  String get sectionPreferences => 'PREFERENZE';

  @override
  String get sectionData => 'DATI';

  @override
  String get sectionSupport => 'SUPPORTO';

  @override
  String get sectionLegal => 'LEGALE';

  @override
  String get sectionAbout => 'INFORMAZIONI';

  @override
  String get nameLabel => 'Nome';

  @override
  String get accountLabel => 'Account';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get removeAccountData => 'Rimuovere account e dati';

  @override
  String get metricLabel => 'Metrico';

  @override
  String get imperialLabel => 'Imperiale';

  @override
  String get notificationsLabel => 'Notifiche';

  @override
  String get onLabel => 'Attivo';

  @override
  String get offLabel => 'Disattivato';

  @override
  String get myCompoundsProfile => 'I miei composti';

  @override
  String get savedVialPresets => 'Preimpostazioni delle fiale salvate';

  @override
  String get exportData => 'Esporta dati';

  @override
  String get copyAsJson => 'Copia come JSON';

  @override
  String get clearAllData => 'Cancella tutti i dati';

  @override
  String get clearingLabel => 'Cancellazione…';

  @override
  String get resetApp => 'Reimposta l\'app';

  @override
  String get contactSupport => 'Contatta l\'assistenza';

  @override
  String get chatWithUs => 'Chatta con noi';

  @override
  String get termsOfService => 'Termini di servizio';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get medicalDisclaimer => 'Disclaimer medico';

  @override
  String get disclaimerTitle => 'Disclaimer';

  @override
  String get versionLabel => 'Versione';

  @override
  String get signOutAction => 'DISCONNESSIONE';

  @override
  String get educationalTrackingDisclaimer =>
      'Solo monitoraggio didattico. Non un consiglio medico.';

  @override
  String get yourName => 'Il tuo nome';

  @override
  String get cancelLabel => 'Annulla';

  @override
  String get saveLabel => 'Salva';

  @override
  String get dataCopied => 'Dati copiati negli appunti.';

  @override
  String get clearDataTitle => 'Cancellare tutti i dati?';

  @override
  String get clearDataBody =>
      'Ciò elimina tutti i protocolli, i registri delle dosi e le metriche corporee, quindi riavvia l\'onboarding. Il tuo account, abbonamento e libreria di peptidi vengono conservati. Questa operazione non può essere annullata.';

  @override
  String get clearLabel => 'Cancella';

  @override
  String get clearingDataTitle => 'Cancellazione dei dati…';

  @override
  String get clearingDataBody =>
      'Mantieni PepMod aperto mentre i tuoi dati di tracciamento vengono rimossi.';

  @override
  String get clearDataFailed =>
      'Impossibile cancellare i dati. Controlla la connessione e riprova.';

  @override
  String get allDataCleared => 'Tutti i dati cancellati.';

  @override
  String get deleteAccountTitle => 'Eliminare l\'account?';

  @override
  String get deleteAccountBody =>
      'Ciò eliminerà permanentemente il tuo account PepMod, le impostazioni, i protocolli, i registri delle dosi e le metriche corporee. Questa operazione non può essere annullata.';

  @override
  String get deletingAccount => 'Eliminazione dell\'account…';

  @override
  String get accountDeletionFailed =>
      'Eliminazione dell\'account non riuscita. Per favore riprova.';

  @override
  String get confirmPassword => 'Conferma password';

  @override
  String get deleteLabel => 'Eliminare';

  @override
  String get signOutTitle => 'Disconnessione?';

  @override
  String get signOutBody =>
      'I tuoi protocolli rimangono salvati e si sincronizzano quando accedi di nuovo.';

  @override
  String get signOutLabel => 'Esci';

  @override
  String get signOutFailed =>
      'Disconnessione non riuscita. Per favore riprova.';

  @override
  String get notificationsDisabledSystem =>
      'Le notifiche sono disabilitate nelle impostazioni di sistema.';

  @override
  String get planPro => 'PRO';

  @override
  String get planFree => 'GRATUITO';

  @override
  String get termsBody =>
      'PepMod è fornito solo a scopo didattico e di monitoraggio. Non è un dispositivo medico e non fornisce consigli medici, diagnosi, prescrizioni o raccomandazioni terapeutiche. Utilizzando PepMod, sei responsabile dei tuoi dati, delle tue decisioni e della consultazione con operatori sanitari qualificati.\n\nGli abbonamenti si rinnovano automaticamente a meno che non vengano annullati tramite App Store o Google Play prima del periodo di rinnovo. I rimborsi vengono gestiti dal negozio in cui hai acquistato.\n\nTermini completi: https://appstorecopilot.com/legal/yzh32x5v/terms';

  @override
  String get privacyBody =>
      'PepMod utilizza Firebase per l\'autenticazione e l\'archiviazione dei dati nel cloud, RevenueCat per gli abbonamenti, AppRefer ed eventi delle app Meta/Facebook per l\'attribuzione e Firebase/Crashlytics per l\'analisi e la diagnostica. Non vendiamo le tue informazioni personali. Puoi eliminare il tuo account e i dati dell\'app salvati dall\'interno dell\'app.\n\nInformativa sulla privacy completa: https://appstorecopilot.com/legal/yzh32x5v/privacy';

  @override
  String get medicalDisclaimerBody =>
      'PepMod è uno strumento di benessere e monitoraggio, NON un dispositivo medico. Niente in questa app costituisce consiglio medico, diagnosi, prescrizione o raccomandazione terapeutica. I peptidi descritti nella libreria sono solo a scopo didattico. Consultare sempre un operatore sanitario qualificato prima di iniziare, modificare o interrompere qualsiasi regime. Se si verificano effetti avversi, consultare immediatamente un medico.';

  @override
  String get profileSystemLabel => 'SYS.UTENTE // PROFILO';

  @override
  String get legalSystemLabel => 'SYS.LEGALE';

  @override
  String get progressTitle => 'Progressi';

  @override
  String get progressSystemLabel => 'SYS.PROGRESSI // BIOMETRIA';

  @override
  String get doseHistoryTooltip => 'Apri cronologia delle dosi';

  @override
  String get logMeasurementTooltip => 'Registra misurazione';

  @override
  String get thirtyDayLabel => '30 GIORNI';

  @override
  String get adherenceLabel => 'aderenza';

  @override
  String get streakLabel => 'SERIE';

  @override
  String get daysLabel => 'giorni';

  @override
  String get totalLabel => 'TOTALE';

  @override
  String get dosesLabel => 'dosi';

  @override
  String get protocolHistoryLabel => 'CRONOLOGIA.PROTOCOLLI';

  @override
  String get noProtocolsYet =>
      'Nessun protocollo ancora. Creane uno dalla scheda Protocollo.';

  @override
  String get adherenceChartLabel => 'ADERENZA // 30.GIORNI';

  @override
  String get thirtyDaysAgo => '30 gg fa';

  @override
  String get todayLabel => 'Oggi';

  @override
  String get noWeightData => 'Nessun dato sul peso';

  @override
  String get logFirstMeasurement =>
      'Registra la tua prima misurazione per vedere le tendenze qui.';

  @override
  String get logMeasurementAction => 'REGISTRA MISURAZIONE';

  @override
  String get weightTrendLabel => 'PESO // TENDENZA';

  @override
  String weightKgValue(String weight) {
    return '${weight}kg';
  }

  @override
  String get statusActive => 'ATTIVO';

  @override
  String get statusPaused => 'IN PAUSA';

  @override
  String get statusEnded => 'TERMINATO';

  @override
  String protocolPeptideCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count peptidi',
      one: '1 peptide',
    );
    return '$_temp0';
  }

  @override
  String get enterOneMetric => 'Inserisci almeno un valore.';

  @override
  String get saveMetricFailed => 'Impossibile salvare. Riprova.';

  @override
  String get newMeasurement => 'Nuova misurazione';

  @override
  String get weightLabel => 'PESO';

  @override
  String get bodyFatLabel => 'GRASSO CORPOREO';

  @override
  String get measurementsCmLabel => 'MISURE (cm)';

  @override
  String get waistLabel => 'VITA';

  @override
  String get chestLabel => 'PETTO';

  @override
  String get armLabel => 'BRACCIO';

  @override
  String get saveAction => 'SALVA';

  @override
  String get logMetricSystemLabel => 'LOG.METRICO';

  @override
  String get activeLastSevenDays => 'ULTIMI 7 GIORNI';

  @override
  String get activeAllTime => 'TUTTO IL TEMPO';

  @override
  String get activeAdherence => 'aderenza';

  @override
  String get activeStarted => 'INIZIATO';

  @override
  String get activeEnded => 'TERMINATO';

  @override
  String activeStackCount(int count) {
    return 'COMBINAZIONE ($count)';
  }

  @override
  String get activeEditProtocol => 'MODIFICA PROTOCOLLO';

  @override
  String get activePauseProtocol => 'METTI IN PAUSA IL PROTOCOLLO';

  @override
  String get activeEndProtocol => 'TERMINA PROTOCOLLO';

  @override
  String get activeResumeProtocol => 'RIPRENDI IL PROTOCOLLO';

  @override
  String get activeDeleteProtocol => 'ELIMINA PROTOCOLLO';

  @override
  String get activeTrackingDisclaimer =>
      'Solo monitoraggio didattico. Consultare un operatore sanitario qualificato prima di apportare modifiche.';

  @override
  String get activeEndQuestion => 'Terminare il protocollo?';

  @override
  String get activeEndBody =>
      'Le dosi future verranno rimosse. I registri precedenti rimangono nella tua cronologia. Questa operazione non può essere annullata.';

  @override
  String get activeEndAction => 'TERMINA';

  @override
  String get activeDeleteQuestion => 'Eliminare il protocollo?';

  @override
  String get activeDeleteBody =>
      'Ciò rimuove permanentemente il protocollo e tutti i relativi registri delle dosi. Questa operazione non può essere annullata.';

  @override
  String get activeDeleteAction => 'ELIMINA';

  @override
  String get cancel => 'Annulla';

  @override
  String get activeStatusActive => 'ATTIVO';

  @override
  String get activeStatusPaused => 'IN PAUSA';

  @override
  String get activeStatusEnded => 'TERMINATO';

  @override
  String get activeNotesLabel => 'NOTE // PROTOCOLLO';

  @override
  String get activeChangeReminders => 'PROMEMORIA DI CAMBIAMENTO';

  @override
  String get activeChangeRemindersBody =>
      'Quando le Notifiche sono attive, PepMod pianifica un checkpoint locale alle 09:00 per ogni cambio di fase imminente.';

  @override
  String activePhaseAnchor(String date) {
    return 'Gli intervalli di settimane sono ancorati a $date.';
  }

  @override
  String activeWeek(int week) {
    return 'SETTIMANA $week';
  }

  @override
  String activeWeeks(int start, int end) {
    return 'SETTIMANE $start–$end';
  }

  @override
  String get activePerDayAmounts => 'Quantità giornaliere';

  @override
  String get activeBaseAmount => 'Quantità base';

  @override
  String get activeCurrent => 'ATTUALE';

  @override
  String get activeBaseSchedule => 'Programma di base';

  @override
  String get activeCustomDays => 'Giorni personalizzati';

  @override
  String get activeContinuousTracking => 'Monitoraggio continuo';

  @override
  String get activeNoFixedCycle => 'Nessuna finestra di ciclo fissa';

  @override
  String activeCycleProgress(int week, int total) {
    return 'Settimana $week di $total';
  }

  @override
  String activeCycleEnds(String date) {
    return 'Il ciclo termina $date';
  }

  @override
  String activeRestProgress(int week, int total) {
    return 'Settimana di riposo $week di $total';
  }

  @override
  String activeRestEnds(String date) {
    return 'Il periodo di riposo termina $date';
  }

  @override
  String get activeCycleComplete => 'Ciclo completato';

  @override
  String activeCompletedDate(String date) {
    return 'Completato $date';
  }

  @override
  String activeRestEnded(String date) {
    return 'Finestra di riposo terminata $date';
  }

  @override
  String get activeNoHistory =>
      'Nessun protocollo in pausa o terminato ancora.';

  @override
  String activeCompoundsCount(int count) {
    return '$count composti';
  }

  @override
  String activeSyringeUnits(String amount) {
    return '$amount unità di siringa';
  }

  @override
  String activeCycleWeeks(int count) {
    return 'Ciclo di $count sett.';
  }

  @override
  String activeRestWeeks(int count) {
    return '$count sett. di riposo';
  }

  @override
  String get activePerDraw => 'PER PRELIEVO';

  @override
  String activeVialSummary(String volume) {
    return 'Fiala da $volume mL · U-100';
  }

  @override
  String get addCompound => 'AGGIUNGI COMPOSTO';

  @override
  String get addPhase => 'AGGIUNGI FASE';

  @override
  String get addTime => 'Aggiungi orario';

  @override
  String get addToStack => 'AGGIUNGI ALLA COMBINAZIONE';

  @override
  String get amountRequired => 'Quantità obbligatoria';

  @override
  String get baseAmount => 'Quantità base';

  @override
  String get baseSchedule => 'programma di base';

  @override
  String get blendConfigBody =>
      'Inserisci esattamente ciò che è stampato sulla fiala. PepMod converte il prelievo in un riepilogo per composto.';

  @override
  String get blendIncompleteError =>
      'Completa almeno due composti, il volume del diluente e la quantità da prelevare.';

  @override
  String get blendNameHint => 'es. Miscela recupero';

  @override
  String get blendNameLabel => 'NOME DELLA MISCELA';

  @override
  String get blendSafetyDisclaimer =>
      'Solo conversione di unità. PepMod non consiglia una miscela, una dose, una frequenza o un metodo di ricostituzione.';

  @override
  String get changeNoteHint => 'Il tuo contesto per questa fase';

  @override
  String get changeNoteOptional => 'NOTA SULLA MODIFICA (FACOLTATIVA)';

  @override
  String colorOption(String hex) {
    return 'Opzione colore $hex';
  }

  @override
  String compoundNumber(int number) {
    return 'COMPOSTO $number';
  }

  @override
  String compoundsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count composti',
      one: '1 composto',
    );
    return '$_temp0';
  }

  @override
  String copiedVialPreset(String amount, String unit) {
    return '$amount $unit preimpostazione fiala · copiato in questo protocollo';
  }

  @override
  String get createProtocolAction => 'CREA PROTOCOLLO';

  @override
  String get createProtocolAddOneError => 'Aggiungi almeno un peptide.';

  @override
  String createProtocolBuildStep(int step, int total) {
    return 'Crea protocollo · Passaggio $step / $total';
  }

  @override
  String get createProtocolDefaultName => 'Il mio protocollo';

  @override
  String createProtocolEditStep(int step, int total) {
    return 'Modifica protocollo · Passaggio $step / $total';
  }

  @override
  String get createProtocolFreeLimitReason =>
      'Il piano gratuito è limitato a un peptide per protocollo. Passa a Premium per combinare più composti.';

  @override
  String get createProtocolNameBody =>
      'Dategli un\'etichetta memorabile, ad es. “Stack di recupero” o “Q2 Shred”.';

  @override
  String get createProtocolNameTitle => 'Dai un nome al tuo protocollo';

  @override
  String get createProtocolNoPeptides => 'Ancora nessun peptide';

  @override
  String get createProtocolPickHint => 'Tocca + per scegliere dalla libreria';

  @override
  String get createProtocolReviewBody =>
      'Conferma i dettagli del protocollo. Puoi apportare modifiche in qualsiasi momento dalla vista Gestisci.';

  @override
  String get createProtocolSaveError =>
      'Impossibile salvare il protocollo. Riprova.';

  @override
  String get createProtocolStackBody =>
      'Aggiungi un peptide o combina più composti. Configura etichetta, quantità, frequenza e ciclo di ciascuno.';

  @override
  String get createProtocolStackTitle => 'Crea la tua combinazione';

  @override
  String get customBlend => 'Miscela personalizzata';

  @override
  String get customDays => 'Giorni personalizzati';

  @override
  String get customDaysDisclaimer =>
      'Vengono programmati solo i giorni selezionati. Le quantità sono valori di monitoraggio inseriti dall’utente, non indicazioni sul dosaggio.';

  @override
  String get customPeptide => 'Peptide personalizzato';

  @override
  String get cycleWeeksLabel => 'SETTIMANE IN CICLO';

  @override
  String get cycleWindowDisclaimer =>
      'Le finestre Ciclo e Riposo organizzano la cronologia del monitoraggio. PepMod non pianificherà le dosi future al termine della finestra del ciclo.';

  @override
  String get defaultAmountLabel => 'QUANTITÀ PREDEFINITA';

  @override
  String get diluentVolumeLabel => 'VOLUME DILUENTE';

  @override
  String get drawExceedsVialError =>
      'Il prelievo non può superare il volume della fiala.';

  @override
  String get drawLabel => 'PRELIEVO';

  @override
  String get drawPreviewLabel => 'ANTEPRIMA DEL PRELIEVO';

  @override
  String drawPreviewValue(String units, String volume) {
    return '$units unità = $volume mL';
  }

  @override
  String editTime(String time) {
    return 'Modifica ora $time';
  }

  @override
  String get endWeekLabel => 'FINE SETTIMANA';

  @override
  String get enterPeptideName => 'Inserisci il nome del peptide';

  @override
  String get frequencyLabel => 'FREQUENZA';

  @override
  String get labelColorBody =>
      'Abbina questo colore all\'etichetta della penna o della fiala che usi nella vita reale.';

  @override
  String get labelColorLabel => 'COLORE ETICHETTA';

  @override
  String get manageSavedCompounds => 'Gestisci i composti salvati';

  @override
  String get nextLabel => 'AVANTI';

  @override
  String get noneLabel => 'Nessuno';

  @override
  String get oneOffCompound => 'Composto unico';

  @override
  String get oneOffCompoundBody =>
      'Utilizzare una volta senza salvare un preset';

  @override
  String get optionalLabel => 'Opzionale';

  @override
  String peptidesCount(int count) {
    return 'PEPTIDI ($count)';
  }

  @override
  String get perDayAmounts => 'Importi giornalieri';

  @override
  String phaseExtendsWarning(int weeks) {
    return 'Una fase si estende oltre il ciclo di $weeks settimane. Regolare la finestra della fase o del ciclo.';
  }

  @override
  String get phaseNameHint => 'es. Monitoraggio settimana 1';

  @override
  String get phaseNameLabel => 'NOME FASE';

  @override
  String phaseNumber(int number) {
    return 'Fase $number';
  }

  @override
  String phaseOutsideCycleError(int weeks) {
    return 'Questo ciclo di protocollo termina dopo la settimana $weeks. Mantieni le settimane della fase all\'interno di quella finestra.';
  }

  @override
  String get phaseOverlapError =>
      'Gli intervalli delle settimane di fase non possono sovrapporsi.';

  @override
  String get phaseOverrideBody =>
      'Inserisci solo il programma di monitoraggio che intendi già seguire. PepMod non consiglia gli importi.';

  @override
  String get phaseOverrideTitle => 'MODIFICA SETTIMANALE';

  @override
  String get phasePreviewDisclaimer =>
      'Anteprima solo delle tue voci. Nessun programma è consigliato da PepMod.';

  @override
  String get phasePreviewLabel => 'ANTEPRIMA FASE';

  @override
  String get phaseReminderBody =>
      'Un promemoria di cambio di fase neutro è programmato per le 9:00 quando i promemoria di protocollo sono abilitati.';

  @override
  String get phaseScheduleLabel => 'PROGRAMMA DELLE FASI';

  @override
  String get phaseSelectDayError =>
      'Seleziona almeno un giorno. PepMod non sceglierà un programma per te.';

  @override
  String get phasesBody =>
      'Le finestre di date facoltative possono sostituire la quantità e il programma di base. Al di fuori di queste finestre, il programma di base continua.';

  @override
  String phasesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fasi',
      one: '1 fase',
    );
    return '$_temp0';
  }

  @override
  String get phasesDisclaimer =>
      'Le settimane vengono conteggiate a partire dalla data di inizio del protocollo. Le note di fase salvate e i promemoria di modifica sono solo aiuti per il monitoraggio.';

  @override
  String get preBlendedVial => 'Flaconcino pre-miscelato';

  @override
  String get preBlendedVialBody => 'Una fiala · un prelievo · più composti';

  @override
  String get protocolNotesBody =>
      'Salva il contesto che desideri sia visibile durante la revisione di questo protocollo.';

  @override
  String get protocolNotesHint =>
      'es. domande, contesto di monitoraggio o note del medico';

  @override
  String get protocolNotesLabel => 'Note del protocollo';

  @override
  String get reminderTimesBody =>
      'Ogni orario selezionato crea la propria riga di monitoraggio e un promemoria nei giorni programmati.';

  @override
  String get reminderTimesLabel => 'TEMPI DI PROMEMORIA';

  @override
  String get removeLabel => 'RIMUOVI';

  @override
  String removePeptide(String name) {
    return 'Rimuovi $name';
  }

  @override
  String get removePhase => 'Rimuovi fase';

  @override
  String removeTime(String time) {
    return 'Rimuovi ora $time';
  }

  @override
  String get restWeeksLabel => 'SETTIMANE DI RIPOSO';

  @override
  String get reviewLabel => 'Rivedi';

  @override
  String get routeLabel => 'VIA';

  @override
  String get saveBlend => 'SALVA MISCELA';

  @override
  String get saveChanges => 'SALVA MODIFICHE';

  @override
  String get savePhase => 'SALVA FASE';

  @override
  String savedVialPreset(String amount, String unit) {
    return '$amount $unit fiala · Preimpostazione salvata';
  }

  @override
  String get scheduleLabel => 'PROGRAMMA';

  @override
  String get searchCompounds => 'Cerca composti...';

  @override
  String get selectDayError =>
      'Seleziona almeno un giorno per programmare questo peptide.';

  @override
  String selectOption(String option) {
    return 'Seleziona $option';
  }

  @override
  String get startDateLabel => 'DATA DI INIZIO';

  @override
  String get startWeekLabel => 'INIZIO SETTIMANA';

  @override
  String syringeUnitsAmount(String amount) {
    return '$amount unità di siringa';
  }

  @override
  String get syringeUnitsDisclaimer =>
      'Contrassegni opzionali della siringa U-100 immessi dall\'utente solo per il tracciamento.';

  @override
  String get syringeUnitsHint => 'es. 12,5';

  @override
  String get syringeUnitsLabel => 'unità di siringa';

  @override
  String get syringeUnitsOptional => 'UNITÀ SIRINGA (FACOLTATIVE)';

  @override
  String get trackedAmountLabel => 'QUANTITÀ MONITORATA';

  @override
  String get u100TrackingDisclaimer =>
      'Utilizza le graduazioni della siringa U-100 (100 unità = 1 mL). I valori sono dati di monitoraggio inseriti dall’utente.';

  @override
  String get unitLabel => 'UNITÀ';

  @override
  String get vialAmountHint => 'Quantità nella fiala';

  @override
  String get vialContentsLabel => 'CONTENUTO DELLA FIALA';

  @override
  String get vialLabelNameHint => 'Nome dall\'etichetta della fiala';

  @override
  String weekNumber(int week) {
    return 'SETTIMANA $week';
  }

  @override
  String weekRange(int start, int end) {
    return 'SETTIMANE $start–$end';
  }

  @override
  String get weekToWeekPhases => 'FASI DI SETTIMANA';

  @override
  String weekdayDose(String weekday) {
    return '$weekday DOSE';
  }

  @override
  String weekdaySchedule(String weekday) {
    return '$weekday PROGRAMMA';
  }

  @override
  String get doseDrawInvalid =>
      'L\'estrazione deve essere maggiore di zero e all\'interno della fiala.';

  @override
  String get doseGenericError => 'Qualcosa è andato storto. Riprova.';

  @override
  String get doseEditSystemLabel => 'MODIFICA.DOSE';

  @override
  String get doseLogSystemLabel => 'LOG.DOSE';

  @override
  String get doseDraw => 'PRELIEVO';

  @override
  String get doseAmount => 'QUANTITÀ';

  @override
  String get doseUnits => 'unità';

  @override
  String get doseTime => 'ORARIO';

  @override
  String get doseChooseTime => 'Scegli l’orario della dose';

  @override
  String get doseBlendSnapshot => 'ISTANTANEA MISCELA // PER ESTRAZIONE';

  @override
  String doseSyringeUnitsRecorded(String amount) {
    return '$amount unità di siringa registrate per questa dose.';
  }

  @override
  String get doseInjectionSite => 'SITO.DI.INIEZIONE';

  @override
  String doseLastSite(String site) {
    return 'ULTIMO SITO PER QUESTO PEPTIDE · $site';
  }

  @override
  String get doseNotes => 'NOTE';

  @override
  String get doseOptional => 'Opzionale...';

  @override
  String get doseMarkPending => 'SEGNA COME IN ATTESA';

  @override
  String get doseSaveChanges => 'SALVA MODIFICHE';

  @override
  String get doseSkip => 'SALTA QUESTA DOSE';

  @override
  String get doseHistorySystemLabel => 'CRONOLOGIA.DOSI // 30.GIORNI';

  @override
  String get doseHistoryTitle => 'Dosi registrate';

  @override
  String get doseHistoryBody =>
      'Tocca una registrazione per correggere quantità, orario effettivo, sito di iniezione, note o stato.';

  @override
  String get doseHistoryEmpty =>
      'Nessuna dose registrata negli ultimi 30 giorni.';

  @override
  String get doseLogPrevious => 'REGISTRA UNA DOSE PASSATA';

  @override
  String doseHistorySkipped(String dateTime) {
    return 'Saltato · $dateTime';
  }

  @override
  String doseHistoryTaken(String amount, String units, String dateTime) {
    return '$amount $units · $dateTime';
  }

  @override
  String get doseEditAction => 'MODIFICA';

  @override
  String get doseChoosePastTime =>
      'Scegli un orario passato per la registrazione.';

  @override
  String get dosePreviousError =>
      'Impossibile registrare la dose precedente. Riprova.';

  @override
  String get doseLogPreviousSystemLabel => 'REGISTRA.PASSATA';

  @override
  String get doseNoPeptides => 'Nessun peptide disponibile';

  @override
  String get doseNoPeptidesBody =>
      'Aggiungi un peptide a un protocollo attivo prima di registrare la cronologia.';

  @override
  String get doseCorrectHistory => 'Correggi la cronologia delle dosi';

  @override
  String get dosePeptide => 'PEPTIDE';

  @override
  String get doseDate => 'DATA';

  @override
  String get doseChooseDate => 'Scegli la data della dose';

  @override
  String doseSyringeUnitsEntry(String amount) {
    return '$amount unità di siringa registrate per questa voce.';
  }

  @override
  String get doseHistoryDisclaimer =>
      'I registri storici sono solo record di tracciamento personali. Non modificano le linee guida mediche o le raccomandazioni sul dosaggio.';

  @override
  String get notificationChannelName => 'Promemoria sulla dose';

  @override
  String get notificationChannelDescription =>
      'Promemoria programmati per le dosi del protocollo peptidico attivo.';

  @override
  String get notificationDoseTitle => 'È ora della dose';

  @override
  String get notificationDoseBody =>
      'Il promemoria del protocollo programmato è pronto.';

  @override
  String get notificationCycleTitle => 'Punto di controllo del protocollo';

  @override
  String get notificationCycleBody =>
      'Oggi è previsto un promemoria sulla finestra del ciclo. Rivedi il tuo piano di monitoraggio.';

  @override
  String get notificationRestTitle =>
      'Punto di controllo del periodo di riposo';

  @override
  String get notificationRestBody =>
      'Oggi è previsto il promemoria del periodo di riposo. Rivedi il tuo piano di monitoraggio.';

  @override
  String get notificationPhaseTitle => 'Checkpoint della fase del protocollo';

  @override
  String get notificationPhaseBody =>
      'Da oggi inizia una nuova fase di tracciamento. Controlla il tuo programma salvato.';

  @override
  String get personalLibrarySystemLabel => 'SYS.LIBRERIA // PERSONALE';

  @override
  String get customCompoundIntro =>
      'Salva i nomi e le dimensioni delle fiale che inserisci personalmente. Le preimpostazioni sono scorciatoie di monitoraggio, non indicazioni sulla dose.';

  @override
  String get archivedHeading => 'ARCHIVIATO';

  @override
  String get activePresetsHeading => 'PRESET ATTIVI';

  @override
  String get showActive => 'Mostra attivo';

  @override
  String get archivedAction => 'Archiviato';

  @override
  String get customCompoundsLoadFailed =>
      'Impossibile caricare i composti. Riprova.';

  @override
  String get libraryLoadFailed =>
      'Impossibile caricare la libreria dei peptidi. Riprova.';

  @override
  String compoundVialSummary(String amount, String unit, String route) {
    return 'Fiala da $amount $unit · $route';
  }

  @override
  String get editPreset => 'Modifica preimpostazione';

  @override
  String get restorePreset => 'Ripristina';

  @override
  String get archivePreset => 'Archivia';

  @override
  String get noArchivedPresets => 'Nessun preset archiviato';

  @override
  String get noSavedCompounds => 'Nessun composto salvato';

  @override
  String get archivedPresetsHint =>
      'Le preimpostazioni archiviate rimangono qui finché non le ripristini.';

  @override
  String get createPresetHint =>
      'Crea un\'etichetta riutilizzabile e preimposta le dimensioni della fiala.';

  @override
  String get presetCompoundSystemLabel => 'COMPOSTO.PRESET';

  @override
  String get newCompound => 'Nuovo composto';

  @override
  String get editCompound => 'Modifica composto';

  @override
  String get ownVialDetailsHint =>
      'Inserisci solo i dettagli stampati sulla tua fiala.';

  @override
  String get compoundLabel => 'NOME DEL COMPOSTO';

  @override
  String get compoundNameExample => 'es. Il mio composto';

  @override
  String get vialUnitLabel => 'UNITÀ FIALA';

  @override
  String get trackingUnitLabel => 'UNITÀ DI MONITORAGGIO';

  @override
  String get notesOptional => 'NOTE FACOLTATIVE';

  @override
  String get compoundNoteExample => 'Etichetta o nota di conservazione';

  @override
  String get noDoseRecommendation =>
      'Non viene creata alcuna raccomandazione sul dosaggio. Inserisci sempre separatamente le quantità del protocollo.';

  @override
  String get saveCompoundFailed =>
      'Impossibile salvare la preimpostazione. Riprova.';

  @override
  String get routeTopical => 'Topica';

  @override
  String get frequencyCustomDays => 'Giorni personalizzati';

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
    return 'U-100 · $volume mL / $capacity unità';
  }

  @override
  String get peptideContentHcgDescription =>
      'La gonadotropina corionica umana (HCG) è un ormone glicoproteico utilizzato in contesti clinici regolamentati e spesso discusso insieme ai protocolli peptidici. Questa voce viene fornita come riferimento di tracciamento neutrale per le pianificazioni immesse dall\'utente.';

  @override
  String get peptideContentHcgTypicalDose => 'IU inserite dall’utente';

  @override
  String get peptideContentHcgHalfLife => '~24-36 ore';

  @override
  String get peptideContentHcgNotes =>
      'Solo su prescrizione in molte giurisdizioni. Registra esclusivamente quanto già indicato da un professionista sanitario qualificato; PepMod non fornisce indicazioni sul dosaggio dell’HCG.';

  @override
  String get peptideContentBpc157Description =>
      'BPC-157 (Body Protection Compound 157) è un peptide sintetico di 15 aminoacidi derivato da una proteina presente nel succo gastrico. È stato studiato in modelli animali per il suo ruolo nella riparazione dei tessuti molli e del rivestimento intestinale. I dati clinici sull’uomo rimangono limitati.';

  @override
  String get peptideContentBpc157TypicalDose => '250–500 mcg';

  @override
  String get peptideContentBpc157HalfLife => '~4 ore';

  @override
  String get peptideContentBpc157Notes =>
      'Ricostituire con acqua batteriostatica e conservare in frigorifero. Negli studi sugli animali viene comunemente associato a TB-500 nei protocolli per il recupero di tendini e legamenti.';

  @override
  String get peptideContentTb500Description =>
      'TB-500 è un frammento sintetico della proteina timosina beta-4 presente in natura. Negli studi sugli animali è stato studiato il suo ruolo nella migrazione cellulare e nella rigenerazione dei tessuti. È ampiamente utilizzato off-label dai ricercatori e in ambito veterinario.';

  @override
  String get peptideContentTb500TypicalDose =>
      '2-5 mg di carico settimanale, poi 2 mg di mantenimento';

  @override
  String get peptideContentTb500HalfLife => '~2 giorni';

  @override
  String get peptideContentTb500Notes =>
      'Spesso abbinato a BPC-157 per protocolli sui tessuti molli. La somministrazione frazionata due volte a settimana è comune a causa della lunga emivita.';

  @override
  String get peptideContentGhkCuDescription =>
      'GHK-Cu (peptide di rame) è un tripeptide naturale che lega il rame presente nel plasma umano. È stato studiato in applicazioni cosmetiche topiche per il rimodellamento cutaneo e la segnalazione dei follicoli piliferi.';

  @override
  String get peptideContentGhkCuTypicalDose => '1-2 mg';

  @override
  String get peptideContentGhkCuHalfLife => '~1 ora';

  @override
  String get peptideContentGhkCuNotes =>
      'Utilizzato anche localmente nelle formulazioni per la cura della pelle. Il dosaggio sottocutaneo è generalmente inferiore alle concentrazioni topiche.';

  @override
  String get peptideContentEpitalonDescription =>
      'Epitalon è un tetrapeptide sintetico analogo dell’epitalamina, un peptide estratto dalla ghiandola pineale. La ricerca russa ne ha esplorato gli effetti sull’attività della telomerasi e sulla regolazione circadiana.';

  @override
  String get peptideContentEpitalonTypicalDose =>
      '5-10 mg per giorno del ciclo';

  @override
  String get peptideContentEpitalonHalfLife => '~30 minuti';

  @override
  String get peptideContentEpitalonNotes =>
      'Viene generalmente utilizzato in brevi cicli intermittenti (ad esempio, 10–20 giorni di utilizzo seguiti da mesi di pausa), sulla base dei protocolli russi di ricerca sulla longevità.';

  @override
  String get peptideContentSemaglutideDescription =>
      'Semaglutide è un agonista del recettore GLP-1 originariamente sviluppato per il diabete di tipo 2 e successivamente approvato per la gestione cronica del peso con i marchi Ozempic e Wegovy. Rallenta lo svuotamento gastrico e modula la segnalazione dell\'appetito.';

  @override
  String get peptideContentSemaglutideTypicalDose =>
      '0,25–2,4 mg settimanali (titolato)';

  @override
  String get peptideContentSemaglutideHalfLife => '~7 giorni';

  @override
  String get peptideContentSemaglutideNotes =>
      'Solo su prescrizione nella maggior parte dei paesi. Il programma di titolazione parte da una dose bassa e aumenta ogni 4 settimane per gestire gli effetti indesiderati gastrointestinali.';

  @override
  String get peptideContentTirzepatideDescription =>
      'Tirzepatide è un doppio agonista dei recettori GIP/GLP-1 approvato per il diabete di tipo 2 (Mounjaro) e l’obesità (Zepbound). Gli studi clinici hanno mostrato riduzioni di peso maggiori rispetto agli agonisti del solo GLP-1.';

  @override
  String get peptideContentTirzepatideTypicalDose =>
      '2,5-15 mg settimanali (titolato)';

  @override
  String get peptideContentTirzepatideHalfLife => '~5 giorni';

  @override
  String get peptideContentTirzepatideNotes =>
      'Solo prescrizione nella maggior parte dei paesi. La titolazione standard prevede incrementi di 4 settimane. Iniettato per via sottocutanea una volta alla settimana.';

  @override
  String get peptideContentRetatrutideDescription =>
      'Retatrutide è un triplo agonista sperimentale che agisce sui recettori GIP, GLP-1 e del glucagone. Gli studi di fase 2 hanno riportato riduzioni di peso superiori a quelle delle terapie esistenti basate su GLP-1.';

  @override
  String get peptideContentRetatrutideTypicalDose =>
      'Dosi di prova 1-12 mg settimanali';

  @override
  String get peptideContentRetatrutideHalfLife => '~6 giorni';

  @override
  String get peptideContentRetatrutideNotes =>
      'È ancora in fase sperimentale e, al momento della stesura, non è approvato dalla FDA. Qualsiasi utilizzo al di fuori di uno studio clinico è strettamente riservato alla ricerca.';

  @override
  String get peptideContentIpamorelinDescription =>
      'Ipamorelin è un pentapeptide grelina-mimetico e secretagogo selettivo dell\'ormone della crescita. È stato studiato per la sua capacità di stimolare un rilascio pulsatile di GH con un effetto minimo su cortisolo o prolattina.';

  @override
  String get peptideContentIpamorelinTypicalDose => '200-300 mcg per iniezione';

  @override
  String get peptideContentIpamorelinHalfLife => '~2 ore';

  @override
  String get peptideContentIpamorelinNotes =>
      'Viene comunemente associato a CJC-1295 (senza DAC) per un rilascio sinergico di GH. Le tempistiche generalmente riportate sono prima di coricarsi e/o prima dell’allenamento, a stomaco vuoto.';

  @override
  String get peptideContentCjc1295DacDescription =>
      'CJC-1295 è un analogo sintetico del GHRH. La variante DAC (Drug Affinity Complex) si lega all\'albumina sierica, estendendone l\'emivita e producendo livelli di GH sostenuti anziché impulsi discreti.';

  @override
  String get peptideContentCjc1295DacTypicalDose => '1-2 mg a settimana';

  @override
  String get peptideContentCjc1295DacHalfLife => '~8 giorni';

  @override
  String get peptideContentCjc1295DacNotes =>
      'A lunga azione: generalmente somministrato una o due volte alla settimana. Aumenta il GH/IGF-1 di base anziché produrre impulsi acuti.';

  @override
  String get peptideContentCjc1295NoDacDescription =>
      'CJC-1295 senza DAC, noto anche come Mod-GRF(1-29), è un analogo del GHRH con una breve emivita. In genere è combinato con un GHRP come Ipamorelin per innescare il rilascio pulsatile naturale di GH.';

  @override
  String get peptideContentCjc1295NoDacTypicalDose => '100 mcg per iniezione';

  @override
  String get peptideContentCjc1295NoDacHalfLife => '~30 minuti';

  @override
  String get peptideContentCjc1295NoDacNotes =>
      'Azione breve: viene spesso associato a un GHRP (Ipamorelin, GHRP-2, GHRP-6) per amplificare i picchi di GH. Nei protocolli non clinici viene generalmente utilizzato 1–3 volte al giorno a stomaco vuoto.';

  @override
  String get peptideContentTesamorelinDescription =>
      'Tesamorelin è un analogo stabilizzato del GHRH approvato per ridurre l\'eccesso di grasso viscerale addominale nella lipodistrofia associata all\'HIV (marchio Egrifta). È stato studiato anche in contesti di invecchiamento cognitivo.';

  @override
  String get peptideContentTesamorelinTypicalDose => '1-2 mg al giorno';

  @override
  String get peptideContentTesamorelinHalfLife => '~30 minuti';

  @override
  String get peptideContentTesamorelinNotes =>
      'Farmaco soggetto a prescrizione. Studiato principalmente per la riduzione del tessuto adiposo viscerale. Somministrato per via sottocutanea una volta al giorno.';

  @override
  String get peptideContentMotsCDescription =>
      'MOTS-c è un peptide di derivazione mitocondriale codificato nel gene MT-RNR1. La ricerca ha studiato il suo ruolo nell’omeostasi metabolica, nella sensibilità all’insulina e nella fisiologia dell’esercizio.';

  @override
  String get peptideContentMotsCTypicalDose => '5–10 mg 2–3 volte a settimana';

  @override
  String get peptideContentMotsCHalfLife => '~90 minuti';

  @override
  String get peptideContentMotsCNotes =>
      'La ricerca è ancora emergente. Nei registri di auto-sperimentazione, alcuni utenti riferiscono un miglioramento del recupero dopo l’esercizio e dei marcatori metabolici.';

  @override
  String get peptideContentCerebrolysinDescription =>
      'Cerebrolysin è una miscela di peptidi a basso peso molecolare e aminoacidi derivati dal tessuto cerebrale suino. È prescritto in diversi paesi europei e asiatici per indicazioni neurodegenerative e per il recupero dall\'ictus.';

  @override
  String get peptideContentCerebrolysinTypicalDose =>
      'Fiale da 5–30 ml (ambito clinico)';

  @override
  String get peptideContentCerebrolysinHalfLife => 'Variabile (miscela)';

  @override
  String get peptideContentCerebrolysinNotes =>
      'Viene generalmente somministrato in cicli sotto supervisione clinica. Non è disponibile negli Stati Uniti. È oggetto di ricerca nell’ictus ischemico e nella malattia di Alzheimer.';

  @override
  String get peptideContentSelankDescription =>
      'Selank è un eptapeptide sintetico sviluppato in Russia come analogo del peptide immunomodulatore tuftsina. È stato studiato per gli effetti ansiolitici senza sedazione o dipendenza dalle benzodiazepine.';

  @override
  String get peptideContentSelankTypicalDose =>
      '250-500 mcg per via intranasale';

  @override
  String get peptideContentSelankHalfLife => '~pochi minuti (sistemico)';

  @override
  String get peptideContentSelankNotes =>
      'Più comunemente somministrato per via intranasale. La ricerca russa si concentra su ansia e attenzione. Emivita breve ma gli effetti riportati durano diverse ore.';

  @override
  String get peptideContentSemaxDescription =>
      'Semax è un eptapeptide sintetico derivato da un frammento di ACTH (4–10). La ricerca russa ha studiato i suoi effetti nootropici e neuroprotettivi, in particolare nei protocolli di recupero dall’ictus.';

  @override
  String get peptideContentSemaxTypicalDose =>
      '250-1000 mcg per via intranasale';

  @override
  String get peptideContentSemaxHalfLife => '~30 minuti';

  @override
  String get peptideContentSemaxNotes =>
      'La somministrazione intranasale è tipica. Approvato in Russia per l\'ictus ischemico. Spesso ciclato con Selank per effetti complementari.';

  @override
  String get peptideContentMelanotanIiDescription =>
      'Melanotan II è un analogo sintetico dell\'ormone stimolante gli alfa-melanociti (α-MSH). È stato originariamente sviluppato come potenziale agente abbronzante senza sole ed è stato anche associato ad effetti sull\'appetito e sulla libido.';

  @override
  String get peptideContentMelanotanIiTypicalDose =>
      'Carico di 250–1000 mcg, poi mantenimento';

  @override
  String get peptideContentMelanotanIiHalfLife => '~1 ora';

  @override
  String get peptideContentMelanotanIiNotes =>
      'Non approvato per alcun uso medico. Gli effetti collaterali più comuni riportati includono nausea e oscuramento dei nei esistenti. Qualsiasi neo nuovo o in evoluzione dovrebbe essere valutato da un dermatologo.';

  @override
  String get peptideContentPt141Description =>
      'PT-141, noto anche come Bremelanotide e commercializzato come Vyleesi, è un agonista del recettore della melanocortina approvato dalla FDA per il disturbo da desiderio sessuale ipoattivo nelle donne in premenopausa. Agisce sulle vie del sistema nervoso centrale.';

  @override
  String get peptideContentPt141TypicalDose => '1,25–1,75 mg al bisogno';

  @override
  String get peptideContentPt141HalfLife => '~2 ore';

  @override
  String get peptideContentPt141Notes =>
      'Farmaco soggetto a prescrizione in alcuni mercati. Viene assunto al bisogno anziché secondo un programma fisso. Gli effetti indesiderati comuni includono nausea e aumenti transitori della pressione arteriosa.';

  @override
  String get peptideContentDsipDescription =>
      'Il Delta Sleep-Inducing Peptide (DSIP) è un nonapeptide isolato dal cervello di coniglio negli anni 1970. È stato studiato per i possibili ruoli nella regolazione del sonno, nella modulazione del dolore e nella risposta allo stress, sebbene i meccanismi rimangano poco chiari.';

  @override
  String get peptideContentDsipTypicalDose => '100-500 mcg prima di coricarsi';

  @override
  String get peptideContentDsipHalfLife => '~7 minuti';

  @override
  String get peptideContentDsipNotes =>
      'Solitamente somministrato prima di andare a letto. Emivita plasmatica breve ma gli effetti riportati potrebbero durare più a lungo. La base di prove rimane limitata.';

  @override
  String get peptideContentThymosinAlpha1Description =>
      'La Thymosin Alpha-1 è un peptide di 28 aminoacidi originariamente isolato dal tessuto del timo. È stato approvato in diversi paesi come terapia immunomodulante aggiuntiva (nome commerciale Zadaxin) per l’epatite B e C.';

  @override
  String get peptideContentThymosinAlpha1TypicalDose =>
      '1,6 mg due volte a settimana';

  @override
  String get peptideContentThymosinAlpha1HalfLife => '~2 ore';

  @override
  String get peptideContentThymosinAlpha1Notes =>
      'Utilizzato in diversi mercati internazionali come parte di protocolli di immunomodulazione. Solitamente somministrato due volte a settimana. La ricerca continua in varie indicazioni.';

  @override
  String get peptideContentNadPlusDescription =>
      'NAD+ (nicotinammide adenina dinucleotide) è un coenzima centrale nel metabolismo energetico cellulare e nella riparazione del DNA. Il NAD+ iniettabile e i suoi precursori (NR, NMN) sono studiati nel contesto della salute e dell\'invecchiamento mitocondriale.';

  @override
  String get peptideContentNadPlusTypicalDose =>
      '100-500 mg IV o SubQ per sessione';

  @override
  String get peptideContentNadPlusHalfLife => '~90 minuti';

  @override
  String get peptideContentNadPlusNotes =>
      'Tecnicamente un coenzima piuttosto che un peptide, ma comunemente raggruppato con protocolli di longevità. Si consiglia un\'infusione lenta per ridurre al minimo il rossore e il disagio.';

  @override
  String get peptideContentSermorelinDescription =>
      'Sermorelin è un analogo sintetico dell’ormone di rilascio dell’ormone della crescita (GHRH). È stato utilizzato in ambito clinico come agente diagnostico della riserva di ormone della crescita ed è spesso discusso nel settore del benessere come peptide di supporto dell’asse GH.';

  @override
  String get peptideContentSermorelinTypicalDose =>
      '100-300 mcg prima di andare a letto';

  @override
  String get peptideContentSermorelinHalfLife => '~10-20 minuti';

  @override
  String get peptideContentSermorelinNotes =>
      'Spesso confrontato con CJC-1295 no-DAC perché entrambi agiscono sulla via del GHRH. La breve emivita rende comune il dosaggio serale nei protocolli non clinici.';

  @override
  String get peptideContentAod9604Description =>
      'AOD-9604 è un frammento modificato dell\'ormone della crescita umano, derivato dalla regione 176-191. È stato studiato per la segnalazione metabolica e della lipolisi, ma le prove umane pubblicate sono limitate e contrastanti.';

  @override
  String get peptideContentAod9604TypicalDose => '250-500 mcg al giorno';

  @override
  String get peptideContentAod9604HalfLife => '~30 minuti';

  @override
  String get peptideContentAod9604Notes =>
      'Chiamato anche frammento HGH 176–191 in alcune discussioni. Non è un farmaco dimagrante approvato; utilizzare un linguaggio di tracciamento neutro ed evitare garanzie sui risultati.';

  @override
  String get peptideContentKpvDescription =>
      'KPV è una breve sequenza tripeptidica (lisina-prolina-valina) derivata dall\'ormone stimolante gli alfa-melanociti. Viene discusso in contesti di ricerca per la segnalazione immunitaria e della barriera intestinale.';

  @override
  String get peptideContentKpvTypicalDose => '250-500 mcg al giorno';

  @override
  String get peptideContentKpvHalfLife => 'Non ben consolidato';

  @override
  String get peptideContentKpvNotes =>
      'Compare nelle discussioni sulla salute intestinale e sulle applicazioni topiche, anche in associazioni informali con BPC-157. Le evidenze sul dosaggio nell’uomo sono limitate, quindi i protocolli dovrebbero essere prudenti.';

  @override
  String get peptideContentSs31Description =>
      'SS-31, noto anche come Elamipretide, è un tetrapeptide mirato ai mitocondri studiato per le interazioni con la cardiolipina e la funzione della membrana mitocondriale. La ricerca clinica si è concentrata su rare condizioni mitocondriali e cardiache.';

  @override
  String get peptideContentSs31TypicalDose => 'I protocolli di prova variano';

  @override
  String get peptideContentSs31HalfLife => '~4 ore';

  @override
  String get peptideContentSs31Notes =>
      'Sperimentale in molti contesti. I protocolli della comunità spesso differiscono dalle formulazioni degli studi clinici e devono essere considerati esclusivamente di ricerca.';

  @override
  String get peptideContentLl37Description =>
      'LL-37 è un peptide antimicrobico della catelicidina umana coinvolto nella segnalazione immunitaria innata. Se ne discute nelle comunità di ricerca per quanto riguarda i percorsi di difesa dell\'ospite e di risposta dei tessuti, ma le considerazioni sulla sicurezza sono significative.';

  @override
  String get peptideContentLl37TypicalDose => 'I protocolli di ricerca variano';

  @override
  String get peptideContentLl37HalfLife => 'Non ben consolidato';

  @override
  String get peptideContentLl37Notes =>
      'Altamente sperimentale al di fuori della ricerca controllata. Poiché i peptidi antimicrobici possono influire sulla segnalazione immunitaria, è importante mantenere un’impostazione educativa prudente.';

  @override
  String get peptideContentDihexaDescription =>
      'Dihexa è un analogo peptidico derivato dall\'angiotensina IV attivo per via orale studiato preclinicamente per la segnalazione del fattore di crescita degli epatociti/c-Met e l\'attività sinaptogena. Non sono stati stabiliti dati sulla sicurezza e sull’efficacia nell’uomo.';

  @override
  String get peptideContentDihexaTypicalDose =>
      'Solo ricerca; i protocolli variano';

  @override
  String get peptideContentDihexaHalfLife => 'Non ben consolidato';

  @override
  String get peptideContentDihexaNotes =>
      'Popolare nelle discussioni sui nootropi ma molto sperimentale. Trattare come una voce di composto di ricerca piuttosto che come un protocollo suggerito.';

  @override
  String get peptideContentGhrp2Description =>
      'GHRP-2 è un peptide sintetico di rilascio dell’ormone della crescita che agisce come agonista del recettore della grelina. È stato studiato per la secrezione di GH, la segnalazione dell’appetito e i test endocrini.';

  @override
  String get peptideContentGhrp2TypicalDose => '100-300 mcg per iniezione';

  @override
  String get peptideContentGhrp2HalfLife => '~20–30 minuti';

  @override
  String get peptideContentGhrp2Notes =>
      'Spesso abbinato a un analogo del GHRH come CJC-1295 no-DAC o Sermorelin. Può influenzare l’appetito, il cortisolo e la prolattina più di Ipamorelin.';

  @override
  String get peptideContentGhrp6Description =>
      'GHRP-6 è un esapeptide sintetico e agonista del recettore della grelina studiato per il rilascio dell’ormone della crescita e la segnalazione dell’appetito. È uno dei peptidi più datati della famiglia GHRP.';

  @override
  String get peptideContentGhrp6TypicalDose => '100-300 mcg per iniezione';

  @override
  String get peptideContentGhrp6HalfLife => '~20–30 minuti';

  @override
  String get peptideContentGhrp6Notes =>
      'L\'uso comunitario spesso enfatizza la stimolazione dell\'appetito. Opzioni più selettive come Ipamorelin sono comunemente preferite quando gli effetti dell\'appetito sono indesiderati.';

  @override
  String get peptideContentHexarelinDescription =>
      'Hexarelin è un secretagogo sintetico dell’ormone della crescita e un agonista del recettore della grelina studiato per il rilascio di GH e i segnali cardiovascolari in ambito di ricerca. È generalmente considerato uno dei GHRP più potenti.';

  @override
  String get peptideContentHexarelinTypicalDose => '100-200 mcg per iniezione';

  @override
  String get peptideContentHexarelinHalfLife => '~70 minuti';

  @override
  String get peptideContentHexarelinNotes =>
      'Spesso ciclato in modo più conservativo rispetto a Ipamorelin a causa dei problemi di potenza e desensibilizzazione discussi nelle comunità di ricerca.';

  @override
  String get peptideContentIgf1Lr3Description =>
      'IGF-1 LR3 è un analogo modificato del fattore di crescita 1 simile all\'insulina con sostituzioni di aminoacidi che riducono l\'affinità con la proteina legante ed estendono l\'attività. Viene discusso principalmente in contesti di ricerca avanzata sulle prestazioni e sulla crescita cellulare.';

  @override
  String get peptideContentIgf1Lr3TypicalDose =>
      '20–50 mcg al giorno nei protocolli di ricerca';

  @override
  String get peptideContentIgf1Lr3HalfLife => '~20–30 ore';

  @override
  String get peptideContentIgf1Lr3Notes =>
      'Composto di ricerca ad alto rischio. I potenziali problemi di segnalazione del glucosio e della crescita dei tessuti rendono la supervisione medica particolarmente importante.';

  @override
  String get peptideContentIgf1DesDescription =>
      'IGF-1 DES è un analogo IGF-1 più corto a cui mancano i primi tre aminoacidi. Viene discusso come una variante IGF ad azione più breve nella ricerca sulla segnalazione tissutale locale.';

  @override
  String get peptideContentIgf1DesTypicalDose =>
      '20–50 mcg nei protocolli di ricerca';

  @override
  String get peptideContentIgf1DesHalfLife => '~20–30 minuti';

  @override
  String get peptideContentIgf1DesNotes =>
      'Molto avanzato e sperimentale. Evitare suggerimenti di protocollo generali perché i dati sulla sicurezza umana e il monitoraggio appropriato sono limitati.';

  @override
  String get peptideContentPegMgfDescription =>
      'PEG-MGF è una variante pegilata del fattore di crescita meccanico, un peptide derivato da una variante di splicing dell’IGF-1. La pegilazione mira a prolungare il tempo di circolazione rispetto al MGF non modificato.';

  @override
  String get peptideContentPegMgfTypicalDose =>
      '100–300 mcg settimanali nei protocolli di ricerca';

  @override
  String get peptideContentPegMgfHalfLife => 'Esteso mediante PEGilazione';

  @override
  String get peptideContentPegMgfNotes =>
      'Comune nei forum sulle prestazioni, ma non è una terapia approvata. Va considerato un composto di ricerca avanzata, con impostazioni di monitoraggio prudenti.';

  @override
  String get peptideContentMk677Description =>
      'MK-677, noto anche come Ibutamoren, è un agonista del recettore della grelina attivo per via orale e un secretagogo dell\'ormone della crescita. Non è un peptide, ma viene comunemente discusso insieme ai peptidi dell’asse GH.';

  @override
  String get peptideContentMk677TypicalDose => '10-25 mg al giorno';

  @override
  String get peptideContentMk677HalfLife => '~24 ore';

  @override
  String get peptideContentMk677Notes =>
      'Composto correlato, non un peptide. Le discussioni nella comunità spesso menzionano considerazioni sull’appetito, la ritenzione idrica, il sonno e il monitoraggio del glucosio.';

  @override
  String get peptideContentFiveAmino1mqDescription =>
      '5-Amino-1MQ è un inibitore di NNMT a piccola molecola discusso nelle comunità dedicate al metabolismo e alla composizione corporea. Non è un peptide, ma compare spesso in associazioni per la longevità e la perdita di grasso discusse insieme ai peptidi.';

  @override
  String get peptideContentFiveAmino1mqTypicalDose => '25-100 mg al giorno';

  @override
  String get peptideContentFiveAmino1mqHalfLife => 'Non ben consolidato';

  @override
  String get peptideContentFiveAmino1mqNotes =>
      'Composto correlato, non un peptide. Le prove umane sono limitate; evitare affermazioni sulla perdita di grasso o sugli esiti della sensibilità all\'insulina.';

  @override
  String get peptideContentTesofensineDescription =>
      'Tesofensine è un inibitore orale della ricaptazione delle monoamine studiato per l’obesità e le patologie neurodegenerative. Non è un peptide, ma viene spesso discusso nelle comunità dedicate alla gestione del peso insieme ai composti GLP-1.';

  @override
  String get peptideContentTesofensineTypicalDose =>
      '0,25-0,5 mg al giorno negli studi';

  @override
  String get peptideContentTesofensineHalfLife => '~9 giorni';

  @override
  String get peptideContentTesofensineNotes =>
      'Composto correlato, non un peptide. Poiché influisce sulle vie dei neurotrasmettitori, sono importanti la valutazione della pressione arteriosa, della frequenza cardiaca e delle possibili interazioni.';

  @override
  String get peptideContentRu58841Description =>
      'RU-58841 è un antiandrogeno topico non steroideo studiato per la segnalazione dei recettori degli androgeni nei follicoli piliferi. Non è un peptide, ma viene spesso discusso nelle comunità estetiche insieme ai peptidi.';

  @override
  String get peptideContentRu58841TypicalDose =>
      '25-50 mg topici al giorno in protocolli informali';

  @override
  String get peptideContentRu58841HalfLife => 'Non ben consolidato';

  @override
  String get peptideContentRu58841Notes =>
      'Composto correlato, non un peptide e non un farmaco approvato. Le preoccupazioni relative al controllo di qualità e all’esposizione sistemica sono punti di discussione comuni.';

  @override
  String get peptideContentEducationalDisclaimer =>
      'Solo per riferimento didattico. Non un consiglio medico. I peptidi di ricerca non sono approvati per l\'uso umano nella maggior parte delle giurisdizioni: consulta sempre un operatore sanitario qualificato.';

  @override
  String get twiceWeeklyPickDaysHint =>
      'Scegli esattamente due giorni della settimana per questo piano.';

  @override
  String get selectExactlyTwoDaysError =>
      'Seleziona esattamente due giorni per un piano di 2 volte a settimana.';

  @override
  String get remindersBlockedTitle => 'I promemoria sono bloccati';

  @override
  String get remindersBlockedBody =>
      'I promemoria delle dosi sono attivi in PepMod, ma le notifiche sono disattivate nelle impostazioni di sistema, quindi non possono essere recapitati.';

  @override
  String get openSettingsAction => 'Apri impostazioni';

  @override
  String freeTrialBadge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'PROVA GRATUITA DI $days GIORNI',
      one: 'PROVA GRATUITA DI $days GIORNO',
    );
    return '$_temp0';
  }

  @override
  String get createCustomCompoundAction => 'Crea composto personalizzato';

  @override
  String get noPeptidesFoundCreateHint =>
      'Nessuna corrispondenza nella libreria di riferimento. Puoi comunque tracciarlo come composto personalizzato.';

  @override
  String get blendSearchHint =>
      'I nomi di miscele come questo non hanno una formulazione standard: il contenuto varia in base al fornitore. Crealo qui come composto personalizzato, o come fiala premiscelata durante la creazione di un protocollo, inserendo il contenuto reale della tua fiala.';

  @override
  String get typicalDoseReferenceNote =>
      'Intervallo di riferimento pubblicato a scopo educativo: non è una raccomandazione né un\'istruzione.';

  @override
  String get peptideContentTestosteroneDescription =>
      'Il testosterone è un ormone androgeno endogeno. Le preparazioni iniettabili di esteri (come cipionato ed enantato) sono farmaci soggetti a prescrizione usati nella terapia ormonale supervisionata da un medico. Questa voce è un riferimento neutro di tracciamento per piani inseriti dall\'utente.';

  @override
  String get peptideContentTestosteroneTypicalDose =>
      'mg inseriti dall\'utente';

  @override
  String get peptideContentTestosteroneHalfLife => 'Dipende dall\'estere';

  @override
  String get peptideContentTestosteroneNotes =>
      'Solo su prescrizione e sostanza controllata in molte giurisdizioni. Registra solo quanto indicato da un professionista sanitario qualificato; PepMod non fornisce indicazioni di dosaggio del testosterone.';

  @override
  String get peptideContentGlutathioneDescription =>
      'Il glutatione è un tripeptide naturale (glutammato-cisteina-glicina) che funziona come importante antiossidante intracellulare. Le forme iniettabili sono usate in alcuni contesti clinici e di benessere. Questa voce è un riferimento neutro di tracciamento per piani inseriti dall\'utente.';

  @override
  String get peptideContentGlutathioneTypicalDose => 'mg inseriti dall\'utente';

  @override
  String get peptideContentGlutathioneHalfLife => 'Breve (sistemica)';

  @override
  String get peptideContentGlutathioneNotes =>
      'Lo stato regolatorio del glutatione iniettabile varia da paese a paese. Registra le quantità esattamente come ottenute e indicate; PepMod non fornisce indicazioni di dosaggio per questo composto.';

  @override
  String get peptideContentKisspeptin10Description =>
      'La kisspeptina-10 è un frammento di dieci aminoacidi del neuropeptide kisspeptina, studiato in ambito di ricerca per il suo ruolo nella segnalazione del GnRH e nella regolazione dell\'asse riproduttivo. I dati sull\'uomo al di fuori di studi controllati sono limitati. Questa voce è un riferimento neutro di tracciamento per piani inseriti dall\'utente.';

  @override
  String get peptideContentKisspeptin10TypicalDose => 'Inserito dall\'utente';

  @override
  String get peptideContentKisspeptin10HalfLife => '~minuti (riportato)';

  @override
  String get peptideContentKisspeptin10Notes =>
      'Composto di ricerca senza protocolli consolidati. Registra solo quantità inserite dall\'utente; PepMod non fornisce indicazioni di dosaggio per questo composto.';

  @override
  String get peptideContentSluPp332Description =>
      'SLU-PP-332 è un agonista ERR sperimentale a piccola molecola studiato in fase preclinica nella ricerca di fisiologia dell\'esercizio. Non è un peptide e non esistono dati consolidati di sicurezza o efficacia sull\'uomo. Questa voce è un riferimento neutro di tracciamento per piani inseriti dall\'utente.';

  @override
  String get peptideContentSluPp332TypicalDose => 'Inserito dall\'utente';

  @override
  String get peptideContentSluPp332HalfLife => 'Non ben stabilita';

  @override
  String get peptideContentSluPp332Notes =>
      'Composto di ricerca altamente sperimentale senza studi sull\'uomo. Composto correlato, non un peptide. Registra solo quantità inserite dall\'utente; PepMod non fornisce indicazioni di dosaggio per questo composto.';
}
