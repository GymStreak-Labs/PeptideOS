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

  @override
  String get tabProtocol => '프로토콜';

  @override
  String get tabProgress => '진행';

  @override
  String get tabLibrary => '라이브러리';

  @override
  String get tabYou => '나';

  @override
  String get continueLabel => '계속';

  @override
  String get processingLabel => '처리 중…';

  @override
  String get authAppleFailed => 'Apple 로그인에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get authGoogleFailed => 'Google 로그인에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get authGenericError => '문제가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get authUserNotFound => '이 이메일 주소로 등록된 사용자를 찾을 수 없습니다.';

  @override
  String get authIncorrectCredentials => '이메일 또는 비밀번호가 올바르지 않습니다.';

  @override
  String get authAccountExists => '이미 이 이메일로 가입된 계정이 있습니다.';

  @override
  String get authWeakPassword => '비밀번호가 너무 약합니다. 6자 이상 입력해 주세요.';

  @override
  String get authInvalidEmail => '유효하지 않은 이메일 주소입니다.';

  @override
  String get authAppleUnavailable => '이 앱에서는 Apple로 로그인을 사용할 수 없습니다.';

  @override
  String get authRequiredTitle => '나만의 맞춤\n프로토콜 저장하기';

  @override
  String get authRequiredBody =>
      '프로토콜이 열리기 전에 로드맵, 일정, 투여 기록, 알림을 계정에 연결해 보관하세요.';

  @override
  String get continueWithEmail => '이메일로 계속하기';

  @override
  String get signInWithApple => 'APPLE로 로그인';

  @override
  String get continueWithGoogle => 'GOOGLE로 계속하기';

  @override
  String get authTermsDisclaimer =>
      '계속 진행하면 이용약관 및 개인정보처리방침에 동의하게 됩니다. PepMod는 교육용 도구이며, 의학적 조언이 아닙니다.';

  @override
  String get signIn => '로그인';

  @override
  String get createAccount => '계정 만들기';

  @override
  String get resetPassword => '비밀번호 재설정';

  @override
  String get signInAction => '로그인';

  @override
  String get createAccountAction => '계정 만들기';

  @override
  String get sendResetLink => '재설정 링크 보내기';

  @override
  String get passwordResetSent => '비밀번호 재설정 이메일을 보냈습니다. 받은편지함을 확인하세요.';

  @override
  String get enterEmail => '이메일을 입력하세요';

  @override
  String get enterValidEmail => '유효한 이메일을 입력하세요';

  @override
  String get enterPassword => '비밀번호를 입력하세요';

  @override
  String get passwordMinLength => '6자 이상 입력하세요';

  @override
  String get forgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get alreadyHaveAccount => '이미 계정이 있으신가요? 로그인';

  @override
  String get backToSignIn => '로그인으로 돌아가기';

  @override
  String get emailLabel => '이메일';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get showPassword => '비밀번호 표시';

  @override
  String get hidePassword => '비밀번호 숨기기';

  @override
  String get accountDeletedTitle => '계정 삭제됨';

  @override
  String get accountDeletedBody => 'PepMod 계정과 저장된 앱 데이터가 삭제되었습니다.';

  @override
  String get subscriptionUnavailable =>
      '지금은 구독 플랜을 이용할 수 없습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get upgradeUnavailable => '지금은 업그레이드를 이용할 수 없습니다. 나중에 다시 시도해 주세요.';

  @override
  String get noPurchasesToRestore => '복원할 구매 내역이 없습니다.';

  @override
  String get unlockFullProtocol => '전체 프로토콜 잠금 해제';

  @override
  String get premiumUnlimitedPeptides => '프로토콜당 무제한 펩타이드';

  @override
  String get premiumMultipleProtocols => '여러 개의 활성 프로토콜';

  @override
  String get premiumCalculator => '재구성 계산기 (전체 펩타이드)';

  @override
  String get premiumMetrics => '체성분 기록 + 차트';

  @override
  String get upgradeNow => '지금 업그레이드';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get notRightNow => '나중에 할게요';

  @override
  String get protocolWeeklyPlanner => '주간 플래너';

  @override
  String get protocolDoseHistory => '투여 기록';

  @override
  String get protocolCreate => '프로토콜 만들기';

  @override
  String get protocolManage => '관리';

  @override
  String get protocolYourProtocol => '내 프로토콜';

  @override
  String get protocolNoActive => '활성 프로토콜 없음';

  @override
  String get protocolNoActiveBody => '첫 프로토콜을 만들어 투여 기록과 준수율 관리를 시작하세요.';

  @override
  String get protocolStartFirst => '첫 프로토콜 시작하기';

  @override
  String get protocolScheduleTodaySystemLabel => '일정 // 오늘';

  @override
  String get protocolAdherenceTodaySystemLabel => '이행률 // 오늘';

  @override
  String get protocolNoDosesScheduledToday => '오늘 예정된 투여 없음';

  @override
  String protocolDosesTaken(int taken, int total) {
    return '총 $total회 중 $taken회 투여 완료';
  }

  @override
  String get protocolNextDose => '다음 투여';

  @override
  String protocolInTime(String duration) {
    return '$duration 후';
  }

  @override
  String protocolDurationHoursMinutes(int hours, int minutes) {
    return '$hours시간 $minutes분';
  }

  @override
  String protocolDurationMinutes(int minutes) {
    return '$minutes분';
  }

  @override
  String get protocolLogDose => '투여 기록';

  @override
  String get protocolNow => '지금';

  @override
  String get protocolMissed => '놓침';

  @override
  String get protocolSkipped => '건너뜀';

  @override
  String get protocolNoDosesToday => '오늘 투여 없음';

  @override
  String get protocolNoDosesTodayBody => '이 프로토콜에는 오늘 예정된 투여가 없습니다.';

  @override
  String get protocolFreeLimit =>
      '무료 플랜은 프로토콜 1개로 제한됩니다. Premium으로 업그레이드하면 여러 스택을 동시에 운영할 수 있습니다.';

  @override
  String protocolSyringeUnitsSuffix(String amount) {
    return ' · $amount 시린지 단위';
  }

  @override
  String get injectionSiteLeftAbdomen => '왼쪽 복부';

  @override
  String get injectionSiteRightAbdomen => '오른쪽 복부';

  @override
  String get injectionSiteLeftThigh => '왼쪽 허벅지';

  @override
  String get injectionSiteRightThigh => '오른쪽 허벅지';

  @override
  String get injectionSiteLeftGlute => '왼쪽 둔부';

  @override
  String get injectionSiteRightGlute => '오른쪽 둔부';

  @override
  String get injectionSiteLeftTriceps => '왼쪽 삼두근';

  @override
  String get injectionSiteRightTriceps => '오른쪽 삼두근';

  @override
  String get plannerToday => '오늘';

  @override
  String get plannerBack => '뒤로';

  @override
  String get plannerPreviousWeek => '이전 주';

  @override
  String get plannerNextWeek => '다음 주';

  @override
  String plannerScheduledCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '예정된 투여 $count건',
      one: '예정된 투여 $count건',
    );
    return '$_temp0';
  }

  @override
  String get plannerTrackingDisclaimer =>
      '기록 전용입니다. 이 캘린더는 저장된 프로토콜을 반영할 뿐, 투여에 대한 조언을 제공하지 않습니다.';

  @override
  String get plannerWashoutPeriod => '휴약 기간';

  @override
  String plannerWashoutUntil(String date) {
    return '$date까지 휴약';
  }

  @override
  String get plannerNoScheduledDoses => '예정된 투여 없음';

  @override
  String get plannerNothingPlanned => '저장된 프로토콜에 예정된 일정이 없습니다.';

  @override
  String get activatePro => 'PRO 활성화';

  @override
  String activateProPrice(String price) {
    return 'PRO 활성화 — $price/년';
  }

  @override
  String get annualAccess => '연간 이용권';

  @override
  String get annualLabel => '연간';

  @override
  String get averageRating => '평균 평점';

  @override
  String get bacWaterLabel => '희석수';

  @override
  String get basedOnInputs => '입력값 기준 //';

  @override
  String get bestValue => '최고 가치';

  @override
  String get birthDateInvalid => '만 18세 이상에 해당하는 유효한 날짜를 입력하세요.';

  @override
  String get birthDateValid => '연령 확인 완료';

  @override
  String calculatorDemoBody(String peptideName) {
    return '$peptideName(으)로 작동 방식을 보여드릴게요';
  }

  @override
  String get calculatorDemoResult => '이렇게 간단합니다. 값을 입력하면\n정확한 시린지 단위가 나옵니다.';

  @override
  String get calculatorDemoTitle => '이제 복잡한\n계산은 그만.';

  @override
  String get confidenceCycleTiming => '주기 타이밍';

  @override
  String get confidenceCycleTimingDetail => '프로토콜 일정과 주기 구간을 한눈에 확인';

  @override
  String get confidenceDoseMath => '용량 계산';

  @override
  String get confidenceDoseMathDetail => '바이알, 희석액, 용량, 흡입 단위를 한 곳에서 관리';

  @override
  String get confidenceLabel => '신뢰도';

  @override
  String get confidencePlainInfo => '쉬운 설명';

  @override
  String get confidencePlainInfoDetail => '복잡함 없이 연구 노트 확인';

  @override
  String get confidenceProgressSignals => '진행 신호';

  @override
  String get confidenceProgressSignalsDetail => '이행률과 신체 지표 변화를 시간순으로 확인';

  @override
  String get confidenceSafetyFraming => '안전 안내';

  @override
  String get confidenceSafetyFramingDetail => '교육용 안내와 유의사항을 항상 표시';

  @override
  String get confidenceSiteRotation => '부위 로테이션';

  @override
  String get confidenceSiteRotationDetail => '각 투여 부위 기록을 기억';

  @override
  String get connectingToStore => '스토어 연결 중...';

  @override
  String continueSelected(int count) {
    return '계속 ($count)';
  }

  @override
  String get customProtocol => '맞춤 프로토콜';

  @override
  String get dateOfBirthLabel => '생년월일';

  @override
  String get dayOne => '1일차';

  @override
  String get dayShortLabel => '일';

  @override
  String get defaultConfidence => '용량 계산 · 부위 로테이션';

  @override
  String get defaultFrustration => '투여 누락';

  @override
  String get defaultGoals => '회복 · 장수';

  @override
  String get doseLabel => '용량';

  @override
  String get dosesLogged => '기록된 투여 횟수';

  @override
  String get dosesPerDay => '일일 투여 횟수';

  @override
  String get drawVolumeLabel => '흡입량';

  @override
  String get durationLabel => '기간';

  @override
  String get experienceAdvanced => '숙련자';

  @override
  String get experienceAdvancedDetail => '세부적인 프로토콜 관리에 익숙해요';

  @override
  String get experienceFirstTime => '처음이에요';

  @override
  String get experienceFirstTimeDetail => '펩타이드 기록이 처음이에요';

  @override
  String get experienceIntermediate => '중급';

  @override
  String get experienceLabel => '경험 수준';

  @override
  String get experienceNovice => '입문';

  @override
  String get experienceSome => '약간의 경험';

  @override
  String get experienceSomeDetail => '한두 개의 프로토콜을 기록해봤어요';

  @override
  String get experienceVeteran => '전문가';

  @override
  String get featureDoseMathBody =>
      '지금 기록 중인 프로토콜 옆에 바이알 크기, 희석액 부피, 용량, 흡입 단위를 함께 확인하세요.';

  @override
  String get featureDoseMathTitle => '맥락 속\n용량 계산';

  @override
  String get featureProtocolArcBody =>
      '계획된 투여, 기록된 투여, 이행률, 신체 지표가 하나의 타임라인으로 이어지는 것을 확인하세요.';

  @override
  String get featureProtocolArcTitle => '시간에 따른\n프로토콜 흐름';

  @override
  String get featureShowcaseTitle => '필요한 모든 것.\n앱 하나로.';

  @override
  String get featureSiteRotationBody =>
      '기록한 모든 부위를 기억하고 로테이션 이력을 투여 기록에 함께 보관하세요.';

  @override
  String get featureSiteRotationTitle => '주사 부위\n로테이션';

  @override
  String get firstNameExample => '예: 민준';

  @override
  String get firstNameLabel => '이름';

  @override
  String get frustrationForgetting => '투여를 잊어버림';

  @override
  String get frustrationLabel => '불편했던 점';

  @override
  String get frustrationMath => '바이알·주사기 계산';

  @override
  String get frustrationProgress => '꾸준히 하고 있는지 확인하기 어려움';

  @override
  String get frustrationSchedule => '일정 관리가 어려움';

  @override
  String get frustrationStacking => '여러 펩타이드 동시 관리';

  @override
  String get frustrationTrust => '믿을 수 있는 정보 찾기';

  @override
  String get goalAntiAging => '건강한 노화';

  @override
  String get goalAntiAgingDetail => '장수 중심의 기록 정리';

  @override
  String get goalCognitive => '인지 기능 지원';

  @override
  String get goalCognitiveDetail => '집중력과 정신적 컨디션 모니터링';

  @override
  String get goalImmune => '면역 지원';

  @override
  String get goalImmuneDetail => '면역 중심 프로토콜 정리';

  @override
  String get goalMuscleGrowth => '근육 성장';

  @override
  String get goalMuscleGrowthDetail => '트레이닝과 성장 목표 추적';

  @override
  String get goalOther => '기타';

  @override
  String get goalOtherDetail => '다른 목표로 추적 설정';

  @override
  String get goalRecovery => '회복';

  @override
  String get goalRecoveryDetail => '회복 기록과 루틴 지원';

  @override
  String get goalSleep => '수면';

  @override
  String get goalSleepDetail => '수면 관련 목표와 패턴 추적';

  @override
  String get goalWeightLoss => '체중 감량';

  @override
  String get goalWeightLossDetail => '대사 목표와 진행 상황 추적';

  @override
  String get goalsLabel => '목표';

  @override
  String get iUnderstand => '이해했습니다';

  @override
  String get lastThreeDaysAgo => '최근: 3일 전';

  @override
  String get leftAbdomen => '왼쪽 복부';

  @override
  String get loveIt => '정말 좋아요';

  @override
  String get maybeLater => '나중에';

  @override
  String get monthOne => '1개월차';

  @override
  String get monthShortLabel => '월';

  @override
  String get monthTwo => '2개월차';

  @override
  String moreCount(String shown, int count) {
    return '$shown 외 $count개';
  }

  @override
  String get needsWork => '개선이 필요해요';

  @override
  String get notificationBody =>
      '예정된 프로토콜 시간이 되면 은근한 알림을 받으세요. 알림에 펩타이드 이름은 표시되지 않으며, 가벼운 리마인더만 제공됩니다.';

  @override
  String get notificationTitle => '투여 시간을\n놓치지 마세요.';

  @override
  String get nowLabel => '지금';

  @override
  String get ok => '확인';

  @override
  String get onboardingAgeConfirmed => '18세 이상입니다';

  @override
  String get onboardingAgeRequirementBody => 'PepMod를 사용하려면 18세 이상이어야 합니다.';

  @override
  String get onboardingAgeRequirementTitle => '연령 요건';

  @override
  String get onboardingAgeVerificationBody => 'PepMod는 18세 이상 성인을 위한 앱입니다.';

  @override
  String get onboardingAgeVerificationTitle => '먼저 연령을\n확인해주세요.';

  @override
  String get onboardingAheadBody =>
      '몇 가지 질문에 답하면 PepMod가 맞춤 트래킹 미리보기를 구성해드립니다.';

  @override
  String get onboardingAheadTitle => '시작하기 전에\n프로토콜을 먼저 확인하세요.';

  @override
  String get onboardingBirthDateBody => '연령 요건 충족 여부를 확인하는 정보예요.';

  @override
  String get onboardingBirthDateTitle => '생년월일이\n어떻게 되시나요?';

  @override
  String get onboardingConfidenceBody =>
      'PepMod가 더 명확하게 도와드렸으면 하는 항목을 모두 선택하세요.';

  @override
  String get onboardingConfidenceTitle => '어떤 부분에서\n더 확신이 필요하신가요?';

  @override
  String get onboardingConversionValueBody => '바이알과 플랜의 값을 부피와 주사기 단위로 변환합니다.';

  @override
  String get onboardingConversionValueTitle => '바이알 계산을\n더 쉽게 확인하세요.';

  @override
  String get onboardingDisclaimerBody =>
      'PepMod는 기록, 알림, 단위 변환을 정리하는 데 도움을 줍니다. 진단, 처방을 하거나 전문 의료 상담을 대체하지 않습니다.';

  @override
  String get onboardingDisclaimerTitle => '명확함을 위해.\n처방을 위한 것이 아닙니다.';

  @override
  String get onboardingExperienceTitle => '어느 정도의\n경험이 있으신가요?';

  @override
  String get onboardingFrustrationBody => '가장 큰 불편함을 선택하세요.';

  @override
  String get onboardingFrustrationTitle => '지금 가장\n어려운 점은 무엇인가요?';

  @override
  String get onboardingGoalsTitle => '주요 목표가\n무엇인가요?';

  @override
  String get onboardingGuidedStartBody =>
      '목표, 경험, 그리고 원하시는 기록 방식에 맞춰 설정을 맞춤화해 드릴게요.';

  @override
  String get onboardingGuidedStartTitle => '당신에게 맞춘\n가이드 시작.';

  @override
  String get onboardingHookAnswer => 'PepMod는 답을 프로토콜 옆에 바로 보여줍니다.';

  @override
  String get onboardingHookQuestion => '몇 유닛을\n주입하시나요?';

  @override
  String get onboardingHookResearch => '리서치 라이브러리';

  @override
  String get onboardingHookSources => '근거 링크가 연결된 출처';

  @override
  String get onboardingHookVial => '바이알 + 희석액';

  @override
  String get onboardingNameBody => 'PepMod 경험을 맞춤화하는 데 사용됩니다.';

  @override
  String get onboardingNameTitle => '어떻게\n불러드릴까요?';

  @override
  String get onboardingPeptideSelectBody => '사용 중이거나 주시하고 싶은 펩타이드를 선택하세요.';

  @override
  String get onboardingPeptideSelectTitle => '무엇을\n추적하고 계신가요?';

  @override
  String get onboardingProgressValueBody =>
      '순응도, 투여 기록, 신체 지표를 하나의 명확한 기록으로 모아드립니다.';

  @override
  String get onboardingProgressValueTitle => '시간에 따른\n전체 흐름을 확인하세요.';

  @override
  String get onboardingProtocolValueBody =>
      '일정을 계획하고, 투여를 기록하고, 각 프로토콜에 세부 정보를 함께 보관하세요.';

  @override
  String get onboardingProtocolValueTitle => '모든 프로토콜을\n한곳에 보관하세요.';

  @override
  String get onboardingUnder18 => '18세 미만입니다';

  @override
  String get openingPermission => '권한 확인 중...';

  @override
  String get paywallArcBody => '계획한 내용, 기록된 내용, 그리고 다음에 더 정리가 필요한 부분을 확인하세요.';

  @override
  String get paywallArcTitle => '시간에 따른 흐름 보기';

  @override
  String get paywallBody => '투여 계산, 부위 로테이션, 알림, 프로토콜 기록까지 — 하나의 기록으로 관리하세요.';

  @override
  String get paywallDoseMathBody =>
      '바이알, 희석수, 투여량, 주입 유닛을 함께 관리해 각 기록을 더 쉽게 확인하세요.';

  @override
  String get paywallDoseMathTitle => '정확한 투여 계산하기';

  @override
  String get paywallPreviewDisclaimer => '기록, 알림, 단위 명확성을 위한 도구이며 의료 조언이 아닙니다.';

  @override
  String get paywallRotationBody => '모든 부위, 주기, 알림이 프로토콜 기록에 계속 연결됩니다.';

  @override
  String get paywallRotationTitle => '로테이션을 놓치지 마세요';

  @override
  String get paywallTitle => '프로토콜을 제대로\n운영하기 위한 모든 것.';

  @override
  String get paywallValueNote =>
      '바이알 계산이 헷갈리면 시간과 제품이 낭비될 수 있습니다. PepMod는 계산을 기록 옆에 함께 보관해, 오래된 메모를 바탕으로 행동하기 전에 기록을 다시 확인할 수 있게 해줍니다.';

  @override
  String get peptideLabel => '펩타이드';

  @override
  String get peptidesLabel => '펩타이드';

  @override
  String get peptidesTracked => '추적 중인\n펩타이드';

  @override
  String get perWeek => '/주';

  @override
  String get perYear => '/년';

  @override
  String get privacyLabel => '개인정보처리방침';

  @override
  String processingGoals(int count) {
    return '목표 $count개 분석 중...';
  }

  @override
  String processingPeptides(int count) {
    return '펩타이드 기록 $count개 연결 중...';
  }

  @override
  String get processingProtocol => '프로토콜 구성 중...';

  @override
  String get processingSchedule => '일정 정리 중...';

  @override
  String get processingTitle => '프로토콜을\n구성하는 중';

  @override
  String get progressLabel => '진행 상황';

  @override
  String get protocolClarity => '프로토콜 명확성';

  @override
  String get protocolIncludes => '프로토콜 구성 항목 //';

  @override
  String get protocolPreviewTitle => '프로토콜이\n준비되었습니다.';

  @override
  String get protocolReady => '프로토콜 준비 완료 //';

  @override
  String get protocolReminderReady => '프로토콜 알림이 준비되었습니다';

  @override
  String get protocolReservedFor => '맞춤 프로토콜이 예약된 시간';

  @override
  String get restorePurchase => '구매 복원';

  @override
  String get resultsSummaryBody =>
      '데이터가 쌓이는 동안 투여 기록, 재구성 계산, 추세 기록을 함께 관리해 드릴게요.';

  @override
  String get reviewGateBody => '회원님의 피드백은 모든 바이오해커를 위해 플랫폼을 개선하는 데 도움이 됩니다.';

  @override
  String get reviewGateTitle => '지금까지 PepMod가\n만족스러우셨나요?';

  @override
  String roadmapBody(int count, String need) {
    return '추적 중인 펩타이드 $count개와 $need에 대한 필요를 바탕으로 구성되었습니다.';
  }

  @override
  String get roadmapDayOneBody => '펩타이드, 투여 기록, 부위 로테이션, 알림이 준비되었습니다.';

  @override
  String get roadmapDayOneTitle => '첫 번째 프로토콜이 정리되었습니다';

  @override
  String get roadmapDisclaimer =>
      'PepMod는 기록과 알림을 정리해 드립니다. 처방, 진단을 하거나 임상의의 지침을 대체하지 않습니다.';

  @override
  String get roadmapMonthOneBody => '순응도, 놓친 투여, 신체 지표가 더 명확한 기록으로 형성되기 시작합니다.';

  @override
  String get roadmapMonthOneTitle => '꾸준함의 기록이 쌓이기 시작합니다';

  @override
  String get roadmapMonthTwoBody =>
      '계획한 내용, 실제 진행된 내용, 그리고 기록에서 주의가 필요한 부분을 확인하세요.';

  @override
  String get roadmapMonthTwoTitle => '프로토콜 전체 흐름을 확인할 수 있습니다';

  @override
  String get roadmapTitle => '앞으로\n이런 일이 펼쳐집니다.';

  @override
  String get roadmapWeekOneBody => '이해하기 쉬운 리서치와 추적 메모가 계획에 함께 유지됩니다.';

  @override
  String roadmapWeekOneTitle(String goal) {
    return '$goal을(를) 중심으로 라이브러리가 채워집니다';
  }

  @override
  String savePercent(int percent) {
    return '$percent% 절약';
  }

  @override
  String get saveRoadmap => '이 로드맵 저장하기';

  @override
  String get schedulePreview => '일정 미리보기';

  @override
  String get seeWhatsInside => '구성 내용 확인하기';

  @override
  String get selectAllThatApply => '해당하는 항목을 모두 선택하세요.';

  @override
  String get siteMap => '부위 맵';

  @override
  String get skipForNow => '나중에 하기';

  @override
  String get socialProofBody => '실제 진행 상황을 추적하는 수천 명과 함께하세요.';

  @override
  String get socialProofTitle => '전 세계 바이오해커들이\n신뢰하는 앱';

  @override
  String get specialOffer => '특별 혜택';

  @override
  String get startFreeTrial => '무료 체험 시작';

  @override
  String get subscribeLabel => '구독하기';

  @override
  String subscribePrice(String price) {
    return '구독하기 — $price/주';
  }

  @override
  String get subscribeToActivate => '구독하고 프로토콜을 활성화하세요';

  @override
  String get subscriptionRenewalDisclaimer =>
      '구독은 현재 기간 종료 최소 24시간 전에 취소하지 않으면 자동으로 갱신됩니다. 설정 > Apple ID > 구독에서 관리할 수 있습니다.';

  @override
  String syringeVolume(String volume) {
    return '1 mL 주사기 기준 $volume mL';
  }

  @override
  String get termsLabel => '이용약관';

  @override
  String get testimonialOne =>
      '이제 투여를 놓치는 일이 없어졌어요. 재구성 계산기 하나만으로도 스프레드시트 계산에 들이던 시간을 크게 아꼈습니다.';

  @override
  String get testimonialThree =>
      '지금까지 써본 것 중 가장 깔끔한 펩타이드 트래커. 진지한 유저를 위해 만든 티가 나요, 실제로 그러니까요.';

  @override
  String get testimonialTwo => '주간 인사이트 덕분에 몇 달간 몰랐던 타이밍 문제를 발견했어요. 완전 게임체인저.';

  @override
  String get thirtyDayAdherence => '30일 순응도';

  @override
  String get threeDayFreeTrial => '3일 무료 체험';

  @override
  String get timelineLabel => '타임라인';

  @override
  String get trackedLabel => '기록됨';

  @override
  String get turnOnReminders => '알림 켜기';

  @override
  String get unitConversionDisclaimer => '단위 변환 도구는 참고용입니다. 반드시 의료 전문가와 확인하세요.';

  @override
  String get unitsLabel => '단위';

  @override
  String get unitsToDraw => '흡입할 단위';

  @override
  String get unlockPepMod => 'PEPMOD 잠금 해제';

  @override
  String get usersLabel => '사용자';

  @override
  String get viewLabel => '보기';

  @override
  String get weekDuration => '주\n기간';

  @override
  String get weekOne => '1주차';

  @override
  String get weeklyLabel => '주간';

  @override
  String weeksCount(int count) {
    return '$count주';
  }

  @override
  String get yearLabel => '연도';

  @override
  String get profileTitle => '프로필';

  @override
  String get signedIn => '로그인됨';

  @override
  String get sectionAccount => '계정';

  @override
  String get sectionPreferences => '환경설정';

  @override
  String get sectionData => '데이터';

  @override
  String get sectionSupport => '지원';

  @override
  String get sectionLegal => '법적 정보';

  @override
  String get sectionAbout => '정보';

  @override
  String get nameLabel => '이름';

  @override
  String get accountLabel => '계정';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get removeAccountData => '계정 및 데이터 삭제';

  @override
  String get metricLabel => '미터법';

  @override
  String get imperialLabel => '야드파운드법';

  @override
  String get notificationsLabel => '알림';

  @override
  String get onLabel => '켜짐';

  @override
  String get offLabel => '꺼짐';

  @override
  String get myCompoundsProfile => '내 화합물';

  @override
  String get savedVialPresets => '저장된 바이알 프리셋';

  @override
  String get exportData => '데이터 내보내기';

  @override
  String get copyAsJson => 'JSON으로 복사';

  @override
  String get clearAllData => '모든 데이터 삭제';

  @override
  String get clearingLabel => '삭제 중…';

  @override
  String get resetApp => '앱 초기화';

  @override
  String get contactSupport => '지원팀 문의';

  @override
  String get chatWithUs => '채팅으로 문의하기';

  @override
  String get termsOfService => '이용약관';

  @override
  String get privacyPolicy => '개인정보처리방침';

  @override
  String get medicalDisclaimer => '의료 관련 고지';

  @override
  String get disclaimerTitle => '고지사항';

  @override
  String get versionLabel => '버전';

  @override
  String get signOutAction => '로그아웃';

  @override
  String get educationalTrackingDisclaimer =>
      '교육 및 기록 목적으로만 제공됩니다. 의료 조언이 아닙니다.';

  @override
  String get yourName => '이름 입력';

  @override
  String get cancelLabel => '취소';

  @override
  String get saveLabel => '저장';

  @override
  String get dataCopied => '데이터가 클립보드에 복사되었습니다.';

  @override
  String get clearDataTitle => '모든 데이터를 삭제할까요?';

  @override
  String get clearDataBody =>
      '모든 프로토콜, 투여 기록, 신체 지표가 삭제되고 온보딩이 다시 시작됩니다. 계정, 구독, 펩타이드 라이브러리는 유지됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get clearLabel => '삭제';

  @override
  String get clearingDataTitle => '데이터 삭제 중…';

  @override
  String get clearingDataBody => '기록 데이터가 삭제되는 동안 PepMod를 열어두세요.';

  @override
  String get clearDataFailed => '데이터를 삭제하지 못했습니다. 연결 상태를 확인하고 다시 시도하세요.';

  @override
  String get allDataCleared => '모든 데이터가 삭제되었습니다.';

  @override
  String get deleteAccountTitle => '계정을 삭제할까요?';

  @override
  String get deleteAccountBody =>
      'PepMod 계정, 설정, 프로토콜, 투여 기록, 신체 지표가 영구적으로 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get deletingAccount => '계정 삭제 중…';

  @override
  String get accountDeletionFailed => '계정 삭제에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get confirmPassword => '비밀번호 확인';

  @override
  String get deleteLabel => '삭제';

  @override
  String get signOutTitle => '로그아웃할까요?';

  @override
  String get signOutBody => '프로토콜은 그대로 저장되며 다시 로그인하면 동기화됩니다.';

  @override
  String get signOutLabel => '로그아웃';

  @override
  String get signOutFailed => '로그아웃에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get notificationsDisabledSystem => '시스템 설정에서 알림이 비활성화되어 있습니다.';

  @override
  String get planPro => 'PRO';

  @override
  String get planFree => '무료';

  @override
  String get termsBody =>
      'PepMod는 교육 및 기록 목적으로만 제공됩니다. 의료 기기가 아니며 의료 조언, 진단, 처방, 치료 권장을 제공하지 않습니다. PepMod를 사용함으로써 귀하는 자신의 기록, 결정, 자격을 갖춘 의료 전문가와의 상담에 대한 책임을 집니다.\n\n구독은 갱신 기간 전에 App Store 또는 Google Play를 통해 취소하지 않는 한 자동으로 갱신됩니다. 환불은 구매한 스토어에서 처리됩니다.\n\n전체 이용약관: https://appstorecopilot.com/legal/yzh32x5v/terms';

  @override
  String get privacyBody =>
      'PepMod는 인증 및 클라우드 데이터 저장에 Firebase를, 구독 관리에 RevenueCat을, 어트리뷰션에 AppRefer와 Meta/Facebook App Events를, 분석 및 진단에 Firebase/Crashlytics를 사용합니다. 당사는 귀하의 개인정보를 판매하지 않습니다. 앱 내에서 계정과 저장된 앱 데이터를 삭제할 수 있습니다.\n\n전체 개인정보처리방침: https://appstorecopilot.com/legal/yzh32x5v/privacy';

  @override
  String get medicalDisclaimerBody =>
      'PepMod는 웰니스 및 기록 도구로, 의료 기기가 아닙니다. 이 앱의 어떤 내용도 의료 조언, 진단, 처방, 치료 권장에 해당하지 않습니다. 라이브러리에 설명된 펩타이드는 교육 목적으로만 제공됩니다. 요법을 시작, 변경, 중단하기 전에는 반드시 자격을 갖춘 의료 전문가와 상담하세요. 이상 반응이 나타나면 즉시 의료 도움을 받으세요.';

  @override
  String get profileSystemLabel => 'SYS.사용자 // 프로필';

  @override
  String get legalSystemLabel => 'SYS.법률';

  @override
  String get progressTitle => '진행 상황';

  @override
  String get progressSystemLabel => 'SYS.진행 // 신체지표';

  @override
  String get doseHistoryTooltip => '투여 기록 열기';

  @override
  String get logMeasurementTooltip => '측정값 기록';

  @override
  String get thirtyDayLabel => '30일';

  @override
  String get adherenceLabel => '순응도';

  @override
  String get streakLabel => '연속 기록';

  @override
  String get daysLabel => '일';

  @override
  String get totalLabel => '누적';

  @override
  String get dosesLabel => '회 투여';

  @override
  String get protocolHistoryLabel => '프로토콜.기록';

  @override
  String get noProtocolsYet => '아직 프로토콜이 없습니다. 프로토콜 탭에서 새로 만들어보세요.';

  @override
  String get adherenceChartLabel => '이행률 // 30일';

  @override
  String get thirtyDaysAgo => '30일 전';

  @override
  String get todayLabel => '오늘';

  @override
  String get noWeightData => '체중 데이터 없음';

  @override
  String get logFirstMeasurement => '첫 측정을 기록하면 여기서 추이를 확인할 수 있어요.';

  @override
  String get logMeasurementAction => '측정 기록';

  @override
  String get weightTrendLabel => '체중 // 추이';

  @override
  String weightKgValue(String weight) {
    return '${weight}kg';
  }

  @override
  String get statusActive => '진행 중';

  @override
  String get statusPaused => '일시중지';

  @override
  String get statusEnded => '종료됨';

  @override
  String protocolPeptideCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '펩타이드 $count개',
      one: '펩타이드 1개',
    );
    return '$_temp0';
  }

  @override
  String get enterOneMetric => '값을 하나 이상 입력하세요.';

  @override
  String get saveMetricFailed => '저장하지 못했습니다. 다시 시도해주세요.';

  @override
  String get newMeasurement => '새 측정';

  @override
  String get weightLabel => '체중';

  @override
  String get bodyFatLabel => '체지방';

  @override
  String get measurementsCmLabel => '측정치 (cm)';

  @override
  String get waistLabel => '허리';

  @override
  String get chestLabel => '가슴';

  @override
  String get armLabel => '팔';

  @override
  String get saveAction => '저장';

  @override
  String get logMetricSystemLabel => '기록.측정';

  @override
  String get activeLastSevenDays => '최근 7일';

  @override
  String get activeAllTime => '전체 기간';

  @override
  String get activeAdherence => '이행률';

  @override
  String get activeStarted => '시작일';

  @override
  String get activeEnded => '종료일';

  @override
  String activeStackCount(int count) {
    return '스택 ($count)';
  }

  @override
  String get activeEditProtocol => '프로토콜 수정';

  @override
  String get activePauseProtocol => '프로토콜 일시중지';

  @override
  String get activeEndProtocol => '프로토콜 종료';

  @override
  String get activeResumeProtocol => '프로토콜 재개';

  @override
  String get activeDeleteProtocol => '프로토콜 삭제';

  @override
  String get activeTrackingDisclaimer =>
      '교육용 기록 도구입니다. 변경 전 반드시 전문 의료인과 상담하세요.';

  @override
  String get activeEndQuestion => '프로토콜을 종료할까요?';

  @override
  String get activeEndBody =>
      '앞으로 예정된 기록은 삭제됩니다. 지난 기록은 이력에 남습니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get activeEndAction => '종료';

  @override
  String get activeDeleteQuestion => '프로토콜을 삭제할까요?';

  @override
  String get activeDeleteBody =>
      '프로토콜과 관련된 모든 기록이 영구적으로 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get activeDeleteAction => '삭제';

  @override
  String get cancel => '취소';

  @override
  String get activeStatusActive => '진행 중';

  @override
  String get activeStatusPaused => '일시중지';

  @override
  String get activeStatusEnded => '종료됨';

  @override
  String get activeNotesLabel => '메모 // 프로토콜';

  @override
  String get activeChangeReminders => '변경 알림';

  @override
  String get activeChangeRemindersBody =>
      '알림이 켜져 있으면 PepMod가 다가오는 단계 변경마다 현지 시간 09:00에 체크포인트를 예약합니다.';

  @override
  String activePhaseAnchor(String date) {
    return '주차 범위는 $date 기준입니다.';
  }

  @override
  String activeWeek(int week) {
    return '$week주차';
  }

  @override
  String activeWeeks(int start, int end) {
    return '$start–$end주차';
  }

  @override
  String get activePerDayAmounts => '일별 양';

  @override
  String get activeBaseAmount => '기본량';

  @override
  String get activeCurrent => '현재';

  @override
  String get activeBaseSchedule => '기본 일정';

  @override
  String get activeCustomDays => '사용자 지정 요일';

  @override
  String get activeContinuousTracking => '연속 기록';

  @override
  String get activeNoFixedCycle => '고정된 주기 없음';

  @override
  String activeCycleProgress(int week, int total) {
    return '$total주 중 $week주차';
  }

  @override
  String activeCycleEnds(String date) {
    return '주기 종료일 $date';
  }

  @override
  String activeRestProgress(int week, int total) {
    return '휴식 $total주 중 $week주차';
  }

  @override
  String activeRestEnds(String date) {
    return '휴식 기간 종료일 $date';
  }

  @override
  String get activeCycleComplete => '주기 완료';

  @override
  String activeCompletedDate(String date) {
    return '$date 완료';
  }

  @override
  String activeRestEnded(String date) {
    return '휴식 기간이 $date에 종료됨';
  }

  @override
  String get activeNoHistory => '일시중지되거나 종료된 프로토콜이 아직 없습니다.';

  @override
  String activeCompoundsCount(int count) {
    return '화합물 $count개';
  }

  @override
  String activeSyringeUnits(String amount) {
    return '$amount 시린지 단위';
  }

  @override
  String activeCycleWeeks(int count) {
    return '$count주 주기';
  }

  @override
  String activeRestWeeks(int count) {
    return '$count주 휴식';
  }

  @override
  String get activePerDraw => '드로우당';

  @override
  String activeVialSummary(String volume) {
    return '${volume}mL 바이알 · U-100';
  }

  @override
  String get addCompound => '화합물 추가';

  @override
  String get addPhase => '단계 추가';

  @override
  String get addTime => '시간 추가';

  @override
  String get addToStack => '스택에 추가';

  @override
  String get amountRequired => '양을 입력하세요';

  @override
  String get baseAmount => '기본량';

  @override
  String get baseSchedule => '기본 일정';

  @override
  String get blendConfigBody =>
      '바이알에 인쇄된 내용을 그대로 입력하세요. PepMod가 드로우 값을 화합물별 스냅샷으로 변환합니다.';

  @override
  String get blendIncompleteError => '화합물 2개 이상, 희석액 부피, 드로우 값을 모두 입력하세요.';

  @override
  String get blendNameHint => '예: 회복 블렌드';

  @override
  String get blendNameLabel => '블렌드 이름';

  @override
  String get blendSafetyDisclaimer =>
      '단위 변환 전용입니다. PepMod는 블렌드, 용량, 빈도, 재구성 방법을 권장하지 않습니다.';

  @override
  String get changeNoteHint => '이 단계에 대한 나만의 메모';

  @override
  String get changeNoteOptional => '변경 메모 (선택)';

  @override
  String colorOption(String hex) {
    return '색상 옵션 $hex';
  }

  @override
  String compoundNumber(int number) {
    return '화합물 $number';
  }

  @override
  String compoundsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '화합물 $count개',
      one: '화합물 1개',
    );
    return '$_temp0';
  }

  @override
  String copiedVialPreset(String amount, String unit) {
    return '$amount $unit 바이알 프리셋 · 이 프로토콜에 복사됨';
  }

  @override
  String get createProtocolAction => '프로토콜 생성';

  @override
  String get createProtocolAddOneError => '펩타이드를 하나 이상 추가하세요.';

  @override
  String createProtocolBuildStep(int step, int total) {
    return '프로토콜 만들기 · $step / $total단계';
  }

  @override
  String get createProtocolDefaultName => '내 프로토콜';

  @override
  String createProtocolEditStep(int step, int total) {
    return '프로토콜 편집 · $step / $total단계';
  }

  @override
  String get createProtocolFreeLimitReason =>
      '무료 플랜은 프로토콜당 펩타이드 1개로 제한됩니다. 여러 화합물을 조합하려면 업그레이드하세요.';

  @override
  String get createProtocolNameBody =>
      '기억하기 쉬운 이름을 지어주세요 — 예: “회복 스택” 또는 “2분기 감량”.';

  @override
  String get createProtocolNameTitle => '프로토콜 이름 짓기';

  @override
  String get createProtocolNoPeptides => '아직 펩타이드가 없습니다';

  @override
  String get createProtocolPickHint => '+를 눌러 라이브러리에서 선택';

  @override
  String get createProtocolReviewBody =>
      '프로토콜 세부 정보를 확인하세요. 관리 화면에서 언제든 수정할 수 있습니다.';

  @override
  String get createProtocolSaveError => '프로토콜 저장에 실패했습니다. 다시 시도하세요.';

  @override
  String get createProtocolStackBody =>
      '펩타이드 하나를 추가하거나 여러 화합물을 조합하세요. 각 라벨, 용량, 빈도, 사이클을 설정하세요.';

  @override
  String get createProtocolStackTitle => '스택 구성하기';

  @override
  String get customBlend => '맞춤 블렌드';

  @override
  String get customDays => '요일 지정';

  @override
  String get customDaysDisclaimer =>
      '선택한 요일만 예정됩니다. 입력한 양은 사용자 기록용 값이며 투여 권고가 아닙니다.';

  @override
  String get customPeptide => '맞춤 펩타이드';

  @override
  String get cycleWeeksLabel => '사이클 주차';

  @override
  String get cycleWindowDisclaimer =>
      '사이클과 휴식 기간은 기록 히스토리를 정리합니다. PepMod는 사이클 기간이 끝난 후 향후 복용을 예약하지 않습니다.';

  @override
  String get defaultAmountLabel => '기본 용량';

  @override
  String get diluentVolumeLabel => '희석액 용량';

  @override
  String get drawExceedsVialError => '드로우 양이 바이알 용량을 초과할 수 없습니다.';

  @override
  String get drawLabel => '드로우';

  @override
  String get drawPreviewLabel => '드로우 미리보기';

  @override
  String drawPreviewValue(String units, String volume) {
    return '$units 단위 = $volume mL';
  }

  @override
  String editTime(String time) {
    return '$time 시간 편집';
  }

  @override
  String get endWeekLabel => '종료 주차';

  @override
  String get enterPeptideName => '펩타이드 이름 입력';

  @override
  String get frequencyLabel => '빈도';

  @override
  String get labelColorBody => '실제로 사용하는 펜이나 바이알 라벨과 이 색상을 맞춰보세요.';

  @override
  String get labelColorLabel => '라벨 색상';

  @override
  String get manageSavedCompounds => '저장된 화합물 관리';

  @override
  String get nextLabel => '다음';

  @override
  String get noneLabel => '없음';

  @override
  String get oneOffCompound => '일회성 화합물';

  @override
  String get oneOffCompoundBody => '프리셋 저장 없이 한 번만 사용';

  @override
  String get optionalLabel => '선택사항';

  @override
  String peptidesCount(int count) {
    return '펩타이드 ($count)';
  }

  @override
  String get perDayAmounts => '일별 용량';

  @override
  String phaseExtendsWarning(int weeks) {
    return '단계가 $weeks주 사이클 범위를 벗어납니다. 단계 또는 사이클 기간을 조정하세요.';
  }

  @override
  String get phaseNameHint => '예: 1주차 기록';

  @override
  String get phaseNameLabel => '단계 이름';

  @override
  String phaseNumber(int number) {
    return '$number단계';
  }

  @override
  String phaseOutsideCycleError(int weeks) {
    return '이 프로토콜 사이클은 $weeks주차 이후 종료됩니다. 단계 주차를 해당 범위 안에 유지하세요.';
  }

  @override
  String get phaseOverlapError => '단계 주차 범위가 겹칠 수 없습니다.';

  @override
  String get phaseOverrideBody =>
      '이미 따르기로 한 기록 일정만 입력하세요. PepMod는 용량을 권고하지 않습니다.';

  @override
  String get phaseOverrideTitle => '주차별 재정의';

  @override
  String get phasePreviewDisclaimer =>
      '입력한 항목만의 미리보기입니다. PepMod가 일정을 권고하지 않습니다.';

  @override
  String get phasePreviewLabel => '단계 미리보기';

  @override
  String get phaseReminderBody =>
      '프로토콜 알림이 활성화되어 있으면 오전 9:00에 중립적인 단계 변경 알림이 예약됩니다.';

  @override
  String get phaseScheduleLabel => '단계 일정';

  @override
  String get phaseSelectDayError =>
      '요일을 하나 이상 선택하세요. PepMod는 일정을 대신 선택하지 않습니다.';

  @override
  String get phasesBody =>
      '선택적 날짜 구간으로 기본 용량과 일정을 재정의할 수 있습니다. 구간 밖에서는 기본 일정이 계속됩니다.';

  @override
  String phasesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 단계',
      one: '1개 단계',
    );
    return '$_temp0';
  }

  @override
  String get phasesDisclaimer =>
      '주차는 프로토콜 시작일부터 계산됩니다. 저장된 단계 메모와 변경 알림은 기록 보조 용도일 뿐입니다.';

  @override
  String get preBlendedVial => '사전 블렌드 바이알';

  @override
  String get preBlendedVialBody => '바이알 하나 · 드로우 한 번 · 여러 화합물';

  @override
  String get protocolNotesBody => '이 프로토콜을 검토할 때 표시할 참고 내용을 저장하세요.';

  @override
  String get protocolNotesHint => '예: 질문, 기록 관련 메모, 임상 담당자 메모';

  @override
  String get protocolNotesLabel => '프로토콜 메모';

  @override
  String get reminderTimesBody => '선택한 각 시간마다 예정된 날짜에 별도의 기록 행과 알림이 생성됩니다.';

  @override
  String get reminderTimesLabel => '알림 시간';

  @override
  String get removeLabel => '제거';

  @override
  String removePeptide(String name) {
    return '$name 제거';
  }

  @override
  String get removePhase => '단계 제거';

  @override
  String removeTime(String time) {
    return '$time 시간 제거';
  }

  @override
  String get restWeeksLabel => '휴식 주차';

  @override
  String get reviewLabel => '검토';

  @override
  String get routeLabel => '투여 경로';

  @override
  String get saveBlend => '블렌드 저장';

  @override
  String get saveChanges => '변경사항 저장';

  @override
  String get savePhase => '단계 저장';

  @override
  String savedVialPreset(String amount, String unit) {
    return '$amount $unit 바이알 · 저장된 프리셋';
  }

  @override
  String get scheduleLabel => '일정';

  @override
  String get searchCompounds => '화합물 검색...';

  @override
  String get selectDayError => '이 펩타이드를 예약할 요일을 하나 이상 선택하세요.';

  @override
  String selectOption(String option) {
    return '$option 선택';
  }

  @override
  String get startDateLabel => '시작일';

  @override
  String get startWeekLabel => '시작 주차';

  @override
  String syringeUnitsAmount(String amount) {
    return '$amount 주사기 단위';
  }

  @override
  String get syringeUnitsDisclaimer => '기록 전용으로 사용하는 선택적 U-100 주사기 눈금 입력값입니다.';

  @override
  String get syringeUnitsHint => '예: 12.5';

  @override
  String get syringeUnitsLabel => '주사기 단위';

  @override
  String get syringeUnitsOptional => '주사기 단위 (선택사항)';

  @override
  String get trackedAmountLabel => '기록된 용량';

  @override
  String get u100TrackingDisclaimer =>
      'U-100 주사기 눈금을 사용합니다 (100단위 = 1mL). 값은 사용자가 직접 입력한 기록 데이터입니다.';

  @override
  String get unitLabel => '단위';

  @override
  String get vialAmountHint => '바이알 용량';

  @override
  String get vialContentsLabel => '바이알 내용물';

  @override
  String get vialLabelNameHint => '바이알 라벨의 이름';

  @override
  String weekNumber(int week) {
    return '$week주차';
  }

  @override
  String weekRange(int start, int end) {
    return '$start–$end주차';
  }

  @override
  String get weekToWeekPhases => '주차별 단계';

  @override
  String weekdayDose(String weekday) {
    return '$weekday 투여';
  }

  @override
  String weekdaySchedule(String weekday) {
    return '$weekday 일정';
  }

  @override
  String get doseDrawInvalid => '흡입량은 0보다 크고 바이알 용량 이내여야 합니다.';

  @override
  String get doseGenericError => '문제가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get doseEditSystemLabel => '편집.투여';

  @override
  String get doseLogSystemLabel => '기록.투여';

  @override
  String get doseDraw => '흡입량';

  @override
  String get doseAmount => '용량';

  @override
  String get doseUnits => '단위';

  @override
  String get doseTime => '시간';

  @override
  String get doseChooseTime => '투여 시간 선택';

  @override
  String get doseBlendSnapshot => '혼합.요약 // 1회.흡입';

  @override
  String doseSyringeUnitsRecorded(String amount) {
    return '이번 투여에 $amount 시린지 단위가 기록되었습니다.';
  }

  @override
  String get doseInjectionSite => '주사.부위';

  @override
  String doseLastSite(String site) {
    return '이 펩타이드의 마지막 부위 · $site';
  }

  @override
  String get doseNotes => '메모';

  @override
  String get doseOptional => '선택 사항...';

  @override
  String get doseMarkPending => '보류로 표시';

  @override
  String get doseSaveChanges => '변경사항 저장';

  @override
  String get doseSkip => '이 투여 건너뛰기';

  @override
  String get doseHistorySystemLabel => '투여.기록 // 30일';

  @override
  String get doseHistoryTitle => '기록된 투여';

  @override
  String get doseHistoryBody => '기록을 탭하면 용량, 실제 시간, 주사 부위, 메모, 상태를 수정할 수 있습니다.';

  @override
  String get doseHistoryEmpty => '최근 30일간 기록된 투여가 없습니다.';

  @override
  String get doseLogPrevious => '이전 투여 기록';

  @override
  String doseHistorySkipped(String dateTime) {
    return '건너뜀 · $dateTime';
  }

  @override
  String doseHistoryTaken(String amount, String units, String dateTime) {
    return '$amount $units · $dateTime';
  }

  @override
  String get doseEditAction => '편집';

  @override
  String get doseChoosePastTime => '기록할 과거 시간을 선택하세요.';

  @override
  String get dosePreviousError => '이전 투여를 기록할 수 없습니다. 다시 시도해 주세요.';

  @override
  String get doseLogPreviousSystemLabel => '이전.기록';

  @override
  String get doseNoPeptides => '사용 가능한 펩타이드 없음';

  @override
  String get doseNoPeptidesBody => '기록을 남기기 전에 활성 프로토콜에 펩타이드를 추가하세요.';

  @override
  String get doseCorrectHistory => '투여 기록 수정';

  @override
  String get dosePeptide => '펩타이드';

  @override
  String get doseDate => '날짜';

  @override
  String get doseChooseDate => '투여 날짜 선택';

  @override
  String doseSyringeUnitsEntry(String amount) {
    return '이 항목에 $amount 시린지 단위가 기록되었습니다.';
  }

  @override
  String get doseHistoryDisclaimer =>
      '기록 로그는 개인 추적용일 뿐입니다. 의학적 지침이나 투여 권장사항을 대체하지 않습니다.';

  @override
  String get notificationChannelName => '투여 알림';

  @override
  String get notificationChannelDescription => '활성 펩타이드 프로토콜 투여를 위한 예약 알림입니다.';

  @override
  String get notificationDoseTitle => '투여 시간입니다';

  @override
  String get notificationDoseBody => '예약된 프로토콜 알림이 준비되었습니다.';

  @override
  String get notificationCycleTitle => '프로토콜 체크포인트';

  @override
  String get notificationCycleBody => '오늘 주기 구간 알림이 예정되어 있습니다. 추적 계획을 확인하세요.';

  @override
  String get notificationRestTitle => '휴식기 체크포인트';

  @override
  String get notificationRestBody => '오늘 휴식기 알림이 예정되어 있습니다. 추적 계획을 확인하세요.';

  @override
  String get notificationPhaseTitle => '프로토콜 단계 체크포인트';

  @override
  String get notificationPhaseBody => '오늘 새로운 추적 단계가 시작됩니다. 저장된 일정을 확인하세요.';

  @override
  String get personalLibrarySystemLabel => 'SYS.라이브러리 // 개인';

  @override
  String get customCompoundIntro =>
      '직접 입력한 라벨과 바이알 용량을 저장하세요. 프리셋은 추적 단축키일 뿐 투여 지침이 아닙니다.';

  @override
  String get archivedHeading => '보관됨';

  @override
  String get activePresetsHeading => '활성 프리셋';

  @override
  String get showActive => '활성 항목 보기';

  @override
  String get archivedAction => '보관됨';

  @override
  String get customCompoundsLoadFailed => '화합물을 불러올 수 없습니다. 다시 시도해 주세요.';

  @override
  String get libraryLoadFailed => '펩타이드 라이브러리를 불러올 수 없습니다. 다시 시도해 주세요.';

  @override
  String compoundVialSummary(String amount, String unit, String route) {
    return '$amount $unit 바이알 · $route';
  }

  @override
  String get editPreset => '프리셋 편집';

  @override
  String get restorePreset => '복원';

  @override
  String get archivePreset => '보관';

  @override
  String get noArchivedPresets => '보관된 프리셋 없음';

  @override
  String get noSavedCompounds => '저장된 화합물 없음';

  @override
  String get archivedPresetsHint => '보관된 프리셋은 복원할 때까지 여기에 남아 있습니다.';

  @override
  String get createPresetHint => '재사용 가능한 라벨과 바이알 용량 프리셋을 만드세요.';

  @override
  String get presetCompoundSystemLabel => '프리셋.화합물';

  @override
  String get newCompound => '새 화합물';

  @override
  String get editCompound => '화합물 편집';

  @override
  String get ownVialDetailsHint => '본인 바이알에 인쇄된 정보만 입력하세요.';

  @override
  String get compoundLabel => '화합물 라벨';

  @override
  String get compoundNameExample => '예: 내 화합물';

  @override
  String get vialUnitLabel => '바이알 단위';

  @override
  String get trackingUnitLabel => '추적 단위';

  @override
  String get notesOptional => '메모 (선택)';

  @override
  String get compoundNoteExample => '라벨 또는 보관 메모';

  @override
  String get noDoseRecommendation =>
      '투여 권장사항은 생성되지 않습니다. 프로토콜 용량은 항상 사용자가 직접 별도로 입력합니다.';

  @override
  String get saveCompoundFailed => '프리셋을 저장할 수 없습니다. 다시 시도해 주세요.';

  @override
  String get routeTopical => '국소';

  @override
  String get frequencyCustomDays => '사용자 지정 요일';

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
    return '$desiredAmount $desiredUnit · $capacity단위';
  }

  @override
  String syringeOption(String volume, String capacity) {
    return 'U-100 · $volume mL / $capacity단위';
  }
}
