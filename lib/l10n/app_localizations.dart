import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('pt', 'BR'),
  ];

  /// Customer-facing app copy for libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryTitle;

  /// Customer-facing app copy for librarySystemLabel.
  ///
  /// In en, this message translates to:
  /// **'SYS.DATABASE // COMPOUNDS'**
  String get librarySystemLabel;

  /// Customer-facing app copy for myCompounds.
  ///
  /// In en, this message translates to:
  /// **'My compounds'**
  String get myCompounds;

  /// Customer-facing app copy for unitConverter.
  ///
  /// In en, this message translates to:
  /// **'Unit converter'**
  String get unitConverter;

  /// Customer-facing app copy for openUnitConverter.
  ///
  /// In en, this message translates to:
  /// **'Open unit converter'**
  String get openUnitConverter;

  /// Customer-facing app copy for converterCardTitle.
  ///
  /// In en, this message translates to:
  /// **'UNIT CONVERTER'**
  String get converterCardTitle;

  /// Customer-facing app copy for converterCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Convert vial math now'**
  String get converterCardSubtitle;

  /// Customer-facing app copy for converterCardHint.
  ///
  /// In en, this message translates to:
  /// **'For reconstitution, tap any peptide below.'**
  String get converterCardHint;

  /// Customer-facing app copy for searchPeptides.
  ///
  /// In en, this message translates to:
  /// **'Search peptides...'**
  String get searchPeptides;

  /// Customer-facing app copy for categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// Customer-facing app copy for categoryHealing.
  ///
  /// In en, this message translates to:
  /// **'Healing'**
  String get categoryHealing;

  /// Customer-facing app copy for categoryGrowthHormone.
  ///
  /// In en, this message translates to:
  /// **'Growth Hormone'**
  String get categoryGrowthHormone;

  /// Customer-facing app copy for categoryCognitive.
  ///
  /// In en, this message translates to:
  /// **'Cognitive'**
  String get categoryCognitive;

  /// Customer-facing app copy for categoryMetabolic.
  ///
  /// In en, this message translates to:
  /// **'Metabolic'**
  String get categoryMetabolic;

  /// Customer-facing app copy for categoryAesthetic.
  ///
  /// In en, this message translates to:
  /// **'Aesthetic'**
  String get categoryAesthetic;

  /// Customer-facing app copy for categoryLongevity.
  ///
  /// In en, this message translates to:
  /// **'Longevity'**
  String get categoryLongevity;

  /// Customer-facing app copy for categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// Customer-facing app copy for libraryUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Library unavailable'**
  String get libraryUnavailable;

  /// Customer-facing app copy for retry.
  ///
  /// In en, this message translates to:
  /// **'RETRY'**
  String get retry;

  /// Customer-facing app copy for noPeptidesFound.
  ///
  /// In en, this message translates to:
  /// **'No peptides found'**
  String get noPeptidesFound;

  /// Customer-facing app copy for tryDifferentSearch.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term or clear the filter.'**
  String get tryDifferentSearch;

  /// Customer-facing app copy for calculationSaved.
  ///
  /// In en, this message translates to:
  /// **'Calculation saved to this account.'**
  String get calculationSaved;

  /// Customer-facing app copy for converterIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter values from your own vial, diluent, and plan. PepMod converts those values into volume and U-100 syringe units.'**
  String get converterIntro;

  /// Customer-facing app copy for vialAndDiluent.
  ///
  /// In en, this message translates to:
  /// **'Vial + diluent'**
  String get vialAndDiluent;

  /// Customer-facing app copy for iuSourceCaption.
  ///
  /// In en, this message translates to:
  /// **'Source: IU on your vial and mL of diluent added.'**
  String get iuSourceCaption;

  /// Customer-facing app copy for massSourceCaption.
  ///
  /// In en, this message translates to:
  /// **'Source: labels on your vial and diluent.'**
  String get massSourceCaption;

  /// Customer-facing app copy for vialAmount.
  ///
  /// In en, this message translates to:
  /// **'VIAL AMOUNT'**
  String get vialAmount;

  /// Customer-facing app copy for amountPrintedOnVial.
  ///
  /// In en, this message translates to:
  /// **'Amount printed on vial'**
  String get amountPrintedOnVial;

  /// Customer-facing app copy for diluent.
  ///
  /// In en, this message translates to:
  /// **'DILUENT'**
  String get diluent;

  /// Customer-facing app copy for volumeAdded.
  ///
  /// In en, this message translates to:
  /// **'Volume you added'**
  String get volumeAdded;

  /// Customer-facing app copy for amountToConvert.
  ///
  /// In en, this message translates to:
  /// **'Amount to convert'**
  String get amountToConvert;

  /// Customer-facing app copy for iuAmountCaption.
  ///
  /// In en, this message translates to:
  /// **'Enter an IU amount you were already given.'**
  String get iuAmountCaption;

  /// Customer-facing app copy for massAmountCaption.
  ///
  /// In en, this message translates to:
  /// **'Source: an amount you were already given.'**
  String get massAmountCaption;

  /// Customer-facing app copy for yourSyringe.
  ///
  /// In en, this message translates to:
  /// **'Your syringe'**
  String get yourSyringe;

  /// Customer-facing app copy for syringeCaption.
  ///
  /// In en, this message translates to:
  /// **'Select the capacity printed on the barrel.'**
  String get syringeCaption;

  /// Customer-facing app copy for educationalConverterDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Educational unit-conversion tool only. PepMod does not recommend an amount or frequency. Recheck the source labels and confirm your calculation with a qualified healthcare professional before use.'**
  String get educationalConverterDisclaimer;

  /// Customer-facing app copy for back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Customer-facing app copy for vialWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Vial workspace'**
  String get vialWorkspace;

  /// Customer-facing app copy for conversionSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'UTIL.CONVERSION'**
  String get conversionSystemLabel;

  /// Customer-facing app copy for measurementModeSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'MEASUREMENT.MODE'**
  String get measurementModeSystemLabel;

  /// Customer-facing app copy for conversionResultSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'CONVERSION.RESULT'**
  String get conversionResultSystemLabel;

  /// Customer-facing app copy for savedVialsSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'SAVED.VIALS'**
  String get savedVialsSystemLabel;

  /// Customer-facing app copy for clear.
  ///
  /// In en, this message translates to:
  /// **'CLEAR'**
  String get clear;

  /// Customer-facing app copy for conversionOnly.
  ///
  /// In en, this message translates to:
  /// **'Conversion only — this workspace never chooses an amount or schedule.'**
  String get conversionOnly;

  /// Customer-facing app copy for sameUnitFamily.
  ///
  /// In en, this message translates to:
  /// **'Use the same unit family printed on the vial.'**
  String get sameUnitFamily;

  /// Customer-facing app copy for mass.
  ///
  /// In en, this message translates to:
  /// **'Mass'**
  String get mass;

  /// Customer-facing app copy for iuOnly.
  ///
  /// In en, this message translates to:
  /// **'IU only'**
  String get iuOnly;

  /// Customer-facing app copy for iuSafety.
  ///
  /// In en, this message translates to:
  /// **'IU stays IU. PepMod does not convert IU to or from mg/mcg.'**
  String get iuSafety;

  /// Customer-facing app copy for enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// Customer-facing app copy for drawTo.
  ///
  /// In en, this message translates to:
  /// **'DRAW TO'**
  String get drawTo;

  /// Customer-facing app copy for units.
  ///
  /// In en, this message translates to:
  /// **'units'**
  String get units;

  /// Customer-facing app copy for concentration.
  ///
  /// In en, this message translates to:
  /// **'CONCENTRATION'**
  String get concentration;

  /// Customer-facing app copy for syringeCapacity.
  ///
  /// In en, this message translates to:
  /// **'SYRINGE CAPACITY'**
  String get syringeCapacity;

  /// Customer-facing app copy for capacityWarning.
  ///
  /// In en, this message translates to:
  /// **'The converted volume is larger than this syringe capacity. Choose the correct syringe or recheck your entries.'**
  String get capacityWarning;

  /// Customer-facing app copy for savePreset.
  ///
  /// In en, this message translates to:
  /// **'SAVE PRESET'**
  String get savePreset;

  /// Customer-facing app copy for savedVialsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a saved calculation to reuse its inputs.'**
  String get savedVialsHint;

  /// Customer-facing app copy for removeSavedCalculation.
  ///
  /// In en, this message translates to:
  /// **'Remove saved calculation'**
  String get removeSavedCalculation;

  /// Customer-facing app copy for errorPositiveNumbers.
  ///
  /// In en, this message translates to:
  /// **'Enter a number greater than zero in every field.'**
  String get errorPositiveNumbers;

  /// Customer-facing app copy for errorAmountAboveVial.
  ///
  /// In en, this message translates to:
  /// **'Desired amount is greater than the amount entered for this vial.'**
  String get errorAmountAboveVial;

  /// Customer-facing app copy for errorConversion.
  ///
  /// In en, this message translates to:
  /// **'These values could not be converted. Recheck each entry.'**
  String get errorConversion;

  /// Customer-facing app copy for halfLife.
  ///
  /// In en, this message translates to:
  /// **'Half-life'**
  String get halfLife;

  /// Customer-facing app copy for weekCycle.
  ///
  /// In en, this message translates to:
  /// **'wk cycle'**
  String get weekCycle;

  /// Customer-facing app copy for typicalDose.
  ///
  /// In en, this message translates to:
  /// **'TYPICAL DOSE'**
  String get typicalDose;

  /// Customer-facing app copy for notes.
  ///
  /// In en, this message translates to:
  /// **'NOTES'**
  String get notes;

  /// Customer-facing app copy for commonStack.
  ///
  /// In en, this message translates to:
  /// **'COMMON.STACK'**
  String get commonStack;

  /// Customer-facing app copy for reconstitutionTool.
  ///
  /// In en, this message translates to:
  /// **'UTIL.RECONSTITUTION'**
  String get reconstitutionTool;

  /// Customer-facing app copy for compoundSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'DB.COMPOUND'**
  String get compoundSystemLabel;

  /// Customer-facing app copy for addToProtocol.
  ///
  /// In en, this message translates to:
  /// **'ADD TO PROTOCOL'**
  String get addToProtocol;

  /// Customer-facing app copy for vialShort.
  ///
  /// In en, this message translates to:
  /// **'VIAL (mg)'**
  String get vialShort;

  /// Customer-facing app copy for bacShort.
  ///
  /// In en, this message translates to:
  /// **'BAC (mL)'**
  String get bacShort;

  /// Customer-facing app copy for doseShort.
  ///
  /// In en, this message translates to:
  /// **'DOSE (mcg)'**
  String get doseShort;

  /// Customer-facing app copy for routeSubcutaneous.
  ///
  /// In en, this message translates to:
  /// **'Subcutaneous'**
  String get routeSubcutaneous;

  /// Customer-facing app copy for routeIntramuscular.
  ///
  /// In en, this message translates to:
  /// **'Intramuscular'**
  String get routeIntramuscular;

  /// Customer-facing app copy for routeOral.
  ///
  /// In en, this message translates to:
  /// **'Oral'**
  String get routeOral;

  /// Customer-facing app copy for routeNasal.
  ///
  /// In en, this message translates to:
  /// **'Nasal'**
  String get routeNasal;

  /// Customer-facing app copy for frequencyDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get frequencyDaily;

  /// Customer-facing app copy for frequencyEveryOtherDay.
  ///
  /// In en, this message translates to:
  /// **'Every other day'**
  String get frequencyEveryOtherDay;

  /// Customer-facing app copy for frequencyTwiceWeekly.
  ///
  /// In en, this message translates to:
  /// **'2x per week'**
  String get frequencyTwiceWeekly;

  /// Customer-facing app copy for frequencyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get frequencyWeekly;

  /// Customer-facing app copy for frequencyAsNeeded.
  ///
  /// In en, this message translates to:
  /// **'As needed'**
  String get frequencyAsNeeded;

  /// Customer-facing app copy for tabProtocol.
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get tabProtocol;

  /// Customer-facing app copy for tabProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get tabProgress;

  /// Customer-facing app copy for tabLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get tabLibrary;

  /// Customer-facing app copy for tabYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get tabYou;

  /// English onboarding copy for continue label.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continueLabel;

  /// Customer-facing app copy for processingLabel.
  ///
  /// In en, this message translates to:
  /// **'PROCESSING…'**
  String get processingLabel;

  /// Customer-facing app copy for authAppleFailed.
  ///
  /// In en, this message translates to:
  /// **'Apple sign-in failed. Please try again.'**
  String get authAppleFailed;

  /// Customer-facing app copy for authGoogleFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed. Please try again.'**
  String get authGoogleFailed;

  /// Customer-facing app copy for authGenericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authGenericError;

  /// Customer-facing app copy for authUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email address.'**
  String get authUserNotFound;

  /// Customer-facing app copy for authIncorrectCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get authIncorrectCredentials;

  /// Customer-facing app copy for authAccountExists.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email.'**
  String get authAccountExists;

  /// Customer-facing app copy for authWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Use at least 6 characters.'**
  String get authWeakPassword;

  /// Customer-facing app copy for authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get authInvalidEmail;

  /// Customer-facing app copy for authAppleUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple is not enabled for this app.'**
  String get authAppleUnavailable;

  /// Customer-facing app copy for authRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Save your personalised\nprotocol'**
  String get authRequiredTitle;

  /// Customer-facing app copy for authRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'Keep your roadmap, schedule, dose logs, and reminders attached to your account before the protocol unlocks.'**
  String get authRequiredBody;

  /// Customer-facing app copy for continueWithEmail.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE WITH EMAIL'**
  String get continueWithEmail;

  /// Customer-facing app copy for signInWithApple.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN WITH APPLE'**
  String get signInWithApple;

  /// Customer-facing app copy for continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE WITH GOOGLE'**
  String get continueWithGoogle;

  /// Customer-facing app copy for authTermsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'By continuing you accept our Terms and Privacy Policy. PepMod is an educational tool — not medical advice.'**
  String get authTermsDisclaimer;

  /// Customer-facing app copy for signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// Customer-facing app copy for createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// Customer-facing app copy for resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// Customer-facing app copy for signInAction.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signInAction;

  /// Customer-facing app copy for createAccountAction.
  ///
  /// In en, this message translates to:
  /// **'CREATE ACCOUNT'**
  String get createAccountAction;

  /// Customer-facing app copy for sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'SEND RESET LINK'**
  String get sendResetLink;

  /// Customer-facing app copy for passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent. Check your inbox.'**
  String get passwordResetSent;

  /// Customer-facing app copy for enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// Customer-facing app copy for enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// Customer-facing app copy for enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get enterPassword;

  /// Customer-facing app copy for passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get passwordMinLength;

  /// Customer-facing app copy for forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Customer-facing app copy for alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get alreadyHaveAccount;

  /// Customer-facing app copy for backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToSignIn;

  /// Customer-facing app copy for emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Customer-facing app copy for passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Customer-facing app copy for showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// Customer-facing app copy for hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// Customer-facing app copy for accountDeletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Account deleted'**
  String get accountDeletedTitle;

  /// Customer-facing app copy for accountDeletedBody.
  ///
  /// In en, this message translates to:
  /// **'Your PepMod account and saved app data have been removed.'**
  String get accountDeletedBody;

  /// Customer-facing app copy for subscriptionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Subscription plans are not available right now. Please try again.'**
  String get subscriptionUnavailable;

  /// Customer-facing app copy for upgradeUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Upgrade is not available right now. Please try again later.'**
  String get upgradeUnavailable;

  /// Customer-facing app copy for noPurchasesToRestore.
  ///
  /// In en, this message translates to:
  /// **'No purchases found to restore.'**
  String get noPurchasesToRestore;

  /// Shown when the subscription SDK is not ready or configured.
  ///
  /// In en, this message translates to:
  /// **'Purchases are temporarily unavailable. Please try again shortly.'**
  String get subscriptionErrorServiceUnavailable;

  /// Shown when available subscription plans cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'Subscription plans could not be loaded. Check your connection and try again.'**
  String get subscriptionErrorPlansUnavailable;

  /// Shown when a customer cancels the store purchase flow. Normally suppressed by paywall UI.
  ///
  /// In en, this message translates to:
  /// **'Purchase cancelled.'**
  String get subscriptionErrorPurchaseCancelled;

  /// Shown when device or account restrictions prevent purchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases are not allowed on this device.'**
  String get subscriptionErrorPurchaseNotAllowed;

  /// Shown when the app store rejects a purchase as invalid.
  ///
  /// In en, this message translates to:
  /// **'The purchase could not be completed. Please check your account and try again.'**
  String get subscriptionErrorPurchaseInvalid;

  /// Shown when the selected store subscription product is unavailable.
  ///
  /// In en, this message translates to:
  /// **'This subscription is not available right now. Please choose another plan or try again later.'**
  String get subscriptionErrorProductUnavailable;

  /// Shown when a subscription purchase fails because of network connectivity.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Check your connection and try again.'**
  String get subscriptionErrorNetwork;

  /// Generic purchase failure shown when no more specific customer-safe cause is available.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed. Please try again.'**
  String get subscriptionErrorPurchaseFailed;

  /// Shown when restoring previous purchases fails.
  ///
  /// In en, this message translates to:
  /// **'Purchases could not be restored. Check your connection and try again.'**
  String get subscriptionErrorRestoreFailed;

  /// Customer-facing app copy for unlockFullProtocol.
  ///
  /// In en, this message translates to:
  /// **'Unlock the full protocol'**
  String get unlockFullProtocol;

  /// Customer-facing app copy for premiumUnlimitedPeptides.
  ///
  /// In en, this message translates to:
  /// **'Unlimited peptides per protocol'**
  String get premiumUnlimitedPeptides;

  /// Customer-facing app copy for premiumMultipleProtocols.
  ///
  /// In en, this message translates to:
  /// **'Multiple active protocols'**
  String get premiumMultipleProtocols;

  /// Customer-facing app copy for premiumCalculator.
  ///
  /// In en, this message translates to:
  /// **'Reconstitution calculator (all peptides)'**
  String get premiumCalculator;

  /// Customer-facing app copy for premiumMetrics.
  ///
  /// In en, this message translates to:
  /// **'Body metric tracking + charts'**
  String get premiumMetrics;

  /// Customer-facing app copy for upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'UPGRADE NOW'**
  String get upgradeNow;

  /// Customer-facing app copy for restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// Customer-facing app copy for notRightNow.
  ///
  /// In en, this message translates to:
  /// **'Not right now'**
  String get notRightNow;

  /// Tooltip for opening the weekly planner.
  ///
  /// In en, this message translates to:
  /// **'Weekly planner'**
  String get protocolWeeklyPlanner;

  /// Tooltip for opening dose history.
  ///
  /// In en, this message translates to:
  /// **'Dose history'**
  String get protocolDoseHistory;

  /// Tooltip for creating a protocol.
  ///
  /// In en, this message translates to:
  /// **'Create protocol'**
  String get protocolCreate;

  /// Action that opens protocol management.
  ///
  /// In en, this message translates to:
  /// **'MANAGE'**
  String get protocolManage;

  /// Heading above the empty protocol state.
  ///
  /// In en, this message translates to:
  /// **'Your Protocol'**
  String get protocolYourProtocol;

  /// Title when no protocol is active.
  ///
  /// In en, this message translates to:
  /// **'No active protocol'**
  String get protocolNoActive;

  /// Guidance when no protocol is active.
  ///
  /// In en, this message translates to:
  /// **'Create your first protocol to start tracking doses and building adherence.'**
  String get protocolNoActiveBody;

  /// Action to create the first protocol.
  ///
  /// In en, this message translates to:
  /// **'START FIRST PROTOCOL'**
  String get protocolStartFirst;

  /// System-style label above today's dose schedule.
  ///
  /// In en, this message translates to:
  /// **'SCHEDULE // TODAY'**
  String get protocolScheduleTodaySystemLabel;

  /// System-style label above today's adherence summary.
  ///
  /// In en, this message translates to:
  /// **'ADHERENCE // TODAY'**
  String get protocolAdherenceTodaySystemLabel;

  /// Message when today has no scheduled doses.
  ///
  /// In en, this message translates to:
  /// **'No doses scheduled today'**
  String get protocolNoDosesScheduledToday;

  /// Summary of completed doses today.
  ///
  /// In en, this message translates to:
  /// **'{taken} of {total} doses taken'**
  String protocolDosesTaken(int taken, int total);

  /// Heading for the next scheduled dose.
  ///
  /// In en, this message translates to:
  /// **'NEXT DOSE'**
  String get protocolNextDose;

  /// Countdown until the next dose.
  ///
  /// In en, this message translates to:
  /// **'In {duration}'**
  String protocolInTime(String duration);

  /// Compact countdown duration containing hours and minutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String protocolDurationHoursMinutes(int hours, int minutes);

  /// Compact countdown duration containing minutes only.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String protocolDurationMinutes(int minutes);

  /// Action to record a dose.
  ///
  /// In en, this message translates to:
  /// **'LOG DOSE'**
  String get protocolLogDose;

  /// Countdown label when a dose is due now.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get protocolNow;

  /// Status for a missed dose.
  ///
  /// In en, this message translates to:
  /// **'MISSED'**
  String get protocolMissed;

  /// Status for a skipped dose.
  ///
  /// In en, this message translates to:
  /// **'SKIPPED'**
  String get protocolSkipped;

  /// Empty-card title for no doses today.
  ///
  /// In en, this message translates to:
  /// **'No doses today'**
  String get protocolNoDosesToday;

  /// Empty-card detail for no doses today.
  ///
  /// In en, this message translates to:
  /// **'Your protocol has no doses scheduled for today.'**
  String get protocolNoDosesTodayBody;

  /// Upgrade explanation when the free protocol limit is reached.
  ///
  /// In en, this message translates to:
  /// **'Free plan is limited to one protocol. Upgrade to Premium to run multiple stacks at once.'**
  String get protocolFreeLimit;

  /// Syringe-unit detail appended to a dose amount.
  ///
  /// In en, this message translates to:
  /// **' · {amount} syringe units'**
  String protocolSyringeUnitsSuffix(String amount);

  /// Display name for the left abdomen injection site.
  ///
  /// In en, this message translates to:
  /// **'Left Abdomen'**
  String get injectionSiteLeftAbdomen;

  /// Display name for the right abdomen injection site.
  ///
  /// In en, this message translates to:
  /// **'Right Abdomen'**
  String get injectionSiteRightAbdomen;

  /// Display name for the left thigh injection site.
  ///
  /// In en, this message translates to:
  /// **'Left Thigh'**
  String get injectionSiteLeftThigh;

  /// Display name for the right thigh injection site.
  ///
  /// In en, this message translates to:
  /// **'Right Thigh'**
  String get injectionSiteRightThigh;

  /// Display name for the left glute injection site.
  ///
  /// In en, this message translates to:
  /// **'Left Glute'**
  String get injectionSiteLeftGlute;

  /// Display name for the right glute injection site.
  ///
  /// In en, this message translates to:
  /// **'Right Glute'**
  String get injectionSiteRightGlute;

  /// Display name for the left triceps injection site.
  ///
  /// In en, this message translates to:
  /// **'Left Triceps'**
  String get injectionSiteLeftTriceps;

  /// Display name for the right triceps injection site.
  ///
  /// In en, this message translates to:
  /// **'Right Triceps'**
  String get injectionSiteRightTriceps;

  /// Display name for the left deltoid injection site.
  ///
  /// In en, this message translates to:
  /// **'Left Deltoid'**
  String get injectionSiteLeftDeltoid;

  /// Display name for the right deltoid injection site.
  ///
  /// In en, this message translates to:
  /// **'Right Deltoid'**
  String get injectionSiteRightDeltoid;

  /// Action that returns the planner to today.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get plannerToday;

  /// Tooltip for leaving the weekly planner.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get plannerBack;

  /// Tooltip for moving to the previous week.
  ///
  /// In en, this message translates to:
  /// **'Previous week'**
  String get plannerPreviousWeek;

  /// Tooltip for moving to the next week.
  ///
  /// In en, this message translates to:
  /// **'Next week'**
  String get plannerNextWeek;

  /// Accessible count of doses scheduled for a calendar day.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} scheduled dose} other{{count} scheduled doses}}'**
  String plannerScheduledCount(int count);

  /// Safety note below the weekly planner.
  ///
  /// In en, this message translates to:
  /// **'Tracking only. This calendar reflects your saved protocol and does not provide dosing advice.'**
  String get plannerTrackingDisclaimer;

  /// Label for a washout period without an end date.
  ///
  /// In en, this message translates to:
  /// **'Washout period'**
  String get plannerWashoutPeriod;

  /// End date shown for a saved washout window.
  ///
  /// In en, this message translates to:
  /// **'Washout until {date}'**
  String plannerWashoutUntil(String date);

  /// Title when a planner day has no doses.
  ///
  /// In en, this message translates to:
  /// **'No scheduled doses'**
  String get plannerNoScheduledDoses;

  /// Detail when a planner day has no doses.
  ///
  /// In en, this message translates to:
  /// **'Nothing is planned from your saved protocols.'**
  String get plannerNothingPlanned;

  /// English onboarding copy for activate pro.
  ///
  /// In en, this message translates to:
  /// **'ACTIVATE PRO'**
  String get activatePro;

  /// English onboarding copy for activate pro price.
  ///
  /// In en, this message translates to:
  /// **'ACTIVATE PRO — {price}/year'**
  String activateProPrice(String price);

  /// English onboarding copy for annual access.
  ///
  /// In en, this message translates to:
  /// **'Annual access'**
  String get annualAccess;

  /// English onboarding copy for annual label.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get annualLabel;

  /// English onboarding copy for average rating.
  ///
  /// In en, this message translates to:
  /// **'AVG RATING'**
  String get averageRating;

  /// English onboarding copy for bac water label.
  ///
  /// In en, this message translates to:
  /// **'BAC WATER'**
  String get bacWaterLabel;

  /// English onboarding copy for based on inputs.
  ///
  /// In en, this message translates to:
  /// **'Based on your inputs //'**
  String get basedOnInputs;

  /// English onboarding copy for best value.
  ///
  /// In en, this message translates to:
  /// **'Best Value'**
  String get bestValue;

  /// English onboarding copy for birth date invalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid date for someone aged 18 or older.'**
  String get birthDateInvalid;

  /// English onboarding copy for birth date valid.
  ///
  /// In en, this message translates to:
  /// **'Age verified'**
  String get birthDateValid;

  /// English onboarding copy for calculator demo body.
  ///
  /// In en, this message translates to:
  /// **'Here’s how it works with {peptideName}'**
  String calculatorDemoBody(String peptideName);

  /// English onboarding copy for calculator demo result.
  ///
  /// In en, this message translates to:
  /// **'That’s it. Enter your values,\nget exact syringe units.'**
  String get calculatorDemoResult;

  /// English onboarding copy for calculator demo title.
  ///
  /// In en, this message translates to:
  /// **'No more\nscary math.'**
  String get calculatorDemoTitle;

  /// English onboarding copy for confidence cycle timing.
  ///
  /// In en, this message translates to:
  /// **'Cycle timing'**
  String get confidenceCycleTiming;

  /// English onboarding copy for confidence cycle timing detail.
  ///
  /// In en, this message translates to:
  /// **'See protocol dates and schedule windows clearly'**
  String get confidenceCycleTimingDetail;

  /// English onboarding copy for confidence dose math.
  ///
  /// In en, this message translates to:
  /// **'Dose math'**
  String get confidenceDoseMath;

  /// English onboarding copy for confidence dose math detail.
  ///
  /// In en, this message translates to:
  /// **'Keep vial, water, dose, and draw units together'**
  String get confidenceDoseMathDetail;

  /// English onboarding copy for confidence label.
  ///
  /// In en, this message translates to:
  /// **'CONFIDENCE'**
  String get confidenceLabel;

  /// English onboarding copy for confidence plain info.
  ///
  /// In en, this message translates to:
  /// **'Plain-language information'**
  String get confidencePlainInfo;

  /// English onboarding copy for confidence plain info detail.
  ///
  /// In en, this message translates to:
  /// **'Read research notes without the clutter'**
  String get confidencePlainInfoDetail;

  /// English onboarding copy for confidence progress signals.
  ///
  /// In en, this message translates to:
  /// **'Progress signals'**
  String get confidenceProgressSignals;

  /// English onboarding copy for confidence progress signals detail.
  ///
  /// In en, this message translates to:
  /// **'See adherence and body metrics over time'**
  String get confidenceProgressSignalsDetail;

  /// English onboarding copy for confidence safety framing.
  ///
  /// In en, this message translates to:
  /// **'Safety framing'**
  String get confidenceSafetyFraming;

  /// English onboarding copy for confidence safety framing detail.
  ///
  /// In en, this message translates to:
  /// **'Keep educational guidance and disclaimers visible'**
  String get confidenceSafetyFramingDetail;

  /// English onboarding copy for confidence site rotation.
  ///
  /// In en, this message translates to:
  /// **'Site rotation'**
  String get confidenceSiteRotation;

  /// English onboarding copy for confidence site rotation detail.
  ///
  /// In en, this message translates to:
  /// **'Remember where each dose was logged'**
  String get confidenceSiteRotationDetail;

  /// English onboarding copy for connecting to store.
  ///
  /// In en, this message translates to:
  /// **'CONNECTING TO STORE...'**
  String get connectingToStore;

  /// English onboarding copy for continue selected.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE ({count})'**
  String continueSelected(int count);

  /// English onboarding copy for custom protocol.
  ///
  /// In en, this message translates to:
  /// **'Custom Protocol'**
  String get customProtocol;

  /// English onboarding copy for date of birth label.
  ///
  /// In en, this message translates to:
  /// **'DATE OF BIRTH'**
  String get dateOfBirthLabel;

  /// English onboarding copy for day one.
  ///
  /// In en, this message translates to:
  /// **'DAY 1'**
  String get dayOne;

  /// English onboarding copy for day short label.
  ///
  /// In en, this message translates to:
  /// **'DD'**
  String get dayShortLabel;

  /// English onboarding copy for default confidence.
  ///
  /// In en, this message translates to:
  /// **'Dose math · Site rotation'**
  String get defaultConfidence;

  /// English onboarding copy for default frustration.
  ///
  /// In en, this message translates to:
  /// **'Missing doses'**
  String get defaultFrustration;

  /// English onboarding copy for default goals.
  ///
  /// In en, this message translates to:
  /// **'Recovery · Longevity'**
  String get defaultGoals;

  /// English onboarding copy for dose label.
  ///
  /// In en, this message translates to:
  /// **'DOSE'**
  String get doseLabel;

  /// English onboarding copy for doses logged.
  ///
  /// In en, this message translates to:
  /// **'DOSES LOGGED'**
  String get dosesLogged;

  /// English onboarding copy for doses per day.
  ///
  /// In en, this message translates to:
  /// **'DOSES/DAY'**
  String get dosesPerDay;

  /// English onboarding copy for draw volume label.
  ///
  /// In en, this message translates to:
  /// **'DRAW VOLUME'**
  String get drawVolumeLabel;

  /// English onboarding copy for duration label.
  ///
  /// In en, this message translates to:
  /// **'DURATION'**
  String get durationLabel;

  /// English onboarding copy for experience advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get experienceAdvanced;

  /// English onboarding copy for experience advanced detail.
  ///
  /// In en, this message translates to:
  /// **'I’m comfortable managing detailed protocols'**
  String get experienceAdvancedDetail;

  /// English onboarding copy for experience first time.
  ///
  /// In en, this message translates to:
  /// **'First time'**
  String get experienceFirstTime;

  /// English onboarding copy for experience first time detail.
  ///
  /// In en, this message translates to:
  /// **'I’m new to peptide tracking'**
  String get experienceFirstTimeDetail;

  /// English onboarding copy for experience intermediate.
  ///
  /// In en, this message translates to:
  /// **'INTERMEDIATE'**
  String get experienceIntermediate;

  /// English onboarding copy for experience label.
  ///
  /// In en, this message translates to:
  /// **'EXPERIENCE'**
  String get experienceLabel;

  /// English onboarding copy for experience novice.
  ///
  /// In en, this message translates to:
  /// **'NOVICE'**
  String get experienceNovice;

  /// English onboarding copy for experience some.
  ///
  /// In en, this message translates to:
  /// **'Some experience'**
  String get experienceSome;

  /// English onboarding copy for experience some detail.
  ///
  /// In en, this message translates to:
  /// **'I’ve tracked one or two protocols'**
  String get experienceSomeDetail;

  /// English onboarding copy for experience veteran.
  ///
  /// In en, this message translates to:
  /// **'VETERAN'**
  String get experienceVeteran;

  /// English onboarding copy for feature dose math body.
  ///
  /// In en, this message translates to:
  /// **'Keep vial size, water volume, dose, and units-to-draw beside the protocol you are actually tracking.'**
  String get featureDoseMathBody;

  /// English onboarding copy for feature dose math title.
  ///
  /// In en, this message translates to:
  /// **'Dose Math\nIn Context'**
  String get featureDoseMathTitle;

  /// English onboarding copy for feature protocol arc body.
  ///
  /// In en, this message translates to:
  /// **'See planned doses, logged doses, adherence, and body metrics build into one timeline.'**
  String get featureProtocolArcBody;

  /// English onboarding copy for feature protocol arc title.
  ///
  /// In en, this message translates to:
  /// **'Protocol Arc\nOver Time'**
  String get featureProtocolArcTitle;

  /// English onboarding copy for feature showcase title.
  ///
  /// In en, this message translates to:
  /// **'Everything you need.\nOne app.'**
  String get featureShowcaseTitle;

  /// English onboarding copy for feature site rotation body.
  ///
  /// In en, this message translates to:
  /// **'Remember every site you log and keep rotation history attached to the dose record.'**
  String get featureSiteRotationBody;

  /// English onboarding copy for feature site rotation title.
  ///
  /// In en, this message translates to:
  /// **'Injection Site\nRotation'**
  String get featureSiteRotationTitle;

  /// English onboarding copy for first name example.
  ///
  /// In en, this message translates to:
  /// **'e.g. Alex'**
  String get firstNameExample;

  /// English onboarding copy for first name label.
  ///
  /// In en, this message translates to:
  /// **'FIRST NAME'**
  String get firstNameLabel;

  /// English onboarding copy for frustration forgetting.
  ///
  /// In en, this message translates to:
  /// **'Forgetting doses'**
  String get frustrationForgetting;

  /// English onboarding copy for frustration label.
  ///
  /// In en, this message translates to:
  /// **'FRUSTRATION'**
  String get frustrationLabel;

  /// English onboarding copy for frustration math.
  ///
  /// In en, this message translates to:
  /// **'Vial and syringe math'**
  String get frustrationMath;

  /// English onboarding copy for frustration progress.
  ///
  /// In en, this message translates to:
  /// **'Seeing whether I’m consistent'**
  String get frustrationProgress;

  /// English onboarding copy for frustration schedule.
  ///
  /// In en, this message translates to:
  /// **'Keeping the schedule straight'**
  String get frustrationSchedule;

  /// English onboarding copy for frustration stacking.
  ///
  /// In en, this message translates to:
  /// **'Managing multiple peptides'**
  String get frustrationStacking;

  /// English onboarding copy for frustration trust.
  ///
  /// In en, this message translates to:
  /// **'Finding trustworthy information'**
  String get frustrationTrust;

  /// English onboarding copy for goal anti aging.
  ///
  /// In en, this message translates to:
  /// **'Healthy ageing'**
  String get goalAntiAging;

  /// English onboarding copy for goal anti aging detail.
  ///
  /// In en, this message translates to:
  /// **'Organise longevity-focused records'**
  String get goalAntiAgingDetail;

  /// English onboarding copy for goal cognitive.
  ///
  /// In en, this message translates to:
  /// **'Cognitive support'**
  String get goalCognitive;

  /// English onboarding copy for goal cognitive detail.
  ///
  /// In en, this message translates to:
  /// **'Monitor focus and mental performance'**
  String get goalCognitiveDetail;

  /// English onboarding copy for goal immune.
  ///
  /// In en, this message translates to:
  /// **'Immune support'**
  String get goalImmune;

  /// English onboarding copy for goal immune detail.
  ///
  /// In en, this message translates to:
  /// **'Keep immune-focused protocols organised'**
  String get goalImmuneDetail;

  /// English onboarding copy for goal muscle growth.
  ///
  /// In en, this message translates to:
  /// **'Muscle growth'**
  String get goalMuscleGrowth;

  /// English onboarding copy for goal muscle growth detail.
  ///
  /// In en, this message translates to:
  /// **'Track training and growth goals'**
  String get goalMuscleGrowthDetail;

  /// English onboarding copy for goal other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get goalOther;

  /// English onboarding copy for goal other detail.
  ///
  /// In en, this message translates to:
  /// **'Set up a different tracking goal'**
  String get goalOtherDetail;

  /// English onboarding copy for goal recovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get goalRecovery;

  /// English onboarding copy for goal recovery detail.
  ///
  /// In en, this message translates to:
  /// **'Support recovery records and routines'**
  String get goalRecoveryDetail;

  /// English onboarding copy for goal sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get goalSleep;

  /// English onboarding copy for goal sleep detail.
  ///
  /// In en, this message translates to:
  /// **'Track sleep-related goals and patterns'**
  String get goalSleepDetail;

  /// English onboarding copy for goal weight loss.
  ///
  /// In en, this message translates to:
  /// **'Weight loss'**
  String get goalWeightLoss;

  /// English onboarding copy for goal weight loss detail.
  ///
  /// In en, this message translates to:
  /// **'Track metabolic goals and progress'**
  String get goalWeightLossDetail;

  /// English onboarding copy for goals label.
  ///
  /// In en, this message translates to:
  /// **'GOALS'**
  String get goalsLabel;

  /// English onboarding copy for i understand.
  ///
  /// In en, this message translates to:
  /// **'I UNDERSTAND'**
  String get iUnderstand;

  /// English onboarding copy for last three days ago.
  ///
  /// In en, this message translates to:
  /// **'Last: 3 days ago'**
  String get lastThreeDaysAgo;

  /// English onboarding copy for left abdomen.
  ///
  /// In en, this message translates to:
  /// **'Left abdomen'**
  String get leftAbdomen;

  /// English onboarding copy for love it.
  ///
  /// In en, this message translates to:
  /// **'LOVE IT'**
  String get loveIt;

  /// English onboarding copy for maybe later.
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get maybeLater;

  /// English onboarding copy for month one.
  ///
  /// In en, this message translates to:
  /// **'MONTH 1'**
  String get monthOne;

  /// English onboarding copy for month short label.
  ///
  /// In en, this message translates to:
  /// **'MM'**
  String get monthShortLabel;

  /// English onboarding copy for month two.
  ///
  /// In en, this message translates to:
  /// **'MONTH 2'**
  String get monthTwo;

  /// English onboarding copy for more count.
  ///
  /// In en, this message translates to:
  /// **'{shown} +{count} more'**
  String moreCount(String shown, int count);

  /// English onboarding copy for needs work.
  ///
  /// In en, this message translates to:
  /// **'NEEDS WORK'**
  String get needsWork;

  /// English onboarding copy for notification body.
  ///
  /// In en, this message translates to:
  /// **'Get discreet reminders when a scheduled protocol window is due. No peptide names in notifications — just a gentle nudge.'**
  String get notificationBody;

  /// English onboarding copy for notification title.
  ///
  /// In en, this message translates to:
  /// **'Keep dose times\nvisible.'**
  String get notificationTitle;

  /// English onboarding copy for now label.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get nowLabel;

  /// English onboarding copy for ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// English onboarding copy for onboarding age confirmed.
  ///
  /// In en, this message translates to:
  /// **'I’M 18 OR OLDER'**
  String get onboardingAgeConfirmed;

  /// English onboarding copy for onboarding age requirement body.
  ///
  /// In en, this message translates to:
  /// **'You must be 18 or older to use PepMod.'**
  String get onboardingAgeRequirementBody;

  /// English onboarding copy for onboarding age requirement title.
  ///
  /// In en, this message translates to:
  /// **'Age requirement'**
  String get onboardingAgeRequirementTitle;

  /// English onboarding copy for onboarding age verification body.
  ///
  /// In en, this message translates to:
  /// **'PepMod is intended for adults aged 18 and over.'**
  String get onboardingAgeVerificationBody;

  /// English onboarding copy for onboarding age verification title.
  ///
  /// In en, this message translates to:
  /// **'First, confirm\nyour age.'**
  String get onboardingAgeVerificationTitle;

  /// English onboarding copy for onboarding ahead body.
  ///
  /// In en, this message translates to:
  /// **'Answer a few questions and PepMod will organise a personalised tracking preview.'**
  String get onboardingAheadBody;

  /// English onboarding copy for onboarding ahead title.
  ///
  /// In en, this message translates to:
  /// **'See your protocol\nbefore you start.'**
  String get onboardingAheadTitle;

  /// English onboarding copy for onboarding birth date body.
  ///
  /// In en, this message translates to:
  /// **'This confirms you meet the age requirement.'**
  String get onboardingBirthDateBody;

  /// English onboarding copy for onboarding birth date title.
  ///
  /// In en, this message translates to:
  /// **'When were\nyou born?'**
  String get onboardingBirthDateTitle;

  /// English onboarding copy for onboarding confidence body.
  ///
  /// In en, this message translates to:
  /// **'Choose everything PepMod should make clearer.'**
  String get onboardingConfidenceBody;

  /// English onboarding copy for onboarding confidence title.
  ///
  /// In en, this message translates to:
  /// **'Where do you want\nmore confidence?'**
  String get onboardingConfidenceTitle;

  /// English onboarding copy for onboarding conversion value body.
  ///
  /// In en, this message translates to:
  /// **'Convert the values from your vial and plan into volume and syringe units.'**
  String get onboardingConversionValueBody;

  /// English onboarding copy for onboarding conversion value title.
  ///
  /// In en, this message translates to:
  /// **'Make vial math\neasier to check.'**
  String get onboardingConversionValueTitle;

  /// English onboarding copy for onboarding disclaimer body.
  ///
  /// In en, this message translates to:
  /// **'PepMod helps organise records, reminders, and unit conversions. It does not diagnose, prescribe, or replace qualified healthcare advice.'**
  String get onboardingDisclaimerBody;

  /// English onboarding copy for onboarding disclaimer title.
  ///
  /// In en, this message translates to:
  /// **'Built for clarity.\nNot prescriptions.'**
  String get onboardingDisclaimerTitle;

  /// English onboarding copy for onboarding experience title.
  ///
  /// In en, this message translates to:
  /// **'How experienced\nare you?'**
  String get onboardingExperienceTitle;

  /// English onboarding copy for onboarding frustration body.
  ///
  /// In en, this message translates to:
  /// **'Pick the biggest friction point.'**
  String get onboardingFrustrationBody;

  /// English onboarding copy for onboarding frustration title.
  ///
  /// In en, this message translates to:
  /// **'What feels\nhardest today?'**
  String get onboardingFrustrationTitle;

  /// English onboarding copy for onboarding goals title.
  ///
  /// In en, this message translates to:
  /// **'What are your\nmain goals?'**
  String get onboardingGoalsTitle;

  /// English onboarding copy for onboarding guided start body.
  ///
  /// In en, this message translates to:
  /// **'We’ll tailor the setup to your goals, experience, and the records you want to keep.'**
  String get onboardingGuidedStartBody;

  /// English onboarding copy for onboarding guided start title.
  ///
  /// In en, this message translates to:
  /// **'A guided start,\nbuilt around you.'**
  String get onboardingGuidedStartTitle;

  /// English onboarding copy for onboarding hook answer.
  ///
  /// In en, this message translates to:
  /// **'PepMod keeps the answer beside your protocol.'**
  String get onboardingHookAnswer;

  /// English onboarding copy for onboarding hook question.
  ///
  /// In en, this message translates to:
  /// **'How many units\ndo you draw?'**
  String get onboardingHookQuestion;

  /// English onboarding copy for onboarding hook research.
  ///
  /// In en, this message translates to:
  /// **'RESEARCH LIBRARY'**
  String get onboardingHookResearch;

  /// English onboarding copy for onboarding hook sources.
  ///
  /// In en, this message translates to:
  /// **'Evidence-linked sources'**
  String get onboardingHookSources;

  /// English onboarding copy for onboarding hook vial.
  ///
  /// In en, this message translates to:
  /// **'VIAL + DILUENT'**
  String get onboardingHookVial;

  /// English onboarding copy for onboarding name body.
  ///
  /// In en, this message translates to:
  /// **'We’ll use this to personalise your PepMod experience.'**
  String get onboardingNameBody;

  /// English onboarding copy for onboarding name title.
  ///
  /// In en, this message translates to:
  /// **'What should we\ncall you?'**
  String get onboardingNameTitle;

  /// English onboarding copy for onboarding peptide select body.
  ///
  /// In en, this message translates to:
  /// **'Choose any peptides you use or want to keep on your radar.'**
  String get onboardingPeptideSelectBody;

  /// English onboarding copy for onboarding peptide select title.
  ///
  /// In en, this message translates to:
  /// **'What are you\ntracking?'**
  String get onboardingPeptideSelectTitle;

  /// English onboarding copy for onboarding progress value body.
  ///
  /// In en, this message translates to:
  /// **'Bring adherence, dose history, and body metrics into one clear record.'**
  String get onboardingProgressValueBody;

  /// English onboarding copy for onboarding progress value title.
  ///
  /// In en, this message translates to:
  /// **'See the full arc\nover time.'**
  String get onboardingProgressValueTitle;

  /// English onboarding copy for onboarding protocol value body.
  ///
  /// In en, this message translates to:
  /// **'Plan schedules, log doses, and keep the details attached to each protocol.'**
  String get onboardingProtocolValueBody;

  /// English onboarding copy for onboarding protocol value title.
  ///
  /// In en, this message translates to:
  /// **'Keep every protocol\nin one place.'**
  String get onboardingProtocolValueTitle;

  /// English onboarding copy for onboarding under18.
  ///
  /// In en, this message translates to:
  /// **'I’M UNDER 18'**
  String get onboardingUnder18;

  /// English onboarding copy for opening permission.
  ///
  /// In en, this message translates to:
  /// **'OPENING PERMISSION...'**
  String get openingPermission;

  /// English onboarding copy for paywall arc body.
  ///
  /// In en, this message translates to:
  /// **'See what was planned, what was logged, and what needs a cleaner record next.'**
  String get paywallArcBody;

  /// English onboarding copy for paywall arc title.
  ///
  /// In en, this message translates to:
  /// **'WATCH THE ARC OVER TIME'**
  String get paywallArcTitle;

  /// English onboarding copy for paywall body.
  ///
  /// In en, this message translates to:
  /// **'Dose math, site rotation, reminders, and protocol history — all in one record.'**
  String get paywallBody;

  /// English onboarding copy for paywall dose math body.
  ///
  /// In en, this message translates to:
  /// **'Keep vial, water, dose, and units-to-draw together so each log is easier to check.'**
  String get paywallDoseMathBody;

  /// English onboarding copy for paywall dose math title.
  ///
  /// In en, this message translates to:
  /// **'GET THE DOSE MATH RIGHT'**
  String get paywallDoseMathTitle;

  /// English onboarding copy for paywall preview disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Built for records, reminders, and unit clarity — not medical advice.'**
  String get paywallPreviewDisclaimer;

  /// English onboarding copy for paywall rotation body.
  ///
  /// In en, this message translates to:
  /// **'Every site, cycle, and reminder stays attached to the protocol record.'**
  String get paywallRotationBody;

  /// English onboarding copy for paywall rotation title.
  ///
  /// In en, this message translates to:
  /// **'NEVER LOSE YOUR ROTATION'**
  String get paywallRotationTitle;

  /// English onboarding copy for paywall title.
  ///
  /// In en, this message translates to:
  /// **'Everything to run\nyour protocol right.'**
  String get paywallTitle;

  /// English onboarding copy for paywall value note.
  ///
  /// In en, this message translates to:
  /// **'A confusing vial calculation can waste time and product. PepMod keeps the math beside the log so you can re-check your records before you act on old notes.'**
  String get paywallValueNote;

  /// English onboarding copy for peptide label.
  ///
  /// In en, this message translates to:
  /// **'PEPTIDE'**
  String get peptideLabel;

  /// English onboarding copy for peptides label.
  ///
  /// In en, this message translates to:
  /// **'PEPTIDES'**
  String get peptidesLabel;

  /// English onboarding copy for peptides tracked.
  ///
  /// In en, this message translates to:
  /// **'PEPTIDES\nTRACKED'**
  String get peptidesTracked;

  /// English onboarding copy for per week.
  ///
  /// In en, this message translates to:
  /// **'/week'**
  String get perWeek;

  /// English onboarding copy for per year.
  ///
  /// In en, this message translates to:
  /// **'/year'**
  String get perYear;

  /// English onboarding copy for privacy label.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacyLabel;

  /// English onboarding copy for processing goals.
  ///
  /// In en, this message translates to:
  /// **'ANALYSING {count} GOALS...'**
  String processingGoals(int count);

  /// English onboarding copy for processing peptides.
  ///
  /// In en, this message translates to:
  /// **'LINKING {count} PEPTIDE RECORDS...'**
  String processingPeptides(int count);

  /// English onboarding copy for processing protocol.
  ///
  /// In en, this message translates to:
  /// **'BUILDING YOUR PROTOCOL...'**
  String get processingProtocol;

  /// English onboarding copy for processing schedule.
  ///
  /// In en, this message translates to:
  /// **'ORGANISING YOUR SCHEDULE...'**
  String get processingSchedule;

  /// English onboarding copy for processing title.
  ///
  /// In en, this message translates to:
  /// **'Building your\nprotocol'**
  String get processingTitle;

  /// English onboarding copy for progress label.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressLabel;

  /// English onboarding copy for protocol clarity.
  ///
  /// In en, this message translates to:
  /// **'protocol clarity'**
  String get protocolClarity;

  /// English onboarding copy for protocol includes.
  ///
  /// In en, this message translates to:
  /// **'YOUR PROTOCOL INCLUDES //'**
  String get protocolIncludes;

  /// English onboarding copy for protocol preview title.
  ///
  /// In en, this message translates to:
  /// **'Your protocol\nis ready.'**
  String get protocolPreviewTitle;

  /// English onboarding copy for protocol ready.
  ///
  /// In en, this message translates to:
  /// **'PROTOCOL READY //'**
  String get protocolReady;

  /// English onboarding copy for protocol reminder ready.
  ///
  /// In en, this message translates to:
  /// **'Protocol reminder is ready'**
  String get protocolReminderReady;

  /// English onboarding copy for protocol reserved for.
  ///
  /// In en, this message translates to:
  /// **'YOUR PERSONALISED PROTOCOL IS RESERVED FOR'**
  String get protocolReservedFor;

  /// English onboarding copy for restore purchase.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get restorePurchase;

  /// English onboarding copy for results summary body.
  ///
  /// In en, this message translates to:
  /// **'We’ll keep dose logs, reconstitution math, and trend records together as your data builds.'**
  String get resultsSummaryBody;

  /// English onboarding copy for review gate body.
  ///
  /// In en, this message translates to:
  /// **'Your feedback helps us improve the platform for every biohacker.'**
  String get reviewGateBody;

  /// English onboarding copy for review gate title.
  ///
  /// In en, this message translates to:
  /// **'Enjoying PepMod\nso far?'**
  String get reviewGateTitle;

  /// English onboarding copy for roadmap body.
  ///
  /// In en, this message translates to:
  /// **'Built around {count} tracked peptides and your need for {need}.'**
  String roadmapBody(int count, String need);

  /// English onboarding copy for roadmap day one body.
  ///
  /// In en, this message translates to:
  /// **'Peptides, dose logs, site rotation, and reminders are ready.'**
  String get roadmapDayOneBody;

  /// English onboarding copy for roadmap day one title.
  ///
  /// In en, this message translates to:
  /// **'Your first protocol is organised'**
  String get roadmapDayOneTitle;

  /// English onboarding copy for roadmap disclaimer.
  ///
  /// In en, this message translates to:
  /// **'PepMod keeps records and reminders organised. It does not prescribe, diagnose, or replace clinician guidance.'**
  String get roadmapDisclaimer;

  /// English onboarding copy for roadmap month one body.
  ///
  /// In en, this message translates to:
  /// **'Adherence, missed doses, and body metrics start forming a cleaner record.'**
  String get roadmapMonthOneBody;

  /// English onboarding copy for roadmap month one title.
  ///
  /// In en, this message translates to:
  /// **'Your consistency history takes shape'**
  String get roadmapMonthOneTitle;

  /// English onboarding copy for roadmap month two body.
  ///
  /// In en, this message translates to:
  /// **'See what you planned, what happened, and where your records need attention.'**
  String get roadmapMonthTwoBody;

  /// English onboarding copy for roadmap month two title.
  ///
  /// In en, this message translates to:
  /// **'Your full protocol arc is visible'**
  String get roadmapMonthTwoTitle;

  /// English onboarding copy for roadmap title.
  ///
  /// In en, this message translates to:
  /// **'Here is what\nis ahead.'**
  String get roadmapTitle;

  /// English onboarding copy for roadmap week one body.
  ///
  /// In en, this message translates to:
  /// **'Plain-English research and tracking notes stay attached to your plan.'**
  String get roadmapWeekOneBody;

  /// English onboarding copy for roadmap week one title.
  ///
  /// In en, this message translates to:
  /// **'Your library fills around {goal}'**
  String roadmapWeekOneTitle(String goal);

  /// English onboarding copy for save percent.
  ///
  /// In en, this message translates to:
  /// **'SAVE {percent}%'**
  String savePercent(int percent);

  /// English onboarding copy for save roadmap.
  ///
  /// In en, this message translates to:
  /// **'SAVE THIS ROADMAP'**
  String get saveRoadmap;

  /// English onboarding copy for schedule preview.
  ///
  /// In en, this message translates to:
  /// **'SCHEDULE PREVIEW'**
  String get schedulePreview;

  /// English onboarding copy for see whats inside.
  ///
  /// In en, this message translates to:
  /// **'SEE WHAT’S INSIDE'**
  String get seeWhatsInside;

  /// English onboarding copy for select all that apply.
  ///
  /// In en, this message translates to:
  /// **'Select all that apply.'**
  String get selectAllThatApply;

  /// English onboarding copy for site map.
  ///
  /// In en, this message translates to:
  /// **'Site map'**
  String get siteMap;

  /// English onboarding copy for skip for now.
  ///
  /// In en, this message translates to:
  /// **'SKIP FOR NOW'**
  String get skipForNow;

  /// English onboarding copy for social proof body.
  ///
  /// In en, this message translates to:
  /// **'Join thousands tracking real progress.'**
  String get socialProofBody;

  /// English onboarding copy for social proof title.
  ///
  /// In en, this message translates to:
  /// **'Trusted by\nbiohackers worldwide'**
  String get socialProofTitle;

  /// English onboarding copy for special offer.
  ///
  /// In en, this message translates to:
  /// **'SPECIAL OFFER'**
  String get specialOffer;

  /// English onboarding copy for start free trial.
  ///
  /// In en, this message translates to:
  /// **'START FREE TRIAL'**
  String get startFreeTrial;

  /// English onboarding copy for subscribe label.
  ///
  /// In en, this message translates to:
  /// **'SUBSCRIBE'**
  String get subscribeLabel;

  /// English onboarding copy for subscribe price.
  ///
  /// In en, this message translates to:
  /// **'SUBSCRIBE — {price}/week'**
  String subscribePrice(String price);

  /// English onboarding copy for subscribe to activate.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to activate your protocol'**
  String get subscribeToActivate;

  /// English onboarding copy for subscription renewal disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Subscription auto-renews unless cancelled at least 24 hours before the end of the current period. Manage in Settings > Apple ID > Subscriptions.'**
  String get subscriptionRenewalDisclaimer;

  /// English onboarding copy for syringe volume.
  ///
  /// In en, this message translates to:
  /// **'{volume}ml on a 1ml syringe'**
  String syringeVolume(String volume);

  /// English onboarding copy for terms label.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get termsLabel;

  /// English onboarding copy for testimonial one.
  ///
  /// In en, this message translates to:
  /// **'Finally stopped missing doses. The reconstitution calculator alone saved me hours of spreadsheet maths.'**
  String get testimonialOne;

  /// English onboarding copy for testimonial three.
  ///
  /// In en, this message translates to:
  /// **'Cleanest peptide tracker I’ve used. Looks like it was built for serious users, because it was.'**
  String get testimonialThree;

  /// English onboarding copy for testimonial two.
  ///
  /// In en, this message translates to:
  /// **'The weekly insights caught a timing issue I didn’t notice for months. Game-changer.'**
  String get testimonialTwo;

  /// English onboarding copy for thirty day adherence.
  ///
  /// In en, this message translates to:
  /// **'30-day adherence'**
  String get thirtyDayAdherence;

  /// English onboarding copy for three day free trial.
  ///
  /// In en, this message translates to:
  /// **'3-DAY FREE TRIAL'**
  String get threeDayFreeTrial;

  /// English onboarding copy for timeline label.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timelineLabel;

  /// English onboarding copy for tracked label.
  ///
  /// In en, this message translates to:
  /// **'tracked'**
  String get trackedLabel;

  /// English onboarding copy for turn on reminders.
  ///
  /// In en, this message translates to:
  /// **'TURN ON REMINDERS'**
  String get turnOnReminders;

  /// English onboarding copy for unit conversion disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Unit conversion tool for reference only. Always verify with your healthcare provider.'**
  String get unitConversionDisclaimer;

  /// Label for measurement unit preferences.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get unitsLabel;

  /// English onboarding copy for units to draw.
  ///
  /// In en, this message translates to:
  /// **'Units to draw'**
  String get unitsToDraw;

  /// English onboarding copy for unlock pep mod.
  ///
  /// In en, this message translates to:
  /// **'UNLOCK PEPMOD'**
  String get unlockPepMod;

  /// English onboarding copy for users label.
  ///
  /// In en, this message translates to:
  /// **'USERS'**
  String get usersLabel;

  /// English onboarding copy for view label.
  ///
  /// In en, this message translates to:
  /// **'VIEW'**
  String get viewLabel;

  /// English onboarding copy for week duration.
  ///
  /// In en, this message translates to:
  /// **'WEEK\nDURATION'**
  String get weekDuration;

  /// English onboarding copy for week one.
  ///
  /// In en, this message translates to:
  /// **'WEEK 1'**
  String get weekOne;

  /// English onboarding copy for weekly label.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weeklyLabel;

  /// English onboarding copy for weeks count.
  ///
  /// In en, this message translates to:
  /// **'{count} weeks'**
  String weeksCount(int count);

  /// English onboarding copy for year label.
  ///
  /// In en, this message translates to:
  /// **'YEAR'**
  String get yearLabel;

  /// Title of the user profile tab.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get profileTitle;

  /// Fallback account status when no email is available.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get signedIn;

  /// Profile section heading for account settings.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get sectionAccount;

  /// Profile section heading for preferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get sectionPreferences;

  /// Profile section heading for user data tools.
  ///
  /// In en, this message translates to:
  /// **'DATA'**
  String get sectionData;

  /// Profile section heading for support.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get sectionSupport;

  /// Profile section heading for legal documents.
  ///
  /// In en, this message translates to:
  /// **'LEGAL'**
  String get sectionLegal;

  /// Profile section heading for app information.
  ///
  /// In en, this message translates to:
  /// **'ABOUT'**
  String get sectionAbout;

  /// Label for the user's display name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// Label for account information.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountLabel;

  /// Action to permanently delete an account.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// Description of the delete-account action.
  ///
  /// In en, this message translates to:
  /// **'Remove account and data'**
  String get removeAccountData;

  /// Metric measurement system label.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get metricLabel;

  /// Imperial measurement system label.
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get imperialLabel;

  /// Label for notification preferences.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsLabel;

  /// Enabled state label.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get onLabel;

  /// Disabled state label.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get offLabel;

  /// Profile action that opens saved custom compounds.
  ///
  /// In en, this message translates to:
  /// **'My compounds'**
  String get myCompoundsProfile;

  /// Description for saved custom compounds.
  ///
  /// In en, this message translates to:
  /// **'Saved vial presets'**
  String get savedVialPresets;

  /// Action to export user data.
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get exportData;

  /// Description of the JSON export action.
  ///
  /// In en, this message translates to:
  /// **'Copy as JSON'**
  String get copyAsJson;

  /// Action to reset all app tracking data.
  ///
  /// In en, this message translates to:
  /// **'Clear all data'**
  String get clearAllData;

  /// Status shown while app data is being cleared.
  ///
  /// In en, this message translates to:
  /// **'Clearing…'**
  String get clearingLabel;

  /// Description of the clear-data action.
  ///
  /// In en, this message translates to:
  /// **'Reset app'**
  String get resetApp;

  /// Action to contact app support.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get contactSupport;

  /// Description of the support action.
  ///
  /// In en, this message translates to:
  /// **'Chat with us'**
  String get chatWithUs;

  /// Title of the terms document.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Title of the privacy document.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Title of the medical disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Medical disclaimer'**
  String get medicalDisclaimer;

  /// Short title for the disclaimer sheet.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimerTitle;

  /// Label for the app version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// Primary sign-out action.
  ///
  /// In en, this message translates to:
  /// **'SIGN OUT'**
  String get signOutAction;

  /// Short safety disclaimer on the profile screen.
  ///
  /// In en, this message translates to:
  /// **'Educational tracking only. Not medical advice.'**
  String get educationalTrackingDisclaimer;

  /// Title of the display-name editor.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// Generic cancel action.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelLabel;

  /// Generic save action.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveLabel;

  /// Confirmation after copying an account export.
  ///
  /// In en, this message translates to:
  /// **'Data copied to clipboard.'**
  String get dataCopied;

  /// Title of the clear-data confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Clear all data?'**
  String get clearDataTitle;

  /// Explanation in the clear-data confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'This deletes all protocols, dose logs, and body metrics, then restarts onboarding. Your account, subscription, and peptide library are preserved. This cannot be undone.'**
  String get clearDataBody;

  /// Destructive action that clears app data.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearLabel;

  /// Title of the blocking clear-data progress dialog.
  ///
  /// In en, this message translates to:
  /// **'Clearing data…'**
  String get clearingDataTitle;

  /// Instruction in the clear-data progress dialog.
  ///
  /// In en, this message translates to:
  /// **'Keep PepMod open while your tracking data is removed.'**
  String get clearingDataBody;

  /// Error shown when clearing app data fails.
  ///
  /// In en, this message translates to:
  /// **'Could not clear data. Check your connection and retry.'**
  String get clearDataFailed;

  /// Confirmation after all app data is cleared.
  ///
  /// In en, this message translates to:
  /// **'All data cleared.'**
  String get allDataCleared;

  /// Title of the account-deletion confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get deleteAccountTitle;

  /// Explanation in the account-deletion confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your PepMod account, settings, protocols, dose logs, and body metrics. This cannot be undone.'**
  String get deleteAccountBody;

  /// Status shown while an account is being deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleting account…'**
  String get deletingAccount;

  /// Generic account-deletion failure message.
  ///
  /// In en, this message translates to:
  /// **'Account deletion failed. Please try again.'**
  String get accountDeletionFailed;

  /// Title of the password confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// Generic destructive delete action.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteLabel;

  /// Title of the sign-out confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get signOutTitle;

  /// Explanation in the sign-out confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Your protocols stay saved and sync back when you sign in again.'**
  String get signOutBody;

  /// Sign-out confirmation action.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOutLabel;

  /// Generic sign-out failure message.
  ///
  /// In en, this message translates to:
  /// **'Sign out failed. Please try again.'**
  String get signOutFailed;

  /// Message shown when notification permission is unavailable.
  ///
  /// In en, this message translates to:
  /// **'Notifications are disabled in system settings.'**
  String get notificationsDisabledSystem;

  /// Paid subscription badge.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get planPro;

  /// Free subscription badge.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get planFree;

  /// In-app summary of PepMod terms with a link to the full document.
  ///
  /// In en, this message translates to:
  /// **'PepMod is provided for educational and tracking purposes only. It is not a medical device and does not provide medical advice, diagnosis, prescriptions, or treatment recommendations. By using PepMod, you are responsible for your own records, decisions, and consultation with qualified healthcare professionals.\n\nSubscriptions renew automatically unless cancelled through the App Store or Google Play before the renewal period. Refunds are handled by the store where you purchased.\n\nFull Terms: https://appstorecopilot.com/legal/yzh32x5v/terms'**
  String get termsBody;

  /// In-app privacy summary with a link to the full document.
  ///
  /// In en, this message translates to:
  /// **'PepMod uses Firebase for authentication and cloud data storage, RevenueCat for subscriptions, AppRefer and Meta/Facebook App Events for attribution, and Firebase/Crashlytics for analytics and diagnostics. We do not sell your personal information. You can delete your account and saved app data from within the app.\n\nFull Privacy Policy: https://appstorecopilot.com/legal/yzh32x5v/privacy'**
  String get privacyBody;

  /// Full in-app medical safety disclaimer.
  ///
  /// In en, this message translates to:
  /// **'PepMod is a wellness and tracking tool — NOT a medical device. Nothing in this app constitutes medical advice, diagnosis, prescription, or treatment recommendation. Peptides described in the library are for educational purposes only. Always consult a qualified healthcare provider before starting, changing, or stopping any regimen. If you experience any adverse effects, seek medical attention immediately.'**
  String get medicalDisclaimerBody;

  /// System-style heading above the profile title.
  ///
  /// In en, this message translates to:
  /// **'SYS.USER // PROFILE'**
  String get profileSystemLabel;

  /// System-style heading in legal document sheets.
  ///
  /// In en, this message translates to:
  /// **'SYS.LEGAL'**
  String get legalSystemLabel;

  /// Title of the progress tab.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressTitle;

  /// System-style heading above the progress title.
  ///
  /// In en, this message translates to:
  /// **'SYS.PROGRESS // BIOMETRICS'**
  String get progressSystemLabel;

  /// Accessibility label for the dose-history button.
  ///
  /// In en, this message translates to:
  /// **'Open dose history'**
  String get doseHistoryTooltip;

  /// Accessibility label for the add-measurement button.
  ///
  /// In en, this message translates to:
  /// **'Log measurement'**
  String get logMeasurementTooltip;

  /// Label for the thirty-day adherence statistic.
  ///
  /// In en, this message translates to:
  /// **'30-DAY'**
  String get thirtyDayLabel;

  /// Hint below an adherence percentage.
  ///
  /// In en, this message translates to:
  /// **'adherence'**
  String get adherenceLabel;

  /// Label for the current tracking streak.
  ///
  /// In en, this message translates to:
  /// **'STREAK'**
  String get streakLabel;

  /// Unit hint for a day count.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get daysLabel;

  /// Label for the total logged dose count.
  ///
  /// In en, this message translates to:
  /// **'TOTAL'**
  String get totalLabel;

  /// Unit hint for a dose count.
  ///
  /// In en, this message translates to:
  /// **'doses'**
  String get dosesLabel;

  /// System-style heading for protocol history.
  ///
  /// In en, this message translates to:
  /// **'PROTOCOL.HISTORY'**
  String get protocolHistoryLabel;

  /// Empty-state message when no protocols exist.
  ///
  /// In en, this message translates to:
  /// **'No protocols yet. Create one from the Protocol tab.'**
  String get noProtocolsYet;

  /// System-style title of the thirty-day adherence chart.
  ///
  /// In en, this message translates to:
  /// **'ADHERENCE // 30.DAY'**
  String get adherenceChartLabel;

  /// Label for the beginning of a thirty-day chart.
  ///
  /// In en, this message translates to:
  /// **'30d ago'**
  String get thirtyDaysAgo;

  /// Label for the current day on a chart.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get todayLabel;

  /// Weight-chart empty-state title.
  ///
  /// In en, this message translates to:
  /// **'No weight data'**
  String get noWeightData;

  /// Weight-chart empty-state description.
  ///
  /// In en, this message translates to:
  /// **'Log your first measurement to see trends here.'**
  String get logFirstMeasurement;

  /// Action to open the measurement form.
  ///
  /// In en, this message translates to:
  /// **'LOG MEASUREMENT'**
  String get logMeasurementAction;

  /// System-style title of the weight trend chart.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT // TREND'**
  String get weightTrendLabel;

  /// Formatted weight in kilograms.
  ///
  /// In en, this message translates to:
  /// **'{weight} kg'**
  String weightKgValue(String weight);

  /// Active protocol status.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get statusActive;

  /// Paused protocol status.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get statusPaused;

  /// Ended protocol status.
  ///
  /// In en, this message translates to:
  /// **'ENDED'**
  String get statusEnded;

  /// Number of peptides in a protocol.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 peptide} other{{count} peptides}}'**
  String protocolPeptideCount(int count);

  /// Validation shown when the measurement form is empty.
  ///
  /// In en, this message translates to:
  /// **'Enter at least one value.'**
  String get enterOneMetric;

  /// Generic measurement-save error.
  ///
  /// In en, this message translates to:
  /// **'Failed to save. Try again.'**
  String get saveMetricFailed;

  /// Title of the body measurement form.
  ///
  /// In en, this message translates to:
  /// **'New Measurement'**
  String get newMeasurement;

  /// Label for the weight input.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT'**
  String get weightLabel;

  /// Label for the body-fat input.
  ///
  /// In en, this message translates to:
  /// **'BODY FAT'**
  String get bodyFatLabel;

  /// Heading for circumference measurements in centimetres.
  ///
  /// In en, this message translates to:
  /// **'MEASUREMENTS (cm)'**
  String get measurementsCmLabel;

  /// Label for the waist measurement.
  ///
  /// In en, this message translates to:
  /// **'WAIST'**
  String get waistLabel;

  /// Label for the chest measurement.
  ///
  /// In en, this message translates to:
  /// **'CHEST'**
  String get chestLabel;

  /// Label for the arm measurement.
  ///
  /// In en, this message translates to:
  /// **'ARM'**
  String get armLabel;

  /// Primary save action.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get saveAction;

  /// System-style heading in the body measurement form.
  ///
  /// In en, this message translates to:
  /// **'LOG.METRIC'**
  String get logMetricSystemLabel;

  /// Adherence period covering the last seven days.
  ///
  /// In en, this message translates to:
  /// **'LAST 7 DAYS'**
  String get activeLastSevenDays;

  /// Adherence period covering all recorded history.
  ///
  /// In en, this message translates to:
  /// **'ALL TIME'**
  String get activeAllTime;

  /// Label below an adherence percentage.
  ///
  /// In en, this message translates to:
  /// **'adherence'**
  String get activeAdherence;

  /// Label for a protocol start date.
  ///
  /// In en, this message translates to:
  /// **'STARTED'**
  String get activeStarted;

  /// Label for a protocol end date.
  ///
  /// In en, this message translates to:
  /// **'ENDED'**
  String get activeEnded;

  /// Heading with the number of peptides in a protocol.
  ///
  /// In en, this message translates to:
  /// **'STACK ({count})'**
  String activeStackCount(int count);

  /// Action to edit a protocol.
  ///
  /// In en, this message translates to:
  /// **'EDIT PROTOCOL'**
  String get activeEditProtocol;

  /// Action to pause a protocol.
  ///
  /// In en, this message translates to:
  /// **'PAUSE PROTOCOL'**
  String get activePauseProtocol;

  /// Action to end a protocol.
  ///
  /// In en, this message translates to:
  /// **'END PROTOCOL'**
  String get activeEndProtocol;

  /// Action to resume a protocol.
  ///
  /// In en, this message translates to:
  /// **'RESUME PROTOCOL'**
  String get activeResumeProtocol;

  /// Action to permanently delete a protocol.
  ///
  /// In en, this message translates to:
  /// **'DELETE PROTOCOL'**
  String get activeDeleteProtocol;

  /// Safety disclaimer on protocol management.
  ///
  /// In en, this message translates to:
  /// **'Educational tracking only. Consult a qualified healthcare provider before making changes.'**
  String get activeTrackingDisclaimer;

  /// Confirmation title before ending a protocol.
  ///
  /// In en, this message translates to:
  /// **'End protocol?'**
  String get activeEndQuestion;

  /// Confirmation detail before ending a protocol.
  ///
  /// In en, this message translates to:
  /// **'Future doses will be removed. Past logs stay in your history. This cannot be undone.'**
  String get activeEndBody;

  /// Confirmation action that ends a protocol.
  ///
  /// In en, this message translates to:
  /// **'END'**
  String get activeEndAction;

  /// Confirmation title before deleting a protocol.
  ///
  /// In en, this message translates to:
  /// **'Delete protocol?'**
  String get activeDeleteQuestion;

  /// Confirmation detail before deleting a protocol.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes the protocol and all its dose logs. This cannot be undone.'**
  String get activeDeleteBody;

  /// Confirmation action that deletes a protocol.
  ///
  /// In en, this message translates to:
  /// **'DELETE'**
  String get activeDeleteAction;

  /// Generic action that dismisses without saving.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Active protocol status.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get activeStatusActive;

  /// Paused protocol status.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get activeStatusPaused;

  /// Ended protocol status.
  ///
  /// In en, this message translates to:
  /// **'ENDED'**
  String get activeStatusEnded;

  /// System heading for protocol notes.
  ///
  /// In en, this message translates to:
  /// **'NOTES // PROTOCOL'**
  String get activeNotesLabel;

  /// Heading for upcoming phase-change reminders.
  ///
  /// In en, this message translates to:
  /// **'CHANGE REMINDERS'**
  String get activeChangeReminders;

  /// Explanation of phase-change reminders.
  ///
  /// In en, this message translates to:
  /// **'When Notifications is on, PepMod schedules a 09:00 local checkpoint for each upcoming phase change.'**
  String get activeChangeRemindersBody;

  /// Date used to calculate phase weeks.
  ///
  /// In en, this message translates to:
  /// **'Week ranges are anchored to {date}.'**
  String activePhaseAnchor(String date);

  /// Single-week phase range.
  ///
  /// In en, this message translates to:
  /// **'WEEK {week}'**
  String activeWeek(int week);

  /// Multi-week phase range.
  ///
  /// In en, this message translates to:
  /// **'WEEKS {start}–{end}'**
  String activeWeeks(int start, int end);

  /// Phase summary using different amounts by weekday.
  ///
  /// In en, this message translates to:
  /// **'Per-day amounts'**
  String get activePerDayAmounts;

  /// Phase summary using the protocol base amount.
  ///
  /// In en, this message translates to:
  /// **'Base amount'**
  String get activeBaseAmount;

  /// Badge on the current phase.
  ///
  /// In en, this message translates to:
  /// **'CURRENT'**
  String get activeCurrent;

  /// Fallback schedule outside phase overrides.
  ///
  /// In en, this message translates to:
  /// **'Base schedule'**
  String get activeBaseSchedule;

  /// Frequency label for selected weekdays.
  ///
  /// In en, this message translates to:
  /// **'Custom days'**
  String get activeCustomDays;

  /// Cycle status when no fixed cycle is configured.
  ///
  /// In en, this message translates to:
  /// **'Continuous tracking'**
  String get activeContinuousTracking;

  /// Cycle detail when no fixed cycle is configured.
  ///
  /// In en, this message translates to:
  /// **'No fixed cycle window'**
  String get activeNoFixedCycle;

  /// Current week within a protocol cycle.
  ///
  /// In en, this message translates to:
  /// **'Week {week} of {total}'**
  String activeCycleProgress(int week, int total);

  /// Date a protocol cycle ends.
  ///
  /// In en, this message translates to:
  /// **'Cycle ends {date}'**
  String activeCycleEnds(String date);

  /// Current week within a rest window.
  ///
  /// In en, this message translates to:
  /// **'Rest week {week} of {total}'**
  String activeRestProgress(int week, int total);

  /// Date a rest window ends.
  ///
  /// In en, this message translates to:
  /// **'Rest window ends {date}'**
  String activeRestEnds(String date);

  /// Cycle status after completion.
  ///
  /// In en, this message translates to:
  /// **'Cycle complete'**
  String get activeCycleComplete;

  /// Date a cycle completed.
  ///
  /// In en, this message translates to:
  /// **'Completed {date}'**
  String activeCompletedDate(String date);

  /// Date a rest window ended.
  ///
  /// In en, this message translates to:
  /// **'Rest window ended {date}'**
  String activeRestEnded(String date);

  /// Empty state for protocol history.
  ///
  /// In en, this message translates to:
  /// **'No paused or ended protocols yet.'**
  String get activeNoHistory;

  /// Number of compounds in a blended vial.
  ///
  /// In en, this message translates to:
  /// **'{count} compounds'**
  String activeCompoundsCount(int count);

  /// Syringe-unit amount without a leading separator.
  ///
  /// In en, this message translates to:
  /// **'{amount} syringe units'**
  String activeSyringeUnits(String amount);

  /// Protocol cycle length tag.
  ///
  /// In en, this message translates to:
  /// **'{count}wk cycle'**
  String activeCycleWeeks(int count);

  /// Protocol rest length tag.
  ///
  /// In en, this message translates to:
  /// **'{count}wk rest'**
  String activeRestWeeks(int count);

  /// Heading for amounts in one blended-vial draw.
  ///
  /// In en, this message translates to:
  /// **'PER DRAW'**
  String get activePerDraw;

  /// Diluent volume and syringe type for a blended vial.
  ///
  /// In en, this message translates to:
  /// **'{volume} mL vial · U-100'**
  String activeVialSummary(String volume);

  /// Action to create a personal compound preset.
  ///
  /// In en, this message translates to:
  /// **'ADD COMPOUND'**
  String get addCompound;

  /// Copy for the create protocol addPhase UI.
  ///
  /// In en, this message translates to:
  /// **'ADD PHASE'**
  String get addPhase;

  /// Copy for the create protocol addTime UI.
  ///
  /// In en, this message translates to:
  /// **'Add time'**
  String get addTime;

  /// Copy for the create protocol addToStack UI.
  ///
  /// In en, this message translates to:
  /// **'ADD TO STACK'**
  String get addToStack;

  /// Copy for the create protocol amountRequired UI.
  ///
  /// In en, this message translates to:
  /// **'Amount required'**
  String get amountRequired;

  /// Copy for the create protocol baseAmount UI.
  ///
  /// In en, this message translates to:
  /// **'Base amount'**
  String get baseAmount;

  /// Copy for the create protocol baseSchedule UI.
  ///
  /// In en, this message translates to:
  /// **'base schedule'**
  String get baseSchedule;

  /// Copy for the create protocol blendConfigBody UI.
  ///
  /// In en, this message translates to:
  /// **'Enter exactly what is printed on the vial. PepMod converts the draw into a per-compound snapshot.'**
  String get blendConfigBody;

  /// Copy for the create protocol blendIncompleteError UI.
  ///
  /// In en, this message translates to:
  /// **'Complete at least two compounds, diluent volume, and draw.'**
  String get blendIncompleteError;

  /// Copy for the create protocol blendNameHint UI.
  ///
  /// In en, this message translates to:
  /// **'e.g. Recovery blend'**
  String get blendNameHint;

  /// Copy for the create protocol blendNameLabel UI.
  ///
  /// In en, this message translates to:
  /// **'BLEND NAME'**
  String get blendNameLabel;

  /// Copy for the create protocol blendSafetyDisclaimer UI.
  ///
  /// In en, this message translates to:
  /// **'Unit conversion only. PepMod does not recommend a blend, dose, frequency, or reconstitution method.'**
  String get blendSafetyDisclaimer;

  /// Copy for the create protocol changeNoteHint UI.
  ///
  /// In en, this message translates to:
  /// **'Your own context for this phase'**
  String get changeNoteHint;

  /// Copy for the create protocol changeNoteOptional UI.
  ///
  /// In en, this message translates to:
  /// **'CHANGE NOTE OPTIONAL'**
  String get changeNoteOptional;

  /// Copy for the create protocol colorOption UI.
  ///
  /// In en, this message translates to:
  /// **'Colour option {hex}'**
  String colorOption(String hex);

  /// Copy for the create protocol compoundNumber UI.
  ///
  /// In en, this message translates to:
  /// **'COMPOUND {number}'**
  String compoundNumber(int number);

  /// Copy for the create protocol compoundsCount UI.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 compound} other{{count} compounds}}'**
  String compoundsCount(int count);

  /// Copy for the create protocol copiedVialPreset UI.
  ///
  /// In en, this message translates to:
  /// **'{amount} {unit} vial preset · copied into this protocol'**
  String copiedVialPreset(String amount, String unit);

  /// Copy for the create protocol createProtocolAction UI.
  ///
  /// In en, this message translates to:
  /// **'CREATE PROTOCOL'**
  String get createProtocolAction;

  /// Copy for the create protocol createProtocolAddOneError UI.
  ///
  /// In en, this message translates to:
  /// **'Add at least one peptide.'**
  String get createProtocolAddOneError;

  /// Copy for the create protocol createProtocolBuildStep UI.
  ///
  /// In en, this message translates to:
  /// **'Build Protocol · Step {step} / {total}'**
  String createProtocolBuildStep(int step, int total);

  /// Copy for the create protocol createProtocolDefaultName UI.
  ///
  /// In en, this message translates to:
  /// **'My Protocol'**
  String get createProtocolDefaultName;

  /// Copy for the create protocol createProtocolEditStep UI.
  ///
  /// In en, this message translates to:
  /// **'Edit Protocol · Step {step} / {total}'**
  String createProtocolEditStep(int step, int total);

  /// Copy for the create protocol createProtocolFreeLimitReason UI.
  ///
  /// In en, this message translates to:
  /// **'Free plan is limited to one peptide per protocol. Upgrade to stack multiple compounds.'**
  String get createProtocolFreeLimitReason;

  /// Copy for the create protocol createProtocolNameBody UI.
  ///
  /// In en, this message translates to:
  /// **'Give it a memorable label — e.g. “Recovery Stack” or “Q2 Shred”.'**
  String get createProtocolNameBody;

  /// Copy for the create protocol createProtocolNameTitle UI.
  ///
  /// In en, this message translates to:
  /// **'Name your protocol'**
  String get createProtocolNameTitle;

  /// Copy for the create protocol createProtocolNoPeptides UI.
  ///
  /// In en, this message translates to:
  /// **'No peptides yet'**
  String get createProtocolNoPeptides;

  /// Copy for the create protocol createProtocolPickHint UI.
  ///
  /// In en, this message translates to:
  /// **'Tap + to pick from the library'**
  String get createProtocolPickHint;

  /// Copy for the create protocol createProtocolReviewBody UI.
  ///
  /// In en, this message translates to:
  /// **'Confirm the protocol details. You can edit anytime from the Manage view.'**
  String get createProtocolReviewBody;

  /// Copy for the create protocol createProtocolSaveError UI.
  ///
  /// In en, this message translates to:
  /// **'Failed to save protocol. Try again.'**
  String get createProtocolSaveError;

  /// Copy for the create protocol createProtocolStackBody UI.
  ///
  /// In en, this message translates to:
  /// **'Add one peptide or stack multiple compounds. Configure each label, dose, frequency, and cycle.'**
  String get createProtocolStackBody;

  /// Copy for the create protocol createProtocolStackTitle UI.
  ///
  /// In en, this message translates to:
  /// **'Build your stack'**
  String get createProtocolStackTitle;

  /// Copy for the create protocol customBlend UI.
  ///
  /// In en, this message translates to:
  /// **'Custom blend'**
  String get customBlend;

  /// Copy for the create protocol customDays UI.
  ///
  /// In en, this message translates to:
  /// **'Custom days'**
  String get customDays;

  /// Copy for the create protocol customDaysDisclaimer UI.
  ///
  /// In en, this message translates to:
  /// **'Only selected weekdays are scheduled. Amounts are user-entered tracking values, not dosing advice.'**
  String get customDaysDisclaimer;

  /// Copy for the create protocol customPeptide UI.
  ///
  /// In en, this message translates to:
  /// **'Custom peptide'**
  String get customPeptide;

  /// Copy for the create protocol cycleWeeksLabel UI.
  ///
  /// In en, this message translates to:
  /// **'CYCLE WEEKS'**
  String get cycleWeeksLabel;

  /// Copy for the create protocol cycleWindowDisclaimer UI.
  ///
  /// In en, this message translates to:
  /// **'Cycle and rest windows organise tracking history. PepMod will not schedule future doses after the cycle window ends.'**
  String get cycleWindowDisclaimer;

  /// Copy for the create protocol defaultAmountLabel UI.
  ///
  /// In en, this message translates to:
  /// **'DEFAULT AMOUNT'**
  String get defaultAmountLabel;

  /// Copy for the create protocol diluentVolumeLabel UI.
  ///
  /// In en, this message translates to:
  /// **'DILUENT VOLUME'**
  String get diluentVolumeLabel;

  /// Copy for the create protocol drawExceedsVialError UI.
  ///
  /// In en, this message translates to:
  /// **'Draw cannot exceed the vial volume.'**
  String get drawExceedsVialError;

  /// Copy for the create protocol drawLabel UI.
  ///
  /// In en, this message translates to:
  /// **'DRAW'**
  String get drawLabel;

  /// Copy for the create protocol drawPreviewLabel UI.
  ///
  /// In en, this message translates to:
  /// **'DRAW PREVIEW'**
  String get drawPreviewLabel;

  /// Copy for the create protocol drawPreviewValue UI.
  ///
  /// In en, this message translates to:
  /// **'{units} units = {volume} mL'**
  String drawPreviewValue(String units, String volume);

  /// Copy for the create protocol editTime UI.
  ///
  /// In en, this message translates to:
  /// **'Edit time {time}'**
  String editTime(String time);

  /// Copy for the create protocol endWeekLabel UI.
  ///
  /// In en, this message translates to:
  /// **'END WEEK'**
  String get endWeekLabel;

  /// Copy for the create protocol enterPeptideName UI.
  ///
  /// In en, this message translates to:
  /// **'Enter peptide name'**
  String get enterPeptideName;

  /// Copy for the create protocol frequencyLabel UI.
  ///
  /// In en, this message translates to:
  /// **'FREQUENCY'**
  String get frequencyLabel;

  /// Copy for the create protocol labelColorBody UI.
  ///
  /// In en, this message translates to:
  /// **'Match this colour to the pen or vial label you use in real life.'**
  String get labelColorBody;

  /// Copy for the create protocol labelColorLabel UI.
  ///
  /// In en, this message translates to:
  /// **'LABEL COLOUR'**
  String get labelColorLabel;

  /// Copy for the create protocol manageSavedCompounds UI.
  ///
  /// In en, this message translates to:
  /// **'Manage saved compounds'**
  String get manageSavedCompounds;

  /// Copy for the create protocol nextLabel UI.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get nextLabel;

  /// Copy for the create protocol noneLabel UI.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get noneLabel;

  /// Copy for the create protocol oneOffCompound UI.
  ///
  /// In en, this message translates to:
  /// **'One-off compound'**
  String get oneOffCompound;

  /// Copy for the create protocol oneOffCompoundBody UI.
  ///
  /// In en, this message translates to:
  /// **'Use once without saving a preset'**
  String get oneOffCompoundBody;

  /// Copy for the create protocol optionalLabel UI.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optionalLabel;

  /// Copy for the create protocol peptidesCount UI.
  ///
  /// In en, this message translates to:
  /// **'PEPTIDES ({count})'**
  String peptidesCount(int count);

  /// Copy for the create protocol perDayAmounts UI.
  ///
  /// In en, this message translates to:
  /// **'Per-day amounts'**
  String get perDayAmounts;

  /// Copy for the create protocol phaseExtendsWarning UI.
  ///
  /// In en, this message translates to:
  /// **'A phase extends beyond the {weeks}-week cycle. Adjust the phase or cycle window.'**
  String phaseExtendsWarning(int weeks);

  /// Copy for the create protocol phaseNameHint UI.
  ///
  /// In en, this message translates to:
  /// **'e.g. Week 1 tracking'**
  String get phaseNameHint;

  /// Copy for the create protocol phaseNameLabel UI.
  ///
  /// In en, this message translates to:
  /// **'PHASE NAME'**
  String get phaseNameLabel;

  /// Copy for the create protocol phaseNumber UI.
  ///
  /// In en, this message translates to:
  /// **'Phase {number}'**
  String phaseNumber(int number);

  /// Copy for the create protocol phaseOutsideCycleError UI.
  ///
  /// In en, this message translates to:
  /// **'This protocol cycle ends after week {weeks}. Keep phase weeks inside that window.'**
  String phaseOutsideCycleError(int weeks);

  /// Copy for the create protocol phaseOverlapError UI.
  ///
  /// In en, this message translates to:
  /// **'Phase week ranges cannot overlap.'**
  String get phaseOverlapError;

  /// Copy for the create protocol phaseOverrideBody UI.
  ///
  /// In en, this message translates to:
  /// **'Enter only the tracking schedule you already intend to follow. PepMod does not recommend amounts.'**
  String get phaseOverrideBody;

  /// Copy for the create protocol phaseOverrideTitle UI.
  ///
  /// In en, this message translates to:
  /// **'Week-to-week override'**
  String get phaseOverrideTitle;

  /// Copy for the create protocol phasePreviewDisclaimer UI.
  ///
  /// In en, this message translates to:
  /// **'Preview of your entries only. No schedule is recommended by PepMod.'**
  String get phasePreviewDisclaimer;

  /// Copy for the create protocol phasePreviewLabel UI.
  ///
  /// In en, this message translates to:
  /// **'PHASE PREVIEW'**
  String get phasePreviewLabel;

  /// Copy for the create protocol phaseReminderBody UI.
  ///
  /// In en, this message translates to:
  /// **'A neutral phase-change reminder is scheduled for 9:00 AM when protocol reminders are enabled.'**
  String get phaseReminderBody;

  /// Copy for the create protocol phaseScheduleLabel UI.
  ///
  /// In en, this message translates to:
  /// **'PHASE SCHEDULE'**
  String get phaseScheduleLabel;

  /// Copy for the create protocol phaseSelectDayError UI.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day. PepMod will not choose a schedule for you.'**
  String get phaseSelectDayError;

  /// Copy for the create protocol phasesBody UI.
  ///
  /// In en, this message translates to:
  /// **'Optional date windows can override this base amount and schedule. Outside them, the base schedule continues.'**
  String get phasesBody;

  /// Copy for the create protocol phasesCount UI.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 phase} other{{count} phases}}'**
  String phasesCount(int count);

  /// Copy for the create protocol phasesDisclaimer UI.
  ///
  /// In en, this message translates to:
  /// **'Weeks are counted from the protocol start date. Saved phase notes and change reminders are tracking aids only.'**
  String get phasesDisclaimer;

  /// Copy for the create protocol preBlendedVial UI.
  ///
  /// In en, this message translates to:
  /// **'Pre-blended vial'**
  String get preBlendedVial;

  /// Copy for the create protocol preBlendedVialBody UI.
  ///
  /// In en, this message translates to:
  /// **'One vial · one draw · multiple compounds'**
  String get preBlendedVialBody;

  /// Copy for the create protocol protocolNotesBody UI.
  ///
  /// In en, this message translates to:
  /// **'Save context you want visible when reviewing this protocol.'**
  String get protocolNotesBody;

  /// Copy for the create protocol protocolNotesHint UI.
  ///
  /// In en, this message translates to:
  /// **'e.g. questions, tracking context, or clinician notes'**
  String get protocolNotesHint;

  /// Copy for the create protocol protocolNotesLabel UI.
  ///
  /// In en, this message translates to:
  /// **'Protocol notes'**
  String get protocolNotesLabel;

  /// Copy for the create protocol reminderTimesBody UI.
  ///
  /// In en, this message translates to:
  /// **'Each selected time creates its own tracking row and reminder on scheduled days.'**
  String get reminderTimesBody;

  /// Copy for the create protocol reminderTimesLabel UI.
  ///
  /// In en, this message translates to:
  /// **'REMINDER TIMES'**
  String get reminderTimesLabel;

  /// Copy for the create protocol removeLabel UI.
  ///
  /// In en, this message translates to:
  /// **'REMOVE'**
  String get removeLabel;

  /// Copy for the create protocol removePeptide UI.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}'**
  String removePeptide(String name);

  /// Copy for the create protocol removePhase UI.
  ///
  /// In en, this message translates to:
  /// **'Remove phase'**
  String get removePhase;

  /// Copy for the create protocol removeTime UI.
  ///
  /// In en, this message translates to:
  /// **'Remove time {time}'**
  String removeTime(String time);

  /// Copy for the create protocol restWeeksLabel UI.
  ///
  /// In en, this message translates to:
  /// **'REST WEEKS'**
  String get restWeeksLabel;

  /// Copy for the create protocol reviewLabel UI.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get reviewLabel;

  /// Label for a route selector.
  ///
  /// In en, this message translates to:
  /// **'ROUTE'**
  String get routeLabel;

  /// Copy for the create protocol saveBlend UI.
  ///
  /// In en, this message translates to:
  /// **'SAVE BLEND'**
  String get saveBlend;

  /// Action to save edits to an existing item.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES'**
  String get saveChanges;

  /// Copy for the create protocol savePhase UI.
  ///
  /// In en, this message translates to:
  /// **'SAVE PHASE'**
  String get savePhase;

  /// Copy for the create protocol savedVialPreset UI.
  ///
  /// In en, this message translates to:
  /// **'{amount} {unit} vial · Saved preset'**
  String savedVialPreset(String amount, String unit);

  /// Copy for the create protocol scheduleLabel UI.
  ///
  /// In en, this message translates to:
  /// **'SCHEDULE'**
  String get scheduleLabel;

  /// Copy for the create protocol searchCompounds UI.
  ///
  /// In en, this message translates to:
  /// **'Search compounds...'**
  String get searchCompounds;

  /// Copy for the create protocol selectDayError UI.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day to schedule this peptide.'**
  String get selectDayError;

  /// Copy for the create protocol selectOption UI.
  ///
  /// In en, this message translates to:
  /// **'Select {option}'**
  String selectOption(String option);

  /// Copy for the create protocol startDateLabel UI.
  ///
  /// In en, this message translates to:
  /// **'START DATE'**
  String get startDateLabel;

  /// Copy for the create protocol startWeekLabel UI.
  ///
  /// In en, this message translates to:
  /// **'START WEEK'**
  String get startWeekLabel;

  /// Copy for the create protocol syringeUnitsAmount UI.
  ///
  /// In en, this message translates to:
  /// **'{amount} syringe units'**
  String syringeUnitsAmount(String amount);

  /// Copy for the create protocol syringeUnitsDisclaimer UI.
  ///
  /// In en, this message translates to:
  /// **'Optional user-entered U-100 syringe markings for tracking only.'**
  String get syringeUnitsDisclaimer;

  /// Copy for the create protocol syringeUnitsHint UI.
  ///
  /// In en, this message translates to:
  /// **'e.g. 12.5'**
  String get syringeUnitsHint;

  /// Copy for the create protocol syringeUnitsLabel UI.
  ///
  /// In en, this message translates to:
  /// **'syringe units'**
  String get syringeUnitsLabel;

  /// Copy for the create protocol syringeUnitsOptional UI.
  ///
  /// In en, this message translates to:
  /// **'SYRINGE UNITS OPTIONAL'**
  String get syringeUnitsOptional;

  /// Copy for the create protocol trackedAmountLabel UI.
  ///
  /// In en, this message translates to:
  /// **'TRACKED AMOUNT'**
  String get trackedAmountLabel;

  /// Copy for the create protocol u100TrackingDisclaimer UI.
  ///
  /// In en, this message translates to:
  /// **'Uses U-100 syringe markings (100 units = 1 mL). Values are user-entered tracking data.'**
  String get u100TrackingDisclaimer;

  /// Copy for the create protocol unitLabel UI.
  ///
  /// In en, this message translates to:
  /// **'UNIT'**
  String get unitLabel;

  /// Copy for the create protocol vialAmountHint UI.
  ///
  /// In en, this message translates to:
  /// **'Vial amount'**
  String get vialAmountHint;

  /// Copy for the create protocol vialContentsLabel UI.
  ///
  /// In en, this message translates to:
  /// **'VIAL CONTENTS'**
  String get vialContentsLabel;

  /// Copy for the create protocol vialLabelNameHint UI.
  ///
  /// In en, this message translates to:
  /// **'Name from vial label'**
  String get vialLabelNameHint;

  /// Copy for the create protocol weekNumber UI.
  ///
  /// In en, this message translates to:
  /// **'WEEK {week}'**
  String weekNumber(int week);

  /// Copy for the create protocol weekRange UI.
  ///
  /// In en, this message translates to:
  /// **'WEEKS {start}–{end}'**
  String weekRange(int start, int end);

  /// Copy for the create protocol weekToWeekPhases UI.
  ///
  /// In en, this message translates to:
  /// **'WEEK-TO-WEEK PHASES'**
  String get weekToWeekPhases;

  /// Copy for the create protocol weekdayDose UI.
  ///
  /// In en, this message translates to:
  /// **'{weekday} DOSE'**
  String weekdayDose(String weekday);

  /// Copy for the create protocol weekdaySchedule UI.
  ///
  /// In en, this message translates to:
  /// **'{weekday} SCHEDULE'**
  String weekdaySchedule(String weekday);

  /// Validation error for an invalid blended-vial draw.
  ///
  /// In en, this message translates to:
  /// **'Draw must be greater than zero and within the vial.'**
  String get doseDrawInvalid;

  /// Generic error shown when a dose update fails.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get doseGenericError;

  /// System heading when editing a recorded dose.
  ///
  /// In en, this message translates to:
  /// **'EDIT.DOSE'**
  String get doseEditSystemLabel;

  /// System heading when logging a scheduled dose.
  ///
  /// In en, this message translates to:
  /// **'LOG.DOSE'**
  String get doseLogSystemLabel;

  /// Field label for a blended-vial syringe draw.
  ///
  /// In en, this message translates to:
  /// **'DRAW'**
  String get doseDraw;

  /// Field label for a dose amount.
  ///
  /// In en, this message translates to:
  /// **'AMOUNT'**
  String get doseAmount;

  /// Unit suffix for a syringe draw.
  ///
  /// In en, this message translates to:
  /// **'units'**
  String get doseUnits;

  /// Field label for the actual dose time.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get doseTime;

  /// Accessibility label for opening the dose time picker.
  ///
  /// In en, this message translates to:
  /// **'Choose dose time'**
  String get doseChooseTime;

  /// Heading for the constituent amounts in one blended-vial draw.
  ///
  /// In en, this message translates to:
  /// **'BLEND SNAPSHOT // PER DRAW'**
  String get doseBlendSnapshot;

  /// Recorded syringe-unit amount for a scheduled dose.
  ///
  /// In en, this message translates to:
  /// **'{amount} syringe units recorded for this dose.'**
  String doseSyringeUnitsRecorded(String amount);

  /// Heading for injection-site selection.
  ///
  /// In en, this message translates to:
  /// **'INJECTION.SITE'**
  String get doseInjectionSite;

  /// Most recent injection site for the selected peptide.
  ///
  /// In en, this message translates to:
  /// **'LAST SITE FOR THIS PEPTIDE · {site}'**
  String doseLastSite(String site);

  /// Field label for dose notes.
  ///
  /// In en, this message translates to:
  /// **'NOTES'**
  String get doseNotes;

  /// Placeholder for an optional dose-notes field.
  ///
  /// In en, this message translates to:
  /// **'Optional...'**
  String get doseOptional;

  /// Action that returns a completed or skipped dose to pending.
  ///
  /// In en, this message translates to:
  /// **'MARK AS PENDING'**
  String get doseMarkPending;

  /// Action that saves edits to a dose record.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES'**
  String get doseSaveChanges;

  /// Action that marks the current dose as skipped.
  ///
  /// In en, this message translates to:
  /// **'Skip this dose'**
  String get doseSkip;

  /// System heading for the 30-day dose history.
  ///
  /// In en, this message translates to:
  /// **'DOSE.HISTORY // 30.DAY'**
  String get doseHistorySystemLabel;

  /// Title for completed and skipped dose history.
  ///
  /// In en, this message translates to:
  /// **'Logged doses'**
  String get doseHistoryTitle;

  /// Instructions for editing a dose-history record.
  ///
  /// In en, this message translates to:
  /// **'Tap a record to correct its amount, actual time, injection site, notes, or status.'**
  String get doseHistoryBody;

  /// Empty state for the 30-day dose history.
  ///
  /// In en, this message translates to:
  /// **'No logged doses in the last 30 days.'**
  String get doseHistoryEmpty;

  /// Action that opens or submits the previous-dose form.
  ///
  /// In en, this message translates to:
  /// **'LOG PREVIOUS DOSE'**
  String get doseLogPrevious;

  /// Skipped dose summary with its recorded date and time.
  ///
  /// In en, this message translates to:
  /// **'Skipped · {dateTime}'**
  String doseHistorySkipped(String dateTime);

  /// Completed dose summary with amount, units, date, and time.
  ///
  /// In en, this message translates to:
  /// **'{amount} {units} · {dateTime}'**
  String doseHistoryTaken(String amount, String units, String dateTime);

  /// Action label on a dose-history row.
  ///
  /// In en, this message translates to:
  /// **'EDIT'**
  String get doseEditAction;

  /// Validation error when a historical dose time is in the future.
  ///
  /// In en, this message translates to:
  /// **'Choose a past time to log.'**
  String get doseChoosePastTime;

  /// Error shown when saving a previous dose fails.
  ///
  /// In en, this message translates to:
  /// **'Could not log previous dose. Try again.'**
  String get dosePreviousError;

  /// System heading for manually logging a previous dose.
  ///
  /// In en, this message translates to:
  /// **'LOG.PREVIOUS'**
  String get doseLogPreviousSystemLabel;

  /// Title when no peptide can be selected for a previous dose.
  ///
  /// In en, this message translates to:
  /// **'No peptides available'**
  String get doseNoPeptides;

  /// Instructions when no peptide can be selected for a previous dose.
  ///
  /// In en, this message translates to:
  /// **'Add a peptide to an active protocol before logging history.'**
  String get doseNoPeptidesBody;

  /// Title for manually adding a previous dose.
  ///
  /// In en, this message translates to:
  /// **'Correct dose history'**
  String get doseCorrectHistory;

  /// Field label for peptide selection.
  ///
  /// In en, this message translates to:
  /// **'PEPTIDE'**
  String get dosePeptide;

  /// Field label for the previous dose date.
  ///
  /// In en, this message translates to:
  /// **'DATE'**
  String get doseDate;

  /// Accessibility label for opening the dose date picker.
  ///
  /// In en, this message translates to:
  /// **'Choose dose date'**
  String get doseChooseDate;

  /// Recorded syringe-unit amount for a historical dose entry.
  ///
  /// In en, this message translates to:
  /// **'{amount} syringe units recorded for this entry.'**
  String doseSyringeUnitsEntry(String amount);

  /// Safety disclaimer for manually entered dose history.
  ///
  /// In en, this message translates to:
  /// **'Historical logs are personal tracking records only. They do not change medical guidance or dosing recommendations.'**
  String get doseHistoryDisclaimer;

  /// Name of the operating-system notification channel for dose reminders.
  ///
  /// In en, this message translates to:
  /// **'Dose Reminders'**
  String get notificationChannelName;

  /// Description of the operating-system notification channel.
  ///
  /// In en, this message translates to:
  /// **'Scheduled reminders for your active peptide protocol doses.'**
  String get notificationChannelDescription;

  /// Title of a scheduled dose notification.
  ///
  /// In en, this message translates to:
  /// **'Time for your dose'**
  String get notificationDoseTitle;

  /// Body of a scheduled dose notification.
  ///
  /// In en, this message translates to:
  /// **'Your scheduled protocol reminder is ready.'**
  String get notificationDoseBody;

  /// Title of a protocol cycle checkpoint notification.
  ///
  /// In en, this message translates to:
  /// **'Protocol checkpoint'**
  String get notificationCycleTitle;

  /// Body of a protocol cycle checkpoint notification.
  ///
  /// In en, this message translates to:
  /// **'A cycle-window reminder is due today. Review your tracking plan.'**
  String get notificationCycleBody;

  /// Title of a protocol rest-period checkpoint notification.
  ///
  /// In en, this message translates to:
  /// **'Rest period checkpoint'**
  String get notificationRestTitle;

  /// Body of a protocol rest-period checkpoint notification.
  ///
  /// In en, this message translates to:
  /// **'A rest-period reminder is due today. Review your tracking plan.'**
  String get notificationRestBody;

  /// Title of a protocol phase checkpoint notification.
  ///
  /// In en, this message translates to:
  /// **'Protocol phase checkpoint'**
  String get notificationPhaseTitle;

  /// Body of a protocol phase checkpoint notification.
  ///
  /// In en, this message translates to:
  /// **'A new tracking phase starts today. Review your saved schedule.'**
  String get notificationPhaseBody;

  /// System-style heading for the personal compound library.
  ///
  /// In en, this message translates to:
  /// **'SYS.LIBRARY // PERSONAL'**
  String get personalLibrarySystemLabel;

  /// Safety-focused introduction to personal compound presets.
  ///
  /// In en, this message translates to:
  /// **'Save labels and vial sizes you enter yourself. Presets are tracking shortcuts—not dose guidance.'**
  String get customCompoundIntro;

  /// Heading above archived personal compound presets.
  ///
  /// In en, this message translates to:
  /// **'ARCHIVED'**
  String get archivedHeading;

  /// Heading above active personal compound presets.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE PRESETS'**
  String get activePresetsHeading;

  /// Action to show active personal compound presets.
  ///
  /// In en, this message translates to:
  /// **'Show active'**
  String get showActive;

  /// Action to show archived personal compound presets.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archivedAction;

  /// Generic personal compound loading error.
  ///
  /// In en, this message translates to:
  /// **'Could not load your compounds. Try again.'**
  String get customCompoundsLoadFailed;

  /// Generic peptide library loading error.
  ///
  /// In en, this message translates to:
  /// **'Could not load the peptide library. Try again.'**
  String get libraryLoadFailed;

  /// Summary of a personal compound vial and route.
  ///
  /// In en, this message translates to:
  /// **'{amount} {unit} vial · {route}'**
  String compoundVialSummary(String amount, String unit, String route);

  /// Action to edit a personal compound preset.
  ///
  /// In en, this message translates to:
  /// **'Edit preset'**
  String get editPreset;

  /// Action to restore an archived personal compound preset.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restorePreset;

  /// Action to archive a personal compound preset.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archivePreset;

  /// Empty-state title when no archived personal presets exist.
  ///
  /// In en, this message translates to:
  /// **'No archived presets'**
  String get noArchivedPresets;

  /// Empty-state title when no personal compounds exist.
  ///
  /// In en, this message translates to:
  /// **'No saved compounds'**
  String get noSavedCompounds;

  /// Empty-state explanation for archived personal presets.
  ///
  /// In en, this message translates to:
  /// **'Archived presets stay here until you restore them.'**
  String get archivedPresetsHint;

  /// Empty-state explanation for personal compound presets.
  ///
  /// In en, this message translates to:
  /// **'Create a reusable label and vial-size preset.'**
  String get createPresetHint;

  /// System-style heading in the personal compound editor.
  ///
  /// In en, this message translates to:
  /// **'PRESET.COMPOUND'**
  String get presetCompoundSystemLabel;

  /// Title when creating a personal compound preset.
  ///
  /// In en, this message translates to:
  /// **'New compound'**
  String get newCompound;

  /// Title when editing a personal compound preset.
  ///
  /// In en, this message translates to:
  /// **'Edit compound'**
  String get editCompound;

  /// Instruction in the personal compound editor.
  ///
  /// In en, this message translates to:
  /// **'Enter only the details printed on your own vial.'**
  String get ownVialDetailsHint;

  /// Label for a personal compound name field.
  ///
  /// In en, this message translates to:
  /// **'COMPOUND LABEL'**
  String get compoundLabel;

  /// Example personal compound name.
  ///
  /// In en, this message translates to:
  /// **'e.g. My compound'**
  String get compoundNameExample;

  /// Label for a personal compound vial unit selector.
  ///
  /// In en, this message translates to:
  /// **'VIAL UNIT'**
  String get vialUnitLabel;

  /// Label for a personal compound tracking unit selector.
  ///
  /// In en, this message translates to:
  /// **'TRACKING UNIT'**
  String get trackingUnitLabel;

  /// Label for an optional personal compound note.
  ///
  /// In en, this message translates to:
  /// **'NOTES OPTIONAL'**
  String get notesOptional;

  /// Example note for a personal compound preset.
  ///
  /// In en, this message translates to:
  /// **'Label or storage note'**
  String get compoundNoteExample;

  /// Safety disclaimer in the personal compound editor.
  ///
  /// In en, this message translates to:
  /// **'No dosing recommendation is created. Protocol amounts are always entered separately by you.'**
  String get noDoseRecommendation;

  /// Generic personal compound save error.
  ///
  /// In en, this message translates to:
  /// **'Could not save preset. Try again.'**
  String get saveCompoundFailed;

  /// Topical administration route.
  ///
  /// In en, this message translates to:
  /// **'Topical'**
  String get routeTopical;

  /// Frequency using user-selected weekdays.
  ///
  /// In en, this message translates to:
  /// **'Custom days'**
  String get frequencyCustomDays;

  /// Title of a saved vial conversion.
  ///
  /// In en, this message translates to:
  /// **'{vialAmount} {vialUnit} + {diluentVolume} mL'**
  String savedCalculationLabel(
    String vialAmount,
    String vialUnit,
    String diluentVolume,
  );

  /// Detail of a saved vial conversion.
  ///
  /// In en, this message translates to:
  /// **'{desiredAmount} {desiredUnit} · {capacity}u'**
  String savedCalculationDetail(
    String desiredAmount,
    String desiredUnit,
    String capacity,
  );

  /// U-100 syringe capacity option.
  ///
  /// In en, this message translates to:
  /// **'U-100 · {volume} mL / {capacity} unit'**
  String syringeOption(String volume, String capacity);

  /// Educational reference description for HCG.
  ///
  /// In en, this message translates to:
  /// **'Human chorionic gonadotropin (HCG) is a glycoprotein hormone used in regulated clinical settings and frequently discussed alongside peptide protocols. This entry is provided as a neutral tracking reference for user-entered schedules.'**
  String get peptideContentHcgDescription;

  /// Reference amount text for HCG; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'User-entered IU'**
  String get peptideContentHcgTypicalDose;

  /// Educational half-life reference for HCG.
  ///
  /// In en, this message translates to:
  /// **'~24-36 hours'**
  String get peptideContentHcgHalfLife;

  /// Neutral educational notes for HCG; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Prescription-only in many jurisdictions. Track only what has already been directed by a qualified healthcare professional; PepMod does not provide HCG dosing guidance.'**
  String get peptideContentHcgNotes;

  /// Educational reference description for BPC-157.
  ///
  /// In en, this message translates to:
  /// **'BPC-157 (Body Protection Compound 157) is a 15-amino-acid synthetic peptide derived from a protein found in gastric juice. It has been studied in animal models for its role in soft-tissue and gut-lining repair. Human clinical data remains limited.'**
  String get peptideContentBpc157Description;

  /// Reference amount text for BPC-157; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'250–500 mcg'**
  String get peptideContentBpc157TypicalDose;

  /// Educational half-life reference for BPC-157.
  ///
  /// In en, this message translates to:
  /// **'~4 hours'**
  String get peptideContentBpc157HalfLife;

  /// Neutral educational notes for BPC-157; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Reconstitute with bacteriostatic water and store refrigerated. Commonly stacked with TB-500 for tendon and ligament recovery protocols in animal studies.'**
  String get peptideContentBpc157Notes;

  /// Educational reference description for TB-500.
  ///
  /// In en, this message translates to:
  /// **'TB-500 is a synthetic fragment of the naturally occurring protein thymosin beta-4. In animal studies it has been investigated for roles in cellular migration and tissue regeneration. It is widely used off-label by researchers and in veterinary settings.'**
  String get peptideContentTb500Description;

  /// Reference amount text for TB-500; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'2–5 mg weekly loading, then 2 mg maintenance'**
  String get peptideContentTb500TypicalDose;

  /// Educational half-life reference for TB-500.
  ///
  /// In en, this message translates to:
  /// **'~2 days'**
  String get peptideContentTb500HalfLife;

  /// Neutral educational notes for TB-500; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Often paired with BPC-157 for soft-tissue protocols. Split dosing twice weekly is common due to long half-life.'**
  String get peptideContentTb500Notes;

  /// Educational reference description for GHK-Cu.
  ///
  /// In en, this message translates to:
  /// **'GHK-Cu (Copper Peptide) is a naturally occurring copper-binding tripeptide present in human plasma. It has been studied in topical cosmetic applications for skin remodelling and hair-follicle signalling.'**
  String get peptideContentGhkCuDescription;

  /// Reference amount text for GHK-Cu; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'1–2 mg'**
  String get peptideContentGhkCuTypicalDose;

  /// Educational half-life reference for GHK-Cu.
  ///
  /// In en, this message translates to:
  /// **'~1 hour'**
  String get peptideContentGhkCuHalfLife;

  /// Neutral educational notes for GHK-Cu; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Also used topically in skincare formulations. Subcutaneous dosing is typically lower than topical concentrations.'**
  String get peptideContentGhkCuNotes;

  /// Educational reference description for Epitalon.
  ///
  /// In en, this message translates to:
  /// **'Epitalon is a synthetic tetrapeptide analogue of epithalamin, a peptide extracted from the pineal gland. Russian research has explored its effects on telomerase activity and circadian regulation.'**
  String get peptideContentEpitalonDescription;

  /// Reference amount text for Epitalon; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'5–10 mg per cycle day'**
  String get peptideContentEpitalonTypicalDose;

  /// Educational half-life reference for Epitalon.
  ///
  /// In en, this message translates to:
  /// **'~30 minutes'**
  String get peptideContentEpitalonHalfLife;

  /// Neutral educational notes for Epitalon; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Typically run in short pulsed cycles (e.g., 10–20 days on, months off) based on Russian longevity research protocols.'**
  String get peptideContentEpitalonNotes;

  /// Educational reference description for Semaglutide.
  ///
  /// In en, this message translates to:
  /// **'Semaglutide is a GLP-1 receptor agonist originally developed for type 2 diabetes and later approved for chronic weight management under brand names Ozempic and Wegovy. It slows gastric emptying and modulates appetite signalling.'**
  String get peptideContentSemaglutideDescription;

  /// Reference amount text for Semaglutide; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'0.25–2.4 mg weekly (titrated)'**
  String get peptideContentSemaglutideTypicalDose;

  /// Educational half-life reference for Semaglutide.
  ///
  /// In en, this message translates to:
  /// **'~7 days'**
  String get peptideContentSemaglutideHalfLife;

  /// Neutral educational notes for Semaglutide; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Prescription only in most countries. Titration schedule starts low and increases every 4 weeks to manage GI side effects.'**
  String get peptideContentSemaglutideNotes;

  /// Educational reference description for Tirzepatide.
  ///
  /// In en, this message translates to:
  /// **'Tirzepatide is a dual GIP/GLP-1 receptor agonist approved for type 2 diabetes (Mounjaro) and obesity (Zepbound). Clinical trials have shown it to produce larger weight reductions than single-agonist GLP-1s.'**
  String get peptideContentTirzepatideDescription;

  /// Reference amount text for Tirzepatide; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'2.5–15 mg weekly (titrated)'**
  String get peptideContentTirzepatideTypicalDose;

  /// Educational half-life reference for Tirzepatide.
  ///
  /// In en, this message translates to:
  /// **'~5 days'**
  String get peptideContentTirzepatideHalfLife;

  /// Neutral educational notes for Tirzepatide; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Prescription only in most countries. Standard titration is 4-week increments. Injected subcutaneously once weekly.'**
  String get peptideContentTirzepatideNotes;

  /// Educational reference description for Retatrutide.
  ///
  /// In en, this message translates to:
  /// **'Retatrutide is an investigational triple agonist targeting GIP, GLP-1, and glucagon receptors. Phase 2 trials reported weight reductions exceeding those of existing GLP-1-based therapies.'**
  String get peptideContentRetatrutideDescription;

  /// Reference amount text for Retatrutide; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'Trial doses 1–12 mg weekly'**
  String get peptideContentRetatrutideTypicalDose;

  /// Educational half-life reference for Retatrutide.
  ///
  /// In en, this message translates to:
  /// **'~6 days'**
  String get peptideContentRetatrutideHalfLife;

  /// Neutral educational notes for Retatrutide; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Still investigational — not FDA approved at time of writing. Any use outside a clinical trial is strictly research-only.'**
  String get peptideContentRetatrutideNotes;

  /// Educational reference description for Ipamorelin.
  ///
  /// In en, this message translates to:
  /// **'Ipamorelin is a pentapeptide ghrelin-mimetic and selective growth-hormone secretagogue. It has been investigated for its ability to stimulate a pulsatile GH release with minimal effect on cortisol or prolactin.'**
  String get peptideContentIpamorelinDescription;

  /// Reference amount text for Ipamorelin; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'200–300 mcg per injection'**
  String get peptideContentIpamorelinTypicalDose;

  /// Educational half-life reference for Ipamorelin.
  ///
  /// In en, this message translates to:
  /// **'~2 hours'**
  String get peptideContentIpamorelinHalfLife;

  /// Neutral educational notes for Ipamorelin; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Commonly stacked with CJC-1295 (no DAC) for a synergistic GH pulse. Typical timing: before bed and/or pre-workout on an empty stomach.'**
  String get peptideContentIpamorelinNotes;

  /// Educational reference description for CJC-1295 (with DAC).
  ///
  /// In en, this message translates to:
  /// **'CJC-1295 is a synthetic GHRH analogue. The DAC (Drug Affinity Complex) variant binds to serum albumin, extending its half-life and producing sustained GH levels rather than discrete pulses.'**
  String get peptideContentCjc1295DacDescription;

  /// Reference amount text for CJC-1295 (with DAC); this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'1–2 mg weekly'**
  String get peptideContentCjc1295DacTypicalDose;

  /// Educational half-life reference for CJC-1295 (with DAC).
  ///
  /// In en, this message translates to:
  /// **'~8 days'**
  String get peptideContentCjc1295DacHalfLife;

  /// Neutral educational notes for CJC-1295 (with DAC); preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Long-acting — typically dosed once or twice per week. Elevates baseline GH/IGF-1 rather than producing sharp pulses.'**
  String get peptideContentCjc1295DacNotes;

  /// Educational reference description for CJC-1295 (no DAC).
  ///
  /// In en, this message translates to:
  /// **'CJC-1295 without DAC — also known as Mod-GRF(1-29) — is a GHRH analogue with a short half-life. It is typically combined with a GHRP such as Ipamorelin to trigger natural pulsatile GH release.'**
  String get peptideContentCjc1295NoDacDescription;

  /// Reference amount text for CJC-1295 (no DAC); this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'100 mcg per injection'**
  String get peptideContentCjc1295NoDacTypicalDose;

  /// Educational half-life reference for CJC-1295 (no DAC).
  ///
  /// In en, this message translates to:
  /// **'~30 minutes'**
  String get peptideContentCjc1295NoDacHalfLife;

  /// Neutral educational notes for CJC-1295 (no DAC); preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Short acting — stack with a GHRP (Ipamorelin, GHRP-2, GHRP-6) to amplify GH pulses. Usually dosed 1–3x per day on an empty stomach.'**
  String get peptideContentCjc1295NoDacNotes;

  /// Educational reference description for Tesamorelin.
  ///
  /// In en, this message translates to:
  /// **'Tesamorelin is a stabilised GHRH analogue approved to reduce excess abdominal visceral fat in HIV-associated lipodystrophy (brand name Egrifta). It has also been studied in cognitive ageing contexts.'**
  String get peptideContentTesamorelinDescription;

  /// Reference amount text for Tesamorelin; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'1–2 mg daily'**
  String get peptideContentTesamorelinTypicalDose;

  /// Educational half-life reference for Tesamorelin.
  ///
  /// In en, this message translates to:
  /// **'~30 minutes'**
  String get peptideContentTesamorelinHalfLife;

  /// Neutral educational notes for Tesamorelin; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Prescription medication. Primarily studied for visceral adipose tissue reduction. Administered once daily subcutaneously.'**
  String get peptideContentTesamorelinNotes;

  /// Educational reference description for MOTS-c.
  ///
  /// In en, this message translates to:
  /// **'MOTS-c is a mitochondrial-derived peptide encoded within the MT-RNR1 gene. Research has investigated its role in metabolic homeostasis, insulin sensitivity, and exercise physiology.'**
  String get peptideContentMotsCDescription;

  /// Reference amount text for MOTS-c; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'5–10 mg 2–3x per week'**
  String get peptideContentMotsCTypicalDose;

  /// Educational half-life reference for MOTS-c.
  ///
  /// In en, this message translates to:
  /// **'~90 minutes'**
  String get peptideContentMotsCHalfLife;

  /// Neutral educational notes for MOTS-c; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Research still emerging. Some users report improved exercise recovery and metabolic markers in self-experiment logs.'**
  String get peptideContentMotsCNotes;

  /// Educational reference description for Cerebrolysin.
  ///
  /// In en, this message translates to:
  /// **'Cerebrolysin is a mixture of low-molecular-weight peptides and amino acids derived from porcine brain tissue. It is prescribed in several European and Asian countries for neurodegenerative and stroke-recovery indications.'**
  String get peptideContentCerebrolysinDescription;

  /// Reference amount text for Cerebrolysin; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'5–30 ml ampoules (clinical setting)'**
  String get peptideContentCerebrolysinTypicalDose;

  /// Educational half-life reference for Cerebrolysin.
  ///
  /// In en, this message translates to:
  /// **'Variable (mixture)'**
  String get peptideContentCerebrolysinHalfLife;

  /// Neutral educational notes for Cerebrolysin; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Typically administered as a course under clinical supervision. Not available in the US. Research in ischemic stroke and Alzheimer\'s disease.'**
  String get peptideContentCerebrolysinNotes;

  /// Educational reference description for Selank.
  ///
  /// In en, this message translates to:
  /// **'Selank is a synthetic heptapeptide developed in Russia as an analogue of the immunomodulatory peptide tuftsin. It has been studied for anxiolytic effects without the sedation or dependence of benzodiazepines.'**
  String get peptideContentSelankDescription;

  /// Reference amount text for Selank; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'250–500 mcg intranasally'**
  String get peptideContentSelankTypicalDose;

  /// Educational half-life reference for Selank.
  ///
  /// In en, this message translates to:
  /// **'~few minutes (systemic)'**
  String get peptideContentSelankHalfLife;

  /// Neutral educational notes for Selank; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Most commonly administered intranasally. Russian research focuses on anxiety and attention. Short half-life but reported effects last several hours.'**
  String get peptideContentSelankNotes;

  /// Educational reference description for Semax.
  ///
  /// In en, this message translates to:
  /// **'Semax is a synthetic heptapeptide derived from a fragment of ACTH (4–10). Russian research has investigated its nootropic and neuroprotective effects, particularly in stroke recovery protocols.'**
  String get peptideContentSemaxDescription;

  /// Reference amount text for Semax; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'250–1000 mcg intranasally'**
  String get peptideContentSemaxTypicalDose;

  /// Educational half-life reference for Semax.
  ///
  /// In en, this message translates to:
  /// **'~30 minutes'**
  String get peptideContentSemaxHalfLife;

  /// Neutral educational notes for Semax; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Intranasal administration is typical. Approved in Russia for ischaemic stroke. Often cycled with Selank for complementary effects.'**
  String get peptideContentSemaxNotes;

  /// Educational reference description for Melanotan II.
  ///
  /// In en, this message translates to:
  /// **'Melanotan II is a synthetic analogue of the alpha-melanocyte-stimulating hormone (α-MSH). It was originally developed as a potential sunless tanning agent and has also been associated with appetite and libido effects.'**
  String get peptideContentMelanotanIiDescription;

  /// Reference amount text for Melanotan II; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'250–1000 mcg loading, then maintenance'**
  String get peptideContentMelanotanIiTypicalDose;

  /// Educational half-life reference for Melanotan II.
  ///
  /// In en, this message translates to:
  /// **'~1 hour'**
  String get peptideContentMelanotanIiHalfLife;

  /// Neutral educational notes for Melanotan II; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Not approved for any medical use. Common reported side effects include nausea and darkening of existing moles. Any new or changing mole should be evaluated by a dermatologist.'**
  String get peptideContentMelanotanIiNotes;

  /// Educational reference description for PT-141 (Bremelanotide).
  ///
  /// In en, this message translates to:
  /// **'PT-141, also known as Bremelanotide and marketed as Vyleesi, is a melanocortin receptor agonist approved by the FDA for hypoactive sexual desire disorder in premenopausal women. It acts on central nervous system pathways.'**
  String get peptideContentPt141Description;

  /// Reference amount text for PT-141 (Bremelanotide); this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'1.25–1.75 mg as needed'**
  String get peptideContentPt141TypicalDose;

  /// Educational half-life reference for PT-141 (Bremelanotide).
  ///
  /// In en, this message translates to:
  /// **'~2 hours'**
  String get peptideContentPt141HalfLife;

  /// Neutral educational notes for PT-141 (Bremelanotide); preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Prescription medication in some markets. Taken as needed rather than on a fixed schedule. Common side effects include nausea and transient blood pressure increases.'**
  String get peptideContentPt141Notes;

  /// Educational reference description for DSIP.
  ///
  /// In en, this message translates to:
  /// **'Delta Sleep-Inducing Peptide (DSIP) is a nonapeptide isolated from rabbit brain in the 1970s. It has been studied for possible roles in sleep regulation, pain modulation, and stress response, though mechanisms remain unclear.'**
  String get peptideContentDsipDescription;

  /// Reference amount text for DSIP; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'100–500 mcg before bed'**
  String get peptideContentDsipTypicalDose;

  /// Educational half-life reference for DSIP.
  ///
  /// In en, this message translates to:
  /// **'~7 minutes'**
  String get peptideContentDsipHalfLife;

  /// Neutral educational notes for DSIP; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Typically administered before bed. Short plasma half-life but reported effects may outlast it. Evidence base remains limited.'**
  String get peptideContentDsipNotes;

  /// Educational reference description for Thymosin Alpha-1.
  ///
  /// In en, this message translates to:
  /// **'Thymosin Alpha-1 is a 28-amino-acid peptide originally isolated from thymus tissue. It has been approved in multiple countries as an adjunct immune-modulating therapy (brand name Zadaxin) for hepatitis B and C.'**
  String get peptideContentThymosinAlpha1Description;

  /// Reference amount text for Thymosin Alpha-1; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'1.6 mg twice weekly'**
  String get peptideContentThymosinAlpha1TypicalDose;

  /// Educational half-life reference for Thymosin Alpha-1.
  ///
  /// In en, this message translates to:
  /// **'~2 hours'**
  String get peptideContentThymosinAlpha1HalfLife;

  /// Neutral educational notes for Thymosin Alpha-1; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Used in several international markets as part of immune-modulation protocols. Typically administered twice weekly. Research continues in various indications.'**
  String get peptideContentThymosinAlpha1Notes;

  /// Educational reference description for NAD+.
  ///
  /// In en, this message translates to:
  /// **'NAD+ (nicotinamide adenine dinucleotide) is a coenzyme central to cellular energy metabolism and DNA repair. Injectable NAD+ and its precursors (NR, NMN) are studied in the context of mitochondrial health and ageing.'**
  String get peptideContentNadPlusDescription;

  /// Reference amount text for NAD+; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'100–500 mg IV or SubQ per session'**
  String get peptideContentNadPlusTypicalDose;

  /// Educational half-life reference for NAD+.
  ///
  /// In en, this message translates to:
  /// **'~90 minutes'**
  String get peptideContentNadPlusHalfLife;

  /// Neutral educational notes for NAD+; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Technically a coenzyme rather than a peptide, but commonly grouped with longevity protocols. Slow infusion is recommended to minimise flushing and discomfort.'**
  String get peptideContentNadPlusNotes;

  /// Educational reference description for Sermorelin.
  ///
  /// In en, this message translates to:
  /// **'Sermorelin is a synthetic analogue of growth hormone-releasing hormone (GHRH). It has been used clinically as a diagnostic agent for growth-hormone reserve and is commonly discussed in wellness settings as a GH-axis support peptide.'**
  String get peptideContentSermorelinDescription;

  /// Reference amount text for Sermorelin; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'100–300 mcg before bed'**
  String get peptideContentSermorelinTypicalDose;

  /// Educational half-life reference for Sermorelin.
  ///
  /// In en, this message translates to:
  /// **'~10–20 minutes'**
  String get peptideContentSermorelinHalfLife;

  /// Neutral educational notes for Sermorelin; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Often compared with CJC-1295 no-DAC because both act on the GHRH pathway. Short half-life makes evening dosing common in non-clinical protocols.'**
  String get peptideContentSermorelinNotes;

  /// Educational reference description for AOD-9604.
  ///
  /// In en, this message translates to:
  /// **'AOD-9604 is a modified fragment of human growth hormone, derived from the 176–191 region. It has been investigated for metabolic and lipolysis signalling, but published human evidence is limited and mixed.'**
  String get peptideContentAod9604Description;

  /// Reference amount text for AOD-9604; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'250–500 mcg daily'**
  String get peptideContentAod9604TypicalDose;

  /// Educational half-life reference for AOD-9604.
  ///
  /// In en, this message translates to:
  /// **'~30 minutes'**
  String get peptideContentAod9604HalfLife;

  /// Neutral educational notes for AOD-9604; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Also called HGH fragment 176–191 in some discussions. Not an approved weight-loss drug; use neutral tracking language and avoid outcome guarantees.'**
  String get peptideContentAod9604Notes;

  /// Educational reference description for KPV.
  ///
  /// In en, this message translates to:
  /// **'KPV is a short tripeptide sequence (lysine-proline-valine) derived from alpha-melanocyte-stimulating hormone. It is discussed in research contexts for immune and gut-barrier signalling.'**
  String get peptideContentKpvDescription;

  /// Reference amount text for KPV; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'250–500 mcg daily'**
  String get peptideContentKpvTypicalDose;

  /// Educational half-life reference for KPV.
  ///
  /// In en, this message translates to:
  /// **'Not well established'**
  String get peptideContentKpvHalfLife;

  /// Neutral educational notes for KPV; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Appears in gut-health and topical discussions, including informal stacks with BPC-157. Human dosing evidence is limited, so protocols should be conservative.'**
  String get peptideContentKpvNotes;

  /// Educational reference description for SS-31 (Elamipretide).
  ///
  /// In en, this message translates to:
  /// **'SS-31, also known as Elamipretide, is a mitochondria-targeted tetrapeptide studied for interactions with cardiolipin and mitochondrial membrane function. Clinical research has focused on rare mitochondrial and cardiac conditions.'**
  String get peptideContentSs31Description;

  /// Reference amount text for SS-31 (Elamipretide); this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'Trial protocols vary'**
  String get peptideContentSs31TypicalDose;

  /// Educational half-life reference for SS-31 (Elamipretide).
  ///
  /// In en, this message translates to:
  /// **'~4 hours'**
  String get peptideContentSs31HalfLife;

  /// Neutral educational notes for SS-31 (Elamipretide); preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Investigational in many contexts. Community protocols often differ from clinical-trial formulations and should be treated as research-only.'**
  String get peptideContentSs31Notes;

  /// Educational reference description for LL-37.
  ///
  /// In en, this message translates to:
  /// **'LL-37 is a human cathelicidin antimicrobial peptide involved in innate immune signalling. It is discussed in research communities for host-defense and tissue-response pathways, but safety considerations are significant.'**
  String get peptideContentLl37Description;

  /// Reference amount text for LL-37; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'Research protocols vary'**
  String get peptideContentLl37TypicalDose;

  /// Educational half-life reference for LL-37.
  ///
  /// In en, this message translates to:
  /// **'Not well established'**
  String get peptideContentLl37HalfLife;

  /// Neutral educational notes for LL-37; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Highly experimental outside controlled research. Because antimicrobial peptides can affect immune signalling, conservative educational framing is important.'**
  String get peptideContentLl37Notes;

  /// Educational reference description for Dihexa.
  ///
  /// In en, this message translates to:
  /// **'Dihexa is an orally active angiotensin IV-derived peptide analogue studied preclinically for hepatocyte growth factor/c-Met signalling and synaptogenic activity. Human safety and efficacy data are not established.'**
  String get peptideContentDihexaDescription;

  /// Reference amount text for Dihexa; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'Research-only; protocols vary'**
  String get peptideContentDihexaTypicalDose;

  /// Educational half-life reference for Dihexa.
  ///
  /// In en, this message translates to:
  /// **'Not well established'**
  String get peptideContentDihexaHalfLife;

  /// Neutral educational notes for Dihexa; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Popular in nootropic discussions but very experimental. Treat as a research compound entry rather than a suggested protocol.'**
  String get peptideContentDihexaNotes;

  /// Educational reference description for GHRP-2.
  ///
  /// In en, this message translates to:
  /// **'GHRP-2 is a synthetic growth hormone-releasing peptide that acts as a ghrelin receptor agonist. It has been studied for GH secretion, appetite signalling, and endocrine testing.'**
  String get peptideContentGhrp2Description;

  /// Reference amount text for GHRP-2; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'100–300 mcg per injection'**
  String get peptideContentGhrp2TypicalDose;

  /// Educational half-life reference for GHRP-2.
  ///
  /// In en, this message translates to:
  /// **'~20–30 minutes'**
  String get peptideContentGhrp2HalfLife;

  /// Neutral educational notes for GHRP-2; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Often paired with a GHRH analogue such as CJC-1295 no-DAC or Sermorelin. It may affect appetite, cortisol, and prolactin more than Ipamorelin.'**
  String get peptideContentGhrp2Notes;

  /// Educational reference description for GHRP-6.
  ///
  /// In en, this message translates to:
  /// **'GHRP-6 is a synthetic hexapeptide and ghrelin receptor agonist studied for growth-hormone release and appetite signalling. It is one of the older peptides in the GHRP family.'**
  String get peptideContentGhrp6Description;

  /// Reference amount text for GHRP-6; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'100–300 mcg per injection'**
  String get peptideContentGhrp6TypicalDose;

  /// Educational half-life reference for GHRP-6.
  ///
  /// In en, this message translates to:
  /// **'~20–30 minutes'**
  String get peptideContentGhrp6HalfLife;

  /// Neutral educational notes for GHRP-6; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Community use often emphasises appetite stimulation. More selective options such as Ipamorelin are commonly preferred when appetite effects are unwanted.'**
  String get peptideContentGhrp6Notes;

  /// Educational reference description for Hexarelin.
  ///
  /// In en, this message translates to:
  /// **'Hexarelin is a synthetic growth hormone secretagogue and ghrelin receptor agonist studied for GH release and cardiovascular research signals. It is generally considered one of the more potent GHRPs.'**
  String get peptideContentHexarelinDescription;

  /// Reference amount text for Hexarelin; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'100–200 mcg per injection'**
  String get peptideContentHexarelinTypicalDose;

  /// Educational half-life reference for Hexarelin.
  ///
  /// In en, this message translates to:
  /// **'~70 minutes'**
  String get peptideContentHexarelinHalfLife;

  /// Neutral educational notes for Hexarelin; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Often cycled more conservatively than Ipamorelin due to potency and desensitisation concerns discussed in research communities.'**
  String get peptideContentHexarelinNotes;

  /// Educational reference description for IGF-1 LR3.
  ///
  /// In en, this message translates to:
  /// **'IGF-1 LR3 is a modified insulin-like growth factor-1 analogue with amino-acid substitutions that reduce binding-protein affinity and extend activity. It is discussed mostly in advanced performance and cell-growth research contexts.'**
  String get peptideContentIgf1Lr3Description;

  /// Reference amount text for IGF-1 LR3; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'20–50 mcg daily in research protocols'**
  String get peptideContentIgf1Lr3TypicalDose;

  /// Educational half-life reference for IGF-1 LR3.
  ///
  /// In en, this message translates to:
  /// **'~20–30 hours'**
  String get peptideContentIgf1Lr3HalfLife;

  /// Neutral educational notes for IGF-1 LR3; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Higher-risk research compound. Potential glucose and tissue-growth signalling concerns make medical supervision especially important.'**
  String get peptideContentIgf1Lr3Notes;

  /// Educational reference description for IGF-1 DES.
  ///
  /// In en, this message translates to:
  /// **'IGF-1 DES is a shorter IGF-1 analogue missing the first three amino acids. It is discussed as a shorter-acting IGF variant in local tissue-signalling research.'**
  String get peptideContentIgf1DesDescription;

  /// Reference amount text for IGF-1 DES; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'20–50 mcg in research protocols'**
  String get peptideContentIgf1DesTypicalDose;

  /// Educational half-life reference for IGF-1 DES.
  ///
  /// In en, this message translates to:
  /// **'~20–30 minutes'**
  String get peptideContentIgf1DesHalfLife;

  /// Neutral educational notes for IGF-1 DES; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Very advanced and experimental. Avoid broad protocol suggestions because human safety data and appropriate monitoring are limited.'**
  String get peptideContentIgf1DesNotes;

  /// Educational reference description for PEG-MGF.
  ///
  /// In en, this message translates to:
  /// **'PEG-MGF is a pegylated variant of mechano growth factor, an IGF-1 splice-variant peptide. The pegylation is intended to extend circulation time compared with unmodified MGF.'**
  String get peptideContentPegMgfDescription;

  /// Reference amount text for PEG-MGF; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'100–300 mcg weekly in research protocols'**
  String get peptideContentPegMgfTypicalDose;

  /// Educational half-life reference for PEG-MGF.
  ///
  /// In en, this message translates to:
  /// **'Extended by PEGylation'**
  String get peptideContentPegMgfHalfLife;

  /// Neutral educational notes for PEG-MGF; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Common in performance forums but not an approved therapy. Treat as an advanced research entry with conservative tracking defaults.'**
  String get peptideContentPegMgfNotes;

  /// Educational reference description for MK-677 (Ibutamoren).
  ///
  /// In en, this message translates to:
  /// **'MK-677, also known as Ibutamoren, is an orally active ghrelin receptor agonist and growth-hormone secretagogue. It is not a peptide, but it is commonly discussed alongside GH-axis peptides.'**
  String get peptideContentMk677Description;

  /// Reference amount text for MK-677 (Ibutamoren); this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'10–25 mg daily'**
  String get peptideContentMk677TypicalDose;

  /// Educational half-life reference for MK-677 (Ibutamoren).
  ///
  /// In en, this message translates to:
  /// **'~24 hours'**
  String get peptideContentMk677HalfLife;

  /// Neutral educational notes for MK-677 (Ibutamoren); preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Related compound, not a peptide. Community discussions often mention appetite, water retention, sleep, and glucose-monitoring considerations.'**
  String get peptideContentMk677Notes;

  /// Educational reference description for 5-Amino-1MQ.
  ///
  /// In en, this message translates to:
  /// **'5-Amino-1MQ is a small-molecule NNMT inhibitor discussed in metabolic and body-composition communities. It is not a peptide, but it often appears in peptide-adjacent longevity and fat-loss stacks.'**
  String get peptideContentFiveAmino1mqDescription;

  /// Reference amount text for 5-Amino-1MQ; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'25–100 mg daily'**
  String get peptideContentFiveAmino1mqTypicalDose;

  /// Educational half-life reference for 5-Amino-1MQ.
  ///
  /// In en, this message translates to:
  /// **'Not well established'**
  String get peptideContentFiveAmino1mqHalfLife;

  /// Neutral educational notes for 5-Amino-1MQ; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Related compound, not a peptide. Human evidence is limited; avoid claims about fat loss or insulin sensitivity outcomes.'**
  String get peptideContentFiveAmino1mqNotes;

  /// Educational reference description for Tesofensine.
  ///
  /// In en, this message translates to:
  /// **'Tesofensine is an oral monoamine reuptake inhibitor investigated for obesity and neurodegenerative conditions. It is not a peptide, but it is frequently discussed in weight-management communities near GLP-1 compounds.'**
  String get peptideContentTesofensineDescription;

  /// Reference amount text for Tesofensine; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'0.25–0.5 mg daily in studies'**
  String get peptideContentTesofensineTypicalDose;

  /// Educational half-life reference for Tesofensine.
  ///
  /// In en, this message translates to:
  /// **'~9 days'**
  String get peptideContentTesofensineHalfLife;

  /// Neutral educational notes for Tesofensine; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Related compound, not a peptide. Because it affects neurotransmitter pathways, blood pressure, heart rate, and interaction screening matter.'**
  String get peptideContentTesofensineNotes;

  /// Educational reference description for RU-58841.
  ///
  /// In en, this message translates to:
  /// **'RU-58841 is a topical nonsteroidal antiandrogen researched for androgen-receptor signalling in hair-follicle contexts. It is not a peptide, but it is often discussed in peptide-adjacent aesthetic communities.'**
  String get peptideContentRu58841Description;

  /// Reference amount text for RU-58841; this is not a dosing recommendation.
  ///
  /// In en, this message translates to:
  /// **'Topical 25–50 mg daily in informal protocols'**
  String get peptideContentRu58841TypicalDose;

  /// Educational half-life reference for RU-58841.
  ///
  /// In en, this message translates to:
  /// **'Not well established'**
  String get peptideContentRu58841HalfLife;

  /// Neutral educational notes for RU-58841; preserve non-prescriptive framing.
  ///
  /// In en, this message translates to:
  /// **'Related compound, not a peptide and not an approved medication. Quality-control and systemic exposure concerns are common discussion points.'**
  String get peptideContentRu58841Notes;

  /// Safety disclaimer shown below every bundled peptide reference. Preserve educational-only, non-medical-advice wording.
  ///
  /// In en, this message translates to:
  /// **'For educational reference only. Not medical advice. Research peptides are not approved for human use in most jurisdictions — always consult a qualified healthcare provider.'**
  String get peptideContentEducationalDisclaimer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
