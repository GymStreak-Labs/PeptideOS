// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get libraryTitle => 'Biblioteca';

  @override
  String get librarySystemLabel => 'SYS.BANCO // COMPOSTOS';

  @override
  String get myCompounds => 'Meus compostos';

  @override
  String get unitConverter => 'Conversor de unidades';

  @override
  String get openUnitConverter => 'Abrir conversor de unidades';

  @override
  String get converterCardTitle => 'CONVERSOR DE UNIDADES';

  @override
  String get converterCardSubtitle => 'Converta os dados do frasco';

  @override
  String get converterCardHint =>
      'Para reconstituição, toque em um peptídeo abaixo.';

  @override
  String get searchPeptides => 'Buscar peptídeos...';

  @override
  String get categoryAll => 'Todos';

  @override
  String get categoryHealing => 'Recuperação';

  @override
  String get categoryGrowthHormone => 'Hormônio do crescimento';

  @override
  String get categoryCognitive => 'Cognitivo';

  @override
  String get categoryMetabolic => 'Metabólico';

  @override
  String get categoryAesthetic => 'Estética';

  @override
  String get categoryLongevity => 'Longevidade';

  @override
  String get categoryOther => 'Outros';

  @override
  String get libraryUnavailable => 'Biblioteca indisponível';

  @override
  String get retry => 'TENTAR NOVAMENTE';

  @override
  String get noPeptidesFound => 'Nenhum peptídeo encontrado';

  @override
  String get tryDifferentSearch =>
      'Tente outro termo de busca ou remova o filtro.';

  @override
  String get calculationSaved => 'Cálculo salvo nesta conta.';

  @override
  String get converterIntro =>
      'Insira os valores do seu frasco, diluente e plano. O PepMod converte esses dados em volume e unidades de seringa U-100.';

  @override
  String get vialAndDiluent => 'Frasco + diluente';

  @override
  String get iuSourceCaption =>
      'Fonte: UI no frasco e ml de diluente adicionados.';

  @override
  String get massSourceCaption => 'Fonte: rótulos do frasco e do diluente.';

  @override
  String get vialAmount => 'QUANTIDADE NO FRASCO';

  @override
  String get amountPrintedOnVial => 'Quantidade indicada no frasco';

  @override
  String get diluent => 'DILUENTE';

  @override
  String get volumeAdded => 'Volume adicionado';

  @override
  String get amountToConvert => 'Quantidade para converter';

  @override
  String get iuAmountCaption =>
      'Insira uma quantidade em UI que você já recebeu.';

  @override
  String get massAmountCaption => 'Fonte: uma quantidade que você já recebeu.';

  @override
  String get yourSyringe => 'Sua seringa';

  @override
  String get syringeCaption =>
      'Selecione a capacidade indicada no corpo da seringa.';

  @override
  String get educationalConverterDisclaimer =>
      'Ferramenta educativa apenas para conversão de unidades. O PepMod não recomenda quantidades nem frequências. Confira os rótulos originais e confirme o cálculo com um profissional de saúde qualificado antes do uso.';

  @override
  String get back => 'Voltar';

  @override
  String get vialWorkspace => 'Calculadora de frasco';

  @override
  String get conversionSystemLabel => 'UTIL.CONVERSÃO';

  @override
  String get measurementModeSystemLabel => 'MODO.MEDIÇÃO';

  @override
  String get conversionResultSystemLabel => 'RESULTADO.CONVERSÃO';

  @override
  String get savedVialsSystemLabel => 'FRASCOS.SALVOS';

  @override
  String get clear => 'LIMPAR';

  @override
  String get conversionOnly =>
      'Somente conversão — esta ferramenta nunca escolhe uma quantidade ou um horário.';

  @override
  String get sameUnitFamily =>
      'Use o mesmo tipo de unidade indicado no frasco.';

  @override
  String get mass => 'Massa';

  @override
  String get iuOnly => 'Somente UI';

  @override
  String get iuSafety =>
      'UI continua sendo UI. O PepMod não converte UI para mg/mcg nem o contrário.';

  @override
  String get enterAmount => 'Insira a quantidade';

  @override
  String get drawTo => 'PUXAR ATÉ';

  @override
  String get units => 'unidades';

  @override
  String get concentration => 'CONCENTRAÇÃO';

  @override
  String get syringeCapacity => 'CAPACIDADE DA SERINGA';

  @override
  String get capacityWarning =>
      'O volume convertido é maior que a capacidade desta seringa. Escolha a seringa correta ou confira os dados inseridos.';

  @override
  String get savePreset => 'SALVAR AJUSTE';

  @override
  String get savedVialsHint =>
      'Toque em um cálculo salvo para reutilizar os dados.';

  @override
  String get removeSavedCalculation => 'Remover cálculo salvo';

  @override
  String get errorPositiveNumbers =>
      'Insira um número maior que zero em todos os campos.';

  @override
  String get errorAmountAboveVial =>
      'A quantidade desejada é maior que a quantidade informada para este frasco.';

  @override
  String get errorConversion =>
      'Não foi possível converter esses valores. Confira cada dado.';

  @override
  String get halfLife => 'Meia-vida';

  @override
  String get weekCycle => 'sem de ciclo';

  @override
  String get typicalDose => 'DOSE TÍPICA';

  @override
  String get notes => 'OBSERVAÇÕES';

  @override
  String get commonStack => 'COMBINAÇÃO COMUM';

  @override
  String get reconstitutionTool => 'UTIL.RECONSTITUIÇÃO';

  @override
  String get compoundSystemLabel => 'DB.COMPOSTO';

  @override
  String get addToProtocol => 'ADICIONAR AO PROTOCOLO';

  @override
  String get vialShort => 'FRASCO (mg)';

  @override
  String get bacShort => 'BAC (ml)';

  @override
  String get doseShort => 'DOSE (mcg)';

  @override
  String get routeSubcutaneous => 'Subcutânea';

  @override
  String get routeIntramuscular => 'Intramuscular';

  @override
  String get routeOral => 'Oral';

  @override
  String get routeNasal => 'Nasal';

  @override
  String get frequencyDaily => 'Diariamente';

  @override
  String get frequencyEveryOtherDay => 'Em dias alternados';

  @override
  String get frequencyTwiceWeekly => '2 vezes por semana';

  @override
  String get frequencyWeekly => 'Semanalmente';

  @override
  String get frequencyAsNeeded => 'Conforme necessário';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get libraryTitle => 'Biblioteca';

  @override
  String get librarySystemLabel => 'SYS.BANCO // COMPOSTOS';

  @override
  String get myCompounds => 'Meus compostos';

  @override
  String get unitConverter => 'Conversor de unidades';

  @override
  String get openUnitConverter => 'Abrir conversor de unidades';

  @override
  String get converterCardTitle => 'CONVERSOR DE UNIDADES';

  @override
  String get converterCardSubtitle => 'Converta os dados do frasco';

  @override
  String get converterCardHint =>
      'Para reconstituição, toque em um peptídeo abaixo.';

  @override
  String get searchPeptides => 'Buscar peptídeos...';

  @override
  String get categoryAll => 'Todos';

  @override
  String get categoryHealing => 'Recuperação';

  @override
  String get categoryGrowthHormone => 'Hormônio do crescimento';

  @override
  String get categoryCognitive => 'Cognitivo';

  @override
  String get categoryMetabolic => 'Metabólico';

  @override
  String get categoryAesthetic => 'Estética';

  @override
  String get categoryLongevity => 'Longevidade';

  @override
  String get categoryOther => 'Outros';

  @override
  String get libraryUnavailable => 'Biblioteca indisponível';

  @override
  String get retry => 'TENTAR NOVAMENTE';

  @override
  String get noPeptidesFound => 'Nenhum peptídeo encontrado';

  @override
  String get tryDifferentSearch =>
      'Tente outro termo de busca ou remova o filtro.';

  @override
  String get calculationSaved => 'Cálculo salvo nesta conta.';

  @override
  String get converterIntro =>
      'Insira os valores do seu frasco, diluente e plano. O PepMod converte esses dados em volume e unidades de seringa U-100.';

  @override
  String get vialAndDiluent => 'Frasco + diluente';

  @override
  String get iuSourceCaption =>
      'Fonte: UI no frasco e ml de diluente adicionados.';

  @override
  String get massSourceCaption => 'Fonte: rótulos do frasco e do diluente.';

  @override
  String get vialAmount => 'QUANTIDADE NO FRASCO';

  @override
  String get amountPrintedOnVial => 'Quantidade indicada no frasco';

  @override
  String get diluent => 'DILUENTE';

  @override
  String get volumeAdded => 'Volume adicionado';

  @override
  String get amountToConvert => 'Quantidade para converter';

  @override
  String get iuAmountCaption =>
      'Insira uma quantidade em UI que você já recebeu.';

  @override
  String get massAmountCaption => 'Fonte: uma quantidade que você já recebeu.';

  @override
  String get yourSyringe => 'Sua seringa';

  @override
  String get syringeCaption =>
      'Selecione a capacidade indicada no corpo da seringa.';

  @override
  String get educationalConverterDisclaimer =>
      'Ferramenta educativa apenas para conversão de unidades. O PepMod não recomenda quantidades nem frequências. Confira os rótulos originais e confirme o cálculo com um profissional de saúde qualificado antes do uso.';

  @override
  String get back => 'Voltar';

  @override
  String get vialWorkspace => 'Calculadora de frasco';

  @override
  String get conversionSystemLabel => 'UTIL.CONVERSÃO';

  @override
  String get measurementModeSystemLabel => 'MODO.MEDIÇÃO';

  @override
  String get conversionResultSystemLabel => 'RESULTADO.CONVERSÃO';

  @override
  String get savedVialsSystemLabel => 'FRASCOS.SALVOS';

  @override
  String get clear => 'LIMPAR';

  @override
  String get conversionOnly =>
      'Somente conversão — esta ferramenta nunca escolhe uma quantidade ou um horário.';

  @override
  String get sameUnitFamily =>
      'Use o mesmo tipo de unidade indicado no frasco.';

  @override
  String get mass => 'Massa';

  @override
  String get iuOnly => 'Somente UI';

  @override
  String get iuSafety =>
      'UI continua sendo UI. O PepMod não converte UI para mg/mcg nem o contrário.';

  @override
  String get enterAmount => 'Insira a quantidade';

  @override
  String get drawTo => 'PUXAR ATÉ';

  @override
  String get units => 'unidades';

  @override
  String get concentration => 'CONCENTRAÇÃO';

  @override
  String get syringeCapacity => 'CAPACIDADE DA SERINGA';

  @override
  String get capacityWarning =>
      'O volume convertido é maior que a capacidade desta seringa. Escolha a seringa correta ou confira os dados inseridos.';

  @override
  String get savePreset => 'SALVAR AJUSTE';

  @override
  String get savedVialsHint =>
      'Toque em um cálculo salvo para reutilizar os dados.';

  @override
  String get removeSavedCalculation => 'Remover cálculo salvo';

  @override
  String get errorPositiveNumbers =>
      'Insira um número maior que zero em todos os campos.';

  @override
  String get errorAmountAboveVial =>
      'A quantidade desejada é maior que a quantidade informada para este frasco.';

  @override
  String get errorConversion =>
      'Não foi possível converter esses valores. Confira cada dado.';

  @override
  String get halfLife => 'Meia-vida';

  @override
  String get weekCycle => 'sem de ciclo';

  @override
  String get typicalDose => 'DOSE TÍPICA';

  @override
  String get notes => 'OBSERVAÇÕES';

  @override
  String get commonStack => 'COMBINAÇÃO COMUM';

  @override
  String get reconstitutionTool => 'UTIL.RECONSTITUIÇÃO';

  @override
  String get compoundSystemLabel => 'DB.COMPOSTO';

  @override
  String get addToProtocol => 'ADICIONAR AO PROTOCOLO';

  @override
  String get vialShort => 'FRASCO (mg)';

  @override
  String get bacShort => 'BAC (ml)';

  @override
  String get doseShort => 'DOSE (mcg)';

  @override
  String get routeSubcutaneous => 'Subcutânea';

  @override
  String get routeIntramuscular => 'Intramuscular';

  @override
  String get routeOral => 'Oral';

  @override
  String get routeNasal => 'Nasal';

  @override
  String get frequencyDaily => 'Diariamente';

  @override
  String get frequencyEveryOtherDay => 'Em dias alternados';

  @override
  String get frequencyTwiceWeekly => '2 vezes por semana';

  @override
  String get frequencyWeekly => 'Semanalmente';

  @override
  String get frequencyAsNeeded => 'Conforme necessário';
}
