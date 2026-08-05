// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get libraryTitle => '라이브러리';

  @override
  String get librarySystemLabel => 'SYS.데이터베이스 // 화합물';

  @override
  String get myCompounds => '내 화합물';

  @override
  String get unitConverter => '단위 변환기';

  @override
  String get openUnitConverter => '단위 변환기 열기';

  @override
  String get converterCardTitle => '단위 변환기';

  @override
  String get converterCardSubtitle => '바이알 수치를 지금 변환하세요';

  @override
  String get converterCardHint => '재구성 계산은 아래에서 펩타이드를 선택하세요.';

  @override
  String get searchPeptides => '펩타이드 검색...';

  @override
  String get categoryAll => '전체';

  @override
  String get categoryHealing => '회복';

  @override
  String get categoryGrowthHormone => '성장 호르몬';

  @override
  String get categoryCognitive => '인지 기능';

  @override
  String get categoryMetabolic => '대사';

  @override
  String get categoryAesthetic => '미용';

  @override
  String get categoryLongevity => '장수';

  @override
  String get categoryOther => '기타';

  @override
  String get libraryUnavailable => '라이브러리를 사용할 수 없습니다';

  @override
  String get retry => '다시 시도';

  @override
  String get noPeptidesFound => '펩타이드를 찾을 수 없습니다';

  @override
  String get tryDifferentSearch => '다른 검색어를 사용하거나 필터를 해제해 보세요.';

  @override
  String get calculationSaved => '이 계정에 계산을 저장했습니다.';

  @override
  String get converterIntro =>
      '본인의 바이알, 희석액 및 계획에 적힌 값을 입력하세요. PepMod가 해당 값을 부피와 U-100 주사기 단위로 변환합니다.';

  @override
  String get vialAndDiluent => '바이알 + 희석액';

  @override
  String get iuSourceCaption => '출처: 바이알에 표시된 IU와 추가한 희석액의 mL.';

  @override
  String get massSourceCaption => '출처: 바이알과 희석액의 라벨.';

  @override
  String get vialAmount => '바이알 용량';

  @override
  String get amountPrintedOnVial => '바이알에 표시된 양';

  @override
  String get diluent => '희석액';

  @override
  String get volumeAdded => '추가한 부피';

  @override
  String get amountToConvert => '변환할 양';

  @override
  String get iuAmountCaption => '이미 안내받은 IU 양을 입력하세요.';

  @override
  String get massAmountCaption => '출처: 이미 안내받은 양.';

  @override
  String get yourSyringe => '사용할 주사기';

  @override
  String get syringeCaption => '몸통에 표시된 용량을 선택하세요.';

  @override
  String get educationalConverterDisclaimer =>
      '교육용 단위 변환 도구입니다. PepMod는 양이나 빈도를 권장하지 않습니다. 사용 전 원본 라벨을 다시 확인하고 자격을 갖춘 의료 전문가에게 계산을 확인하세요.';

  @override
  String get back => '뒤로';

  @override
  String get vialWorkspace => '바이알 변환';

  @override
  String get conversionSystemLabel => '도구.변환';

  @override
  String get measurementModeSystemLabel => '측정.모드';

  @override
  String get conversionResultSystemLabel => '변환.결과';

  @override
  String get savedVialsSystemLabel => '저장한.바이알';

  @override
  String get clear => '지우기';

  @override
  String get conversionOnly => '변환 전용 — 이 화면에서는 양이나 일정을 정하지 않습니다.';

  @override
  String get sameUnitFamily => '바이알에 표시된 것과 같은 단위 체계를 사용하세요.';

  @override
  String get mass => '질량';

  @override
  String get iuOnly => 'IU 전용';

  @override
  String get iuSafety =>
      'IU는 IU로 유지됩니다. PepMod는 IU를 mg/mcg로 또는 mg/mcg를 IU로 변환하지 않습니다.';

  @override
  String get enterAmount => '양 입력';

  @override
  String get drawTo => '맞출 눈금';

  @override
  String get units => '단위';

  @override
  String get concentration => '농도';

  @override
  String get syringeCapacity => '주사기 용량';

  @override
  String get capacityWarning =>
      '변환된 부피가 이 주사기의 용량보다 큽니다. 올바른 주사기를 선택하거나 입력값을 다시 확인하세요.';

  @override
  String get savePreset => '프리셋 저장';

  @override
  String get savedVialsHint => '저장한 계산을 탭하면 입력값을 다시 사용할 수 있습니다.';

  @override
  String get removeSavedCalculation => '저장한 계산 삭제';

  @override
  String get errorPositiveNumbers => '모든 입력란에 0보다 큰 숫자를 입력하세요.';

  @override
  String get errorAmountAboveVial => '원하는 양이 이 바이알에 입력한 양보다 큽니다.';

  @override
  String get errorConversion => '이 값을 변환할 수 없습니다. 각 입력값을 다시 확인하세요.';

  @override
  String get halfLife => '반감기';

  @override
  String get weekCycle => '주 사이클';

  @override
  String get typicalDose => '일반적인 용량';

  @override
  String get notes => '메모';

  @override
  String get commonStack => '일반적인 조합';

  @override
  String get reconstitutionTool => '도구.재구성';

  @override
  String get compoundSystemLabel => 'DB.화합물';

  @override
  String get addToProtocol => '프로토콜에 추가';

  @override
  String get vialShort => '바이알 (mg)';

  @override
  String get bacShort => 'BAC (mL)';

  @override
  String get doseShort => '용량 (mcg)';

  @override
  String get routeSubcutaneous => '피하';

  @override
  String get routeIntramuscular => '근육 내';

  @override
  String get routeOral => '경구';

  @override
  String get routeNasal => '비강';

  @override
  String get frequencyDaily => '매일';

  @override
  String get frequencyEveryOtherDay => '격일';

  @override
  String get frequencyTwiceWeekly => '주 2회';

  @override
  String get frequencyWeekly => '매주';

  @override
  String get frequencyAsNeeded => '필요할 때';
}
