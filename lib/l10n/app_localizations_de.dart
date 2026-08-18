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
  String get openUnitConverter => 'Einheitenrechner öffnen';

  @override
  String get converterCardTitle => 'EINHEITENRECHNER';

  @override
  String get converterCardSubtitle => 'Fläschchenwerte jetzt umrechnen';

  @override
  String get converterCardHint =>
      'Für die Rekonstitution unten ein Peptid antippen.';

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
      'IE bleibt IE. PepMod rechnet IE nicht in mg/mcg um oder zurück.';

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
  String get addToProtocol => 'ZUM PROTOKOLL';

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

  @override
  String get tabProtocol => 'Protokoll';

  @override
  String get tabProgress => 'Fortschritt';

  @override
  String get tabLibrary => 'Bibliothek';

  @override
  String get tabYou => 'Du';

  @override
  String get continueLabel => 'WEITER';

  @override
  String get processingLabel => 'WIRD VERARBEITET…';

  @override
  String get authAppleFailed =>
      'Apple-Anmeldung fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get authGoogleFailed =>
      'Google-Anmeldung fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get authGenericError =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

  @override
  String get authUserNotFound =>
      'Für diese E-Mail-Adresse wurde kein Konto gefunden.';

  @override
  String get authIncorrectCredentials =>
      'E-Mail-Adresse oder Passwort ist falsch.';

  @override
  String get authAccountExists =>
      'Für diese E-Mail-Adresse gibt es bereits ein Konto.';

  @override
  String get authWeakPassword =>
      'Das Passwort ist zu schwach. Verwende mindestens 6 Zeichen.';

  @override
  String get authInvalidEmail => 'Ungültige E-Mail-Adresse.';

  @override
  String get authAppleUnavailable =>
      'Die Anmeldung mit Apple ist für diese App nicht aktiviert.';

  @override
  String get authRequiredTitle => 'Speichere dein persönliches\nProtokoll';

  @override
  String get authRequiredBody =>
      'Verknüpfe deinen Plan, Zeitplan, deine Dosisprotokolle und Erinnerungen mit deinem Konto, bevor das Protokoll freigeschaltet wird.';

  @override
  String get continueWithEmail => 'MIT E-MAIL FORTFAHREN';

  @override
  String get signInWithApple => 'MIT APPLE ANMELDEN';

  @override
  String get continueWithGoogle => 'MIT GOOGLE FORTFAHREN';

  @override
  String get authTermsDisclaimer =>
      'Wenn du fortfährst, akzeptierst du unsere Nutzungsbedingungen und Datenschutzerklärung. PepMod ist ein Lernwerkzeug und keine medizinische Beratung.';

  @override
  String get signIn => 'Anmelden';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get resetPassword => 'Passwort zurücksetzen';

  @override
  String get signInAction => 'ANMELDEN';

  @override
  String get createAccountAction => 'KONTO ERSTELLEN';

  @override
  String get sendResetLink => 'LINK SENDEN';

  @override
  String get passwordResetSent =>
      'E-Mail zum Zurücksetzen gesendet. Prüfe deinen Posteingang.';

  @override
  String get enterEmail => 'Gib deine E-Mail-Adresse ein';

  @override
  String get enterValidEmail => 'Gib eine gültige E-Mail-Adresse ein';

  @override
  String get enterPassword => 'Gib ein Passwort ein';

  @override
  String get passwordMinLength => 'Mindestens 6 Zeichen';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get alreadyHaveAccount => 'Du hast bereits ein Konto? Anmelden';

  @override
  String get backToSignIn => 'Zurück zur Anmeldung';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get showPassword => 'Passwort anzeigen';

  @override
  String get hidePassword => 'Passwort ausblenden';

  @override
  String get accountDeletedTitle => 'Konto gelöscht';

  @override
  String get accountDeletedBody =>
      'Dein PepMod-Konto und deine gespeicherten App-Daten wurden entfernt.';

  @override
  String get subscriptionUnavailable =>
      'Abos sind derzeit nicht verfügbar. Bitte versuche es erneut.';

  @override
  String get upgradeUnavailable =>
      'Das Upgrade ist derzeit nicht verfügbar. Bitte versuche es später erneut.';

  @override
  String get noPurchasesToRestore =>
      'Keine Käufe zum Wiederherstellen gefunden.';

  @override
  String get subscriptionErrorServiceUnavailable =>
      'Käufe sind vorübergehend nicht verfügbar. Bitte versuche es in Kürze erneut.';

  @override
  String get subscriptionErrorPlansUnavailable =>
      'Abopläne konnten nicht geladen werden. Bitte überprüfe deine Verbindung und versuche es erneut.';

  @override
  String get subscriptionErrorPurchaseCancelled => 'Kauf abgebrochen.';

  @override
  String get subscriptionErrorPurchaseNotAllowed =>
      'Käufe sind auf diesem Gerät nicht erlaubt.';

  @override
  String get subscriptionErrorPurchaseInvalid =>
      'Der Kauf konnte nicht abgeschlossen werden. Bitte überprüfe dein Konto und versuche es erneut.';

  @override
  String get subscriptionErrorProductUnavailable =>
      'Dieses Abo ist derzeit nicht verfügbar. Bitte wähle einen anderen Plan oder versuche es später erneut.';

  @override
  String get subscriptionErrorNetwork =>
      'Du bist offline. Überprüfe deine Verbindung und versuche es erneut.';

  @override
  String get subscriptionErrorPurchaseFailed =>
      'Kauf fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get subscriptionErrorRestoreFailed =>
      'Käufe konnten nicht wiederhergestellt werden. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get unlockFullProtocol => 'Schalte das vollständige Protokoll frei';

  @override
  String get premiumUnlimitedPeptides =>
      'Unbegrenzt viele Peptide pro Protokoll';

  @override
  String get premiumMultipleProtocols => 'Mehrere aktive Protokolle';

  @override
  String get premiumCalculator => 'Rekonstitutionsrechner (alle Peptide)';

  @override
  String get premiumMetrics => 'Körperwerte und Diagramme verfolgen';

  @override
  String get upgradeNow => 'JETZT UPGRADEN';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get notRightNow => 'Jetzt nicht';

  @override
  String get protocolWeeklyPlanner => 'Wochenplan';

  @override
  String get protocolDoseHistory => 'Dosisverlauf';

  @override
  String get protocolCreate => 'Protokoll erstellen';

  @override
  String get protocolManage => 'VERWALTEN';

  @override
  String get protocolYourProtocol => 'Dein Protokoll';

  @override
  String get protocolNoActive => 'Kein aktives Protokoll';

  @override
  String get protocolNoActiveBody =>
      'Erstelle dein erstes Protokoll, um Dosen und Regelmäßigkeit zu erfassen.';

  @override
  String get protocolStartFirst => 'ERSTES PROTOKOLL STARTEN';

  @override
  String get protocolScheduleTodaySystemLabel => 'PLAN // HEUTE';

  @override
  String get protocolAdherenceTodaySystemLabel => 'ADHÄRENZ // HEUTE';

  @override
  String get protocolNoDosesScheduledToday => 'Heute keine Dosen geplant';

  @override
  String protocolDosesTaken(int taken, int total) {
    return '$taken von $total Dosen erfasst';
  }

  @override
  String get protocolNextDose => 'NÄCHSTE DOSIS';

  @override
  String protocolInTime(String duration) {
    return 'In $duration';
  }

  @override
  String protocolDurationHoursMinutes(int hours, int minutes) {
    return '$hours Std. $minutes Min.';
  }

  @override
  String protocolDurationMinutes(int minutes) {
    return '$minutes Min.';
  }

  @override
  String get protocolLogDose => 'DOSIS ERFASSEN';

  @override
  String get protocolNow => 'jetzt';

  @override
  String get protocolMissed => 'VERPASST';

  @override
  String get protocolSkipped => 'ÜBERSPRUNGEN';

  @override
  String get protocolNoDosesToday => 'Heute keine Dosen';

  @override
  String get protocolNoDosesTodayBody =>
      'Für dein Protokoll sind heute keine Dosen geplant.';

  @override
  String get protocolFreeLimit =>
      'Im kostenlosen Tarif ist nur ein Protokoll möglich. Mit Premium kannst du mehrere Stacks gleichzeitig nutzen.';

  @override
  String protocolSyringeUnitsSuffix(String amount) {
    return ' · $amount Spritzeneinheiten';
  }

  @override
  String get injectionSiteLeftAbdomen => 'Linker Bauch';

  @override
  String get injectionSiteRightAbdomen => 'Rechter Bauch';

  @override
  String get injectionSiteLeftThigh => 'Linker Oberschenkel';

  @override
  String get injectionSiteRightThigh => 'Rechter Oberschenkel';

  @override
  String get injectionSiteLeftGlute => 'Linke Gesäßhälfte';

  @override
  String get injectionSiteRightGlute => 'Rechte Gesäßhälfte';

  @override
  String get injectionSiteLeftTriceps => 'Linker Trizeps';

  @override
  String get injectionSiteRightTriceps => 'Rechter Trizeps';

  @override
  String get injectionSiteLeftDeltoid => 'Linker Deltamuskel';

  @override
  String get injectionSiteRightDeltoid => 'Rechter Deltamuskel';

  @override
  String get plannerToday => 'HEUTE';

  @override
  String get plannerBack => 'Zurück';

  @override
  String get plannerPreviousWeek => 'Vorherige Woche';

  @override
  String get plannerNextWeek => 'Nächste Woche';

  @override
  String plannerScheduledCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count geplante Dosen',
      one: '$count geplante Dosis',
    );
    return '$_temp0';
  }

  @override
  String get plannerTrackingDisclaimer =>
      'Nur zur Dokumentation. Dieser Kalender zeigt dein gespeichertes Protokoll und gibt keine Dosierungsempfehlung.';

  @override
  String get plannerWashoutPeriod => 'Pausenzeit';

  @override
  String plannerWashoutUntil(String date) {
    return 'Pause bis $date';
  }

  @override
  String get plannerNoScheduledDoses => 'Keine Dosen geplant';

  @override
  String get plannerNothingPlanned =>
      'In deinen gespeicherten Protokollen ist nichts geplant.';

  @override
  String get activatePro => 'PRO AKTIVIEREN';

  @override
  String activateProPrice(String price) {
    return 'PRO AKTIVIEREN — $price/Jahr';
  }

  @override
  String get annualAccess => 'Jährlicher Zugang';

  @override
  String get annualLabel => 'Jährlich';

  @override
  String get averageRating => 'Ø BEWERTUNG';

  @override
  String get bacWaterLabel => 'BAC-WASSER';

  @override
  String get basedOnInputs => 'Basierend auf deinen Angaben //';

  @override
  String get bestValue => 'Bestes Angebot';

  @override
  String get birthDateInvalid =>
      'Gib ein gültiges Geburtsdatum für ein Alter von 18 Jahren oder älter ein.';

  @override
  String get birthDateValid => 'Alter bestätigt';

  @override
  String calculatorDemoBody(String peptideName) {
    return 'So funktioniert es mit $peptideName';
  }

  @override
  String get calculatorDemoResult =>
      'Das war\'s. Werte eingeben,\nexakte Spritzeneinheiten erhalten.';

  @override
  String get calculatorDemoTitle => 'Keine gruselige\nMathematik mehr.';

  @override
  String get confidenceCycleTiming => 'Zyklus-Timing';

  @override
  String get confidenceCycleTimingDetail =>
      'Protokolltermine und Zeitfenster klar im Blick behalten';

  @override
  String get confidenceDoseMath => 'Dosis-Rechnung';

  @override
  String get confidenceDoseMathDetail =>
      'Fläschchen, Wasser, Dosis und Aufziehmenge an einem Ort';

  @override
  String get confidenceLabel => 'SICHERHEIT';

  @override
  String get confidencePlainInfo => 'Informationen in einfacher Sprache';

  @override
  String get confidencePlainInfoDetail =>
      'Lies Forschungsnotizen ohne Ablenkung';

  @override
  String get confidenceProgressSignals => 'Fortschrittssignale';

  @override
  String get confidenceProgressSignalsDetail =>
      'Verfolge Adhärenz und Körperwerte im Zeitverlauf';

  @override
  String get confidenceSafetyFraming => 'Sicherheitshinweise';

  @override
  String get confidenceSafetyFramingDetail =>
      'Behalte Hinweise und Haftungsausschlüsse im Blick';

  @override
  String get confidenceSiteRotation => 'Stellenrotation';

  @override
  String get confidenceSiteRotationDetail =>
      'Behalte im Blick, wo jede Dosis erfasst wurde';

  @override
  String get connectingToStore => 'VERBINDUNG ZUM STORE...';

  @override
  String continueSelected(int count) {
    return 'WEITER ($count)';
  }

  @override
  String get customProtocol => 'Eigenes Protokoll';

  @override
  String get dateOfBirthLabel => 'GEBURTSDATUM';

  @override
  String get dayOne => 'TAG 1';

  @override
  String get dayShortLabel => 'TT';

  @override
  String get defaultConfidence => 'Dosisberechnung · Stellenrotation';

  @override
  String get defaultFrustration => 'Verpasste Dosen';

  @override
  String get defaultGoals => 'Regeneration · Langlebigkeit';

  @override
  String get doseLabel => 'DOSIS';

  @override
  String get dosesLogged => 'DOSEN ERFASST';

  @override
  String get dosesPerDay => 'DOSEN/TAG';

  @override
  String get drawVolumeLabel => 'ENTNAHMEVOLUMEN';

  @override
  String get durationLabel => 'DAUER';

  @override
  String get experienceAdvanced => 'Fortgeschritten';

  @override
  String get experienceAdvancedDetail =>
      'Ich komme gut mit detaillierten Protokollen zurecht';

  @override
  String get experienceFirstTime => 'Erstmalig';

  @override
  String get experienceFirstTimeDetail => 'Ich bin neu beim Peptid-Tracking';

  @override
  String get experienceIntermediate => 'MITTEL';

  @override
  String get experienceLabel => 'ERFAHRUNG';

  @override
  String get experienceNovice => 'ANFÄNGER';

  @override
  String get experienceSome => 'Etwas Erfahrung';

  @override
  String get experienceSomeDetail =>
      'Ich habe schon ein oder zwei Protokolle erfasst';

  @override
  String get experienceVeteran => 'SEHR ERFAHREN';

  @override
  String get featureDoseMathBody =>
      'Behalte Fläschchengröße, Wassermenge, Dosis und aufzuziehende Einheiten neben dem Protokoll, das du gerade verfolgst.';

  @override
  String get featureDoseMathTitle => 'Dosis-Rechnung\nim Kontext';

  @override
  String get featureProtocolArcBody =>
      'Sieh, wie geplante Dosen, erfasste Dosen, Adhärenz und Körperwerte zu einer Zeitleiste zusammenwachsen.';

  @override
  String get featureProtocolArcTitle => 'Protokollverlauf\nim Zeitverlauf';

  @override
  String get featureShowcaseTitle => 'Alles, was du brauchst.\nEine App.';

  @override
  String get featureSiteRotationBody =>
      'Merke dir jede erfasste Stelle und behalte den Rotationsverlauf im Dosiseintrag.';

  @override
  String get featureSiteRotationTitle => 'Rotation der\nInjektionsstellen';

  @override
  String get firstNameExample => 'z. B. Alex';

  @override
  String get firstNameLabel => 'VORNAME';

  @override
  String get frustrationForgetting => 'Dosen vergessen';

  @override
  String get frustrationLabel => 'FRUSTRATION';

  @override
  String get frustrationMath => 'Fläschchen- und Spritzenrechnung';

  @override
  String get frustrationProgress => 'Erkennen, ob ich konsequent bin';

  @override
  String get frustrationSchedule => 'Den Zeitplan im Blick behalten';

  @override
  String get frustrationStacking => 'Mehrere Peptide gleichzeitig verwalten';

  @override
  String get frustrationTrust => 'Vertrauenswürdige Informationen finden';

  @override
  String get goalAntiAging => 'Gesundes Altern';

  @override
  String get goalAntiAgingDetail =>
      'Auf Langlebigkeit ausgerichtete Aufzeichnungen ordnen';

  @override
  String get goalCognitive => 'Kognitive Unterstützung';

  @override
  String get goalCognitiveDetail =>
      'Fokus und mentale Leistung im Blick behalten';

  @override
  String get goalImmune => 'Immununterstützung';

  @override
  String get goalImmuneDetail =>
      'Auf das Immunsystem ausgerichtete Protokolle ordnen';

  @override
  String get goalMuscleGrowth => 'Muskelaufbau';

  @override
  String get goalMuscleGrowthDetail =>
      'Trainings- und Wachstumsziele verfolgen';

  @override
  String get goalOther => 'Sonstiges';

  @override
  String get goalOtherDetail => 'Ein anderes Tracking-Ziel einrichten';

  @override
  String get goalRecovery => 'Regeneration';

  @override
  String get goalRecoveryDetail =>
      'Regenerationsaufzeichnungen und Routinen unterstützen';

  @override
  String get goalSleep => 'Schlaf';

  @override
  String get goalSleepDetail => 'Schlafbezogene Ziele und Muster erfassen';

  @override
  String get goalWeightLoss => 'Gewichtsverlust';

  @override
  String get goalWeightLossDetail =>
      'Stoffwechselziele und Fortschritt verfolgen';

  @override
  String get goalsLabel => 'ZIELE';

  @override
  String get iUnderstand => 'VERSTANDEN';

  @override
  String get lastThreeDaysAgo => 'Zuletzt: vor 3 Tagen';

  @override
  String get leftAbdomen => 'Linker Bauch';

  @override
  String get loveIt => 'SUPER';

  @override
  String get maybeLater => 'Vielleicht später';

  @override
  String get monthOne => 'MONAT 1';

  @override
  String get monthShortLabel => 'MM';

  @override
  String get monthTwo => 'MONAT 2';

  @override
  String moreCount(String shown, int count) {
    return '$shown +$count weitere';
  }

  @override
  String get needsWork => 'AUSBAUFÄHIG';

  @override
  String get notificationBody =>
      'Erhalte dezente Erinnerungen, wenn ein geplantes Protokollfenster fällig ist. Keine Peptidnamen in den Mitteilungen — nur ein sanfter Hinweis.';

  @override
  String get notificationTitle => 'Dosiszeiten\nim Blick behalten.';

  @override
  String get nowLabel => 'jetzt';

  @override
  String get ok => 'OK';

  @override
  String get onboardingAgeConfirmed => 'ICH BIN 18 ODER ÄLTER';

  @override
  String get onboardingAgeRequirementBody =>
      'Du musst mindestens 18 Jahre alt sein, um PepMod zu nutzen.';

  @override
  String get onboardingAgeRequirementTitle => 'Altersvoraussetzung';

  @override
  String get onboardingAgeVerificationBody =>
      'PepMod ist für Erwachsene ab 18 Jahren vorgesehen.';

  @override
  String get onboardingAgeVerificationTitle => 'Bestätige zuerst\ndein Alter.';

  @override
  String get onboardingAheadBody =>
      'Beantworte ein paar Fragen, und PepMod erstellt eine persönliche Tracking-Vorschau.';

  @override
  String get onboardingAheadTitle => 'Sieh dein Protokoll,\nbevor du startest.';

  @override
  String get onboardingBirthDateBody =>
      'Damit bestätigst du, dass du die Altersanforderung erfüllst.';

  @override
  String get onboardingBirthDateTitle => 'Wann wurdest\ndu geboren?';

  @override
  String get onboardingConfidenceBody =>
      'Wähle alles aus, was PepMod für dich klarer machen soll.';

  @override
  String get onboardingConfidenceTitle => 'Wobei möchtest du\nmehr Sicherheit?';

  @override
  String get onboardingConversionValueBody =>
      'Rechne die Werte aus deinem Fläschchen und Plan in Volumen und Spritzeneinheiten um.';

  @override
  String get onboardingConversionValueTitle =>
      'Fläschchenrechnung\neinfacher prüfen.';

  @override
  String get onboardingDisclaimerBody =>
      'PepMod hilft dir, Aufzeichnungen, Erinnerungen und Einheitenumrechnungen zu organisieren. Es diagnostiziert nicht, verschreibt nichts und ersetzt keine qualifizierte medizinische Beratung.';

  @override
  String get onboardingDisclaimerTitle =>
      'Für Klarheit gemacht.\nKeine Verschreibungen.';

  @override
  String get onboardingExperienceTitle => 'Wie viel Erfahrung\nhast du?';

  @override
  String get onboardingFrustrationBody => 'Wähle den größten Stolperstein.';

  @override
  String get onboardingFrustrationTitle => 'Was ist aktuell\nam schwierigsten?';

  @override
  String get onboardingGoalsTitle => 'Was sind deine\nwichtigsten Ziele?';

  @override
  String get onboardingGuidedStartBody =>
      'Wir passen die Einrichtung an deine Ziele, deine Erfahrung und die Aufzeichnungen an, die du führen möchtest.';

  @override
  String get onboardingGuidedStartTitle =>
      'Ein geführter Start,\nganz auf dich abgestimmt.';

  @override
  String get onboardingHookAnswer =>
      'PepMod hält die Antwort direkt bei deinem Protokoll bereit.';

  @override
  String get onboardingHookQuestion => 'Wie viele Einheiten\nziehst du auf?';

  @override
  String get onboardingHookResearch => 'RECHERCHE-BIBLIOTHEK';

  @override
  String get onboardingHookSources => 'Quellenbelegte Informationen';

  @override
  String get onboardingHookVial => 'FLÄSCHCHEN + VERDÜNNUNG';

  @override
  String get onboardingNameBody =>
      'Damit personalisieren wir dein PepMod-Erlebnis.';

  @override
  String get onboardingNameTitle => 'Wie dürfen wir\ndich nennen?';

  @override
  String get onboardingPeptideSelectBody =>
      'Wähle die Peptide, die du nutzt oder im Blick behalten möchtest.';

  @override
  String get onboardingPeptideSelectTitle => 'Was möchtest du\nerfassen?';

  @override
  String get onboardingProgressValueBody =>
      'Bringe Regelmäßigkeit, Dosisverlauf und Körperwerte in eine übersichtliche Aufzeichnung.';

  @override
  String get onboardingProgressValueTitle =>
      'Sieh den gesamten Verlauf\nüber die Zeit.';

  @override
  String get onboardingProtocolValueBody =>
      'Plane Zeitpläne, erfasse Dosen und behalte die Details zu jedem Protokoll.';

  @override
  String get onboardingProtocolValueTitle => 'Jedes Protokoll\nan einem Ort.';

  @override
  String get onboardingUnder18 => 'ICH BIN UNTER 18';

  @override
  String get openingPermission => 'BERECHTIGUNG WIRD GEÖFFNET...';

  @override
  String get paywallArcBody =>
      'Sieh, was geplant war, was erfasst wurde und wo eine sauberere Aufzeichnung nötig ist.';

  @override
  String get paywallArcTitle => 'VERLAUF ÜBER ZEIT BEOBACHTEN';

  @override
  String get paywallBody =>
      'Dosis-Rechnung, Stellenrotation, Erinnerungen und Protokollverlauf — alles in einer Aufzeichnung.';

  @override
  String get paywallDoseMathBody =>
      'Halte Fläschchen, Wasser, Dosis und Aufziehmenge zusammen, damit jeder Eintrag leichter zu prüfen ist.';

  @override
  String get paywallDoseMathTitle => 'DIE DOSISRECHNUNG RICHTIG MACHEN';

  @override
  String get paywallPreviewDisclaimer =>
      'Für Aufzeichnungen, Erinnerungen und Einheitenklarheit — keine medizinische Beratung.';

  @override
  String get paywallRotationBody =>
      'Jede Stelle, jeder Zyklus und jede Erinnerung bleibt im Protokoll erhalten.';

  @override
  String get paywallRotationTitle =>
      'VERLIERE NIE DEN ÜBERBLICK ÜBER DEINE ROTATION';

  @override
  String get paywallTitle => 'Alles für dein\nProtokoll.';

  @override
  String get paywallValueNote =>
      'Eine verwirrende Fläschchenberechnung kann Zeit und Produkt kosten. PepMod hält die Berechnung direkt beim Eintrag, damit du deine Aufzeichnungen prüfen kannst, bevor du nach alten Notizen handelst.';

  @override
  String get peptideLabel => 'PEPTID';

  @override
  String get peptidesLabel => 'PEPTIDE';

  @override
  String get peptidesTracked => 'PEPTIDE\nERFASST';

  @override
  String get perWeek => '/Woche';

  @override
  String get perYear => '/Jahr';

  @override
  String get privacyLabel => 'Datenschutz';

  @override
  String processingGoals(int count) {
    return 'ANALYSIERE $count ZIELE...';
  }

  @override
  String processingPeptides(int count) {
    return 'VERKNÜPFE $count PEPTID-EINTRÄGE...';
  }

  @override
  String get processingProtocol => 'DEIN PROTOKOLL WIRD ERSTELLT...';

  @override
  String get processingSchedule => 'DEIN ZEITPLAN WIRD ORGANISIERT...';

  @override
  String get processingTitle => 'Dein Protokoll\nwird erstellt';

  @override
  String get progressLabel => 'Fortschritt';

  @override
  String get protocolClarity => 'Protokollklarheit';

  @override
  String get protocolIncludes => 'DEIN PROTOKOLL ENTHÄLT //';

  @override
  String get protocolPreviewTitle => 'Dein Protokoll\nist bereit.';

  @override
  String get protocolReady => 'PROTOKOLL BEREIT //';

  @override
  String get protocolReminderReady => 'Protokollerinnerung ist bereit';

  @override
  String get protocolReservedFor =>
      'DEIN PERSÖNLICHES PROTOKOLL IST RESERVIERT FÜR';

  @override
  String get restorePurchase => 'Kauf wiederherstellen';

  @override
  String get resultsSummaryBody =>
      'Wir bewahren Dosisprotokolle, Rekonstitutionsberechnungen und Trendaufzeichnungen zusammen auf, während deine Daten wachsen.';

  @override
  String get reviewGateBody =>
      'Dein Feedback hilft uns, die Plattform für alle Biohacker zu verbessern.';

  @override
  String get reviewGateTitle => 'Gefällt dir PepMod\nbisher?';

  @override
  String roadmapBody(int count, String need) {
    return 'Aufgebaut rund um $count erfasste Peptide und deinen Bedarf an $need.';
  }

  @override
  String get roadmapDayOneBody =>
      'Peptide, Dosisprotokolle, Stellenrotation und Erinnerungen sind bereit.';

  @override
  String get roadmapDayOneTitle => 'Dein erstes Protokoll ist geordnet';

  @override
  String get roadmapDisclaimer =>
      'PepMod hält Aufzeichnungen und Erinnerungen organisiert. Es verschreibt oder diagnostiziert nicht und ersetzt keine ärztliche Beratung.';

  @override
  String get roadmapMonthOneBody =>
      'Adhärenz, verpasste Dosen und Körperwerte beginnen, eine klarere Aufzeichnung zu bilden.';

  @override
  String get roadmapMonthOneTitle =>
      'Dein Verlauf der Regelmäßigkeit nimmt Form an';

  @override
  String get roadmapMonthTwoBody =>
      'Sieh, was du geplant hast, was passiert ist und wo deine Aufzeichnungen Aufmerksamkeit brauchen.';

  @override
  String get roadmapMonthTwoTitle =>
      'Dein vollständiger Protokollverlauf ist sichtbar';

  @override
  String get roadmapTitle => 'Das erwartet\ndich als Nächstes.';

  @override
  String get roadmapWeekOneBody =>
      'Verständliche Recherchen und Tracking-Notizen bleiben mit deinem Plan verknüpft.';

  @override
  String roadmapWeekOneTitle(String goal) {
    return 'Deine Bibliothek füllt sich rund um $goal';
  }

  @override
  String savePercent(int percent) {
    return 'SPARE $percent%';
  }

  @override
  String get saveRoadmap => 'DIESEN FAHRPLAN SPEICHERN';

  @override
  String get schedulePreview => 'ZEITPLAN-VORSCHAU';

  @override
  String get seeWhatsInside => 'ENTDECKE, WAS DABEI IST';

  @override
  String get selectAllThatApply => 'Wähle alles Zutreffende aus.';

  @override
  String get siteMap => 'Stellenübersicht';

  @override
  String get skipForNow => 'VORERST ÜBERSPRINGEN';

  @override
  String get socialProofBody =>
      'Schließe dich Tausenden an, die echten Fortschritt erfassen.';

  @override
  String get socialProofTitle => 'Vertraut von\nBiohackern weltweit';

  @override
  String get specialOffer => 'SONDERANGEBOT';

  @override
  String get startFreeTrial => 'KOSTENLOS TESTEN';

  @override
  String get subscribeLabel => 'ABONNIEREN';

  @override
  String subscribePrice(String price) {
    return 'ABONNIEREN — $price/Woche';
  }

  @override
  String subscribeAnnualPrice(String price) {
    return 'ABONNIEREN — $price/Jahr';
  }

  @override
  String get subscribeToActivate =>
      'Abonniere, um dein Protokoll zu aktivieren';

  @override
  String get subscriptionRenewalDisclaimer =>
      'Das Abo verlängert sich automatisch, sofern es nicht mindestens 24 Stunden vor Ende des aktuellen Zeitraums gekündigt wird. Verwaltung unter Einstellungen > Apple-ID > Abonnements.';

  @override
  String syringeVolume(String volume) {
    return '${volume}ml auf einer 1ml-Spritze';
  }

  @override
  String get termsLabel => 'Bedingungen';

  @override
  String get testimonialOne =>
      'Ich vergesse endlich keine Dosen mehr. Allein der Rekonstitutionsrechner hat mir Stunden Tabellenrechnerei erspart.';

  @override
  String get testimonialThree =>
      'Der übersichtlichste Peptid-Tracker, den ich genutzt habe. Wirkt, als wäre er für ernsthafte Nutzer gemacht — weil er es ist.';

  @override
  String get testimonialTwo =>
      'Die wöchentlichen Einblicke haben ein Timing-Problem aufgedeckt, das mir monatelang nicht aufgefallen war. Absolutes Highlight.';

  @override
  String get thirtyDayAdherence => '30-Tage-Adhärenz';

  @override
  String get timelineLabel => 'Zeitachse';

  @override
  String get trackedLabel => 'erfasst';

  @override
  String get turnOnReminders => 'ERINNERUNGEN AKTIVIEREN';

  @override
  String get unitConversionDisclaimer =>
      'Nur ein Referenzwerkzeug zur Einheitenumrechnung. Prüfe die Angaben immer mit deinem medizinischen Fachpersonal.';

  @override
  String get unitsLabel => 'Einheiten';

  @override
  String get unitsToDraw => 'Aufzuziehende Einheiten';

  @override
  String get unlockPepMod => 'PEPMOD FREISCHALTEN';

  @override
  String get usersLabel => 'NUTZER';

  @override
  String get viewLabel => 'ANSICHT';

  @override
  String get weekDuration => 'WOCHEN-\nDAUER';

  @override
  String get weekOne => 'WOCHE 1';

  @override
  String get weeklyLabel => 'Wöchentlich';

  @override
  String weeksCount(int count) {
    return '$count Wochen';
  }

  @override
  String get yearLabel => 'JAHR';

  @override
  String get profileTitle => 'Du';

  @override
  String get signedIn => 'Angemeldet';

  @override
  String get sectionAccount => 'KONTO';

  @override
  String get sectionPreferences => 'EINSTELLUNGEN';

  @override
  String get sectionData => 'DATEN';

  @override
  String get sectionSupport => 'SUPPORT';

  @override
  String get sectionLegal => 'RECHTLICHES';

  @override
  String get sectionAbout => 'ÜBER DIE APP';

  @override
  String get nameLabel => 'Name';

  @override
  String get accountLabel => 'Konto';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get removeAccountData => 'Konto und Daten entfernen';

  @override
  String get metricLabel => 'Metrisch';

  @override
  String get imperialLabel => 'Imperial';

  @override
  String get notificationsLabel => 'Mitteilungen';

  @override
  String get onLabel => 'Ein';

  @override
  String get offLabel => 'Aus';

  @override
  String get myCompoundsProfile => 'Meine Wirkstoffe';

  @override
  String get savedVialPresets => 'Gespeicherte Fläschchenvorlagen';

  @override
  String get exportData => 'Daten exportieren';

  @override
  String get copyAsJson => 'Als JSON kopieren';

  @override
  String get clearAllData => 'Alle Daten löschen';

  @override
  String get clearingLabel => 'Wird gelöscht…';

  @override
  String get resetApp => 'App zurücksetzen';

  @override
  String get contactSupport => 'Support kontaktieren';

  @override
  String get chatWithUs => 'Mit uns chatten';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get medicalDisclaimer => 'Medizinischer Hinweis';

  @override
  String get disclaimerTitle => 'Haftungsausschluss';

  @override
  String get versionLabel => 'Version';

  @override
  String get signOutAction => 'ABMELDEN';

  @override
  String get educationalTrackingDisclaimer =>
      'Nur zur Aufzeichnung und Information. Keine medizinische Beratung.';

  @override
  String get yourName => 'Dein Name';

  @override
  String get cancelLabel => 'Abbrechen';

  @override
  String get saveLabel => 'Speichern';

  @override
  String get dataCopied => 'Daten in die Zwischenablage kopiert.';

  @override
  String get clearDataTitle => 'Alle Daten löschen?';

  @override
  String get clearDataBody =>
      'Dadurch werden alle Protokolle, Dosisprotokolle und Körperwerte gelöscht und das Onboarding neu gestartet. Dein Konto, dein Abo und die Peptidbibliothek bleiben erhalten. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get clearLabel => 'Löschen';

  @override
  String get clearingDataTitle => 'Daten werden gelöscht…';

  @override
  String get clearingDataBody =>
      'Lass PepMod geöffnet, während deine Aufzeichnungsdaten entfernt werden.';

  @override
  String get clearDataFailed =>
      'Daten konnten nicht gelöscht werden. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get allDataCleared => 'Alle Daten wurden gelöscht.';

  @override
  String get deleteAccountTitle => 'Konto löschen?';

  @override
  String get deleteAccountBody =>
      'Dadurch werden dein PepMod-Konto, deine Einstellungen, Protokolle, Dosisprotokolle und Körperwerte dauerhaft gelöscht. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get deletingAccount => 'Konto wird gelöscht…';

  @override
  String get accountDeletionFailed =>
      'Das Konto konnte nicht gelöscht werden. Bitte versuche es erneut.';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get deleteLabel => 'Löschen';

  @override
  String get signOutTitle => 'Abmelden?';

  @override
  String get signOutBody =>
      'Deine Protokolle bleiben gespeichert und werden bei der nächsten Anmeldung synchronisiert.';

  @override
  String get signOutLabel => 'Abmelden';

  @override
  String get signOutFailed =>
      'Abmeldung fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get notificationsDisabledSystem =>
      'Mitteilungen sind in den Systemeinstellungen deaktiviert.';

  @override
  String get planPro => 'PRO';

  @override
  String get planFree => 'KOSTENLOS';

  @override
  String get termsBody =>
      'PepMod ist ausschließlich für Bildungs- und Aufzeichnungszwecke bestimmt. Es ist kein Medizinprodukt und bietet keine medizinische Beratung, Diagnose, Verschreibung oder Behandlungsempfehlung. Bei der Nutzung von PepMod bist du für deine eigenen Aufzeichnungen, Entscheidungen und die Rücksprache mit qualifiziertem medizinischem Fachpersonal selbst verantwortlich.\n\nAbos verlängern sich automatisch, sofern sie nicht vor dem Verlängerungszeitraum im App Store oder bei Google Play gekündigt werden. Erstattungen werden über den Store abgewickelt, in dem du gekauft hast.\n\nVollständige Bedingungen: https://appstorecopilot.com/legal/yzh32x5v/terms';

  @override
  String get privacyBody =>
      'PepMod nutzt Firebase für Anmeldung und Cloud-Datenspeicherung, RevenueCat für Abos, AppRefer und Meta/Facebook App Events für Attribution sowie Firebase/Crashlytics für Analysen und Diagnosen. Wir verkaufen deine personenbezogenen Daten nicht. Du kannst dein Konto und gespeicherte App-Daten in der App löschen.\n\nVollständige Datenschutzerklärung: https://appstorecopilot.com/legal/yzh32x5v/privacy';

  @override
  String get medicalDisclaimerBody =>
      'PepMod ist ein Wellness- und Aufzeichnungswerkzeug — KEIN Medizinprodukt. Nichts in dieser App stellt eine medizinische Beratung, Diagnose, Verschreibung oder Behandlungsempfehlung dar. Die Peptide in der Bibliothek dienen ausschließlich zu Informationszwecken. Sprich vor Beginn, Änderung oder Beendigung eines Programms immer mit qualifiziertem medizinischem Fachpersonal. Suche bei unerwünschten Wirkungen sofort medizinische Hilfe.';

  @override
  String get profileSystemLabel => 'SYS.USER // PROFIL';

  @override
  String get legalSystemLabel => 'SYS.RECHTLICHES';

  @override
  String get progressTitle => 'Fortschritt';

  @override
  String get progressSystemLabel => 'SYS.FORTSCHRITT // BIOMETRIE';

  @override
  String get doseHistoryTooltip => 'Dosisverlauf öffnen';

  @override
  String get logMeasurementTooltip => 'Messwert erfassen';

  @override
  String get thirtyDayLabel => '30 TAGE';

  @override
  String get adherenceLabel => 'Regelmäßigkeit';

  @override
  String get streakLabel => 'SERIE';

  @override
  String get daysLabel => 'Tage';

  @override
  String get totalLabel => 'GESAMT';

  @override
  String get dosesLabel => 'Dosen';

  @override
  String get protocolHistoryLabel => 'PROTOKOLL.VERLAUF';

  @override
  String get noProtocolsYet =>
      'Noch keine Protokolle. Erstelle eines im Tab „Protokoll“.';

  @override
  String get adherenceChartLabel => 'ADHÄRENZ // 30 TAGE';

  @override
  String get thirtyDaysAgo => 'vor 30 Tagen';

  @override
  String get todayLabel => 'heute';

  @override
  String get noWeightData => 'Keine Gewichtsdaten';

  @override
  String get logFirstMeasurement =>
      'Erfasse deinen ersten Messwert, um hier Trends zu sehen.';

  @override
  String get logMeasurementAction => 'ERFASSEN';

  @override
  String get weightTrendLabel => 'GEWICHT // TREND';

  @override
  String weightKgValue(String weight) {
    return '$weight kg';
  }

  @override
  String get statusActive => 'AKTIV';

  @override
  String get statusPaused => 'PAUSIERT';

  @override
  String get statusEnded => 'BEENDET';

  @override
  String protocolPeptideCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Peptide',
      one: '1 Peptid',
    );
    return '$_temp0';
  }

  @override
  String get enterOneMetric => 'Gib mindestens einen Wert ein.';

  @override
  String get saveMetricFailed =>
      'Speichern fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get newMeasurement => 'Neuer Messwert';

  @override
  String get weightLabel => 'GEWICHT';

  @override
  String get bodyFatLabel => 'KÖRPERFETT';

  @override
  String get measurementsCmLabel => 'MESSWERTE (cm)';

  @override
  String get waistLabel => 'TAILLE';

  @override
  String get chestLabel => 'BRUST';

  @override
  String get armLabel => 'ARM';

  @override
  String get saveAction => 'SPEICHERN';

  @override
  String get logMetricSystemLabel => 'MESSWERT.ERFASSEN';

  @override
  String get activeLastSevenDays => 'LETZTE 7 TAGE';

  @override
  String get activeAllTime => 'GESAMT';

  @override
  String get activeAdherence => 'Regelmäßigkeit';

  @override
  String get activeStarted => 'GESTARTET';

  @override
  String get activeEnded => 'BEENDET';

  @override
  String activeStackCount(int count) {
    return 'STACK ($count)';
  }

  @override
  String get activeEditProtocol => 'PROTOKOLL BEARBEITEN';

  @override
  String get activePauseProtocol => 'PAUSIEREN';

  @override
  String get activeEndProtocol => 'BEENDEN';

  @override
  String get activeResumeProtocol => 'FORTSETZEN';

  @override
  String get activeDeleteProtocol => 'PROTOKOLL LÖSCHEN';

  @override
  String get activeTrackingDisclaimer =>
      'Nur zur Dokumentation. Sprich vor Änderungen mit qualifiziertem medizinischem Fachpersonal.';

  @override
  String get activeEndQuestion => 'Protokoll beenden?';

  @override
  String get activeEndBody =>
      'Zukünftige Dosen werden entfernt. Bisherige Einträge bleiben im Verlauf. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get activeEndAction => 'BEENDEN';

  @override
  String get activeDeleteQuestion => 'Protokoll löschen?';

  @override
  String get activeDeleteBody =>
      'Dadurch werden das Protokoll und alle Dosiseinträge dauerhaft gelöscht. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get activeDeleteAction => 'LÖSCHEN';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get activeStatusActive => 'AKTIV';

  @override
  String get activeStatusPaused => 'PAUSIERT';

  @override
  String get activeStatusEnded => 'BEENDET';

  @override
  String get activeNotesLabel => 'NOTIZEN // PROTOKOLL';

  @override
  String get activeChangeReminders => 'ÄNDERUNGSERINNERUNGEN';

  @override
  String get activeChangeRemindersBody =>
      'Wenn Mitteilungen aktiv sind, plant PepMod für jeden bevorstehenden Phasenwechsel einen lokalen Hinweis um 09:00 Uhr.';

  @override
  String activePhaseAnchor(String date) {
    return 'Wochenbereiche beginnen ab $date.';
  }

  @override
  String activeWeek(int week) {
    return 'WOCHE $week';
  }

  @override
  String activeWeeks(int start, int end) {
    return 'WOCHEN $start–$end';
  }

  @override
  String get activePerDayAmounts => 'Mengen pro Tag';

  @override
  String get activeBaseAmount => 'Basismenge';

  @override
  String get activeCurrent => 'AKTUELL';

  @override
  String get activeBaseSchedule => 'Basisplan';

  @override
  String get activeCustomDays => 'Eigene Tage';

  @override
  String get activeContinuousTracking => 'Fortlaufende Erfassung';

  @override
  String get activeNoFixedCycle => 'Kein festes Zyklusfenster';

  @override
  String activeCycleProgress(int week, int total) {
    return 'Woche $week von $total';
  }

  @override
  String activeCycleEnds(String date) {
    return 'Zyklus endet am $date';
  }

  @override
  String activeRestProgress(int week, int total) {
    return 'Pausenwoche $week von $total';
  }

  @override
  String activeRestEnds(String date) {
    return 'Pausenzeit endet am $date';
  }

  @override
  String get activeCycleComplete => 'Zyklus abgeschlossen';

  @override
  String activeCompletedDate(String date) {
    return 'Abgeschlossen am $date';
  }

  @override
  String activeRestEnded(String date) {
    return 'Pausenzeit endete am $date';
  }

  @override
  String get activeNoHistory =>
      'Noch keine pausierten oder beendeten Protokolle.';

  @override
  String activeCompoundsCount(int count) {
    return '$count Wirkstoffe';
  }

  @override
  String activeSyringeUnits(String amount) {
    return '$amount Spritzeneinheiten';
  }

  @override
  String activeCycleWeeks(int count) {
    return '$count Wo. Zyklus';
  }

  @override
  String activeRestWeeks(int count) {
    return '$count Wo. Pause';
  }

  @override
  String get activePerDraw => 'PRO ENTNAHME';

  @override
  String activeVialSummary(String volume) {
    return '$volume mL Flakon · U-100';
  }

  @override
  String get addCompound => 'WIRKSTOFF HINZUFÜGEN';

  @override
  String get addPhase => 'PHASE HINZUFÜGEN';

  @override
  String get addTime => 'Zeit hinzufügen';

  @override
  String get addToStack => 'ZUM STACK HINZUFÜGEN';

  @override
  String get amountRequired => 'Menge erforderlich';

  @override
  String get baseAmount => 'Basismenge';

  @override
  String get baseSchedule => 'Basiszeitplan';

  @override
  String get blendConfigBody =>
      'Gib genau ein, was auf dem Vial steht. PepMod rechnet die Entnahme in eine Momentaufnahme je Verbindung um.';

  @override
  String get blendIncompleteError =>
      'Vervollständige mindestens zwei Verbindungen, das Verdünnungsvolumen und die Entnahme.';

  @override
  String get blendNameHint => 'z. B. Regenerations-Blend';

  @override
  String get blendNameLabel => 'BLEND-NAME';

  @override
  String get blendSafetyDisclaimer =>
      'Nur Einheitenumrechnung. PepMod empfiehlt keinen Blend, keine Dosis, Häufigkeit oder Rekonstitutionsmethode.';

  @override
  String get changeNoteHint => 'Dein eigener Kontext für diese Phase';

  @override
  String get changeNoteOptional => 'ÄNDERUNGSNOTIZ OPTIONAL';

  @override
  String colorOption(String hex) {
    return 'Farboption $hex';
  }

  @override
  String compoundNumber(int number) {
    return 'VERBINDUNG $number';
  }

  @override
  String compoundsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Verbindungen',
      one: '1 Verbindung',
    );
    return '$_temp0';
  }

  @override
  String copiedVialPreset(String amount, String unit) {
    return '$amount $unit Vial-Voreinstellung · in dieses Protokoll kopiert';
  }

  @override
  String get createProtocolAction => 'PROTOKOLL ERSTELLEN';

  @override
  String get createProtocolAddOneError => 'Füge mindestens ein Peptid hinzu.';

  @override
  String createProtocolBuildStep(int step, int total) {
    return 'Protokoll erstellen · Schritt $step / $total';
  }

  @override
  String get createProtocolDefaultName => 'Mein Protokoll';

  @override
  String createProtocolEditStep(int step, int total) {
    return 'Protokoll bearbeiten · Schritt $step / $total';
  }

  @override
  String get createProtocolFreeLimitReason =>
      'Im kostenlosen Tarif ist nur ein Peptid pro Protokoll möglich. Führe ein Upgrade durch, um mehrere Verbindungen zu kombinieren.';

  @override
  String get createProtocolNameBody =>
      'Gib ihm einen einprägsamen Namen — z. B. „Regenerations-Stack“ oder „Q2-Definition“.';

  @override
  String get createProtocolNameTitle => 'Benenne dein Protokoll';

  @override
  String get createProtocolNoPeptides => 'Noch keine Peptide';

  @override
  String get createProtocolPickHint =>
      'Tippe auf +, um aus der Bibliothek auszuwählen';

  @override
  String get createProtocolReviewBody =>
      'Prüfe die Protokolldetails. Du kannst sie jederzeit in der Verwaltungsansicht bearbeiten.';

  @override
  String get createProtocolSaveError =>
      'Protokoll konnte nicht gespeichert werden. Versuche es erneut.';

  @override
  String get createProtocolStackBody =>
      'Füge ein Peptid hinzu oder kombiniere mehrere Verbindungen. Konfiguriere Bezeichnung, Dosis, Häufigkeit und Zyklus.';

  @override
  String get createProtocolStackTitle => 'Erstelle deinen Stack';

  @override
  String get customBlend => 'Eigener Blend';

  @override
  String get customDays => 'Eigene Tage';

  @override
  String get customDaysDisclaimer =>
      'Nur ausgewählte Wochentage werden geplant. Mengen sind vom Nutzer eingegebene Tracking-Werte und keine Dosierempfehlung.';

  @override
  String get customPeptide => 'Eigenes Peptid';

  @override
  String get cycleWeeksLabel => 'ZYKLUSWOCHEN';

  @override
  String get cycleWindowDisclaimer =>
      'Zyklus- und Pausenfenster ordnen den Tracking-Verlauf. PepMod plant nach Ende des Zyklusfensters keine weiteren Dosen.';

  @override
  String get defaultAmountLabel => 'STANDARDMENGE';

  @override
  String get diluentVolumeLabel => 'VERDÜNNUNGSVOLUMEN';

  @override
  String get drawExceedsVialError =>
      'Die Entnahme darf das Vial-Volumen nicht überschreiten.';

  @override
  String get drawLabel => 'ENTNAHME';

  @override
  String get drawPreviewLabel => 'ENTNAHMEVORSCHAU';

  @override
  String drawPreviewValue(String units, String volume) {
    return '$units Einheiten = $volume ml';
  }

  @override
  String editTime(String time) {
    return 'Zeit $time bearbeiten';
  }

  @override
  String get endWeekLabel => 'ENDWOCHE';

  @override
  String get enterPeptideName => 'Peptidnamen eingeben';

  @override
  String get frequencyLabel => 'HÄUFIGKEIT';

  @override
  String get labelColorBody =>
      'Ordne diese Farbe dem Stift- oder Vial-Etikett zu, das du tatsächlich verwendest.';

  @override
  String get labelColorLabel => 'ETIKETTFARBE';

  @override
  String get manageSavedCompounds => 'Gespeicherte Verbindungen verwalten';

  @override
  String get nextLabel => 'WEITER';

  @override
  String get noneLabel => 'Keine';

  @override
  String get oneOffCompound => 'Einmalige Verbindung';

  @override
  String get oneOffCompoundBody =>
      'Einmal verwenden, ohne eine Voreinstellung zu speichern';

  @override
  String get optionalLabel => 'Optional';

  @override
  String peptidesCount(int count) {
    return 'PEPTIDE ($count)';
  }

  @override
  String get perDayAmounts => 'Mengen je Tag';

  @override
  String phaseExtendsWarning(int weeks) {
    return 'Eine Phase reicht über den $weeks-wöchigen Zyklus hinaus. Passe die Phase oder das Zyklusfenster an.';
  }

  @override
  String get phaseNameHint => 'z. B. Tracking Woche 1';

  @override
  String get phaseNameLabel => 'PHASENNAME';

  @override
  String phaseNumber(int number) {
    return 'Phase $number';
  }

  @override
  String phaseOutsideCycleError(int weeks) {
    return 'Dieser Protokollzyklus endet nach Woche $weeks. Die Phasenwochen müssen innerhalb dieses Fensters liegen.';
  }

  @override
  String get phaseOverlapError =>
      'Wochenbereiche von Phasen dürfen sich nicht überschneiden.';

  @override
  String get phaseOverrideBody =>
      'Gib nur den Tracking-Zeitplan ein, den du bereits befolgen möchtest. PepMod empfiehlt keine Mengen.';

  @override
  String get phaseOverrideTitle => 'Wochenweise Anpassung';

  @override
  String get phasePreviewDisclaimer =>
      'Nur eine Vorschau deiner Eingaben. PepMod empfiehlt keinen Zeitplan.';

  @override
  String get phasePreviewLabel => 'PHASENVORSCHAU';

  @override
  String get phaseReminderBody =>
      'Wenn Protokollerinnerungen aktiviert sind, wird um 09:00 Uhr eine neutrale Erinnerung zum Phasenwechsel geplant.';

  @override
  String get phaseScheduleLabel => 'PHASENZEITPLAN';

  @override
  String get phaseSelectDayError =>
      'Wähle mindestens einen Tag. PepMod wählt keinen Zeitplan für dich.';

  @override
  String get phasesBody =>
      'Optionale Zeitfenster können Basismenge und Zeitplan überschreiben. Außerhalb davon gilt der Basiszeitplan.';

  @override
  String phasesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Phasen',
      one: '1 Phase',
    );
    return '$_temp0';
  }

  @override
  String get phasesDisclaimer =>
      'Wochen werden ab dem Startdatum des Protokolls gezählt. Gespeicherte Phasennotizen und Erinnerungen dienen nur dem Tracking.';

  @override
  String get preBlendedVial => 'Vorgemischtes Vial';

  @override
  String get preBlendedVialBody =>
      'Ein Vial · eine Entnahme · mehrere Verbindungen';

  @override
  String get protocolNotesBody =>
      'Speichere Kontext, der bei der Prüfung dieses Protokolls sichtbar sein soll.';

  @override
  String get protocolNotesHint =>
      'z. B. Fragen, Tracking-Kontext oder ärztliche Notizen';

  @override
  String get protocolNotesLabel => 'Protokollnotizen';

  @override
  String get reminderTimesBody =>
      'Jede ausgewählte Zeit erstellt an geplanten Tagen eine eigene Tracking-Zeile und Erinnerung.';

  @override
  String get reminderTimesLabel => 'ERINNERUNGSZEITEN';

  @override
  String get removeLabel => 'ENTFERNEN';

  @override
  String removePeptide(String name) {
    return '$name entfernen';
  }

  @override
  String get removePhase => 'Phase entfernen';

  @override
  String removeTime(String time) {
    return 'Zeit $time entfernen';
  }

  @override
  String get restWeeksLabel => 'PAUSENWOCHEN';

  @override
  String get reviewLabel => 'Prüfen';

  @override
  String get routeLabel => 'ANWENDUNGSART';

  @override
  String get saveBlend => 'BLEND SPEICHERN';

  @override
  String get saveChanges => 'ÄNDERUNGEN SPEICHERN';

  @override
  String get savePhase => 'PHASE SPEICHERN';

  @override
  String savedVialPreset(String amount, String unit) {
    return '$amount $unit Vial · Gespeicherte Voreinstellung';
  }

  @override
  String get scheduleLabel => 'ZEITPLAN';

  @override
  String get searchCompounds => 'Verbindungen suchen...';

  @override
  String get selectDayError =>
      'Wähle mindestens einen Tag für dieses Peptid aus.';

  @override
  String selectOption(String option) {
    return '$option auswählen';
  }

  @override
  String get startDateLabel => 'STARTDATUM';

  @override
  String get startWeekLabel => 'STARTWOCHE';

  @override
  String syringeUnitsAmount(String amount) {
    return '$amount Spritzeneinheiten';
  }

  @override
  String get syringeUnitsDisclaimer =>
      'Optionale, vom Nutzer eingegebene U-100-Spritzenmarkierungen nur fürs Tracking.';

  @override
  String get syringeUnitsHint => 'z. B. 12,5';

  @override
  String get syringeUnitsLabel => 'Spritzeneinheiten';

  @override
  String get syringeUnitsOptional => 'SPRITZENEINHEITEN OPTIONAL';

  @override
  String get trackedAmountLabel => 'ERFASSTE MENGE';

  @override
  String get u100TrackingDisclaimer =>
      'Verwendet U-100-Spritzenmarkierungen (100 Einheiten = 1 ml). Die Werte sind vom Nutzer eingegebene Tracking-Daten.';

  @override
  String get unitLabel => 'EINHEIT';

  @override
  String get vialAmountHint => 'Vial-Menge';

  @override
  String get vialContentsLabel => 'VIAL-INHALT';

  @override
  String get vialLabelNameHint => 'Name vom Vial-Etikett';

  @override
  String weekNumber(int week) {
    return 'WOCHE $week';
  }

  @override
  String weekRange(int start, int end) {
    return 'WOCHEN $start–$end';
  }

  @override
  String get weekToWeekPhases => 'WOCHENWEISE PHASEN';

  @override
  String weekdayDose(String weekday) {
    return 'DOSIS $weekday';
  }

  @override
  String weekdaySchedule(String weekday) {
    return 'ZEITPLAN $weekday';
  }

  @override
  String get doseDrawInvalid =>
      'Die Entnahmemenge muss größer als null sein und im Flakon verfügbar sein.';

  @override
  String get doseGenericError =>
      'Etwas ist schiefgelaufen. Versuche es erneut.';

  @override
  String get doseEditSystemLabel => 'DOSIS.BEARBEITEN';

  @override
  String get doseLogSystemLabel => 'DOSIS.PROTOKOLLIEREN';

  @override
  String get doseDraw => 'ENTNAHME';

  @override
  String get doseAmount => 'MENGE';

  @override
  String get doseUnits => 'Einheiten';

  @override
  String get doseTime => 'UHRZEIT';

  @override
  String get doseChooseTime => 'Uhrzeit der Dosis auswählen';

  @override
  String get doseBlendSnapshot => 'MISCHUNGSÜBERSICHT // PRO ENTNAHME';

  @override
  String doseSyringeUnitsRecorded(String amount) {
    return 'Für diese Dosis wurden $amount Spritzeneinheiten erfasst.';
  }

  @override
  String get doseInjectionSite => 'INJEKTIONSSTELLE';

  @override
  String doseLastSite(String site) {
    return 'LETZTE STELLE FÜR DIESES PEPTID · $site';
  }

  @override
  String get doseNotes => 'NOTIZEN';

  @override
  String get doseOptional => 'Optional...';

  @override
  String get doseMarkPending => 'AUSSTEHEND';

  @override
  String get doseSaveChanges => 'SPEICHERN';

  @override
  String get doseSkip => 'Diese Dosis überspringen';

  @override
  String get doseHistorySystemLabel => 'DOSISVERLAUF // 30 TAGE';

  @override
  String get doseHistoryTitle => 'Protokollierte Dosen';

  @override
  String get doseHistoryBody =>
      'Tippe auf einen Eintrag, um Menge, tatsächliche Uhrzeit, Injektionsstelle, Notizen oder Status zu korrigieren.';

  @override
  String get doseHistoryEmpty =>
      'In den letzten 30 Tagen wurden keine Dosen protokolliert.';

  @override
  String get doseLogPrevious => 'FRÜHERE DOSIS';

  @override
  String doseHistorySkipped(String dateTime) {
    return 'Übersprungen · $dateTime';
  }

  @override
  String doseHistoryTaken(String amount, String units, String dateTime) {
    return '$amount $units · $dateTime';
  }

  @override
  String get doseEditAction => 'BEARBEITEN';

  @override
  String get doseChoosePastTime => 'Wähle eine Uhrzeit in der Vergangenheit.';

  @override
  String get dosePreviousError =>
      'Die frühere Dosis konnte nicht protokolliert werden. Versuche es erneut.';

  @override
  String get doseLogPreviousSystemLabel => 'FRÜHERE.DOSIS';

  @override
  String get doseNoPeptides => 'Keine Peptide verfügbar';

  @override
  String get doseNoPeptidesBody =>
      'Füge einem aktiven Protokoll ein Peptid hinzu, bevor du einen früheren Eintrag erstellst.';

  @override
  String get doseCorrectHistory => 'Dosisverlauf korrigieren';

  @override
  String get dosePeptide => 'PEPTID';

  @override
  String get doseDate => 'DATUM';

  @override
  String get doseChooseDate => 'Datum der Dosis auswählen';

  @override
  String doseSyringeUnitsEntry(String amount) {
    return 'Für diesen Eintrag wurden $amount Spritzeneinheiten erfasst.';
  }

  @override
  String get doseHistoryDisclaimer =>
      'Frühere Einträge dienen nur der persönlichen Dokumentation. Sie ändern weder medizinische Hinweise noch Dosierungsempfehlungen.';

  @override
  String get notificationChannelName => 'Dosiserinnerungen';

  @override
  String get notificationChannelDescription =>
      'Geplante Erinnerungen für Dosen in deinen aktiven Peptidprotokollen.';

  @override
  String get notificationDoseTitle => 'Zeit für deine Dosis';

  @override
  String get notificationDoseBody =>
      'Deine geplante Protokollerinnerung ist bereit.';

  @override
  String get notificationCycleTitle => 'Protokoll-Checkpoint';

  @override
  String get notificationCycleBody =>
      'Heute ist eine Erinnerung zum Zyklusfenster fällig. Prüfe deinen Tracking-Plan.';

  @override
  String get notificationRestTitle => 'Pausen-Checkpoint';

  @override
  String get notificationRestBody =>
      'Heute ist eine Erinnerung zur Pausenphase fällig. Prüfe deinen Tracking-Plan.';

  @override
  String get notificationPhaseTitle => 'Phasen-Checkpoint';

  @override
  String get notificationPhaseBody =>
      'Heute beginnt eine neue Tracking-Phase. Prüfe deinen gespeicherten Zeitplan.';

  @override
  String get personalLibrarySystemLabel => 'SYS.BIBLIOTHEK // PERSÖNLICH';

  @override
  String get customCompoundIntro =>
      'Speichere selbst eingegebene Bezeichnungen und Fläschchengrößen. Vorlagen erleichtern nur die Aufzeichnung und sind keine Dosierungsempfehlung.';

  @override
  String get archivedHeading => 'ARCHIVIERT';

  @override
  String get activePresetsHeading => 'AKTIVE VORLAGEN';

  @override
  String get showActive => 'Aktive anzeigen';

  @override
  String get archivedAction => 'Archiviert';

  @override
  String get customCompoundsLoadFailed =>
      'Deine Wirkstoffe konnten nicht geladen werden. Versuche es erneut.';

  @override
  String get libraryLoadFailed =>
      'Die Peptidbibliothek konnte nicht geladen werden. Versuche es erneut.';

  @override
  String compoundVialSummary(String amount, String unit, String route) {
    return '$amount $unit Fläschchen · $route';
  }

  @override
  String get editPreset => 'Vorlage bearbeiten';

  @override
  String get restorePreset => 'Wiederherstellen';

  @override
  String get archivePreset => 'Archivieren';

  @override
  String get noArchivedPresets => 'Keine archivierten Vorlagen';

  @override
  String get noSavedCompounds => 'Keine gespeicherten Wirkstoffe';

  @override
  String get archivedPresetsHint =>
      'Archivierte Vorlagen bleiben hier, bis du sie wiederherstellst.';

  @override
  String get createPresetHint =>
      'Erstelle eine wiederverwendbare Vorlage mit Bezeichnung und Fläschchengröße.';

  @override
  String get presetCompoundSystemLabel => 'VORLAGE.WIRKSTOFF';

  @override
  String get newCompound => 'Neuer Wirkstoff';

  @override
  String get editCompound => 'Wirkstoff bearbeiten';

  @override
  String get ownVialDetailsHint =>
      'Gib nur die Angaben ein, die auf deinem eigenen Fläschchen stehen.';

  @override
  String get compoundLabel => 'WIRKSTOFFBEZEICHNUNG';

  @override
  String get compoundNameExample => 'z. B. Mein Wirkstoff';

  @override
  String get vialUnitLabel => 'FLÄSCHCHENEINHEIT';

  @override
  String get trackingUnitLabel => 'AUFZEICHNUNGSEINHEIT';

  @override
  String get notesOptional => 'HINWEISE OPTIONAL';

  @override
  String get compoundNoteExample => 'Etikett- oder Lagerungshinweis';

  @override
  String get noDoseRecommendation =>
      'Es wird keine Dosierungsempfehlung erstellt. Mengen für Protokolle gibst du immer separat ein.';

  @override
  String get saveCompoundFailed =>
      'Die Vorlage konnte nicht gespeichert werden. Versuche es erneut.';

  @override
  String get routeTopical => 'Topisch';

  @override
  String get frequencyCustomDays => 'Benutzerdefinierte Tage';

  @override
  String savedCalculationLabel(
    String vialAmount,
    String vialUnit,
    String diluentVolume,
  ) {
    return '$vialAmount $vialUnit + $diluentVolume ml';
  }

  @override
  String savedCalculationDetail(
    String desiredAmount,
    String desiredUnit,
    String capacity,
  ) {
    return '$desiredAmount $desiredUnit · $capacity E';
  }

  @override
  String syringeOption(String volume, String capacity) {
    return 'U-100 · $volume ml / $capacity Einheiten';
  }

  @override
  String get peptideContentHcgDescription =>
      'Humanes Choriongonadotropin (HCG) ist ein Glykoproteinhormon, das in regulierten klinischen Umgebungen eingesetzt wird und häufig im Zusammenhang mit Peptidprotokollen erwähnt wird. Dieser Eintrag dient als neutrale Tracking-Referenz für selbst eingegebene Zeitpläne.';

  @override
  String get peptideContentHcgTypicalDose => 'Vom Nutzer eingegebene IE';

  @override
  String get peptideContentHcgHalfLife => '~24-36 Stunden';

  @override
  String get peptideContentHcgNotes =>
      'In vielen Rechtsordnungen verschreibungspflichtig. Erfasse nur, was bereits von qualifiziertem medizinischem Fachpersonal angeordnet wurde; PepMod gibt keine Dosierungsempfehlungen für HCG.';

  @override
  String get peptideContentBpc157Description =>
      'BPC-157 (Body Protection Compound 157) ist ein synthetisches Peptid aus 15 Aminosäuren, das von einem Protein im Magensaft abgeleitet ist. In Tiermodellen wurde seine Rolle bei der Regeneration von Weichgewebe und Darmschleimhaut untersucht. Klinische Daten beim Menschen sind weiterhin begrenzt.';

  @override
  String get peptideContentBpc157TypicalDose => '250–500 mcg';

  @override
  String get peptideContentBpc157HalfLife => '~4 Stunden';

  @override
  String get peptideContentBpc157Notes =>
      'In Tierstudien wird BPC-157 häufig gemeinsam mit TB-500 in Forschungsprotokollen zu Sehnen und Bändern erwähnt. Diese Referenz stellt keine Anweisung zur Rekonstitution oder Anwendung dar.';

  @override
  String get peptideContentTb500Description =>
      'TB-500 ist ein synthetisches Fragment des natürlich vorkommenden Proteins Thymosin Beta-4. In Tierstudien wurde seine Rolle bei Zellmigration und Geweberegeneration untersucht. Es wird von Forschenden und im veterinärmedizinischen Bereich häufig off-label verwendet.';

  @override
  String get peptideContentTb500TypicalDose =>
      '2–5 mg wöchentliche Aufsättigung, danach 2 mg Erhaltungsdosis';

  @override
  String get peptideContentTb500HalfLife => '~2 Tage';

  @override
  String get peptideContentTb500Notes =>
      'Wird oft mit BPC-157 in Weichteilprotokollen kombiniert. Aufgeteilte Dosierung zweimal wöchentlich ist aufgrund der langen Halbwertszeit üblich.';

  @override
  String get peptideContentGhkCuDescription =>
      'GHK-Cu (Kupferpeptid) ist ein natürlich vorkommendes kupferbindendes Tripeptid, das im menschlichen Plasma vorhanden ist. Es wurde in topischen kosmetischen Anwendungen zur Hauterneuerung und Haarfollikel-Signalgebung untersucht.';

  @override
  String get peptideContentGhkCuTypicalDose => '1–2 mg';

  @override
  String get peptideContentGhkCuHalfLife => '~1 Stunde';

  @override
  String get peptideContentGhkCuNotes =>
      'Wird auch topisch in Hautpflegeformulierungen eingesetzt. Die subkutane Dosierung liegt typischerweise unter den topischen Konzentrationen.';

  @override
  String get peptideContentEpitalonDescription =>
      'Epitalon ist ein synthetisches Tetrapeptid-Analogon von Epithalamin, einem Peptid, das aus der Zirbeldrüse gewonnen wird. Russische Forschung hat seine Wirkung auf die Telomerase-Aktivität und die zirkadiane Regulation untersucht.';

  @override
  String get peptideContentEpitalonTypicalDose => '5–10 mg pro Zyklustag';

  @override
  String get peptideContentEpitalonHalfLife => '~30 Minuten';

  @override
  String get peptideContentEpitalonNotes =>
      'Wird typischerweise in kurzen, gepulsten Zyklen angewendet (z. B. 10–20 Tage Einnahme, Monate Pause), basierend auf russischen Langlebigkeitsforschungsprotokollen.';

  @override
  String get peptideContentSemaglutideDescription =>
      'Semaglutid ist ein GLP-1-Rezeptoragonist, der ursprünglich für Typ-2-Diabetes entwickelt und später unter den Markennamen Ozempic und Wegovy für das chronische Gewichtsmanagement zugelassen wurde. Es verlangsamt die Magenentleerung und moduliert die Appetitsignalgebung.';

  @override
  String get peptideContentSemaglutideTypicalDose =>
      '0.25–2.4 mg wöchentlich (titriert)';

  @override
  String get peptideContentSemaglutideHalfLife => '~7 Tage';

  @override
  String get peptideContentSemaglutideNotes =>
      'In den meisten Ländern verschreibungspflichtig. Der Titrationsplan beginnt niedrig und wird alle 4 Wochen erhöht, um gastrointestinale Nebenwirkungen zu kontrollieren.';

  @override
  String get peptideContentTirzepatideDescription =>
      'Tirzepatid ist ein dualer GIP/GLP-1-Rezeptoragonist, der für Typ-2-Diabetes (Mounjaro) und Adipositas (Zepbound) zugelassen ist. Klinische Studien haben gezeigt, dass es im Vergleich zu Einzelagonisten-GLP-1-Präparaten stärkere Gewichtsreduktionen bewirkt.';

  @override
  String get peptideContentTirzepatideTypicalDose =>
      '2.5–15 mg wöchentlich (titriert)';

  @override
  String get peptideContentTirzepatideHalfLife => '~5 Tage';

  @override
  String get peptideContentTirzepatideNotes =>
      'In den meisten Ländern verschreibungspflichtig. Die Standardtitration erfolgt in 4-Wochen-Schritten. Wird einmal wöchentlich subkutan injiziert.';

  @override
  String get peptideContentRetatrutideDescription =>
      'Retatrutid ist ein experimenteller Dreifachagonist, der auf GIP-, GLP-1- und Glukagonrezeptoren wirkt. Phase-2-Studien berichteten von Gewichtsreduktionen, die über denen bestehender GLP-1-basierter Therapien lagen.';

  @override
  String get peptideContentRetatrutideTypicalDose =>
      'Studiendosen 1–12 mg wöchentlich';

  @override
  String get peptideContentRetatrutideHalfLife => '~6 Tage';

  @override
  String get peptideContentRetatrutideNotes =>
      'Noch in der Erprobung — zum Zeitpunkt der Erstellung nicht von der FDA zugelassen. Jede Anwendung außerhalb einer klinischen Studie ist ausschließlich Forschungszwecken vorbehalten.';

  @override
  String get peptideContentIpamorelinDescription =>
      'Ipamorelin ist ein Pentapeptid-Ghrelin-Mimetikum und selektives Wachstumshormon-Sekretagogum. Es wurde auf seine Fähigkeit untersucht, eine pulsatile GH-Ausschüttung mit minimaler Wirkung auf Cortisol oder Prolaktin auszulösen.';

  @override
  String get peptideContentIpamorelinTypicalDose => '200–300 mcg pro Injektion';

  @override
  String get peptideContentIpamorelinHalfLife => '~2 Stunden';

  @override
  String get peptideContentIpamorelinNotes =>
      'Wird häufig mit CJC-1295 (ohne DAC) kombiniert, um einen synergistischen GH-Puls zu erzielen. Typisches Timing: vor dem Schlafengehen und/oder vor dem Training auf nüchternen Magen.';

  @override
  String get peptideContentCjc1295DacDescription =>
      'CJC-1295 ist ein synthetisches GHRH-Analogon. Die DAC-Variante (Drug Affinity Complex) bindet an Serumalbumin, verlängert dadurch die Halbwertszeit und erzeugt anhaltende GH-Spiegel anstelle einzelner Ausschüttungsspitzen.';

  @override
  String get peptideContentCjc1295DacTypicalDose => '1–2 mg wöchentlich';

  @override
  String get peptideContentCjc1295DacHalfLife => '~8 Tage';

  @override
  String get peptideContentCjc1295DacNotes =>
      'Langwirksam — wird typischerweise ein- bis zweimal pro Woche dosiert. Erhöht den GH/IGF-1-Grundspiegel, statt scharfe Pulse zu erzeugen.';

  @override
  String get peptideContentCjc1295NoDacDescription =>
      'CJC-1295 ohne DAC — auch bekannt als Mod-GRF(1-29) — ist ein GHRH-Analogon mit kurzer Halbwertszeit. Es wird typischerweise mit einem GHRP wie Ipamorelin kombiniert, um eine natürliche pulsatile GH-Ausschüttung auszulösen.';

  @override
  String get peptideContentCjc1295NoDacTypicalDose => '100 mcg pro Injektion';

  @override
  String get peptideContentCjc1295NoDacHalfLife => '~30 Minuten';

  @override
  String get peptideContentCjc1295NoDacNotes =>
      'Kurzwirksam — wird mit einem GHRP (Ipamorelin, GHRP-2, GHRP-6) kombiniert, um GH-Pulse zu verstärken. Wird meist 1–3× täglich auf nüchternen Magen dosiert.';

  @override
  String get peptideContentTesamorelinDescription =>
      'Tesamorelin ist ein stabilisiertes GHRH-Analogon, das zur Reduktion von überschüssigem viszeralem Bauchfett bei HIV-assoziierter Lipodystrophie zugelassen ist (Markenname Egrifta). Es wurde auch im Zusammenhang mit kognitivem Altern untersucht.';

  @override
  String get peptideContentTesamorelinTypicalDose => '1–2 mg täglich';

  @override
  String get peptideContentTesamorelinHalfLife => '~30 Minuten';

  @override
  String get peptideContentTesamorelinNotes =>
      'Verschreibungspflichtiges Arzneimittel. Wird vor allem im Hinblick auf die Reduktion viszeralen Fettgewebes untersucht. Wird einmal täglich subkutan verabreicht.';

  @override
  String get peptideContentMotsCDescription =>
      'MOTS-c ist ein mitochondrial abgeleitetes Peptid, das im MT-RNR1-Gen kodiert ist. Die Forschung hat seine Rolle bei der metabolischen Homöostase, der Insulinsensitivität und der Bewegungsphysiologie untersucht.';

  @override
  String get peptideContentMotsCTypicalDose => '5–10 mg 2–3x pro Woche';

  @override
  String get peptideContentMotsCHalfLife => '~90 Minuten';

  @override
  String get peptideContentMotsCNotes =>
      'Die Forschung befindet sich noch in einem frühen Stadium. Einige Nutzer berichten in Selbstversuchsprotokollen von verbesserter Trainingsregeneration und Stoffwechselwerten.';

  @override
  String get peptideContentCerebrolysinDescription =>
      'Cerebrolysin ist eine Mischung aus niedermolekularen Peptiden und Aminosäuren, die aus Schweinehirngewebe gewonnen wird. Es wird in mehreren europäischen und asiatischen Ländern für neurodegenerative Indikationen und die Schlaganfall-Rehabilitation verschrieben.';

  @override
  String get peptideContentCerebrolysinTypicalDose =>
      '5–30 ml Ampullen (klinischer Rahmen)';

  @override
  String get peptideContentCerebrolysinHalfLife => 'Variabel (Mischung)';

  @override
  String get peptideContentCerebrolysinNotes =>
      'Wird typischerweise als Kur unter klinischer Aufsicht verabreicht. In den USA nicht erhältlich. Forschung zu ischämischem Schlaganfall und Alzheimer-Krankheit.';

  @override
  String get peptideContentSelankDescription =>
      'Selank ist ein synthetisches Heptapeptid, das in Russland als Analogon des immunmodulatorischen Peptids Tuftsin entwickelt wurde. Es wurde auf anxiolytische Wirkungen ohne die Sedierung oder Abhängigkeit von Benzodiazepinen untersucht.';

  @override
  String get peptideContentSelankTypicalDose => '250–500 mcg intranasal';

  @override
  String get peptideContentSelankHalfLife => '~wenige Minuten (systemisch)';

  @override
  String get peptideContentSelankNotes =>
      'Wird am häufigsten intranasal verabreicht. Die russische Forschung konzentriert sich auf Angst und Aufmerksamkeit. Kurze Halbwertszeit, berichtete Wirkungen sollen jedoch mehrere Stunden anhalten.';

  @override
  String get peptideContentSemaxDescription =>
      'Semax ist ein synthetisches Heptapeptid, das von einem Fragment des ACTH (4–10) abgeleitet ist. Russische Forschung hat seine nootropischen und neuroprotektiven Wirkungen untersucht, insbesondere im Rahmen der Schlaganfall-Rehabilitation.';

  @override
  String get peptideContentSemaxTypicalDose => '250–1000 mcg intranasal';

  @override
  String get peptideContentSemaxHalfLife => '~30 Minuten';

  @override
  String get peptideContentSemaxNotes =>
      'Die intranasale Verabreichung ist üblich. In Russland für ischämischen Schlaganfall zugelassen. Wird oft zyklisch mit Selank kombiniert, um sich ergänzende Wirkungen zu erzielen.';

  @override
  String get peptideContentMelanotanIiDescription =>
      'Melanotan II ist ein synthetisches Analogon des Alpha-Melanozyten-stimulierenden Hormons (α-MSH). Es wurde ursprünglich als potenzielles Mittel zur Bräunung ohne Sonneneinstrahlung entwickelt und wurde auch mit Effekten auf Appetit und Libido in Verbindung gebracht.';

  @override
  String get peptideContentMelanotanIiTypicalDose =>
      '250–1000 mcg Aufsättigung, danach Erhaltungsdosis';

  @override
  String get peptideContentMelanotanIiHalfLife => '~1 Stunde';

  @override
  String get peptideContentMelanotanIiNotes =>
      'Für keine medizinische Anwendung zugelassen. Häufig berichtete Nebenwirkungen sind Übelkeit und Verdunkelung bestehender Muttermale. Jedes neue oder sich verändernde Muttermal sollte von einem Dermatologen untersucht werden.';

  @override
  String get peptideContentPt141Description =>
      'PT-141, auch bekannt als Bremelanotid und unter dem Namen Vyleesi vermarktet, ist ein Melanocortin-Rezeptoragonist, der von der FDA für Störungen mit verminderter sexueller Appetenz bei prämenopausalen Frauen zugelassen ist. Es wirkt auf Signalwege im zentralen Nervensystem.';

  @override
  String get peptideContentPt141TypicalDose => '1.25–1.75 mg bei Bedarf';

  @override
  String get peptideContentPt141HalfLife => '~2 Stunden';

  @override
  String get peptideContentPt141Notes =>
      'In manchen Märkten verschreibungspflichtig. Wird bei Bedarf statt nach festem Zeitplan eingenommen. Häufige Nebenwirkungen sind Übelkeit und vorübergehender Blutdruckanstieg.';

  @override
  String get peptideContentDsipDescription =>
      'Delta-Sleep-Inducing-Peptid (DSIP) ist ein Nonapeptid, das in den 1970er-Jahren aus dem Kaninchenhirn isoliert wurde. Es wurde auf mögliche Rollen bei der Schlafregulation, der Schmerzmodulation und der Stressreaktion untersucht, wobei die Wirkmechanismen weiterhin unklar sind.';

  @override
  String get peptideContentDsipTypicalDose =>
      '100–500 mcg vor dem Schlafengehen';

  @override
  String get peptideContentDsipHalfLife => '~7 Minuten';

  @override
  String get peptideContentDsipNotes =>
      'Wird typischerweise vor dem Schlafengehen verabreicht. Kurze Plasmahalbwertszeit, berichtete Wirkungen sollen jedoch länger andauern. Die Evidenzlage bleibt begrenzt.';

  @override
  String get peptideContentThymosinAlpha1Description =>
      'Thymosin Alpha-1 ist ein Peptid aus 28 Aminosäuren, das ursprünglich aus Thymusgewebe isoliert wurde. Es wurde in mehreren Ländern als ergänzende immunmodulierende Therapie (Markenname Zadaxin) für Hepatitis B und C zugelassen.';

  @override
  String get peptideContentThymosinAlpha1TypicalDose =>
      '1.6 mg zweimal wöchentlich';

  @override
  String get peptideContentThymosinAlpha1HalfLife => '~2 Stunden';

  @override
  String get peptideContentThymosinAlpha1Notes =>
      'Wird in mehreren internationalen Märkten im Rahmen von Immunmodulationsprotokollen eingesetzt. Wird typischerweise zweimal wöchentlich verabreicht. Die Forschung zu verschiedenen Indikationen wird fortgesetzt.';

  @override
  String get peptideContentNadPlusDescription =>
      'NAD+ (Nicotinamidadenindinukleotid) ist ein Coenzym, das für den zellulären Energiestoffwechsel und die DNA-Reparatur von zentraler Bedeutung ist. Injizierbares NAD+ und seine Vorstufen (NR, NMN) werden im Zusammenhang mit mitochondrialer Gesundheit und Alterung untersucht.';

  @override
  String get peptideContentNadPlusTypicalDose =>
      '100–500 mg IV oder s.c. pro Sitzung';

  @override
  String get peptideContentNadPlusHalfLife => '~90 Minuten';

  @override
  String get peptideContentNadPlusNotes =>
      'Streng genommen ein Coenzym und kein Peptid, wird aber häufig zu Langlebigkeitsprotokollen gezählt. Eine langsame Infusion wird empfohlen, um Hautrötungen und Unwohlsein zu minimieren.';

  @override
  String get peptideContentSermorelinDescription =>
      'Sermorelin ist ein synthetisches Analogon des Wachstumshormon-Releasing-Hormons (GHRH). Es wurde klinisch als diagnostisches Mittel zur Prüfung der Wachstumshormonreserve eingesetzt und wird im Wellness-Bereich häufig als unterstützendes Peptid für die GH-Achse diskutiert.';

  @override
  String get peptideContentSermorelinTypicalDose =>
      '100–300 mcg vor dem Schlafengehen';

  @override
  String get peptideContentSermorelinHalfLife => '~10–20 Minuten';

  @override
  String get peptideContentSermorelinNotes =>
      'Wird oft mit CJC-1295 ohne DAC verglichen, da beide über den GHRH-Signalweg wirken. Die kurze Halbwertszeit macht die abendliche Dosierung in nichtklinischen Protokollen üblich.';

  @override
  String get peptideContentAod9604Description =>
      'AOD-9604 ist ein modifiziertes Fragment des menschlichen Wachstumshormons, das aus dem Bereich 176–191 abgeleitet ist. Es wurde im Hinblick auf metabolische und lipolytische Signalwege untersucht, doch die veröffentlichte Evidenz beim Menschen ist begrenzt und uneinheitlich.';

  @override
  String get peptideContentAod9604TypicalDose => '250–500 mcg täglich';

  @override
  String get peptideContentAod9604HalfLife => '~30 Minuten';

  @override
  String get peptideContentAod9604Notes =>
      'In manchen Diskussionen auch als HGH-Fragment 176–191 bezeichnet. Kein zugelassenes Abnehmmedikament; verwende neutrale Trackingformulierungen und vermeide Erfolgsversprechen.';

  @override
  String get peptideContentKpvDescription =>
      'KPV ist eine kurze Tripeptidsequenz (Lysin-Prolin-Valin), die vom Alpha-Melanozyten-stimulierenden Hormon abgeleitet ist. Es wird in Forschungskontexten im Zusammenhang mit Immun- und Darmbarriere-Signalgebung diskutiert.';

  @override
  String get peptideContentKpvTypicalDose => '250–500 mcg täglich';

  @override
  String get peptideContentKpvHalfLife => 'Nicht gut erforscht';

  @override
  String get peptideContentKpvNotes =>
      'Kommt in Diskussionen zur Darmgesundheit und zu topischer Anwendung vor, auch in informellen Kombinationen mit BPC-157. Die Evidenz zur Dosierung beim Menschen ist begrenzt, weshalb Protokolle konservativ gehalten werden sollten.';

  @override
  String get peptideContentSs31Description =>
      'SS-31, auch bekannt als Elamipretid, ist ein auf Mitochondrien ausgerichtetes Tetrapeptid, das im Hinblick auf Wechselwirkungen mit Cardiolipin und der mitochondrialen Membranfunktion untersucht wurde. Die klinische Forschung konzentriert sich auf seltene mitochondriale und kardiale Erkrankungen.';

  @override
  String get peptideContentSs31TypicalDose => 'Studienprotokolle variieren';

  @override
  String get peptideContentSs31HalfLife => '~4 Stunden';

  @override
  String get peptideContentSs31Notes =>
      'In vielen Kontexten noch in der Erprobung. Community-Protokolle unterscheiden sich häufig von den in klinischen Studien verwendeten Formulierungen und sollten ausschließlich als Forschungsmaterial behandelt werden.';

  @override
  String get peptideContentLl37Description =>
      'LL-37 ist ein humanes antimikrobielles Cathelicidin-Peptid, das an der angeborenen Immunsignalgebung beteiligt ist. Es wird in Forschungskreisen im Zusammenhang mit Abwehr- und Gewebereaktionswegen diskutiert, wobei Sicherheitsaspekte erheblich sind.';

  @override
  String get peptideContentLl37TypicalDose => 'Forschungsprotokolle variieren';

  @override
  String get peptideContentLl37HalfLife => 'Nicht gut erforscht';

  @override
  String get peptideContentLl37Notes =>
      'Außerhalb kontrollierter Forschung hochgradig experimentell. Da antimikrobielle Peptide die Immunsignalisierung beeinflussen können, ist eine zurückhaltende, rein informative Darstellung wichtig.';

  @override
  String get peptideContentDihexaDescription =>
      'Dihexa ist ein oral aktives, von Angiotensin IV abgeleitetes Peptid-Analogon, das präklinisch im Hinblick auf die Signalgebung des Hepatozyten-Wachstumsfaktors/c-Met und synaptogene Aktivität untersucht wurde. Sicherheits- und Wirksamkeitsdaten beim Menschen sind nicht etabliert.';

  @override
  String get peptideContentDihexaTypicalDose =>
      'Nur für Forschungszwecke; Protokolle variieren';

  @override
  String get peptideContentDihexaHalfLife => 'Nicht gut erforscht';

  @override
  String get peptideContentDihexaNotes =>
      'Beliebt in nootropischen Diskussionen, aber sehr experimentell. Als Eintrag zu einer Forschungssubstanz behandeln, nicht als vorgeschlagenes Protokoll.';

  @override
  String get peptideContentGhrp2Description =>
      'GHRP-2 ist ein synthetisches wachstumshormonfreisetzendes Peptid, das als Ghrelin-Rezeptoragonist wirkt. Es wurde im Hinblick auf die GH-Sekretion, die Appetitsignalgebung und endokrine Tests untersucht.';

  @override
  String get peptideContentGhrp2TypicalDose => '100–300 mcg pro Injektion';

  @override
  String get peptideContentGhrp2HalfLife => '~20–30 Minuten';

  @override
  String get peptideContentGhrp2Notes =>
      'Wird oft mit einem GHRH-Analogon wie CJC-1295 ohne DAC oder Sermorelin kombiniert. Kann Appetit, Cortisol und Prolaktin stärker beeinflussen als Ipamorelin.';

  @override
  String get peptideContentGhrp6Description =>
      'GHRP-6 ist ein synthetisches Hexapeptid und Ghrelin-Rezeptoragonist, das im Hinblick auf die Wachstumshormonausschüttung und die Appetitsignalgebung untersucht wurde. Es zählt zu den älteren Peptiden der GHRP-Familie.';

  @override
  String get peptideContentGhrp6TypicalDose => '100–300 mcg pro Injektion';

  @override
  String get peptideContentGhrp6HalfLife => '~20–30 Minuten';

  @override
  String get peptideContentGhrp6Notes =>
      'In der Community wird häufig die appetitanregende Wirkung betont. Selektivere Optionen wie Ipamorelin werden meist bevorzugt, wenn Appetiteffekte unerwünscht sind.';

  @override
  String get peptideContentHexarelinDescription =>
      'Hexarelin ist ein synthetisches Wachstumshormon-Sekretagogum und Ghrelin-Rezeptoragonist, das im Hinblick auf die GH-Ausschüttung und kardiovaskuläre Forschungssignale untersucht wurde. Es gilt allgemein als eines der potenteren GHRPs.';

  @override
  String get peptideContentHexarelinTypicalDose => '100–200 mcg pro Injektion';

  @override
  String get peptideContentHexarelinHalfLife => '~70 Minuten';

  @override
  String get peptideContentHexarelinNotes =>
      'Wird aufgrund von Bedenken zu Wirkstärke und Desensibilisierung, die in Forschungskreisen diskutiert werden, oft konservativer zyklisch angewendet als Ipamorelin.';

  @override
  String get peptideContentIgf1Lr3Description =>
      'IGF-1 LR3 ist ein modifiziertes Analogon des insulinähnlichen Wachstumsfaktors 1 mit Aminosäuresubstitutionen, die die Bindungsproteinaffinität verringern und die Wirkdauer verlängern. Es wird vor allem in Kontexten der fortgeschrittenen Leistungs- und Zellwachstumsforschung diskutiert.';

  @override
  String get peptideContentIgf1Lr3TypicalDose =>
      '20–50 mcg täglich in Forschungsprotokollen';

  @override
  String get peptideContentIgf1Lr3HalfLife => '~20–30 Stunden';

  @override
  String get peptideContentIgf1Lr3Notes =>
      'Forschungssubstanz mit höherem Risikoprofil. Mögliche Bedenken hinsichtlich Glukose- und Gewebewachstumssignalisierung machen eine medizinische Aufsicht besonders wichtig.';

  @override
  String get peptideContentIgf1DesDescription =>
      'IGF-1 DES ist ein kürzeres IGF-1-Analogon, dem die ersten drei Aminosäuren fehlen. Es wird als kürzer wirkende IGF-Variante in der Forschung zur lokalen Gewebesignalgebung diskutiert.';

  @override
  String get peptideContentIgf1DesTypicalDose =>
      '20–50 mcg in Forschungsprotokollen';

  @override
  String get peptideContentIgf1DesHalfLife => '~20–30 Minuten';

  @override
  String get peptideContentIgf1DesNotes =>
      'Sehr fortgeschritten und experimentell. Vermeide allgemeine Protokollvorschläge, da Sicherheitsdaten beim Menschen und geeignete Überwachung begrenzt sind.';

  @override
  String get peptideContentPegMgfDescription =>
      'PEG-MGF ist eine pegylierte Variante des Mechano-Growth-Factors, einem IGF-1-Spleißvarianten-Peptid. Die Pegylierung soll die Verweildauer im Kreislauf im Vergleich zu unmodifiziertem MGF verlängern.';

  @override
  String get peptideContentPegMgfTypicalDose =>
      '100–300 mcg wöchentlich in Forschungsprotokollen';

  @override
  String get peptideContentPegMgfHalfLife => 'Verlängert durch PEGylierung';

  @override
  String get peptideContentPegMgfNotes =>
      'Häufig in Leistungssport-Foren diskutiert, aber keine zugelassene Therapie. Als fortgeschrittenen Forschungseintrag mit konservativen Standard-Trackingwerten behandeln.';

  @override
  String get peptideContentMk677Description =>
      'MK-677, auch bekannt als Ibutamoren, ist ein oral aktiver Ghrelin-Rezeptoragonist und Wachstumshormon-Sekretagogum. Es handelt sich nicht um ein Peptid, wird jedoch häufig im Zusammenhang mit Peptiden der GH-Achse diskutiert.';

  @override
  String get peptideContentMk677TypicalDose => '10–25 mg täglich';

  @override
  String get peptideContentMk677HalfLife => '~24 Stunden';

  @override
  String get peptideContentMk677Notes =>
      'Verwandte Substanz, kein Peptid. In Community-Diskussionen werden häufig Appetit, Wassereinlagerungen, Schlaf und die Überwachung des Blutzuckers erwähnt.';

  @override
  String get peptideContentFiveAmino1mqDescription =>
      '5-Amino-1MQ ist ein niedermolekularer NNMT-Hemmer, der in Kreisen zu Stoffwechsel und Körperzusammensetzung diskutiert wird. Es handelt sich nicht um ein Peptid, taucht jedoch häufig in peptidnahen Longevity- und Fettabbau-Kombinationen auf.';

  @override
  String get peptideContentFiveAmino1mqTypicalDose => '25–100 mg täglich';

  @override
  String get peptideContentFiveAmino1mqHalfLife => 'Nicht gut erforscht';

  @override
  String get peptideContentFiveAmino1mqNotes =>
      'Verwandte Substanz, kein Peptid. Die Evidenz beim Menschen ist begrenzt; vermeide Aussagen zu Fettabbau oder Insulinsensitivität als Ergebnis.';

  @override
  String get peptideContentTesofensineDescription =>
      'Tesofensin ist ein oraler Monoamin-Wiederaufnahmehemmer, der im Hinblick auf Adipositas und neurodegenerative Erkrankungen untersucht wird. Es handelt sich nicht um ein Peptid, wird jedoch häufig in Kreisen zum Gewichtsmanagement im Zusammenhang mit GLP-1-Wirkstoffen diskutiert.';

  @override
  String get peptideContentTesofensineTypicalDose =>
      '0.25–0.5 mg täglich in Studien';

  @override
  String get peptideContentTesofensineHalfLife => '~9 Tage';

  @override
  String get peptideContentTesofensineNotes =>
      'Verwandte Substanz, kein Peptid. Da sie Neurotransmitter-Signalwege beeinflusst, sind Blutdruck, Herzfrequenz und die Prüfung auf Wechselwirkungen von Bedeutung.';

  @override
  String get peptideContentRu58841Description =>
      'RU-58841 ist ein topisches nichtsteroidales Antiandrogen, das im Hinblick auf die Androgenrezeptor-Signalgebung im Kontext von Haarfollikeln erforscht wird. Es handelt sich nicht um ein Peptid, wird jedoch häufig in peptidnahen ästhetischen Kreisen diskutiert.';

  @override
  String get peptideContentRu58841TypicalDose =>
      'Topisch 25–50 mg täglich in informellen Protokollen';

  @override
  String get peptideContentRu58841HalfLife => 'Nicht gut erforscht';

  @override
  String get peptideContentRu58841Notes =>
      'Verwandte Substanz, kein Peptid und kein zugelassenes Arzneimittel. Qualitätskontrolle und systemische Exposition sind häufige Diskussionspunkte.';

  @override
  String get peptideContentEducationalDisclaimer =>
      'Nur als Bildungsreferenz. Keine medizinische Beratung. Forschungspeptide sind in den meisten Rechtsordnungen nicht für die Anwendung am Menschen zugelassen — wende dich immer an qualifiziertes medizinisches Fachpersonal.';

  @override
  String get twiceWeeklyPickDaysHint =>
      'Wähle genau zwei Wochentage für diesen Plan aus.';

  @override
  String get selectExactlyTwoDaysError =>
      'Wähle genau zwei Tage für einen 2×-pro-Woche-Plan aus.';

  @override
  String get remindersBlockedTitle => 'Erinnerungen sind blockiert';

  @override
  String get remindersBlockedBody =>
      'Dosis-Erinnerungen sind in PepMod aktiviert, aber Mitteilungen sind in den Systemeinstellungen deaktiviert, daher können keine Erinnerungen zugestellt werden.';

  @override
  String get openSettingsAction => 'Einstellungen öffnen';

  @override
  String freeTrialBadgeDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count TAGE KOSTENLOS TESTEN',
      one: '$count TAG KOSTENLOS TESTEN',
    );
    return '$_temp0';
  }

  @override
  String freeTrialBadgeWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count WOCHEN KOSTENLOS TESTEN',
      one: '$count WOCHE KOSTENLOS TESTEN',
    );
    return '$_temp0';
  }

  @override
  String freeTrialBadgeMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count MONATE KOSTENLOS TESTEN',
      one: '$count MONAT KOSTENLOS TESTEN',
    );
    return '$_temp0';
  }

  @override
  String freeTrialBadgeYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count JAHRE KOSTENLOS TESTEN',
      one: '$count JAHR KOSTENLOS TESTEN',
    );
    return '$_temp0';
  }

  @override
  String get createCustomCompoundAction => 'Eigenen Wirkstoff erstellen';

  @override
  String get noPeptidesFoundCreateHint =>
      'Kein Treffer in der Referenzbibliothek. Du kannst es trotzdem als eigenen Wirkstoff erfassen.';

  @override
  String get blendSearchHint =>
      'Blend-Namen wie dieser haben keine Standardformel — der Inhalt variiert je nach Anbieter. Erstelle ihn hier als eigenen Wirkstoff oder beim Erstellen eines Protokolls als vorgemischtes Fläschchen und gib den tatsächlichen Inhalt deines Fläschchens ein.';

  @override
  String get typicalDoseReferenceNote =>
      'Veröffentlichter Referenzbereich zu Bildungszwecken — keine Empfehlung oder Anweisung.';

  @override
  String get peptideContentTestosteroneDescription =>
      'Testosteron ist ein körpereigenes Androgen-Hormon. Injizierbare Ester-Präparate (wie Cypionat und Enanthat) sind verschreibungspflichtige Medikamente für die ärztlich überwachte Hormontherapie. Dieser Eintrag ist eine neutrale Tracking-Referenz für vom Nutzer eingegebene Pläne.';

  @override
  String get peptideContentTestosteroneTypicalDose =>
      'Vom Nutzer eingegebene mg';

  @override
  String get peptideContentTestosteroneHalfLife => 'Ester-abhängig';

  @override
  String get peptideContentTestosteroneNotes =>
      'Verschreibungspflichtig und in vielen Rechtsordnungen eine kontrollierte Substanz. Erfasse nur, was von qualifiziertem medizinischem Fachpersonal angeordnet wurde; PepMod gibt keine Dosierungsempfehlungen für Testosteron.';

  @override
  String get peptideContentGlutathioneDescription =>
      'Glutathion ist ein natürlich vorkommendes Tripeptid (Glutamat-Cystein-Glycin), das als wichtiges intrazelluläres Antioxidans wirkt. Injizierbare Formen werden in einigen Wellness- und klinischen Umgebungen verwendet. Dieser Eintrag ist eine neutrale Tracking-Referenz für vom Nutzer eingegebene Pläne.';

  @override
  String get peptideContentGlutathioneTypicalDose =>
      'Vom Nutzer eingegebene mg';

  @override
  String get peptideContentGlutathioneHalfLife => 'Kurz (systemisch)';

  @override
  String get peptideContentGlutathioneNotes =>
      'Der Zulassungsstatus von injizierbarem Glutathion variiert je nach Land. Erfasse Mengen genau wie bezogen und angeordnet; PepMod gibt keine Dosierungsempfehlungen für diese Substanz.';

  @override
  String get peptideContentKisspeptin10Description =>
      'Kisspeptin-10 ist ein Fragment des Neuropeptids Kisspeptin aus zehn Aminosäuren, das in der Forschung für seine Rolle in der GnRH-Signalgebung und der Regulation der Reproduktionsachse untersucht wird. Humandaten außerhalb kontrollierter Studien sind begrenzt. Dieser Eintrag ist eine neutrale Tracking-Referenz für vom Nutzer eingegebene Pläne.';

  @override
  String get peptideContentKisspeptin10TypicalDose => 'Vom Nutzer eingegeben';

  @override
  String get peptideContentKisspeptin10HalfLife => '~Minuten (berichtet)';

  @override
  String get peptideContentKisspeptin10Notes =>
      'Forschungssubstanz ohne etablierte Protokolle. Erfasse nur vom Nutzer eingegebene Mengen; PepMod gibt keine Dosierungsempfehlungen für diese Substanz.';

  @override
  String get peptideContentSluPp332Description =>
      'SLU-PP-332 ist ein experimenteller niedermolekularer ERR-Agonist, der präklinisch in der Bewegungsphysiologie-Forschung untersucht wird. Es ist kein Peptid und es liegen keine etablierten Daten zu Sicherheit oder Wirksamkeit beim Menschen vor. Dieser Eintrag ist eine neutrale Tracking-Referenz für vom Nutzer eingegebene Pläne.';

  @override
  String get peptideContentSluPp332TypicalDose => 'Vom Nutzer eingegeben';

  @override
  String get peptideContentSluPp332HalfLife => 'Nicht gut belegt';

  @override
  String get peptideContentSluPp332Notes =>
      'Hochexperimentelle Forschungssubstanz ohne Humanstudien. Verwandte Substanz, kein Peptid. Erfasse nur vom Nutzer eingegebene Mengen; PepMod gibt keine Dosierungsempfehlungen für diese Substanz.';
}
