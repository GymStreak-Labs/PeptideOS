// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get libraryTitle => 'ライブラリ';

  @override
  String get languageLabel => '言語';

  @override
  String get languageSystemDefault => 'システム設定';

  @override
  String get selectLanguageTitle => 'アプリの言語を選択';

  @override
  String get librarySystemLabel => 'SYS.データベース // 化合物';

  @override
  String get myCompounds => 'マイ化合物';

  @override
  String get unitConverter => '単位換算';

  @override
  String get openUnitConverter => '単位換算を開く';

  @override
  String get converterCardTitle => '単位換算';

  @override
  String get converterCardSubtitle => 'バイアルの数値を今すぐ換算';

  @override
  String get converterCardHint => '再溶解計算は、下のペプチドをタップしてください。';

  @override
  String get searchPeptides => 'ペプチドを検索...';

  @override
  String get categoryAll => 'すべて';

  @override
  String get categoryHealing => '回復';

  @override
  String get categoryGrowthHormone => '成長ホルモン';

  @override
  String get categoryCognitive => '認知機能';

  @override
  String get categoryMetabolic => '代謝';

  @override
  String get categoryAesthetic => '美容';

  @override
  String get categoryLongevity => '長寿';

  @override
  String get categoryOther => 'その他';

  @override
  String get libraryUnavailable => 'ライブラリを利用できません';

  @override
  String get retry => '再試行';

  @override
  String get noPeptidesFound => 'ペプチドが見つかりません';

  @override
  String get tryDifferentSearch => '別の検索語を試すか、フィルターを解除してください。';

  @override
  String get calculationSaved => 'このアカウントに計算を保存しました。';

  @override
  String get converterIntro =>
      'ご自身のバイアル、希釈液、計画に記載された値を入力してください。PepModがその値を容量とU-100シリンジの単位に換算します。';

  @override
  String get vialAndDiluent => 'バイアル + 希釈液';

  @override
  String get iuSourceCaption => '参照元：バイアルに記載されたIUと、加えた希釈液のmL。';

  @override
  String get massSourceCaption => '参照元：バイアルと希釈液のラベル。';

  @override
  String get vialAmount => 'バイアルの量';

  @override
  String get amountPrintedOnVial => 'バイアルに記載された量';

  @override
  String get diluent => '希釈液';

  @override
  String get volumeAdded => '加えた容量';

  @override
  String get amountToConvert => '換算する量';

  @override
  String get iuAmountCaption => 'すでに指定されているIUの量を入力してください。';

  @override
  String get massAmountCaption => '参照元：すでに指定されている量。';

  @override
  String get yourSyringe => '使用するシリンジ';

  @override
  String get syringeCaption => '本体に記載された容量を選択してください。';

  @override
  String get educationalConverterDisclaimer =>
      '教育目的の単位換算ツールです。PepModは量や頻度を推奨しません。使用前に元のラベルを再確認し、資格を持つ医療専門家に計算をご確認ください。';

  @override
  String get back => '戻る';

  @override
  String get vialWorkspace => 'バイアル換算';

  @override
  String get conversionSystemLabel => 'ツール.換算';

  @override
  String get measurementModeSystemLabel => '測定.モード';

  @override
  String get conversionResultSystemLabel => '換算.結果';

  @override
  String get savedVialsSystemLabel => '保存済み.バイアル';

  @override
  String get clear => 'クリア';

  @override
  String get conversionOnly => '換算専用 — この画面では量やスケジュールを決定しません。';

  @override
  String get sameUnitFamily => 'バイアルに記載されたものと同じ単位系を使用してください。';

  @override
  String get mass => '質量';

  @override
  String get iuOnly => 'IUのみ';

  @override
  String get iuSafety => 'IUはIUのまま扱います。PepModはIUをmg/mcgに、またはmg/mcgをIUに換算しません。';

  @override
  String get enterAmount => '量を入力';

  @override
  String get drawTo => '合わせる目盛り';

  @override
  String get units => '単位';

  @override
  String get concentration => '濃度';

  @override
  String get syringeCapacity => 'シリンジ容量';

  @override
  String get capacityWarning =>
      '換算後の容量がこのシリンジの容量を超えています。正しいシリンジを選ぶか、入力内容を再確認してください。';

  @override
  String get savePreset => 'プリセットを保存';

  @override
  String get savedVialsHint => '保存した計算をタップすると、入力値を再利用できます。';

  @override
  String get removeSavedCalculation => '保存した計算を削除';

  @override
  String get errorPositiveNumbers => 'すべての欄に0より大きい数値を入力してください。';

  @override
  String get errorAmountAboveVial => '希望する量が、このバイアルに入力した量を超えています。';

  @override
  String get errorConversion => 'この値は換算できませんでした。各入力内容を再確認してください。';

  @override
  String get halfLife => '半減期';

  @override
  String get weekCycle => '週サイクル';

  @override
  String get typicalDose => '一般的な用量';

  @override
  String get notes => 'メモ';

  @override
  String get commonStack => '一般的な組み合わせ';

  @override
  String get reconstitutionTool => 'ツール.再溶解';

  @override
  String get compoundSystemLabel => 'DB.化合物';

  @override
  String get addToProtocol => 'プロトコルに追加';

  @override
  String get vialShort => 'バイアル (mg)';

  @override
  String get bacShort => 'BAC (mL)';

  @override
  String get doseShort => '量 (mcg)';

  @override
  String get routeSubcutaneous => '皮下';

  @override
  String get routeIntramuscular => '筋肉内';

  @override
  String get routeOral => '経口';

  @override
  String get routeNasal => '経鼻';

  @override
  String get frequencyDaily => '毎日';

  @override
  String get frequencyEveryOtherDay => '1日おき';

  @override
  String get frequencyTwiceWeekly => '週2回';

  @override
  String get frequencyWeekly => '毎週';

  @override
  String get frequencyAsNeeded => '必要に応じて';

  @override
  String get tabProtocol => 'プロトコル';

  @override
  String get tabProgress => '経過';

  @override
  String get tabLibrary => 'ライブラリ';

  @override
  String get tabYou => 'あなた';

  @override
  String get continueLabel => '続ける';

  @override
  String get processingLabel => '処理中…';

  @override
  String get authAppleFailed => 'Appleサインインに失敗しました。もう一度お試しください。';

  @override
  String get authGoogleFailed => 'Googleサインインに失敗しました。もう一度お試しください。';

  @override
  String get authGenericError => '問題が発生しました。もう一度お試しください。';

  @override
  String get authUserNotFound => 'このメールアドレスのユーザーが見つかりません。';

  @override
  String get authIncorrectCredentials => 'メールアドレスまたはパスワードが正しくありません。';

  @override
  String get authAccountExists => 'このメールアドレスのアカウントは既に存在します。';

  @override
  String get authWeakPassword => 'パスワードが脆弱です。6文字以上で入力してください。';

  @override
  String get authInvalidEmail => 'メールアドレスが無効です。';

  @override
  String get authAppleUnavailable => 'このアプリではApple IDでのサインインは利用できません。';

  @override
  String get authRequiredTitle => 'あなた専用のプロトコルを\n保存しましょう';

  @override
  String get authRequiredBody =>
      'プロトコルが解放される前に、ロードマップ、スケジュール、投与ログ、リマインダーをアカウントに紐づけて保存しましょう。';

  @override
  String get continueWithEmail => 'メールで続ける';

  @override
  String get signInWithApple => 'APPLEでサインイン';

  @override
  String get continueWithGoogle => 'GOOGLEで続ける';

  @override
  String get authTermsDisclaimer =>
      '続行することで利用規約とプライバシーポリシーに同意したことになります。PepModは教育目的のツールであり、医療アドバイスではありません。';

  @override
  String get signIn => 'サインイン';

  @override
  String get createAccount => 'アカウント作成';

  @override
  String get resetPassword => 'パスワードを再設定';

  @override
  String get signInAction => 'サインイン';

  @override
  String get createAccountAction => 'アカウントを作成';

  @override
  String get sendResetLink => '再設定リンクを送信';

  @override
  String get passwordResetSent => 'パスワード再設定メールを送信しました。受信ボックスをご確認ください。';

  @override
  String get enterEmail => 'メールアドレスを入力';

  @override
  String get enterValidEmail => '有効なメールアドレスを入力してください';

  @override
  String get enterPassword => 'パスワードを入力';

  @override
  String get passwordMinLength => '6文字以上';

  @override
  String get forgotPassword => 'パスワードをお忘れですか？';

  @override
  String get alreadyHaveAccount => 'アカウントをお持ちの方はサインイン';

  @override
  String get backToSignIn => 'サインインに戻る';

  @override
  String get emailLabel => 'メールアドレス';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get showPassword => 'パスワードを表示';

  @override
  String get hidePassword => 'パスワードを隠す';

  @override
  String get accountDeletedTitle => 'アカウントを削除しました';

  @override
  String get accountDeletedBody => 'PepModアカウントと保存されたアプリデータは削除されました。';

  @override
  String get subscriptionUnavailable =>
      '現在サブスクリプションプランをご利用いただけません。もう一度お試しください。';

  @override
  String get upgradeUnavailable => '現在アップグレードをご利用いただけません。後でもう一度お試しください。';

  @override
  String get noPurchasesToRestore => '復元できる購入履歴が見つかりません。';

  @override
  String get subscriptionErrorServiceUnavailable =>
      '購入機能は一時的に利用できません。しばらくしてからもう一度お試しください。';

  @override
  String get subscriptionErrorPlansUnavailable =>
      'サブスクリプションプランを読み込めません。通信状態を確認して、もう一度お試しください。';

  @override
  String get subscriptionErrorPurchaseCancelled => '購入をキャンセルしました。';

  @override
  String get subscriptionErrorPurchaseNotAllowed => 'このデバイスでは購入が許可されていません。';

  @override
  String get subscriptionErrorPurchaseInvalid =>
      '購入を完了できませんでした。アカウントを確認して、もう一度お試しください。';

  @override
  String get subscriptionErrorProductUnavailable =>
      'このサブスクリプションは現在ご利用いただけません。別のプランを選択するか、後でもう一度お試しください。';

  @override
  String get subscriptionErrorNetwork => 'オフラインです。接続を確認して、もう一度試してください。';

  @override
  String get subscriptionErrorPurchaseFailed => '購入に失敗しました。もう一度試してください。';

  @override
  String get subscriptionErrorRestoreFailed =>
      '購入を復元できませんでした。接続を確認して、もう一度試してください。';

  @override
  String get unlockFullProtocol => 'フルプロトコルを解放';

  @override
  String get premiumUnlimitedPeptides => 'プロトコルごとにペプチドを無制限に追加';

  @override
  String get premiumMultipleProtocols => '複数のプロトコルを同時に管理';

  @override
  String get premiumCalculator => '希釈計算ツール（全ペプチド対応）';

  @override
  String get premiumMetrics => '体組成トラッキング＋グラフ';

  @override
  String get upgradeNow => '今すぐアップグレード';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get notRightNow => '今はしない';

  @override
  String get protocolWeeklyPlanner => '週間プランナー';

  @override
  String get protocolDoseHistory => '投与履歴';

  @override
  String get protocolCreate => 'プロトコルを作成';

  @override
  String get protocolManage => '管理';

  @override
  String get protocolYourProtocol => 'あなたのプロトコル';

  @override
  String get protocolNoActive => '有効なプロトコルがありません';

  @override
  String get protocolNoActiveBody =>
      '最初のプロトコルを作成して、投与のトラッキングとアドヒアランスの記録を始めましょう。';

  @override
  String get protocolStartFirst => '最初のプロトコルを開始';

  @override
  String get protocolScheduleTodaySystemLabel => 'スケジュール // 今日';

  @override
  String get protocolAdherenceTodaySystemLabel => '遵守率 // 今日';

  @override
  String get protocolNoDosesScheduledToday => '本日予定されている投与はありません';

  @override
  String protocolDosesTaken(int taken, int total) {
    return '$total回中$taken回の投与を完了';
  }

  @override
  String get protocolNextDose => '次回の投与';

  @override
  String protocolInTime(String duration) {
    return 'あと$duration';
  }

  @override
  String protocolDurationHoursMinutes(int hours, int minutes) {
    return '$hours時間$minutes分';
  }

  @override
  String protocolDurationMinutes(int minutes) {
    return '$minutes分';
  }

  @override
  String get protocolLogDose => '投与を記録';

  @override
  String get protocolNow => '今';

  @override
  String get protocolMissed => '未実施';

  @override
  String get protocolSkipped => 'スキップ済み';

  @override
  String get plannerTaken => '記録済み・タップして編集';

  @override
  String get protocolNoDosesToday => '本日の投与はありません';

  @override
  String get protocolNoDosesTodayBody => '本日はプロトコルに予定されている投与がありません。';

  @override
  String get protocolFreeLimit =>
      '無料プランではプロトコルを1つまで作成できます。複数のスタックを同時に運用するにはPremiumにアップグレードしてください。';

  @override
  String protocolSyringeUnitsSuffix(String amount) {
    return ' ・ $amountシリンジ単位';
  }

  @override
  String get injectionSiteLeftAbdomen => '左腹部';

  @override
  String get injectionSiteRightAbdomen => '右腹部';

  @override
  String get injectionSiteLeftThigh => '左大腿';

  @override
  String get injectionSiteRightThigh => '右大腿';

  @override
  String get injectionSiteLeftGlute => '左臀部';

  @override
  String get injectionSiteRightGlute => '右臀部';

  @override
  String get injectionSiteLeftTriceps => '左上腕三頭筋';

  @override
  String get injectionSiteRightTriceps => '右上腕三頭筋';

  @override
  String get injectionSiteLeftDeltoid => '左三角筋';

  @override
  String get injectionSiteRightDeltoid => '右三角筋';

  @override
  String get plannerToday => '本日';

  @override
  String get plannerBack => '戻る';

  @override
  String get plannerPreviousWeek => '前の週';

  @override
  String get plannerNextWeek => '次の週';

  @override
  String plannerScheduledCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '予定されている投与 $count 件',
      one: '予定されている投与 $count 件',
    );
    return '$_temp0';
  }

  @override
  String get plannerTrackingDisclaimer =>
      'これは記録専用です。このカレンダーは保存されたプロトコルを反映するものであり、投与に関する助言を提供するものではありません。';

  @override
  String get plannerWashoutPeriod => '休薬期間';

  @override
  String plannerWashoutUntil(String date) {
    return '$dateまで休薬';
  }

  @override
  String get plannerNoScheduledDoses => '予定されている投与はありません';

  @override
  String get plannerNothingPlanned => '保存されたプロトコルには予定がありません。';

  @override
  String get activatePro => 'PROを有効化';

  @override
  String activateProPrice(String price) {
    return 'PROを有効化 — $price/年';
  }

  @override
  String get annualAccess => '年間アクセス';

  @override
  String get annualLabel => '年間';

  @override
  String get averageRating => '平均評価';

  @override
  String get bacWaterLabel => '静菌水';

  @override
  String get basedOnInputs => '入力内容に基づく //';

  @override
  String get bestValue => 'ベストバリュー';

  @override
  String get birthDateInvalid => '18歳以上になる有効な日付を入力してください。';

  @override
  String get birthDateValid => '年齢確認済み';

  @override
  String calculatorDemoBody(String peptideName) {
    return '$peptideNameを例にした使い方はこちら';
  }

  @override
  String get calculatorDemoResult => 'これだけです。数値を入力すれば、\n正確なシリンジ単位がわかります。';

  @override
  String get calculatorDemoTitle => 'もう、\n難しい計算はいりません。';

  @override
  String get confidenceCycleTiming => 'サイクルタイミング';

  @override
  String get confidenceCycleTimingDetail => 'プロトコルの日程とスケジュール期間を明確に確認';

  @override
  String get confidenceDoseMath => '投与量計算';

  @override
  String get confidenceDoseMathDetail => 'バイアル・希釈水・投与量・吸引単位をまとめて管理';

  @override
  String get confidenceLabel => '信頼度';

  @override
  String get confidencePlainInfo => 'わかりやすい情報';

  @override
  String get confidencePlainInfoDetail => '余計な情報を省いて研究メモを読む';

  @override
  String get confidenceProgressSignals => '進捗シグナル';

  @override
  String get confidenceProgressSignalsDetail => 'アドヒアランスと身体指標の推移を確認';

  @override
  String get confidenceSafetyFraming => '安全性の枠組み';

  @override
  String get confidenceSafetyFramingDetail => '教育的ガイダンスと免責事項を常に表示';

  @override
  String get confidenceSiteRotation => '注射部位ローテーション';

  @override
  String get confidenceSiteRotationDetail => '各投与の記録部位を記憶';

  @override
  String get connectingToStore => 'ストアに接続中...';

  @override
  String continueSelected(int count) {
    return '続ける ($count)';
  }

  @override
  String get customProtocol => 'カスタムプロトコル';

  @override
  String get dateOfBirthLabel => '生年月日';

  @override
  String get dayOne => '1日目';

  @override
  String get dayShortLabel => 'DD';

  @override
  String get defaultConfidence => '投与量計算・注射部位ローテーション';

  @override
  String get defaultFrustration => '投与忘れ';

  @override
  String get defaultGoals => '回復・長寿';

  @override
  String get doseLabel => '投与量';

  @override
  String get dosesLogged => '記録した投与回数';

  @override
  String get dosesPerDay => '1日の投与回数';

  @override
  String get drawVolumeLabel => '吸引量';

  @override
  String get durationLabel => '期間';

  @override
  String get experienceAdvanced => '上級';

  @override
  String get experienceAdvancedDetail => '詳細なプロトコル管理に慣れています';

  @override
  String get experienceFirstTime => '初めて';

  @override
  String get experienceFirstTimeDetail => 'ペプチド記録は初めてです';

  @override
  String get experienceIntermediate => '中級';

  @override
  String get experienceLabel => '経験レベル';

  @override
  String get experienceNovice => '初心者';

  @override
  String get experienceSome => '多少経験あり';

  @override
  String get experienceSomeDetail => '1〜2件のプロトコルを記録したことがあります';

  @override
  String get experienceVeteran => '熟練者';

  @override
  String get featureDoseMathBody =>
      'バイアルサイズ、希釈水量、投与量、吸引単位を、実際に記録中のプロトコルと並べて確認できます。';

  @override
  String get featureDoseMathTitle => '投与量計算を\n文脈の中で';

  @override
  String get featureProtocolArcBody =>
      '予定投与、記録済み投与、アドヒアランス、身体指標が1つのタイムラインにまとまります。';

  @override
  String get featureProtocolArcTitle => 'プロトコルの推移を\n時系列で';

  @override
  String get featureShowcaseTitle => '必要なものすべてが\n1つのアプリに。';

  @override
  String get featureSiteRotationBody => '記録したすべての部位を記憶し、ローテーション履歴を投与記録に紐づけます。';

  @override
  String get featureSiteRotationTitle => '注射部位の\nローテーション';

  @override
  String get firstNameExample => '例：あかり';

  @override
  String get firstNameLabel => '名前';

  @override
  String get frustrationForgetting => '投与を忘れる';

  @override
  String get frustrationLabel => '悩み';

  @override
  String get frustrationMath => 'バイアルとシリンジの計算';

  @override
  String get frustrationProgress => '継続できているか把握できない';

  @override
  String get frustrationSchedule => 'スケジュール管理が大変';

  @override
  String get frustrationStacking => '複数のペプチドの管理';

  @override
  String get frustrationTrust => '信頼できる情報を見つけること';

  @override
  String get goalAntiAging => '健康的なエイジング';

  @override
  String get goalAntiAgingDetail => '長寿を意識した記録を整理';

  @override
  String get goalCognitive => '認知機能サポート';

  @override
  String get goalCognitiveDetail => '集中力とメンタルパフォーマンスをモニタリング';

  @override
  String get goalImmune => '免疫サポート';

  @override
  String get goalImmuneDetail => '免疫サポート向けプロトコルを整理';

  @override
  String get goalMuscleGrowth => '筋肉増強';

  @override
  String get goalMuscleGrowthDetail => 'トレーニングと成長の目標を記録';

  @override
  String get goalOther => 'その他';

  @override
  String get goalOtherDetail => '別の記録目標を設定';

  @override
  String get goalRecovery => '回復';

  @override
  String get goalRecoveryDetail => '回復記録とルーティンをサポート';

  @override
  String get goalSleep => '睡眠';

  @override
  String get goalSleepDetail => '睡眠に関する目標とパターンを記録';

  @override
  String get goalWeightLoss => '減量';

  @override
  String get goalWeightLossDetail => '代謝目標と進捗を記録';

  @override
  String get goalsLabel => '目標';

  @override
  String get iUnderstand => '理解しました';

  @override
  String get lastThreeDaysAgo => '前回：3日前';

  @override
  String get leftAbdomen => '左腹部';

  @override
  String get loveIt => '気に入っている';

  @override
  String get maybeLater => '後で';

  @override
  String get monthOne => '1ヶ月目';

  @override
  String get monthShortLabel => 'MM';

  @override
  String get monthTwo => '2ヶ月目';

  @override
  String moreCount(String shown, int count) {
    return '$shown 他$count件';
  }

  @override
  String get needsWork => '要改善';

  @override
  String get notificationBody =>
      '予定されたプロトコルの時間になると、控えめなリマインダーが届きます。通知にペプチド名は表示されず、そっと知らせるだけです。';

  @override
  String get notificationTitle => '投与時間を\n見える化。';

  @override
  String get nowLabel => 'たった今';

  @override
  String get ok => 'OK';

  @override
  String get onboardingAgeConfirmed => '18歳以上です';

  @override
  String get onboardingAgeRequirementBody => 'PepModを利用するには18歳以上である必要があります。';

  @override
  String get onboardingAgeRequirementTitle => '年齢要件';

  @override
  String get onboardingAgeVerificationBody => 'PepModは18歳以上の成人を対象としています。';

  @override
  String get onboardingAgeVerificationTitle => 'まず、\n年齢を確認します。';

  @override
  String get onboardingAheadBody =>
      'いくつかの質問に答えると、PepModがパーソナライズされた記録プレビューを用意します。';

  @override
  String get onboardingAheadTitle => '始める前に\nプロトコルを確認';

  @override
  String get onboardingBirthDateBody => '年齢要件の確認に使用します。';

  @override
  String get onboardingBirthDateTitle => '生年月日を\n教えてください';

  @override
  String get onboardingConfidenceBody => 'PepModにもっと明確にしてほしいことを選んでください。';

  @override
  String get onboardingConfidenceTitle => 'どこにもっと\n自信を持ちたいですか?';

  @override
  String get onboardingConversionValueBody => 'バイアルとプランの数値を、容量とシリンジ単位に変換します。';

  @override
  String get onboardingConversionValueTitle => 'バイアル計算を\nもっと確認しやすく';

  @override
  String get onboardingDisclaimerBody =>
      'PepModは記録・リマインダー・単位換算の整理をサポートします。診断・処方、専門家によるアドバイスの代わりにはなりません。';

  @override
  String get onboardingDisclaimerTitle => '明確さのために。\n処方のためではありません。';

  @override
  String get onboardingExperienceTitle => '経験レベルは\nどのくらいですか?';

  @override
  String get onboardingFrustrationBody => '一番のストレスポイントを選んでください。';

  @override
  String get onboardingFrustrationTitle => '今、一番\n大変なことは?';

  @override
  String get onboardingGoalsTitle => '主な目標は\n何ですか?';

  @override
  String get onboardingGuidedStartBody => 'あなたの目標、経験、そして残したい記録に合わせてセットアップします。';

  @override
  String get onboardingGuidedStartTitle => 'あなたに合わせた、\nガイド付きスタート';

  @override
  String get onboardingHookAnswer => 'PepModなら答えをプロトコルのそばに保持できます。';

  @override
  String get onboardingHookQuestion => '何単位\n引きますか?';

  @override
  String get onboardingHookResearch => 'リサーチライブラリ';

  @override
  String get onboardingHookSources => '根拠付きソース';

  @override
  String get onboardingHookVial => 'バイアル + 希釈液';

  @override
  String get onboardingNameBody => 'PepModをあなた向けにパーソナライズするために使用します。';

  @override
  String get onboardingNameTitle => '何とお呼び\nすればいいですか?';

  @override
  String get onboardingPeptideSelectBody => '使用中、または注目しておきたいペプチドを選んでください。';

  @override
  String get onboardingPeptideSelectTitle => '何を\n記録していますか?';

  @override
  String get onboardingProgressValueBody =>
      'アドヒアランス、投与履歴、身体データを一つの明確な記録にまとめます。';

  @override
  String get onboardingProgressValueTitle => '全体の流れを\n時系列で確認';

  @override
  String get onboardingProtocolValueBody =>
      'スケジュールを計画し、投与を記録し、詳細を各プロトコルに紐づけて管理します。';

  @override
  String get onboardingProtocolValueTitle => 'すべてのプロトコルを\n一箇所で管理';

  @override
  String get onboardingUnder18 => '18歳未満です';

  @override
  String get openingPermission => '権限を確認中...';

  @override
  String get paywallArcBody => '計画したこと、記録したこと、次にもっと整理すべきことを確認できます。';

  @override
  String get paywallArcTitle => '経過を時系列で確認';

  @override
  String get paywallBody => '投与計算、部位ローテーション、リマインダー、プロトコル履歴 — すべてを一つの記録に。';

  @override
  String get paywallDoseMathBody => 'バイアル・水・投与量・引く単位をまとめて管理し、記録を確認しやすくします。';

  @override
  String get paywallDoseMathTitle => '投与計算を正確に';

  @override
  String get paywallPreviewDisclaimer =>
      '記録・リマインダー・単位の明確化のためのアプリです。医療アドバイスではありません。';

  @override
  String get paywallRotationBody => 'すべての部位、サイクル、リマインダーがプロトコル記録に紐づいたままになります。';

  @override
  String get paywallRotationTitle => 'ローテーションを見失わない';

  @override
  String get paywallTitle => 'プロトコル管理に\n必要なすべて';

  @override
  String get paywallValueNote =>
      'バイアル計算を間違えると、時間や製品を無駄にすることがあります。PepModなら計算を記録のそばに保持できるので、古いメモをもとに行動する前に記録を確認し直せます。';

  @override
  String get peptideLabel => 'ペプチド';

  @override
  String get peptidesLabel => 'ペプチド';

  @override
  String get peptidesTracked => '記録した\nペプチド数';

  @override
  String get perWeek => '/週';

  @override
  String get perYear => '/年';

  @override
  String get privacyLabel => 'プライバシー';

  @override
  String processingGoals(int count) {
    return '$count件の目標を分析中...';
  }

  @override
  String processingPeptides(int count) {
    return '$count件のペプチド記録をリンク中...';
  }

  @override
  String get processingProtocol => 'プロトコルを構築中...';

  @override
  String get processingSchedule => 'スケジュールを整理中...';

  @override
  String get processingTitle => 'プロトコルを\n構築しています';

  @override
  String get progressLabel => '進捗';

  @override
  String get protocolClarity => 'プロトコルの明確さ';

  @override
  String get protocolIncludes => 'あなたのプロトコル内容 //';

  @override
  String get protocolPreviewTitle => 'プロトコルの\n準備ができました';

  @override
  String get protocolReady => 'プロトコル準備完了 //';

  @override
  String get protocolReminderReady => 'プロトコルリマインダーの準備ができました';

  @override
  String get protocolReservedFor => 'パーソナライズされたプロトコルを確保中';

  @override
  String get restorePurchase => '購入を復元';

  @override
  String get resultsSummaryBody =>
      'データが蓄積されるにつれ、投与記録・再構成計算・トレンド記録をひとつにまとめていきます。';

  @override
  String get reviewGateBody => 'あなたのフィードバックは、すべてのバイオハッカーのためのプラットフォーム改善に役立ちます。';

  @override
  String get reviewGateTitle => 'PepModは\nいかがですか?';

  @override
  String roadmapBody(int count, String need) {
    return '記録中の$count件のペプチドと、$needへのニーズに合わせて構成されています。';
  }

  @override
  String get roadmapDayOneBody => 'ペプチド、投与記録、部位ローテーション、リマインダーの準備が整いました。';

  @override
  String get roadmapDayOneTitle => '最初のプロトコルが整理されました';

  @override
  String get roadmapDisclaimer =>
      'PepModは記録とリマインダーの整理をサポートします。処方・診断、または臨床専門家によるアドバイスの代わりにはなりません。';

  @override
  String get roadmapMonthOneBody => 'アドヒアランス、投与漏れ、身体データがより明確な記録として形になり始めます。';

  @override
  String get roadmapMonthOneTitle => '継続履歴が形になっていきます';

  @override
  String get roadmapMonthTwoBody => '計画したこと、実際に起きたこと、注意が必要な記録が見えるようになります。';

  @override
  String get roadmapMonthTwoTitle => 'プロトコル全体の流れが見えるようになります';

  @override
  String get roadmapTitle => 'この先に\n待っていること';

  @override
  String get roadmapWeekOneBody => '平易な言葉によるリサーチと記録メモがプランに紐づいたままになります。';

  @override
  String roadmapWeekOneTitle(String goal) {
    return '$goalを中心にライブラリが充実していきます';
  }

  @override
  String savePercent(int percent) {
    return '$percent%お得';
  }

  @override
  String get saveRoadmap => 'このロードマップを保存';

  @override
  String get schedulePreview => 'スケジュールプレビュー';

  @override
  String get seeWhatsInside => '中身を見る';

  @override
  String get selectAllThatApply => '当てはまるものをすべて選んでください。';

  @override
  String get siteMap => '部位マップ';

  @override
  String get skipForNow => '今はスキップ';

  @override
  String get socialProofBody => '実際の進捗を記録する数千人の仲間に参加しましょう。';

  @override
  String get socialProofTitle => '世界中のバイオハッカーに\n選ばれています';

  @override
  String get specialOffer => '特別オファー';

  @override
  String get startFreeTrial => '無料トライアルを開始';

  @override
  String get subscribeLabel => '登録する';

  @override
  String subscribePrice(String price) {
    return '登録する — $price/週';
  }

  @override
  String subscribeAnnualPrice(String price) {
    return '登録する — $price/年';
  }

  @override
  String get subscribeToActivate => '登録してプロトコルを有効化';

  @override
  String get subscriptionRenewalDisclaimer =>
      'サブスクリプションは、現在の期間終了の24時間前までにキャンセルしない限り自動更新されます。設定 > Apple ID > サブスクリプションから管理できます。';

  @override
  String syringeVolume(String volume) {
    return '1 mLシリンジでは$volume mL';
  }

  @override
  String get termsLabel => '利用規約';

  @override
  String get testimonialOne =>
      '投与忘れがついになくなりました。再構成計算機だけでもスプレッドシート計算の何時間分もの時間を節約できました。';

  @override
  String get testimonialThree =>
      '今まで使った中で一番洗練されたペプチドトラッカー。本格的なユーザー向けに作られている、まさにその通りに。';

  @override
  String get testimonialTwo =>
      '週次インサイトが数か月気づかなかったタイミングの問題を見つけてくれた。まさにゲームチェンジャー。';

  @override
  String get thirtyDayAdherence => '30日間のアドヒアランス';

  @override
  String get timelineLabel => 'タイムライン';

  @override
  String get trackedLabel => '記録済み';

  @override
  String get turnOnReminders => 'リマインダーをオンにする';

  @override
  String get unitConversionDisclaimer =>
      '単位換算ツールは参考情報のみを目的としています。必ず医療従事者にご確認ください。';

  @override
  String get unitsLabel => '単位';

  @override
  String get unitsToDraw => '吸引する単位数';

  @override
  String get unlockPepMod => 'PEPMODをアンロック';

  @override
  String get usersLabel => 'ユーザー';

  @override
  String get viewLabel => '表示';

  @override
  String get weekDuration => '週間\n期間';

  @override
  String get weekOne => '第1週';

  @override
  String get weeklyLabel => '週次';

  @override
  String weeksCount(int count) {
    return '$count週間';
  }

  @override
  String get yearLabel => '年';

  @override
  String get profileTitle => 'マイページ';

  @override
  String get signedIn => 'サインイン済み';

  @override
  String get sectionAccount => 'アカウント';

  @override
  String get sectionPreferences => '環境設定';

  @override
  String get sectionData => 'データ';

  @override
  String get sectionSupport => 'サポート';

  @override
  String get sectionLegal => '法的情報';

  @override
  String get sectionAbout => 'アプリについて';

  @override
  String get nameLabel => '名前';

  @override
  String get accountLabel => 'アカウント';

  @override
  String get deleteAccount => 'アカウントを削除';

  @override
  String get removeAccountData => 'アカウントとデータを削除';

  @override
  String get metricLabel => 'メートル法';

  @override
  String get imperialLabel => 'ヤード・ポンド法';

  @override
  String get notificationsLabel => '通知';

  @override
  String get onLabel => 'オン';

  @override
  String get offLabel => 'オフ';

  @override
  String get myCompoundsProfile => 'マイ化合物';

  @override
  String get savedVialPresets => '保存済みバイアルプリセット';

  @override
  String get exportData => 'データをエクスポート';

  @override
  String get copyAsJson => 'JSONとしてコピー';

  @override
  String get clearAllData => 'すべてのデータを消去';

  @override
  String get clearingLabel => '消去中…';

  @override
  String get resetApp => 'アプリをリセット';

  @override
  String get contactSupport => 'サポートに問い合わせる';

  @override
  String get chatWithUs => 'チャットで問い合わせる';

  @override
  String get termsOfService => '利用規約';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get medicalDisclaimer => '医療免責事項';

  @override
  String get disclaimerTitle => '免責事項';

  @override
  String get versionLabel => 'バージョン';

  @override
  String get signOutAction => 'サインアウト';

  @override
  String get educationalTrackingDisclaimer => '教育目的の記録専用です。医療的助言ではありません。';

  @override
  String get yourName => 'お名前';

  @override
  String get cancelLabel => 'キャンセル';

  @override
  String get saveLabel => '保存';

  @override
  String get dataCopied => 'データをクリップボードにコピーしました。';

  @override
  String get clearDataTitle => 'すべてのデータを消去しますか?';

  @override
  String get clearDataBody =>
      'すべてのプロトコル、投与ログ、身体測定値が削除され、オンボーディングが再開されます。アカウント、サブスクリプション、ペプチドライブラリは保持されます。この操作は取り消せません。';

  @override
  String get clearLabel => '消去';

  @override
  String get clearingDataTitle => 'データを消去中…';

  @override
  String get clearingDataBody => '記録データの削除中はPepModを開いたままにしてください。';

  @override
  String get clearDataFailed => 'データを消去できませんでした。接続を確認して再試行してください。';

  @override
  String get allDataCleared => 'すべてのデータを消去しました。';

  @override
  String get deleteAccountTitle => 'アカウントを削除しますか?';

  @override
  String get deleteAccountBody =>
      'PepModのアカウント、設定、プロトコル、投与ログ、身体測定値が完全に削除されます。この操作は取り消せません。';

  @override
  String get deletingAccount => 'アカウントを削除中…';

  @override
  String get accountDeletionFailed => 'アカウントの削除に失敗しました。もう一度お試しください。';

  @override
  String get confirmPassword => 'パスワードを確認';

  @override
  String get deleteLabel => '削除';

  @override
  String get signOutTitle => 'サインアウトしますか?';

  @override
  String get signOutBody => 'プロトコルは保存されたままになり、再度サインインすると同期されます。';

  @override
  String get signOutLabel => 'サインアウト';

  @override
  String get signOutFailed => 'サインアウトに失敗しました。もう一度お試しください。';

  @override
  String get notificationsDisabledSystem => '通知はシステム設定で無効になっています。';

  @override
  String get planPro => 'PRO';

  @override
  String get planFree => '無料';

  @override
  String get termsBody =>
      'PepModは教育および記録の目的でのみ提供されています。医療機器ではなく、医療的助言、診断、処方、治療の推奨は行いません。PepModの利用にあたり、ご自身の記録や判断、資格を持つ医療従事者への相談についてはご自身の責任となります。\n\nサブスクリプションは、更新期間前にApp StoreまたはGoogle Playを通じて解約されない限り自動更新されます。返金については購入元のストアの規定が適用されます。\n\n利用規約全文: https://appstorecopilot.com/legal/yzh32x5v/terms';

  @override
  String get privacyBody =>
      'PepModは認証とクラウドデータ保存にFirebase、サブスクリプションにRevenueCat、アトリビューションにAppReferおよびMeta/Facebook App Events、分析と診断にFirebase/Crashlyticsを使用しています。お客様の個人情報を販売することはありません。アカウントおよびアプリ内の保存データは、アプリ内からいつでも削除できます。\n\nプライバシーポリシー全文: https://appstorecopilot.com/legal/yzh32x5v/privacy';

  @override
  String get medicalDisclaimerBody =>
      'PepModはウェルネス・記録ツールであり、医療機器ではありません。本アプリのいかなる内容も、医療的助言、診断、処方、治療の推奨を構成するものではありません。ライブラリに記載されているペプチドは教育目的のみを意図しています。レジメンを開始・変更・中止する前は、必ず資格を持つ医療従事者にご相談ください。副作用を感じた場合は、直ちに医療機関を受診してください。';

  @override
  String get profileSystemLabel => 'SYS.ユーザー // プロフィール';

  @override
  String get legalSystemLabel => 'SYS.法務';

  @override
  String get progressTitle => '進捗';

  @override
  String get progressSystemLabel => 'SYS.進捗 // 生体指標';

  @override
  String get doseHistoryTooltip => '投与履歴を開く';

  @override
  String get logMeasurementTooltip => '測定値を記録';

  @override
  String get thirtyDayLabel => '30日間';

  @override
  String get adherenceLabel => 'アドヒアランス';

  @override
  String get streakLabel => '連続記録';

  @override
  String get daysLabel => '日';

  @override
  String get totalLabel => '合計';

  @override
  String get dosesLabel => '回分';

  @override
  String get protocolHistoryLabel => 'プロトコル.履歴';

  @override
  String get noProtocolsYet => 'プロトコルはまだありません。プロトコルタブから作成してください。';

  @override
  String get adherenceChartLabel => 'アドヒアランス // 過去30日';

  @override
  String get thirtyDaysAgo => '30日前';

  @override
  String get todayLabel => '今日';

  @override
  String get noWeightData => '体重データなし';

  @override
  String get logFirstMeasurement => '最初の測定を記録すると、ここに推移が表示されます。';

  @override
  String get logMeasurementAction => '測定を記録';

  @override
  String get weightTrendLabel => '体重 // 推移';

  @override
  String weightKgValue(String weight) {
    return '$weight kg';
  }

  @override
  String get statusActive => '実行中';

  @override
  String get statusPaused => '一時停止中';

  @override
  String get statusEnded => '終了';

  @override
  String protocolPeptideCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ペプチド$count種',
      one: 'ペプチド1種',
    );
    return '$_temp0';
  }

  @override
  String get enterOneMetric => '少なくとも1つの値を入力してください。';

  @override
  String get saveMetricFailed => '保存に失敗しました。もう一度お試しください。';

  @override
  String get newMeasurement => '新規測定';

  @override
  String get weightLabel => '体重';

  @override
  String get bodyFatLabel => '体脂肪率';

  @override
  String get measurementsCmLabel => '各部位サイズ（cm）';

  @override
  String get waistLabel => 'ウエスト';

  @override
  String get chestLabel => '胸囲';

  @override
  String get armLabel => '腕';

  @override
  String get saveAction => '保存';

  @override
  String get logMetricSystemLabel => '指標.記録';

  @override
  String get activeLastSevenDays => '過去7日間';

  @override
  String get activeAllTime => '全期間';

  @override
  String get activeAdherence => 'アドヒアランス';

  @override
  String get activeStarted => '開始日';

  @override
  String get activeEnded => '終了日';

  @override
  String activeStackCount(int count) {
    return 'スタック（$count）';
  }

  @override
  String get activeEditProtocol => 'プロトコルを編集';

  @override
  String get activePauseProtocol => 'プロトコルを一時停止';

  @override
  String get activeEndProtocol => 'プロトコルを終了';

  @override
  String get activeResumeProtocol => 'プロトコルを再開';

  @override
  String get activeDeleteProtocol => 'プロトコルを削除';

  @override
  String get activeTrackingDisclaimer =>
      '教育目的の記録専用です。変更前には必ず有資格の医療専門家にご相談ください。';

  @override
  String get activeEndQuestion => 'プロトコルを終了しますか？';

  @override
  String get activeEndBody => '今後の予定投与は削除されます。過去の記録は履歴に残ります。この操作は取り消せません。';

  @override
  String get activeEndAction => '終了';

  @override
  String get activeDeleteQuestion => 'プロトコルを削除しますか？';

  @override
  String get activeDeleteBody => 'このプロトコルとすべての投与記録が完全に削除されます。この操作は取り消せません。';

  @override
  String get activeDeleteAction => '削除';

  @override
  String get cancel => 'キャンセル';

  @override
  String get activeStatusActive => '実行中';

  @override
  String get activeStatusPaused => '一時停止中';

  @override
  String get activeStatusEnded => '終了';

  @override
  String get activeNotesLabel => 'メモ // プロトコル';

  @override
  String get activeChangeReminders => '変更リマインダー';

  @override
  String get activeChangeRemindersBody =>
      '通知がオンの場合、PepModは今後のフェーズ変更ごとに現地時間09:00のチェックポイントを設定します。';

  @override
  String activePhaseAnchor(String date) {
    return '週の区切りは$dateを起点としています。';
  }

  @override
  String activeWeek(int week) {
    return '第$week週';
  }

  @override
  String activeWeeks(int start, int end) {
    return '第$start〜$end週';
  }

  @override
  String get activePerDayAmounts => '1日あたりの量';

  @override
  String get activeBaseAmount => '基本量';

  @override
  String get activeCurrent => '現在';

  @override
  String get activeBaseSchedule => '基本スケジュール';

  @override
  String get activeCustomDays => 'カスタム日程';

  @override
  String get activeContinuousTracking => '継続記録';

  @override
  String get activeNoFixedCycle => '固定サイクル期間なし';

  @override
  String activeCycleProgress(int week, int total) {
    return '第$week週 / 全$total週';
  }

  @override
  String activeCycleEnds(String date) {
    return 'サイクル終了：$date';
  }

  @override
  String activeRestProgress(int week, int total) {
    return '休止第$week週 / 全$total週';
  }

  @override
  String activeRestEnds(String date) {
    return '休止期間終了：$date';
  }

  @override
  String get activeCycleComplete => 'サイクル完了';

  @override
  String activeCompletedDate(String date) {
    return '完了日：$date';
  }

  @override
  String activeRestEnded(String date) {
    return '休止期間終了：$date';
  }

  @override
  String get activeNoHistory => '一時停止・終了したプロトコルはまだありません。';

  @override
  String activeCompoundsCount(int count) {
    return '$count種の成分';
  }

  @override
  String activeSyringeUnits(String amount) {
    return '$amountシリンジ単位';
  }

  @override
  String activeCycleWeeks(int count) {
    return '$count週サイクル';
  }

  @override
  String activeRestWeeks(int count) {
    return '$count週休止';
  }

  @override
  String get activePerDraw => '1回の吸引あたり';

  @override
  String activeVialSummary(String volume) {
    return '$volume mLバイアル・U-100';
  }

  @override
  String get addCompound => '成分を追加';

  @override
  String get addPhase => 'フェーズを追加';

  @override
  String get addTime => '時間を追加';

  @override
  String get addToStack => 'スタックに追加';

  @override
  String get amountRequired => '量を入力してください';

  @override
  String get baseAmount => '基本量';

  @override
  String get baseSchedule => '基本スケジュール';

  @override
  String get blendConfigBody =>
      'バイアルに記載されている内容をそのまま入力してください。PepModが吸引量を成分ごとのスナップショットに変換します。';

  @override
  String get blendIncompleteError => '成分は最低2つ、希釈液量、吸引量をすべて入力してください。';

  @override
  String get blendNameHint => '例：リカバリーブレンド';

  @override
  String get blendNameLabel => 'ブレンド名';

  @override
  String get blendSafetyDisclaimer =>
      '単位変換のみを行う機能です。PepModはブレンド、用量、頻度、再構成方法を推奨するものではありません。';

  @override
  String get changeNoteHint => 'このフェーズについての自分用メモ';

  @override
  String get changeNoteOptional => '変更メモ（任意）';

  @override
  String colorOption(String hex) {
    return 'カラーオプション $hex';
  }

  @override
  String compoundNumber(int number) {
    return '成分 $number';
  }

  @override
  String compoundsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '成分$count種',
      one: '成分1種',
    );
    return '$_temp0';
  }

  @override
  String copiedVialPreset(String amount, String unit) {
    return '$amount $unit バイアルプリセット・このプロトコルにコピーしました';
  }

  @override
  String get createProtocolAction => 'プロトコルを作成';

  @override
  String get createProtocolAddOneError => 'ペプチドを1つ以上追加してください。';

  @override
  String createProtocolBuildStep(int step, int total) {
    return 'プロトコル作成 · ステップ $step / $total';
  }

  @override
  String get createProtocolDefaultName => 'マイプロトコル';

  @override
  String createProtocolEditStep(int step, int total) {
    return 'プロトコル編集 · ステップ $step / $total';
  }

  @override
  String get createProtocolFreeLimitReason =>
      '無料プランではプロトコルごとにペプチド1種類までです。複数の化合物を組み合わせるにはアップグレードしてください。';

  @override
  String get createProtocolNameBody =>
      '「リカバリースタック」や「Q2シュレッド」のような覚えやすい名前を付けましょう。';

  @override
  String get createProtocolNameTitle => 'プロトコルに名前を付ける';

  @override
  String get createProtocolNoPeptides => 'ペプチドがまだありません';

  @override
  String get createProtocolPickHint => '+をタップしてライブラリから選択';

  @override
  String get createProtocolReviewBody => 'プロトコルの詳細を確認してください。管理画面からいつでも編集できます。';

  @override
  String get createProtocolSaveError => 'プロトコルの保存に失敗しました。もう一度お試しください。';

  @override
  String get createProtocolStackBody =>
      'ペプチドを1つ追加するか、複数の化合物を組み合わせましょう。それぞれのラベル、用量、頻度、サイクルを設定します。';

  @override
  String get createProtocolStackTitle => 'スタックを作成';

  @override
  String get customBlend => 'カスタムブレンド';

  @override
  String get customDays => 'カスタム曜日';

  @override
  String get customDaysDisclaimer =>
      '選択した曜日のみがスケジュールされます。入力する量はユーザーによる記録値であり、投与に関する助言ではありません。';

  @override
  String get customPeptide => 'カスタムペプチド';

  @override
  String get cycleWeeksLabel => 'サイクル週数';

  @override
  String get cycleWindowDisclaimer =>
      'サイクルと休止期間は記録履歴を整理するためのものです。サイクル期間の終了後、PepModは今後の摂取をスケジュールしません。';

  @override
  String get defaultAmountLabel => 'デフォルト量';

  @override
  String get diluentVolumeLabel => '希釈液量';

  @override
  String get drawExceedsVialError => '吸引量はバイアルの容量を超えることはできません。';

  @override
  String get drawLabel => '吸引量';

  @override
  String get drawPreviewLabel => '吸引量プレビュー';

  @override
  String drawPreviewValue(String units, String volume) {
    return '$units ユニット = $volume mL';
  }

  @override
  String editTime(String time) {
    return '時刻 $time を編集';
  }

  @override
  String get endWeekLabel => '終了週';

  @override
  String get enterPeptideName => 'ペプチド名を入力';

  @override
  String get frequencyLabel => '頻度';

  @override
  String get labelColorBody => '実際に使っているペンやバイアルのラベルに合わせた色を選んでください。';

  @override
  String get labelColorLabel => 'ラベルカラー';

  @override
  String get manageSavedCompounds => '保存済み化合物を管理';

  @override
  String get nextLabel => '次へ';

  @override
  String get noneLabel => 'なし';

  @override
  String get oneOffCompound => '単発の化合物';

  @override
  String get oneOffCompoundBody => 'プリセットとして保存せず一度だけ使用';

  @override
  String get optionalLabel => '任意';

  @override
  String peptidesCount(int count) {
    return 'ペプチド（$count）';
  }

  @override
  String get perDayAmounts => '1日ごとの量';

  @override
  String phaseExtendsWarning(int weeks) {
    return 'フェーズが$weeks週間のサイクルを超えています。フェーズまたはサイクル期間を調整してください。';
  }

  @override
  String get phaseNameHint => '例：1週目の記録';

  @override
  String get phaseNameLabel => 'フェーズ名';

  @override
  String phaseNumber(int number) {
    return 'フェーズ $number';
  }

  @override
  String phaseOutsideCycleError(int weeks) {
    return 'このプロトコルのサイクルは$weeks週目で終了します。フェーズの週数はその範囲内に収めてください。';
  }

  @override
  String get phaseOverlapError => 'フェーズの週範囲を重複させることはできません。';

  @override
  String get phaseOverrideBody =>
      'すでに実践予定の記録スケジュールのみを入力してください。PepModは量を推奨しません。';

  @override
  String get phaseOverrideTitle => '週ごとのオーバーライド';

  @override
  String get phasePreviewDisclaimer =>
      '入力内容のプレビューのみです。PepModによるスケジュールの推奨ではありません。';

  @override
  String get phasePreviewLabel => 'フェーズプレビュー';

  @override
  String get phaseReminderBody => 'プロトコルのリマインダーが有効な場合、フェーズ変更の通知は午前9:00に設定されます。';

  @override
  String get phaseScheduleLabel => 'フェーズスケジュール';

  @override
  String get phaseSelectDayError =>
      '少なくとも1日を選択してください。PepModが代わりにスケジュールを選ぶことはありません。';

  @override
  String get phasesBody =>
      '任意で期間を設定し、この基本の量やスケジュールを上書きできます。期間外は基本スケジュールが継続します。';

  @override
  String phasesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'フェーズ$count件',
      one: 'フェーズ1件',
    );
    return '$_temp0';
  }

  @override
  String get phasesDisclaimer =>
      '週数はプロトコル開始日から数えられます。保存されたフェーズのメモや変更リマインダーは記録の補助にすぎません。';

  @override
  String get preBlendedVial => 'プレブレンドバイアル';

  @override
  String get preBlendedVialBody => 'バイアル1本・吸引1回・複数の化合物';

  @override
  String get protocolNotesBody => 'このプロトコルを確認する際に表示したい情報を保存できます。';

  @override
  String get protocolNotesHint => '例：疑問点、記録の背景、専門家からのメモなど';

  @override
  String get protocolNotesLabel => 'プロトコルメモ';

  @override
  String get reminderTimesBody => '選択した時刻ごとに、専用の記録行とスケジュール日のリマインダーが作成されます。';

  @override
  String get reminderTimesLabel => 'リマインダー時刻';

  @override
  String get removeLabel => '削除';

  @override
  String removePeptide(String name) {
    return '$nameを削除';
  }

  @override
  String get removePhase => 'フェーズを削除';

  @override
  String removeTime(String time) {
    return '時刻 $time を削除';
  }

  @override
  String get restWeeksLabel => '休止週数';

  @override
  String get reviewLabel => '確認';

  @override
  String get routeLabel => '投与経路';

  @override
  String get saveBlend => 'ブレンドを保存';

  @override
  String get saveChanges => '変更を保存';

  @override
  String get savePhase => 'フェーズを保存';

  @override
  String savedVialPreset(String amount, String unit) {
    return '$amount $unit バイアル · 保存済みプリセット';
  }

  @override
  String get scheduleLabel => 'スケジュール';

  @override
  String get searchCompounds => '化合物を検索...';

  @override
  String get selectDayError => 'このペプチドをスケジュールするには、少なくとも1日選択してください。';

  @override
  String selectOption(String option) {
    return '$optionを選択';
  }

  @override
  String get startDateLabel => '開始日';

  @override
  String get startWeekLabel => '開始週';

  @override
  String syringeUnitsAmount(String amount) {
    return '$amount シリンジユニット';
  }

  @override
  String get syringeUnitsDisclaimer => '記録用として任意で入力するU-100シリンジの目盛りです。';

  @override
  String get syringeUnitsHint => '例：12.5';

  @override
  String get syringeUnitsLabel => 'シリンジユニット';

  @override
  String get syringeUnitsOptional => 'シリンジユニット（任意）';

  @override
  String get trackedAmountLabel => '記録量';

  @override
  String get u100TrackingDisclaimer =>
      'U-100シリンジの目盛り（100ユニット = 1 mL）を使用します。値はユーザーが入力する記録データです。';

  @override
  String get unitLabel => '単位';

  @override
  String get vialAmountHint => 'バイアルの量';

  @override
  String get vialContentsLabel => 'バイアルの内容';

  @override
  String get vialLabelNameHint => 'バイアルラベルに記載の名前';

  @override
  String weekNumber(int week) {
    return '第$week週';
  }

  @override
  String weekRange(int start, int end) {
    return '第$start〜$end週';
  }

  @override
  String get weekToWeekPhases => '週次フェーズ';

  @override
  String weekdayDose(String weekday) {
    return '$weekday投与';
  }

  @override
  String weekdaySchedule(String weekday) {
    return '$weekdayスケジュール';
  }

  @override
  String get doseDrawInvalid => '吸引量はゼロより大きく、バイアルの容量内である必要があります。';

  @override
  String get doseGenericError => '問題が発生しました。もう一度お試しください。';

  @override
  String get doseEditSystemLabel => '編集.投与';

  @override
  String get doseLogSystemLabel => '記録.投与';

  @override
  String get doseDraw => '吸引量';

  @override
  String get doseAmount => '量';

  @override
  String get doseUnits => 'ユニット';

  @override
  String get doseTime => '時刻';

  @override
  String get doseChooseTime => '投与時刻を選択';

  @override
  String get doseBlendSnapshot => '配合スナップショット // 1回あたり';

  @override
  String doseSyringeUnitsRecorded(String amount) {
    return 'この投与に$amountシリンジユニットを記録しました。';
  }

  @override
  String get doseInjectionSite => '注射.部位';

  @override
  String doseLastSite(String site) {
    return 'このペプチドの前回部位 · $site';
  }

  @override
  String get doseNotes => 'メモ';

  @override
  String get doseOptional => '任意…';

  @override
  String get doseMarkPending => '保留にする';

  @override
  String get doseSaveChanges => '変更を保存';

  @override
  String get doseSkip => 'この投与をスキップ';

  @override
  String get doseHistorySystemLabel => '投与.履歴 // 30日';

  @override
  String get doseHistoryTitle => '記録済みの投与';

  @override
  String get doseHistoryBody => '記録をタップすると、量・実施時刻・注射部位・メモ・ステータスを修正できます。';

  @override
  String get doseHistoryEmpty => '過去30日間に記録された投与はありません。';

  @override
  String get doseLogPrevious => '過去の投与を記録';

  @override
  String doseHistorySkipped(String dateTime) {
    return 'スキップ · $dateTime';
  }

  @override
  String doseHistoryTaken(String amount, String units, String dateTime) {
    return '$amount $units · $dateTime';
  }

  @override
  String get doseEditAction => '編集';

  @override
  String get doseChoosePastTime => '記録する過去の時刻を選択してください。';

  @override
  String get dosePreviousError => '過去の投与を記録できませんでした。もう一度お試しください。';

  @override
  String get doseLogPreviousSystemLabel => '記録.過去分';

  @override
  String get doseNoPeptides => '利用可能なペプチドがありません';

  @override
  String get doseNoPeptidesBody => '履歴を記録する前に、進行中のプロトコルにペプチドを追加してください。';

  @override
  String get doseCorrectHistory => '投与履歴を修正';

  @override
  String get dosePeptide => 'ペプチド';

  @override
  String get doseDate => '日付';

  @override
  String get doseChooseDate => '投与日を選択';

  @override
  String doseSyringeUnitsEntry(String amount) {
    return 'この記録に$amountシリンジユニットを記録しました。';
  }

  @override
  String get doseHistoryDisclaimer =>
      '履歴の記録は個人のトラッキング用データにすぎません。医学的な助言や投与に関する推奨を変更するものではありません。';

  @override
  String get notificationChannelName => '投与リマインダー';

  @override
  String get notificationChannelDescription =>
      '進行中のペプチドプロトコルの投与について設定したリマインダーです。';

  @override
  String get notificationDoseTitle => '投与の時間です';

  @override
  String get notificationDoseBody => '設定した投与リマインダーの時間になりました。';

  @override
  String get notificationCycleTitle => 'プロトコルチェックポイント';

  @override
  String get notificationCycleBody =>
      '本日、サイクル期間のリマインダーがあります。トラッキングプランを確認してください。';

  @override
  String get notificationRestTitle => '休止期間チェックポイント';

  @override
  String get notificationRestBody => '本日、休止期間のリマインダーがあります。トラッキングプランを確認してください。';

  @override
  String get notificationPhaseTitle => 'プロトコルフェーズチェックポイント';

  @override
  String get notificationPhaseBody =>
      '本日、新しいトラッキングフェーズが始まります。保存済みのスケジュールを確認してください。';

  @override
  String get personalLibrarySystemLabel => 'SYS.ライブラリ // 個人用';

  @override
  String get customCompoundIntro =>
      '自分で入力したラベルとバイアルサイズを保存できます。プリセットはトラッキングを効率化するためのもので、投与の指示ではありません。';

  @override
  String get archivedHeading => 'アーカイブ済み';

  @override
  String get activePresetsHeading => '有効なプリセット';

  @override
  String get showActive => '有効なものを表示';

  @override
  String get archivedAction => 'アーカイブ済み';

  @override
  String get customCompoundsLoadFailed => '成分を読み込めませんでした。もう一度お試しください。';

  @override
  String get libraryLoadFailed => 'ペプチドライブラリを読み込めませんでした。もう一度お試しください。';

  @override
  String compoundVialSummary(String amount, String unit, String route) {
    return '$amount $unit バイアル · $route';
  }

  @override
  String get editPreset => 'プリセットを編集';

  @override
  String get restorePreset => '復元';

  @override
  String get archivePreset => 'アーカイブ';

  @override
  String get noArchivedPresets => 'アーカイブ済みのプリセットはありません';

  @override
  String get noSavedCompounds => '保存された成分はありません';

  @override
  String get archivedPresetsHint => 'アーカイブしたプリセットは、復元するまでここに保存されます。';

  @override
  String get createPresetHint => '繰り返し使えるラベルとバイアルサイズのプリセットを作成します。';

  @override
  String get presetCompoundSystemLabel => 'プリセット.成分';

  @override
  String get newCompound => '新しい成分';

  @override
  String get editCompound => '成分を編集';

  @override
  String get ownVialDetailsHint => 'ご自身のバイアルに記載されている情報のみを入力してください。';

  @override
  String get compoundLabel => '成分ラベル';

  @override
  String get compoundNameExample => '例：自分の成分';

  @override
  String get vialUnitLabel => 'バイアル単位';

  @override
  String get trackingUnitLabel => 'トラッキング単位';

  @override
  String get notesOptional => 'メモ（任意）';

  @override
  String get compoundNoteExample => 'ラベルや保管に関するメモ';

  @override
  String get noDoseRecommendation => '投与に関する推奨は作成されません。プロトコルの量は常にご自身で個別に入力します。';

  @override
  String get saveCompoundFailed => 'プリセットを保存できませんでした。もう一度お試しください。';

  @override
  String get routeTopical => '外用';

  @override
  String get frequencyCustomDays => 'カスタム日数';

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
    return 'U-100 · $volume mL / $capacityユニット';
  }

  @override
  String get peptideContentHcgDescription =>
      'ヒト絨毛性性腺刺激ホルモン (HCG) は、規制された臨床現場で使用される糖タンパク質ホルモンであり、ペプチドプロトコルと並んで頻繁に議論されます。このエントリは、ユーザーが入力したスケジュールの中立的な追跡参照として提供されます。';

  @override
  String get peptideContentHcgTypicalDose => 'ユーザーが入力した IU';

  @override
  String get peptideContentHcgHalfLife => '～24～36時間';

  @override
  String get peptideContentHcgNotes =>
      '多くの地域で処方薬に該当します。資格のある医療従事者から既に指示された内容だけを記録してください。PepModはHCGの投与量を案内しません。';

  @override
  String get peptideContentBpc157Description =>
      'BPC-157 (Body Protection Compound 157) は、胃液に含まれるタンパク質に由来する 15 アミノ酸の合成ペプチドです。軟組織および腸内壁の修復における役割について、動物モデルで研究されています。ヒトの臨床データは依然として限られています。';

  @override
  String get peptideContentBpc157TypicalDose => '250～500μg';

  @override
  String get peptideContentBpc157HalfLife => '～4時間';

  @override
  String get peptideContentBpc157Notes =>
      '静菌水で再溶解し冷蔵保存する取り扱いが一般に記載されています。動物研究の腱・靱帯プロトコルでは、TB-500との併用がよく言及されます。';

  @override
  String get peptideContentTb500Description =>
      'TB-500 は、天然に存在するタンパク質チモシン ベータ 4 の合成フラグメントです。動物実験では、細胞遊走と組織再生における役割が研究されています。研究者や獣医療現場で適応外で広く使用されています。';

  @override
  String get peptideContentTb500TypicalDose => '毎週 2 ～ 5 mg の負荷、その後 2 mg の維持';

  @override
  String get peptideContentTb500HalfLife => '～2日';

  @override
  String get peptideContentTb500Notes =>
      '軟組織に関する研究プロトコルでは、BPC-157との併用がよく言及されます。半減期が長いため、週2回に分ける例が一般的とされています。';

  @override
  String get peptideContentGhkCuDescription =>
      'GHK-Cu (銅ペプチド) は、ヒトの血漿中に存在する天然の銅結合トリペプチドです。皮膚のリモデリングや毛包シグナル伝達のための局所化粧品用途で研究されています。';

  @override
  String get peptideContentGhkCuTypicalDose => '1～2mg';

  @override
  String get peptideContentGhkCuHalfLife => '～1時間';

  @override
  String get peptideContentGhkCuNotes =>
      'スキンケア製剤にも局所的に使用されます。皮下投与は通常、局所濃度よりも低くなります。';

  @override
  String get peptideContentEpitalonDescription =>
      'エピタロンは、松果体から抽出されたペプチドであるエピタラミンの合成テトラペプチド類似体です。ロシアの研究では、テロメラーゼ活性と概日調節に対するその影響が調査されています。';

  @override
  String get peptideContentEpitalonTypicalDose => '1 サイクル日あたり 5 ～ 10 mg';

  @override
  String get peptideContentEpitalonHalfLife => '～30分';

  @override
  String get peptideContentEpitalonNotes =>
      'ロシアの長寿研究では、短い周期（例：10～20日間使用し、その後数か月休止）で実施された例があります。';

  @override
  String get peptideContentSemaglutideDescription =>
      'セマグルチドは、元々 2 型糖尿病用に開発された GLP-1 受容体アゴニストで、後に Ozempic および Wegovy という商品名で慢性的な体重管理用に承認されました。胃内容排出を遅らせ、食欲シグナル伝達を調節します。';

  @override
  String get peptideContentSemaglutideTypicalDose => '週0.25～2.4 mg（漸増）';

  @override
  String get peptideContentSemaglutideHalfLife => '～7日';

  @override
  String get peptideContentSemaglutideNotes =>
      '多くの国で処方薬に該当します。消化器系の副作用に配慮し、低用量から開始して4週間ごとに増量する漸増スケジュールが用いられます。';

  @override
  String get peptideContentTirzepatideDescription =>
      'チルゼパチドは、2 型糖尿病 (Mounjaro) および肥満 (Zepbound) に対して承認されている GIP/GLP-1 デュアル受容体アゴニストです。臨床試験では、単一アゴニストの GLP-1 よりも大きな体重減少をもたらすことが示されています。';

  @override
  String get peptideContentTirzepatideTypicalDose => '毎週 2.5 ～ 15 mg (漸増)';

  @override
  String get peptideContentTirzepatideHalfLife => '～5日';

  @override
  String get peptideContentTirzepatideNotes =>
      '多くの国で処方薬に該当します。一般的な漸増間隔は4週間で、週1回の皮下投与として承認されています。';

  @override
  String get peptideContentRetatrutideDescription =>
      'レタトルチドは、GIP、GLP-1、およびグルカゴン受容体を標的とする研究中のトリプルアゴニストです。第 2 相試験では、既存の GLP-1 ベースの治療法を超える体重減少が報告されました。';

  @override
  String get peptideContentRetatrutideTypicalDose =>
      '承認された投与レジメンはありません。Retatrutideは治験段階であり、試験で報告された量は研究上の参考情報で、使用指示ではありません。';

  @override
  String get peptideContentRetatrutideHalfLife => '～6日';

  @override
  String get peptideContentRetatrutideNotes =>
      'まだ研究中です。執筆時点では FDA の承認はありません。臨床試験以外での使用は厳密に研究のみに限られます。';

  @override
  String get peptideContentIpamorelinDescription =>
      'イパモレリンは、ペンタペプチドのグレリン模倣物であり、選択的成長ホルモン分泌促進物質です。コルチゾールやプロラクチンへの影響を最小限に抑えながら、脈動的な GH 放出を刺激する能力が研究されています。';

  @override
  String get peptideContentIpamorelinTypicalDose => '1 回の注射につき 200 ～ 300 mcg';

  @override
  String get peptideContentIpamorelinHalfLife => '～2時間';

  @override
  String get peptideContentIpamorelinNotes =>
      '研究コミュニティでは、GHパルスとの関連からCJC-1295（DACなし）との併用がよく言及されます。就寝前や運動前の空腹時という例も報告されています。';

  @override
  String get peptideContentCjc1295DacDescription =>
      'CJC-1295 は合成 GHRH 類似体です。 DAC (Drug Affinity Complex) バリアントは血清アルブミンに結合し、その半減期を延長し、離散的なパルスではなく持続的な GH レベルを生成します。';

  @override
  String get peptideContentCjc1295DacTypicalDose => '毎週1～2mg';

  @override
  String get peptideContentCjc1295DacHalfLife => '～8日';

  @override
  String get peptideContentCjc1295DacNotes =>
      '長時間作用型で、研究プロトコルでは週1～2回の例が見られます。急峻なパルスではなく、GH/IGF-1の基礎値を持続的に高めるとされています。';

  @override
  String get peptideContentCjc1295NoDacDescription =>
      'DAC を含まない CJC-1295 (Mod-GRF(1-29) としても知られる) は、半減期が短い GHRH 類似体です。通常、自然な拍動性の GH 放出を引き起こすために、イパモレリンなどの GHRP と組み合わせられます。';

  @override
  String get peptideContentCjc1295NoDacTypicalDose => '1回の注射につき100mcg';

  @override
  String get peptideContentCjc1295NoDacHalfLife => '～30分';

  @override
  String get peptideContentCjc1295NoDacNotes =>
      '短時間作用型で、GHパルスとの関連からGHRP（イパモレリン、GHRP-2、GHRP-6）との併用が研究コミュニティで言及されます。空腹時に1日1～3回という例もあります。';

  @override
  String get peptideContentTesamorelinDescription =>
      'テサモレリンは、HIV 関連脂肪異栄養症における過剰な腹部内臓脂肪を減らすことが承認された安定化 GHRH 類似体です (商品名 Egrifta)。認知老化の文脈でも研究されています。';

  @override
  String get peptideContentTesamorelinTypicalDose => '毎日1～2mg';

  @override
  String get peptideContentTesamorelinHalfLife => '～30分';

  @override
  String get peptideContentTesamorelinNotes =>
      '処方薬です。主に内臓脂肪組織の減少について研究され、承認された用法では1日1回の皮下投与です。';

  @override
  String get peptideContentMotsCDescription =>
      'MOTS-c は、MT-RNR1 遺伝子内にコードされているミトコンドリア由来のペプチドです。研究では、代謝恒常性、インスリン感受性、運動生理学におけるその役割が調査されています。';

  @override
  String get peptideContentMotsCTypicalDose => '5 ～ 10 mg を週に 2 ～ 3 回';

  @override
  String get peptideContentMotsCHalfLife => '～90分';

  @override
  String get peptideContentMotsCNotes =>
      '研究はまだ進行中です。一部のユーザーは、自己実験ログで運動の回復力と代謝マーカーの改善を報告しています。';

  @override
  String get peptideContentCerebrolysinDescription =>
      'セレブロリシンは、ブタの脳組織由来の低分子量ペプチドとアミノ酸の混合物です。ヨーロッパおよびアジアのいくつかの国では、神経変性疾患および脳卒中回復の適応症として処方されています。';

  @override
  String get peptideContentCerebrolysinTypicalDose => '5 ～ 30 ml アンプル (臨床現場)';

  @override
  String get peptideContentCerebrolysinHalfLife => '一定ではない（混合物）';

  @override
  String get peptideContentCerebrolysinNotes =>
      '通常は臨床管理下で一定期間使用されます。米国では承認されていません。虚血性脳卒中やアルツハイマー病を対象とした研究があります。';

  @override
  String get peptideContentSelankDescription =>
      'Selank は、免疫調節ペプチド タフトシンの類似体としてロシアで開発された合成ヘプタペプチドです。ベンゾジアゼピンの鎮静や依存を伴わない抗不安効果について研究されています。';

  @override
  String get peptideContentSelankTypicalDose => '250～500 mcg 鼻腔内';

  @override
  String get peptideContentSelankHalfLife => '～数分（全身）';

  @override
  String get peptideContentSelankNotes =>
      '最も一般的には鼻腔内に投与されます。ロシアの研究は不安と注意力に焦点を当てている。半減期は短いですが、効果は数時間持続すると報告されています。';

  @override
  String get peptideContentSemaxDescription =>
      'Semax は、ACTH (4-10) のフラグメントに由来する合成ヘプタペプチドです。ロシアの研究では、特に脳卒中回復プロトコルにおいて、その向知性効果と神経保護効果が調査されています。';

  @override
  String get peptideContentSemaxTypicalDose => '250～1000 mcg 鼻腔内';

  @override
  String get peptideContentSemaxHalfLife => '～30分';

  @override
  String get peptideContentSemaxNotes =>
      '鼻腔内投与が典型的です。ロシアでは虚血性脳卒中に対して承認されています。補完的な効果を得るために Selank と組み合わせて使用​​することがよくあります。';

  @override
  String get peptideContentMelanotanIiDescription =>
      'メラノタン II は、α-メラノサイト刺激ホルモン (α-MSH) の合成類似体です。元々はサンレスタンニング剤として開発されたもので、食欲や性欲の影響にも関係しています。';

  @override
  String get peptideContentMelanotanIiTypicalDose =>
      '250 ～ 1000 mcg のローディング、その後のメンテナンス';

  @override
  String get peptideContentMelanotanIiHalfLife => '～1時間';

  @override
  String get peptideContentMelanotanIiNotes =>
      '医療用途としては承認されていません。一般的に報告されている副作用には、吐き気や既存のほくろの黒ずみなどが含まれます。新たなほくろや変化のあるほくろは、皮膚科医の診断を受ける必要があります。';

  @override
  String get peptideContentPt141Description =>
      'PT-141 はブレメラノチドとしても知られ、ヴィリーシとして販売されており、閉経前女性の性的欲求低下障害に対して FDA によって承認されたメラノコルチン受容体作動薬です。中枢神経系の経路に作用します。';

  @override
  String get peptideContentPt141TypicalDose => '必要に応じて 1.25 ～ 1.75 mg';

  @override
  String get peptideContentPt141HalfLife => '～2時間';

  @override
  String get peptideContentPt141Notes =>
      '一部の市場では処方薬です。定期的なスケジュールではなく、必要時に使用されます。一般的な副作用として、吐き気や一時的な血圧上昇が報告されています。';

  @override
  String get peptideContentDsipDescription =>
      'デルタ睡眠誘導ペプチド (DSIP) は、1970 年代にウサギの脳から単離されたノナペプチドです。睡眠調節、痛みの調節、ストレス反応における役割の可能性について研究されていますが、メカニズムは不明のままです。';

  @override
  String get peptideContentDsipTypicalDose => '就寝前に100～500μg';

  @override
  String get peptideContentDsipHalfLife => '～7分';

  @override
  String get peptideContentDsipNotes =>
      '研究プロトコルでは就寝前の使用例が見られます。血漿半減期は短いものの、それを超えて作用が続くとの報告があります。根拠は依然として限定的です。';

  @override
  String get peptideContentThymosinAlpha1Description =>
      'チモシン アルファ-1 は、もともと胸腺組織から単離された 28 アミノ酸のペプチドです。 B 型および C 型肝炎に対する補助免疫調節療法 (商品名 Zadaxin) として複数の国で承認されています。';

  @override
  String get peptideContentThymosinAlpha1TypicalDose => '1.6mgを週2回';

  @override
  String get peptideContentThymosinAlpha1HalfLife => '～2時間';

  @override
  String get peptideContentThymosinAlpha1Notes =>
      'いくつかの国際市場で免疫調節プロトコルの一部として使用されています。通常、週に2回投与します。さまざまな適応症について研究が続けられています。';

  @override
  String get peptideContentNadPlusDescription =>
      'NAD+ (ニコチンアミドアデニン ジヌクレオチド) は、細胞のエネルギー代謝と DNA 修復の中心となる補酵素です。注射可能な NAD+ とその前駆体 (NR、NMN) は、ミトコンドリアの健康と老化の観点から研究されています。';

  @override
  String get peptideContentNadPlusTypicalDose =>
      'セッションごとに 100 ～ 500 mg IV または SubQ';

  @override
  String get peptideContentNadPlusHalfLife => '～90分';

  @override
  String get peptideContentNadPlusNotes =>
      '厳密にはペプチドではなく補酵素ですが、長寿関連のプロトコルと併せて扱われることがあります。紅潮や不快感との関連から、緩徐な点滴が言及されています。';

  @override
  String get peptideContentSermorelinDescription =>
      'セルモレリンは、成長ホルモン放出ホルモン (GHRH) の合成類似体です。成長ホルモン貯蔵量の診断薬として臨床的に使用されており、ウェルネス環境では GH 軸サポートペプチドとして一般的に議論されています。';

  @override
  String get peptideContentSermorelinTypicalDose => '就寝前に100～300μg';

  @override
  String get peptideContentSermorelinHalfLife => '～10～20分';

  @override
  String get peptideContentSermorelinNotes =>
      'どちらも GHRH 経路に作用するため、CJC-1295 no-DAC とよく比較されます。半減期が短いため、非臨床プロトコールでは夕方の投与が一般的です。';

  @override
  String get peptideContentAod9604Description =>
      'AOD-9604 は、176 ～ 191 領域に由来するヒト成長ホルモンの修飾フラグメントです。代謝および脂肪分解シグナル伝達について研究されていますが、ヒトで発表された証拠は限られており、混合されています。';

  @override
  String get peptideContentAod9604TypicalDose => '毎日 250 ～ 500 mcg';

  @override
  String get peptideContentAod9604HalfLife => '～30分';

  @override
  String get peptideContentAod9604Notes =>
      'HGHフラグメント176～191とも呼ばれます。承認された減量薬ではなく、記録時も中立的な表現を保ち、結果を保証するものではありません。';

  @override
  String get peptideContentKpvDescription =>
      'KPV は、α-メラノサイト刺激ホルモンに由来する短いトリペプチド配列 (リジン-プロリン-バリン) です。これは、免疫および腸関門シグナル伝達の研究の文脈で議論されています。';

  @override
  String get peptideContentKpvTypicalDose => '毎日 250 ～ 500 mcg';

  @override
  String get peptideContentKpvHalfLife => '十分に確立されていない';

  @override
  String get peptideContentKpvNotes =>
      '腸の健康や局所使用に関する議論で、BPC-157との非公式な併用例が見られます。ヒトでの用量に関する根拠は限定的です。';

  @override
  String get peptideContentSs31Description =>
      'SS-31 はエラミプレチドとしても知られ、カルジオリピンとの相互作用およびミトコンドリア膜機能について研究されているミトコンドリアを標的とするテトラペプチドです。臨床研究は、まれなミトコンドリアおよび心臓の状態に焦点を当ててきました。';

  @override
  String get peptideContentSs31TypicalDose => '治験プロトコルはさまざまです';

  @override
  String get peptideContentSs31HalfLife => '～4時間';

  @override
  String get peptideContentSs31Notes =>
      '多くの文脈で調査中。コミュニティプロトコルは臨床試験の処方とは異なることが多く、研究専用として扱う必要があります。';

  @override
  String get peptideContentLl37Description =>
      'LL-37 は、自然免疫シグナル伝達に関与するヒト カテリシジン抗菌ペプチドです。研究コミュニティでは宿主防御および組織応答経路について議論されていますが、安全性についての考慮は重要です。';

  @override
  String get peptideContentLl37TypicalDose => '研究プロトコルはさまざまです';

  @override
  String get peptideContentLl37HalfLife => '十分に確立されていない';

  @override
  String get peptideContentLl37Notes =>
      '管理された研究環境以外での使用は非常に実験的です。抗菌ペプチドは免疫シグナル伝達に影響し得るため、慎重な教育的説明が重要です。';

  @override
  String get peptideContentDihexaDescription =>
      'ジヘキサは、肝細胞増殖因子/c-Met シグナル伝達およびシナプス形成活性について前臨床研究された経口活性アンジオテンシン IV 由来ペプチド類似体です。ヒトに対する安全性と有効性のデータは確立されていません。';

  @override
  String get peptideContentDihexaTypicalDose => '研究専用。プロトコルは異なります';

  @override
  String get peptideContentDihexaHalfLife => '十分に確立されていない';

  @override
  String get peptideContentDihexaNotes =>
      '認知機能関連のコミュニティで話題になりますが、非常に実験的です。推奨プロトコルではなく、研究用化合物の参考情報として扱います。';

  @override
  String get peptideContentGhrp2Description =>
      'GHRP-2 は、グレリン受容体アゴニストとして作用する合成成長ホルモン放出ペプチドです。 GH分泌、食欲シグナル伝達、内分泌検査について研究されています。';

  @override
  String get peptideContentGhrp2TypicalDose => '1 回の注射につき 100 ～ 300 mcg';

  @override
  String get peptideContentGhrp2HalfLife => '～20～30分';

  @override
  String get peptideContentGhrp2Notes =>
      '多くの場合、CJC-1295 no-DAC や Sermorelin などの GHRH 類似体と組み合わせられます。イパモレリンよりも食欲、コルチゾール、プロラクチンに影響を与える可能性があります。';

  @override
  String get peptideContentGhrp6Description =>
      'GHRP-6 は、成長ホルモンの放出と食欲シグナル伝達について研究されている合成ヘキサペプチドおよびグレリン受容体アゴニストです。これは、GHRP ファミリーの中で最も古いペプチドの 1 つです。';

  @override
  String get peptideContentGhrp6TypicalDose => '1 回の注射につき 100 ～ 300 mcg';

  @override
  String get peptideContentGhrp6HalfLife => '～20～30分';

  @override
  String get peptideContentGhrp6Notes =>
      'コミュニティでの使用では、食欲の刺激が重視されることがよくあります。食欲への影響が望ましくない場合には、イパモレリンなどのより選択的なオプションが一般的に好まれます。';

  @override
  String get peptideContentHexarelinDescription =>
      'ヘキサレリンは合成成長ホルモン分泌促進物質であり、GH 放出と心血管研究シグナルについて研究されているグレリン受容体アゴニストです。一般に、より強力な GHRP の 1 つと考えられています。';

  @override
  String get peptideContentHexarelinTypicalDose => '1 回の注射につき 100 ～ 200 mcg';

  @override
  String get peptideContentHexarelinHalfLife => '～70分';

  @override
  String get peptideContentHexarelinNotes =>
      '研究コミュニティで議論されている効力と脱感作の懸念のため、イパモレリンよりも保守的にサイクルすることがよくあります。';

  @override
  String get peptideContentIgf1Lr3Description =>
      'IGF-1 LR3 は、結合タンパク質の親和性を低下させ、活性を延長するアミノ酸置換を有する修飾されたインスリン様成長因子 1 類似体です。これは主に、高度なパフォーマンスと細胞増殖の研究の文脈で議論されます。';

  @override
  String get peptideContentIgf1Lr3TypicalDose => '研究プロトコルでは毎日 20 ～ 50 mcg';

  @override
  String get peptideContentIgf1Lr3HalfLife => '約20～30時間';

  @override
  String get peptideContentIgf1Lr3Notes =>
      'よりリスクの高い研究用化合物。グルコースおよび組織増殖シグナル伝達の潜在的な懸念により、医療監督が特に重要になります。';

  @override
  String get peptideContentIgf1DesDescription =>
      'IGF-1 DES は、最初の 3 つのアミノ酸が欠落した短い IGF-1 類似体です。局所組織シグナル伝達研究では、作用時間の短い IGF バリアントとして議論されています。';

  @override
  String get peptideContentIgf1DesTypicalDose => '研究プロトコルでは 20 ～ 50 mcg';

  @override
  String get peptideContentIgf1DesHalfLife => '～20～30分';

  @override
  String get peptideContentIgf1DesNotes =>
      '高度かつ実験的な研究用化合物です。ヒトでの安全性データや適切なモニタリングに関する根拠が限られるため、一般的なプロトコルは提示されていません。';

  @override
  String get peptideContentPegMgfDescription =>
      'PEG-MGF は、メカノ成長因子のペグ化変異体、IGF-1 スプライス変異体ペプチドです。ペグ化は、未修飾の MGF と比較して循環時間を延長することを目的としています。';

  @override
  String get peptideContentPegMgfTypicalDose => '研究プロトコルでは毎週 100 ～ 300 mcg';

  @override
  String get peptideContentPegMgfHalfLife => 'PEG化による拡張';

  @override
  String get peptideContentPegMgfNotes =>
      'パフォーマンスフォーラムでは一般的ですが、承認された治療法ではありません。保守的な追跡デフォルトを使用して、高度な研究エントリとして扱います。';

  @override
  String get peptideContentMk677Description =>
      'MK-677 はイブタモレンとしても知られ、経口的に活性なグレリン受容体アゴニストおよび成長ホルモン分泌促進薬です。これはペプチドではありませんが、一般的に GH 軸ペプチドと並べて議論されます。';

  @override
  String get peptideContentMk677TypicalDose => '毎日10～25mg';

  @override
  String get peptideContentMk677HalfLife => '～24時間';

  @override
  String get peptideContentMk677Notes =>
      '関連する化合物であり、ペプチドではありません。コミュニティでの議論では、食欲、水分保持、睡眠、血糖値のモニタリングに関する考慮事項についてよく言及されます。';

  @override
  String get peptideContentFiveAmino1mqDescription =>
      '5-アミノ-1MQ は、代謝および体組成のコミュニティで議論されている小分子 NNMT 阻害剤です。これはペプチドではありませんが、ペプチドに隣接する長寿スタックと脂肪減少スタックによく現れます。';

  @override
  String get peptideContentFiveAmino1mqTypicalDose => '毎日25～100mg';

  @override
  String get peptideContentFiveAmino1mqHalfLife => '十分に確立されていない';

  @override
  String get peptideContentFiveAmino1mqNotes =>
      'ペプチドではなく関連化合物です。ヒトでの根拠は限定的で、脂肪減少やインスリン感受性に関する結果を保証するものではありません。';

  @override
  String get peptideContentTesofensineDescription =>
      'テソフェンシンは、肥満および神経変性状態について研究されている経口モノアミン再取り込み阻害剤です。これはペプチドではありませんが、体重管理コミュニティでは GLP-1 化合物に関連して頻繁に議論されています。';

  @override
  String get peptideContentTesofensineTypicalDose => '研究では毎日0.25〜0.5 mg';

  @override
  String get peptideContentTesofensineHalfLife => '～9日';

  @override
  String get peptideContentTesofensineNotes =>
      '関連する化合物であり、ペプチドではありません。神経伝達物質経路、血圧、心拍数、相互作用スクリーニングに影響を与えるためです。';

  @override
  String get peptideContentRu58841Description =>
      'RU-58841 は、毛包におけるアンドロゲン受容体シグナル伝達について研究された局所用非ステロイド性抗アンドロゲン剤です。これはペプチドではありませんが、ペプチドに関連する美的コミュニティでよく議論されます。';

  @override
  String get peptideContentRu58841TypicalDose => '非公式プロトコルで毎日 25 ～ 50 mg を局所投与';

  @override
  String get peptideContentRu58841HalfLife => '十分に確立されていない';

  @override
  String get peptideContentRu58841Notes =>
      '関連化合物。ペプチドではなく、承認された医薬品でもありません。品質管理と全身性曝露の懸念が共通の論点です。';

  @override
  String get peptideContentEducationalDisclaimer =>
      '教育目的の参考情報であり、医療上の助言ではありません。研究用ペプチドは、多くの地域でヒトへの使用が承認されていません。必ず資格のある医療従事者に相談してください。';

  @override
  String get twiceWeeklyPickDaysHint => 'このスケジュールには曜日をちょうど2つ選んでください。';

  @override
  String get selectExactlyTwoDaysError => '週2回のスケジュールには曜日をちょうど2つ選択してください。';

  @override
  String get remindersBlockedTitle => 'リマインダーがブロックされています';

  @override
  String get remindersBlockedBody =>
      'PepModでは投与リマインダーがオンになっていますが、システム設定で通知がオフのため、リマインダーを届けられません。';

  @override
  String get openSettingsAction => '設定を開く';

  @override
  String freeTrialBadgeDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count日間無料トライアル',
    );
    return '$_temp0';
  }

  @override
  String freeTrialBadgeWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count週間無料トライアル',
    );
    return '$_temp0';
  }

  @override
  String freeTrialBadgeMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countか月間無料トライアル',
    );
    return '$_temp0';
  }

  @override
  String freeTrialBadgeYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count年間無料トライアル',
    );
    return '$_temp0';
  }

  @override
  String get createCustomCompoundAction => 'カスタム化合物を作成';

  @override
  String get noPeptidesFoundCreateHint =>
      'リファレンスライブラリに一致がありません。カスタム化合物として記録できます。';

  @override
  String get blendSearchHint =>
      'このようなブレンド名には標準的な配合はなく、内容は販売元によって異なります。ここでカスタム化合物として、またはプロトコル作成時にプレブレンドバイアルとして作成し、実際のバイアルの内容を入力してください。';

  @override
  String get typicalDoseReferenceNote => '教育目的で公表されている参考範囲です。推奨や指示ではありません。';

  @override
  String get peptideContentTestosteroneDescription =>
      'テストステロンは内因性のアンドロゲンホルモンです。注射用エステル製剤（シピオン酸エステルやエナント酸エステルなど）は、医師の管理下で行うホルモン療法に使われる処方薬です。この項目はユーザーが入力したスケジュールのための中立的な記録用リファレンスです。';

  @override
  String get peptideContentTestosteroneTypicalDose => 'ユーザー入力のmg';

  @override
  String get peptideContentTestosteroneHalfLife => 'エステルにより異なる';

  @override
  String get peptideContentTestosteroneNotes =>
      '多くの法域で処方箋が必要な規制物質です。資格のある医療専門家の指示があるもののみ記録してください。PepModはテストステロンの投与ガイダンスを提供しません。';

  @override
  String get peptideContentGlutathioneDescription =>
      'グルタチオンは天然に存在するトリペプチド（グルタミン酸-システイン-グリシン）で、主要な細胞内抗酸化物質として機能します。注射剤は一部のウェルネスや臨床の場で使用されています。この項目はユーザーが入力したスケジュールのための中立的な記録用リファレンスです。';

  @override
  String get peptideContentGlutathioneTypicalDose => 'ユーザー入力のmg';

  @override
  String get peptideContentGlutathioneHalfLife => '短い（全身）';

  @override
  String get peptideContentGlutathioneNotes =>
      '注射用グルタチオンの規制状況は国によって異なります。入手・指示された通りの量のみ記録してください。PepModはこの化合物の投与ガイダンスを提供しません。';

  @override
  String get peptideContentKisspeptin10Description =>
      'キスペプチン-10は神経ペプチドであるキスペプチンの10アミノ酸フラグメントで、GnRHシグナル伝達と生殖軸の調節における役割が研究されています。管理された研究以外でのヒトのデータは限られています。この項目はユーザーが入力したスケジュールのための中立的な記録用リファレンスです。';

  @override
  String get peptideContentKisspeptin10TypicalDose => 'ユーザー入力';

  @override
  String get peptideContentKisspeptin10HalfLife => '約数分（報告値）';

  @override
  String get peptideContentKisspeptin10Notes =>
      '確立されたプロトコルのない研究用化合物です。ユーザーが入力した量のみ記録してください。PepModはこの化合物の投与ガイダンスを提供しません。';

  @override
  String get peptideContentSluPp332Description =>
      'SLU-PP-332は運動生理学研究で前臨床的に調査されている実験的な低分子ERRアゴニストです。ペプチドではなく、ヒトでの安全性や有効性の確立されたデータはありません。この項目はユーザーが入力したスケジュールのための中立的な記録用リファレンスです。';

  @override
  String get peptideContentSluPp332TypicalDose => 'ユーザー入力';

  @override
  String get peptideContentSluPp332HalfLife => '十分に確立されていない';

  @override
  String get peptideContentSluPp332Notes =>
      'ヒトでの試験がない極めて実験的な研究用化合物です。関連化合物であり、ペプチドではありません。ユーザーが入力した量のみ記録してください。PepModはこの化合物の投与ガイダンスを提供しません。';

  @override
  String get investigationalDosingLabel => '治験段階 — 承認された投与量なし';

  @override
  String get investigationalProtocolEntryWarning =>
      'この治験段階の化合物に承認されたプロトコルはありません。PepModは量やスケジュールを提示しません。記録値は自分で明示的に入力してください。';

  @override
  String get doseUnitPreferenceLabel => '投与量の単位';

  @override
  String get doseUnitPreferenceDescription =>
      '質量で表す投与量の表示方法を選択します。実際の投与量は変わりません。';

  @override
  String get doseUnitPreferenceOriginal => '入力時の単位';

  @override
  String get doseUnitPreferencePreview => '500 mcg = 0.5 mg';

  @override
  String get doseUnitPreferenceIuNote => 'IUとシリンジの目盛り単位は変わりません。';
}
