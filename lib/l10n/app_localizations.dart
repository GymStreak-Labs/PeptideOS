import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

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
  ];

  /// No description provided for @libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryTitle;

  /// No description provided for @librarySystemLabel.
  ///
  /// In en, this message translates to:
  /// **'SYS.DATABASE // COMPOUNDS'**
  String get librarySystemLabel;

  /// No description provided for @myCompounds.
  ///
  /// In en, this message translates to:
  /// **'My compounds'**
  String get myCompounds;

  /// No description provided for @unitConverter.
  ///
  /// In en, this message translates to:
  /// **'Unit converter'**
  String get unitConverter;

  /// No description provided for @openUnitConverter.
  ///
  /// In en, this message translates to:
  /// **'Open unit converter'**
  String get openUnitConverter;

  /// No description provided for @converterCardTitle.
  ///
  /// In en, this message translates to:
  /// **'UNIT CONVERTER'**
  String get converterCardTitle;

  /// No description provided for @converterCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Convert vial math now'**
  String get converterCardSubtitle;

  /// No description provided for @converterCardHint.
  ///
  /// In en, this message translates to:
  /// **'For reconstitution, tap any peptide below.'**
  String get converterCardHint;

  /// No description provided for @searchPeptides.
  ///
  /// In en, this message translates to:
  /// **'Search peptides...'**
  String get searchPeptides;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryHealing.
  ///
  /// In en, this message translates to:
  /// **'Healing'**
  String get categoryHealing;

  /// No description provided for @categoryGrowthHormone.
  ///
  /// In en, this message translates to:
  /// **'Growth Hormone'**
  String get categoryGrowthHormone;

  /// No description provided for @categoryCognitive.
  ///
  /// In en, this message translates to:
  /// **'Cognitive'**
  String get categoryCognitive;

  /// No description provided for @categoryMetabolic.
  ///
  /// In en, this message translates to:
  /// **'Metabolic'**
  String get categoryMetabolic;

  /// No description provided for @categoryAesthetic.
  ///
  /// In en, this message translates to:
  /// **'Aesthetic'**
  String get categoryAesthetic;

  /// No description provided for @categoryLongevity.
  ///
  /// In en, this message translates to:
  /// **'Longevity'**
  String get categoryLongevity;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @libraryUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Library unavailable'**
  String get libraryUnavailable;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'RETRY'**
  String get retry;

  /// No description provided for @noPeptidesFound.
  ///
  /// In en, this message translates to:
  /// **'No peptides found'**
  String get noPeptidesFound;

  /// No description provided for @tryDifferentSearch.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term or clear the filter.'**
  String get tryDifferentSearch;

  /// No description provided for @calculationSaved.
  ///
  /// In en, this message translates to:
  /// **'Calculation saved to this account.'**
  String get calculationSaved;

  /// No description provided for @converterIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter values from your own vial, diluent, and plan. PepMod converts those values into volume and U-100 syringe units.'**
  String get converterIntro;

  /// No description provided for @vialAndDiluent.
  ///
  /// In en, this message translates to:
  /// **'Vial + diluent'**
  String get vialAndDiluent;

  /// No description provided for @iuSourceCaption.
  ///
  /// In en, this message translates to:
  /// **'Source: IU on your vial and mL of diluent added.'**
  String get iuSourceCaption;

  /// No description provided for @massSourceCaption.
  ///
  /// In en, this message translates to:
  /// **'Source: labels on your vial and diluent.'**
  String get massSourceCaption;

  /// No description provided for @vialAmount.
  ///
  /// In en, this message translates to:
  /// **'VIAL AMOUNT'**
  String get vialAmount;

  /// No description provided for @amountPrintedOnVial.
  ///
  /// In en, this message translates to:
  /// **'Amount printed on vial'**
  String get amountPrintedOnVial;

  /// No description provided for @diluent.
  ///
  /// In en, this message translates to:
  /// **'DILUENT'**
  String get diluent;

  /// No description provided for @volumeAdded.
  ///
  /// In en, this message translates to:
  /// **'Volume you added'**
  String get volumeAdded;

  /// No description provided for @amountToConvert.
  ///
  /// In en, this message translates to:
  /// **'Amount to convert'**
  String get amountToConvert;

  /// No description provided for @iuAmountCaption.
  ///
  /// In en, this message translates to:
  /// **'Enter an IU amount you were already given.'**
  String get iuAmountCaption;

  /// No description provided for @massAmountCaption.
  ///
  /// In en, this message translates to:
  /// **'Source: an amount you were already given.'**
  String get massAmountCaption;

  /// No description provided for @yourSyringe.
  ///
  /// In en, this message translates to:
  /// **'Your syringe'**
  String get yourSyringe;

  /// No description provided for @syringeCaption.
  ///
  /// In en, this message translates to:
  /// **'Select the capacity printed on the barrel.'**
  String get syringeCaption;

  /// No description provided for @educationalConverterDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Educational unit-conversion tool only. PepMod does not recommend an amount or frequency. Recheck the source labels and confirm your calculation with a qualified healthcare professional before use.'**
  String get educationalConverterDisclaimer;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @vialWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Vial workspace'**
  String get vialWorkspace;

  /// No description provided for @conversionSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'UTIL.CONVERSION'**
  String get conversionSystemLabel;

  /// No description provided for @measurementModeSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'MEASUREMENT.MODE'**
  String get measurementModeSystemLabel;

  /// No description provided for @conversionResultSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'CONVERSION.RESULT'**
  String get conversionResultSystemLabel;

  /// No description provided for @savedVialsSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'SAVED.VIALS'**
  String get savedVialsSystemLabel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'CLEAR'**
  String get clear;

  /// No description provided for @conversionOnly.
  ///
  /// In en, this message translates to:
  /// **'Conversion only — this workspace never chooses an amount or schedule.'**
  String get conversionOnly;

  /// No description provided for @sameUnitFamily.
  ///
  /// In en, this message translates to:
  /// **'Use the same unit family printed on the vial.'**
  String get sameUnitFamily;

  /// No description provided for @mass.
  ///
  /// In en, this message translates to:
  /// **'Mass'**
  String get mass;

  /// No description provided for @iuOnly.
  ///
  /// In en, this message translates to:
  /// **'IU only'**
  String get iuOnly;

  /// No description provided for @iuSafety.
  ///
  /// In en, this message translates to:
  /// **'IU stays IU. PepMod does not convert IU to or from mg/mcg.'**
  String get iuSafety;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @drawTo.
  ///
  /// In en, this message translates to:
  /// **'DRAW TO'**
  String get drawTo;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'units'**
  String get units;

  /// No description provided for @concentration.
  ///
  /// In en, this message translates to:
  /// **'CONCENTRATION'**
  String get concentration;

  /// No description provided for @syringeCapacity.
  ///
  /// In en, this message translates to:
  /// **'SYRINGE CAPACITY'**
  String get syringeCapacity;

  /// No description provided for @capacityWarning.
  ///
  /// In en, this message translates to:
  /// **'The converted volume is larger than this syringe capacity. Choose the correct syringe or recheck your entries.'**
  String get capacityWarning;

  /// No description provided for @savePreset.
  ///
  /// In en, this message translates to:
  /// **'SAVE PRESET'**
  String get savePreset;

  /// No description provided for @savedVialsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a saved calculation to reuse its inputs.'**
  String get savedVialsHint;

  /// No description provided for @removeSavedCalculation.
  ///
  /// In en, this message translates to:
  /// **'Remove saved calculation'**
  String get removeSavedCalculation;

  /// No description provided for @errorPositiveNumbers.
  ///
  /// In en, this message translates to:
  /// **'Enter a number greater than zero in every field.'**
  String get errorPositiveNumbers;

  /// No description provided for @errorAmountAboveVial.
  ///
  /// In en, this message translates to:
  /// **'Desired amount is greater than the amount entered for this vial.'**
  String get errorAmountAboveVial;

  /// No description provided for @errorConversion.
  ///
  /// In en, this message translates to:
  /// **'These values could not be converted. Recheck each entry.'**
  String get errorConversion;

  /// No description provided for @halfLife.
  ///
  /// In en, this message translates to:
  /// **'Half-life'**
  String get halfLife;

  /// No description provided for @weekCycle.
  ///
  /// In en, this message translates to:
  /// **'wk cycle'**
  String get weekCycle;

  /// No description provided for @typicalDose.
  ///
  /// In en, this message translates to:
  /// **'TYPICAL DOSE'**
  String get typicalDose;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'NOTES'**
  String get notes;

  /// No description provided for @commonStack.
  ///
  /// In en, this message translates to:
  /// **'COMMON.STACK'**
  String get commonStack;

  /// No description provided for @reconstitutionTool.
  ///
  /// In en, this message translates to:
  /// **'UTIL.RECONSTITUTION'**
  String get reconstitutionTool;

  /// No description provided for @compoundSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'DB.COMPOUND'**
  String get compoundSystemLabel;

  /// No description provided for @addToProtocol.
  ///
  /// In en, this message translates to:
  /// **'ADD TO PROTOCOL'**
  String get addToProtocol;

  /// No description provided for @vialShort.
  ///
  /// In en, this message translates to:
  /// **'VIAL (mg)'**
  String get vialShort;

  /// No description provided for @bacShort.
  ///
  /// In en, this message translates to:
  /// **'BAC (mL)'**
  String get bacShort;

  /// No description provided for @doseShort.
  ///
  /// In en, this message translates to:
  /// **'DOSE (mcg)'**
  String get doseShort;

  /// No description provided for @routeSubcutaneous.
  ///
  /// In en, this message translates to:
  /// **'Subcutaneous'**
  String get routeSubcutaneous;

  /// No description provided for @routeIntramuscular.
  ///
  /// In en, this message translates to:
  /// **'Intramuscular'**
  String get routeIntramuscular;

  /// No description provided for @routeOral.
  ///
  /// In en, this message translates to:
  /// **'Oral'**
  String get routeOral;

  /// No description provided for @routeNasal.
  ///
  /// In en, this message translates to:
  /// **'Nasal'**
  String get routeNasal;

  /// No description provided for @frequencyDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get frequencyDaily;

  /// No description provided for @frequencyEveryOtherDay.
  ///
  /// In en, this message translates to:
  /// **'Every other day'**
  String get frequencyEveryOtherDay;

  /// No description provided for @frequencyTwiceWeekly.
  ///
  /// In en, this message translates to:
  /// **'2x per week'**
  String get frequencyTwiceWeekly;

  /// No description provided for @frequencyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get frequencyWeekly;

  /// No description provided for @frequencyAsNeeded.
  ///
  /// In en, this message translates to:
  /// **'As needed'**
  String get frequencyAsNeeded;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
