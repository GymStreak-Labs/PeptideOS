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

  @override
  String get tabProtocol => 'Protocol';

  @override
  String get tabProgress => 'Progress';

  @override
  String get tabLibrary => 'Library';

  @override
  String get tabYou => 'You';

  @override
  String get continueLabel => 'CONTINUE';

  @override
  String get processingLabel => 'PROCESSING…';

  @override
  String get authAppleFailed => 'Apple sign-in failed. Please try again.';

  @override
  String get authGoogleFailed => 'Google sign-in failed. Please try again.';

  @override
  String get authGenericError => 'Something went wrong. Please try again.';

  @override
  String get authUserNotFound => 'No user found with this email address.';

  @override
  String get authIncorrectCredentials => 'Incorrect email or password.';

  @override
  String get authAccountExists => 'An account already exists with this email.';

  @override
  String get authWeakPassword =>
      'Password is too weak. Use at least 6 characters.';

  @override
  String get authInvalidEmail => 'Invalid email address.';

  @override
  String get authAppleUnavailable =>
      'Sign in with Apple is not enabled for this app.';

  @override
  String get authRequiredTitle => 'Save your personalised\nprotocol';

  @override
  String get authRequiredBody =>
      'Keep your roadmap, schedule, dose logs, and reminders attached to your account before the protocol unlocks.';

  @override
  String get continueWithEmail => 'CONTINUE WITH EMAIL';

  @override
  String get signInWithApple => 'SIGN IN WITH APPLE';

  @override
  String get continueWithGoogle => 'CONTINUE WITH GOOGLE';

  @override
  String get authTermsDisclaimer =>
      'By continuing you accept our Terms and Privacy Policy. PepMod is an educational tool — not medical advice.';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'Create account';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get signInAction => 'SIGN IN';

  @override
  String get createAccountAction => 'CREATE ACCOUNT';

  @override
  String get sendResetLink => 'SEND RESET LINK';

  @override
  String get passwordResetSent =>
      'Password reset email sent. Check your inbox.';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get enterPassword => 'Enter a password';

  @override
  String get passwordMinLength => 'At least 6 characters';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get backToSignIn => 'Back to sign in';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get accountDeletedTitle => 'Account deleted';

  @override
  String get accountDeletedBody =>
      'Your PepMod account and saved app data have been removed.';

  @override
  String get subscriptionUnavailable =>
      'Subscription plans are not available right now. Please try again.';

  @override
  String get upgradeUnavailable =>
      'Upgrade is not available right now. Please try again later.';

  @override
  String get noPurchasesToRestore => 'No purchases found to restore.';

  @override
  String get unlockFullProtocol => 'Unlock the full protocol';

  @override
  String get premiumUnlimitedPeptides => 'Unlimited peptides per protocol';

  @override
  String get premiumMultipleProtocols => 'Multiple active protocols';

  @override
  String get premiumCalculator => 'Reconstitution calculator (all peptides)';

  @override
  String get premiumMetrics => 'Body metric tracking + charts';

  @override
  String get upgradeNow => 'UPGRADE NOW';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get notRightNow => 'Not right now';

  @override
  String get protocolWeeklyPlanner => 'Weekly planner';

  @override
  String get protocolDoseHistory => 'Dose history';

  @override
  String get protocolCreate => 'Create protocol';

  @override
  String get protocolManage => 'MANAGE';

  @override
  String get protocolYourProtocol => 'Your Protocol';

  @override
  String get protocolNoActive => 'No active protocol';

  @override
  String get protocolNoActiveBody =>
      'Create your first protocol to start tracking doses and building adherence.';

  @override
  String get protocolStartFirst => 'START FIRST PROTOCOL';

  @override
  String get protocolScheduleTodaySystemLabel => 'SCHEDULE // TODAY';

  @override
  String get protocolAdherenceTodaySystemLabel => 'ADHERENCE // TODAY';

  @override
  String get protocolNoDosesScheduledToday => 'No doses scheduled today';

  @override
  String protocolDosesTaken(int taken, int total) {
    return '$taken of $total doses taken';
  }

  @override
  String get protocolNextDose => 'NEXT DOSE';

  @override
  String protocolInTime(String duration) {
    return 'In $duration';
  }

  @override
  String protocolDurationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String protocolDurationMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String get protocolLogDose => 'LOG DOSE';

  @override
  String get protocolNow => 'now';

  @override
  String get protocolMissed => 'MISSED';

  @override
  String get protocolSkipped => 'SKIPPED';

  @override
  String get protocolNoDosesToday => 'No doses today';

  @override
  String get protocolNoDosesTodayBody =>
      'Your protocol has no doses scheduled for today.';

  @override
  String get protocolFreeLimit =>
      'Free plan is limited to one protocol. Upgrade to Premium to run multiple stacks at once.';

  @override
  String protocolSyringeUnitsSuffix(String amount) {
    return ' · $amount syringe units';
  }

  @override
  String get injectionSiteLeftAbdomen => 'Left Abdomen';

  @override
  String get injectionSiteRightAbdomen => 'Right Abdomen';

  @override
  String get injectionSiteLeftThigh => 'Left Thigh';

  @override
  String get injectionSiteRightThigh => 'Right Thigh';

  @override
  String get injectionSiteLeftGlute => 'Left Glute';

  @override
  String get injectionSiteRightGlute => 'Right Glute';

  @override
  String get injectionSiteLeftTriceps => 'Left Triceps';

  @override
  String get injectionSiteRightTriceps => 'Right Triceps';

  @override
  String get plannerToday => 'TODAY';

  @override
  String get plannerBack => 'Back';

  @override
  String get plannerPreviousWeek => 'Previous week';

  @override
  String get plannerNextWeek => 'Next week';

  @override
  String plannerScheduledCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count scheduled doses',
      one: '$count scheduled dose',
    );
    return '$_temp0';
  }

  @override
  String get plannerTrackingDisclaimer =>
      'Tracking only. This calendar reflects your saved protocol and does not provide dosing advice.';

  @override
  String get plannerWashoutPeriod => 'Washout period';

  @override
  String plannerWashoutUntil(String date) {
    return 'Washout until $date';
  }

  @override
  String get plannerNoScheduledDoses => 'No scheduled doses';

  @override
  String get plannerNothingPlanned =>
      'Nothing is planned from your saved protocols.';

  @override
  String get activatePro => 'ACTIVATE PRO';

  @override
  String activateProPrice(String price) {
    return 'ACTIVATE PRO — $price/year';
  }

  @override
  String get annualAccess => 'Annual access';

  @override
  String get annualLabel => 'Annual';

  @override
  String get averageRating => 'AVG RATING';

  @override
  String get bacWaterLabel => 'BAC WATER';

  @override
  String get basedOnInputs => 'Based on your inputs //';

  @override
  String get bestValue => 'Best Value';

  @override
  String get birthDateInvalid =>
      'Enter a valid date for someone aged 18 or older.';

  @override
  String get birthDateValid => 'Age verified';

  @override
  String calculatorDemoBody(String peptideName) {
    return 'Here’s how it works with $peptideName';
  }

  @override
  String get calculatorDemoResult =>
      'That’s it. Enter your values,\nget exact syringe units.';

  @override
  String get calculatorDemoTitle => 'No more\nscary math.';

  @override
  String get confidenceCycleTiming => 'Cycle timing';

  @override
  String get confidenceCycleTimingDetail =>
      'See protocol dates and schedule windows clearly';

  @override
  String get confidenceDoseMath => 'Dose math';

  @override
  String get confidenceDoseMathDetail =>
      'Keep vial, water, dose, and draw units together';

  @override
  String get confidenceLabel => 'CONFIDENCE';

  @override
  String get confidencePlainInfo => 'Plain-language information';

  @override
  String get confidencePlainInfoDetail =>
      'Read research notes without the clutter';

  @override
  String get confidenceProgressSignals => 'Progress signals';

  @override
  String get confidenceProgressSignalsDetail =>
      'See adherence and body metrics over time';

  @override
  String get confidenceSafetyFraming => 'Safety framing';

  @override
  String get confidenceSafetyFramingDetail =>
      'Keep educational guidance and disclaimers visible';

  @override
  String get confidenceSiteRotation => 'Site rotation';

  @override
  String get confidenceSiteRotationDetail =>
      'Remember where each dose was logged';

  @override
  String get connectingToStore => 'CONNECTING TO STORE...';

  @override
  String continueSelected(int count) {
    return 'CONTINUE ($count)';
  }

  @override
  String get customProtocol => 'Custom Protocol';

  @override
  String get dateOfBirthLabel => 'DATE OF BIRTH';

  @override
  String get dayOne => 'DAY 1';

  @override
  String get dayShortLabel => 'DD';

  @override
  String get defaultConfidence => 'Dose math · Site rotation';

  @override
  String get defaultFrustration => 'Missing doses';

  @override
  String get defaultGoals => 'Recovery · Longevity';

  @override
  String get doseLabel => 'DOSE';

  @override
  String get dosesLogged => 'DOSES LOGGED';

  @override
  String get dosesPerDay => 'DOSES/DAY';

  @override
  String get drawVolumeLabel => 'DRAW VOLUME';

  @override
  String get durationLabel => 'DURATION';

  @override
  String get experienceAdvanced => 'Advanced';

  @override
  String get experienceAdvancedDetail =>
      'I’m comfortable managing detailed protocols';

  @override
  String get experienceFirstTime => 'First time';

  @override
  String get experienceFirstTimeDetail => 'I’m new to peptide tracking';

  @override
  String get experienceIntermediate => 'INTERMEDIATE';

  @override
  String get experienceLabel => 'EXPERIENCE';

  @override
  String get experienceNovice => 'NOVICE';

  @override
  String get experienceSome => 'Some experience';

  @override
  String get experienceSomeDetail => 'I’ve tracked one or two protocols';

  @override
  String get experienceVeteran => 'VETERAN';

  @override
  String get featureDoseMathBody =>
      'Keep vial size, water volume, dose, and units-to-draw beside the protocol you are actually tracking.';

  @override
  String get featureDoseMathTitle => 'Dose Math\nIn Context';

  @override
  String get featureProtocolArcBody =>
      'See planned doses, logged doses, adherence, and body metrics build into one timeline.';

  @override
  String get featureProtocolArcTitle => 'Protocol Arc\nOver Time';

  @override
  String get featureShowcaseTitle => 'Everything you need.\nOne app.';

  @override
  String get featureSiteRotationBody =>
      'Remember every site you log and keep rotation history attached to the dose record.';

  @override
  String get featureSiteRotationTitle => 'Injection Site\nRotation';

  @override
  String get firstNameExample => 'e.g. Alex';

  @override
  String get firstNameLabel => 'FIRST NAME';

  @override
  String get frustrationForgetting => 'Forgetting doses';

  @override
  String get frustrationLabel => 'FRUSTRATION';

  @override
  String get frustrationMath => 'Vial and syringe math';

  @override
  String get frustrationProgress => 'Seeing whether I’m consistent';

  @override
  String get frustrationSchedule => 'Keeping the schedule straight';

  @override
  String get frustrationStacking => 'Managing multiple peptides';

  @override
  String get frustrationTrust => 'Finding trustworthy information';

  @override
  String get goalAntiAging => 'Healthy ageing';

  @override
  String get goalAntiAgingDetail => 'Organise longevity-focused records';

  @override
  String get goalCognitive => 'Cognitive support';

  @override
  String get goalCognitiveDetail => 'Monitor focus and mental performance';

  @override
  String get goalImmune => 'Immune support';

  @override
  String get goalImmuneDetail => 'Keep immune-focused protocols organised';

  @override
  String get goalMuscleGrowth => 'Muscle growth';

  @override
  String get goalMuscleGrowthDetail => 'Track training and growth goals';

  @override
  String get goalOther => 'Other';

  @override
  String get goalOtherDetail => 'Set up a different tracking goal';

  @override
  String get goalRecovery => 'Recovery';

  @override
  String get goalRecoveryDetail => 'Support recovery records and routines';

  @override
  String get goalSleep => 'Sleep';

  @override
  String get goalSleepDetail => 'Track sleep-related goals and patterns';

  @override
  String get goalWeightLoss => 'Weight loss';

  @override
  String get goalWeightLossDetail => 'Track metabolic goals and progress';

  @override
  String get goalsLabel => 'GOALS';

  @override
  String get iUnderstand => 'I UNDERSTAND';

  @override
  String get lastThreeDaysAgo => 'Last: 3 days ago';

  @override
  String get leftAbdomen => 'Left abdomen';

  @override
  String get loveIt => 'LOVE IT';

  @override
  String get maybeLater => 'Maybe later';

  @override
  String get monthOne => 'MONTH 1';

  @override
  String get monthShortLabel => 'MM';

  @override
  String get monthTwo => 'MONTH 2';

  @override
  String moreCount(String shown, int count) {
    return '$shown +$count more';
  }

  @override
  String get needsWork => 'NEEDS WORK';

  @override
  String get notificationBody =>
      'Get discreet reminders when a scheduled protocol window is due. No peptide names in notifications — just a gentle nudge.';

  @override
  String get notificationTitle => 'Keep dose times\nvisible.';

  @override
  String get nowLabel => 'now';

  @override
  String get ok => 'OK';

  @override
  String get onboardingAgeConfirmed => 'I’M 18 OR OLDER';

  @override
  String get onboardingAgeRequirementBody =>
      'You must be 18 or older to use PepMod.';

  @override
  String get onboardingAgeRequirementTitle => 'Age requirement';

  @override
  String get onboardingAgeVerificationBody =>
      'PepMod is intended for adults aged 18 and over.';

  @override
  String get onboardingAgeVerificationTitle => 'First, confirm\nyour age.';

  @override
  String get onboardingAheadBody =>
      'Answer a few questions and PepMod will organise a personalised tracking preview.';

  @override
  String get onboardingAheadTitle => 'See your protocol\nbefore you start.';

  @override
  String get onboardingBirthDateBody =>
      'This confirms you meet the age requirement.';

  @override
  String get onboardingBirthDateTitle => 'When were\nyou born?';

  @override
  String get onboardingConfidenceBody =>
      'Choose everything PepMod should make clearer.';

  @override
  String get onboardingConfidenceTitle => 'Where do you want\nmore confidence?';

  @override
  String get onboardingConversionValueBody =>
      'Convert the values from your vial and plan into volume and syringe units.';

  @override
  String get onboardingConversionValueTitle =>
      'Make vial math\neasier to check.';

  @override
  String get onboardingDisclaimerBody =>
      'PepMod helps organise records, reminders, and unit conversions. It does not diagnose, prescribe, or replace qualified healthcare advice.';

  @override
  String get onboardingDisclaimerTitle =>
      'Built for clarity.\nNot prescriptions.';

  @override
  String get onboardingExperienceTitle => 'How experienced\nare you?';

  @override
  String get onboardingFrustrationBody => 'Pick the biggest friction point.';

  @override
  String get onboardingFrustrationTitle => 'What feels\nhardest today?';

  @override
  String get onboardingGoalsTitle => 'What are your\nmain goals?';

  @override
  String get onboardingGuidedStartBody =>
      'We’ll tailor the setup to your goals, experience, and the records you want to keep.';

  @override
  String get onboardingGuidedStartTitle => 'A guided start,\nbuilt around you.';

  @override
  String get onboardingHookAnswer =>
      'PepMod keeps the answer beside your protocol.';

  @override
  String get onboardingHookQuestion => 'How many units\ndo you draw?';

  @override
  String get onboardingHookResearch => 'RESEARCH LIBRARY';

  @override
  String get onboardingHookSources => 'Evidence-linked sources';

  @override
  String get onboardingHookVial => 'VIAL + DILUENT';

  @override
  String get onboardingNameBody =>
      'We’ll use this to personalise your PepMod experience.';

  @override
  String get onboardingNameTitle => 'What should we\ncall you?';

  @override
  String get onboardingPeptideSelectBody =>
      'Choose any peptides you use or want to keep on your radar.';

  @override
  String get onboardingPeptideSelectTitle => 'What are you\ntracking?';

  @override
  String get onboardingProgressValueBody =>
      'Bring adherence, dose history, and body metrics into one clear record.';

  @override
  String get onboardingProgressValueTitle => 'See the full arc\nover time.';

  @override
  String get onboardingProtocolValueBody =>
      'Plan schedules, log doses, and keep the details attached to each protocol.';

  @override
  String get onboardingProtocolValueTitle =>
      'Keep every protocol\nin one place.';

  @override
  String get onboardingUnder18 => 'I’M UNDER 18';

  @override
  String get openingPermission => 'OPENING PERMISSION...';

  @override
  String get paywallArcBody =>
      'See what was planned, what was logged, and what needs a cleaner record next.';

  @override
  String get paywallArcTitle => 'WATCH THE ARC OVER TIME';

  @override
  String get paywallBody =>
      'Dose math, site rotation, reminders, and protocol history — all in one record.';

  @override
  String get paywallDoseMathBody =>
      'Keep vial, water, dose, and units-to-draw together so each log is easier to check.';

  @override
  String get paywallDoseMathTitle => 'GET THE DOSE MATH RIGHT';

  @override
  String get paywallPreviewDisclaimer =>
      'Built for records, reminders, and unit clarity — not medical advice.';

  @override
  String get paywallRotationBody =>
      'Every site, cycle, and reminder stays attached to the protocol record.';

  @override
  String get paywallRotationTitle => 'NEVER LOSE YOUR ROTATION';

  @override
  String get paywallTitle => 'Everything to run\nyour protocol right.';

  @override
  String get paywallValueNote =>
      'A confusing vial calculation can waste time and product. PepMod keeps the math beside the log so you can re-check your records before you act on old notes.';

  @override
  String get peptideLabel => 'PEPTIDE';

  @override
  String get peptidesLabel => 'PEPTIDES';

  @override
  String get peptidesTracked => 'PEPTIDES\nTRACKED';

  @override
  String get perWeek => '/week';

  @override
  String get perYear => '/year';

  @override
  String get privacyLabel => 'Privacy';

  @override
  String processingGoals(int count) {
    return 'ANALYSING $count GOALS...';
  }

  @override
  String processingPeptides(int count) {
    return 'LINKING $count PEPTIDE RECORDS...';
  }

  @override
  String get processingProtocol => 'BUILDING YOUR PROTOCOL...';

  @override
  String get processingSchedule => 'ORGANISING YOUR SCHEDULE...';

  @override
  String get processingTitle => 'Building your\nprotocol';

  @override
  String get progressLabel => 'Progress';

  @override
  String get protocolClarity => 'protocol clarity';

  @override
  String get protocolIncludes => 'YOUR PROTOCOL INCLUDES //';

  @override
  String get protocolPreviewTitle => 'Your protocol\nis ready.';

  @override
  String get protocolReady => 'PROTOCOL READY //';

  @override
  String get protocolReminderReady => 'Protocol reminder is ready';

  @override
  String get protocolReservedFor =>
      'YOUR PERSONALISED PROTOCOL IS RESERVED FOR';

  @override
  String get restorePurchase => 'Restore Purchase';

  @override
  String get resultsSummaryBody =>
      'We’ll keep dose logs, reconstitution math, and trend records together as your data builds.';

  @override
  String get reviewGateBody =>
      'Your feedback helps us improve the platform for every biohacker.';

  @override
  String get reviewGateTitle => 'Enjoying PepMod\nso far?';

  @override
  String roadmapBody(int count, String need) {
    return 'Built around $count tracked peptides and your need for $need.';
  }

  @override
  String get roadmapDayOneBody =>
      'Peptides, dose logs, site rotation, and reminders are ready.';

  @override
  String get roadmapDayOneTitle => 'Your first protocol is organised';

  @override
  String get roadmapDisclaimer =>
      'PepMod keeps records and reminders organised. It does not prescribe, diagnose, or replace clinician guidance.';

  @override
  String get roadmapMonthOneBody =>
      'Adherence, missed doses, and body metrics start forming a cleaner record.';

  @override
  String get roadmapMonthOneTitle => 'Your consistency history takes shape';

  @override
  String get roadmapMonthTwoBody =>
      'See what you planned, what happened, and where your records need attention.';

  @override
  String get roadmapMonthTwoTitle => 'Your full protocol arc is visible';

  @override
  String get roadmapTitle => 'Here is what\nis ahead.';

  @override
  String get roadmapWeekOneBody =>
      'Plain-English research and tracking notes stay attached to your plan.';

  @override
  String roadmapWeekOneTitle(String goal) {
    return 'Your library fills around $goal';
  }

  @override
  String savePercent(int percent) {
    return 'SAVE $percent%';
  }

  @override
  String get saveRoadmap => 'SAVE THIS ROADMAP';

  @override
  String get schedulePreview => 'SCHEDULE PREVIEW';

  @override
  String get seeWhatsInside => 'SEE WHAT’S INSIDE';

  @override
  String get selectAllThatApply => 'Select all that apply.';

  @override
  String get siteMap => 'Site map';

  @override
  String get skipForNow => 'SKIP FOR NOW';

  @override
  String get socialProofBody => 'Join thousands tracking real progress.';

  @override
  String get socialProofTitle => 'Trusted by\nbiohackers worldwide';

  @override
  String get specialOffer => 'SPECIAL OFFER';

  @override
  String get startFreeTrial => 'START FREE TRIAL';

  @override
  String get subscribeLabel => 'SUBSCRIBE';

  @override
  String subscribePrice(String price) {
    return 'SUBSCRIBE — $price/week';
  }

  @override
  String get subscribeToActivate => 'Subscribe to activate your protocol';

  @override
  String get subscriptionRenewalDisclaimer =>
      'Subscription auto-renews unless cancelled at least 24 hours before the end of the current period. Manage in Settings > Apple ID > Subscriptions.';

  @override
  String syringeVolume(String volume) {
    return '${volume}ml on a 1ml syringe';
  }

  @override
  String get termsLabel => 'Terms';

  @override
  String get testimonialOne =>
      'Finally stopped missing doses. The reconstitution calculator alone saved me hours of spreadsheet maths.';

  @override
  String get testimonialThree =>
      'Cleanest peptide tracker I’ve used. Looks like it was built for serious users, because it was.';

  @override
  String get testimonialTwo =>
      'The weekly insights caught a timing issue I didn’t notice for months. Game-changer.';

  @override
  String get thirtyDayAdherence => '30-day adherence';

  @override
  String get threeDayFreeTrial => '3-DAY FREE TRIAL';

  @override
  String get timelineLabel => 'Timeline';

  @override
  String get trackedLabel => 'tracked';

  @override
  String get turnOnReminders => 'TURN ON REMINDERS';

  @override
  String get unitConversionDisclaimer =>
      'Unit conversion tool for reference only. Always verify with your healthcare provider.';

  @override
  String get unitsLabel => 'Units';

  @override
  String get unitsToDraw => 'Units to draw';

  @override
  String get unlockPepMod => 'UNLOCK PEPMOD';

  @override
  String get usersLabel => 'USERS';

  @override
  String get viewLabel => 'VIEW';

  @override
  String get weekDuration => 'WEEK\nDURATION';

  @override
  String get weekOne => 'WEEK 1';

  @override
  String get weeklyLabel => 'Weekly';

  @override
  String weeksCount(int count) {
    return '$count weeks';
  }

  @override
  String get yearLabel => 'YEAR';

  @override
  String get profileTitle => 'You';

  @override
  String get signedIn => 'Signed in';

  @override
  String get sectionAccount => 'ACCOUNT';

  @override
  String get sectionPreferences => 'PREFERENCES';

  @override
  String get sectionData => 'DATA';

  @override
  String get sectionSupport => 'SUPPORT';

  @override
  String get sectionLegal => 'LEGAL';

  @override
  String get sectionAbout => 'ABOUT';

  @override
  String get nameLabel => 'Name';

  @override
  String get accountLabel => 'Account';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get removeAccountData => 'Remove account and data';

  @override
  String get metricLabel => 'Metric';

  @override
  String get imperialLabel => 'Imperial';

  @override
  String get notificationsLabel => 'Notifications';

  @override
  String get onLabel => 'On';

  @override
  String get offLabel => 'Off';

  @override
  String get myCompoundsProfile => 'My compounds';

  @override
  String get savedVialPresets => 'Saved vial presets';

  @override
  String get exportData => 'Export data';

  @override
  String get copyAsJson => 'Copy as JSON';

  @override
  String get clearAllData => 'Clear all data';

  @override
  String get clearingLabel => 'Clearing…';

  @override
  String get resetApp => 'Reset app';

  @override
  String get contactSupport => 'Contact support';

  @override
  String get chatWithUs => 'Chat with us';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get medicalDisclaimer => 'Medical disclaimer';

  @override
  String get disclaimerTitle => 'Disclaimer';

  @override
  String get versionLabel => 'Version';

  @override
  String get signOutAction => 'SIGN OUT';

  @override
  String get educationalTrackingDisclaimer =>
      'Educational tracking only. Not medical advice.';

  @override
  String get yourName => 'Your name';

  @override
  String get cancelLabel => 'Cancel';

  @override
  String get saveLabel => 'Save';

  @override
  String get dataCopied => 'Data copied to clipboard.';

  @override
  String get clearDataTitle => 'Clear all data?';

  @override
  String get clearDataBody =>
      'This deletes all protocols, dose logs, and body metrics, then restarts onboarding. Your account, subscription, and peptide library are preserved. This cannot be undone.';

  @override
  String get clearLabel => 'Clear';

  @override
  String get clearingDataTitle => 'Clearing data…';

  @override
  String get clearingDataBody =>
      'Keep PepMod open while your tracking data is removed.';

  @override
  String get clearDataFailed =>
      'Could not clear data. Check your connection and retry.';

  @override
  String get allDataCleared => 'All data cleared.';

  @override
  String get deleteAccountTitle => 'Delete account?';

  @override
  String get deleteAccountBody =>
      'This permanently deletes your PepMod account, settings, protocols, dose logs, and body metrics. This cannot be undone.';

  @override
  String get deletingAccount => 'Deleting account…';

  @override
  String get accountDeletionFailed =>
      'Account deletion failed. Please try again.';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get deleteLabel => 'Delete';

  @override
  String get signOutTitle => 'Sign out?';

  @override
  String get signOutBody =>
      'Your protocols stay saved and sync back when you sign in again.';

  @override
  String get signOutLabel => 'Sign out';

  @override
  String get signOutFailed => 'Sign out failed. Please try again.';

  @override
  String get notificationsDisabledSystem =>
      'Notifications are disabled in system settings.';

  @override
  String get planPro => 'PRO';

  @override
  String get planFree => 'FREE';

  @override
  String get termsBody =>
      'PepMod is provided for educational and tracking purposes only. It is not a medical device and does not provide medical advice, diagnosis, prescriptions, or treatment recommendations. By using PepMod, you are responsible for your own records, decisions, and consultation with qualified healthcare professionals.\n\nSubscriptions renew automatically unless cancelled through the App Store or Google Play before the renewal period. Refunds are handled by the store where you purchased.\n\nFull Terms: https://appstorecopilot.com/legal/yzh32x5v/terms';

  @override
  String get privacyBody =>
      'PepMod uses Firebase for authentication and cloud data storage, RevenueCat for subscriptions, AppRefer and Meta/Facebook App Events for attribution, and Firebase/Crashlytics for analytics and diagnostics. We do not sell your personal information. You can delete your account and saved app data from within the app.\n\nFull Privacy Policy: https://appstorecopilot.com/legal/yzh32x5v/privacy';

  @override
  String get medicalDisclaimerBody =>
      'PepMod is a wellness and tracking tool — NOT a medical device. Nothing in this app constitutes medical advice, diagnosis, prescription, or treatment recommendation. Peptides described in the library are for educational purposes only. Always consult a qualified healthcare provider before starting, changing, or stopping any regimen. If you experience any adverse effects, seek medical attention immediately.';

  @override
  String get profileSystemLabel => 'SYS.USER // PROFILE';

  @override
  String get legalSystemLabel => 'SYS.LEGAL';

  @override
  String get progressTitle => 'Progress';

  @override
  String get progressSystemLabel => 'SYS.PROGRESS // BIOMETRICS';

  @override
  String get doseHistoryTooltip => 'Open dose history';

  @override
  String get logMeasurementTooltip => 'Log measurement';

  @override
  String get thirtyDayLabel => '30-DAY';

  @override
  String get adherenceLabel => 'adherence';

  @override
  String get streakLabel => 'STREAK';

  @override
  String get daysLabel => 'days';

  @override
  String get totalLabel => 'TOTAL';

  @override
  String get dosesLabel => 'doses';

  @override
  String get protocolHistoryLabel => 'PROTOCOL.HISTORY';

  @override
  String get noProtocolsYet =>
      'No protocols yet. Create one from the Protocol tab.';

  @override
  String get adherenceChartLabel => 'ADHERENCE // 30.DAY';

  @override
  String get thirtyDaysAgo => '30d ago';

  @override
  String get todayLabel => 'today';

  @override
  String get noWeightData => 'No weight data';

  @override
  String get logFirstMeasurement =>
      'Log your first measurement to see trends here.';

  @override
  String get logMeasurementAction => 'LOG MEASUREMENT';

  @override
  String get weightTrendLabel => 'WEIGHT // TREND';

  @override
  String weightKgValue(String weight) {
    return '$weight kg';
  }

  @override
  String get statusActive => 'ACTIVE';

  @override
  String get statusPaused => 'PAUSED';

  @override
  String get statusEnded => 'ENDED';

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
  String get enterOneMetric => 'Enter at least one value.';

  @override
  String get saveMetricFailed => 'Failed to save. Try again.';

  @override
  String get newMeasurement => 'New Measurement';

  @override
  String get weightLabel => 'WEIGHT';

  @override
  String get bodyFatLabel => 'BODY FAT';

  @override
  String get measurementsCmLabel => 'MEASUREMENTS (cm)';

  @override
  String get waistLabel => 'WAIST';

  @override
  String get chestLabel => 'CHEST';

  @override
  String get armLabel => 'ARM';

  @override
  String get saveAction => 'SAVE';

  @override
  String get logMetricSystemLabel => 'LOG.METRIC';

  @override
  String get activeLastSevenDays => 'LAST 7 DAYS';

  @override
  String get activeAllTime => 'ALL TIME';

  @override
  String get activeAdherence => 'adherence';

  @override
  String get activeStarted => 'STARTED';

  @override
  String get activeEnded => 'ENDED';

  @override
  String activeStackCount(int count) {
    return 'STACK ($count)';
  }

  @override
  String get activeEditProtocol => 'EDIT PROTOCOL';

  @override
  String get activePauseProtocol => 'PAUSE PROTOCOL';

  @override
  String get activeEndProtocol => 'END PROTOCOL';

  @override
  String get activeResumeProtocol => 'RESUME PROTOCOL';

  @override
  String get activeDeleteProtocol => 'DELETE PROTOCOL';

  @override
  String get activeTrackingDisclaimer =>
      'Educational tracking only. Consult a qualified healthcare provider before making changes.';

  @override
  String get activeEndQuestion => 'End protocol?';

  @override
  String get activeEndBody =>
      'Future doses will be removed. Past logs stay in your history. This cannot be undone.';

  @override
  String get activeEndAction => 'END';

  @override
  String get activeDeleteQuestion => 'Delete protocol?';

  @override
  String get activeDeleteBody =>
      'This permanently removes the protocol and all its dose logs. This cannot be undone.';

  @override
  String get activeDeleteAction => 'DELETE';

  @override
  String get cancel => 'Cancel';

  @override
  String get activeStatusActive => 'ACTIVE';

  @override
  String get activeStatusPaused => 'PAUSED';

  @override
  String get activeStatusEnded => 'ENDED';

  @override
  String get activeNotesLabel => 'NOTES // PROTOCOL';

  @override
  String get activeChangeReminders => 'CHANGE REMINDERS';

  @override
  String get activeChangeRemindersBody =>
      'When Notifications is on, PepMod schedules a 09:00 local checkpoint for each upcoming phase change.';

  @override
  String activePhaseAnchor(String date) {
    return 'Week ranges are anchored to $date.';
  }

  @override
  String activeWeek(int week) {
    return 'WEEK $week';
  }

  @override
  String activeWeeks(int start, int end) {
    return 'WEEKS $start–$end';
  }

  @override
  String get activePerDayAmounts => 'Per-day amounts';

  @override
  String get activeBaseAmount => 'Base amount';

  @override
  String get activeCurrent => 'CURRENT';

  @override
  String get activeBaseSchedule => 'Base schedule';

  @override
  String get activeCustomDays => 'Custom days';

  @override
  String get activeContinuousTracking => 'Continuous tracking';

  @override
  String get activeNoFixedCycle => 'No fixed cycle window';

  @override
  String activeCycleProgress(int week, int total) {
    return 'Week $week of $total';
  }

  @override
  String activeCycleEnds(String date) {
    return 'Cycle ends $date';
  }

  @override
  String activeRestProgress(int week, int total) {
    return 'Rest week $week of $total';
  }

  @override
  String activeRestEnds(String date) {
    return 'Rest window ends $date';
  }

  @override
  String get activeCycleComplete => 'Cycle complete';

  @override
  String activeCompletedDate(String date) {
    return 'Completed $date';
  }

  @override
  String activeRestEnded(String date) {
    return 'Rest window ended $date';
  }

  @override
  String get activeNoHistory => 'No paused or ended protocols yet.';

  @override
  String activeCompoundsCount(int count) {
    return '$count compounds';
  }

  @override
  String activeSyringeUnits(String amount) {
    return '$amount syringe units';
  }

  @override
  String activeCycleWeeks(int count) {
    return '${count}wk cycle';
  }

  @override
  String activeRestWeeks(int count) {
    return '${count}wk rest';
  }

  @override
  String get activePerDraw => 'PER DRAW';

  @override
  String activeVialSummary(String volume) {
    return '$volume mL vial · U-100';
  }

  @override
  String get addCompound => 'ADD COMPOUND';

  @override
  String get addPhase => 'ADD PHASE';

  @override
  String get addTime => 'Add time';

  @override
  String get addToStack => 'ADD TO STACK';

  @override
  String get amountRequired => 'Amount required';

  @override
  String get baseAmount => 'Base amount';

  @override
  String get baseSchedule => 'base schedule';

  @override
  String get blendConfigBody =>
      'Enter exactly what is printed on the vial. PepMod converts the draw into a per-compound snapshot.';

  @override
  String get blendIncompleteError =>
      'Complete at least two compounds, diluent volume, and draw.';

  @override
  String get blendNameHint => 'e.g. Recovery blend';

  @override
  String get blendNameLabel => 'BLEND NAME';

  @override
  String get blendSafetyDisclaimer =>
      'Unit conversion only. PepMod does not recommend a blend, dose, frequency, or reconstitution method.';

  @override
  String get changeNoteHint => 'Your own context for this phase';

  @override
  String get changeNoteOptional => 'CHANGE NOTE OPTIONAL';

  @override
  String colorOption(String hex) {
    return 'Colour option $hex';
  }

  @override
  String compoundNumber(int number) {
    return 'COMPOUND $number';
  }

  @override
  String compoundsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count compounds',
      one: '1 compound',
    );
    return '$_temp0';
  }

  @override
  String copiedVialPreset(String amount, String unit) {
    return '$amount $unit vial preset · copied into this protocol';
  }

  @override
  String get createProtocolAction => 'CREATE PROTOCOL';

  @override
  String get createProtocolAddOneError => 'Add at least one peptide.';

  @override
  String createProtocolBuildStep(int step, int total) {
    return 'Build Protocol · Step $step / $total';
  }

  @override
  String get createProtocolDefaultName => 'My Protocol';

  @override
  String createProtocolEditStep(int step, int total) {
    return 'Edit Protocol · Step $step / $total';
  }

  @override
  String get createProtocolFreeLimitReason =>
      'Free plan is limited to one peptide per protocol. Upgrade to stack multiple compounds.';

  @override
  String get createProtocolNameBody =>
      'Give it a memorable label — e.g. “Recovery Stack” or “Q2 Shred”.';

  @override
  String get createProtocolNameTitle => 'Name your protocol';

  @override
  String get createProtocolNoPeptides => 'No peptides yet';

  @override
  String get createProtocolPickHint => 'Tap + to pick from the library';

  @override
  String get createProtocolReviewBody =>
      'Confirm the protocol details. You can edit anytime from the Manage view.';

  @override
  String get createProtocolSaveError => 'Failed to save protocol. Try again.';

  @override
  String get createProtocolStackBody =>
      'Add one peptide or stack multiple compounds. Configure each label, dose, frequency, and cycle.';

  @override
  String get createProtocolStackTitle => 'Build your stack';

  @override
  String get customBlend => 'Custom blend';

  @override
  String get customDays => 'Custom days';

  @override
  String get customDaysDisclaimer =>
      'Only selected weekdays are scheduled. Amounts are user-entered tracking values, not dosing advice.';

  @override
  String get customPeptide => 'Custom peptide';

  @override
  String get cycleWeeksLabel => 'CYCLE WEEKS';

  @override
  String get cycleWindowDisclaimer =>
      'Cycle and rest windows organise tracking history. PepMod will not schedule future doses after the cycle window ends.';

  @override
  String get defaultAmountLabel => 'DEFAULT AMOUNT';

  @override
  String get diluentVolumeLabel => 'DILUENT VOLUME';

  @override
  String get drawExceedsVialError => 'Draw cannot exceed the vial volume.';

  @override
  String get drawLabel => 'DRAW';

  @override
  String get drawPreviewLabel => 'DRAW PREVIEW';

  @override
  String drawPreviewValue(String units, String volume) {
    return '$units units = $volume mL';
  }

  @override
  String editTime(String time) {
    return 'Edit time $time';
  }

  @override
  String get endWeekLabel => 'END WEEK';

  @override
  String get enterPeptideName => 'Enter peptide name';

  @override
  String get frequencyLabel => 'FREQUENCY';

  @override
  String get labelColorBody =>
      'Match this colour to the pen or vial label you use in real life.';

  @override
  String get labelColorLabel => 'LABEL COLOUR';

  @override
  String get manageSavedCompounds => 'Manage saved compounds';

  @override
  String get nextLabel => 'NEXT';

  @override
  String get noneLabel => 'None';

  @override
  String get oneOffCompound => 'One-off compound';

  @override
  String get oneOffCompoundBody => 'Use once without saving a preset';

  @override
  String get optionalLabel => 'Optional';

  @override
  String peptidesCount(int count) {
    return 'PEPTIDES ($count)';
  }

  @override
  String get perDayAmounts => 'Per-day amounts';

  @override
  String phaseExtendsWarning(int weeks) {
    return 'A phase extends beyond the $weeks-week cycle. Adjust the phase or cycle window.';
  }

  @override
  String get phaseNameHint => 'e.g. Week 1 tracking';

  @override
  String get phaseNameLabel => 'PHASE NAME';

  @override
  String phaseNumber(int number) {
    return 'Phase $number';
  }

  @override
  String phaseOutsideCycleError(int weeks) {
    return 'This protocol cycle ends after week $weeks. Keep phase weeks inside that window.';
  }

  @override
  String get phaseOverlapError => 'Phase week ranges cannot overlap.';

  @override
  String get phaseOverrideBody =>
      'Enter only the tracking schedule you already intend to follow. PepMod does not recommend amounts.';

  @override
  String get phaseOverrideTitle => 'Week-to-week override';

  @override
  String get phasePreviewDisclaimer =>
      'Preview of your entries only. No schedule is recommended by PepMod.';

  @override
  String get phasePreviewLabel => 'PHASE PREVIEW';

  @override
  String get phaseReminderBody =>
      'A neutral phase-change reminder is scheduled for 9:00 AM when protocol reminders are enabled.';

  @override
  String get phaseScheduleLabel => 'PHASE SCHEDULE';

  @override
  String get phaseSelectDayError =>
      'Select at least one day. PepMod will not choose a schedule for you.';

  @override
  String get phasesBody =>
      'Optional date windows can override this base amount and schedule. Outside them, the base schedule continues.';

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
      'Weeks are counted from the protocol start date. Saved phase notes and change reminders are tracking aids only.';

  @override
  String get preBlendedVial => 'Pre-blended vial';

  @override
  String get preBlendedVialBody => 'One vial · one draw · multiple compounds';

  @override
  String get protocolNotesBody =>
      'Save context you want visible when reviewing this protocol.';

  @override
  String get protocolNotesHint =>
      'e.g. questions, tracking context, or clinician notes';

  @override
  String get protocolNotesLabel => 'Protocol notes';

  @override
  String get reminderTimesBody =>
      'Each selected time creates its own tracking row and reminder on scheduled days.';

  @override
  String get reminderTimesLabel => 'REMINDER TIMES';

  @override
  String get removeLabel => 'REMOVE';

  @override
  String removePeptide(String name) {
    return 'Remove $name';
  }

  @override
  String get removePhase => 'Remove phase';

  @override
  String removeTime(String time) {
    return 'Remove time $time';
  }

  @override
  String get restWeeksLabel => 'REST WEEKS';

  @override
  String get reviewLabel => 'Review';

  @override
  String get routeLabel => 'ROUTE';

  @override
  String get saveBlend => 'SAVE BLEND';

  @override
  String get saveChanges => 'SAVE CHANGES';

  @override
  String get savePhase => 'SAVE PHASE';

  @override
  String savedVialPreset(String amount, String unit) {
    return '$amount $unit vial · Saved preset';
  }

  @override
  String get scheduleLabel => 'SCHEDULE';

  @override
  String get searchCompounds => 'Search compounds...';

  @override
  String get selectDayError =>
      'Select at least one day to schedule this peptide.';

  @override
  String selectOption(String option) {
    return 'Select $option';
  }

  @override
  String get startDateLabel => 'START DATE';

  @override
  String get startWeekLabel => 'START WEEK';

  @override
  String syringeUnitsAmount(String amount) {
    return '$amount syringe units';
  }

  @override
  String get syringeUnitsDisclaimer =>
      'Optional user-entered U-100 syringe markings for tracking only.';

  @override
  String get syringeUnitsHint => 'e.g. 12.5';

  @override
  String get syringeUnitsLabel => 'syringe units';

  @override
  String get syringeUnitsOptional => 'SYRINGE UNITS OPTIONAL';

  @override
  String get trackedAmountLabel => 'TRACKED AMOUNT';

  @override
  String get u100TrackingDisclaimer =>
      'Uses U-100 syringe markings (100 units = 1 mL). Values are user-entered tracking data.';

  @override
  String get unitLabel => 'UNIT';

  @override
  String get vialAmountHint => 'Vial amount';

  @override
  String get vialContentsLabel => 'VIAL CONTENTS';

  @override
  String get vialLabelNameHint => 'Name from vial label';

  @override
  String weekNumber(int week) {
    return 'WEEK $week';
  }

  @override
  String weekRange(int start, int end) {
    return 'WEEKS $start–$end';
  }

  @override
  String get weekToWeekPhases => 'WEEK-TO-WEEK PHASES';

  @override
  String weekdayDose(String weekday) {
    return '$weekday DOSE';
  }

  @override
  String weekdaySchedule(String weekday) {
    return '$weekday SCHEDULE';
  }

  @override
  String get doseDrawInvalid =>
      'Draw must be greater than zero and within the vial.';

  @override
  String get doseGenericError => 'Something went wrong. Try again.';

  @override
  String get doseEditSystemLabel => 'EDIT.DOSE';

  @override
  String get doseLogSystemLabel => 'LOG.DOSE';

  @override
  String get doseDraw => 'DRAW';

  @override
  String get doseAmount => 'AMOUNT';

  @override
  String get doseUnits => 'units';

  @override
  String get doseTime => 'TIME';

  @override
  String get doseChooseTime => 'Choose dose time';

  @override
  String get doseBlendSnapshot => 'BLEND SNAPSHOT // PER DRAW';

  @override
  String doseSyringeUnitsRecorded(String amount) {
    return '$amount syringe units recorded for this dose.';
  }

  @override
  String get doseInjectionSite => 'INJECTION.SITE';

  @override
  String doseLastSite(String site) {
    return 'LAST SITE FOR THIS PEPTIDE · $site';
  }

  @override
  String get doseNotes => 'NOTES';

  @override
  String get doseOptional => 'Optional...';

  @override
  String get doseMarkPending => 'MARK AS PENDING';

  @override
  String get doseSaveChanges => 'SAVE CHANGES';

  @override
  String get doseSkip => 'Skip this dose';

  @override
  String get doseHistorySystemLabel => 'DOSE.HISTORY // 30.DAY';

  @override
  String get doseHistoryTitle => 'Logged doses';

  @override
  String get doseHistoryBody =>
      'Tap a record to correct its amount, actual time, injection site, notes, or status.';

  @override
  String get doseHistoryEmpty => 'No logged doses in the last 30 days.';

  @override
  String get doseLogPrevious => 'LOG PREVIOUS DOSE';

  @override
  String doseHistorySkipped(String dateTime) {
    return 'Skipped · $dateTime';
  }

  @override
  String doseHistoryTaken(String amount, String units, String dateTime) {
    return '$amount $units · $dateTime';
  }

  @override
  String get doseEditAction => 'EDIT';

  @override
  String get doseChoosePastTime => 'Choose a past time to log.';

  @override
  String get dosePreviousError => 'Could not log previous dose. Try again.';

  @override
  String get doseLogPreviousSystemLabel => 'LOG.PREVIOUS';

  @override
  String get doseNoPeptides => 'No peptides available';

  @override
  String get doseNoPeptidesBody =>
      'Add a peptide to an active protocol before logging history.';

  @override
  String get doseCorrectHistory => 'Correct dose history';

  @override
  String get dosePeptide => 'PEPTIDE';

  @override
  String get doseDate => 'DATE';

  @override
  String get doseChooseDate => 'Choose dose date';

  @override
  String doseSyringeUnitsEntry(String amount) {
    return '$amount syringe units recorded for this entry.';
  }

  @override
  String get doseHistoryDisclaimer =>
      'Historical logs are personal tracking records only. They do not change medical guidance or dosing recommendations.';

  @override
  String get notificationChannelName => 'Dose Reminders';

  @override
  String get notificationChannelDescription =>
      'Scheduled reminders for your active peptide protocol doses.';

  @override
  String get notificationDoseTitle => 'Time for your dose';

  @override
  String get notificationDoseBody =>
      'Your scheduled protocol reminder is ready.';

  @override
  String get notificationCycleTitle => 'Protocol checkpoint';

  @override
  String get notificationCycleBody =>
      'A cycle-window reminder is due today. Review your tracking plan.';

  @override
  String get notificationRestTitle => 'Rest period checkpoint';

  @override
  String get notificationRestBody =>
      'A rest-period reminder is due today. Review your tracking plan.';

  @override
  String get notificationPhaseTitle => 'Protocol phase checkpoint';

  @override
  String get notificationPhaseBody =>
      'A new tracking phase starts today. Review your saved schedule.';

  @override
  String get personalLibrarySystemLabel => 'SYS.LIBRARY // PERSONAL';

  @override
  String get customCompoundIntro =>
      'Save labels and vial sizes you enter yourself. Presets are tracking shortcuts—not dose guidance.';

  @override
  String get archivedHeading => 'ARCHIVED';

  @override
  String get activePresetsHeading => 'ACTIVE PRESETS';

  @override
  String get showActive => 'Show active';

  @override
  String get archivedAction => 'Archived';

  @override
  String get customCompoundsLoadFailed =>
      'Could not load your compounds. Try again.';

  @override
  String get libraryLoadFailed =>
      'Could not load the peptide library. Try again.';

  @override
  String compoundVialSummary(String amount, String unit, String route) {
    return '$amount $unit vial · $route';
  }

  @override
  String get editPreset => 'Edit preset';

  @override
  String get restorePreset => 'Restore';

  @override
  String get archivePreset => 'Archive';

  @override
  String get noArchivedPresets => 'No archived presets';

  @override
  String get noSavedCompounds => 'No saved compounds';

  @override
  String get archivedPresetsHint =>
      'Archived presets stay here until you restore them.';

  @override
  String get createPresetHint =>
      'Create a reusable label and vial-size preset.';

  @override
  String get presetCompoundSystemLabel => 'PRESET.COMPOUND';

  @override
  String get newCompound => 'New compound';

  @override
  String get editCompound => 'Edit compound';

  @override
  String get ownVialDetailsHint =>
      'Enter only the details printed on your own vial.';

  @override
  String get compoundLabel => 'COMPOUND LABEL';

  @override
  String get compoundNameExample => 'e.g. My compound';

  @override
  String get vialUnitLabel => 'VIAL UNIT';

  @override
  String get trackingUnitLabel => 'TRACKING UNIT';

  @override
  String get notesOptional => 'NOTES OPTIONAL';

  @override
  String get compoundNoteExample => 'Label or storage note';

  @override
  String get noDoseRecommendation =>
      'No dosing recommendation is created. Protocol amounts are always entered separately by you.';

  @override
  String get saveCompoundFailed => 'Could not save preset. Try again.';

  @override
  String get routeTopical => 'Topical';

  @override
  String get frequencyCustomDays => 'Custom days';

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
    return 'U-100 · $volume mL / $capacity unit';
  }
}
