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
  String get converterCardSubtitle => 'Convierte los datos del vial';

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
      'Introduce los valores de tu vial, diluyente y plan. PepMod los convierte en volumen y unidades de jeringa U-100.';

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
  String get volumeAdded => 'Volumen añadido';

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
      'Herramienta educativa solo para convertir unidades. PepMod no recomienda cantidades ni frecuencias. Revisa las etiquetas originales y confirma el cálculo con un profesional sanitario cualificado antes de usarlo.';

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
      'Solo conversión: esta herramienta nunca elige una cantidad ni un horario.';

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
}
