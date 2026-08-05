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
}
