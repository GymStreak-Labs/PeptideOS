import 'package:flutter/widgets.dart';

import '../../../l10n/app_localizations.dart';

extension ProtocolLocalizationsContext on BuildContext {
  AppLocalizations get protocolL10n => AppLocalizations.of(this);
}

String localizedInjectionSiteLabel(AppLocalizations l10n, String key) =>
    switch (key) {
      'left-abdomen' => l10n.injectionSiteLeftAbdomen,
      'right-abdomen' => l10n.injectionSiteRightAbdomen,
      'left-thigh' => l10n.injectionSiteLeftThigh,
      'right-thigh' => l10n.injectionSiteRightThigh,
      'left-glute' => l10n.injectionSiteLeftGlute,
      'right-glute' => l10n.injectionSiteRightGlute,
      'left-triceps' => l10n.injectionSiteLeftTriceps,
      'right-triceps' => l10n.injectionSiteRightTriceps,
      'left-delt' => l10n.injectionSiteLeftDeltoid,
      'right-delt' => l10n.injectionSiteRightDeltoid,
      _ => key,
    };
