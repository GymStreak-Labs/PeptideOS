import '../../../l10n/app_localizations.dart';
import '../../../models/peptide.dart';
import '../../../models/protocol.dart';

String localizedPeptideCategoryLabel(
  AppLocalizations l10n,
  PeptideCategory category,
) => switch (category) {
  PeptideCategory.healing => l10n.categoryHealing,
  PeptideCategory.growthHormone => l10n.categoryGrowthHormone,
  PeptideCategory.cognitive => l10n.categoryCognitive,
  PeptideCategory.metabolic => l10n.categoryMetabolic,
  PeptideCategory.aesthetic => l10n.categoryAesthetic,
  PeptideCategory.longevity => l10n.categoryLongevity,
  PeptideCategory.other => l10n.categoryOther,
};

String localizedProtocolRouteLabel(AppLocalizations l10n, String key) =>
    switch (key) {
      'subcutaneous' => l10n.routeSubcutaneous,
      'intramuscular' => l10n.routeIntramuscular,
      'oral' => l10n.routeOral,
      'nasal' => l10n.routeNasal,
      'topical' => l10n.routeTopical,
      _ => key,
    };

String localizedProtocolFrequencyLabel(AppLocalizations l10n, String key) =>
    switch (key) {
      'daily' => l10n.frequencyDaily,
      'eod' => l10n.frequencyEveryOtherDay,
      'twice_weekly' => l10n.frequencyTwiceWeekly,
      'weekly' => l10n.frequencyWeekly,
      kCustomWeekdayFrequency => l10n.frequencyCustomDays,
      'as_needed' => l10n.frequencyAsNeeded,
      _ => key,
    };

String localizedProtocolStatusLabel(
  AppLocalizations l10n,
  ProtocolStatus status,
) => switch (status) {
  ProtocolStatus.active => l10n.statusActive,
  ProtocolStatus.paused => l10n.statusPaused,
  ProtocolStatus.ended => l10n.statusEnded,
};
