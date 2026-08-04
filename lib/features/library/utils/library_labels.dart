import '../../../l10n/app_localizations.dart';
import '../../../models/peptide.dart';

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
