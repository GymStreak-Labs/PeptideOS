import '../../../l10n/app_localizations.dart';
import '../../../models/peptide.dart';
import 'library_labels.dart';

/// Customer-facing reference copy for a peptide.
///
/// Canonical [Peptide] values remain stable for Firestore and protocol logic;
/// bundled reference prose is translated only at the presentation boundary.
class LocalizedPeptideContent {
  const LocalizedPeptideContent({
    required this.description,
    required this.typicalDose,
    required this.halfLife,
    required this.notes,
    required this.disclaimer,
  });

  final String description;
  final String typicalDose;
  final String halfLife;
  final String notes;
  final String disclaimer;

  Iterable<String> searchTerms(AppLocalizations l10n, Peptide peptide) =>
      <String>[
        peptide.name,
        localizedPeptideCategoryLabel(l10n, peptide.category),
        description,
        typicalDose,
        halfLife,
        notes,
      ];
}

LocalizedPeptideContent localizedPeptideContent(
  AppLocalizations l10n,
  Peptide peptide,
) => switch (peptide.slug) {
  'hcg' => LocalizedPeptideContent(
    description: l10n.peptideContentHcgDescription,
    typicalDose: l10n.peptideContentHcgTypicalDose,
    halfLife: l10n.peptideContentHcgHalfLife,
    notes: l10n.peptideContentHcgNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'bpc-157' => LocalizedPeptideContent(
    description: l10n.peptideContentBpc157Description,
    typicalDose: l10n.peptideContentBpc157TypicalDose,
    halfLife: l10n.peptideContentBpc157HalfLife,
    notes: l10n.peptideContentBpc157Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'tb-500' => LocalizedPeptideContent(
    description: l10n.peptideContentTb500Description,
    typicalDose: l10n.peptideContentTb500TypicalDose,
    halfLife: l10n.peptideContentTb500HalfLife,
    notes: l10n.peptideContentTb500Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'ghk-cu' => LocalizedPeptideContent(
    description: l10n.peptideContentGhkCuDescription,
    typicalDose: l10n.peptideContentGhkCuTypicalDose,
    halfLife: l10n.peptideContentGhkCuHalfLife,
    notes: l10n.peptideContentGhkCuNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'epitalon' => LocalizedPeptideContent(
    description: l10n.peptideContentEpitalonDescription,
    typicalDose: l10n.peptideContentEpitalonTypicalDose,
    halfLife: l10n.peptideContentEpitalonHalfLife,
    notes: l10n.peptideContentEpitalonNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'semaglutide' => LocalizedPeptideContent(
    description: l10n.peptideContentSemaglutideDescription,
    typicalDose: l10n.peptideContentSemaglutideTypicalDose,
    halfLife: l10n.peptideContentSemaglutideHalfLife,
    notes: l10n.peptideContentSemaglutideNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'tirzepatide' => LocalizedPeptideContent(
    description: l10n.peptideContentTirzepatideDescription,
    typicalDose: l10n.peptideContentTirzepatideTypicalDose,
    halfLife: l10n.peptideContentTirzepatideHalfLife,
    notes: l10n.peptideContentTirzepatideNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'retatrutide' => LocalizedPeptideContent(
    description: l10n.peptideContentRetatrutideDescription,
    typicalDose: l10n.peptideContentRetatrutideTypicalDose,
    halfLife: l10n.peptideContentRetatrutideHalfLife,
    notes: l10n.peptideContentRetatrutideNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'ipamorelin' => LocalizedPeptideContent(
    description: l10n.peptideContentIpamorelinDescription,
    typicalDose: l10n.peptideContentIpamorelinTypicalDose,
    halfLife: l10n.peptideContentIpamorelinHalfLife,
    notes: l10n.peptideContentIpamorelinNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'cjc-1295-dac' => LocalizedPeptideContent(
    description: l10n.peptideContentCjc1295DacDescription,
    typicalDose: l10n.peptideContentCjc1295DacTypicalDose,
    halfLife: l10n.peptideContentCjc1295DacHalfLife,
    notes: l10n.peptideContentCjc1295DacNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'cjc-1295-no-dac' => LocalizedPeptideContent(
    description: l10n.peptideContentCjc1295NoDacDescription,
    typicalDose: l10n.peptideContentCjc1295NoDacTypicalDose,
    halfLife: l10n.peptideContentCjc1295NoDacHalfLife,
    notes: l10n.peptideContentCjc1295NoDacNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'tesamorelin' => LocalizedPeptideContent(
    description: l10n.peptideContentTesamorelinDescription,
    typicalDose: l10n.peptideContentTesamorelinTypicalDose,
    halfLife: l10n.peptideContentTesamorelinHalfLife,
    notes: l10n.peptideContentTesamorelinNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'mots-c' => LocalizedPeptideContent(
    description: l10n.peptideContentMotsCDescription,
    typicalDose: l10n.peptideContentMotsCTypicalDose,
    halfLife: l10n.peptideContentMotsCHalfLife,
    notes: l10n.peptideContentMotsCNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'cerebrolysin' => LocalizedPeptideContent(
    description: l10n.peptideContentCerebrolysinDescription,
    typicalDose: l10n.peptideContentCerebrolysinTypicalDose,
    halfLife: l10n.peptideContentCerebrolysinHalfLife,
    notes: l10n.peptideContentCerebrolysinNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'selank' => LocalizedPeptideContent(
    description: l10n.peptideContentSelankDescription,
    typicalDose: l10n.peptideContentSelankTypicalDose,
    halfLife: l10n.peptideContentSelankHalfLife,
    notes: l10n.peptideContentSelankNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'semax' => LocalizedPeptideContent(
    description: l10n.peptideContentSemaxDescription,
    typicalDose: l10n.peptideContentSemaxTypicalDose,
    halfLife: l10n.peptideContentSemaxHalfLife,
    notes: l10n.peptideContentSemaxNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'melanotan-ii' => LocalizedPeptideContent(
    description: l10n.peptideContentMelanotanIiDescription,
    typicalDose: l10n.peptideContentMelanotanIiTypicalDose,
    halfLife: l10n.peptideContentMelanotanIiHalfLife,
    notes: l10n.peptideContentMelanotanIiNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'pt-141' => LocalizedPeptideContent(
    description: l10n.peptideContentPt141Description,
    typicalDose: l10n.peptideContentPt141TypicalDose,
    halfLife: l10n.peptideContentPt141HalfLife,
    notes: l10n.peptideContentPt141Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'dsip' => LocalizedPeptideContent(
    description: l10n.peptideContentDsipDescription,
    typicalDose: l10n.peptideContentDsipTypicalDose,
    halfLife: l10n.peptideContentDsipHalfLife,
    notes: l10n.peptideContentDsipNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'thymosin-alpha-1' => LocalizedPeptideContent(
    description: l10n.peptideContentThymosinAlpha1Description,
    typicalDose: l10n.peptideContentThymosinAlpha1TypicalDose,
    halfLife: l10n.peptideContentThymosinAlpha1HalfLife,
    notes: l10n.peptideContentThymosinAlpha1Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'nad-plus' => LocalizedPeptideContent(
    description: l10n.peptideContentNadPlusDescription,
    typicalDose: l10n.peptideContentNadPlusTypicalDose,
    halfLife: l10n.peptideContentNadPlusHalfLife,
    notes: l10n.peptideContentNadPlusNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'sermorelin' => LocalizedPeptideContent(
    description: l10n.peptideContentSermorelinDescription,
    typicalDose: l10n.peptideContentSermorelinTypicalDose,
    halfLife: l10n.peptideContentSermorelinHalfLife,
    notes: l10n.peptideContentSermorelinNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'aod-9604' => LocalizedPeptideContent(
    description: l10n.peptideContentAod9604Description,
    typicalDose: l10n.peptideContentAod9604TypicalDose,
    halfLife: l10n.peptideContentAod9604HalfLife,
    notes: l10n.peptideContentAod9604Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'kpv' => LocalizedPeptideContent(
    description: l10n.peptideContentKpvDescription,
    typicalDose: l10n.peptideContentKpvTypicalDose,
    halfLife: l10n.peptideContentKpvHalfLife,
    notes: l10n.peptideContentKpvNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'ss-31' => LocalizedPeptideContent(
    description: l10n.peptideContentSs31Description,
    typicalDose: l10n.peptideContentSs31TypicalDose,
    halfLife: l10n.peptideContentSs31HalfLife,
    notes: l10n.peptideContentSs31Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'll-37' => LocalizedPeptideContent(
    description: l10n.peptideContentLl37Description,
    typicalDose: l10n.peptideContentLl37TypicalDose,
    halfLife: l10n.peptideContentLl37HalfLife,
    notes: l10n.peptideContentLl37Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'dihexa' => LocalizedPeptideContent(
    description: l10n.peptideContentDihexaDescription,
    typicalDose: l10n.peptideContentDihexaTypicalDose,
    halfLife: l10n.peptideContentDihexaHalfLife,
    notes: l10n.peptideContentDihexaNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'ghrp-2' => LocalizedPeptideContent(
    description: l10n.peptideContentGhrp2Description,
    typicalDose: l10n.peptideContentGhrp2TypicalDose,
    halfLife: l10n.peptideContentGhrp2HalfLife,
    notes: l10n.peptideContentGhrp2Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'ghrp-6' => LocalizedPeptideContent(
    description: l10n.peptideContentGhrp6Description,
    typicalDose: l10n.peptideContentGhrp6TypicalDose,
    halfLife: l10n.peptideContentGhrp6HalfLife,
    notes: l10n.peptideContentGhrp6Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'hexarelin' => LocalizedPeptideContent(
    description: l10n.peptideContentHexarelinDescription,
    typicalDose: l10n.peptideContentHexarelinTypicalDose,
    halfLife: l10n.peptideContentHexarelinHalfLife,
    notes: l10n.peptideContentHexarelinNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'igf-1-lr3' => LocalizedPeptideContent(
    description: l10n.peptideContentIgf1Lr3Description,
    typicalDose: l10n.peptideContentIgf1Lr3TypicalDose,
    halfLife: l10n.peptideContentIgf1Lr3HalfLife,
    notes: l10n.peptideContentIgf1Lr3Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'igf-1-des' => LocalizedPeptideContent(
    description: l10n.peptideContentIgf1DesDescription,
    typicalDose: l10n.peptideContentIgf1DesTypicalDose,
    halfLife: l10n.peptideContentIgf1DesHalfLife,
    notes: l10n.peptideContentIgf1DesNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'peg-mgf' => LocalizedPeptideContent(
    description: l10n.peptideContentPegMgfDescription,
    typicalDose: l10n.peptideContentPegMgfTypicalDose,
    halfLife: l10n.peptideContentPegMgfHalfLife,
    notes: l10n.peptideContentPegMgfNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'mk-677' => LocalizedPeptideContent(
    description: l10n.peptideContentMk677Description,
    typicalDose: l10n.peptideContentMk677TypicalDose,
    halfLife: l10n.peptideContentMk677HalfLife,
    notes: l10n.peptideContentMk677Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'five-amino-1mq' => LocalizedPeptideContent(
    description: l10n.peptideContentFiveAmino1mqDescription,
    typicalDose: l10n.peptideContentFiveAmino1mqTypicalDose,
    halfLife: l10n.peptideContentFiveAmino1mqHalfLife,
    notes: l10n.peptideContentFiveAmino1mqNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'tesofensine' => LocalizedPeptideContent(
    description: l10n.peptideContentTesofensineDescription,
    typicalDose: l10n.peptideContentTesofensineTypicalDose,
    halfLife: l10n.peptideContentTesofensineHalfLife,
    notes: l10n.peptideContentTesofensineNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'testosterone' => LocalizedPeptideContent(
    description: l10n.peptideContentTestosteroneDescription,
    typicalDose: l10n.peptideContentTestosteroneTypicalDose,
    halfLife: l10n.peptideContentTestosteroneHalfLife,
    notes: l10n.peptideContentTestosteroneNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'glutathione' => LocalizedPeptideContent(
    description: l10n.peptideContentGlutathioneDescription,
    typicalDose: l10n.peptideContentGlutathioneTypicalDose,
    halfLife: l10n.peptideContentGlutathioneHalfLife,
    notes: l10n.peptideContentGlutathioneNotes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'kisspeptin-10' => LocalizedPeptideContent(
    description: l10n.peptideContentKisspeptin10Description,
    typicalDose: l10n.peptideContentKisspeptin10TypicalDose,
    halfLife: l10n.peptideContentKisspeptin10HalfLife,
    notes: l10n.peptideContentKisspeptin10Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'slu-pp-332' => LocalizedPeptideContent(
    description: l10n.peptideContentSluPp332Description,
    typicalDose: l10n.peptideContentSluPp332TypicalDose,
    halfLife: l10n.peptideContentSluPp332HalfLife,
    notes: l10n.peptideContentSluPp332Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  'ru-58841' => LocalizedPeptideContent(
    description: l10n.peptideContentRu58841Description,
    typicalDose: l10n.peptideContentRu58841TypicalDose,
    halfLife: l10n.peptideContentRu58841HalfLife,
    notes: l10n.peptideContentRu58841Notes,
    disclaimer: l10n.peptideContentEducationalDisclaimer,
  ),
  _ => LocalizedPeptideContent(
    description: peptide.description,
    typicalDose: peptide.typicalDose,
    halfLife: peptide.halfLife,
    notes: peptide.notes,
    disclaimer: peptide.disclaimer,
  ),
};
