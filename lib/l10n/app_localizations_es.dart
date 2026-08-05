// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get libraryTitle => 'Biblioteca';

  @override
  String get librarySystemLabel => 'SYS.BASEDATOS // COMPUESTOS';

  @override
  String get myCompounds => 'Mis compuestos';

  @override
  String get unitConverter => 'Conversor de unidades';

  @override
  String get openUnitConverter => 'Abrir conversor de unidades';

  @override
  String get converterCardTitle => 'CONVERSOR DE UNIDADES';

  @override
  String get converterCardSubtitle => 'Convierte ahora los cálculos del vial';

  @override
  String get converterCardHint =>
      'Para la reconstitución, toca un péptido abajo.';

  @override
  String get searchPeptides => 'Buscar péptidos...';

  @override
  String get categoryAll => 'Todos';

  @override
  String get categoryHealing => 'Recuperación';

  @override
  String get categoryGrowthHormone => 'Hormona de crecimiento';

  @override
  String get categoryCognitive => 'Cognitivo';

  @override
  String get categoryMetabolic => 'Metabólico';

  @override
  String get categoryAesthetic => 'Estética';

  @override
  String get categoryLongevity => 'Longevidad';

  @override
  String get categoryOther => 'Otros';

  @override
  String get libraryUnavailable => 'Biblioteca no disponible';

  @override
  String get retry => 'REINTENTAR';

  @override
  String get noPeptidesFound => 'No se encontraron péptidos';

  @override
  String get tryDifferentSearch =>
      'Prueba otro término de búsqueda o quita el filtro.';

  @override
  String get calculationSaved => 'Cálculo guardado en esta cuenta.';

  @override
  String get converterIntro =>
      'Introduce los valores de tu propio vial, diluyente y plan. PepMod convierte esos valores en volumen y unidades de jeringa U-100.';

  @override
  String get vialAndDiluent => 'Vial + diluyente';

  @override
  String get iuSourceCaption =>
      'Fuente: UI del vial y ml de diluyente añadidos.';

  @override
  String get massSourceCaption => 'Fuente: etiquetas del vial y del diluyente.';

  @override
  String get vialAmount => 'CANTIDAD DEL VIAL';

  @override
  String get amountPrintedOnVial => 'Cantidad indicada en el vial';

  @override
  String get diluent => 'DILUYENTE';

  @override
  String get volumeAdded => 'Volumen que añadiste';

  @override
  String get amountToConvert => 'Cantidad que convertir';

  @override
  String get iuAmountCaption =>
      'Introduce una cantidad en UI que ya te hayan indicado.';

  @override
  String get massAmountCaption =>
      'Fuente: una cantidad que ya te hayan indicado.';

  @override
  String get yourSyringe => 'Tu jeringa';

  @override
  String get syringeCaption =>
      'Selecciona la capacidad indicada en el cilindro.';

  @override
  String get educationalConverterDisclaimer =>
      'Herramienta educativa solo para convertir unidades. PepMod no recomienda una cantidad ni una frecuencia. Revisa las etiquetas originales y confirma el cálculo con un profesional sanitario cualificado antes de usarlo.';

  @override
  String get back => 'Atrás';

  @override
  String get vialWorkspace => 'Calculadora de vial';

  @override
  String get conversionSystemLabel => 'UTIL.CONVERSIÓN';

  @override
  String get measurementModeSystemLabel => 'MODO.MEDICIÓN';

  @override
  String get conversionResultSystemLabel => 'RESULTADO.CONVERSIÓN';

  @override
  String get savedVialsSystemLabel => 'VIALES.GUARDADOS';

  @override
  String get clear => 'BORRAR';

  @override
  String get conversionOnly =>
      'Solo conversión: este espacio de trabajo nunca elige una cantidad ni un horario.';

  @override
  String get sameUnitFamily =>
      'Usa el mismo tipo de unidad que aparece en el vial.';

  @override
  String get mass => 'Masa';

  @override
  String get iuOnly => 'Solo UI';

  @override
  String get iuSafety =>
      'Las UI se mantienen como UI. PepMod no convierte UI a mg/mcg ni al contrario.';

  @override
  String get enterAmount => 'Introduce la cantidad';

  @override
  String get drawTo => 'CARGAR HASTA';

  @override
  String get units => 'unidades';

  @override
  String get concentration => 'CONCENTRACIÓN';

  @override
  String get syringeCapacity => 'CAPACIDAD DE LA JERINGA';

  @override
  String get capacityWarning =>
      'El volumen convertido supera la capacidad de esta jeringa. Elige la jeringa correcta o revisa los datos introducidos.';

  @override
  String get savePreset => 'GUARDAR AJUSTE';

  @override
  String get savedVialsHint =>
      'Toca un cálculo guardado para reutilizar sus datos.';

  @override
  String get removeSavedCalculation => 'Eliminar cálculo guardado';

  @override
  String get errorPositiveNumbers =>
      'Introduce un número mayor que cero en cada campo.';

  @override
  String get errorAmountAboveVial =>
      'La cantidad deseada supera la cantidad introducida para este vial.';

  @override
  String get errorConversion =>
      'No se pudieron convertir estos valores. Revisa cada dato.';

  @override
  String get halfLife => 'Semivida';

  @override
  String get weekCycle => 'sem de ciclo';

  @override
  String get typicalDose => 'DOSIS TÍPICA';

  @override
  String get notes => 'NOTAS';

  @override
  String get commonStack => 'COMBINACIÓN HABITUAL';

  @override
  String get reconstitutionTool => 'UTIL.RECONSTITUCIÓN';

  @override
  String get compoundSystemLabel => 'DB.COMPUESTO';

  @override
  String get addToProtocol => 'AÑADIR AL PROTOCOLO';

  @override
  String get vialShort => 'VIAL (mg)';

  @override
  String get bacShort => 'BAC (ml)';

  @override
  String get doseShort => 'DOSIS (mcg)';

  @override
  String get routeSubcutaneous => 'Subcutánea';

  @override
  String get routeIntramuscular => 'Intramuscular';

  @override
  String get routeOral => 'Oral';

  @override
  String get routeNasal => 'Nasal';

  @override
  String get frequencyDaily => 'A diario';

  @override
  String get frequencyEveryOtherDay => 'Días alternos';

  @override
  String get frequencyTwiceWeekly => '2 veces por semana';

  @override
  String get frequencyWeekly => 'Semanal';

  @override
  String get frequencyAsNeeded => 'Según sea necesario';

  @override
  String get tabProtocol => 'Protocolo';

  @override
  String get tabProgress => 'Progreso';

  @override
  String get tabLibrary => 'Biblioteca';

  @override
  String get tabYou => 'Tú';

  @override
  String get continueLabel => 'CONTINUAR';

  @override
  String get processingLabel => 'PROCESANDO…';

  @override
  String get authAppleFailed =>
      'No se pudo iniciar sesión con Apple. Inténtalo de nuevo.';

  @override
  String get authGoogleFailed =>
      'No se pudo iniciar sesión con Google. Inténtalo de nuevo.';

  @override
  String get authGenericError => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get authUserNotFound =>
      'No se encontró ningún usuario con esa dirección de correo electrónico.';

  @override
  String get authIncorrectCredentials =>
      'Correo electrónico o contraseña incorrectos.';

  @override
  String get authAccountExists => 'Ya existe una cuenta con este correo.';

  @override
  String get authWeakPassword =>
      'La contraseña es demasiado débil. Usa al menos 6 caracteres.';

  @override
  String get authInvalidEmail => 'Dirección de correo electrónico no válida.';

  @override
  String get authAppleUnavailable =>
      'Iniciar sesión con Apple no está habilitado para esta app.';

  @override
  String get authRequiredTitle => 'Guarda tu protocolo\npersonalizado';

  @override
  String get authRequiredBody =>
      'Vincula tu hoja de ruta, horario, registro de dosis y recordatorios a tu cuenta antes de desbloquear el protocolo.';

  @override
  String get continueWithEmail => 'CONTINUAR CON CORREO ELECTRÓNICO';

  @override
  String get signInWithApple => 'INICIAR SESIÓN CON APPLE';

  @override
  String get continueWithGoogle => 'CONTINUAR CON GOOGLE';

  @override
  String get authTermsDisclaimer =>
      'Al continuar, aceptas nuestros Términos y nuestra Política de Privacidad. PepMod es una herramienta educativa, no un consejo médico.';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get resetPassword => 'Restablecer contraseña';

  @override
  String get signInAction => 'INICIAR SESIÓN';

  @override
  String get createAccountAction => 'CREAR CUENTA';

  @override
  String get sendResetLink => 'ENVIAR ENLACE';

  @override
  String get passwordResetSent =>
      'Correo de restablecimiento enviado. Revisa tu bandeja de entrada.';

  @override
  String get enterEmail => 'Introduce tu correo electrónico';

  @override
  String get enterValidEmail => 'Introduce un correo electrónico válido';

  @override
  String get enterPassword => 'Introduce una contraseña';

  @override
  String get passwordMinLength => 'Al menos 6 caracteres';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get backToSignIn => 'Volver al inicio de sesión';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get showPassword => 'Mostrar contraseña';

  @override
  String get hidePassword => 'Ocultar contraseña';

  @override
  String get accountDeletedTitle => 'Cuenta eliminada';

  @override
  String get accountDeletedBody =>
      'Tu cuenta de PepMod y los datos guardados de la app se han eliminado.';

  @override
  String get subscriptionUnavailable =>
      'Los planes de suscripción no están disponibles en este momento. Inténtalo de nuevo.';

  @override
  String get upgradeUnavailable =>
      'La mejora no está disponible en este momento. Inténtalo más tarde.';

  @override
  String get noPurchasesToRestore => 'No se encontraron compras que restaurar.';

  @override
  String get subscriptionErrorServiceUnavailable =>
      'Las compras no están disponibles temporalmente. Inténtalo de nuevo en unos minutos.';

  @override
  String get subscriptionErrorPlansUnavailable =>
      'No se pudieron cargar los planes de suscripción. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get subscriptionErrorPurchaseCancelled => 'Compra cancelada.';

  @override
  String get subscriptionErrorPurchaseNotAllowed =>
      'Las compras no están permitidas en este dispositivo.';

  @override
  String get subscriptionErrorPurchaseInvalid =>
      'No se pudo completar la compra. Comprueba tu cuenta e inténtalo de nuevo.';

  @override
  String get subscriptionErrorProductUnavailable =>
      'Esta suscripción no está disponible en este momento. Elige otro plan o inténtalo de nuevo más tarde.';

  @override
  String get subscriptionErrorNetwork =>
      'Estás sin conexión. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get subscriptionErrorPurchaseFailed =>
      'La compra falló. Inténtalo de nuevo.';

  @override
  String get subscriptionErrorRestoreFailed =>
      'No se pudieron restaurar las compras. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get unlockFullProtocol => 'Desbloquea el protocolo completo';

  @override
  String get premiumUnlimitedPeptides => 'Péptidos ilimitados por protocolo';

  @override
  String get premiumMultipleProtocols => 'Varios protocolos activos';

  @override
  String get premiumCalculator =>
      'Calculadora de reconstitución (todos los péptidos)';

  @override
  String get premiumMetrics => 'Seguimiento de medidas corporales + gráficas';

  @override
  String get upgradeNow => 'MEJORA AHORA';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get notRightNow => 'Ahora no';

  @override
  String get protocolWeeklyPlanner => 'Planificador semanal';

  @override
  String get protocolDoseHistory => 'Historial de dosis';

  @override
  String get protocolCreate => 'Crear protocolo';

  @override
  String get protocolManage => 'GESTIONAR';

  @override
  String get protocolYourProtocol => 'Tu protocolo';

  @override
  String get protocolNoActive => 'Sin protocolo activo';

  @override
  String get protocolNoActiveBody =>
      'Crea tu primer protocolo para empezar a registrar dosis y consolidar el hábito.';

  @override
  String get protocolStartFirst => 'INICIAR PRIMER PROTOCOLO';

  @override
  String get protocolScheduleTodaySystemLabel => 'PROGRAMA // HOY';

  @override
  String get protocolAdherenceTodaySystemLabel => 'ADHERENCIA // HOY';

  @override
  String get protocolNoDosesScheduledToday => 'No hay dosis programadas hoy';

  @override
  String protocolDosesTaken(int taken, int total) {
    return '$taken de $total dosis tomadas';
  }

  @override
  String get protocolNextDose => 'PRÓXIMA DOSIS';

  @override
  String protocolInTime(String duration) {
    return 'En $duration';
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
  String get protocolLogDose => 'REGISTRAR DOSIS';

  @override
  String get protocolNow => 'ahora';

  @override
  String get protocolMissed => 'OMITIDA';

  @override
  String get protocolSkipped => 'OMITIDA';

  @override
  String get protocolNoDosesToday => 'Hoy no hay dosis';

  @override
  String get protocolNoDosesTodayBody =>
      'Tu protocolo no tiene dosis programadas para hoy.';

  @override
  String get protocolFreeLimit =>
      'El plan gratuito se limita a un protocolo. Mejora a Premium para gestionar varias combinaciones a la vez.';

  @override
  String protocolSyringeUnitsSuffix(String amount) {
    return ' · $amount unidades de jeringa';
  }

  @override
  String get injectionSiteLeftAbdomen => 'Abdomen izquierdo';

  @override
  String get injectionSiteRightAbdomen => 'Abdomen derecho';

  @override
  String get injectionSiteLeftThigh => 'Muslo izquierdo';

  @override
  String get injectionSiteRightThigh => 'Muslo derecho';

  @override
  String get injectionSiteLeftGlute => 'Glúteo izquierdo';

  @override
  String get injectionSiteRightGlute => 'Glúteo derecho';

  @override
  String get injectionSiteLeftTriceps => 'Tríceps izquierdo';

  @override
  String get injectionSiteRightTriceps => 'Tríceps derecho';

  @override
  String get injectionSiteLeftDeltoid => 'Deltoides izquierdo';

  @override
  String get injectionSiteRightDeltoid => 'Deltoides derecho';

  @override
  String get plannerToday => 'HOY';

  @override
  String get plannerBack => 'Atrás';

  @override
  String get plannerPreviousWeek => 'Semana anterior';

  @override
  String get plannerNextWeek => 'Próxima semana';

  @override
  String plannerScheduledCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dosis programadas',
      one: '$count dosis programada',
    );
    return '$_temp0';
  }

  @override
  String get plannerTrackingDisclaimer =>
      'Solo seguimiento. Este calendario refleja tu protocolo guardado y no ofrece consejos de dosificación.';

  @override
  String get plannerWashoutPeriod => 'Periodo de descanso';

  @override
  String plannerWashoutUntil(String date) {
    return 'Periodo de descanso hasta $date';
  }

  @override
  String get plannerNoScheduledDoses => 'No hay dosis programadas';

  @override
  String get plannerNothingPlanned =>
      'No hay nada planificado a partir de tus protocolos guardados.';

  @override
  String get activatePro => 'ACTIVAR PRO';

  @override
  String activateProPrice(String price) {
    return 'ACTIVAR PRO — $price/año';
  }

  @override
  String get annualAccess => 'Acceso anual';

  @override
  String get annualLabel => 'Anual';

  @override
  String get averageRating => 'VALORACIÓN MEDIA';

  @override
  String get bacWaterLabel => 'AGUA BAC';

  @override
  String get basedOnInputs => 'Según tus datos //';

  @override
  String get bestValue => 'Mejor oferta';

  @override
  String get birthDateInvalid =>
      'Introduce una fecha válida para una persona de 18 años o más.';

  @override
  String get birthDateValid => 'Edad verificada';

  @override
  String calculatorDemoBody(String peptideName) {
    return 'Así funciona con $peptideName';
  }

  @override
  String get calculatorDemoResult =>
      'Así de simple. Introduce tus valores\ny obtén las unidades exactas de jeringa.';

  @override
  String get calculatorDemoTitle => 'Se acabaron\nlos cálculos complicados.';

  @override
  String get confidenceCycleTiming => 'Momento del ciclo';

  @override
  String get confidenceCycleTimingDetail =>
      'Consulta con claridad las fechas del protocolo y las ventanas del horario';

  @override
  String get confidenceDoseMath => 'Cálculo de dosis';

  @override
  String get confidenceDoseMathDetail =>
      'Mantén juntos el vial, el agua, la dosis y las unidades de carga';

  @override
  String get confidenceLabel => 'CONFIANZA';

  @override
  String get confidencePlainInfo => 'Información en lenguaje sencillo';

  @override
  String get confidencePlainInfoDetail =>
      'Lee notas de investigación sin distracciones';

  @override
  String get confidenceProgressSignals => 'Señales de progreso';

  @override
  String get confidenceProgressSignalsDetail =>
      'Consulta la adherencia y las métricas corporales a lo largo del tiempo';

  @override
  String get confidenceSafetyFraming => 'Enfoque de seguridad';

  @override
  String get confidenceSafetyFramingDetail =>
      'Mantén visibles las indicaciones educativas y los avisos';

  @override
  String get confidenceSiteRotation => 'Rotación de puntos';

  @override
  String get confidenceSiteRotationDetail =>
      'Recuerda dónde se registró cada dosis';

  @override
  String get connectingToStore => 'CONECTANDO CON LA TIENDA...';

  @override
  String continueSelected(int count) {
    return 'CONTINUAR ($count)';
  }

  @override
  String get customProtocol => 'Protocolo personalizado';

  @override
  String get dateOfBirthLabel => 'FECHA DE NACIMIENTO';

  @override
  String get dayOne => 'DÍA 1';

  @override
  String get dayShortLabel => 'DD';

  @override
  String get defaultConfidence => 'Cálculo de dosis · Rotación de puntos';

  @override
  String get defaultFrustration => 'Dosis olvidadas';

  @override
  String get defaultGoals => 'Recuperación · Longevidad';

  @override
  String get doseLabel => 'DOSIS';

  @override
  String get dosesLogged => 'DOSIS REGISTRADAS';

  @override
  String get dosesPerDay => 'DOSIS/DÍA';

  @override
  String get drawVolumeLabel => 'VOLUMEN A CARGAR';

  @override
  String get durationLabel => 'DURACIÓN';

  @override
  String get experienceAdvanced => 'Avanzado';

  @override
  String get experienceAdvancedDetail =>
      'Me siento cómodo gestionando protocolos detallados';

  @override
  String get experienceFirstTime => 'Primera vez';

  @override
  String get experienceFirstTimeDetail =>
      'Soy nuevo en el seguimiento de péptidos';

  @override
  String get experienceIntermediate => 'INTERMEDIO';

  @override
  String get experienceLabel => 'EXPERIENCIA';

  @override
  String get experienceNovice => 'PRINCIPIANTE';

  @override
  String get experienceSome => 'Algo de experiencia';

  @override
  String get experienceSomeDetail => 'He seguido uno o dos protocolos';

  @override
  String get experienceVeteran => 'VETERANO';

  @override
  String get featureDoseMathBody =>
      'Mantén el tamaño del vial, el volumen de agua, la dosis y las unidades que cargar junto al protocolo que realmente sigues.';

  @override
  String get featureDoseMathTitle => 'Cálculo de dosis\nen contexto';

  @override
  String get featureProtocolArcBody =>
      'Consulta dosis planificadas, dosis registradas, adherencia y métricas corporales reunidas en una sola línea de tiempo.';

  @override
  String get featureProtocolArcTitle => 'Evolución del\nprotocolo';

  @override
  String get featureShowcaseTitle => 'Todo lo que necesitas.\nUna sola app.';

  @override
  String get featureSiteRotationBody =>
      'Recuerda cada zona que registras y mantén el historial de rotación junto al registro de dosis.';

  @override
  String get featureSiteRotationTitle => 'Rotación de\nPuntos de Inyección';

  @override
  String get firstNameExample => 'p. ej. Alex';

  @override
  String get firstNameLabel => 'NOMBRE';

  @override
  String get frustrationForgetting => 'Olvidar dosis';

  @override
  String get frustrationLabel => 'FRUSTRACIÓN';

  @override
  String get frustrationMath => 'Cálculos de vial y jeringa';

  @override
  String get frustrationProgress => 'Saber si estoy siendo constante';

  @override
  String get frustrationSchedule => 'Mantener el horario en orden';

  @override
  String get frustrationStacking => 'Gestionar varios péptidos';

  @override
  String get frustrationTrust => 'Encontrar información fiable';

  @override
  String get goalAntiAging => 'Envejecimiento saludable';

  @override
  String get goalAntiAgingDetail =>
      'Organiza registros centrados en la longevidad';

  @override
  String get goalCognitive => 'Apoyo cognitivo';

  @override
  String get goalCognitiveDetail =>
      'Controla el enfoque y el rendimiento mental';

  @override
  String get goalImmune => 'Apoyo inmunitario';

  @override
  String get goalImmuneDetail =>
      'Mantén organizados los protocolos centrados en el sistema inmunitario';

  @override
  String get goalMuscleGrowth => 'Crecimiento muscular';

  @override
  String get goalMuscleGrowthDetail =>
      'Sigue tus objetivos de entrenamiento y crecimiento';

  @override
  String get goalOther => 'Otro';

  @override
  String get goalOtherDetail => 'Configura otro objetivo de seguimiento';

  @override
  String get goalRecovery => 'Recuperación';

  @override
  String get goalRecoveryDetail =>
      'Apoya tus registros y rutinas de recuperación';

  @override
  String get goalSleep => 'Sueño';

  @override
  String get goalSleepDetail =>
      'Haz seguimiento de objetivos y patrones relacionados con el sueño';

  @override
  String get goalWeightLoss => 'Pérdida de peso';

  @override
  String get goalWeightLossDetail =>
      'Sigue tus objetivos y progreso metabólico';

  @override
  String get goalsLabel => 'OBJETIVOS';

  @override
  String get iUnderstand => 'ENTENDIDO';

  @override
  String get lastThreeDaysAgo => 'Último: hace 3 días';

  @override
  String get leftAbdomen => 'Abdomen izquierdo';

  @override
  String get loveIt => 'ME ENCANTA';

  @override
  String get maybeLater => 'Quizá más tarde';

  @override
  String get monthOne => 'MES 1';

  @override
  String get monthShortLabel => 'MM';

  @override
  String get monthTwo => 'MES 2';

  @override
  String moreCount(String shown, int count) {
    return '$shown +$count más';
  }

  @override
  String get needsWork => 'POR MEJORAR';

  @override
  String get notificationBody =>
      'Recibe recordatorios discretos cuando llegue una ventana programada del protocolo. Sin nombres de péptidos en las notificaciones, solo un aviso suave.';

  @override
  String get notificationTitle => 'Ten siempre a la vista\nlas horas de dosis.';

  @override
  String get nowLabel => 'ahora';

  @override
  String get ok => 'OK';

  @override
  String get onboardingAgeConfirmed => 'TENGO 18 AÑOS O MÁS';

  @override
  String get onboardingAgeRequirementBody =>
      'Debes tener 18 años o más para usar PepMod.';

  @override
  String get onboardingAgeRequirementTitle => 'Requisito de edad';

  @override
  String get onboardingAgeVerificationBody =>
      'PepMod está pensada para adultos de 18 años o más.';

  @override
  String get onboardingAgeVerificationTitle => 'Primero, confirma\ntu edad.';

  @override
  String get onboardingAheadBody =>
      'Responde unas preguntas y PepMod organizará una vista previa de seguimiento personalizada.';

  @override
  String get onboardingAheadTitle => 'Ve tu protocolo\nantes de empezar.';

  @override
  String get onboardingBirthDateBody =>
      'Esto confirma que cumples el requisito de edad.';

  @override
  String get onboardingBirthDateTitle => '¿Cuándo\nnaciste?';

  @override
  String get onboardingConfidenceBody =>
      'Elige todo lo que quieres que PepMod te aclare.';

  @override
  String get onboardingConfidenceTitle => '¿Dónde quieres\nmás confianza?';

  @override
  String get onboardingConversionValueBody =>
      'Convierte los valores de tu vial y plan en volumen y unidades de jeringa.';

  @override
  String get onboardingConversionValueTitle =>
      'Comprueba los cálculos\ndel vial con más facilidad.';

  @override
  String get onboardingDisclaimerBody =>
      'PepMod ayuda a organizar registros, recordatorios y conversiones de unidades. No diagnostica, no prescribe ni sustituye el consejo de un profesional sanitario cualificado.';

  @override
  String get onboardingDisclaimerTitle =>
      'Pensado para dar claridad.\nNo para recetar.';

  @override
  String get onboardingExperienceTitle => '¿Cuánta experiencia\ntienes?';

  @override
  String get onboardingFrustrationBody => 'Elige el mayor punto de fricción.';

  @override
  String get onboardingFrustrationTitle => '¿Qué es lo que\nmás te cuesta hoy?';

  @override
  String get onboardingGoalsTitle => '¿Cuáles son tus\nprincipales objetivos?';

  @override
  String get onboardingGuidedStartBody =>
      'Adaptaremos la configuración a tus objetivos, tu experiencia y los registros que quieras llevar.';

  @override
  String get onboardingGuidedStartTitle =>
      'Un inicio guiado,\npensado para ti.';

  @override
  String get onboardingHookAnswer =>
      'PepMod guarda la respuesta junto a tu protocolo.';

  @override
  String get onboardingHookQuestion => '¿Cuántas unidades\ncargas?';

  @override
  String get onboardingHookResearch => 'BIBLIOTECA DE INVESTIGACIÓN';

  @override
  String get onboardingHookSources => 'Fuentes con referencias';

  @override
  String get onboardingHookVial => 'VIAL + DILUYENTE';

  @override
  String get onboardingNameBody =>
      'Lo usaremos para personalizar tu experiencia en PepMod.';

  @override
  String get onboardingNameTitle => '¿Cómo quieres que\nte llamemos?';

  @override
  String get onboardingPeptideSelectBody =>
      'Elige los péptidos que uses o que quieras seguir de cerca.';

  @override
  String get onboardingPeptideSelectTitle => '¿Qué estás\nsiguiendo?';

  @override
  String get onboardingProgressValueBody =>
      'Reúne adherencia, historial de dosis y métricas corporales en un solo registro claro.';

  @override
  String get onboardingProgressValueTitle =>
      'Consulta toda tu\nevolución en el tiempo.';

  @override
  String get onboardingProtocolValueBody =>
      'Planifica horarios, registra dosis y mantén los detalles junto a cada protocolo.';

  @override
  String get onboardingProtocolValueTitle =>
      'Ten cada protocolo\nen un solo lugar.';

  @override
  String get onboardingUnder18 => 'TENGO MENOS DE 18';

  @override
  String get openingPermission => 'ABRIENDO PERMISO...';

  @override
  String get paywallArcBody =>
      'Consulta qué se planificó, qué se registró y qué necesita un registro más claro a continuación.';

  @override
  String get paywallArcTitle => 'OBSERVA LA EVOLUCIÓN EN EL TIEMPO';

  @override
  String get paywallBody =>
      'Cálculo de dosis, rotación de zonas, recordatorios e historial de protocolos, todo en un solo registro.';

  @override
  String get paywallDoseMathBody =>
      'Mantén juntos el vial, el agua, la dosis y las unidades de carga para revisar cada registro con más facilidad.';

  @override
  String get paywallDoseMathTitle => 'ACIERTA CON LOS CÁLCULOS DE DOSIS';

  @override
  String get paywallPreviewDisclaimer =>
      'Diseñado para registros, recordatorios y claridad de unidades, no para consejo médico.';

  @override
  String get paywallRotationBody =>
      'Cada zona, ciclo y recordatorio queda vinculado al registro del protocolo.';

  @override
  String get paywallRotationTitle => 'NUNCA PIERDAS TU ROTACIÓN';

  @override
  String get paywallTitle => 'Todo para llevar bien\ntu protocolo.';

  @override
  String get paywallValueNote =>
      'Un cálculo de vial confuso puede hacerte perder tiempo y producto. PepMod mantiene los cálculos junto al registro para que puedas revisar tus datos antes de actuar según notas antiguas.';

  @override
  String get peptideLabel => 'PÉPTIDO';

  @override
  String get peptidesLabel => 'PÉPTIDOS';

  @override
  String get peptidesTracked => 'PÉPTIDOS\nSEGUIDOS';

  @override
  String get perWeek => '/semana';

  @override
  String get perYear => '/año';

  @override
  String get privacyLabel => 'Privacidad';

  @override
  String processingGoals(int count) {
    return 'ANALIZANDO $count OBJETIVOS...';
  }

  @override
  String processingPeptides(int count) {
    return 'VINCULANDO $count REGISTROS DE PÉPTIDOS...';
  }

  @override
  String get processingProtocol => 'CREANDO TU PROTOCOLO...';

  @override
  String get processingSchedule => 'ORGANIZANDO TU HORARIO...';

  @override
  String get processingTitle => 'Creando tu\nprotocolo';

  @override
  String get progressLabel => 'Progreso';

  @override
  String get protocolClarity => 'claridad del protocolo';

  @override
  String get protocolIncludes => 'TU PROTOCOLO INCLUYE //';

  @override
  String get protocolPreviewTitle => 'Tu protocolo\nestá listo.';

  @override
  String get protocolReady => 'PROTOCOLO LISTO //';

  @override
  String get protocolReminderReady =>
      'El recordatorio del protocolo está listo';

  @override
  String get protocolReservedFor =>
      'TU PROTOCOLO PERSONALIZADO ESTÁ RESERVADO PARA';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get resultsSummaryBody =>
      'Mantendremos juntos el registro de dosis, los cálculos de reconstitución y las tendencias a medida que se acumulen tus datos.';

  @override
  String get reviewGateBody =>
      'Tus comentarios nos ayudan a mejorar la plataforma para cada biohacker.';

  @override
  String get reviewGateTitle => '¿Qué tal te está\nyendo con PepMod?';

  @override
  String roadmapBody(int count, String need) {
    return 'Creado en torno a $count péptidos seguidos y tu necesidad de $need.';
  }

  @override
  String get roadmapDayOneBody =>
      'Péptidos, registro de dosis, rotación de zonas y recordatorios están listos.';

  @override
  String get roadmapDayOneTitle => 'Tu primer protocolo está organizado';

  @override
  String get roadmapDisclaimer =>
      'PepMod organiza tus registros y recordatorios. No prescribe, no diagnostica ni sustituye la orientación de un profesional sanitario.';

  @override
  String get roadmapMonthOneBody =>
      'La adherencia, las dosis olvidadas y las métricas corporales empiezan a formar un registro más claro.';

  @override
  String get roadmapMonthOneTitle => 'Tu historial de constancia toma forma';

  @override
  String get roadmapMonthTwoBody =>
      'Consulta qué planificaste, qué ocurrió y dónde tus registros necesitan atención.';

  @override
  String get roadmapMonthTwoTitle =>
      'Toda la evolución de tu protocolo, visible';

  @override
  String get roadmapTitle => 'Esto es lo que\nviene a continuación.';

  @override
  String get roadmapWeekOneBody =>
      'La información en lenguaje sencillo y las notas de seguimiento permanecen junto a tu plan.';

  @override
  String roadmapWeekOneTitle(String goal) {
    return 'Tu biblioteca se llena en torno a $goal';
  }

  @override
  String savePercent(int percent) {
    return 'AHORRA $percent%';
  }

  @override
  String get saveRoadmap => 'GUARDAR ESTA HOJA DE RUTA';

  @override
  String get schedulePreview => 'VISTA PREVIA DEL HORARIO';

  @override
  String get seeWhatsInside => 'VER QUÉ INCLUYE';

  @override
  String get selectAllThatApply => 'Selecciona todo lo que corresponda.';

  @override
  String get siteMap => 'Mapa de zonas';

  @override
  String get skipForNow => 'OMITIR POR AHORA';

  @override
  String get socialProofBody =>
      'Únete a miles de personas que hacen seguimiento de su progreso real.';

  @override
  String get socialProofTitle =>
      'Con la confianza de\nbiohackers de todo el mundo';

  @override
  String get specialOffer => 'OFERTA ESPECIAL';

  @override
  String get startFreeTrial => 'INICIAR PRUEBA GRATUITA';

  @override
  String get subscribeLabel => 'SUSCRIBIRSE';

  @override
  String subscribePrice(String price) {
    return 'SUSCRIBIRSE — $price/semana';
  }

  @override
  String get subscribeToActivate => 'Suscríbete para activar tu protocolo';

  @override
  String get subscriptionRenewalDisclaimer =>
      'La suscripción se renueva automáticamente salvo que se cancele al menos 24 horas antes del final del periodo actual. Gestiónala en Ajustes > ID de Apple > Suscripciones.';

  @override
  String syringeVolume(String volume) {
    return '${volume}ml en una jeringa de 1ml';
  }

  @override
  String get termsLabel => 'Términos';

  @override
  String get testimonialOne =>
      'Por fin dejé de olvidar dosis. Solo la calculadora de reconstitución ya me ahorró horas de cálculos en una hoja de cálculo.';

  @override
  String get testimonialThree =>
      'El rastreador de péptidos más claro que he usado. Parece hecho para usuarios serios, porque lo es.';

  @override
  String get testimonialTwo =>
      'Los informes semanales detectaron un problema de horario que no había notado en meses. Un antes y un después.';

  @override
  String get thirtyDayAdherence => 'Adherencia de 30 días';

  @override
  String get threeDayFreeTrial => 'PRUEBA GRATIS DE 3 DÍAS';

  @override
  String get timelineLabel => 'Cronología';

  @override
  String get trackedLabel => 'registrado';

  @override
  String get turnOnReminders => 'ACTIVAR RECORDATORIOS';

  @override
  String get unitConversionDisclaimer =>
      'Herramienta de conversión de unidades solo como referencia. Verifica siempre con tu profesional sanitario.';

  @override
  String get unitsLabel => 'Unidades';

  @override
  String get unitsToDraw => 'Unidades que cargar';

  @override
  String get unlockPepMod => 'DESBLOQUEAR PEPMOD';

  @override
  String get usersLabel => 'USUARIOS';

  @override
  String get viewLabel => 'VER';

  @override
  String get weekDuration => 'DURACIÓN\nEN SEMANAS';

  @override
  String get weekOne => 'SEMANA 1';

  @override
  String get weeklyLabel => 'Semanal';

  @override
  String weeksCount(int count) {
    return '$count semanas';
  }

  @override
  String get yearLabel => 'AÑO';

  @override
  String get profileTitle => 'Tú';

  @override
  String get signedIn => 'Sesión iniciada';

  @override
  String get sectionAccount => 'CUENTA';

  @override
  String get sectionPreferences => 'PREFERENCIAS';

  @override
  String get sectionData => 'DATOS';

  @override
  String get sectionSupport => 'SOPORTE';

  @override
  String get sectionLegal => 'LEGAL';

  @override
  String get sectionAbout => 'ACERCA DE';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get accountLabel => 'Cuenta';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get removeAccountData => 'Eliminar cuenta y datos';

  @override
  String get metricLabel => 'Métrica';

  @override
  String get imperialLabel => 'Imperial';

  @override
  String get notificationsLabel => 'Notificaciones';

  @override
  String get onLabel => 'Activado';

  @override
  String get offLabel => 'Desactivado';

  @override
  String get myCompoundsProfile => 'Mis compuestos';

  @override
  String get savedVialPresets => 'Ajustes de vial guardados';

  @override
  String get exportData => 'Exportar datos';

  @override
  String get copyAsJson => 'Copiar como JSON';

  @override
  String get clearAllData => 'Borrar todos los datos';

  @override
  String get clearingLabel => 'Borrando…';

  @override
  String get resetApp => 'Restablecer app';

  @override
  String get contactSupport => 'Contactar con soporte';

  @override
  String get chatWithUs => 'Chatea con nosotros';

  @override
  String get termsOfService => 'Términos del servicio';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get medicalDisclaimer => 'Aviso médico';

  @override
  String get disclaimerTitle => 'Aviso legal';

  @override
  String get versionLabel => 'Versión';

  @override
  String get signOutAction => 'CERRAR SESIÓN';

  @override
  String get educationalTrackingDisclaimer =>
      'Solo seguimiento educativo. No es un consejo médico.';

  @override
  String get yourName => 'Tu nombre';

  @override
  String get cancelLabel => 'Cancelar';

  @override
  String get saveLabel => 'Guardar';

  @override
  String get dataCopied => 'Datos copiados al portapapeles.';

  @override
  String get clearDataTitle => '¿Borrar todos los datos?';

  @override
  String get clearDataBody =>
      'Esto elimina todos los protocolos, registros de dosis y medidas corporales, y reinicia la introducción. Tu cuenta, suscripción y biblioteca de péptidos se conservan. Esta acción no se puede deshacer.';

  @override
  String get clearLabel => 'Borrar';

  @override
  String get clearingDataTitle => 'Borrando datos…';

  @override
  String get clearingDataBody =>
      'Mantén PepMod abierto mientras se eliminan tus datos de seguimiento.';

  @override
  String get clearDataFailed =>
      'No se pudieron borrar los datos. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get allDataCleared => 'Todos los datos se han borrado.';

  @override
  String get deleteAccountTitle => '¿Eliminar cuenta?';

  @override
  String get deleteAccountBody =>
      'Esto elimina de forma permanente tu cuenta de PepMod, ajustes, protocolos, registros de dosis y métricas corporales. Esta acción no se puede deshacer.';

  @override
  String get deletingAccount => 'Eliminando cuenta…';

  @override
  String get accountDeletionFailed =>
      'No se pudo eliminar la cuenta. Inténtalo de nuevo.';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get deleteLabel => 'Eliminar';

  @override
  String get signOutTitle => '¿Cerrar sesión?';

  @override
  String get signOutBody =>
      'Tus protocolos permanecen guardados y se sincronizan de nuevo cuando inicies sesión otra vez.';

  @override
  String get signOutLabel => 'Cerrar sesión';

  @override
  String get signOutFailed => 'No se pudo cerrar sesión. Inténtalo de nuevo.';

  @override
  String get notificationsDisabledSystem =>
      'Las notificaciones están desactivadas en los ajustes del sistema.';

  @override
  String get planPro => 'PRO';

  @override
  String get planFree => 'GRATIS';

  @override
  String get termsBody =>
      'PepMod se ofrece únicamente con fines educativos y de seguimiento. No es un dispositivo médico y no proporciona asesoramiento médico, diagnósticos, prescripciones ni recomendaciones de tratamiento. Al usar PepMod, eres responsable de tus propios registros, decisiones y de consultar con profesionales sanitarios cualificados.\n\nLas suscripciones se renuevan automáticamente a menos que se cancelen a través de App Store o Google Play antes del periodo de renovación. Los reembolsos los gestiona la tienda donde realizaste la compra.\n\nTérminos completos: https://appstorecopilot.com/legal/yzh32x5v/terms';

  @override
  String get privacyBody =>
      'PepMod utiliza Firebase para la autenticación y el almacenamiento de datos en la nube, RevenueCat para las suscripciones, AppRefer y Meta/Facebook App Events para la atribución, y Firebase/Crashlytics para análisis y diagnóstico. No vendemos tu información personal. Puedes eliminar tu cuenta y los datos guardados de la app desde dentro de la propia app.\n\nPolítica de privacidad completa: https://appstorecopilot.com/legal/yzh32x5v/privacy';

  @override
  String get medicalDisclaimerBody =>
      'PepMod es una herramienta de bienestar y seguimiento, NO un dispositivo médico. Nada en esta app constituye asesoramiento médico, diagnóstico, receta ni recomendación de tratamiento. Los péptidos descritos en la biblioteca tienen fines exclusivamente educativos. Consulta siempre a un profesional sanitario cualificado antes de empezar, cambiar o interrumpir cualquier régimen. Si experimentas algún efecto adverso, busca atención médica de inmediato.';

  @override
  String get profileSystemLabel => 'SYS.USUARIO // PERFIL';

  @override
  String get legalSystemLabel => 'SYS.LEGAL';

  @override
  String get progressTitle => 'Progreso';

  @override
  String get progressSystemLabel => 'SYS.PROGRESO // BIOMÉTRICOS';

  @override
  String get doseHistoryTooltip => 'Abrir historial de dosis';

  @override
  String get logMeasurementTooltip => 'Registrar medida';

  @override
  String get thirtyDayLabel => '30 DÍAS';

  @override
  String get adherenceLabel => 'adherencia';

  @override
  String get streakLabel => 'RACHA';

  @override
  String get daysLabel => 'días';

  @override
  String get totalLabel => 'TOTAL';

  @override
  String get dosesLabel => 'dosis';

  @override
  String get protocolHistoryLabel => 'PROTOCOLO.HISTORIAL';

  @override
  String get noProtocolsYet =>
      'Aún no hay protocolos. Crea uno desde la pestaña Protocolo.';

  @override
  String get adherenceChartLabel => 'ADHERENCIA // 30.DÍAS';

  @override
  String get thirtyDaysAgo => 'hace 30d';

  @override
  String get todayLabel => 'hoy';

  @override
  String get noWeightData => 'Sin datos de peso';

  @override
  String get logFirstMeasurement =>
      'Registra tu primera medida para ver tendencias aquí.';

  @override
  String get logMeasurementAction => 'REGISTRAR MEDIDA';

  @override
  String get weightTrendLabel => 'PESO // TENDENCIA';

  @override
  String weightKgValue(String weight) {
    return '$weight kg';
  }

  @override
  String get statusActive => 'ACTIVO';

  @override
  String get statusPaused => 'PAUSADO';

  @override
  String get statusEnded => 'FINALIZADO';

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
  String get enterOneMetric => 'Introduce al menos un valor.';

  @override
  String get saveMetricFailed => 'No se pudo guardar. Inténtalo de nuevo.';

  @override
  String get newMeasurement => 'Nueva medición';

  @override
  String get weightLabel => 'PESO';

  @override
  String get bodyFatLabel => 'GRASA CORPORAL';

  @override
  String get measurementsCmLabel => 'MEDIDAS (cm)';

  @override
  String get waistLabel => 'CINTURA';

  @override
  String get chestLabel => 'PECHO';

  @override
  String get armLabel => 'BRAZO';

  @override
  String get saveAction => 'GUARDAR';

  @override
  String get logMetricSystemLabel => 'LOG.MÉTRICA';

  @override
  String get activeLastSevenDays => 'ÚLTIMOS 7 DÍAS';

  @override
  String get activeAllTime => 'TOTAL HISTÓRICO';

  @override
  String get activeAdherence => 'adherencia';

  @override
  String get activeStarted => 'INICIADO';

  @override
  String get activeEnded => 'FINALIZADO';

  @override
  String activeStackCount(int count) {
    return 'COMBINACIÓN ($count)';
  }

  @override
  String get activeEditProtocol => 'EDITAR PROTOCOLO';

  @override
  String get activePauseProtocol => 'PAUSAR PROTOCOLO';

  @override
  String get activeEndProtocol => 'FINALIZAR PROTOCOLO';

  @override
  String get activeResumeProtocol => 'REANUDAR PROTOCOLO';

  @override
  String get activeDeleteProtocol => 'ELIMINAR PROTOCOLO';

  @override
  String get activeTrackingDisclaimer =>
      'Solo seguimiento educativo. Consulta a un profesional sanitario cualificado antes de hacer cambios.';

  @override
  String get activeEndQuestion => '¿Finalizar protocolo?';

  @override
  String get activeEndBody =>
      'Se eliminarán las dosis futuras. Los registros pasados permanecen en tu historial. Esta acción no se puede deshacer.';

  @override
  String get activeEndAction => 'FINALIZAR';

  @override
  String get activeDeleteQuestion => '¿Eliminar protocolo?';

  @override
  String get activeDeleteBody =>
      'Esto elimina de forma permanente el protocolo y todos sus registros de dosis. Esta acción no se puede deshacer.';

  @override
  String get activeDeleteAction => 'ELIMINAR';

  @override
  String get cancel => 'Cancelar';

  @override
  String get activeStatusActive => 'ACTIVO';

  @override
  String get activeStatusPaused => 'PAUSADO';

  @override
  String get activeStatusEnded => 'FINALIZADO';

  @override
  String get activeNotesLabel => 'NOTAS // PROTOCOLO';

  @override
  String get activeChangeReminders => 'CAMBIAR RECORDATORIOS';

  @override
  String get activeChangeRemindersBody =>
      'Cuando las notificaciones están activadas, PepMod programa un aviso local a las 09:00 para cada cambio de fase próximo.';

  @override
  String activePhaseAnchor(String date) {
    return 'Los rangos semanales se calculan a partir de $date.';
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
  String get activePerDayAmounts => 'Cantidades por día';

  @override
  String get activeBaseAmount => 'Cantidad base';

  @override
  String get activeCurrent => 'ACTUAL';

  @override
  String get activeBaseSchedule => 'Horario base';

  @override
  String get activeCustomDays => 'Días personalizados';

  @override
  String get activeContinuousTracking => 'Seguimiento continuo';

  @override
  String get activeNoFixedCycle => 'Sin ventana de ciclo fija';

  @override
  String activeCycleProgress(int week, int total) {
    return 'Semana $week de $total';
  }

  @override
  String activeCycleEnds(String date) {
    return 'El ciclo termina el $date';
  }

  @override
  String activeRestProgress(int week, int total) {
    return 'Semana de descanso $week de $total';
  }

  @override
  String activeRestEnds(String date) {
    return 'La ventana de descanso termina el $date';
  }

  @override
  String get activeCycleComplete => 'Ciclo completado';

  @override
  String activeCompletedDate(String date) {
    return 'Completado el $date';
  }

  @override
  String activeRestEnded(String date) {
    return 'La ventana de descanso terminó el $date';
  }

  @override
  String get activeNoHistory => 'Aún no hay protocolos pausados o finalizados.';

  @override
  String activeCompoundsCount(int count) {
    return '$count compuestos';
  }

  @override
  String activeSyringeUnits(String amount) {
    return '$amount unidades de jeringa';
  }

  @override
  String activeCycleWeeks(int count) {
    return 'Ciclo de $count sem';
  }

  @override
  String activeRestWeeks(int count) {
    return '${count}sem de descanso';
  }

  @override
  String get activePerDraw => 'POR CARGA';

  @override
  String activeVialSummary(String volume) {
    return 'Vial de $volume ml · U-100';
  }

  @override
  String get addCompound => 'AÑADIR COMPUESTO';

  @override
  String get addPhase => 'AÑADIR FASE';

  @override
  String get addTime => 'Añadir hora';

  @override
  String get addToStack => 'AÑADIR A LA COMBINACIÓN';

  @override
  String get amountRequired => 'Cantidad obligatoria';

  @override
  String get baseAmount => 'Cantidad base';

  @override
  String get baseSchedule => 'horario base';

  @override
  String get blendConfigBody =>
      'Introduce exactamente lo que está indicado en el vial. PepMod convierte la carga en un resumen por compuesto.';

  @override
  String get blendIncompleteError =>
      'Completa al menos dos compuestos, el volumen de diluyente y la carga.';

  @override
  String get blendNameHint => 'p. ej. Mezcla de recuperación';

  @override
  String get blendNameLabel => 'NOMBRE DE LA MEZCLA';

  @override
  String get blendSafetyDisclaimer =>
      'Solo conversión de unidades. PepMod no recomienda una combinación, dosis, frecuencia ni método de reconstitución.';

  @override
  String get changeNoteHint => 'Tu propio contexto para esta fase';

  @override
  String get changeNoteOptional => 'NOTA DE CAMBIO OPCIONAL';

  @override
  String colorOption(String hex) {
    return 'Opción de color $hex';
  }

  @override
  String compoundNumber(int number) {
    return 'COMPUESTO $number';
  }

  @override
  String compoundsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count compuestos',
      one: '1 compuesto',
    );
    return '$_temp0';
  }

  @override
  String copiedVialPreset(String amount, String unit) {
    return 'Ajuste de vial de $amount $unit · copiado en este protocolo';
  }

  @override
  String get createProtocolAction => 'CREAR PROTOCOLO';

  @override
  String get createProtocolAddOneError => 'Añade al menos un péptido.';

  @override
  String createProtocolBuildStep(int step, int total) {
    return 'Crear protocolo · Paso $step / $total';
  }

  @override
  String get createProtocolDefaultName => 'Mi protocolo';

  @override
  String createProtocolEditStep(int step, int total) {
    return 'Editar protocolo · Paso $step / $total';
  }

  @override
  String get createProtocolFreeLimitReason =>
      'El plan gratuito se limita a un péptido por protocolo. Mejora tu plan para combinar varios compuestos.';

  @override
  String get createProtocolNameBody =>
      'Ponle un nombre fácil de recordar, por ejemplo, «Combinación de recuperación» o «Definición Q2».';

  @override
  String get createProtocolNameTitle => 'Ponle nombre a tu protocolo';

  @override
  String get createProtocolNoPeptides => 'Aún no hay péptidos';

  @override
  String get createProtocolPickHint => 'Toca + para elegir de la biblioteca';

  @override
  String get createProtocolReviewBody =>
      'Confirma los datos del protocolo. Puedes editarlos cuando quieras desde la vista Gestionar.';

  @override
  String get createProtocolSaveError =>
      'No se pudo guardar el protocolo. Inténtalo de nuevo.';

  @override
  String get createProtocolStackBody =>
      'Añade un péptido o combina varios compuestos. Configura la etiqueta, la dosis, la frecuencia y el ciclo de cada uno.';

  @override
  String get createProtocolStackTitle => 'Crea tu combinación';

  @override
  String get customBlend => 'Combinación personalizada';

  @override
  String get customDays => 'Días personalizados';

  @override
  String get customDaysDisclaimer =>
      'Solo se programan los días seleccionados. Las cantidades son valores de seguimiento introducidos por ti, no recomendaciones de dosis.';

  @override
  String get customPeptide => 'Péptido personalizado';

  @override
  String get cycleWeeksLabel => 'SEMANAS DE CICLO';

  @override
  String get cycleWindowDisclaimer =>
      'Las ventanas de ciclo y descanso organizan el historial de seguimiento. PepMod no programará dosis futuras después de que termine la ventana del ciclo.';

  @override
  String get defaultAmountLabel => 'CANTIDAD PREDETERMINADA';

  @override
  String get diluentVolumeLabel => 'VOLUMEN DE DILUYENTE';

  @override
  String get drawExceedsVialError =>
      'La carga no puede superar el volumen del vial.';

  @override
  String get drawLabel => 'CARGAR';

  @override
  String get drawPreviewLabel => 'VISTA PREVIA DE CARGA';

  @override
  String drawPreviewValue(String units, String volume) {
    return '$units unidades = $volume ml';
  }

  @override
  String editTime(String time) {
    return 'Editar hora $time';
  }

  @override
  String get endWeekLabel => 'SEMANA FINAL';

  @override
  String get enterPeptideName => 'Introduce el nombre del péptido';

  @override
  String get frequencyLabel => 'FRECUENCIA';

  @override
  String get labelColorBody =>
      'Haz coincidir este color con la etiqueta del bolígrafo o vial que usas en la vida real.';

  @override
  String get labelColorLabel => 'COLOR DE ETIQUETA';

  @override
  String get manageSavedCompounds => 'Gestionar compuestos guardados';

  @override
  String get nextLabel => 'SIGUIENTE';

  @override
  String get noneLabel => 'Ninguno';

  @override
  String get oneOffCompound => 'Compuesto puntual';

  @override
  String get oneOffCompoundBody => 'Úsalo una vez sin guardar un ajuste';

  @override
  String get optionalLabel => 'Opcional';

  @override
  String peptidesCount(int count) {
    return 'PÉPTIDOS ($count)';
  }

  @override
  String get perDayAmounts => 'Cantidades por día';

  @override
  String phaseExtendsWarning(int weeks) {
    return 'Una fase se extiende más allá del ciclo de $weeks semanas. Ajusta la fase o el periodo del ciclo.';
  }

  @override
  String get phaseNameHint => 'p. ej. Seguimiento semana 1';

  @override
  String get phaseNameLabel => 'NOMBRE DE LA FASE';

  @override
  String phaseNumber(int number) {
    return 'Fase $number';
  }

  @override
  String phaseOutsideCycleError(int weeks) {
    return 'Este ciclo de protocolo termina en la semana $weeks. Mantén las semanas de la fase dentro de ese periodo.';
  }

  @override
  String get phaseOverlapError =>
      'Los rangos de semanas de las fases no pueden superponerse.';

  @override
  String get phaseOverrideBody =>
      'Introduce solo el horario de seguimiento que ya tienes previsto seguir. PepMod no recomienda cantidades.';

  @override
  String get phaseOverrideTitle => 'Anulación semana a semana';

  @override
  String get phasePreviewDisclaimer =>
      'Solo es una vista previa de tus datos. PepMod no recomienda ningún horario.';

  @override
  String get phasePreviewLabel => 'VISTA PREVIA DE FASE';

  @override
  String get phaseReminderBody =>
      'Se programa un recordatorio neutro de cambio de fase a las 9:00 cuando los recordatorios del protocolo están activados.';

  @override
  String get phaseScheduleLabel => 'HORARIO DE LA FASE';

  @override
  String get phaseSelectDayError =>
      'Selecciona al menos un día. PepMod no elegirá un horario por ti.';

  @override
  String get phasesBody =>
      'Las ventanas de fechas opcionales pueden anular esta cantidad y horario base. Fuera de ellas, continúa el horario base.';

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
      'Las semanas se cuentan desde la fecha de inicio del protocolo. Las notas de fase guardadas y los recordatorios de cambio son solo ayudas de seguimiento.';

  @override
  String get preBlendedVial => 'Vial premezclado';

  @override
  String get preBlendedVialBody => 'Un vial · una carga · varios compuestos';

  @override
  String get protocolNotesBody =>
      'Guarda el contexto que quieras tener a la vista al revisar este protocolo.';

  @override
  String get protocolNotesHint =>
      'p. ej. preguntas, contexto de seguimiento o notas del clínico';

  @override
  String get protocolNotesLabel => 'Notas del protocolo';

  @override
  String get reminderTimesBody =>
      'Cada hora seleccionada crea su propia fila de seguimiento y recordatorio en los días programados.';

  @override
  String get reminderTimesLabel => 'HORAS DE RECORDATORIO';

  @override
  String get removeLabel => 'ELIMINAR';

  @override
  String removePeptide(String name) {
    return 'Eliminar $name';
  }

  @override
  String get removePhase => 'Eliminar fase';

  @override
  String removeTime(String time) {
    return 'Eliminar hora $time';
  }

  @override
  String get restWeeksLabel => 'SEMANAS DE DESCANSO';

  @override
  String get reviewLabel => 'Revisión';

  @override
  String get routeLabel => 'VÍA';

  @override
  String get saveBlend => 'GUARDAR COMBINACIÓN';

  @override
  String get saveChanges => 'GUARDAR CAMBIOS';

  @override
  String get savePhase => 'GUARDAR FASE';

  @override
  String savedVialPreset(String amount, String unit) {
    return 'Vial de $amount $unit · Ajuste guardado';
  }

  @override
  String get scheduleLabel => 'HORARIO';

  @override
  String get searchCompounds => 'Buscar compuestos...';

  @override
  String get selectDayError =>
      'Selecciona al menos un día para programar este péptido.';

  @override
  String selectOption(String option) {
    return 'Selecciona $option';
  }

  @override
  String get startDateLabel => 'FECHA DE INICIO';

  @override
  String get startWeekLabel => 'SEMANA INICIAL';

  @override
  String syringeUnitsAmount(String amount) {
    return '$amount unidades de jeringa';
  }

  @override
  String get syringeUnitsDisclaimer =>
      'Marcas de jeringa U-100 opcionales introducidas por el usuario, solo para seguimiento.';

  @override
  String get syringeUnitsHint => 'p. ej., 12,5';

  @override
  String get syringeUnitsLabel => 'unidades de jeringa';

  @override
  String get syringeUnitsOptional => 'UNIDADES DE JERINGA OPCIONALES';

  @override
  String get trackedAmountLabel => 'CANTIDAD SEGUIDA';

  @override
  String get u100TrackingDisclaimer =>
      'Usa la escala de jeringa U-100 (100 unidades = 1 ml). Los valores son datos de seguimiento introducidos por el usuario.';

  @override
  String get unitLabel => 'UNIDAD';

  @override
  String get vialAmountHint => 'Cantidad del vial';

  @override
  String get vialContentsLabel => 'CONTENIDO DEL VIAL';

  @override
  String get vialLabelNameHint => 'Nombre de la etiqueta del vial';

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
    return 'DOSIS DEL $weekday';
  }

  @override
  String weekdaySchedule(String weekday) {
    return 'HORARIO DE $weekday';
  }

  @override
  String get doseDrawInvalid =>
      'La carga debe ser mayor que cero y no superar el vial.';

  @override
  String get doseGenericError => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get doseEditSystemLabel => 'EDITAR.DOSIS';

  @override
  String get doseLogSystemLabel => 'LOG.DOSIS';

  @override
  String get doseDraw => 'CARGA';

  @override
  String get doseAmount => 'CANTIDAD';

  @override
  String get doseUnits => 'unidades';

  @override
  String get doseTime => 'HORA';

  @override
  String get doseChooseTime => 'Elige la hora de la dosis';

  @override
  String get doseBlendSnapshot => 'RESUMEN DE COMBINACIÓN // POR CARGA';

  @override
  String doseSyringeUnitsRecorded(String amount) {
    return 'Se registraron $amount unidades de jeringa para esta dosis.';
  }

  @override
  String get doseInjectionSite => 'ZONA.INYECCIÓN';

  @override
  String doseLastSite(String site) {
    return 'ÚLTIMO PUNTO PARA ESTE PÉPTIDO · $site';
  }

  @override
  String get doseNotes => 'NOTAS';

  @override
  String get doseOptional => 'Opcional...';

  @override
  String get doseMarkPending => 'MARCAR COMO PENDIENTE';

  @override
  String get doseSaveChanges => 'GUARDAR CAMBIOS';

  @override
  String get doseSkip => 'Omitir esta dosis';

  @override
  String get doseHistorySystemLabel => 'HISTORIAL.DOSIS // 30.DÍAS';

  @override
  String get doseHistoryTitle => 'Dosis registradas';

  @override
  String get doseHistoryBody =>
      'Toca un registro para corregir su cantidad, hora real, punto de inyección, notas o estado.';

  @override
  String get doseHistoryEmpty =>
      'No hay dosis registradas en los últimos 30 días.';

  @override
  String get doseLogPrevious => 'REGISTRAR DOSIS ANTERIOR';

  @override
  String doseHistorySkipped(String dateTime) {
    return 'Omitida · $dateTime';
  }

  @override
  String doseHistoryTaken(String amount, String units, String dateTime) {
    return '$amount $units · $dateTime';
  }

  @override
  String get doseEditAction => 'EDITAR';

  @override
  String get doseChoosePastTime => 'Elige una hora pasada para registrar.';

  @override
  String get dosePreviousError =>
      'No se pudo registrar la dosis anterior. Inténtalo de nuevo.';

  @override
  String get doseLogPreviousSystemLabel => 'LOG.ANTERIOR';

  @override
  String get doseNoPeptides => 'No hay péptidos disponibles';

  @override
  String get doseNoPeptidesBody =>
      'Añade un péptido a un protocolo activo antes de registrar historial.';

  @override
  String get doseCorrectHistory => 'Corregir historial de dosis';

  @override
  String get dosePeptide => 'PÉPTIDO';

  @override
  String get doseDate => 'FECHA';

  @override
  String get doseChooseDate => 'Elige la fecha de la dosis';

  @override
  String doseSyringeUnitsEntry(String amount) {
    return '$amount unidades de jeringa registradas para esta entrada.';
  }

  @override
  String get doseHistoryDisclaimer =>
      'Los registros históricos son solo datos personales de seguimiento. No modifican la orientación médica ni las recomendaciones de dosis.';

  @override
  String get notificationChannelName => 'Recordatorios de dosis';

  @override
  String get notificationChannelDescription =>
      'Recordatorios programados para las dosis de tu protocolo de péptidos activo.';

  @override
  String get notificationDoseTitle => 'Hora de tu dosis';

  @override
  String get notificationDoseBody =>
      'Tu recordatorio de protocolo programado está listo.';

  @override
  String get notificationCycleTitle => 'Aviso del protocolo';

  @override
  String get notificationCycleBody =>
      'Hoy toca un recordatorio de la ventana de ciclo. Revisa tu plan de seguimiento.';

  @override
  String get notificationRestTitle =>
      'Punto de control del período de descanso';

  @override
  String get notificationRestBody =>
      'Hoy toca un recordatorio de periodo de descanso. Revisa tu plan de seguimiento.';

  @override
  String get notificationPhaseTitle => 'Aviso de fase del protocolo';

  @override
  String get notificationPhaseBody =>
      'Hoy empieza una nueva fase de seguimiento. Revisa tu horario guardado.';

  @override
  String get personalLibrarySystemLabel => 'SYS.BIBLIOTECA // PERSONAL';

  @override
  String get customCompoundIntro =>
      'Guarda las etiquetas y tamaños de vial que introduzcas tú mismo. Los ajustes son atajos de seguimiento, no recomendaciones de dosis.';

  @override
  String get archivedHeading => 'ARCHIVADOS';

  @override
  String get activePresetsHeading => 'AJUSTES ACTIVOS';

  @override
  String get showActive => 'Mostrar activos';

  @override
  String get archivedAction => 'Archivado';

  @override
  String get customCompoundsLoadFailed =>
      'No se pudieron cargar tus compuestos. Inténtalo de nuevo.';

  @override
  String get libraryLoadFailed =>
      'No se pudo cargar la biblioteca de péptidos. Inténtalo de nuevo.';

  @override
  String compoundVialSummary(String amount, String unit, String route) {
    return 'Vial de $amount $unit · $route';
  }

  @override
  String get editPreset => 'Editar ajuste';

  @override
  String get restorePreset => 'Restaurar';

  @override
  String get archivePreset => 'Archivar';

  @override
  String get noArchivedPresets => 'No hay ajustes archivados';

  @override
  String get noSavedCompounds => 'No hay compuestos guardados';

  @override
  String get archivedPresetsHint =>
      'Los ajustes archivados permanecen aquí hasta que los restaures.';

  @override
  String get createPresetHint =>
      'Crea un ajuste reutilizable de nombre y tamaño de vial.';

  @override
  String get presetCompoundSystemLabel => 'PRESET.COMPUESTO';

  @override
  String get newCompound => 'Nuevo compuesto';

  @override
  String get editCompound => 'Editar compuesto';

  @override
  String get ownVialDetailsHint =>
      'Introduce solo los datos impresos en tu propio vial.';

  @override
  String get compoundLabel => 'ETIQUETA DEL COMPUESTO';

  @override
  String get compoundNameExample => 'p. ej. Mi compuesto';

  @override
  String get vialUnitLabel => 'UNIDAD DEL VIAL';

  @override
  String get trackingUnitLabel => 'UNIDAD DE SEGUIMIENTO';

  @override
  String get notesOptional => 'NOTAS OPCIONAL';

  @override
  String get compoundNoteExample => 'Etiqueta o nota de almacenamiento';

  @override
  String get noDoseRecommendation =>
      'No se crea ninguna recomendación de dosis. Las cantidades del protocolo siempre las introduces tú por separado.';

  @override
  String get saveCompoundFailed =>
      'No se pudo guardar el ajuste. Inténtalo de nuevo.';

  @override
  String get routeTopical => 'Tópica';

  @override
  String get frequencyCustomDays => 'Días personalizados';

  @override
  String savedCalculationLabel(
    String vialAmount,
    String vialUnit,
    String diluentVolume,
  ) {
    return '$vialAmount $vialUnit + $diluentVolume ml';
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
    return 'U-100 · $volume mL / $capacity unidad';
  }

  @override
  String get peptideContentHcgDescription =>
      'La gonadotropina coriónica humana (HCG) es una hormona glicoproteica utilizada en entornos clínicos regulados y que se menciona con frecuencia junto a los protocolos de péptidos. Esta entrada se ofrece como referencia neutral de seguimiento para los horarios introducidos por el usuario.';

  @override
  String get peptideContentHcgTypicalDose => 'UI introducidas por el usuario';

  @override
  String get peptideContentHcgHalfLife => '~24-36 horas';

  @override
  String get peptideContentHcgNotes =>
      'Solo con receta en muchas jurisdicciones. Registra únicamente lo que ya te haya indicado un profesional sanitario cualificado; PepMod no ofrece pautas de dosificación de HCG.';

  @override
  String get peptideContentBpc157Description =>
      'BPC-157 (Body Protection Compound 157) es un péptido sintético de 15 aminoácidos derivado de una proteína presente en el jugo gástrico. Se ha estudiado en modelos animales por su posible papel en la reparación de tejidos blandos y del revestimiento intestinal. Los datos clínicos en humanos siguen siendo limitados.';

  @override
  String get peptideContentBpc157TypicalDose => '250–500 mcg';

  @override
  String get peptideContentBpc157HalfLife => '~4 horas';

  @override
  String get peptideContentBpc157Notes =>
      'En estudios con animales, BPC-157 se menciona habitualmente junto con TB-500 en protocolos de investigación sobre tendones y ligamentos. Esta referencia no constituye instrucciones de reconstitución ni de uso.';

  @override
  String get peptideContentTb500Description =>
      'TB-500 es un fragmento sintético de la proteína natural timosina beta-4. En estudios con animales se ha investigado su posible papel en la migración celular y la regeneración de tejidos. Se utiliza ampliamente fuera de indicación por investigadores y en entornos veterinarios.';

  @override
  String get peptideContentTb500TypicalDose =>
      '2–5 mg semanales de carga, luego 2 mg de mantenimiento';

  @override
  String get peptideContentTb500HalfLife => '~2 días';

  @override
  String get peptideContentTb500Notes =>
      'A menudo se combina con BPC-157 en protocolos de tejido blando. Es habitual repartir la dosis dos veces por semana debido a su semivida prolongada.';

  @override
  String get peptideContentGhkCuDescription =>
      'GHK-Cu (péptido de cobre) es un tripéptido natural que se une al cobre y está presente en el plasma humano. Se ha estudiado en aplicaciones cosméticas tópicas por su papel en la remodelación cutánea y la señalización del folículo piloso.';

  @override
  String get peptideContentGhkCuTypicalDose => '1–2 mg';

  @override
  String get peptideContentGhkCuHalfLife => '~1 hora';

  @override
  String get peptideContentGhkCuNotes =>
      'También se usa por vía tópica en formulaciones para el cuidado de la piel. La dosis subcutánea suele ser inferior a las concentraciones tópicas.';

  @override
  String get peptideContentEpitalonDescription =>
      'La epitalona es un tetrapéptido sintético análogo de la epitalamina, un péptido extraído de la glándula pineal. Investigaciones rusas han explorado sus efectos sobre la actividad de la telomerasa y la regulación circadiana.';

  @override
  String get peptideContentEpitalonTypicalDose => '5–10 mg por día de ciclo';

  @override
  String get peptideContentEpitalonHalfLife => '~30 minutos';

  @override
  String get peptideContentEpitalonNotes =>
      'Se suele emplear en ciclos cortos por pulsos (p. ej., 10-20 días activos y meses de descanso) según protocolos de investigación rusos sobre longevidad.';

  @override
  String get peptideContentSemaglutideDescription =>
      'La semaglutida es un agonista del receptor GLP-1 desarrollado originalmente para la diabetes tipo 2 y aprobado posteriormente para el control crónico del peso bajo las marcas Ozempic y Wegovy. Ralentiza el vaciado gástrico y modula la señalización del apetito.';

  @override
  String get peptideContentSemaglutideTypicalDose =>
      '0.25–2.4 mg semanales (con ajuste progresivo)';

  @override
  String get peptideContentSemaglutideHalfLife => '~7 días';

  @override
  String get peptideContentSemaglutideNotes =>
      'Solo con receta en la mayoría de los países. El esquema de titulación comienza bajo y aumenta cada 4 semanas para controlar los efectos secundarios digestivos.';

  @override
  String get peptideContentTirzepatideDescription =>
      'La tirzepatida es un agonista dual de los receptores GIP/GLP-1 aprobado para la diabetes tipo 2 (Mounjaro) y la obesidad (Zepbound). Los ensayos clínicos han mostrado que produce mayores reducciones de peso que los agonistas GLP-1 de acción única.';

  @override
  String get peptideContentTirzepatideTypicalDose =>
      '2.5–15 mg semanales (con ajuste progresivo)';

  @override
  String get peptideContentTirzepatideHalfLife => '~5 días';

  @override
  String get peptideContentTirzepatideNotes =>
      'Solo con receta en la mayoría de los países. La titulación estándar se realiza en incrementos de 4 semanas. Se inyecta por vía subcutánea una vez por semana.';

  @override
  String get peptideContentRetatrutideDescription =>
      'La retatrutida es un agonista triple en fase de investigación que actúa sobre los receptores GIP, GLP-1 y glucagón. Los ensayos de fase 2 registraron reducciones de peso superiores a las de las terapias existentes basadas en GLP-1.';

  @override
  String get peptideContentRetatrutideTypicalDose =>
      'Dosis de ensayo de 1–12 mg semanales';

  @override
  String get peptideContentRetatrutideHalfLife => '~6 días';

  @override
  String get peptideContentRetatrutideNotes =>
      'Todavía en fase de investigación: no aprobado por la FDA en el momento de redactar esto. Cualquier uso fuera de un ensayo clínico es estrictamente para investigación.';

  @override
  String get peptideContentIpamorelinDescription =>
      'La ipamorelina es un pentapéptido mimético de la grelina y secretagogo selectivo de la hormona del crecimiento. Se ha investigado por su capacidad de estimular una liberación pulsátil de GH con un efecto mínimo sobre el cortisol o la prolactina.';

  @override
  String get peptideContentIpamorelinTypicalDose => '200–300 mcg por inyección';

  @override
  String get peptideContentIpamorelinHalfLife => '~2 horas';

  @override
  String get peptideContentIpamorelinNotes =>
      'Se combina habitualmente con CJC-1295 (sin DAC) para lograr un pulso sinérgico de GH. Momento típico: antes de dormir y/o antes de entrenar en ayunas.';

  @override
  String get peptideContentCjc1295DacDescription =>
      'CJC-1295 es un análogo sintético de la GHRH. La variante DAC (Drug Affinity Complex) se une a la albúmina sérica, lo que prolonga su semivida y genera niveles sostenidos de GH en lugar de pulsos discretos.';

  @override
  String get peptideContentCjc1295DacTypicalDose => '1–2 mg semanales';

  @override
  String get peptideContentCjc1295DacHalfLife => '~8 días';

  @override
  String get peptideContentCjc1295DacNotes =>
      'De acción prolongada: normalmente se dosifica una o dos veces por semana. Eleva los niveles basales de GH/IGF-1 en lugar de producir pulsos marcados.';

  @override
  String get peptideContentCjc1295NoDacDescription =>
      'CJC-1295 sin DAC —también conocido como Mod-GRF(1-29)— es un análogo de la GHRH con una semivida corta. Suele combinarse con un GHRP como la ipamorelina para desencadenar una liberación pulsátil natural de GH.';

  @override
  String get peptideContentCjc1295NoDacTypicalDose => '100 mcg por inyección';

  @override
  String get peptideContentCjc1295NoDacHalfLife => '~30 minutos';

  @override
  String get peptideContentCjc1295NoDacNotes =>
      'De acción corta: se combina con un GHRP (Ipamorelin, GHRP-2, GHRP-6) para amplificar los pulsos de GH. Suele dosificarse de 1 a 3 veces al día en ayunas.';

  @override
  String get peptideContentTesamorelinDescription =>
      'La tesamorelina es un análogo estabilizado de la GHRH aprobado para reducir el exceso de grasa visceral abdominal en la lipodistrofia asociada al VIH (marca Egrifta). También se ha estudiado en contextos de envejecimiento cognitivo.';

  @override
  String get peptideContentTesamorelinTypicalDose => '1–2 mg al día';

  @override
  String get peptideContentTesamorelinHalfLife => '~30 minutos';

  @override
  String get peptideContentTesamorelinNotes =>
      'Medicamento con receta. Estudiado principalmente para reducir el tejido adiposo visceral. Se administra una vez al día por vía subcutánea.';

  @override
  String get peptideContentMotsCDescription =>
      'MOTS-c es un péptido derivado de la mitocondria codificado en el gen MT-RNR1. La investigación ha estudiado su papel en la homeostasis metabólica, la sensibilidad a la insulina y la fisiología del ejercicio.';

  @override
  String get peptideContentMotsCTypicalDose => '5–10 mg 2–3 veces por semana';

  @override
  String get peptideContentMotsCHalfLife => '~90 minutos';

  @override
  String get peptideContentMotsCNotes =>
      'La investigación aún es incipiente. Algunos usuarios reportan mejoras en la recuperación del ejercicio y en marcadores metabólicos en registros de autoexperimentación.';

  @override
  String get peptideContentCerebrolysinDescription =>
      'Cerebrolysin es una mezcla de péptidos de bajo peso molecular y aminoácidos derivados de tejido cerebral porcino. Se prescribe en varios países de Europa y Asia para indicaciones neurodegenerativas y de recuperación tras un ictus.';

  @override
  String get peptideContentCerebrolysinTypicalDose =>
      'Ampollas de 5–30 ml (entorno clínico)';

  @override
  String get peptideContentCerebrolysinHalfLife => 'Variable (mezcla)';

  @override
  String get peptideContentCerebrolysinNotes =>
      'Se administra típicamente en un ciclo bajo supervisión clínica. No disponible en EE. UU. Investigado en ictus isquémico y enfermedad de Alzheimer.';

  @override
  String get peptideContentSelankDescription =>
      'Selank es un heptapéptido sintético desarrollado en Rusia como análogo del péptido inmunomodulador tuftsina. Se ha estudiado por sus posibles efectos ansiolíticos sin la sedación ni la dependencia asociadas a las benzodiacepinas.';

  @override
  String get peptideContentSelankTypicalDose =>
      '250–500 mcg por vía intranasal';

  @override
  String get peptideContentSelankHalfLife => '~pocos minutos (sistémica)';

  @override
  String get peptideContentSelankNotes =>
      'Se administra con mayor frecuencia por vía intranasal. La investigación rusa se centra en la ansiedad y la atención. Semivida corta, aunque los efectos reportados duran varias horas.';

  @override
  String get peptideContentSemaxDescription =>
      'Semax es un heptapéptido sintético derivado de un fragmento de la ACTH (4–10). Investigaciones rusas han estudiado sus posibles efectos nootrópicos y neuroprotectores, en particular en protocolos de recuperación tras un ictus.';

  @override
  String get peptideContentSemaxTypicalDose =>
      '250–1000 mcg por vía intranasal';

  @override
  String get peptideContentSemaxHalfLife => '~30 minutos';

  @override
  String get peptideContentSemaxNotes =>
      'La administración intranasal es habitual. Aprobado en Rusia para el ictus isquémico. A menudo se cicla con Selank para obtener efectos complementarios.';

  @override
  String get peptideContentMelanotanIiDescription =>
      'La melanotán II es un análogo sintético de la hormona estimulante de los alfa-melanocitos (α-MSH). Se desarrolló originalmente como posible agente para el bronceado sin sol y también se ha asociado con efectos sobre el apetito y la libido.';

  @override
  String get peptideContentMelanotanIiTypicalDose =>
      '250–1000 mcg de carga, luego mantenimiento';

  @override
  String get peptideContentMelanotanIiHalfLife => '~1 hora';

  @override
  String get peptideContentMelanotanIiNotes =>
      'No aprobado para ningún uso médico. Los efectos secundarios reportados con mayor frecuencia incluyen náuseas y oscurecimiento de lunares existentes. Cualquier lunar nuevo o que cambie debe ser evaluado por un dermatólogo.';

  @override
  String get peptideContentPt141Description =>
      'PT-141, también conocido como bremelanotida y comercializado como Vyleesi, es un agonista del receptor de melanocortina aprobado por la FDA para el trastorno del deseo sexual hipoactivo en mujeres premenopáusicas. Actúa sobre vías del sistema nervioso central.';

  @override
  String get peptideContentPt141TypicalDose =>
      '1.25–1.75 mg según sea necesario';

  @override
  String get peptideContentPt141HalfLife => '~2 horas';

  @override
  String get peptideContentPt141Notes =>
      'Medicamento con receta en algunos mercados. Se toma según sea necesario, no en un horario fijo. Los efectos secundarios comunes incluyen náuseas y aumentos transitorios de la presión arterial.';

  @override
  String get peptideContentDsipDescription =>
      'El péptido inductor del sueño delta (DSIP) es un nonapéptido aislado del cerebro de conejo en la década de 1970. Se ha estudiado por su posible papel en la regulación del sueño, la modulación del dolor y la respuesta al estrés, aunque sus mecanismos siguen sin estar claros.';

  @override
  String get peptideContentDsipTypicalDose => '100–500 mcg antes de dormir';

  @override
  String get peptideContentDsipHalfLife => '~7 minutos';

  @override
  String get peptideContentDsipNotes =>
      'Se administra típicamente antes de dormir. Tiene una semivida plasmática corta, aunque los efectos reportados pueden durar más. La evidencia disponible sigue siendo limitada.';

  @override
  String get peptideContentThymosinAlpha1Description =>
      'La timosina alfa-1 es un péptido de 28 aminoácidos aislado originalmente del tejido tímico. Se ha aprobado en varios países como terapia inmunomoduladora complementaria (marca Zadaxin) para la hepatitis B y C.';

  @override
  String get peptideContentThymosinAlpha1TypicalDose =>
      '1.6 mg dos veces por semana';

  @override
  String get peptideContentThymosinAlpha1HalfLife => '~2 horas';

  @override
  String get peptideContentThymosinAlpha1Notes =>
      'Se usa en varios mercados internacionales como parte de protocolos de modulación inmunitaria. Se administra típicamente dos veces por semana. La investigación continúa en diversas indicaciones.';

  @override
  String get peptideContentNadPlusDescription =>
      'El NAD+ (dinucleótido de nicotinamida y adenina) es una coenzima central en el metabolismo energético celular y la reparación del ADN. El NAD+ inyectable y sus precursores (NR, NMN) se estudian en el contexto de la salud mitocondrial y el envejecimiento.';

  @override
  String get peptideContentNadPlusTypicalDose =>
      '100–500 mg IV o subcutáneo por sesión';

  @override
  String get peptideContentNadPlusHalfLife => '~90 minutos';

  @override
  String get peptideContentNadPlusNotes =>
      'Técnicamente es una coenzima y no un péptido, pero suele agruparse con los protocolos de longevidad. Se recomienda una infusión lenta para minimizar el enrojecimiento y las molestias.';

  @override
  String get peptideContentSermorelinDescription =>
      'La sermorelina es un análogo sintético de la hormona liberadora de la hormona del crecimiento (GHRH). Se ha utilizado clínicamente como agente diagnóstico de la reserva de hormona del crecimiento y suele mencionarse en entornos de bienestar como péptido de apoyo al eje de la GH.';

  @override
  String get peptideContentSermorelinTypicalDose =>
      '100–300 mcg antes de dormir';

  @override
  String get peptideContentSermorelinHalfLife => '~10–20 minutos';

  @override
  String get peptideContentSermorelinNotes =>
      'Se compara a menudo con CJC-1295 sin DAC porque ambos actúan sobre la vía de la GHRH. Su semivida corta hace que la dosis nocturna sea habitual en protocolos no clínicos.';

  @override
  String get peptideContentAod9604Description =>
      'AOD-9604 es un fragmento modificado de la hormona del crecimiento humana, derivado de la región 176–191. Se ha investigado por su señalización metabólica y de lipólisis, pero la evidencia publicada en humanos es limitada y mixta.';

  @override
  String get peptideContentAod9604TypicalDose => '250–500 mcg al día';

  @override
  String get peptideContentAod9604HalfLife => '~30 minutos';

  @override
  String get peptideContentAod9604Notes =>
      'También llamado fragmento de HGH 176-191 en algunas discusiones. No es un medicamento aprobado para la pérdida de peso; usa un lenguaje de seguimiento neutro y evita garantizar resultados.';

  @override
  String get peptideContentKpvDescription =>
      'KPV es una secuencia tripeptídica corta (lisina-prolina-valina) derivada de la hormona estimulante de los alfa-melanocitos. Se menciona en contextos de investigación por su señalización inmunitaria y de la barrera intestinal.';

  @override
  String get peptideContentKpvTypicalDose => '250–500 mcg al día';

  @override
  String get peptideContentKpvHalfLife => 'No bien establecida';

  @override
  String get peptideContentKpvNotes =>
      'Aparece en discusiones sobre salud intestinal y uso tópico, incluidas combinaciones informales con BPC-157. La evidencia sobre dosificación en humanos es limitada, por lo que los protocolos deben ser conservadores.';

  @override
  String get peptideContentSs31Description =>
      'SS-31, también conocido como elamipretida, es un tetrapéptido dirigido a la mitocondria estudiado por sus interacciones con la cardiolipina y la función de la membrana mitocondrial. La investigación clínica se ha centrado en enfermedades mitocondriales y cardíacas poco frecuentes.';

  @override
  String get peptideContentSs31TypicalDose => 'Los protocolos de ensayo varían';

  @override
  String get peptideContentSs31HalfLife => '~4 horas';

  @override
  String get peptideContentSs31Notes =>
      'En fase de investigación en muchos contextos. Los protocolos de la comunidad suelen diferir de las formulaciones de los ensayos clínicos y deben considerarse exclusivamente de investigación.';

  @override
  String get peptideContentLl37Description =>
      'LL-37 es un péptido antimicrobiano humano de la familia de las catelicidinas implicado en la señalización inmunitaria innata. Se menciona en comunidades de investigación por sus vías de defensa del huésped y respuesta tisular, pero las consideraciones de seguridad son importantes.';

  @override
  String get peptideContentLl37TypicalDose =>
      'Los protocolos de investigación varían';

  @override
  String get peptideContentLl37HalfLife => 'No bien establecida';

  @override
  String get peptideContentLl37Notes =>
      'Altamente experimental fuera de la investigación controlada. Dado que los péptidos antimicrobianos pueden afectar la señalización inmunitaria, es importante mantener un enfoque educativo conservador.';

  @override
  String get peptideContentDihexaDescription =>
      'La dihexa es un análogo peptídico derivado de la angiotensina IV, activo por vía oral, estudiado en fase preclínica por su señalización del factor de crecimiento de hepatocitos/c-Met y su actividad sinaptogénica. Los datos de seguridad y eficacia en humanos no están establecidos.';

  @override
  String get peptideContentDihexaTypicalDose =>
      'Solo para investigación; los protocolos varían';

  @override
  String get peptideContentDihexaHalfLife => 'No bien establecida';

  @override
  String get peptideContentDihexaNotes =>
      'Popular en discusiones sobre nootrópicos, pero muy experimental. Trátalo como una entrada de compuesto de investigación y no como un protocolo sugerido.';

  @override
  String get peptideContentGhrp2Description =>
      'GHRP-2 es un péptido sintético liberador de la hormona del crecimiento que actúa como agonista del receptor de grelina. Se ha estudiado por su papel en la secreción de GH, la señalización del apetito y las pruebas endocrinas.';

  @override
  String get peptideContentGhrp2TypicalDose => '100–300 mcg por inyección';

  @override
  String get peptideContentGhrp2HalfLife => '~20–30 minutos';

  @override
  String get peptideContentGhrp2Notes =>
      'Se combina a menudo con un análogo de GHRH, como CJC-1295 sin DAC o Sermorelin. Puede afectar al apetito, el cortisol y la prolactina más que Ipamorelin.';

  @override
  String get peptideContentGhrp6Description =>
      'GHRP-6 es un hexapéptido sintético y agonista del receptor de grelina estudiado por la liberación de hormona del crecimiento y la señalización del apetito. Es uno de los péptidos más antiguos de la familia GHRP.';

  @override
  String get peptideContentGhrp6TypicalDose => '100–300 mcg por inyección';

  @override
  String get peptideContentGhrp6HalfLife => '~20–30 minutos';

  @override
  String get peptideContentGhrp6Notes =>
      'El uso en la comunidad suele destacar la estimulación del apetito. Se suelen preferir opciones más selectivas, como Ipamorelin, cuando no se desean efectos sobre el apetito.';

  @override
  String get peptideContentHexarelinDescription =>
      'La hexarelina es un secretagogo sintético de la hormona del crecimiento y agonista del receptor de grelina estudiado por la liberación de GH y señales de investigación cardiovascular. Generalmente se considera uno de los GHRP más potentes.';

  @override
  String get peptideContentHexarelinTypicalDose => '100–200 mcg por inyección';

  @override
  String get peptideContentHexarelinHalfLife => '~70 minutos';

  @override
  String get peptideContentHexarelinNotes =>
      'Suele ciclarse de forma más conservadora que Ipamorelin debido a su potencia y a las preocupaciones sobre desensibilización comentadas en comunidades de investigación.';

  @override
  String get peptideContentIgf1Lr3Description =>
      'IGF-1 LR3 es un análogo modificado del factor de crecimiento insulínico tipo 1 con sustituciones de aminoácidos que reducen la afinidad por las proteínas de unión y prolongan su actividad. Se menciona sobre todo en contextos de rendimiento avanzado e investigación del crecimiento celular.';

  @override
  String get peptideContentIgf1Lr3TypicalDose =>
      '20–50 mcg al día en protocolos de investigación';

  @override
  String get peptideContentIgf1Lr3HalfLife => '~20–30 horas';

  @override
  String get peptideContentIgf1Lr3Notes =>
      'Compuesto de investigación de mayor riesgo. Las posibles preocupaciones relacionadas con la glucosa y la señalización del crecimiento tisular hacen que la supervisión médica sea especialmente importante.';

  @override
  String get peptideContentIgf1DesDescription =>
      'IGF-1 DES es un análogo más corto del IGF-1 al que le faltan los tres primeros aminoácidos. Se menciona como una variante de IGF de acción más corta en la investigación de señalización tisular local.';

  @override
  String get peptideContentIgf1DesTypicalDose =>
      '20–50 mcg en protocolos de investigación';

  @override
  String get peptideContentIgf1DesHalfLife => '~20–30 minutos';

  @override
  String get peptideContentIgf1DesNotes =>
      'Muy avanzado y experimental. Evita sugerencias generales de protocolo, ya que los datos de seguridad en humanos y la supervisión adecuada son limitados.';

  @override
  String get peptideContentPegMgfDescription =>
      'PEG-MGF es una variante pegilada del factor de crecimiento mecánico, un péptido variante de empalme del IGF-1. La pegilación tiene como objetivo prolongar el tiempo de circulación en comparación con el MGF sin modificar.';

  @override
  String get peptideContentPegMgfTypicalDose =>
      '100–300 mcg semanales en protocolos de investigación';

  @override
  String get peptideContentPegMgfHalfLife => 'Prolongada por PEGilación';

  @override
  String get peptideContentPegMgfNotes =>
      'Común en foros de rendimiento, pero no es una terapia aprobada. Trátalo como una entrada de investigación avanzada con ajustes de seguimiento conservadores por defecto.';

  @override
  String get peptideContentMk677Description =>
      'MK-677, también conocido como ibutamoren, es un agonista del receptor de grelina y secretagogo de la hormona del crecimiento activo por vía oral. No es un péptido, pero suele mencionarse junto a los péptidos del eje de la GH.';

  @override
  String get peptideContentMk677TypicalDose => '10–25 mg al día';

  @override
  String get peptideContentMk677HalfLife => '~24 horas';

  @override
  String get peptideContentMk677Notes =>
      'Compuesto relacionado, no un péptido. Las discusiones de la comunidad suelen mencionar el apetito, la retención de agua, el sueño y consideraciones sobre el control de la glucosa.';

  @override
  String get peptideContentFiveAmino1mqDescription =>
      '5-Amino-1MQ es un inhibidor de molécula pequeña de la NNMT que se menciona en comunidades centradas en el metabolismo y la composición corporal. No es un péptido, pero suele aparecer en combinaciones de longevidad y pérdida de grasa cercanas al ámbito de los péptidos.';

  @override
  String get peptideContentFiveAmino1mqTypicalDose => '25–100 mg al día';

  @override
  String get peptideContentFiveAmino1mqHalfLife => 'No bien establecida';

  @override
  String get peptideContentFiveAmino1mqNotes =>
      'Compuesto relacionado, no un péptido. La evidencia en humanos es limitada; evita afirmaciones sobre resultados de pérdida de grasa o sensibilidad a la insulina.';

  @override
  String get peptideContentTesofensineDescription =>
      'La tesofensina es un inhibidor oral de la recaptación de monoaminas investigado para la obesidad y enfermedades neurodegenerativas. No es un péptido, pero se menciona con frecuencia en comunidades de control de peso junto a compuestos GLP-1.';

  @override
  String get peptideContentTesofensineTypicalDose =>
      '0.25–0.5 mg al día en estudios';

  @override
  String get peptideContentTesofensineHalfLife => '~9 días';

  @override
  String get peptideContentTesofensineNotes =>
      'Compuesto relacionado, no un péptido. Dado que afecta a las vías de neurotransmisores, la presión arterial y la frecuencia cardíaca, el control de interacciones es importante.';

  @override
  String get peptideContentRu58841Description =>
      'RU-58841 es un antiandrógeno tópico no esteroideo investigado por su señalización del receptor androgénico en el contexto del folículo piloso. No es un péptido, pero suele mencionarse en comunidades estéticas cercanas al ámbito de los péptidos.';

  @override
  String get peptideContentRu58841TypicalDose =>
      'Tópico: 25–50 mg al día en protocolos informales';

  @override
  String get peptideContentRu58841HalfLife => 'No bien establecida';

  @override
  String get peptideContentRu58841Notes =>
      'Compuesto relacionado, no un péptido ni un medicamento aprobado. El control de calidad y las preocupaciones sobre la exposición sistémica son puntos habituales de discusión.';

  @override
  String get peptideContentEducationalDisclaimer =>
      'Solo para fines de referencia educativa. No constituye consejo médico. Los péptidos de investigación no están aprobados para uso humano en la mayoría de las jurisdicciones; consulta siempre a un profesional sanitario cualificado.';
}
