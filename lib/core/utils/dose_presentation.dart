import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../features/profile/providers/settings_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_settings.dart';
import 'dose_units.dart';

extension DosePresentation on BuildContext {
  DoseUnitPreference get doseUnitPreference =>
      watch<SettingsProvider?>()?.settings.doseUnitPreference ??
      DoseUnitPreference.original;

  String displayDoseUnit(String storedUnit) =>
      preferredDoseUnit(storedUnit, doseUnitPreference);

  String displayDoseNumber(double amount, String storedUnit) =>
      formatDoseNumber(
        convertMassDose(amount, storedUnit, displayDoseUnit(storedUnit)),
        AppLocalizations.of(this).localeName,
      );

  String displayDose(double amount, String storedUnit) =>
      '${displayDoseNumber(amount, storedUnit)} ${displayDoseUnit(storedUnit)}';
}
