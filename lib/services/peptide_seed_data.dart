import '../models/peptide.dart';

/// Factual peptide reference data used to seed the local library on first launch.
/// Wikipedia-like neutral tone. No medical claims. Every entry ends with a
/// mandatory educational-use disclaimer.
class PeptideSeedData {
  static const String _stdDisclaimer =
      'For educational reference only. Not medical advice. Research peptides are not approved for human use in most jurisdictions — always consult a qualified healthcare provider.';

  static List<Peptide> build() {
    return _entries.map((e) {
      final p = Peptide()
        ..slug = e.slug
        ..name = e.name
        ..category = e.category
        ..description = e.description
        ..typicalDose = e.typicalDose
        ..defaultDoseMcg = e.defaultDoseMcg
        ..defaultFrequency = e.defaultFrequency
        ..halfLife = e.halfLife
        ..typicalCycleWeeks = e.cycleWeeks
        ..defaultRoute = e.route
        ..commonStack = List<String>.from(e.stack)
        ..notes = e.notes
        ..disclaimer = _stdDisclaimer;
      return p;
    }).toList();
  }

  static const _entries = <_Seed>[
    _Seed(
      slug: 'bpc-157',
      name: 'BPC-157',
      category: PeptideCategory.healing,
      description:
          'BPC-157 (Body Protection Compound 157) is a 15-amino-acid synthetic peptide derived from a protein found in gastric juice. It has been studied in animal models for its role in soft-tissue and gut-lining repair. Human clinical data remains limited.',
      typicalDose: '250–500 mcg',
      defaultDoseMcg: 250,
      defaultFrequency: 'daily',
      halfLife: '~4 hours',
      cycleWeeks: 4,
      route: 'subcutaneous',
      stack: ['tb-500', 'ghk-cu'],
      notes:
          'Reconstitute with bacteriostatic water and store refrigerated. Commonly stacked with TB-500 for tendon and ligament recovery protocols in animal studies.',
    ),
    _Seed(
      slug: 'tb-500',
      name: 'TB-500',
      category: PeptideCategory.healing,
      description:
          'TB-500 is a synthetic fragment of the naturally occurring protein thymosin beta-4. In animal studies it has been investigated for roles in cellular migration and tissue regeneration. It is widely used off-label by researchers and in veterinary settings.',
      typicalDose: '2–5 mg weekly loading, then 2 mg maintenance',
      defaultDoseMcg: 2000,
      defaultFrequency: 'twice_weekly',
      halfLife: '~2 days',
      cycleWeeks: 6,
      route: 'subcutaneous',
      stack: ['bpc-157'],
      notes:
          'Often paired with BPC-157 for soft-tissue protocols. Split dosing twice weekly is common due to long half-life.',
    ),
    _Seed(
      slug: 'ghk-cu',
      name: 'GHK-Cu',
      category: PeptideCategory.aesthetic,
      description:
          'GHK-Cu (Copper Peptide) is a naturally occurring copper-binding tripeptide present in human plasma. It has been studied in topical cosmetic applications for skin remodelling and hair-follicle signalling.',
      typicalDose: '1–2 mg',
      defaultDoseMcg: 1500,
      defaultFrequency: 'daily',
      halfLife: '~1 hour',
      cycleWeeks: 8,
      route: 'subcutaneous',
      stack: ['bpc-157'],
      notes:
          'Also used topically in skincare formulations. Subcutaneous dosing is typically lower than topical concentrations.',
    ),
    _Seed(
      slug: 'epitalon',
      name: 'Epitalon',
      category: PeptideCategory.longevity,
      description:
          'Epitalon is a synthetic tetrapeptide analogue of epithalamin, a peptide extracted from the pineal gland. Russian research has explored its effects on telomerase activity and circadian regulation.',
      typicalDose: '5–10 mg per cycle day',
      defaultDoseMcg: 10000,
      defaultFrequency: 'daily',
      halfLife: '~30 minutes',
      cycleWeeks: 2,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Typically run in short pulsed cycles (e.g., 10–20 days on, months off) based on Russian longevity research protocols.',
    ),
    _Seed(
      slug: 'semaglutide',
      name: 'Semaglutide',
      category: PeptideCategory.metabolic,
      description:
          'Semaglutide is a GLP-1 receptor agonist originally developed for type 2 diabetes and later approved for chronic weight management under brand names Ozempic and Wegovy. It slows gastric emptying and modulates appetite signalling.',
      typicalDose: '0.25–2.4 mg weekly (titrated)',
      defaultDoseMcg: 250,
      defaultFrequency: 'weekly',
      halfLife: '~7 days',
      cycleWeeks: 0,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Prescription only in most countries. Titration schedule starts low and increases every 4 weeks to manage GI side effects.',
    ),
    _Seed(
      slug: 'tirzepatide',
      name: 'Tirzepatide',
      category: PeptideCategory.metabolic,
      description:
          'Tirzepatide is a dual GIP/GLP-1 receptor agonist approved for type 2 diabetes (Mounjaro) and obesity (Zepbound). Clinical trials have shown it to produce larger weight reductions than single-agonist GLP-1s.',
      typicalDose: '2.5–15 mg weekly (titrated)',
      defaultDoseMcg: 2500,
      defaultFrequency: 'weekly',
      halfLife: '~5 days',
      cycleWeeks: 0,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Prescription only in most countries. Standard titration is 4-week increments. Injected subcutaneously once weekly.',
    ),
    _Seed(
      slug: 'retatrutide',
      name: 'Retatrutide',
      category: PeptideCategory.metabolic,
      description:
          'Retatrutide is an investigational triple agonist targeting GIP, GLP-1, and glucagon receptors. Phase 2 trials reported weight reductions exceeding those of existing GLP-1-based therapies.',
      typicalDose: 'Trial doses 1–12 mg weekly',
      defaultDoseMcg: 2000,
      defaultFrequency: 'weekly',
      halfLife: '~6 days',
      cycleWeeks: 0,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Still investigational — not FDA approved at time of writing. Any use outside a clinical trial is strictly research-only.',
    ),
    _Seed(
      slug: 'ipamorelin',
      name: 'Ipamorelin',
      category: PeptideCategory.growthHormone,
      description:
          'Ipamorelin is a pentapeptide ghrelin-mimetic and selective growth-hormone secretagogue. It has been investigated for its ability to stimulate a pulsatile GH release with minimal effect on cortisol or prolactin.',
      typicalDose: '200–300 mcg per injection',
      defaultDoseMcg: 250,
      defaultFrequency: 'daily',
      halfLife: '~2 hours',
      cycleWeeks: 12,
      route: 'subcutaneous',
      stack: ['cjc-1295-no-dac'],
      notes:
          'Commonly stacked with CJC-1295 (no DAC) for a synergistic GH pulse. Typical timing: before bed and/or pre-workout on an empty stomach.',
    ),
    _Seed(
      slug: 'cjc-1295-dac',
      name: 'CJC-1295 (with DAC)',
      category: PeptideCategory.growthHormone,
      description:
          'CJC-1295 is a synthetic GHRH analogue. The DAC (Drug Affinity Complex) variant binds to serum albumin, extending its half-life and producing sustained GH levels rather than discrete pulses.',
      typicalDose: '1–2 mg weekly',
      defaultDoseMcg: 1000,
      defaultFrequency: 'weekly',
      halfLife: '~8 days',
      cycleWeeks: 12,
      route: 'subcutaneous',
      stack: ['ipamorelin'],
      notes:
          'Long-acting — typically dosed once or twice per week. Elevates baseline GH/IGF-1 rather than producing sharp pulses.',
    ),
    _Seed(
      slug: 'cjc-1295-no-dac',
      name: 'CJC-1295 (no DAC)',
      category: PeptideCategory.growthHormone,
      description:
          'CJC-1295 without DAC — also known as Mod-GRF(1-29) — is a GHRH analogue with a short half-life. It is typically combined with a GHRP such as Ipamorelin to trigger natural pulsatile GH release.',
      typicalDose: '100 mcg per injection',
      defaultDoseMcg: 100,
      defaultFrequency: 'daily',
      halfLife: '~30 minutes',
      cycleWeeks: 12,
      route: 'subcutaneous',
      stack: ['ipamorelin'],
      notes:
          'Short acting — stack with a GHRP (Ipamorelin, GHRP-2, GHRP-6) to amplify GH pulses. Usually dosed 1–3x per day on an empty stomach.',
    ),
    _Seed(
      slug: 'tesamorelin',
      name: 'Tesamorelin',
      category: PeptideCategory.growthHormone,
      description:
          'Tesamorelin is a stabilised GHRH analogue approved to reduce excess abdominal visceral fat in HIV-associated lipodystrophy (brand name Egrifta). It has also been studied in cognitive ageing contexts.',
      typicalDose: '1–2 mg daily',
      defaultDoseMcg: 1000,
      defaultFrequency: 'daily',
      halfLife: '~30 minutes',
      cycleWeeks: 12,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Prescription medication. Primarily studied for visceral adipose tissue reduction. Administered once daily subcutaneously.',
    ),
    _Seed(
      slug: 'mots-c',
      name: 'MOTS-c',
      category: PeptideCategory.metabolic,
      description:
          'MOTS-c is a mitochondrial-derived peptide encoded within the MT-RNR1 gene. Research has investigated its role in metabolic homeostasis, insulin sensitivity, and exercise physiology.',
      typicalDose: '5–10 mg 2–3x per week',
      defaultDoseMcg: 5000,
      defaultFrequency: 'twice_weekly',
      halfLife: '~90 minutes',
      cycleWeeks: 6,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Research still emerging. Some users report improved exercise recovery and metabolic markers in self-experiment logs.',
    ),
    _Seed(
      slug: 'cerebrolysin',
      name: 'Cerebrolysin',
      category: PeptideCategory.cognitive,
      description:
          'Cerebrolysin is a mixture of low-molecular-weight peptides and amino acids derived from porcine brain tissue. It is prescribed in several European and Asian countries for neurodegenerative and stroke-recovery indications.',
      typicalDose: '5–30 ml ampoules (clinical setting)',
      defaultDoseMcg: 5000,
      defaultFrequency: 'daily',
      halfLife: 'Variable (mixture)',
      cycleWeeks: 4,
      route: 'intramuscular',
      stack: ['semax'],
      notes:
          'Typically administered as a course under clinical supervision. Not available in the US. Research in ischemic stroke and Alzheimer\'s disease.',
    ),
    _Seed(
      slug: 'selank',
      name: 'Selank',
      category: PeptideCategory.cognitive,
      description:
          'Selank is a synthetic heptapeptide developed in Russia as an analogue of the immunomodulatory peptide tuftsin. It has been studied for anxiolytic effects without the sedation or dependence of benzodiazepines.',
      typicalDose: '250–500 mcg intranasally',
      defaultDoseMcg: 300,
      defaultFrequency: 'daily',
      halfLife: '~few minutes (systemic)',
      cycleWeeks: 2,
      route: 'nasal',
      stack: ['semax'],
      notes:
          'Most commonly administered intranasally. Russian research focuses on anxiety and attention. Short half-life but reported effects last several hours.',
    ),
    _Seed(
      slug: 'semax',
      name: 'Semax',
      category: PeptideCategory.cognitive,
      description:
          'Semax is a synthetic heptapeptide derived from a fragment of ACTH (4–10). Russian research has investigated its nootropic and neuroprotective effects, particularly in stroke recovery protocols.',
      typicalDose: '250–1000 mcg intranasally',
      defaultDoseMcg: 500,
      defaultFrequency: 'daily',
      halfLife: '~30 minutes',
      cycleWeeks: 2,
      route: 'nasal',
      stack: ['selank'],
      notes:
          'Intranasal administration is typical. Approved in Russia for ischaemic stroke. Often cycled with Selank for complementary effects.',
    ),
    _Seed(
      slug: 'melanotan-ii',
      name: 'Melanotan II',
      category: PeptideCategory.aesthetic,
      description:
          'Melanotan II is a synthetic analogue of the alpha-melanocyte-stimulating hormone (α-MSH). It was originally developed as a potential sunless tanning agent and has also been associated with appetite and libido effects.',
      typicalDose: '250–1000 mcg loading, then maintenance',
      defaultDoseMcg: 500,
      defaultFrequency: 'daily',
      halfLife: '~1 hour',
      cycleWeeks: 4,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Not approved for any medical use. Common reported side effects include nausea and darkening of existing moles. Any new or changing mole should be evaluated by a dermatologist.',
    ),
    _Seed(
      slug: 'pt-141',
      name: 'PT-141 (Bremelanotide)',
      category: PeptideCategory.aesthetic,
      description:
          'PT-141, also known as Bremelanotide and marketed as Vyleesi, is a melanocortin receptor agonist approved by the FDA for hypoactive sexual desire disorder in premenopausal women. It acts on central nervous system pathways.',
      typicalDose: '1.25–1.75 mg as needed',
      defaultDoseMcg: 1500,
      defaultFrequency: 'as_needed',
      halfLife: '~2 hours',
      cycleWeeks: 0,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Prescription medication in some markets. Taken as needed rather than on a fixed schedule. Common side effects include nausea and transient blood pressure increases.',
    ),
    _Seed(
      slug: 'dsip',
      name: 'DSIP',
      category: PeptideCategory.longevity,
      description:
          'Delta Sleep-Inducing Peptide (DSIP) is a nonapeptide isolated from rabbit brain in the 1970s. It has been studied for possible roles in sleep regulation, pain modulation, and stress response, though mechanisms remain unclear.',
      typicalDose: '100–500 mcg before bed',
      defaultDoseMcg: 250,
      defaultFrequency: 'daily',
      halfLife: '~7 minutes',
      cycleWeeks: 4,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Typically administered before bed. Short plasma half-life but reported effects may outlast it. Evidence base remains limited.',
    ),
    _Seed(
      slug: 'thymosin-alpha-1',
      name: 'Thymosin Alpha-1',
      category: PeptideCategory.healing,
      description:
          'Thymosin Alpha-1 is a 28-amino-acid peptide originally isolated from thymus tissue. It has been approved in multiple countries as an adjunct immune-modulating therapy (brand name Zadaxin) for hepatitis B and C.',
      typicalDose: '1.6 mg twice weekly',
      defaultDoseMcg: 1600,
      defaultFrequency: 'twice_weekly',
      halfLife: '~2 hours',
      cycleWeeks: 8,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Used in several international markets as part of immune-modulation protocols. Typically administered twice weekly. Research continues in various indications.',
    ),
    _Seed(
      slug: 'nad-plus',
      name: 'NAD+',
      category: PeptideCategory.longevity,
      description:
          'NAD+ (nicotinamide adenine dinucleotide) is a coenzyme central to cellular energy metabolism and DNA repair. Injectable NAD+ and its precursors (NR, NMN) are studied in the context of mitochondrial health and ageing.',
      typicalDose: '100–500 mg IV or SubQ per session',
      defaultDoseMcg: 100000,
      defaultFrequency: 'weekly',
      halfLife: '~90 minutes',
      cycleWeeks: 4,
      route: 'subcutaneous',
      stack: [],
      notes:
          'Technically a coenzyme rather than a peptide, but commonly grouped with longevity protocols. Slow infusion is recommended to minimise flushing and discomfort.',
    ),
  ];
}

class _Seed {
  const _Seed({
    required this.slug,
    required this.name,
    required this.category,
    required this.description,
    required this.typicalDose,
    required this.defaultDoseMcg,
    required this.defaultFrequency,
    required this.halfLife,
    required this.cycleWeeks,
    required this.route,
    required this.stack,
    required this.notes,
  });

  final String slug;
  final String name;
  final PeptideCategory category;
  final String description;
  final String typicalDose;
  final double defaultDoseMcg;
  final String defaultFrequency;
  final String halfLife;
  final int cycleWeeks;
  final String route;
  final List<String> stack;
  final String notes;
}
