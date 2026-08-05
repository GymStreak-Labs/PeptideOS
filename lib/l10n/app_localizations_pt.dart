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
  String get librarySystemLabel => 'SYS.BASE DE DADOS // COMPOSTOS';

  @override
  String get myCompounds => 'Os meus compostos';

  @override
  String get unitConverter => 'Conversor de unidades';

  @override
  String get openUnitConverter => 'Abrir conversor de unidades';

  @override
  String get converterCardTitle => 'CONVERSOR DE UNIDADES';

  @override
  String get converterCardSubtitle => 'Converta já os cálculos do frasco';

  @override
  String get converterCardHint =>
      'Para a reconstituição, toque em qualquer péptido abaixo.';

  @override
  String get searchPeptides => 'Buscar peptídeos...';

  @override
  String get categoryAll => 'Todos';

  @override
  String get categoryHealing => 'Recuperação';

  @override
  String get categoryGrowthHormone => 'Hormona do Crescimento';

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
  String get noPeptidesFound => 'Nenhum péptido encontrado';

  @override
  String get tryDifferentSearch =>
      'Tente outro termo de busca ou remova o filtro.';

  @override
  String get calculationSaved => 'Cálculo guardado nesta conta.';

  @override
  String get converterIntro =>
      'Introduza os valores do seu frasco, diluente e plano. O PepMod converte esses valores em volume e unidades de seringa U-100.';

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
  String get amountToConvert => 'Quantidade a converter';

  @override
  String get iuAmountCaption =>
      'Introduza uma quantidade em UI que já lhe foi indicada.';

  @override
  String get massAmountCaption => 'Fonte: uma quantidade que você já recebeu.';

  @override
  String get yourSyringe => 'A sua seringa';

  @override
  String get syringeCaption =>
      'Selecione a capacidade indicada no corpo da seringa.';

  @override
  String get educationalConverterDisclaimer =>
      'Ferramenta educativa de conversão de unidades apenas. O PepMod não recomenda uma quantidade nem uma frequência. Volte a verificar os rótulos de origem e confirme o seu cálculo com um profissional de saúde qualificado antes de utilizar.';

  @override
  String get back => 'Voltar';

  @override
  String get vialWorkspace => 'Espaço de trabalho do frasco';

  @override
  String get conversionSystemLabel => 'UTIL.CONVERSÃO';

  @override
  String get measurementModeSystemLabel => 'MEASUREMENT.MODE';

  @override
  String get conversionResultSystemLabel => 'RESULTADO.CONVERSÃO';

  @override
  String get savedVialsSystemLabel => 'FRASCOS.GUARDADOS';

  @override
  String get clear => 'LIMPAR';

  @override
  String get conversionOnly =>
      'Apenas conversão — este espaço de trabalho nunca escolhe uma quantidade ou um horário.';

  @override
  String get sameUnitFamily =>
      'Use o mesmo tipo de unidade indicado no frasco.';

  @override
  String get mass => 'Massa';

  @override
  String get iuOnly => 'Apenas UI';

  @override
  String get iuSafety =>
      'UI mantém-se UI. O PepMod não converte UI para mg/mcg nem o inverso.';

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
      'O volume convertido é superior à capacidade desta seringa. Escolha a seringa correta ou reveja os dados inseridos.';

  @override
  String get savePreset => 'GUARDAR AJUSTE';

  @override
  String get savedVialsHint =>
      'Toque num cálculo guardado para reutilizar os seus dados.';

  @override
  String get removeSavedCalculation => 'Remover cálculo salvo';

  @override
  String get errorPositiveNumbers =>
      'Insira um número superior a zero em todos os campos.';

  @override
  String get errorAmountAboveVial =>
      'A quantidade pretendida é superior à quantidade indicada para este frasco.';

  @override
  String get errorConversion =>
      'Não foi possível converter estes valores. Verifique cada entrada.';

  @override
  String get halfLife => 'Meia-vida';

  @override
  String get weekCycle => 'sem. de ciclo';

  @override
  String get typicalDose => 'DOSE TÍPICA';

  @override
  String get notes => 'NOTAS';

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

  @override
  String get tabProtocol => 'Protocolo';

  @override
  String get tabProgress => 'Progresso';

  @override
  String get tabLibrary => 'Biblioteca';

  @override
  String get tabYou => 'Eu';

  @override
  String get continueLabel => 'CONTINUAR';

  @override
  String get processingLabel => 'A PROCESSAR…';

  @override
  String get authAppleFailed =>
      'Falha ao iniciar sessão com a Apple. Tente novamente.';

  @override
  String get authGoogleFailed =>
      'Não foi possível iniciar sessão com o Google. Tente novamente.';

  @override
  String get authGenericError => 'Ocorreu um erro. Tente novamente.';

  @override
  String get authUserNotFound =>
      'Não foi encontrado nenhum utilizador com este endereço de email.';

  @override
  String get authIncorrectCredentials => 'E-mail ou palavra-passe incorretos.';

  @override
  String get authAccountExists => 'Já existe uma conta associada a este email.';

  @override
  String get authWeakPassword =>
      'A palavra-passe é demasiado fraca. Utilize pelo menos 6 carateres.';

  @override
  String get authInvalidEmail => 'Endereço de email inválido.';

  @override
  String get authAppleUnavailable =>
      'O início de sessão com a Apple não está disponível nesta aplicação.';

  @override
  String get authRequiredTitle => 'Guarde o seu\nprotocolo personalizado';

  @override
  String get authRequiredBody =>
      'Mantenha o seu plano, calendário, registos de doses e lembretes associados à sua conta antes de desbloquear o protocolo.';

  @override
  String get continueWithEmail => 'CONTINUAR COM O EMAIL';

  @override
  String get signInWithApple => 'INICIAR SESSÃO COM A APPLE';

  @override
  String get continueWithGoogle => 'CONTINUAR COM O GOOGLE';

  @override
  String get authTermsDisclaimer =>
      'Ao continuar, aceita os nossos Termos e a Política de Privacidade. O PepMod é uma ferramenta educativa — não constitui aconselhamento médico.';

  @override
  String get signIn => 'Iniciar sessão';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get resetPassword => 'Redefinir palavra-passe';

  @override
  String get signInAction => 'INICIAR SESSÃO';

  @override
  String get createAccountAction => 'CRIAR CONTA';

  @override
  String get sendResetLink => 'ENVIAR LINK DE REPOSIÇÃO';

  @override
  String get passwordResetSent =>
      'Email de redefinição de palavra-passe enviado. Verifique a sua caixa de entrada.';

  @override
  String get enterEmail => 'Insira o seu e-mail';

  @override
  String get enterValidEmail => 'Insira um email válido';

  @override
  String get enterPassword => 'Introduza uma palavra-passe';

  @override
  String get passwordMinLength => 'Pelo menos 6 caracteres';

  @override
  String get forgotPassword => 'Esqueceu-se da palavra-passe?';

  @override
  String get alreadyHaveAccount => 'Já tem conta? Inicie sessão';

  @override
  String get backToSignIn => 'Voltar ao início de sessão';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Palavra-passe';

  @override
  String get showPassword => 'Mostrar palavra-passe';

  @override
  String get hidePassword => 'Ocultar palavra-passe';

  @override
  String get accountDeletedTitle => 'Conta eliminada';

  @override
  String get accountDeletedBody =>
      'A sua conta PepMod e os dados guardados da aplicação foram removidos.';

  @override
  String get subscriptionUnavailable =>
      'Os planos de subscrição não estão disponíveis de momento. Tente novamente.';

  @override
  String get upgradeUnavailable =>
      'A atualização não está disponível de momento. Tente novamente mais tarde.';

  @override
  String get noPurchasesToRestore =>
      'Não foram encontradas compras para restaurar.';

  @override
  String get unlockFullProtocol => 'Desbloquear o protocolo completo';

  @override
  String get premiumUnlimitedPeptides => 'Peptídeos ilimitados por protocolo';

  @override
  String get premiumMultipleProtocols => 'Vários protocolos ativos';

  @override
  String get premiumCalculator =>
      'Calculadora de reconstituição (todos os péptidos)';

  @override
  String get premiumMetrics => 'Registo de métricas corporais + gráficos';

  @override
  String get upgradeNow => 'ATUALIZAR AGORA';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get notRightNow => 'Agora não';

  @override
  String get protocolWeeklyPlanner => 'Planeador semanal';

  @override
  String get protocolDoseHistory => 'Histórico de doses';

  @override
  String get protocolCreate => 'Criar protocolo';

  @override
  String get protocolManage => 'GERIR';

  @override
  String get protocolYourProtocol => 'O seu protocolo';

  @override
  String get protocolNoActive => 'Nenhum protocolo ativo';

  @override
  String get protocolNoActiveBody =>
      'Crie o seu primeiro protocolo para começar a registar doses e a construir adesão.';

  @override
  String get protocolStartFirst => 'INICIAR PRIMEIRO PROTOCOLO';

  @override
  String get protocolScheduleTodaySystemLabel => 'PROGRAMA // HOJE';

  @override
  String get protocolAdherenceTodaySystemLabel => 'ADESÃO // HOJE';

  @override
  String get protocolNoDosesScheduledToday => 'Sem doses agendadas para hoje';

  @override
  String protocolDosesTaken(int taken, int total) {
    return '$taken de $total doses tomadas';
  }

  @override
  String get protocolNextDose => 'PRÓXIMA DOSE';

  @override
  String protocolInTime(String duration) {
    return 'Em $duration';
  }

  @override
  String protocolDurationHoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String protocolDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get protocolLogDose => 'REGISTAR DOSE';

  @override
  String get protocolNow => 'agora';

  @override
  String get protocolMissed => 'PERDIDA';

  @override
  String get protocolSkipped => 'IGNORADO';

  @override
  String get protocolNoDosesToday => 'Sem doses hoje';

  @override
  String get protocolNoDosesTodayBody =>
      'O seu protocolo não tem doses previstas para hoje.';

  @override
  String get protocolFreeLimit =>
      'O plano gratuito está limitado a um protocolo. Atualize para Premium para gerir várias combinações em simultâneo.';

  @override
  String protocolSyringeUnitsSuffix(String amount) {
    return ' · $amount unidades de seringa';
  }

  @override
  String get injectionSiteLeftAbdomen => 'Abdómen esquerdo';

  @override
  String get injectionSiteRightAbdomen => 'Abdómen direito';

  @override
  String get injectionSiteLeftThigh => 'Coxa Esquerda';

  @override
  String get injectionSiteRightThigh => 'Coxa direita';

  @override
  String get injectionSiteLeftGlute => 'Glúteo esquerdo';

  @override
  String get injectionSiteRightGlute => 'Glúteo direito';

  @override
  String get injectionSiteLeftTriceps => 'Tríceps Esquerdo';

  @override
  String get injectionSiteRightTriceps => 'Tríceps direito';

  @override
  String get plannerToday => 'HOJE';

  @override
  String get plannerBack => 'Voltar';

  @override
  String get plannerPreviousWeek => 'Semana anterior';

  @override
  String get plannerNextWeek => 'Próxima semana';

  @override
  String plannerScheduledCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count doses agendadas',
      one: '$count dose agendada',
    );
    return '$_temp0';
  }

  @override
  String get plannerTrackingDisclaimer =>
      'Apenas registo. Este calendário reflete o seu protocolo guardado e não fornece indicações de dosagem.';

  @override
  String get plannerWashoutPeriod => 'Período de lavagem';

  @override
  String plannerWashoutUntil(String date) {
    return 'Período de lavagem até $date';
  }

  @override
  String get plannerNoScheduledDoses => 'Sem doses agendadas';

  @override
  String get plannerNothingPlanned =>
      'Não há nada planeado a partir dos seus protocolos guardados.';

  @override
  String get activatePro => 'ATIVAR PRO';

  @override
  String activateProPrice(String price) {
    return 'ATIVAR PRO — $price/ano';
  }

  @override
  String get annualAccess => 'Acesso anual';

  @override
  String get annualLabel => 'Anual';

  @override
  String get averageRating => 'AVALIAÇÃO MÉDIA';

  @override
  String get bacWaterLabel => 'ÁGUA BAC';

  @override
  String get basedOnInputs => 'Com base nos seus dados //';

  @override
  String get bestValue => 'Melhor valor';

  @override
  String get birthDateInvalid =>
      'Introduza uma data válida para alguém com 18 anos ou mais.';

  @override
  String get birthDateValid => 'Idade verificada';

  @override
  String calculatorDemoBody(String peptideName) {
    return 'Veja como funciona com $peptideName';
  }

  @override
  String get calculatorDemoResult =>
      'É só isto. Insira os seus valores\ne obtenha unidades de seringa exatas.';

  @override
  String get calculatorDemoTitle => 'Chega de\ncontas complicadas.';

  @override
  String get confidenceCycleTiming => 'Calendarização do ciclo';

  @override
  String get confidenceCycleTimingDetail =>
      'Veja claramente as datas do protocolo e as janelas do calendário';

  @override
  String get confidenceDoseMath => 'Cálculo de dose';

  @override
  String get confidenceDoseMathDetail =>
      'Mantenha frasco, água, dose e unidades de puxada juntos';

  @override
  String get confidenceLabel => 'CONFIANÇA';

  @override
  String get confidencePlainInfo => 'Informação em linguagem simples';

  @override
  String get confidencePlainInfoDetail =>
      'Leia notas de pesquisa sem complicações';

  @override
  String get confidenceProgressSignals => 'Sinais de progresso';

  @override
  String get confidenceProgressSignalsDetail =>
      'Veja a adesão e as métricas corporais ao longo do tempo';

  @override
  String get confidenceSafetyFraming => 'Enquadramento de segurança';

  @override
  String get confidenceSafetyFramingDetail =>
      'Mantenha as orientações educativas e os avisos sempre visíveis';

  @override
  String get confidenceSiteRotation => 'Rotação de locais';

  @override
  String get confidenceSiteRotationDetail =>
      'Lembre-se de onde cada dose foi registada';

  @override
  String get connectingToStore => 'A LIGAR À LOJA...';

  @override
  String continueSelected(int count) {
    return 'CONTINUAR ($count)';
  }

  @override
  String get customProtocol => 'Protocolo Personalizado';

  @override
  String get dateOfBirthLabel => 'DATA DE NASCIMENTO';

  @override
  String get dayOne => 'DIA 1';

  @override
  String get dayShortLabel => 'DD';

  @override
  String get defaultConfidence => 'Cálculo de dose · Rotação de locais';

  @override
  String get defaultFrustration => 'Doses em falta';

  @override
  String get defaultGoals => 'Recuperação · Longevidade';

  @override
  String get doseLabel => 'DOSE';

  @override
  String get dosesLogged => 'DOSES REGISTADAS';

  @override
  String get dosesPerDay => 'DOSES/DIA';

  @override
  String get drawVolumeLabel => 'VOLUME A PUXAR';

  @override
  String get durationLabel => 'DURAÇÃO';

  @override
  String get experienceAdvanced => 'Avançado';

  @override
  String get experienceAdvancedDetail =>
      'Sinto-me confortável a gerir protocolos detalhados';

  @override
  String get experienceFirstTime => 'Primeira vez';

  @override
  String get experienceFirstTimeDetail => 'Sou novo no registo de peptídeos';

  @override
  String get experienceIntermediate => 'INTERMÉDIO';

  @override
  String get experienceLabel => 'EXPERIÊNCIA';

  @override
  String get experienceNovice => 'INICIANTE';

  @override
  String get experienceSome => 'Alguma experiência';

  @override
  String get experienceSomeDetail => 'Já acompanhei um ou dois protocolos';

  @override
  String get experienceVeteran => 'VETERANO';

  @override
  String get featureDoseMathBody =>
      'Mantenha o tamanho do frasco, o volume de água, a dose e as unidades a puxar junto do protocolo que está a acompanhar.';

  @override
  String get featureDoseMathTitle => 'Cálculo de Dose\nEm Contexto';

  @override
  String get featureProtocolArcBody =>
      'Veja doses planeadas, doses registadas, adesão e métricas corporais reunidas numa só linha temporal.';

  @override
  String get featureProtocolArcTitle =>
      'Evolução do Protocolo\nao Longo do Tempo';

  @override
  String get featureShowcaseTitle => 'Tudo o que precisa.\nUma só aplicação.';

  @override
  String get featureSiteRotationBody =>
      'Memorize cada local registado e mantenha o histórico de rotação associado ao registo da dose.';

  @override
  String get featureSiteRotationTitle => 'Rotação de\nLocais de Injeção';

  @override
  String get firstNameExample => 'por ex.: Alex';

  @override
  String get firstNameLabel => 'PRIMEIRO NOME';

  @override
  String get frustrationForgetting => 'Esquecer doses';

  @override
  String get frustrationLabel => 'FRUSTRAÇÃO';

  @override
  String get frustrationMath => 'Cálculos de frasco e seringa';

  @override
  String get frustrationProgress => 'Perceber se estou a ser consistente';

  @override
  String get frustrationSchedule => 'Manter o horário organizado';

  @override
  String get frustrationStacking => 'Gerir vários péptidos';

  @override
  String get frustrationTrust => 'Encontrar informação fiável';

  @override
  String get goalAntiAging => 'Envelhecimento saudável';

  @override
  String get goalAntiAgingDetail => 'Organize registos focados em longevidade';

  @override
  String get goalCognitive => 'Apoio cognitivo';

  @override
  String get goalCognitiveDetail => 'Monitorize o foco e o desempenho mental';

  @override
  String get goalImmune => 'Apoio imunitário';

  @override
  String get goalImmuneDetail =>
      'Mantenha organizados os protocolos focados em imunidade';

  @override
  String get goalMuscleGrowth => 'Crescimento muscular';

  @override
  String get goalMuscleGrowthDetail =>
      'Acompanhe os objetivos de treino e crescimento';

  @override
  String get goalOther => 'Outro';

  @override
  String get goalOtherDetail => 'Configure um objetivo de registo diferente';

  @override
  String get goalRecovery => 'Recuperação';

  @override
  String get goalRecoveryDetail =>
      'Apoie os registos e as rotinas de recuperação';

  @override
  String get goalSleep => 'Sono';

  @override
  String get goalSleepDetail =>
      'Acompanhe objetivos e padrões relacionados com o sono';

  @override
  String get goalWeightLoss => 'Perda de peso';

  @override
  String get goalWeightLossDetail =>
      'Acompanhe os objetivos e o progresso metabólico';

  @override
  String get goalsLabel => 'OBJETIVOS';

  @override
  String get iUnderstand => 'COMPREENDO';

  @override
  String get lastThreeDaysAgo => 'Última: há 3 dias';

  @override
  String get leftAbdomen => 'Abdómen esquerdo';

  @override
  String get loveIt => 'ADORO';

  @override
  String get maybeLater => 'Talvez mais tarde';

  @override
  String get monthOne => 'MÊS 1';

  @override
  String get monthShortLabel => 'MM';

  @override
  String get monthTwo => 'MÊS 2';

  @override
  String moreCount(String shown, int count) {
    return '$shown +$count mais';
  }

  @override
  String get needsWork => 'A MELHORAR';

  @override
  String get notificationBody =>
      'Receba lembretes discretos quando uma janela do protocolo agendada estiver prestes a começar. Sem nomes de péptidos nas notificações — apenas um lembrete simples.';

  @override
  String get notificationTitle => 'Mantenha os horários\ndas doses visíveis.';

  @override
  String get nowLabel => 'agora';

  @override
  String get ok => 'OK';

  @override
  String get onboardingAgeConfirmed => 'TENHO 18 ANOS OU MAIS';

  @override
  String get onboardingAgeRequirementBody =>
      'Tem de ter 18 anos ou mais para utilizar o PepMod.';

  @override
  String get onboardingAgeRequirementTitle => 'Requisito de idade';

  @override
  String get onboardingAgeVerificationBody =>
      'O PepMod destina-se a adultos com 18 anos ou mais.';

  @override
  String get onboardingAgeVerificationTitle =>
      'Primeiro, confirme\na sua idade.';

  @override
  String get onboardingAheadBody =>
      'Responda a algumas perguntas e o PepMod irá organizar uma pré-visualização de acompanhamento personalizada.';

  @override
  String get onboardingAheadTitle => 'Veja o seu protocolo\nantes de começar.';

  @override
  String get onboardingBirthDateBody =>
      'Isto confirma que cumpre o requisito de idade.';

  @override
  String get onboardingBirthDateTitle => 'Quando\nnasceu?';

  @override
  String get onboardingConfidenceBody =>
      'Escolha tudo o que o PepMod deve tornar mais claro.';

  @override
  String get onboardingConfidenceTitle => 'Onde quer\nmais confiança?';

  @override
  String get onboardingConversionValueBody =>
      'Converta os valores do seu frasco e plano em volume e unidades de seringa.';

  @override
  String get onboardingConversionValueTitle =>
      'Torne os cálculos do frasco\nmais fáceis de verificar.';

  @override
  String get onboardingDisclaimerBody =>
      'O PepMod ajuda a organizar registos, lembretes e conversões de unidades. Não diagnostica, não prescreve nem substitui o aconselhamento de um profissional de saúde qualificado.';

  @override
  String get onboardingDisclaimerTitle =>
      'Feito para clareza.\nNão para prescrições.';

  @override
  String get onboardingExperienceTitle => 'Qual é a sua\nexperiência?';

  @override
  String get onboardingFrustrationBody =>
      'Escolha o principal ponto de fricção.';

  @override
  String get onboardingFrustrationTitle =>
      'O que lhe parece\nmais difícil hoje?';

  @override
  String get onboardingGoalsTitle => 'Quais são os seus\nprincipais objetivos?';

  @override
  String get onboardingGuidedStartBody =>
      'Vamos adaptar a configuração aos seus objetivos, experiência e aos registos que pretende manter.';

  @override
  String get onboardingGuidedStartTitle =>
      'Um começo guiado,\npensado para si.';

  @override
  String get onboardingHookAnswer =>
      'O PepMod mantém a resposta junto do seu protocolo.';

  @override
  String get onboardingHookQuestion => 'Quantas unidades\nvai puxar?';

  @override
  String get onboardingHookResearch => 'BIBLIOTECA DE INVESTIGAÇÃO';

  @override
  String get onboardingHookSources => 'Fontes com referências científicas';

  @override
  String get onboardingHookVial => 'FRASCO + DILUENTE';

  @override
  String get onboardingNameBody =>
      'Vamos usar isto para personalizar a sua experiência PepMod.';

  @override
  String get onboardingNameTitle => 'Como devemos\nchamar-lhe?';

  @override
  String get onboardingPeptideSelectBody =>
      'Escolha os péptidos que utiliza ou que quer manter no seu radar.';

  @override
  String get onboardingPeptideSelectTitle => 'O que está a\nacompanhar?';

  @override
  String get onboardingProgressValueBody =>
      'Reúna adesão, histórico de doses e medidas corporais num único registo claro.';

  @override
  String get onboardingProgressValueTitle =>
      'Veja toda a evolução\nao longo do tempo.';

  @override
  String get onboardingProtocolValueBody =>
      'Planeie horários, registe doses e mantenha os detalhes associados a cada protocolo.';

  @override
  String get onboardingProtocolValueTitle =>
      'Mantenha todos os protocolos\nnum só lugar.';

  @override
  String get onboardingUnder18 => 'TENHO MENOS DE 18 ANOS';

  @override
  String get openingPermission => 'A ABRIR PERMISSÃO...';

  @override
  String get paywallArcBody =>
      'Veja o que foi planeado, o que foi registado e o que precisa de um registo mais organizado a seguir.';

  @override
  String get paywallArcTitle => 'VEJA A EVOLUÇÃO AO LONGO DO TEMPO';

  @override
  String get paywallBody =>
      'Cálculo de dose, rotação de locais, lembretes e histórico de protocolo — tudo num único registo.';

  @override
  String get paywallDoseMathBody =>
      'Mantenha frasco, água, dose e unidades a puxar juntos, para que cada registo seja mais fácil de verificar.';

  @override
  String get paywallDoseMathTitle => 'ACERTE OS CÁLCULOS DA DOSE';

  @override
  String get paywallPreviewDisclaimer =>
      'Criado para registos, lembretes e clareza nas unidades — não é aconselhamento médico.';

  @override
  String get paywallRotationBody =>
      'Cada local, ciclo e lembrete fica associado ao registo do protocolo.';

  @override
  String get paywallRotationTitle => 'NUNCA PERCA A SUA ROTAÇÃO';

  @override
  String get paywallTitle =>
      'Tudo o que precisa para\ngerir bem o seu protocolo.';

  @override
  String get paywallValueNote =>
      'Um cálculo de frasco confuso pode desperdiçar tempo e produto. O PepMod mantém os cálculos junto do registo para que possa reverificar os seus dados antes de agir com base em notas antigas.';

  @override
  String get peptideLabel => 'PEPTÍDEO';

  @override
  String get peptidesLabel => 'PÉPTIDOS';

  @override
  String get peptidesTracked => 'PÉPTIDOS\nMONITORIZADOS';

  @override
  String get perWeek => '/semana';

  @override
  String get perYear => '/ano';

  @override
  String get privacyLabel => 'Privacidade';

  @override
  String processingGoals(int count) {
    return 'A ANALISAR $count OBJETIVOS...';
  }

  @override
  String processingPeptides(int count) {
    return 'A LIGAR $count REGISTOS DE PEPTÍDEOS...';
  }

  @override
  String get processingProtocol => 'A CRIAR O SEU PROTOCOLO...';

  @override
  String get processingSchedule => 'A ORGANIZAR O SEU CALENDÁRIO...';

  @override
  String get processingTitle => 'A construir o seu\nprotocolo';

  @override
  String get progressLabel => 'Progresso';

  @override
  String get protocolClarity => 'clareza do protocolo';

  @override
  String get protocolIncludes => 'O SEU PROTOCOLO INCLUI //';

  @override
  String get protocolPreviewTitle => 'O seu protocolo\nestá pronto.';

  @override
  String get protocolReady => 'PROTOCOLO PRONTO //';

  @override
  String get protocolReminderReady => 'O lembrete do protocolo está pronto';

  @override
  String get protocolReservedFor =>
      'O SEU PROTOCOLO PERSONALIZADO ESTÁ RESERVADO PARA';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get resultsSummaryBody =>
      'Vamos manter os registos de doses, os cálculos de reconstituição e os registos de tendências juntos à medida que os seus dados crescem.';

  @override
  String get reviewGateBody =>
      'O seu feedback ajuda-nos a melhorar a plataforma para todos os biohackers.';

  @override
  String get reviewGateTitle => 'Está a gostar do PepMod\naté agora?';

  @override
  String roadmapBody(int count, String need) {
    return 'Construído em torno de $count péptidos monitorizados e da sua necessidade de $need.';
  }

  @override
  String get roadmapDayOneBody =>
      'Peptídeos, registos de doses, rotação de locais e lembretes estão prontos.';

  @override
  String get roadmapDayOneTitle => 'O seu primeiro protocolo está organizado';

  @override
  String get roadmapDisclaimer =>
      'O PepMod mantém registos e lembretes organizados. Não prescreve, não diagnostica nem substitui a orientação de um profissional de saúde.';

  @override
  String get roadmapMonthOneBody =>
      'A adesão, as doses em falta e as métricas corporais começam a formar um registo mais organizado.';

  @override
  String get roadmapMonthOneTitle =>
      'O seu histórico de consistência começa a ganhar forma';

  @override
  String get roadmapMonthTwoBody =>
      'Veja o que planeou, o que aconteceu e onde os seus registos precisam de atenção.';

  @override
  String get roadmapMonthTwoTitle =>
      'Toda a evolução do seu protocolo fica visível';

  @override
  String get roadmapTitle => 'Eis o que\nse segue.';

  @override
  String get roadmapWeekOneBody =>
      'Informação em linguagem simples e notas de acompanhamento ficam associadas ao seu plano.';

  @override
  String roadmapWeekOneTitle(String goal) {
    return 'A sua biblioteca preenche-se em torno de $goal';
  }

  @override
  String savePercent(int percent) {
    return 'POUPE $percent%';
  }

  @override
  String get saveRoadmap => 'GUARDAR ESTE ROTEIRO';

  @override
  String get schedulePreview => 'PRÉ-VISUALIZAÇÃO DO CALENDÁRIO';

  @override
  String get seeWhatsInside => 'VER O QUE ESTÁ INCLUÍDO';

  @override
  String get selectAllThatApply => 'Selecione todas as opções aplicáveis.';

  @override
  String get siteMap => 'Mapa de locais';

  @override
  String get skipForNow => 'SALTAR POR AGORA';

  @override
  String get socialProofBody =>
      'Junte-se a milhares de pessoas a acompanhar o seu progresso real.';

  @override
  String get socialProofTitle => 'Confiado por\nbiohackers em todo o mundo';

  @override
  String get specialOffer => 'OFERTA ESPECIAL';

  @override
  String get startFreeTrial => 'INICIAR TESTE GRATUITO';

  @override
  String get subscribeLabel => 'SUBSCREVER';

  @override
  String subscribePrice(String price) {
    return 'SUBSCREVER — $price/semana';
  }

  @override
  String get subscribeToActivate => 'Subscreva para ativar o seu protocolo';

  @override
  String get subscriptionRenewalDisclaimer =>
      'A subscrição renova-se automaticamente, exceto se for cancelada pelo menos 24 horas antes do final do período atual. Faça a gestão em Definições > Apple ID > Subscrições.';

  @override
  String syringeVolume(String volume) {
    return '${volume}ml numa seringa de 1ml';
  }

  @override
  String get termsLabel => 'Termos';

  @override
  String get testimonialOne =>
      'Finalmente deixei de falhar doses. Só a calculadora de reconstituição já me poupou horas de contas em folhas de cálculo.';

  @override
  String get testimonialThree =>
      'O rastreador de peptídeos mais organizado que já usei. Parece ter sido feito para utilizadores exigentes, porque foi.';

  @override
  String get testimonialTwo =>
      'As análises semanais detetaram um problema de tempo que eu não tinha notado há meses. Mudou tudo.';

  @override
  String get thirtyDayAdherence => 'Adesão de 30 dias';

  @override
  String get threeDayFreeTrial => 'TESTE GRATUITO DE 3 DIAS';

  @override
  String get timelineLabel => 'Linha do tempo';

  @override
  String get trackedLabel => 'registado';

  @override
  String get turnOnReminders => 'ATIVAR LEMBRETES';

  @override
  String get unitConversionDisclaimer =>
      'Ferramenta de conversão de unidades apenas para referência. Confirme sempre com o seu profissional de saúde.';

  @override
  String get unitsLabel => 'Unidades';

  @override
  String get unitsToDraw => 'Unidades a puxar';

  @override
  String get unlockPepMod => 'DESBLOQUEAR O PEPMOD';

  @override
  String get usersLabel => 'UTILIZADORES';

  @override
  String get viewLabel => 'VER';

  @override
  String get weekDuration => 'DURAÇÃO\nDA SEMANA';

  @override
  String get weekOne => 'SEMANA 1';

  @override
  String get weeklyLabel => 'Semanal';

  @override
  String weeksCount(int count) {
    return '$count semanas';
  }

  @override
  String get yearLabel => 'ANO';

  @override
  String get profileTitle => 'Você';

  @override
  String get signedIn => 'Sessão iniciada';

  @override
  String get sectionAccount => 'CONTA';

  @override
  String get sectionPreferences => 'PREFERÊNCIAS';

  @override
  String get sectionData => 'DADOS';

  @override
  String get sectionSupport => 'SUPORTE';

  @override
  String get sectionLegal => 'LEGAL';

  @override
  String get sectionAbout => 'SOBRE';

  @override
  String get nameLabel => 'Nome';

  @override
  String get accountLabel => 'Conta';

  @override
  String get deleteAccount => 'Eliminar conta';

  @override
  String get removeAccountData => 'Remover conta e dados';

  @override
  String get metricLabel => 'Métrica';

  @override
  String get imperialLabel => 'Imperial';

  @override
  String get notificationsLabel => 'Notificações';

  @override
  String get onLabel => 'Ativado';

  @override
  String get offLabel => 'Desativado';

  @override
  String get myCompoundsProfile => 'Os meus compostos';

  @override
  String get savedVialPresets => 'Ajustes de frasco guardados';

  @override
  String get exportData => 'Exportar dados';

  @override
  String get copyAsJson => 'Copiar como JSON';

  @override
  String get clearAllData => 'Limpar todos os dados';

  @override
  String get clearingLabel => 'A limpar…';

  @override
  String get resetApp => 'Repor aplicação';

  @override
  String get contactSupport => 'Contactar suporte';

  @override
  String get chatWithUs => 'Converse connosco';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get medicalDisclaimer => 'Aviso médico';

  @override
  String get disclaimerTitle => 'Aviso legal';

  @override
  String get versionLabel => 'Versão';

  @override
  String get signOutAction => 'TERMINAR SESSÃO';

  @override
  String get educationalTrackingDisclaimer =>
      'Apenas registo educativo. Não é aconselhamento médico.';

  @override
  String get yourName => 'O seu nome';

  @override
  String get cancelLabel => 'Cancelar';

  @override
  String get saveLabel => 'Guardar';

  @override
  String get dataCopied => 'Dados copiados para a área de transferência.';

  @override
  String get clearDataTitle => 'Limpar todos os dados?';

  @override
  String get clearDataBody =>
      'Isto elimina todos os protocolos, registos de doses e métricas corporais, reiniciando depois o processo de introdução. A sua conta, subscrição e biblioteca de peptídeos são preservadas. Esta ação não pode ser revertida.';

  @override
  String get clearLabel => 'Limpar';

  @override
  String get clearingDataTitle => 'A limpar dados…';

  @override
  String get clearingDataBody =>
      'Mantenha o PepMod aberto enquanto os seus dados de acompanhamento são removidos.';

  @override
  String get clearDataFailed =>
      'Não foi possível limpar os dados. Verifique a sua ligação e tente novamente.';

  @override
  String get allDataCleared => 'Todos os dados foram limpos.';

  @override
  String get deleteAccountTitle => 'Eliminar conta?';

  @override
  String get deleteAccountBody =>
      'Esta ação elimina permanentemente a sua conta PepMod, definições, protocolos, registos de doses e métricas corporais. Não é possível anular esta ação.';

  @override
  String get deletingAccount => 'A eliminar conta…';

  @override
  String get accountDeletionFailed =>
      'Falha ao eliminar a conta. Tente novamente.';

  @override
  String get confirmPassword => 'Confirmar palavra-passe';

  @override
  String get deleteLabel => 'Eliminar';

  @override
  String get signOutTitle => 'Terminar sessão?';

  @override
  String get signOutBody =>
      'Os seus protocolos permanecem guardados e voltam a sincronizar quando iniciar sessão de novo.';

  @override
  String get signOutLabel => 'Terminar sessão';

  @override
  String get signOutFailed =>
      'Não foi possível terminar a sessão. Tente novamente.';

  @override
  String get notificationsDisabledSystem =>
      'As notificações estão desativadas nas definições do sistema.';

  @override
  String get planPro => 'PRO';

  @override
  String get planFree => 'GRATUITO';

  @override
  String get termsBody =>
      'O PepMod é disponibilizado apenas para fins educativos e de acompanhamento. Não é um dispositivo médico e não fornece aconselhamento médico, diagnósticos, prescrições ou recomendações de tratamento. Ao utilizar o PepMod, é responsável pelos seus próprios registos, decisões e pela consulta de profissionais de saúde qualificados.\n\nAs subscrições renovam-se automaticamente, salvo cancelamento através da App Store ou da Google Play antes do período de renovação. Os reembolsos são geridos pela loja onde efetuou a compra.\n\nTermos completos: https://appstorecopilot.com/legal/yzh32x5v/terms';

  @override
  String get privacyBody =>
      'O PepMod utiliza o Firebase para autenticação e armazenamento de dados na nuvem, o RevenueCat para subscrições, o AppRefer e os Eventos de Aplicação da Meta/Facebook para atribuição, e o Firebase/Crashlytics para análise e diagnóstico. Não vendemos as suas informações pessoais. Pode eliminar a sua conta e os dados guardados da aplicação diretamente na aplicação.\n\nPolítica de Privacidade completa: https://appstorecopilot.com/legal/yzh32x5v/privacy';

  @override
  String get medicalDisclaimerBody =>
      'O PepMod é uma ferramenta de bem-estar e registo — NÃO é um dispositivo médico. Nada nesta aplicação constitui aconselhamento médico, diagnóstico, prescrição ou recomendação de tratamento. Os peptídeos descritos na biblioteca destinam-se apenas a fins educativos. Consulte sempre um profissional de saúde qualificado antes de iniciar, alterar ou interromper qualquer regime. Se sentir quaisquer efeitos adversos, procure assistência médica de imediato.';

  @override
  String get profileSystemLabel => 'SYS.UTILIZADOR // PERFIL';

  @override
  String get legalSystemLabel => 'SYS.LEGAL';

  @override
  String get progressTitle => 'Progresso';

  @override
  String get progressSystemLabel => 'SYS.PROGRESSO // BIOMÉTRICA';

  @override
  String get doseHistoryTooltip => 'Abrir histórico de doses';

  @override
  String get logMeasurementTooltip => 'Registar medição';

  @override
  String get thirtyDayLabel => '30 DIAS';

  @override
  String get adherenceLabel => 'adesão';

  @override
  String get streakLabel => 'SEQUÊNCIA';

  @override
  String get daysLabel => 'dias';

  @override
  String get totalLabel => 'TOTAL';

  @override
  String get dosesLabel => 'doses';

  @override
  String get protocolHistoryLabel => 'PROTOCOLO.HISTÓRICO';

  @override
  String get noProtocolsYet =>
      'Ainda não há protocolos. Crie um no separador Protocolo.';

  @override
  String get adherenceChartLabel => 'ADESÃO // 30.DIAS';

  @override
  String get thirtyDaysAgo => 'há 30 dias';

  @override
  String get todayLabel => 'hoje';

  @override
  String get noWeightData => 'Sem dados de peso';

  @override
  String get logFirstMeasurement =>
      'Registe a sua primeira medição para ver tendências aqui.';

  @override
  String get logMeasurementAction => 'REGISTAR MEDIDA';

  @override
  String get weightTrendLabel => 'PESO // TENDÊNCIA';

  @override
  String weightKgValue(String weight) {
    return '$weight kg';
  }

  @override
  String get statusActive => 'ATIVO';

  @override
  String get statusPaused => 'EM PAUSA';

  @override
  String get statusEnded => 'TERMINADO';

  @override
  String protocolPeptideCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count péptidos',
      one: '1 péptido',
    );
    return '$_temp0';
  }

  @override
  String get enterOneMetric => 'Insira pelo menos um valor.';

  @override
  String get saveMetricFailed => 'Falha ao guardar. Tente novamente.';

  @override
  String get newMeasurement => 'Nova Medição';

  @override
  String get weightLabel => 'PESO';

  @override
  String get bodyFatLabel => 'GORDURA CORPORAL';

  @override
  String get measurementsCmLabel => 'MEDIDAS (cm)';

  @override
  String get waistLabel => 'CINTURA';

  @override
  String get chestLabel => 'PEITO';

  @override
  String get armLabel => 'BRAÇO';

  @override
  String get saveAction => 'GUARDAR';

  @override
  String get logMetricSystemLabel => 'REG.MÉTRICA';

  @override
  String get activeLastSevenDays => 'ÚLTIMOS 7 DIAS';

  @override
  String get activeAllTime => 'DESDE SEMPRE';

  @override
  String get activeAdherence => 'adesão';

  @override
  String get activeStarted => 'INICIADO';

  @override
  String get activeEnded => 'TERMINADO';

  @override
  String activeStackCount(int count) {
    return 'COMBINAÇÃO ($count)';
  }

  @override
  String get activeEditProtocol => 'EDITAR PROTOCOLO';

  @override
  String get activePauseProtocol => 'PAUSAR PROTOCOLO';

  @override
  String get activeEndProtocol => 'TERMINAR PROTOCOLO';

  @override
  String get activeResumeProtocol => 'RETOMAR PROTOCOLO';

  @override
  String get activeDeleteProtocol => 'ELIMINAR PROTOCOLO';

  @override
  String get activeTrackingDisclaimer =>
      'Apenas registo educativo. Consulte um profissional de saúde qualificado antes de fazer alterações.';

  @override
  String get activeEndQuestion => 'Terminar protocolo?';

  @override
  String get activeEndBody =>
      'As doses futuras serão removidas. Os registos anteriores permanecem no seu histórico. Esta ação não pode ser revertida.';

  @override
  String get activeEndAction => 'TERMINAR';

  @override
  String get activeDeleteQuestion => 'Eliminar protocolo?';

  @override
  String get activeDeleteBody =>
      'Esta ação remove permanentemente o protocolo e todos os seus registos de doses. Não é possível anular esta ação.';

  @override
  String get activeDeleteAction => 'ELIMINAR';

  @override
  String get cancel => 'Cancelar';

  @override
  String get activeStatusActive => 'ATIVO';

  @override
  String get activeStatusPaused => 'EM PAUSA';

  @override
  String get activeStatusEnded => 'TERMINADO';

  @override
  String get activeNotesLabel => 'NOTAS // PROTOCOLO';

  @override
  String get activeChangeReminders => 'ALTERAR LEMBRETES';

  @override
  String get activeChangeRemindersBody =>
      'Quando as notificações estão ativas, o PepMod agenda um alerta às 09:00 (hora local) para cada mudança de fase futura.';

  @override
  String activePhaseAnchor(String date) {
    return 'Os intervalos semanais têm como referência $date.';
  }

  @override
  String activeWeek(int week) {
    return 'SEMANA $week';
  }

  @override
  String activeWeeks(int start, int end) {
    return 'SEMANAS $start–$end';
  }

  @override
  String get activePerDayAmounts => 'Quantidades por dia';

  @override
  String get activeBaseAmount => 'Quantidade base';

  @override
  String get activeCurrent => 'ATUAL';

  @override
  String get activeBaseSchedule => 'Calendário base';

  @override
  String get activeCustomDays => 'Dias personalizados';

  @override
  String get activeContinuousTracking => 'Acompanhamento contínuo';

  @override
  String get activeNoFixedCycle => 'Sem janela de ciclo fixa';

  @override
  String activeCycleProgress(int week, int total) {
    return 'Semana $week de $total';
  }

  @override
  String activeCycleEnds(String date) {
    return 'O ciclo termina em $date';
  }

  @override
  String activeRestProgress(int week, int total) {
    return 'Semana de descanso $week de $total';
  }

  @override
  String activeRestEnds(String date) {
    return 'A janela de descanso termina a $date';
  }

  @override
  String get activeCycleComplete => 'Ciclo concluído';

  @override
  String activeCompletedDate(String date) {
    return 'Concluído em $date';
  }

  @override
  String activeRestEnded(String date) {
    return 'A janela de descanso terminou em $date';
  }

  @override
  String get activeNoHistory =>
      'Ainda não há protocolos em pausa ou terminados.';

  @override
  String activeCompoundsCount(int count) {
    return '$count compostos';
  }

  @override
  String activeSyringeUnits(String amount) {
    return '$amount unidades de seringa';
  }

  @override
  String activeCycleWeeks(int count) {
    return 'Ciclo de $count sem';
  }

  @override
  String activeRestWeeks(int count) {
    return '$count sem. de descanso';
  }

  @override
  String get activePerDraw => 'POR PUXADA';

  @override
  String activeVialSummary(String volume) {
    return 'Frasco de $volume mL · U-100';
  }

  @override
  String get addCompound => 'ADICIONAR COMPOSTO';

  @override
  String get addPhase => 'ADICIONAR FASE';

  @override
  String get addTime => 'Adicionar hora';

  @override
  String get addToStack => 'ADICIONAR À COMBINAÇÃO';

  @override
  String get amountRequired => 'Quantidade obrigatória';

  @override
  String get baseAmount => 'Quantidade base';

  @override
  String get baseSchedule => 'calendário base';

  @override
  String get blendConfigBody =>
      'Introduza exatamente o que está indicado no frasco. O PepMod converte a extração numa síntese por composto.';

  @override
  String get blendIncompleteError =>
      'Complete pelo menos dois compostos, o volume de diluente e a quantidade a puxar.';

  @override
  String get blendNameHint => 'ex.: mistura de recuperação';

  @override
  String get blendNameLabel => 'NOME DA MISTURA';

  @override
  String get blendSafetyDisclaimer =>
      'Apenas conversão de unidades. O PepMod não recomenda uma combinação, dose, frequência ou método de reconstituição.';

  @override
  String get changeNoteHint => 'O seu próprio contexto para esta fase';

  @override
  String get changeNoteOptional => 'NOTA DE ALTERAÇÃO OPCIONAL';

  @override
  String colorOption(String hex) {
    return 'Opção de cor $hex';
  }

  @override
  String compoundNumber(int number) {
    return 'COMPOSTO $number';
  }

  @override
  String compoundsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count compostos',
      one: '1 composto',
    );
    return '$_temp0';
  }

  @override
  String copiedVialPreset(String amount, String unit) {
    return 'Predefinição de frasco de $amount $unit · copiada para este protocolo';
  }

  @override
  String get createProtocolAction => 'CRIAR PROTOCOLO';

  @override
  String get createProtocolAddOneError => 'Adicione pelo menos um péptido.';

  @override
  String createProtocolBuildStep(int step, int total) {
    return 'Criar protocolo · Passo $step / $total';
  }

  @override
  String get createProtocolDefaultName => 'O Meu Protocolo';

  @override
  String createProtocolEditStep(int step, int total) {
    return 'Editar Protocolo · Passo $step / $total';
  }

  @override
  String get createProtocolFreeLimitReason =>
      'O plano gratuito está limitado a um péptido por protocolo. Faça upgrade para combinar vários compostos.';

  @override
  String get createProtocolNameBody =>
      'Dê-lhe um nome fácil de lembrar — por exemplo, «Combinação de Recuperação» ou «Definição T2».';

  @override
  String get createProtocolNameTitle => 'Dê um nome ao seu protocolo';

  @override
  String get createProtocolNoPeptides => 'Ainda sem péptidos';

  @override
  String get createProtocolPickHint => 'Toque em + para escolher da biblioteca';

  @override
  String get createProtocolReviewBody =>
      'Confirme os detalhes do protocolo. Pode editá-los a qualquer momento a partir da vista de Gestão.';

  @override
  String get createProtocolSaveError =>
      'Falha ao guardar o protocolo. Tente novamente.';

  @override
  String get createProtocolStackBody =>
      'Adicione um péptido ou combine vários compostos. Configure a etiqueta, dose, frequência e ciclo de cada um.';

  @override
  String get createProtocolStackTitle => 'Crie a sua combinação';

  @override
  String get customBlend => 'Combinação personalizada';

  @override
  String get customDays => 'Dias personalizados';

  @override
  String get customDaysDisclaimer =>
      'Só os dias da semana selecionados ficam agendados. As quantidades são valores de registo introduzidos por si, não recomendações de dose.';

  @override
  String get customPeptide => 'Péptido personalizado';

  @override
  String get cycleWeeksLabel => 'SEMANAS DE CICLO';

  @override
  String get cycleWindowDisclaimer =>
      'As janelas de ciclo e de descanso organizam o histórico de registo. O PepMod não agenda doses futuras depois de a janela de ciclo terminar.';

  @override
  String get defaultAmountLabel => 'QUANTIDADE PREDEFINIDA';

  @override
  String get diluentVolumeLabel => 'VOLUME DO DILUENTE';

  @override
  String get drawExceedsVialError =>
      'A quantidade a puxar não pode exceder o volume do frasco.';

  @override
  String get drawLabel => 'PUXAR';

  @override
  String get drawPreviewLabel => 'PRÉ-VISUALIZAÇÃO DA PUXADA';

  @override
  String drawPreviewValue(String units, String volume) {
    return '$units unidades = $volume mL';
  }

  @override
  String editTime(String time) {
    return 'Editar horário $time';
  }

  @override
  String get endWeekLabel => 'SEMANA FINAL';

  @override
  String get enterPeptideName => 'Introduza o nome do péptido';

  @override
  String get frequencyLabel => 'FREQUÊNCIA';

  @override
  String get labelColorBody =>
      'Faça corresponder esta cor à caneta ou ao rótulo do frasco que utiliza na realidade.';

  @override
  String get labelColorLabel => 'COR DA ETIQUETA';

  @override
  String get manageSavedCompounds => 'Gerir compostos guardados';

  @override
  String get nextLabel => 'SEGUINTE';

  @override
  String get noneLabel => 'Nenhum';

  @override
  String get oneOffCompound => 'Composto pontual';

  @override
  String get oneOffCompoundBody => 'Usar uma vez sem guardar um ajuste';

  @override
  String get optionalLabel => 'Opcional';

  @override
  String peptidesCount(int count) {
    return 'PEPTÍDEOS ($count)';
  }

  @override
  String get perDayAmounts => 'Quantidades por dia';

  @override
  String phaseExtendsWarning(int weeks) {
    return 'Uma fase ultrapassa o ciclo de $weeks semanas. Ajuste a fase ou o período do ciclo.';
  }

  @override
  String get phaseNameHint => 'ex.: Acompanhamento da semana 1';

  @override
  String get phaseNameLabel => 'NOME DA FASE';

  @override
  String phaseNumber(int number) {
    return 'Fase $number';
  }

  @override
  String phaseOutsideCycleError(int weeks) {
    return 'Este ciclo de protocolo termina na semana $weeks. Mantenha as semanas da fase dentro desse período.';
  }

  @override
  String get phaseOverlapError =>
      'Os intervalos de semanas das fases não podem sobrepor-se.';

  @override
  String get phaseOverrideBody =>
      'Insira apenas o calendário de acompanhamento que já pretende seguir. O PepMod não recomenda quantidades.';

  @override
  String get phaseOverrideTitle => 'Substituição semana a semana';

  @override
  String get phasePreviewDisclaimer =>
      'Apenas pré-visualização dos seus dados. O PepMod não recomenda nenhum calendário.';

  @override
  String get phasePreviewLabel => 'PRÉ-VISUALIZAÇÃO DA FASE';

  @override
  String get phaseReminderBody =>
      'Um lembrete neutro de mudança de fase é agendado para as 9h00 quando os lembretes do protocolo estão ativados.';

  @override
  String get phaseScheduleLabel => 'HORÁRIO DA FASE';

  @override
  String get phaseSelectDayError =>
      'Selecione pelo menos um dia. O PepMod não escolhe um calendário por si.';

  @override
  String get phasesBody =>
      'Janelas de datas opcionais podem substituir esta quantidade e horário base. Fora delas, o horário base continua.';

  @override
  String phasesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fases',
      one: '1 fase',
    );
    return '$_temp0';
  }

  @override
  String get phasesDisclaimer =>
      'As semanas são contadas a partir da data de início do protocolo. As notas de fase guardadas e os lembretes de alteração são apenas auxiliares de registo.';

  @override
  String get preBlendedVial => 'Frasco pré-misturado';

  @override
  String get preBlendedVialBody =>
      'Um frasco · uma extração · vários compostos';

  @override
  String get protocolNotesBody =>
      'Guarde o contexto que quer ver ao rever este protocolo.';

  @override
  String get protocolNotesHint =>
      'ex.: perguntas, contexto de registo ou notas clínicas';

  @override
  String get protocolNotesLabel => 'Notas do protocolo';

  @override
  String get reminderTimesBody =>
      'Cada hora selecionada cria a sua própria linha de acompanhamento e lembrete nos dias agendados.';

  @override
  String get reminderTimesLabel => 'HORÁRIOS DOS LEMBRETES';

  @override
  String get removeLabel => 'REMOVER';

  @override
  String removePeptide(String name) {
    return 'Remover $name';
  }

  @override
  String get removePhase => 'Remover fase';

  @override
  String removeTime(String time) {
    return 'Remover horário $time';
  }

  @override
  String get restWeeksLabel => 'SEMANAS DE DESCANSO';

  @override
  String get reviewLabel => 'Revisão';

  @override
  String get routeLabel => 'VIA';

  @override
  String get saveBlend => 'GUARDAR COMBINAÇÃO';

  @override
  String get saveChanges => 'GUARDAR ALTERAÇÕES';

  @override
  String get savePhase => 'GUARDAR FASE';

  @override
  String savedVialPreset(String amount, String unit) {
    return 'Frasco de $amount $unit · Ajuste guardado';
  }

  @override
  String get scheduleLabel => 'CALENDÁRIO';

  @override
  String get searchCompounds => 'Procurar compostos...';

  @override
  String get selectDayError =>
      'Selecione pelo menos um dia para agendar este péptido.';

  @override
  String selectOption(String option) {
    return 'Selecionar $option';
  }

  @override
  String get startDateLabel => 'DATA DE INÍCIO';

  @override
  String get startWeekLabel => 'SEMANA INICIAL';

  @override
  String syringeUnitsAmount(String amount) {
    return '$amount unidades de seringa';
  }

  @override
  String get syringeUnitsDisclaimer =>
      'Marcações opcionais de seringa U-100 introduzidas pelo utilizador, apenas para acompanhamento.';

  @override
  String get syringeUnitsHint => 'por ex. 12,5';

  @override
  String get syringeUnitsLabel => 'unidades de seringa';

  @override
  String get syringeUnitsOptional => 'UNIDADES DE SERINGA OPCIONAIS';

  @override
  String get trackedAmountLabel => 'QUANTIDADE MONITORIZADA';

  @override
  String get u100TrackingDisclaimer =>
      'Utiliza as marcações de seringa U-100 (100 unidades = 1 ml). Os valores são dados de acompanhamento inseridos pelo utilizador.';

  @override
  String get unitLabel => 'UNIDADE';

  @override
  String get vialAmountHint => 'Quantidade no frasco';

  @override
  String get vialContentsLabel => 'CONTEÚDO DO FRASCO';

  @override
  String get vialLabelNameHint => 'Nome indicado no rótulo do frasco';

  @override
  String weekNumber(int week) {
    return 'SEMANA $week';
  }

  @override
  String weekRange(int start, int end) {
    return 'SEMANAS $start–$end';
  }

  @override
  String get weekToWeekPhases => 'FASES SEMANA A SEMANA';

  @override
  String weekdayDose(String weekday) {
    return 'DOSE DE $weekday';
  }

  @override
  String weekdaySchedule(String weekday) {
    return 'HORÁRIO DE $weekday';
  }

  @override
  String get doseDrawInvalid =>
      'A puxada tem de ser superior a zero e estar dentro do limite do frasco.';

  @override
  String get doseGenericError => 'Ocorreu um erro. Tente novamente.';

  @override
  String get doseEditSystemLabel => 'EDITAR.DOSE';

  @override
  String get doseLogSystemLabel => 'LOG.DOSE';

  @override
  String get doseDraw => 'PUXADA';

  @override
  String get doseAmount => 'QUANTIDADE';

  @override
  String get doseUnits => 'unidades';

  @override
  String get doseTime => 'HORA';

  @override
  String get doseChooseTime => 'Escolher hora da dose';

  @override
  String get doseBlendSnapshot => 'SÍNTESE DA COMBINAÇÃO // POR EXTRAÇÃO';

  @override
  String doseSyringeUnitsRecorded(String amount) {
    return '$amount unidades de seringa registadas para esta dose.';
  }

  @override
  String get doseInjectionSite => 'LOCAL.INJEÇÃO';

  @override
  String doseLastSite(String site) {
    return 'ÚLTIMO LOCAL PARA ESTE PÉPTIDO · $site';
  }

  @override
  String get doseNotes => 'NOTAS';

  @override
  String get doseOptional => 'Opcional...';

  @override
  String get doseMarkPending => 'MARCAR COMO PENDENTE';

  @override
  String get doseSaveChanges => 'GUARDAR ALTERAÇÕES';

  @override
  String get doseSkip => 'Ignorar esta dose';

  @override
  String get doseHistorySystemLabel => 'HISTÓRICO.DOSES // 30.DIAS';

  @override
  String get doseHistoryTitle => 'Doses registadas';

  @override
  String get doseHistoryBody =>
      'Toque num registo para corrigir a quantidade, a hora real, o local de injeção, as notas ou o estado.';

  @override
  String get doseHistoryEmpty => 'Sem doses registadas nos últimos 30 dias.';

  @override
  String get doseLogPrevious => 'REGISTAR DOSE ANTERIOR';

  @override
  String doseHistorySkipped(String dateTime) {
    return 'Ignorada · $dateTime';
  }

  @override
  String doseHistoryTaken(String amount, String units, String dateTime) {
    return '$amount $units · $dateTime';
  }

  @override
  String get doseEditAction => 'EDITAR';

  @override
  String get doseChoosePastTime => 'Escolha uma hora anterior para registar.';

  @override
  String get dosePreviousError =>
      'Não foi possível registar a dose anterior. Tente novamente.';

  @override
  String get doseLogPreviousSystemLabel => 'REG.ANTERIOR';

  @override
  String get doseNoPeptides => 'Nenhum péptido disponível';

  @override
  String get doseNoPeptidesBody =>
      'Adicione um peptídeo a um protocolo ativo antes de registar o histórico.';

  @override
  String get doseCorrectHistory => 'Corrigir histórico de doses';

  @override
  String get dosePeptide => 'PÉPTIDO';

  @override
  String get doseDate => 'DATA';

  @override
  String get doseChooseDate => 'Escolha a data da dose';

  @override
  String doseSyringeUnitsEntry(String amount) {
    return '$amount unidades de seringa registadas para esta entrada.';
  }

  @override
  String get doseHistoryDisclaimer =>
      'Os registos históricos são apenas dados pessoais de acompanhamento. Não alteram a orientação médica nem as recomendações de dose.';

  @override
  String get notificationChannelName => 'Lembretes de dose';

  @override
  String get notificationChannelDescription =>
      'Lembretes agendados para as doses do seu protocolo de peptídeos ativo.';

  @override
  String get notificationDoseTitle => 'Hora da sua dose';

  @override
  String get notificationDoseBody =>
      'O seu lembrete de protocolo agendado está pronto.';

  @override
  String get notificationCycleTitle => 'Ponto de verificação do protocolo';

  @override
  String get notificationCycleBody =>
      'Um lembrete de janela de ciclo é devido hoje. Reveja o seu plano de acompanhamento.';

  @override
  String get notificationRestTitle =>
      'Ponto de verificação do período de descanso';

  @override
  String get notificationRestBody =>
      'Hoje há um lembrete de período de repouso. Reveja o seu plano de registo.';

  @override
  String get notificationPhaseTitle =>
      'Ponto de verificação da fase do protocolo';

  @override
  String get notificationPhaseBody =>
      'Uma nova fase de acompanhamento começa hoje. Reveja o seu calendário guardado.';

  @override
  String get personalLibrarySystemLabel => 'SYS.BIBLIOTECA // PESSOAL';

  @override
  String get customCompoundIntro =>
      'Guarde etiquetas e tamanhos de frasco introduzidos por si. Os ajustes são atalhos de registo — não recomendações de dose.';

  @override
  String get archivedHeading => 'ARQUIVADOS';

  @override
  String get activePresetsHeading => 'AJUSTES ATIVOS';

  @override
  String get showActive => 'Mostrar ativos';

  @override
  String get archivedAction => 'Arquivado';

  @override
  String get customCompoundsLoadFailed =>
      'Não foi possível carregar os seus compostos. Tente novamente.';

  @override
  String get libraryLoadFailed =>
      'Não foi possível carregar a biblioteca de peptídeos. Tente novamente.';

  @override
  String compoundVialSummary(String amount, String unit, String route) {
    return 'Frasco de $amount $unit · $route';
  }

  @override
  String get editPreset => 'Editar ajuste';

  @override
  String get restorePreset => 'Restaurar';

  @override
  String get archivePreset => 'Arquivar';

  @override
  String get noArchivedPresets => 'Sem predefinições arquivadas';

  @override
  String get noSavedCompounds => 'Sem compostos guardados';

  @override
  String get archivedPresetsHint =>
      'Os ajustes arquivados permanecem aqui até serem restaurados.';

  @override
  String get createPresetHint =>
      'Crie um ajuste reutilizável de nome e tamanho de frasco.';

  @override
  String get presetCompoundSystemLabel => 'PREDEFINIÇÃO.COMPOSTO';

  @override
  String get newCompound => 'Novo composto';

  @override
  String get editCompound => 'Editar composto';

  @override
  String get ownVialDetailsHint =>
      'Insira apenas os detalhes indicados no seu próprio frasco.';

  @override
  String get compoundLabel => 'ETIQUETA DO COMPOSTO';

  @override
  String get compoundNameExample => 'ex.: O meu composto';

  @override
  String get vialUnitLabel => 'UNIDADE DO FRASCO';

  @override
  String get trackingUnitLabel => 'UNIDADE DE ACOMPANHAMENTO';

  @override
  String get notesOptional => 'NOTAS OPCIONAIS';

  @override
  String get compoundNoteExample => 'Etiqueta ou nota de armazenamento';

  @override
  String get noDoseRecommendation =>
      'Não é criada nenhuma recomendação de dose. As quantidades do protocolo são sempre introduzidas separadamente por si.';

  @override
  String get saveCompoundFailed =>
      'Não foi possível guardar o ajuste. Tente novamente.';

  @override
  String get routeTopical => 'Tópica';

  @override
  String get frequencyCustomDays => 'Dias personalizados';

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
    return 'U-100 · $volume ml / $capacity unidade';
  }
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
  String get converterCardSubtitle => 'Converta os dados do frasco agora';

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
  String get notes => 'NOTAS';

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
  String get bacShort => 'BAC (mL)';

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
  String get frequencyDaily => 'Diária';

  @override
  String get frequencyEveryOtherDay => 'Em dias alternados';

  @override
  String get frequencyTwiceWeekly => '2 vezes por semana';

  @override
  String get frequencyWeekly => 'Semanalmente';

  @override
  String get frequencyAsNeeded => 'Quando necessário';

  @override
  String get tabProtocol => 'Protocolo';

  @override
  String get tabProgress => 'Progresso';

  @override
  String get tabLibrary => 'Biblioteca';

  @override
  String get tabYou => 'Você';

  @override
  String get continueLabel => 'CONTINUAR';

  @override
  String get processingLabel => 'PROCESSANDO…';

  @override
  String get authAppleFailed => 'Falha no login com Apple. Tente novamente.';

  @override
  String get authGoogleFailed =>
      'Falha ao entrar com o Google. Tente novamente.';

  @override
  String get authGenericError => 'Algo deu errado. Tente novamente.';

  @override
  String get authUserNotFound => 'Nenhum usuário encontrado com este e-mail.';

  @override
  String get authIncorrectCredentials => 'E-mail ou senha incorretos.';

  @override
  String get authAccountExists => 'Já existe uma conta com esse e-mail.';

  @override
  String get authWeakPassword =>
      'Senha muito fraca. Use pelo menos 6 caracteres.';

  @override
  String get authInvalidEmail => 'E-mail inválido.';

  @override
  String get authAppleUnavailable =>
      'O login com Apple não está disponível neste app.';

  @override
  String get authRequiredTitle => 'Salve seu protocolo\npersonalizado';

  @override
  String get authRequiredBody =>
      'Vincule seu roteiro, cronograma, registros de dose e lembretes à sua conta antes de desbloquear o protocolo.';

  @override
  String get continueWithEmail => 'CONTINUAR COM E-MAIL';

  @override
  String get signInWithApple => 'ENTRAR COM A APPLE';

  @override
  String get continueWithGoogle => 'CONTINUAR COM O GOOGLE';

  @override
  String get authTermsDisclaimer =>
      'Ao continuar, você aceita nossos Termos e nossa Política de Privacidade. O PepMod é uma ferramenta educativa — não é orientação médica.';

  @override
  String get signIn => 'Entrar';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get resetPassword => 'Redefinir senha';

  @override
  String get signInAction => 'ENTRAR';

  @override
  String get createAccountAction => 'CRIAR CONTA';

  @override
  String get sendResetLink => 'ENVIAR LINK DE REDEFINIÇÃO';

  @override
  String get passwordResetSent =>
      'E-mail de redefinição de senha enviado. Verifique sua caixa de entrada.';

  @override
  String get enterEmail => 'Insira seu e-mail';

  @override
  String get enterValidEmail => 'Digite um e-mail válido';

  @override
  String get enterPassword => 'Insira uma senha';

  @override
  String get passwordMinLength => 'Pelo menos 6 caracteres';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta? Entrar';

  @override
  String get backToSignIn => 'Voltar para o login';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get showPassword => 'Mostrar senha';

  @override
  String get hidePassword => 'Ocultar senha';

  @override
  String get accountDeletedTitle => 'Conta excluída';

  @override
  String get accountDeletedBody =>
      'Sua conta do PepMod e os dados salvos no app foram removidos.';

  @override
  String get subscriptionUnavailable =>
      'Os planos de assinatura não estão disponíveis no momento. Tente novamente.';

  @override
  String get upgradeUnavailable =>
      'O upgrade não está disponível no momento. Tente novamente mais tarde.';

  @override
  String get noPurchasesToRestore =>
      'Nenhuma compra encontrada para restaurar.';

  @override
  String get unlockFullProtocol => 'Desbloqueie o protocolo completo';

  @override
  String get premiumUnlimitedPeptides => 'Peptídeos ilimitados por protocolo';

  @override
  String get premiumMultipleProtocols => 'Vários protocolos ativos';

  @override
  String get premiumCalculator =>
      'Calculadora de reconstituição (todos os peptídeos)';

  @override
  String get premiumMetrics =>
      'Acompanhamento de métricas corporais + gráficos';

  @override
  String get upgradeNow => 'FAZER UPGRADE AGORA';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get notRightNow => 'Agora não';

  @override
  String get protocolWeeklyPlanner => 'Planejador semanal';

  @override
  String get protocolDoseHistory => 'Histórico de doses';

  @override
  String get protocolCreate => 'Criar protocolo';

  @override
  String get protocolManage => 'GERENCIAR';

  @override
  String get protocolYourProtocol => 'Seu Protocolo';

  @override
  String get protocolNoActive => 'Nenhum protocolo ativo';

  @override
  String get protocolNoActiveBody =>
      'Crie seu primeiro protocolo para começar a registrar doses e acompanhar sua constância.';

  @override
  String get protocolStartFirst => 'INICIAR PRIMEIRO PROTOCOLO';

  @override
  String get protocolScheduleTodaySystemLabel => 'PROGRAMAÇÃO // HOJE';

  @override
  String get protocolAdherenceTodaySystemLabel => 'ADESÃO // HOJE';

  @override
  String get protocolNoDosesScheduledToday => 'Nenhuma dose agendada para hoje';

  @override
  String protocolDosesTaken(int taken, int total) {
    return '$taken de $total doses tomadas';
  }

  @override
  String get protocolNextDose => 'PRÓXIMA DOSE';

  @override
  String protocolInTime(String duration) {
    return 'Em $duration';
  }

  @override
  String protocolDurationHoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String protocolDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get protocolLogDose => 'REGISTRAR DOSE';

  @override
  String get protocolNow => 'agora';

  @override
  String get protocolMissed => 'PERDIDA';

  @override
  String get protocolSkipped => 'PULADA';

  @override
  String get protocolNoDosesToday => 'Nenhuma dose hoje';

  @override
  String get protocolNoDosesTodayBody =>
      'Seu protocolo não tem doses agendadas para hoje.';

  @override
  String get protocolFreeLimit =>
      'O plano gratuito permite apenas um protocolo. Faça upgrade para o Premium para rodar várias combinações ao mesmo tempo.';

  @override
  String protocolSyringeUnitsSuffix(String amount) {
    return ' · $amount unidades de seringa';
  }

  @override
  String get injectionSiteLeftAbdomen => 'Abdômen esquerdo';

  @override
  String get injectionSiteRightAbdomen => 'Abdômen direito';

  @override
  String get injectionSiteLeftThigh => 'Coxa esquerda';

  @override
  String get injectionSiteRightThigh => 'Coxa direita';

  @override
  String get injectionSiteLeftGlute => 'Glúteo esquerdo';

  @override
  String get injectionSiteRightGlute => 'Glúteo direito';

  @override
  String get injectionSiteLeftTriceps => 'Tríceps esquerdo';

  @override
  String get injectionSiteRightTriceps => 'Tríceps direito';

  @override
  String get plannerToday => 'HOJE';

  @override
  String get plannerBack => 'Voltar';

  @override
  String get plannerPreviousWeek => 'Semana anterior';

  @override
  String get plannerNextWeek => 'Próxima semana';

  @override
  String plannerScheduledCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count doses agendadas',
      one: '$count dose agendada',
    );
    return '$_temp0';
  }

  @override
  String get plannerTrackingDisclaimer =>
      'Somente rastreamento. Este calendário reflete o protocolo salvo e não fornece orientação de dosagem.';

  @override
  String get plannerWashoutPeriod => 'Período de washout';

  @override
  String plannerWashoutUntil(String date) {
    return 'Pausa até $date';
  }

  @override
  String get plannerNoScheduledDoses => 'Nenhuma dose agendada';

  @override
  String get plannerNothingPlanned =>
      'Nada planejado a partir dos seus protocolos salvos.';

  @override
  String get activatePro => 'ATIVAR PRO';

  @override
  String activateProPrice(String price) {
    return 'ATIVAR PRO — $price/ano';
  }

  @override
  String get annualAccess => 'Acesso anual';

  @override
  String get annualLabel => 'Anual';

  @override
  String get averageRating => 'AVALIAÇÃO MÉDIA';

  @override
  String get bacWaterLabel => 'ÁGUA BACTERIOSTÁTICA';

  @override
  String get basedOnInputs => 'Com base nos seus dados //';

  @override
  String get bestValue => 'Melhor Custo-Benefício';

  @override
  String get birthDateInvalid =>
      'Insira uma data válida para alguém com 18 anos ou mais.';

  @override
  String get birthDateValid => 'Idade verificada';

  @override
  String calculatorDemoBody(String peptideName) {
    return 'Veja como funciona com $peptideName';
  }

  @override
  String get calculatorDemoResult =>
      'É só isso. Insira seus valores\ne obtenha as unidades exatas da seringa.';

  @override
  String get calculatorDemoTitle => 'Chega de\ncontas complicadas.';

  @override
  String get confidenceCycleTiming => 'Tempo de ciclo';

  @override
  String get confidenceCycleTimingDetail =>
      'Veja com clareza as datas do protocolo e as janelas do cronograma';

  @override
  String get confidenceDoseMath => 'Cálculo de dose';

  @override
  String get confidenceDoseMathDetail =>
      'Mantenha frasco, água, dose e unidades de puxada juntos';

  @override
  String get confidenceLabel => 'CONFIANÇA';

  @override
  String get confidencePlainInfo => 'Informações em linguagem simples';

  @override
  String get confidencePlainInfoDetail =>
      'Leia notas de pesquisa sem poluição visual';

  @override
  String get confidenceProgressSignals => 'Sinais de progresso';

  @override
  String get confidenceProgressSignalsDetail =>
      'Veja a adesão e as métricas corporais ao longo do tempo';

  @override
  String get confidenceSafetyFraming => 'Orientação com foco em segurança';

  @override
  String get confidenceSafetyFramingDetail =>
      'Mantenha orientações educativas e avisos sempre visíveis';

  @override
  String get confidenceSiteRotation => 'Rotação de locais';

  @override
  String get confidenceSiteRotationDetail =>
      'Lembre onde cada dose foi registrada';

  @override
  String get connectingToStore => 'CONECTANDO À LOJA...';

  @override
  String continueSelected(int count) {
    return 'CONTINUAR ($count)';
  }

  @override
  String get customProtocol => 'Protocolo personalizado';

  @override
  String get dateOfBirthLabel => 'DATA DE NASCIMENTO';

  @override
  String get dayOne => 'DIA 1';

  @override
  String get dayShortLabel => 'DD';

  @override
  String get defaultConfidence => 'Cálculo de dose · Rotação de locais';

  @override
  String get defaultFrustration => 'Doses esquecidas';

  @override
  String get defaultGoals => 'Recuperação · Longevidade';

  @override
  String get doseLabel => 'DOSE';

  @override
  String get dosesLogged => 'DOSES REGISTRADAS';

  @override
  String get dosesPerDay => 'DOSES/DIA';

  @override
  String get drawVolumeLabel => 'VOLUME A PUXAR';

  @override
  String get durationLabel => 'DURAÇÃO';

  @override
  String get experienceAdvanced => 'Avançado';

  @override
  String get experienceAdvancedDetail =>
      'Tenho facilidade para gerenciar protocolos detalhados';

  @override
  String get experienceFirstTime => 'Primeira vez';

  @override
  String get experienceFirstTimeDetail =>
      'Sou novo no rastreamento de peptídeos';

  @override
  String get experienceIntermediate => 'INTERMEDIÁRIO';

  @override
  String get experienceLabel => 'EXPERIÊNCIA';

  @override
  String get experienceNovice => 'INICIANTE';

  @override
  String get experienceSome => 'Alguma experiência';

  @override
  String get experienceSomeDetail => 'Já acompanhei um ou dois protocolos';

  @override
  String get experienceVeteran => 'VETERANO';

  @override
  String get featureDoseMathBody =>
      'Mantenha o tamanho do frasco, o volume de água, a dose e as unidades a puxar junto do protocolo que você está acompanhando.';

  @override
  String get featureDoseMathTitle => 'Cálculo de Dose\nEm Contexto';

  @override
  String get featureProtocolArcBody =>
      'Veja doses planejadas, doses registradas, constância e métricas corporais reunidas em uma única linha do tempo.';

  @override
  String get featureProtocolArcTitle =>
      'Trajetória do\nProtocolo ao Longo do Tempo';

  @override
  String get featureShowcaseTitle => 'Tudo o que você precisa.\nUm só app.';

  @override
  String get featureSiteRotationBody =>
      'Lembre-se de cada local registrado e mantenha o histórico de rodízio junto ao registro da dose.';

  @override
  String get featureSiteRotationTitle => 'Rotação de\nLocais de Injeção';

  @override
  String get firstNameExample => 'ex.: Alex';

  @override
  String get firstNameLabel => 'PRIMEIRO NOME';

  @override
  String get frustrationForgetting => 'Esquecer doses';

  @override
  String get frustrationLabel => 'FRUSTRAÇÃO';

  @override
  String get frustrationMath => 'Cálculos de frasco e seringa';

  @override
  String get frustrationProgress => 'Saber se estou sendo consistente';

  @override
  String get frustrationSchedule => 'Manter a agenda organizada';

  @override
  String get frustrationStacking => 'Gerenciar vários peptídeos';

  @override
  String get frustrationTrust => 'Encontrar informações confiáveis';

  @override
  String get goalAntiAging => 'Envelhecimento saudável';

  @override
  String get goalAntiAgingDetail => 'Organize registros focados em longevidade';

  @override
  String get goalCognitive => 'Suporte cognitivo';

  @override
  String get goalCognitiveDetail => 'Monitore o foco e o desempenho mental';

  @override
  String get goalImmune => 'Suporte imunológico';

  @override
  String get goalImmuneDetail =>
      'Mantenha protocolos focados em imunidade organizados';

  @override
  String get goalMuscleGrowth => 'Ganho de massa muscular';

  @override
  String get goalMuscleGrowthDetail =>
      'Acompanhe metas de treino e crescimento';

  @override
  String get goalOther => 'Outro';

  @override
  String get goalOtherDetail =>
      'Configure um objetivo de rastreamento diferente';

  @override
  String get goalRecovery => 'Recuperação';

  @override
  String get goalRecoveryDetail => 'Apoie registros e rotinas de recuperação';

  @override
  String get goalSleep => 'Sono';

  @override
  String get goalSleepDetail =>
      'Acompanhe objetivos e padrões relacionados ao sono';

  @override
  String get goalWeightLoss => 'Perda de peso';

  @override
  String get goalWeightLossDetail => 'Acompanhe metas e progresso metabólico';

  @override
  String get goalsLabel => 'OBJETIVOS';

  @override
  String get iUnderstand => 'ENTENDI';

  @override
  String get lastThreeDaysAgo => 'Última: há 3 dias';

  @override
  String get leftAbdomen => 'Abdômen esquerdo';

  @override
  String get loveIt => 'ADOREI';

  @override
  String get maybeLater => 'Talvez depois';

  @override
  String get monthOne => 'MÊS 1';

  @override
  String get monthShortLabel => 'MM';

  @override
  String get monthTwo => 'MÊS 2';

  @override
  String moreCount(String shown, int count) {
    return '$shown +$count a mais';
  }

  @override
  String get needsWork => 'PRECISA MELHORAR';

  @override
  String get notificationBody =>
      'Receba lembretes discretos quando uma janela de protocolo estiver programada. Nenhum nome de peptídeo aparece nas notificações — apenas um lembrete gentil.';

  @override
  String get notificationTitle => 'Mantenha os horários de dose\nà vista.';

  @override
  String get nowLabel => 'agora';

  @override
  String get ok => 'OK';

  @override
  String get onboardingAgeConfirmed => 'TENHO 18 ANOS OU MAIS';

  @override
  String get onboardingAgeRequirementBody =>
      'Você precisa ter 18 anos ou mais para usar o PepMod.';

  @override
  String get onboardingAgeRequirementTitle => 'Requisito de idade';

  @override
  String get onboardingAgeVerificationBody =>
      'O PepMod é destinado a adultos com 18 anos ou mais.';

  @override
  String get onboardingAgeVerificationTitle => 'Primeiro, confirme\nsua idade.';

  @override
  String get onboardingAheadBody =>
      'Responda algumas perguntas e o PepMod vai montar uma prévia personalizada de acompanhamento.';

  @override
  String get onboardingAheadTitle => 'Veja seu protocolo\nantes de começar.';

  @override
  String get onboardingBirthDateBody =>
      'Isso confirma que você atende ao requisito de idade.';

  @override
  String get onboardingBirthDateTitle => 'Quando você\nnasceu?';

  @override
  String get onboardingConfidenceBody =>
      'Escolha tudo o que o PepMod deve deixar mais claro.';

  @override
  String get onboardingConfidenceTitle => 'Onde você quer\nmais confiança?';

  @override
  String get onboardingConversionValueBody =>
      'Converta os dados do seu frasco e plano em volume e unidades de seringa.';

  @override
  String get onboardingConversionValueTitle =>
      'Facilite a conferência\ndo cálculo do frasco.';

  @override
  String get onboardingDisclaimerBody =>
      'O PepMod ajuda a organizar registros, lembretes e conversões de unidade. Ele não diagnostica, não prescreve e não substitui a orientação de um profissional de saúde qualificado.';

  @override
  String get onboardingDisclaimerTitle =>
      'Feito para clareza.\nNão para prescrições.';

  @override
  String get onboardingExperienceTitle => 'Qual é o seu\nnível de experiência?';

  @override
  String get onboardingFrustrationBody => 'Escolha o maior ponto de atrito.';

  @override
  String get onboardingFrustrationTitle => 'O que é mais\ndifícil hoje?';

  @override
  String get onboardingGoalsTitle => 'Quais são seus\nprincipais objetivos?';

  @override
  String get onboardingGuidedStartBody =>
      'Vamos ajustar a configuração aos seus objetivos, experiência e aos registros que você quer manter.';

  @override
  String get onboardingGuidedStartTitle =>
      'Um começo guiado,\nfeito para você.';

  @override
  String get onboardingHookAnswer =>
      'O PepMod mantém a resposta junto do seu protocolo.';

  @override
  String get onboardingHookQuestion => 'Quantas unidades\nvocê puxa?';

  @override
  String get onboardingHookResearch => 'BIBLIOTECA DE PESQUISA';

  @override
  String get onboardingHookSources => 'Fontes com evidências vinculadas';

  @override
  String get onboardingHookVial => 'FRASCO + DILUENTE';

  @override
  String get onboardingNameBody =>
      'Vamos usar isso para personalizar sua experiência no PepMod.';

  @override
  String get onboardingNameTitle => 'Como devemos\nte chamar?';

  @override
  String get onboardingPeptideSelectBody =>
      'Escolha os peptídeos que você usa ou quer acompanhar.';

  @override
  String get onboardingPeptideSelectTitle => 'O que você está\nacompanhando?';

  @override
  String get onboardingProgressValueBody =>
      'Reúna adesão, histórico de doses e métricas corporais em um único registro claro.';

  @override
  String get onboardingProgressValueTitle =>
      'Veja toda a\nsua trajetória ao longo do tempo.';

  @override
  String get onboardingProtocolValueBody =>
      'Planeje horários, registre doses e mantenha os detalhes ligados a cada protocolo.';

  @override
  String get onboardingProtocolValueTitle =>
      'Mantenha todos os protocolos\nem um só lugar.';

  @override
  String get onboardingUnder18 => 'SOU MENOR DE 18 ANOS';

  @override
  String get openingPermission => 'ABRINDO PERMISSÃO...';

  @override
  String get paywallArcBody =>
      'Veja o que foi planejado, o que foi registrado e o que precisa de um registro mais claro a seguir.';

  @override
  String get paywallArcTitle => 'ACOMPANHE A EVOLUÇÃO AO LONGO DO TEMPO';

  @override
  String get paywallBody =>
      'Cálculo de dose, rodízio de locais, lembretes e histórico de protocolo — tudo em um só registro.';

  @override
  String get paywallDoseMathBody =>
      'Mantenha frasco, água, dose e unidades de puxada juntos para conferir cada registro com mais facilidade.';

  @override
  String get paywallDoseMathTitle => 'ACERTE O CÁLCULO DA DOSE';

  @override
  String get paywallPreviewDisclaimer =>
      'Feito para registros, lembretes e clareza nas unidades — não é orientação médica.';

  @override
  String get paywallRotationBody =>
      'Cada local, ciclo e lembrete fica vinculado ao registro do protocolo.';

  @override
  String get paywallRotationTitle => 'NUNCA PERCA SUA ROTAÇÃO';

  @override
  String get paywallTitle => 'Tudo para conduzir\nseu protocolo direito.';

  @override
  String get paywallValueNote =>
      'Um cálculo de frasco confuso pode desperdiçar tempo e produto. O PepMod mantém a matemática junto do registro para você conferir seus dados antes de agir com base em anotações antigas.';

  @override
  String get peptideLabel => 'PEPTÍDEO';

  @override
  String get peptidesLabel => 'PEPTÍDEOS';

  @override
  String get peptidesTracked => 'PEPTÍDEOS\nACOMPANHADOS';

  @override
  String get perWeek => '/semana';

  @override
  String get perYear => '/ano';

  @override
  String get privacyLabel => 'Privacidade';

  @override
  String processingGoals(int count) {
    return 'ANALISANDO $count METAS...';
  }

  @override
  String processingPeptides(int count) {
    return 'VINCULANDO $count REGISTROS DE PEPTÍDEOS...';
  }

  @override
  String get processingProtocol => 'MONTANDO SEU PROTOCOLO...';

  @override
  String get processingSchedule => 'ORGANIZANDO SEU CRONOGRAMA...';

  @override
  String get processingTitle => 'Montando seu\nprotocolo';

  @override
  String get progressLabel => 'Progresso';

  @override
  String get protocolClarity => 'clareza do protocolo';

  @override
  String get protocolIncludes => 'SEU PROTOCOLO INCLUI //';

  @override
  String get protocolPreviewTitle => 'Seu protocolo\nestá pronto.';

  @override
  String get protocolReady => 'PROTOCOLO PRONTO //';

  @override
  String get protocolReminderReady => 'O lembrete do protocolo está pronto';

  @override
  String get protocolReservedFor =>
      'SEU PROTOCOLO PERSONALIZADO ESTÁ RESERVADO PARA';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get resultsSummaryBody =>
      'Vamos manter os registros de dose, os cálculos de reconstituição e o histórico de tendências reunidos à medida que seus dados crescem.';

  @override
  String get reviewGateBody =>
      'Seu feedback nos ajuda a melhorar a plataforma para todo biohacker.';

  @override
  String get reviewGateTitle => 'Está gostando\ndo PepMod até agora?';

  @override
  String roadmapBody(int count, String need) {
    return 'Construído em torno de $count peptídeos acompanhados e da sua necessidade de $need.';
  }

  @override
  String get roadmapDayOneBody =>
      'Peptídeos, registros de dose, rodízio de locais de aplicação e lembretes já estão prontos.';

  @override
  String get roadmapDayOneTitle => 'Seu primeiro protocolo está organizado';

  @override
  String get roadmapDisclaimer =>
      'O PepMod organiza registros e lembretes. Ele não prescreve, diagnostica nem substitui a orientação de um profissional de saúde.';

  @override
  String get roadmapMonthOneBody =>
      'Adesão, doses esquecidas e métricas corporais começam a formar um registro mais claro.';

  @override
  String get roadmapMonthOneTitle =>
      'Seu histórico de consistência começa a tomar forma';

  @override
  String get roadmapMonthTwoBody =>
      'Veja o que você planejou, o que aconteceu e onde seus registros precisam de atenção.';

  @override
  String get roadmapMonthTwoTitle =>
      'Sua trajetória completa do protocolo fica visível';

  @override
  String get roadmapTitle => 'Veja o que\nvem a seguir.';

  @override
  String get roadmapWeekOneBody =>
      'Anotações de pesquisa em linguagem simples e de acompanhamento ficam vinculadas ao seu plano.';

  @override
  String roadmapWeekOneTitle(String goal) {
    return 'Sua biblioteca se organiza em torno de $goal';
  }

  @override
  String savePercent(int percent) {
    return 'ECONOMIZE $percent%';
  }

  @override
  String get saveRoadmap => 'SALVAR ESSE ROTEIRO';

  @override
  String get schedulePreview => 'PRÉVIA DO CRONOGRAMA';

  @override
  String get seeWhatsInside => 'VEJA O QUE TEM DENTRO';

  @override
  String get selectAllThatApply => 'Selecione todas as opções que se aplicam.';

  @override
  String get siteMap => 'Mapa de locais';

  @override
  String get skipForNow => 'PULAR POR AGORA';

  @override
  String get socialProofBody =>
      'Junte-se a milhares acompanhando um progresso real.';

  @override
  String get socialProofTitle => 'Confiado por\nbiohackers no mundo todo';

  @override
  String get specialOffer => 'OFERTA ESPECIAL';

  @override
  String get startFreeTrial => 'INICIAR TESTE GRATUITO';

  @override
  String get subscribeLabel => 'ASSINAR';

  @override
  String subscribePrice(String price) {
    return 'ASSINAR — $price/semana';
  }

  @override
  String get subscribeToActivate => 'Assine para ativar seu protocolo';

  @override
  String get subscriptionRenewalDisclaimer =>
      'A assinatura é renovada automaticamente, a menos que seja cancelada pelo menos 24 horas antes do fim do período atual. Gerencie em Ajustes > ID Apple > Assinaturas.';

  @override
  String syringeVolume(String volume) {
    return '${volume}ml em uma seringa de 1ml';
  }

  @override
  String get termsLabel => 'Termos';

  @override
  String get testimonialOne =>
      'Finalmente parei de esquecer doses. Só a calculadora de reconstituição já me poupou horas de conta em planilha.';

  @override
  String get testimonialThree =>
      'O rastreador de peptídeos mais organizado que já usei. Parece feito para quem leva isso a sério, porque é.';

  @override
  String get testimonialTwo =>
      'As análises semanais apontaram um problema de horário que eu não percebia havia meses. Mudou o jogo.';

  @override
  String get thirtyDayAdherence => 'Constância em 30 dias';

  @override
  String get threeDayFreeTrial => '3 DIAS GRÁTIS';

  @override
  String get timelineLabel => 'Linha do tempo';

  @override
  String get trackedLabel => 'rastreado';

  @override
  String get turnOnReminders => 'ATIVAR LEMBRETES';

  @override
  String get unitConversionDisclaimer =>
      'Ferramenta de conversão de unidades apenas para referência. Sempre confirme com seu profissional de saúde.';

  @override
  String get unitsLabel => 'Unidades';

  @override
  String get unitsToDraw => 'Unidades a puxar';

  @override
  String get unlockPepMod => 'DESBLOQUEAR O PEPMOD';

  @override
  String get usersLabel => 'USUÁRIOS';

  @override
  String get viewLabel => 'VER';

  @override
  String get weekDuration => 'DURAÇÃO\nEM SEMANAS';

  @override
  String get weekOne => 'SEMANA 1';

  @override
  String get weeklyLabel => 'Semanal';

  @override
  String weeksCount(int count) {
    return '$count semanas';
  }

  @override
  String get yearLabel => 'ANO';

  @override
  String get profileTitle => 'Você';

  @override
  String get signedIn => 'Sessão iniciada';

  @override
  String get sectionAccount => 'CONTA';

  @override
  String get sectionPreferences => 'PREFERÊNCIAS';

  @override
  String get sectionData => 'DADOS';

  @override
  String get sectionSupport => 'SUPORTE';

  @override
  String get sectionLegal => 'JURÍDICO';

  @override
  String get sectionAbout => 'SOBRE';

  @override
  String get nameLabel => 'Nome';

  @override
  String get accountLabel => 'Conta';

  @override
  String get deleteAccount => 'Excluir conta';

  @override
  String get removeAccountData => 'Remover conta e dados';

  @override
  String get metricLabel => 'Métrica';

  @override
  String get imperialLabel => 'Imperial';

  @override
  String get notificationsLabel => 'Notificações';

  @override
  String get onLabel => 'Ativado';

  @override
  String get offLabel => 'Desativado';

  @override
  String get myCompoundsProfile => 'Meus compostos';

  @override
  String get savedVialPresets => 'Ajustes de frasco salvos';

  @override
  String get exportData => 'Exportar dados';

  @override
  String get copyAsJson => 'Copiar como JSON';

  @override
  String get clearAllData => 'Limpar todos os dados';

  @override
  String get clearingLabel => 'Limpando…';

  @override
  String get resetApp => 'Redefinir app';

  @override
  String get contactSupport => 'Contatar suporte';

  @override
  String get chatWithUs => 'Fale conosco';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get medicalDisclaimer => 'Aviso médico';

  @override
  String get disclaimerTitle => 'Aviso legal';

  @override
  String get versionLabel => 'Versão';

  @override
  String get signOutAction => 'SAIR';

  @override
  String get educationalTrackingDisclaimer =>
      'Apenas registro educativo. Não é aconselhamento médico.';

  @override
  String get yourName => 'Seu nome';

  @override
  String get cancelLabel => 'Cancelar';

  @override
  String get saveLabel => 'Salvar';

  @override
  String get dataCopied => 'Dados copiados para a área de transferência.';

  @override
  String get clearDataTitle => 'Limpar todos os dados?';

  @override
  String get clearDataBody =>
      'Isso exclui todos os protocolos, registros de dose e métricas corporais, e reinicia a integração inicial. Sua conta, assinatura e a biblioteca de peptídeos são preservadas. Essa ação não pode ser desfeita.';

  @override
  String get clearLabel => 'Limpar';

  @override
  String get clearingDataTitle => 'Limpando dados…';

  @override
  String get clearingDataBody =>
      'Mantenha o PepMod aberto enquanto seus dados de acompanhamento são removidos.';

  @override
  String get clearDataFailed =>
      'Não foi possível limpar os dados. Verifique sua conexão e tente novamente.';

  @override
  String get allDataCleared => 'Todos os dados foram apagados.';

  @override
  String get deleteAccountTitle => 'Excluir conta?';

  @override
  String get deleteAccountBody =>
      'Isso exclui permanentemente sua conta do PepMod, configurações, protocolos, registros de dose e métricas corporais. Essa ação não pode ser desfeita.';

  @override
  String get deletingAccount => 'Excluindo conta…';

  @override
  String get accountDeletionFailed =>
      'Falha ao excluir a conta. Tente novamente.';

  @override
  String get confirmPassword => 'Confirmar senha';

  @override
  String get deleteLabel => 'Excluir';

  @override
  String get signOutTitle => 'Sair da conta?';

  @override
  String get signOutBody =>
      'Seus protocolos continuam salvos e sincronizam de novo quando você entrar outra vez.';

  @override
  String get signOutLabel => 'Sair';

  @override
  String get signOutFailed => 'Falha ao sair da conta. Tente novamente.';

  @override
  String get notificationsDisabledSystem =>
      'As notificações estão desativadas nos ajustes do sistema.';

  @override
  String get planPro => 'PRO';

  @override
  String get planFree => 'GRATUITO';

  @override
  String get termsBody =>
      'O PepMod é fornecido apenas para fins educacionais e de acompanhamento. Não é um dispositivo médico e não oferece aconselhamento médico, diagnóstico, prescrições ou recomendações de tratamento. Ao usar o PepMod, você é responsável por seus próprios registros, decisões e pela consulta a profissionais de saúde qualificados.\n\nAs assinaturas renovam automaticamente, a menos que sejam canceladas pela App Store ou pelo Google Play antes do período de renovação. Os reembolsos são tratados pela loja onde a compra foi feita.\n\nTermos completos: https://appstorecopilot.com/legal/yzh32x5v/terms';

  @override
  String get privacyBody =>
      'O PepMod usa o Firebase para autenticação e armazenamento de dados na nuvem, o RevenueCat para assinaturas, o AppRefer e os Eventos de App da Meta/Facebook para atribuição, e o Firebase/Crashlytics para análise e diagnóstico. Não vendemos suas informações pessoais. Você pode excluir sua conta e os dados salvos no app diretamente pelo aplicativo.\n\nPolítica de Privacidade completa: https://appstorecopilot.com/legal/yzh32x5v/privacy';

  @override
  String get medicalDisclaimerBody =>
      'O PepMod é uma ferramenta de bem-estar e rastreamento — NÃO é um dispositivo médico. Nada neste app constitui aconselhamento médico, diagnóstico, prescrição ou recomendação de tratamento. Os peptídeos descritos na biblioteca têm finalidade exclusivamente educativa. Sempre consulte um profissional de saúde qualificado antes de iniciar, alterar ou interromper qualquer protocolo. Se você sentir qualquer efeito adverso, procure atendimento médico imediatamente.';

  @override
  String get profileSystemLabel => 'SYS.USUÁRIO // PERFIL';

  @override
  String get legalSystemLabel => 'SIS.JURÍDICO';

  @override
  String get progressTitle => 'Progresso';

  @override
  String get progressSystemLabel => 'SYS.PROGRESSO // BIOMÉTRICOS';

  @override
  String get doseHistoryTooltip => 'Abrir histórico de doses';

  @override
  String get logMeasurementTooltip => 'Registrar medida';

  @override
  String get thirtyDayLabel => '30 DIAS';

  @override
  String get adherenceLabel => 'adesão';

  @override
  String get streakLabel => 'SEQUÊNCIA';

  @override
  String get daysLabel => 'dias';

  @override
  String get totalLabel => 'TOTAL';

  @override
  String get dosesLabel => 'doses';

  @override
  String get protocolHistoryLabel => 'HISTÓRICO.PROTOCOLO';

  @override
  String get noProtocolsYet =>
      'Nenhum protocolo ainda. Crie um na aba Protocolo.';

  @override
  String get adherenceChartLabel => 'ADESÃO // 30.DIAS';

  @override
  String get thirtyDaysAgo => 'há 30d';

  @override
  String get todayLabel => 'hoje';

  @override
  String get noWeightData => 'Nenhum dado de peso';

  @override
  String get logFirstMeasurement =>
      'Registre sua primeira medição para ver tendências aqui.';

  @override
  String get logMeasurementAction => 'REGISTRAR MEDIDA';

  @override
  String get weightTrendLabel => 'PESO // TENDÊNCIA';

  @override
  String weightKgValue(String weight) {
    return '$weight kg';
  }

  @override
  String get statusActive => 'ATIVO';

  @override
  String get statusPaused => 'PAUSADO';

  @override
  String get statusEnded => 'ENCERRADO';

  @override
  String protocolPeptideCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count peptídeos',
      one: '1 peptídeo',
    );
    return '$_temp0';
  }

  @override
  String get enterOneMetric => 'Insira pelo menos um valor.';

  @override
  String get saveMetricFailed => 'Falha ao salvar. Tente novamente.';

  @override
  String get newMeasurement => 'Nova medição';

  @override
  String get weightLabel => 'PESO';

  @override
  String get bodyFatLabel => 'GORDURA CORPORAL';

  @override
  String get measurementsCmLabel => 'MEDIDAS (cm)';

  @override
  String get waistLabel => 'CINTURA';

  @override
  String get chestLabel => 'PEITO';

  @override
  String get armLabel => 'BRAÇO';

  @override
  String get saveAction => 'SALVAR';

  @override
  String get logMetricSystemLabel => 'LOG.MÉTRICA';

  @override
  String get activeLastSevenDays => 'ÚLTIMOS 7 DIAS';

  @override
  String get activeAllTime => 'TODO O PERÍODO';

  @override
  String get activeAdherence => 'adesão';

  @override
  String get activeStarted => 'INICIADO';

  @override
  String get activeEnded => 'ENCERRADA';

  @override
  String activeStackCount(int count) {
    return 'COMBINAÇÃO ($count)';
  }

  @override
  String get activeEditProtocol => 'EDITAR PROTOCOLO';

  @override
  String get activePauseProtocol => 'PAUSAR PROTOCOLO';

  @override
  String get activeEndProtocol => 'ENCERRAR PROTOCOLO';

  @override
  String get activeResumeProtocol => 'RETOMAR PROTOCOLO';

  @override
  String get activeDeleteProtocol => 'EXCLUIR PROTOCOLO';

  @override
  String get activeTrackingDisclaimer =>
      'Apenas registro educativo. Consulte um profissional de saúde qualificado antes de fazer mudanças.';

  @override
  String get activeEndQuestion => 'Encerrar protocolo?';

  @override
  String get activeEndBody =>
      'As doses futuras serão removidas. Os registros anteriores permanecem no seu histórico. Essa ação não pode ser desfeita.';

  @override
  String get activeEndAction => 'ENCERRAR';

  @override
  String get activeDeleteQuestion => 'Excluir protocolo?';

  @override
  String get activeDeleteBody =>
      'Isso remove permanentemente o protocolo e todos os seus registros de dose. Essa ação não pode ser desfeita.';

  @override
  String get activeDeleteAction => 'EXCLUIR';

  @override
  String get cancel => 'Cancelar';

  @override
  String get activeStatusActive => 'ATIVO';

  @override
  String get activeStatusPaused => 'PAUSADO';

  @override
  String get activeStatusEnded => 'ENCERRADO';

  @override
  String get activeNotesLabel => 'NOTAS // PROTOCOLO';

  @override
  String get activeChangeReminders => 'ALTERAR LEMBRETES';

  @override
  String get activeChangeRemindersBody =>
      'Quando as notificações estão ativadas, o PepMod agenda um lembrete às 09h no horário local para cada mudança de fase futura.';

  @override
  String activePhaseAnchor(String date) {
    return 'Os intervalos semanais têm como referência $date.';
  }

  @override
  String activeWeek(int week) {
    return 'SEMANA $week';
  }

  @override
  String activeWeeks(int start, int end) {
    return 'SEMANAS $start–$end';
  }

  @override
  String get activePerDayAmounts => 'Quantidades por dia';

  @override
  String get activeBaseAmount => 'Quantidade base';

  @override
  String get activeCurrent => 'ATUAL';

  @override
  String get activeBaseSchedule => 'Cronograma base';

  @override
  String get activeCustomDays => 'Dias personalizados';

  @override
  String get activeContinuousTracking => 'Acompanhamento contínuo';

  @override
  String get activeNoFixedCycle => 'Sem janela de ciclo fixa';

  @override
  String activeCycleProgress(int week, int total) {
    return 'Semana $week de $total';
  }

  @override
  String activeCycleEnds(String date) {
    return 'Ciclo termina em $date';
  }

  @override
  String activeRestProgress(int week, int total) {
    return 'Semana de descanso $week de $total';
  }

  @override
  String activeRestEnds(String date) {
    return 'A janela de descanso termina em $date';
  }

  @override
  String get activeCycleComplete => 'Ciclo concluído';

  @override
  String activeCompletedDate(String date) {
    return 'Concluído em $date';
  }

  @override
  String activeRestEnded(String date) {
    return 'A janela de descanso terminou em $date';
  }

  @override
  String get activeNoHistory => 'Nenhum protocolo pausado ou encerrado ainda.';

  @override
  String activeCompoundsCount(int count) {
    return '$count compostos';
  }

  @override
  String activeSyringeUnits(String amount) {
    return '$amount unidades de seringa';
  }

  @override
  String activeCycleWeeks(int count) {
    return 'ciclo de ${count}sem';
  }

  @override
  String activeRestWeeks(int count) {
    return '${count}sem de descanso';
  }

  @override
  String get activePerDraw => 'POR PUXADA';

  @override
  String activeVialSummary(String volume) {
    return 'Frasco de $volume mL · U-100';
  }

  @override
  String get addCompound => 'ADICIONAR COMPOSTO';

  @override
  String get addPhase => 'ADICIONAR FASE';

  @override
  String get addTime => 'Adicionar horário';

  @override
  String get addToStack => 'ADICIONAR À COMBINAÇÃO';

  @override
  String get amountRequired => 'Quantidade obrigatória';

  @override
  String get baseAmount => 'Quantidade base';

  @override
  String get baseSchedule => 'cronograma base';

  @override
  String get blendConfigBody =>
      'Insira exatamente o que está indicado no frasco. O PepMod converte a dose em um retrato por composto.';

  @override
  String get blendIncompleteError =>
      'Preencha pelo menos dois compostos, o volume de diluente e a quantidade a puxar.';

  @override
  String get blendNameHint => 'ex.: Mistura de recuperação';

  @override
  String get blendNameLabel => 'NOME DA MISTURA';

  @override
  String get blendSafetyDisclaimer =>
      'Somente conversão de unidades. O PepMod não recomenda combinação, dose, frequência ou método de reconstituição.';

  @override
  String get changeNoteHint => 'Seu próprio contexto para esta fase';

  @override
  String get changeNoteOptional => 'NOTA DE ALTERAÇÃO OPCIONAL';

  @override
  String colorOption(String hex) {
    return 'Opção de cor $hex';
  }

  @override
  String compoundNumber(int number) {
    return 'COMPOSTO $number';
  }

  @override
  String compoundsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count compostos',
      one: '1 composto',
    );
    return '$_temp0';
  }

  @override
  String copiedVialPreset(String amount, String unit) {
    return 'Predefinição de frasco $amount $unit · copiada para este protocolo';
  }

  @override
  String get createProtocolAction => 'CRIAR PROTOCOLO';

  @override
  String get createProtocolAddOneError => 'Adicione pelo menos um peptídeo.';

  @override
  String createProtocolBuildStep(int step, int total) {
    return 'Criar Protocolo · Etapa $step / $total';
  }

  @override
  String get createProtocolDefaultName => 'Meu Protocolo';

  @override
  String createProtocolEditStep(int step, int total) {
    return 'Editar protocolo · Etapa $step / $total';
  }

  @override
  String get createProtocolFreeLimitReason =>
      'O plano gratuito é limitado a um peptídeo por protocolo. Faça upgrade para combinar vários compostos.';

  @override
  String get createProtocolNameBody =>
      'Dê um nome fácil de lembrar — por exemplo, “Combinação de Recuperação” ou “Definição T2”.';

  @override
  String get createProtocolNameTitle => 'Dê um nome ao seu protocolo';

  @override
  String get createProtocolNoPeptides => 'Nenhum peptídeo ainda';

  @override
  String get createProtocolPickHint => 'Toque em + para escolher na biblioteca';

  @override
  String get createProtocolReviewBody =>
      'Confirme os detalhes do protocolo. Você pode editá-los a qualquer momento na tela de Gerenciamento.';

  @override
  String get createProtocolSaveError =>
      'Falha ao salvar o protocolo. Tente novamente.';

  @override
  String get createProtocolStackBody =>
      'Adicione um peptídeo ou combine vários compostos. Configure cada rótulo, dose, frequência e ciclo.';

  @override
  String get createProtocolStackTitle => 'Monte sua combinação';

  @override
  String get customBlend => 'Combinação personalizada';

  @override
  String get customDays => 'Dias personalizados';

  @override
  String get customDaysDisclaimer =>
      'Somente os dias da semana selecionados são programados. As quantidades são valores de registro inseridos por você, não orientação de dosagem.';

  @override
  String get customPeptide => 'Peptídeo personalizado';

  @override
  String get cycleWeeksLabel => 'SEMANAS DE CICLO';

  @override
  String get cycleWindowDisclaimer =>
      'As janelas de ciclo e descanso organizam o histórico de rastreamento. O PepMod não agenda doses futuras depois que a janela de ciclo termina.';

  @override
  String get defaultAmountLabel => 'QUANTIDADE PADRÃO';

  @override
  String get diluentVolumeLabel => 'VOLUME DE DILUENTE';

  @override
  String get drawExceedsVialError =>
      'A quantidade a puxar não pode exceder o volume do frasco.';

  @override
  String get drawLabel => 'PUXAR';

  @override
  String get drawPreviewLabel => 'PRÉVIA DA PUXADA';

  @override
  String drawPreviewValue(String units, String volume) {
    return '$units unidades = $volume mL';
  }

  @override
  String editTime(String time) {
    return 'Editar horário $time';
  }

  @override
  String get endWeekLabel => 'SEMANA FINAL';

  @override
  String get enterPeptideName => 'Insira o nome do peptídeo';

  @override
  String get frequencyLabel => 'FREQUÊNCIA';

  @override
  String get labelColorBody =>
      'Combine essa cor com a caneta ou o rótulo do frasco que você usa de verdade.';

  @override
  String get labelColorLabel => 'COR DA ETIQUETA';

  @override
  String get manageSavedCompounds => 'Gerenciar compostos salvos';

  @override
  String get nextLabel => 'PRÓXIMO';

  @override
  String get noneLabel => 'Nenhum';

  @override
  String get oneOffCompound => 'Composto avulso';

  @override
  String get oneOffCompoundBody => 'Use uma vez sem salvar um ajuste';

  @override
  String get optionalLabel => 'Opcional';

  @override
  String peptidesCount(int count) {
    return 'PEPTÍDEOS ($count)';
  }

  @override
  String get perDayAmounts => 'Quantidades por dia';

  @override
  String phaseExtendsWarning(int weeks) {
    return 'Uma fase ultrapassa o ciclo de $weeks semanas. Ajuste a fase ou a janela do ciclo.';
  }

  @override
  String get phaseNameHint => 'ex.: Acompanhamento da semana 1';

  @override
  String get phaseNameLabel => 'NOME DA FASE';

  @override
  String phaseNumber(int number) {
    return 'Fase $number';
  }

  @override
  String phaseOutsideCycleError(int weeks) {
    return 'Este ciclo de protocolo termina após a semana $weeks. Mantenha as semanas da fase dentro dessa janela.';
  }

  @override
  String get phaseOverlapError =>
      'Os intervalos de semanas das fases não podem se sobrepor.';

  @override
  String get phaseOverrideBody =>
      'Insira apenas o cronograma de acompanhamento que você já pretende seguir. O PepMod não recomenda quantidades.';

  @override
  String get phaseOverrideTitle => 'Substituição semana a semana';

  @override
  String get phasePreviewDisclaimer =>
      'Prévia apenas dos seus registros. O PepMod não recomenda nenhum cronograma.';

  @override
  String get phasePreviewLabel => 'PRÉVIA DA FASE';

  @override
  String get phaseReminderBody =>
      'Um lembrete neutro de mudança de fase é agendado para as 9h quando os lembretes de protocolo estão ativados.';

  @override
  String get phaseScheduleLabel => 'AGENDA DA FASE';

  @override
  String get phaseSelectDayError =>
      'Selecione pelo menos um dia. O PepMod não escolhe um cronograma por você.';

  @override
  String get phasesBody =>
      'Janelas de datas opcionais podem substituir essa quantidade e horário base. Fora delas, o horário base continua.';

  @override
  String phasesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fases',
      one: '1 fase',
    );
    return '$_temp0';
  }

  @override
  String get phasesDisclaimer =>
      'As semanas são contadas a partir da data de início do protocolo. Notas de fase salvas e lembretes de alteração são apenas auxílios de rastreamento.';

  @override
  String get preBlendedVial => 'Frasco pré-misturado';

  @override
  String get preBlendedVialBody => 'Um frasco · uma dose · vários compostos';

  @override
  String get protocolNotesBody =>
      'Salve o contexto que você quer ver ao revisar este protocolo.';

  @override
  String get protocolNotesHint =>
      'ex.: dúvidas, contexto de rastreamento ou notas do profissional de saúde';

  @override
  String get protocolNotesLabel => 'Observações do protocolo';

  @override
  String get reminderTimesBody =>
      'Cada horário selecionado cria sua própria linha de acompanhamento e lembrete nos dias programados.';

  @override
  String get reminderTimesLabel => 'HORÁRIOS DE LEMBRETE';

  @override
  String get removeLabel => 'REMOVER';

  @override
  String removePeptide(String name) {
    return 'Remover $name';
  }

  @override
  String get removePhase => 'Remover fase';

  @override
  String removeTime(String time) {
    return 'Remover horário $time';
  }

  @override
  String get restWeeksLabel => 'SEMANAS DE DESCANSO';

  @override
  String get reviewLabel => 'Revisão';

  @override
  String get routeLabel => 'VIA';

  @override
  String get saveBlend => 'SALVAR COMBINAÇÃO';

  @override
  String get saveChanges => 'SALVAR ALTERAÇÕES';

  @override
  String get savePhase => 'SALVAR FASE';

  @override
  String savedVialPreset(String amount, String unit) {
    return 'Frasco de $amount $unit · Ajuste salvo';
  }

  @override
  String get scheduleLabel => 'CRONOGRAMA';

  @override
  String get searchCompounds => 'Buscar compostos...';

  @override
  String get selectDayError =>
      'Selecione pelo menos um dia para programar este peptídeo.';

  @override
  String selectOption(String option) {
    return 'Selecionar $option';
  }

  @override
  String get startDateLabel => 'DATA DE INÍCIO';

  @override
  String get startWeekLabel => 'SEMANA INICIAL';

  @override
  String syringeUnitsAmount(String amount) {
    return '$amount unidades de seringa';
  }

  @override
  String get syringeUnitsDisclaimer =>
      'Marcações opcionais de seringa U-100 inseridas pelo usuário apenas para acompanhamento.';

  @override
  String get syringeUnitsHint => 'ex.: 12,5';

  @override
  String get syringeUnitsLabel => 'unidades de seringa';

  @override
  String get syringeUnitsOptional => 'UNIDADES DE SERINGA OPCIONAIS';

  @override
  String get trackedAmountLabel => 'QUANTIDADE ACOMPANHADA';

  @override
  String get u100TrackingDisclaimer =>
      'Usa as marcações da seringa U-100 (100 unidades = 1 ml). Os valores são dados de acompanhamento inseridos pelo usuário.';

  @override
  String get unitLabel => 'UNIDADE';

  @override
  String get vialAmountHint => 'Quantidade no frasco';

  @override
  String get vialContentsLabel => 'CONTEÚDO DO FRASCO';

  @override
  String get vialLabelNameHint => 'Nome indicado no rótulo do frasco';

  @override
  String weekNumber(int week) {
    return 'SEMANA $week';
  }

  @override
  String weekRange(int start, int end) {
    return 'SEMANAS $start–$end';
  }

  @override
  String get weekToWeekPhases => 'FASES SEMANA A SEMANA';

  @override
  String weekdayDose(String weekday) {
    return 'DOSE DE $weekday';
  }

  @override
  String weekdaySchedule(String weekday) {
    return 'AGENDA DE $weekday';
  }

  @override
  String get doseDrawInvalid =>
      'A puxada deve ser maior que zero e dentro da capacidade do frasco.';

  @override
  String get doseGenericError => 'Algo deu errado. Tente novamente.';

  @override
  String get doseEditSystemLabel => 'EDITAR.DOSE';

  @override
  String get doseLogSystemLabel => 'LOG.DOSE';

  @override
  String get doseDraw => 'PUXADA';

  @override
  String get doseAmount => 'QUANTIDADE';

  @override
  String get doseUnits => 'unidades';

  @override
  String get doseTime => 'HORÁRIO';

  @override
  String get doseChooseTime => 'Escolher horário da dose';

  @override
  String get doseBlendSnapshot => 'RETRATO DA COMBINAÇÃO // POR DOSE';

  @override
  String doseSyringeUnitsRecorded(String amount) {
    return '$amount unidades de seringa registradas para esta dose.';
  }

  @override
  String get doseInjectionSite => 'LOCAL.INJEÇÃO';

  @override
  String doseLastSite(String site) {
    return 'ÚLTIMO LOCAL PARA ESTE PEPTÍDEO · $site';
  }

  @override
  String get doseNotes => 'NOTAS';

  @override
  String get doseOptional => 'Opcional...';

  @override
  String get doseMarkPending => 'MARCAR COMO PENDENTE';

  @override
  String get doseSaveChanges => 'SALVAR ALTERAÇÕES';

  @override
  String get doseSkip => 'Pular esta dose';

  @override
  String get doseHistorySystemLabel => 'HISTÓRICO.DOSE // 30.DIAS';

  @override
  String get doseHistoryTitle => 'Doses registradas';

  @override
  String get doseHistoryBody =>
      'Toque em um registro para corrigir a quantidade, o horário real, o local de injeção, as observações ou o status.';

  @override
  String get doseHistoryEmpty => 'Nenhuma dose registrada nos últimos 30 dias.';

  @override
  String get doseLogPrevious => 'REGISTRAR DOSE ANTERIOR';

  @override
  String doseHistorySkipped(String dateTime) {
    return 'Pulada · $dateTime';
  }

  @override
  String doseHistoryTaken(String amount, String units, String dateTime) {
    return '$amount $units · $dateTime';
  }

  @override
  String get doseEditAction => 'EDITAR';

  @override
  String get doseChoosePastTime => 'Escolha um horário passado para registrar.';

  @override
  String get dosePreviousError =>
      'Não foi possível registrar a dose anterior. Tente novamente.';

  @override
  String get doseLogPreviousSystemLabel => 'LOG.ANTERIOR';

  @override
  String get doseNoPeptides => 'Nenhum peptídeo disponível';

  @override
  String get doseNoPeptidesBody =>
      'Adicione um peptídeo a um protocolo ativo antes de registrar o histórico.';

  @override
  String get doseCorrectHistory => 'Corrigir histórico de doses';

  @override
  String get dosePeptide => 'PEPTÍDEO';

  @override
  String get doseDate => 'DATA';

  @override
  String get doseChooseDate => 'Escolha a data da dose';

  @override
  String doseSyringeUnitsEntry(String amount) {
    return '$amount unidades de seringa registradas para este item.';
  }

  @override
  String get doseHistoryDisclaimer =>
      'Os registros históricos são apenas anotações pessoais de acompanhamento. Eles não alteram orientações médicas nem recomendações de dosagem.';

  @override
  String get notificationChannelName => 'Lembretes de dose';

  @override
  String get notificationChannelDescription =>
      'Lembretes agendados para as doses do seu protocolo de peptídeos ativo.';

  @override
  String get notificationDoseTitle => 'Hora da sua dose';

  @override
  String get notificationDoseBody =>
      'Seu lembrete programado de protocolo está pronto.';

  @override
  String get notificationCycleTitle => 'Checkpoint do protocolo';

  @override
  String get notificationCycleBody =>
      'Um lembrete de janela de ciclo vence hoje. Revise seu plano de acompanhamento.';

  @override
  String get notificationRestTitle =>
      'Ponto de checagem do período de descanso';

  @override
  String get notificationRestBody =>
      'Há um lembrete de período de descanso hoje. Revise seu plano de acompanhamento.';

  @override
  String get notificationPhaseTitle => 'Checkpoint de fase do protocolo';

  @override
  String get notificationPhaseBody =>
      'Uma nova fase de acompanhamento começa hoje. Revise seu cronograma salvo.';

  @override
  String get personalLibrarySystemLabel => 'SYS.BIBLIOTECA // PESSOAL';

  @override
  String get customCompoundIntro =>
      'Salve rótulos e tamanhos de frasco que você mesmo inserir. Os ajustes são atalhos de registro — não orientação de dose.';

  @override
  String get archivedHeading => 'ARQUIVADOS';

  @override
  String get activePresetsHeading => 'AJUSTES ATIVOS';

  @override
  String get showActive => 'Mostrar ativos';

  @override
  String get archivedAction => 'Arquivado';

  @override
  String get customCompoundsLoadFailed =>
      'Não foi possível carregar seus compostos. Tente novamente.';

  @override
  String get libraryLoadFailed =>
      'Não foi possível carregar a biblioteca de peptídeos. Tente novamente.';

  @override
  String compoundVialSummary(String amount, String unit, String route) {
    return 'Frasco $amount $unit · $route';
  }

  @override
  String get editPreset => 'Editar ajuste';

  @override
  String get restorePreset => 'Restaurar';

  @override
  String get archivePreset => 'Arquivar';

  @override
  String get noArchivedPresets => 'Nenhum ajuste arquivado';

  @override
  String get noSavedCompounds => 'Nenhum composto salvo';

  @override
  String get archivedPresetsHint =>
      'Os ajustes arquivados ficam aqui até você restaurá-los.';

  @override
  String get createPresetHint =>
      'Crie um ajuste reutilizável de nome e tamanho de frasco.';

  @override
  String get presetCompoundSystemLabel => 'AJUSTE.COMPOSTO';

  @override
  String get newCompound => 'Novo composto';

  @override
  String get editCompound => 'Editar composto';

  @override
  String get ownVialDetailsHint =>
      'Insira apenas os detalhes indicados no seu próprio frasco.';

  @override
  String get compoundLabel => 'ETIQUETA DO COMPOSTO';

  @override
  String get compoundNameExample => 'ex.: Meu composto';

  @override
  String get vialUnitLabel => 'UNIDADE DO FRASCO';

  @override
  String get trackingUnitLabel => 'UNIDADE DE ACOMPANHAMENTO';

  @override
  String get notesOptional => 'OBSERVAÇÕES OPCIONAIS';

  @override
  String get compoundNoteExample => 'Rótulo ou observação de armazenamento';

  @override
  String get noDoseRecommendation =>
      'Nenhuma recomendação de dose é criada. As quantidades do protocolo são sempre inseridas separadamente por você.';

  @override
  String get saveCompoundFailed =>
      'Não foi possível salvar o ajuste. Tente novamente.';

  @override
  String get routeTopical => 'Tópica';

  @override
  String get frequencyCustomDays => 'Dias personalizados';

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
    return 'U-100 · $volume mL / $capacity unidade';
  }
}
