import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr')
  ];

  /// No description provided for @appName.
  ///
  /// In tr, this message translates to:
  /// **'Dama Koleksiyonu'**
  String get appName;

  /// No description provided for @settingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsTitle;

  /// No description provided for @languageHeader.
  ///
  /// In tr, this message translates to:
  /// **'DİL'**
  String get languageHeader;

  /// No description provided for @language.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get language;

  /// No description provided for @languageSelectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Dil Seçin'**
  String get languageSelectionTitle;

  /// No description provided for @languageSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In tr, this message translates to:
  /// **'İngilizce'**
  String get languageEnglish;

  /// No description provided for @languageTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get languageTurkish;

  /// No description provided for @appearanceHeader.
  ///
  /// In tr, this message translates to:
  /// **'GÖRÜNÜM'**
  String get appearanceHeader;

  /// No description provided for @themeLight.
  ///
  /// In tr, this message translates to:
  /// **'Açık'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get themeSystem;

  /// No description provided for @themeDark.
  ///
  /// In tr, this message translates to:
  /// **'Koyu'**
  String get themeDark;

  /// No description provided for @gameExperienceHeader.
  ///
  /// In tr, this message translates to:
  /// **'OYUN DENEYİMİ'**
  String get gameExperienceHeader;

  /// No description provided for @soundEffects.
  ///
  /// In tr, this message translates to:
  /// **'Ses Efektleri'**
  String get soundEffects;

  /// No description provided for @haptics.
  ///
  /// In tr, this message translates to:
  /// **'Dokunsal Geri Bildirim'**
  String get haptics;

  /// No description provided for @showCoordinates.
  ///
  /// In tr, this message translates to:
  /// **'Koordinatları Göster'**
  String get showCoordinates;

  /// No description provided for @gamePreferencesHeader.
  ///
  /// In tr, this message translates to:
  /// **'OYUN TERCİHLERİ'**
  String get gamePreferencesHeader;

  /// No description provided for @gamePreferencesDescription.
  ///
  /// In tr, this message translates to:
  /// **'Bilgisayara karşı oynarken hangi renkle başlamak istediğinizi seçin.'**
  String get gamePreferencesDescription;

  /// No description provided for @colorWhite.
  ///
  /// In tr, this message translates to:
  /// **'Beyaz'**
  String get colorWhite;

  /// No description provided for @colorRandom.
  ///
  /// In tr, this message translates to:
  /// **'Rastgele'**
  String get colorRandom;

  /// No description provided for @colorBlack.
  ///
  /// In tr, this message translates to:
  /// **'Siyah'**
  String get colorBlack;

  /// No description provided for @progressHeader.
  ///
  /// In tr, this message translates to:
  /// **'İLERLEME'**
  String get progressHeader;

  /// No description provided for @resetAllRanks.
  ///
  /// In tr, this message translates to:
  /// **'Tüm Rütbeleri Sıfırla'**
  String get resetAllRanks;

  /// No description provided for @resetProgressConfirmationTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlerleme Sıfırlansın mı?'**
  String get resetProgressConfirmationTitle;

  /// No description provided for @resetProgressConfirmationBody.
  ///
  /// In tr, this message translates to:
  /// **'Tüm oyun modlarındaki rütbe ilerlemeniz kalıcı olarak silinecektir. Bu işlem geri alınamaz.'**
  String get resetProgressConfirmationBody;

  /// No description provided for @dialogCancel.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get dialogCancel;

  /// No description provided for @dialogReset.
  ///
  /// In tr, this message translates to:
  /// **'Sıfırla'**
  String get dialogReset;

  /// No description provided for @progressResetSuccess.
  ///
  /// In tr, this message translates to:
  /// **'İlerleme Sıfırlandı'**
  String get progressResetSuccess;

  /// No description provided for @dialogOK.
  ///
  /// In tr, this message translates to:
  /// **'Tamam'**
  String get dialogOK;

  /// No description provided for @mainMenuPlayButtonAI.
  ///
  /// In tr, this message translates to:
  /// **'Seviye Seç'**
  String get mainMenuPlayButtonAI;

  /// No description provided for @mainMenuPlayButtonHuman.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Oyun'**
  String get mainMenuPlayButtonHuman;

  /// No description provided for @mainMenuContinue.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get mainMenuContinue;

  /// No description provided for @mainMenuOpponentAI.
  ///
  /// In tr, this message translates to:
  /// **'Yapay Zeka'**
  String get mainMenuOpponentAI;

  /// No description provided for @mainMenuOpponentHuman.
  ///
  /// In tr, this message translates to:
  /// **'İki Kişilik'**
  String get mainMenuOpponentHuman;

  /// No description provided for @mainMenuRules.
  ///
  /// In tr, this message translates to:
  /// **'Kurallar'**
  String get mainMenuRules;

  /// No description provided for @mainMenuExploreThemes.
  ///
  /// In tr, this message translates to:
  /// **'Temaları Keşfet'**
  String get mainMenuExploreThemes;

  /// No description provided for @close.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get close;

  /// AI seviyesini gösterir
  ///
  /// In tr, this message translates to:
  /// **'Seviye {level}'**
  String levelNumber(int level);

  /// No description provided for @themeStoreTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tema Mağazası'**
  String get themeStoreTitle;

  /// No description provided for @searchBoardPlaceholder.
  ///
  /// In tr, this message translates to:
  /// **'Tahta Ara'**
  String get searchBoardPlaceholder;

  /// No description provided for @searchPiecePlaceholder.
  ///
  /// In tr, this message translates to:
  /// **'Taş Ara'**
  String get searchPiecePlaceholder;

  /// No description provided for @boards.
  ///
  /// In tr, this message translates to:
  /// **'Tahtalar'**
  String get boards;

  /// No description provided for @pieces.
  ///
  /// In tr, this message translates to:
  /// **'Taşlar'**
  String get pieces;

  /// No description provided for @noResults.
  ///
  /// In tr, this message translates to:
  /// **'Sonuç bulunamadı'**
  String get noResults;

  /// No description provided for @loadingStatusInitializing.
  ///
  /// In tr, this message translates to:
  /// **'Başlatılıyor...'**
  String get loadingStatusInitializing;

  /// No description provided for @loadingStatusSettings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar yükleniyor...'**
  String get loadingStatusSettings;

  /// No description provided for @loadingStatusUI.
  ///
  /// In tr, this message translates to:
  /// **'Arayüz optimize ediliyor...'**
  String get loadingStatusUI;

  /// No description provided for @loadingStatusReady.
  ///
  /// In tr, this message translates to:
  /// **'Hazır!'**
  String get loadingStatusReady;

  /// No description provided for @gameScreenConfirmExitTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ana Menüye Dön'**
  String get gameScreenConfirmExitTitle;

  /// No description provided for @gameScreenConfirmExitBody.
  ///
  /// In tr, this message translates to:
  /// **'Devam eden oyunu kaydetmek ister misiniz?'**
  String get gameScreenConfirmExitBody;

  /// No description provided for @gameScreenSaveAndExit.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet ve Çık'**
  String get gameScreenSaveAndExit;

  /// No description provided for @gameScreenExitWithoutSaving.
  ///
  /// In tr, this message translates to:
  /// **'Kaydetmeden Çık'**
  String get gameScreenExitWithoutSaving;

  /// No description provided for @gameScreenPaused.
  ///
  /// In tr, this message translates to:
  /// **'Duraklatıldı'**
  String get gameScreenPaused;

  /// No description provided for @gameScreenResume.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get gameScreenResume;

  /// No description provided for @gameScreenRestart.
  ///
  /// In tr, this message translates to:
  /// **'Yeniden Başlat'**
  String get gameScreenRestart;

  /// No description provided for @gameScreenReturnToMenu.
  ///
  /// In tr, this message translates to:
  /// **'Ana Menüye Dön'**
  String get gameScreenReturnToMenu;

  /// No description provided for @gameOverWinTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tebrikler, Kazandın!'**
  String get gameOverWinTitle;

  /// No description provided for @gameOverWinBody.
  ///
  /// In tr, this message translates to:
  /// **'Harika bir zafer!'**
  String get gameOverWinBody;

  /// No description provided for @gameOverNewRankBody.
  ///
  /// In tr, this message translates to:
  /// **'Yeni bir rütbe kazandın!'**
  String get gameOverNewRankBody;

  /// No description provided for @gameOverNewRankTitle.
  ///
  /// In tr, this message translates to:
  /// **'RÜTBE ATLANDI!'**
  String get gameOverNewRankTitle;

  /// No description provided for @gameOverLoseTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaybettin'**
  String get gameOverLoseTitle;

  /// No description provided for @gameOverLoseBody.
  ///
  /// In tr, this message translates to:
  /// **'Daha sıkı çalışmalısın.'**
  String get gameOverLoseBody;

  /// No description provided for @gameOverDrawTitle.
  ///
  /// In tr, this message translates to:
  /// **'Berabere!'**
  String get gameOverDrawTitle;

  /// No description provided for @gameOverTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oyun Bitti!'**
  String get gameOverTitle;

  /// No description provided for @gameOverWinner.
  ///
  /// In tr, this message translates to:
  /// **'Kazanan: {winner}'**
  String gameOverWinner(String winner);

  /// No description provided for @gameOverNewGame.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Oyun'**
  String get gameOverNewGame;

  /// No description provided for @playerYou.
  ///
  /// In tr, this message translates to:
  /// **'Siz'**
  String get playerYou;

  /// No description provided for @playerComputer.
  ///
  /// In tr, this message translates to:
  /// **'Bilgisayar'**
  String get playerComputer;

  /// No description provided for @playerWhite.
  ///
  /// In tr, this message translates to:
  /// **'Beyaz'**
  String get playerWhite;

  /// No description provided for @playerBlack.
  ///
  /// In tr, this message translates to:
  /// **'Siyah'**
  String get playerBlack;

  /// No description provided for @aiThinking.
  ///
  /// In tr, this message translates to:
  /// **'Düşünüyor...'**
  String get aiThinking;

  /// No description provided for @nextMove.
  ///
  /// In tr, this message translates to:
  /// **'Sıradaki Hamle'**
  String get nextMove;

  /// No description provided for @waiting.
  ///
  /// In tr, this message translates to:
  /// **'Bekleniyor...'**
  String get waiting;

  /// No description provided for @tutorialTitle.
  ///
  /// In tr, this message translates to:
  /// **'{gameMode} Öğreticisi'**
  String tutorialTitle(String gameMode);

  /// No description provided for @tutorialNext.
  ///
  /// In tr, this message translates to:
  /// **'İleri'**
  String get tutorialNext;

  /// No description provided for @tutorialPrevious.
  ///
  /// In tr, this message translates to:
  /// **'Geri'**
  String get tutorialPrevious;

  /// No description provided for @tutorialPlay.
  ///
  /// In tr, this message translates to:
  /// **'Oynat'**
  String get tutorialPlay;

  /// No description provided for @rankNovice.
  ///
  /// In tr, this message translates to:
  /// **'Acemi'**
  String get rankNovice;

  /// No description provided for @rankApprentice.
  ///
  /// In tr, this message translates to:
  /// **'Çırak'**
  String get rankApprentice;

  /// No description provided for @rankJourneyman.
  ///
  /// In tr, this message translates to:
  /// **'Kalfa'**
  String get rankJourneyman;

  /// No description provided for @rankMaster.
  ///
  /// In tr, this message translates to:
  /// **'Usta'**
  String get rankMaster;

  /// No description provided for @rankExpert.
  ///
  /// In tr, this message translates to:
  /// **'Uzman'**
  String get rankExpert;

  /// No description provided for @rankVirtuoso.
  ///
  /// In tr, this message translates to:
  /// **'Virtüöz'**
  String get rankVirtuoso;

  /// No description provided for @rankGrandmaster.
  ///
  /// In tr, this message translates to:
  /// **'Büyük Usta'**
  String get rankGrandmaster;

  /// No description provided for @drawReasonThreefoldRepetition.
  ///
  /// In tr, this message translates to:
  /// **'Aynı pozisyon üç kez tekrarlandı.'**
  String get drawReasonThreefoldRepetition;

  /// No description provided for @drawReasonFiftyMoveRule.
  ///
  /// In tr, this message translates to:
  /// **'50 hamle boyunca taş alınmadı veya dama yapılmadı.'**
  String get drawReasonFiftyMoveRule;

  /// No description provided for @drawReasonFortyMoveRule.
  ///
  /// In tr, this message translates to:
  /// **'40 hamle boyunca taş alınmadı veya dama yapılmadı.'**
  String get drawReasonFortyMoveRule;

  /// No description provided for @drawReasonTwentyFiveMoveRule.
  ///
  /// In tr, this message translates to:
  /// **'25 hamle boyunca taş alınmadı veya dama yapılmadı.'**
  String get drawReasonTwentyFiveMoveRule;

  /// No description provided for @drawReasonFifteenMoveRule.
  ///
  /// In tr, this message translates to:
  /// **'15 hamle boyunca taş alınmadı veya dama yapılmadı.'**
  String get drawReasonFifteenMoveRule;

  /// No description provided for @drawReasonInsufficientMaterial.
  ///
  /// In tr, this message translates to:
  /// **'Kalan taşlar oyunu kazanmak için yetersiz.'**
  String get drawReasonInsufficientMaterial;

  /// No description provided for @drawReasonStalemate.
  ///
  /// In tr, this message translates to:
  /// **'Her iki oyuncunun da geçerli hamlesi kalmadı.'**
  String get drawReasonStalemate;

  /// No description provided for @gameModeTurkishName.
  ///
  /// In tr, this message translates to:
  /// **'Türk Daması'**
  String get gameModeTurkishName;

  /// No description provided for @gameModeTurkishDescription.
  ///
  /// In tr, this message translates to:
  /// **'8x8 tahtada oynanır. Taşlar ileri ve yanlara doğru hareket eder.'**
  String get gameModeTurkishDescription;

  /// No description provided for @gameModeEnglishName.
  ///
  /// In tr, this message translates to:
  /// **'İngiliz Daması'**
  String get gameModeEnglishName;

  /// No description provided for @gameModeEnglishDescription.
  ///
  /// In tr, this message translates to:
  /// **'8x8 tahtada oynanır. Normal taşlar geriye doğru yiyemez ve damalar uçmaz.'**
  String get gameModeEnglishDescription;

  /// No description provided for @gameModeInternationalName.
  ///
  /// In tr, this message translates to:
  /// **'Uluslararası Dama'**
  String get gameModeInternationalName;

  /// No description provided for @gameModeInternationalDescription.
  ///
  /// In tr, this message translates to:
  /// **'10x10 tahtada oynanır. En çok yeme zorunluluğu vardır ve damalar uçar.'**
  String get gameModeInternationalDescription;

  /// No description provided for @gameModeRussianName.
  ///
  /// In tr, this message translates to:
  /// **'Rus Daması'**
  String get gameModeRussianName;

  /// No description provided for @gameModeRussianDescription.
  ///
  /// In tr, this message translates to:
  /// **'Yiyerek dama olan taş, aynı hamlede yemeye devam edebilir.'**
  String get gameModeRussianDescription;

  /// No description provided for @gameModeSpanishName.
  ///
  /// In tr, this message translates to:
  /// **'İspanyol Daması'**
  String get gameModeSpanishName;

  /// No description provided for @gameModeSpanishDescription.
  ///
  /// In tr, this message translates to:
  /// **'Normal taşlar sadece ileri yiyebilir/gider. En çok yeme zorunludur ve damalar uçar.'**
  String get gameModeSpanishDescription;

  /// No description provided for @gameModeAntiCheckersName.
  ///
  /// In tr, this message translates to:
  /// **'Ters Dama'**
  String get gameModeAntiCheckersName;

  /// No description provided for @gameModeAntiCheckersDescription.
  ///
  /// In tr, this message translates to:
  /// **'Tüm taşlarını ilk bitiren veya hamlesi kalmayan oyuncu kazanır.'**
  String get gameModeAntiCheckersDescription;

  /// No description provided for @ruleTitleManMove.
  ///
  /// In tr, this message translates to:
  /// **'Normal Taş Hareketi'**
  String get ruleTitleManMove;

  /// No description provided for @ruleDescManMoveForward.
  ///
  /// In tr, this message translates to:
  /// **'Normal taşlar sadece ileri doğru bir kare çapraz hareket eder.'**
  String get ruleDescManMoveForward;

  /// No description provided for @ruleTitleManCapture.
  ///
  /// In tr, this message translates to:
  /// **'Normal Taş Yeme'**
  String get ruleTitleManCapture;

  /// No description provided for @ruleDescManCaptureForward.
  ///
  /// In tr, this message translates to:
  /// **'Normal taşlar sadece ileri doğru çapraz yiyebilir.'**
  String get ruleDescManCaptureForward;

  /// No description provided for @ruleDescManCaptureBackward.
  ///
  /// In tr, this message translates to:
  /// **'Normal taşlar hem ileri hem de geri çapraz yiyebilir.'**
  String get ruleDescManCaptureBackward;

  /// No description provided for @ruleTitleKingMove.
  ///
  /// In tr, this message translates to:
  /// **'Dama Hareketi'**
  String get ruleTitleKingMove;

  /// No description provided for @ruleDescKingShort.
  ///
  /// In tr, this message translates to:
  /// **'Dama olan taş (King), her yöne sadece bir kare çapraz hareket eder ve yer.'**
  String get ruleDescKingShort;

  /// No description provided for @ruleDescKingFlying.
  ///
  /// In tr, this message translates to:
  /// **'Dama olan taş (King), her yöne boş kareler üzerinden kayarak (uçarak) hareket eder ve yer.'**
  String get ruleDescKingFlying;

  /// No description provided for @ruleTitleMandatoryCapture.
  ///
  /// In tr, this message translates to:
  /// **'Zorunlu Yeme'**
  String get ruleTitleMandatoryCapture;

  /// No description provided for @ruleDescMandatoryCapture.
  ///
  /// In tr, this message translates to:
  /// **'Yeme hamlesi varsa, yapılması zorunludur.'**
  String get ruleDescMandatoryCapture;

  /// No description provided for @ruleTitleMaxCapture.
  ///
  /// In tr, this message translates to:
  /// **'En Çok Yeme'**
  String get ruleTitleMaxCapture;

  /// No description provided for @ruleDescMaxCapture.
  ///
  /// In tr, this message translates to:
  /// **'Birden fazla yeme yolu varsa, en çok sayıda taşı yiyen hamle dizisi zorunludur.'**
  String get ruleDescMaxCapture;

  /// No description provided for @ruleTitleTurkishManMove.
  ///
  /// In tr, this message translates to:
  /// **'Normal Taş Hareketi'**
  String get ruleTitleTurkishManMove;

  /// No description provided for @ruleDescTurkishManMove.
  ///
  /// In tr, this message translates to:
  /// **'Normal taşlar ileri ve yanlara doğru bir kare hareket eder.'**
  String get ruleDescTurkishManMove;

  /// No description provided for @ruleTitleTurkishCapture.
  ///
  /// In tr, this message translates to:
  /// **'Yeme Kuralı'**
  String get ruleTitleTurkishCapture;

  /// No description provided for @ruleDescTurkishCapture.
  ///
  /// In tr, this message translates to:
  /// **'Taşlar, rakip taşın üzerinden düz veya yan atlayarak yer.'**
  String get ruleDescTurkishCapture;

  /// No description provided for @ruleTitlePromotion.
  ///
  /// In tr, this message translates to:
  /// **'Terfi Kuralı'**
  String get ruleTitlePromotion;

  /// No description provided for @ruleDescPromotionStops.
  ///
  /// In tr, this message translates to:
  /// **'Yeme hamlesi sırasında terfi eden taş, hamlesini durdurur. Sıra rakibe geçer.'**
  String get ruleDescPromotionStops;

  /// No description provided for @ruleDescPromotionContinues.
  ///
  /// In tr, this message translates to:
  /// **'Yeme hamlesi sırasında terfi eden taş, aynı hamle içinde Dama olarak yemeye devam edebilir.'**
  String get ruleDescPromotionContinues;

  /// No description provided for @ruleTitleAntiCheckersAim.
  ///
  /// In tr, this message translates to:
  /// **'Amaç'**
  String get ruleTitleAntiCheckersAim;

  /// No description provided for @ruleDescAntiCheckersAim.
  ///
  /// In tr, this message translates to:
  /// **'Oyunun amacı, tüm taşlarını rakibe yedirmek veya hamle yapamaz duruma düşmektir.'**
  String get ruleDescAntiCheckersAim;

  /// No description provided for @tutorialStepWelcomeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hoş Geldiniz'**
  String get tutorialStepWelcomeTitle;

  /// No description provided for @tutorialStepWelcomeDescTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Türk Daması\'na hoş geldiniz! Taşlar her iki taraf için de ikinci ve üçüncü sıralara dizilir. Amaç, rakibin tüm taşlarını yemektir.'**
  String get tutorialStepWelcomeDescTurkish;

  /// No description provided for @tutorialStepManMoveDescTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Piyonlar bir kare ileri veya yana doğru hareket eder. Geriye doğru hareket edemezler.'**
  String get tutorialStepManMoveDescTurkish;

  /// No description provided for @tutorialStepCaptureTitle.
  ///
  /// In tr, this message translates to:
  /// **'Taş Alma'**
  String get tutorialStepCaptureTitle;

  /// No description provided for @tutorialStepCaptureDescTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Taşlar, rakip bir taşın üzerinden atlayarak arkasındaki boş kareye gelerek alınır.'**
  String get tutorialStepCaptureDescTurkish;

  /// No description provided for @tutorialStepMaxCaptureTitle.
  ///
  /// In tr, this message translates to:
  /// **'En Çok Taşı Alma'**
  String get tutorialStepMaxCaptureTitle;

  /// No description provided for @tutorialStepMaxCaptureDesc.
  ///
  /// In tr, this message translates to:
  /// **'Birden fazla taş alma seçeneği varsa, en çok sayıda taşı alacağınız yolu seçmek zorundasınız.'**
  String get tutorialStepMaxCaptureDesc;

  /// No description provided for @tutorialStepPromotionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Dama Olma (Terfi)'**
  String get tutorialStepPromotionTitle;

  /// No description provided for @tutorialStepPromotionDesc.
  ///
  /// In tr, this message translates to:
  /// **'Bir piyon rakibin son sırasına ulaştığında, Dama olur ve özel yetenekler kazanır.'**
  String get tutorialStepPromotionDesc;

  /// No description provided for @tutorialStepKingMoveDescTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Dama, satrançtaki kale gibi ileri, geri ve yanlara doğru istediği kadar boş karede hareket edebilir ve aynı hat üzerindeki bir taşı üzerinden atlayarak yer.'**
  String get tutorialStepKingMoveDescTurkish;

  /// No description provided for @tutorialStepDrawTitle.
  ///
  /// In tr, this message translates to:
  /// **'Beraberlik Durumları'**
  String get tutorialStepDrawTitle;

  /// No description provided for @tutorialStepDrawDescTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Aynı pozisyon üç kez tekrarlanırsa veya 25 hamle boyunca hiç taş alınmazsa oyun berabere biter.'**
  String get tutorialStepDrawDescTurkish;

  /// No description provided for @tutorialStepWelcomeDescEnglish.
  ///
  /// In tr, this message translates to:
  /// **'İngiliz Daması\'na hoş geldiniz! Amaç, rakibin tüm taşlarını yemektir. Tüm hamleler ve taş almalar koyu renkli karelerde yapılır.'**
  String get tutorialStepWelcomeDescEnglish;

  /// No description provided for @tutorialStepManMoveDescEnglish.
  ///
  /// In tr, this message translates to:
  /// **'Piyonlar sadece boş bir kareye doğru ileri çapraz bir adım hareket eder.'**
  String get tutorialStepManMoveDescEnglish;

  /// No description provided for @tutorialStepCaptureDescEnglish.
  ///
  /// In tr, this message translates to:
  /// **'Piyonlar, rakip bir taşın üzerinden ileri çapraz atlayarak hemen arkasındaki boş kareye gelerek taş alırlar.'**
  String get tutorialStepCaptureDescEnglish;

  /// No description provided for @tutorialStepManCannotCaptureBackwardTitle.
  ///
  /// In tr, this message translates to:
  /// **'Geriye Doğru Yiyememe'**
  String get tutorialStepManCannotCaptureBackwardTitle;

  /// No description provided for @tutorialStepManCannotCaptureBackwardDesc.
  ///
  /// In tr, this message translates to:
  /// **'Piyonlar geriye doğru taş alamazlar. Burada, beyaz piyon arkasındaki siyah piyonu alamaz.'**
  String get tutorialStepManCannotCaptureBackwardDesc;

  /// No description provided for @tutorialStepMultipleCaptureTitle.
  ///
  /// In tr, this message translates to:
  /// **'Çoklu Taş Alma'**
  String get tutorialStepMultipleCaptureTitle;

  /// No description provided for @tutorialStepMultipleCaptureDesc.
  ///
  /// In tr, this message translates to:
  /// **'Bir taş alma hamlesi sizi başka bir taş alma pozisyonuna getirirse, aynı turda taş almaya devam etmelisiniz.'**
  String get tutorialStepMultipleCaptureDesc;

  /// No description provided for @tutorialStepPromotionDescEnglish.
  ///
  /// In tr, this message translates to:
  /// **'Bir piyon, başlangıç konumundan en uzak sıraya ulaştığında Dama\'ya terfi eder. Bir taş terfi ettiğinde hamle sırası sona erer.'**
  String get tutorialStepPromotionDescEnglish;

  /// No description provided for @tutorialStepKingMoveDescEnglish.
  ///
  /// In tr, this message translates to:
  /// **'Bir Dama, ileri veya geri olmak üzere her yöne çapraz olarak bir adım hareket edebilir ve taş alabilir.'**
  String get tutorialStepKingMoveDescEnglish;

  /// No description provided for @tutorialStepDrawDescEnglish.
  ///
  /// In tr, this message translates to:
  /// **'Aynı pozisyon üç kez tekrarlanırsa veya anlaşma ile oyun berabere biter. Ayrıca, bir damaya karşı bir dama kalması durumunda da oyun beraberedir.'**
  String get tutorialStepDrawDescEnglish;

  /// No description provided for @tutorialStepWelcomeDescInternational.
  ///
  /// In tr, this message translates to:
  /// **'10x10\'luk bir tahtada oynanan Uluslararası Dama\'ya hoş geldiniz! Kurallar diğer varyantlara benzer, ancak bazı önemli farkları vardır.'**
  String get tutorialStepWelcomeDescInternational;

  /// No description provided for @tutorialStepManCaptureDescInternational.
  ///
  /// In tr, this message translates to:
  /// **'Piyonlar ileri çapraz hareket eder ancak hem ileri hem de geri çapraz taş alabilirler.'**
  String get tutorialStepManCaptureDescInternational;

  /// No description provided for @tutorialStepKingMoveDescInternational.
  ///
  /// In tr, this message translates to:
  /// **'Dama \'uçar\'. Herhangi bir yöne doğru istediği kadar boş karede çapraz olarak hareket edebilir.'**
  String get tutorialStepKingMoveDescInternational;

  /// No description provided for @tutorialStepKingCaptureTitle.
  ///
  /// In tr, this message translates to:
  /// **'Dama ile Taş Alma'**
  String get tutorialStepKingCaptureTitle;

  /// No description provided for @tutorialStepKingCaptureDesc.
  ///
  /// In tr, this message translates to:
  /// **'Uçan bir Dama, yolu açık olduğu sürece bir taşın üzerinden atlayarak arkasındaki herhangi bir boş kareye konarak uzaktan taş alabilir.'**
  String get tutorialStepKingCaptureDesc;

  /// No description provided for @tutorialStepKingMultipleCaptureTitle.
  ///
  /// In tr, this message translates to:
  /// **'Dama ile Çoklu Taş Alma'**
  String get tutorialStepKingMultipleCaptureTitle;

  /// No description provided for @tutorialStepKingMultipleCaptureDesc.
  ///
  /// In tr, this message translates to:
  /// **'Bir Dama, genellikle her atlayıştan sonra yön değiştirerek bir dizi taş alma hamlesi yapabilir.'**
  String get tutorialStepKingMultipleCaptureDesc;

  /// No description provided for @tutorialStepDrawDescInternational.
  ///
  /// In tr, this message translates to:
  /// **'Aynı pozisyon üç kez tekrarlanırsa veya 50 hamle boyunca piyon hamlesi veya taş alma olmazsa oyun berabere biter. İki damanın bir damaya karşı olduğu bazı oyun sonları da beraberedir.'**
  String get tutorialStepDrawDescInternational;

  /// No description provided for @tutorialStepLosingAimTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oyunun Amacı'**
  String get tutorialStepLosingAimTitle;

  /// No description provided for @tutorialStepLosingAimDesc.
  ///
  /// In tr, this message translates to:
  /// **'Ters Dama\'ya hoş geldiniz! Amaç, normal damanın tam tersidir: tüm taşlarınızı kaybederek veya yasal bir hamleniz kalmayarak kazanırsınız.'**
  String get tutorialStepLosingAimDesc;

  /// No description provided for @tutorialStepMandatoryCaptureDescLosing.
  ///
  /// In tr, this message translates to:
  /// **'Tıpkı normal damada olduğu gibi, taş almak zorunludur. Fırsatınız varsa taşlarınızı rakibe vermek zorundasınız!'**
  String get tutorialStepMandatoryCaptureDescLosing;

  /// No description provided for @tutorialStepTrapTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tuzak Kurma'**
  String get tutorialStepTrapTitle;

  /// No description provided for @tutorialStepTrapDesc.
  ///
  /// In tr, this message translates to:
  /// **'Yaygın bir strateji, rakibinizi birçok taşınızı alacağı uzun bir taş alma dizisine zorlayacak bir konuma getirmektir.'**
  String get tutorialStepTrapDesc;

  /// No description provided for @tutorialStepFallingIntoTrapTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tuzağa Düşme'**
  String get tutorialStepFallingIntoTrapTitle;

  /// No description provided for @tutorialStepFallingIntoTrapDesc.
  ///
  /// In tr, this message translates to:
  /// **'Siyah oyuncu şimdi beyaz taşı almak zorunda, ki bu tam da Beyaz\'ın istediği şeydi.'**
  String get tutorialStepFallingIntoTrapDesc;

  /// No description provided for @tutorialStepLosingEndgameTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oyun Sonu'**
  String get tutorialStepLosingEndgameTitle;

  /// No description provided for @tutorialStepLosingEndgameDesc.
  ///
  /// In tr, this message translates to:
  /// **'Oyun, bir oyuncunun tahtada hiç taşı kalmadığında veya hamle yapamadığında sona erer. O oyuncu kazanır! Burada, Siyah hiç taşı kalmadığı için kazanmıştır.'**
  String get tutorialStepLosingEndgameDesc;

  /// No description provided for @tutorialStepDrawDescLosing.
  ///
  /// In tr, this message translates to:
  /// **'Beraberlik nadirdir ancak örneğin bir pozisyonun üç kez tekrarlanmasıyla meydana gelebilir.'**
  String get tutorialStepDrawDescLosing;

  /// No description provided for @tutorialStepWelcomeDescRussian.
  ///
  /// In tr, this message translates to:
  /// **'Rus Daması\'na (Şaški) hoş geldiniz! Benzersiz bir terfi kuralı vardır.'**
  String get tutorialStepWelcomeDescRussian;

  /// No description provided for @tutorialStepManCaptureBackwardTitle.
  ///
  /// In tr, this message translates to:
  /// **'Piyonla Geriye Taş Alma'**
  String get tutorialStepManCaptureBackwardTitle;

  /// No description provided for @tutorialStepManCaptureBackwardDesc.
  ///
  /// In tr, this message translates to:
  /// **'Uluslararası Dama\'da olduğu gibi, piyonlar ileri hareket eder ancak hem ileri hem de geri taş alabilirler.'**
  String get tutorialStepManCaptureBackwardDesc;

  /// No description provided for @tutorialStepPromotionDescRussian.
  ///
  /// In tr, this message translates to:
  /// **'Bir piyon, taş almadan rakibin son sırasına ulaştığında Dama\'ya terfi eder ve sıra sona erer.'**
  String get tutorialStepPromotionDescRussian;

  /// No description provided for @tutorialStepPromotionRuleTitle.
  ///
  /// In tr, this message translates to:
  /// **'Özel Terfi Kuralı'**
  String get tutorialStepPromotionRuleTitle;

  /// No description provided for @tutorialStepPromotionRuleDescRussian.
  ///
  /// In tr, this message translates to:
  /// **'ANA KURAL: Eğer bir piyon, taş alarak terfi sırasına ulaşırsa, anında Dama olur ve mümkünse aynı turda Dama olarak taş almaya DEVAM ETMEK ZORUNDADIR.'**
  String get tutorialStepPromotionRuleDescRussian;

  /// No description provided for @tutorialStepDrawDescRussian.
  ///
  /// In tr, this message translates to:
  /// **'Pozisyonun üç kez tekrarlanmasıyla veya tahtada sadece damalar varken 15 hamle boyunca taş alınmazsa oyun berabere bitebilir.'**
  String get tutorialStepDrawDescRussian;

  /// No description provided for @tutorialStepWelcomeDescSpanish.
  ///
  /// In tr, this message translates to:
  /// **'İspanyol Daması\'na hoş geldiniz! Bu varyant, İngiliz ve Uluslararası Dama kurallarını birleştirir.'**
  String get tutorialStepWelcomeDescSpanish;

  /// No description provided for @tutorialStepManMoveDescSpanish.
  ///
  /// In tr, this message translates to:
  /// **'Piyonlar, tıpkı İngiliz Daması\'nda olduğu gibi, sadece ileri çapraz hareket eder ve taş alır.'**
  String get tutorialStepManMoveDescSpanish;

  /// No description provided for @tutorialStepMandatoryCaptureTitle.
  ///
  /// In tr, this message translates to:
  /// **'Zorunlu Taş Alma'**
  String get tutorialStepMandatoryCaptureTitle;

  /// No description provided for @tutorialStepMandatoryCaptureDescSpanish.
  ///
  /// In tr, this message translates to:
  /// **'Taş almak zorunludur. Birden fazla taş alma seçeneği varsa, birini seçmelisiniz; piyonlar için \'en çok yeme\' kuralı yoktur.'**
  String get tutorialStepMandatoryCaptureDescSpanish;

  /// No description provided for @tutorialStepPromotionDescSpanish.
  ///
  /// In tr, this message translates to:
  /// **'Bir piyon en uzak sıraya ulaştığında, Dama\'ya terfi eder. Terfi üzerine sıra sona erer.'**
  String get tutorialStepPromotionDescSpanish;

  /// No description provided for @tutorialStepKingMoveDescSpanish.
  ///
  /// In tr, this message translates to:
  /// **'Damalar \'uçar\', yani Uluslararası Dama\'da olduğu gibi birden fazla kare üzerinden hareket edebilir ve taş alabilirler.'**
  String get tutorialStepKingMoveDescSpanish;

  /// No description provided for @tutorialStepDrawDescSpanish.
  ///
  /// In tr, this message translates to:
  /// **'Pozisyonun üç kez tekrarlanmasıyla veya 50 hamle boyunca önemli bir hamle (taş alma veya piyon hamlesi) yapılmazsa oyun berabere bitebilir.'**
  String get tutorialStepDrawDescSpanish;

  /// No description provided for @tutorialStepManMoveTitle.
  ///
  /// In tr, this message translates to:
  /// **'Piyon Hareketi'**
  String get tutorialStepManMoveTitle;

  /// No description provided for @tutorialStepKingMoveTitle.
  ///
  /// In tr, this message translates to:
  /// **'Dama Hareketi'**
  String get tutorialStepKingMoveTitle;

  /// No description provided for @tutorialStepManCaptureTitle.
  ///
  /// In tr, this message translates to:
  /// **'Piyonla Taş Alma'**
  String get tutorialStepManCaptureTitle;

  /// No description provided for @categoryClassicNatural.
  ///
  /// In tr, this message translates to:
  /// **'Klasik & Doğal'**
  String get categoryClassicNatural;

  /// No description provided for @categoryCulturalHistorical.
  ///
  /// In tr, this message translates to:
  /// **'Kültürel & Tarihi'**
  String get categoryCulturalHistorical;

  /// No description provided for @categoryFantasySciFi.
  ///
  /// In tr, this message translates to:
  /// **'Fantastik & Bilimkurgu'**
  String get categoryFantasySciFi;

  /// No description provided for @categoryLuxuryArtistic.
  ///
  /// In tr, this message translates to:
  /// **'Lüks & Sanatsal'**
  String get categoryLuxuryArtistic;

  /// No description provided for @categoryModernMinimalist.
  ///
  /// In tr, this message translates to:
  /// **'Modern & Minimalist'**
  String get categoryModernMinimalist;

  /// No description provided for @categoryFunColorful.
  ///
  /// In tr, this message translates to:
  /// **'Eğlenceli & Renkli'**
  String get categoryFunColorful;

  /// No description provided for @themeBoardClassicWood.
  ///
  /// In tr, this message translates to:
  /// **'Klasik Ahşap'**
  String get themeBoardClassicWood;

  /// No description provided for @themeBoardMarble.
  ///
  /// In tr, this message translates to:
  /// **'Mermer'**
  String get themeBoardMarble;

  /// No description provided for @themeBoardGreenVelvet.
  ///
  /// In tr, this message translates to:
  /// **'Yeşil Kadife'**
  String get themeBoardGreenVelvet;

  /// No description provided for @themeBoardOceanBlue.
  ///
  /// In tr, this message translates to:
  /// **'Okyanus Mavisi'**
  String get themeBoardOceanBlue;

  /// No description provided for @themeBoardAutumn.
  ///
  /// In tr, this message translates to:
  /// **'Sonbahar'**
  String get themeBoardAutumn;

  /// No description provided for @themeBoardGranite.
  ///
  /// In tr, this message translates to:
  /// **'Granit'**
  String get themeBoardGranite;

  /// No description provided for @themeBoardWinterForest.
  ///
  /// In tr, this message translates to:
  /// **'Kış Ormanı'**
  String get themeBoardWinterForest;

  /// No description provided for @themeBoardRiverStone.
  ///
  /// In tr, this message translates to:
  /// **'Nehir Taşı'**
  String get themeBoardRiverStone;

  /// No description provided for @themeBoardOttomanTile.
  ///
  /// In tr, this message translates to:
  /// **'Osmanlı Çinisi'**
  String get themeBoardOttomanTile;

  /// No description provided for @themeBoardEgyptianPapyrus.
  ///
  /// In tr, this message translates to:
  /// **'Mısır Papirüsü'**
  String get themeBoardEgyptianPapyrus;

  /// No description provided for @themeBoardRomanMosaic.
  ///
  /// In tr, this message translates to:
  /// **'Roma Mozaiği'**
  String get themeBoardRomanMosaic;

  /// No description provided for @themeBoardJapaneseSakura.
  ///
  /// In tr, this message translates to:
  /// **'Japon Sakura'**
  String get themeBoardJapaneseSakura;

  /// No description provided for @themeBoardScandinavianRune.
  ///
  /// In tr, this message translates to:
  /// **'İskandinav Rün'**
  String get themeBoardScandinavianRune;

  /// No description provided for @themeBoardAztecSunStone.
  ///
  /// In tr, this message translates to:
  /// **'Aztek Güneş Taşı'**
  String get themeBoardAztecSunStone;

  /// No description provided for @themeBoardCelticKnot.
  ///
  /// In tr, this message translates to:
  /// **'Kelt Düğümü'**
  String get themeBoardCelticKnot;

  /// No description provided for @themeBoardVictorian.
  ///
  /// In tr, this message translates to:
  /// **'Viktorya'**
  String get themeBoardVictorian;

  /// No description provided for @themeBoardGalaxy.
  ///
  /// In tr, this message translates to:
  /// **'Galaksi'**
  String get themeBoardGalaxy;

  /// No description provided for @themeBoardEnchantedForest.
  ///
  /// In tr, this message translates to:
  /// **'Büyülü Orman'**
  String get themeBoardEnchantedForest;

  /// No description provided for @themeBoardHellfire.
  ///
  /// In tr, this message translates to:
  /// **'Cehennem Ateşi'**
  String get themeBoardHellfire;

  /// No description provided for @themeBoardGlacierKingdom.
  ///
  /// In tr, this message translates to:
  /// **'Buzul Krallığı'**
  String get themeBoardGlacierKingdom;

  /// No description provided for @themeBoardCyberCircuit.
  ///
  /// In tr, this message translates to:
  /// **'Siber Devre'**
  String get themeBoardCyberCircuit;

  /// No description provided for @themeBoardSteampunk.
  ///
  /// In tr, this message translates to:
  /// **'Steampunk'**
  String get themeBoardSteampunk;

  /// No description provided for @themeBoardAtlantis.
  ///
  /// In tr, this message translates to:
  /// **'Atlantis'**
  String get themeBoardAtlantis;

  /// No description provided for @themeBoardCanadaSpace.
  ///
  /// In tr, this message translates to:
  /// **'Kanada Uzayı'**
  String get themeBoardCanadaSpace;

  /// No description provided for @themeBoardBlackGold.
  ///
  /// In tr, this message translates to:
  /// **'Siyah & Altın'**
  String get themeBoardBlackGold;

  /// No description provided for @themeBoardRubyEmerald.
  ///
  /// In tr, this message translates to:
  /// **'Yakut & Zümrüt'**
  String get themeBoardRubyEmerald;

  /// No description provided for @themeBoardArtDeco.
  ///
  /// In tr, this message translates to:
  /// **'Art Deco'**
  String get themeBoardArtDeco;

  /// No description provided for @themeBoardRoyalVelvet.
  ///
  /// In tr, this message translates to:
  /// **'Kraliyet Kadifesi'**
  String get themeBoardRoyalVelvet;

  /// No description provided for @themeBoardPorcelain.
  ///
  /// In tr, this message translates to:
  /// **'Porselen'**
  String get themeBoardPorcelain;

  /// No description provided for @themeBoardStainedGlass.
  ///
  /// In tr, this message translates to:
  /// **'Vitray'**
  String get themeBoardStainedGlass;

  /// No description provided for @themeBoardPearl.
  ///
  /// In tr, this message translates to:
  /// **'İnci'**
  String get themeBoardPearl;

  /// No description provided for @themeBoardBrushStrokes.
  ///
  /// In tr, this message translates to:
  /// **'Fırça Darbeleri'**
  String get themeBoardBrushStrokes;

  /// No description provided for @themeBoardMatteBlack.
  ///
  /// In tr, this message translates to:
  /// **'Mat Siyah'**
  String get themeBoardMatteBlack;

  /// No description provided for @themeBoardConcreteSteel.
  ///
  /// In tr, this message translates to:
  /// **'Beton & Çelik'**
  String get themeBoardConcreteSteel;

  /// No description provided for @themeBoardCarbonFiber.
  ///
  /// In tr, this message translates to:
  /// **'Karbon Fiber'**
  String get themeBoardCarbonFiber;

  /// No description provided for @themeBoardGlass.
  ///
  /// In tr, this message translates to:
  /// **'Cam'**
  String get themeBoardGlass;

  /// No description provided for @themeBoardPaper.
  ///
  /// In tr, this message translates to:
  /// **'Kağıt'**
  String get themeBoardPaper;

  /// No description provided for @themeBoardDigitalPixel.
  ///
  /// In tr, this message translates to:
  /// **'Dijital Piksel'**
  String get themeBoardDigitalPixel;

  /// No description provided for @themeBoardPastelGeometry.
  ///
  /// In tr, this message translates to:
  /// **'Pastel Geometri'**
  String get themeBoardPastelGeometry;

  /// No description provided for @themeBoardMonochromeGradient.
  ///
  /// In tr, this message translates to:
  /// **'Tek Renk Gradyan'**
  String get themeBoardMonochromeGradient;

  /// No description provided for @themeBoardCandyLand.
  ///
  /// In tr, this message translates to:
  /// **'Şeker Diyarı'**
  String get themeBoardCandyLand;

  /// No description provided for @themeBoardComicBook.
  ///
  /// In tr, this message translates to:
  /// **'Çizgi Roman'**
  String get themeBoardComicBook;

  /// No description provided for @themeBoard8BitRetro.
  ///
  /// In tr, this message translates to:
  /// **'8-Bit Retro'**
  String get themeBoard8BitRetro;

  /// No description provided for @themeBoardToyBlocks.
  ///
  /// In tr, this message translates to:
  /// **'Oyuncak Bloklar'**
  String get themeBoardToyBlocks;

  /// No description provided for @themeBoardRainbow.
  ///
  /// In tr, this message translates to:
  /// **'Gökkuşağı'**
  String get themeBoardRainbow;

  /// No description provided for @themeBoardGraffiti.
  ///
  /// In tr, this message translates to:
  /// **'Graffiti'**
  String get themeBoardGraffiti;

  /// No description provided for @themeBoardWatercolor.
  ///
  /// In tr, this message translates to:
  /// **'Suluboya'**
  String get themeBoardWatercolor;

  /// No description provided for @themeBoardHoneycomb.
  ///
  /// In tr, this message translates to:
  /// **'Bal Peteği'**
  String get themeBoardHoneycomb;

  /// No description provided for @themePieceCarvedWood.
  ///
  /// In tr, this message translates to:
  /// **'Oymalı Ahşap'**
  String get themePieceCarvedWood;

  /// No description provided for @themePieceIvoryEbony.
  ///
  /// In tr, this message translates to:
  /// **'Fildişi & Abanoz'**
  String get themePieceIvoryEbony;

  /// No description provided for @themePiecePolishedPebble.
  ///
  /// In tr, this message translates to:
  /// **'Parlak Çakıl'**
  String get themePiecePolishedPebble;

  /// No description provided for @themePieceEarthenware.
  ///
  /// In tr, this message translates to:
  /// **'Toprak Pota'**
  String get themePieceEarthenware;

  /// No description provided for @themePieceFrostedGlass.
  ///
  /// In tr, this message translates to:
  /// **'Buzlu Cam'**
  String get themePieceFrostedGlass;

  /// No description provided for @themePieceRedJasper.
  ///
  /// In tr, this message translates to:
  /// **'Kırmızı Jasper'**
  String get themePieceRedJasper;

  /// No description provided for @themePieceBamboo.
  ///
  /// In tr, this message translates to:
  /// **'Bambu'**
  String get themePieceBamboo;

  /// No description provided for @themePieceAmber.
  ///
  /// In tr, this message translates to:
  /// **'Kehribar'**
  String get themePieceAmber;

  /// No description provided for @themePieceIznikTile.
  ///
  /// In tr, this message translates to:
  /// **'İznik Çinisi'**
  String get themePieceIznikTile;

  /// No description provided for @themePieceLapisLazuli.
  ///
  /// In tr, this message translates to:
  /// **'Lapis Lazuli'**
  String get themePieceLapisLazuli;

  /// No description provided for @themePieceJade.
  ///
  /// In tr, this message translates to:
  /// **'Yeşim Taşı'**
  String get themePieceJade;

  /// No description provided for @themePieceAncientBronze.
  ///
  /// In tr, this message translates to:
  /// **'Antik Bronz'**
  String get themePieceAncientBronze;

  /// No description provided for @themePieceObsidian.
  ///
  /// In tr, this message translates to:
  /// **'Obsidyen'**
  String get themePieceObsidian;

  /// No description provided for @themePieceParchment.
  ///
  /// In tr, this message translates to:
  /// **'Parşömen'**
  String get themePieceParchment;

  /// No description provided for @themePieceTerracotta.
  ///
  /// In tr, this message translates to:
  /// **'Terrakotta'**
  String get themePieceTerracotta;

  /// No description provided for @themePieceIronRune.
  ///
  /// In tr, this message translates to:
  /// **'Demir Rün'**
  String get themePieceIronRune;

  /// No description provided for @themePieceDragonScale.
  ///
  /// In tr, this message translates to:
  /// **'Ejderha Pulu'**
  String get themePieceDragonScale;

  /// No description provided for @themePieceCrystal.
  ///
  /// In tr, this message translates to:
  /// **'Kristal'**
  String get themePieceCrystal;

  /// No description provided for @themePieceNeonLights.
  ///
  /// In tr, this message translates to:
  /// **'Neon Işıkları'**
  String get themePieceNeonLights;

  /// No description provided for @themePieceGhost.
  ///
  /// In tr, this message translates to:
  /// **'Hayalet'**
  String get themePieceGhost;

  /// No description provided for @themePieceVolcanicMagma.
  ///
  /// In tr, this message translates to:
  /// **'Volkanik Magma'**
  String get themePieceVolcanicMagma;

  /// No description provided for @themePieceElvenMithril.
  ///
  /// In tr, this message translates to:
  /// **'Elf Mithrili'**
  String get themePieceElvenMithril;

  /// No description provided for @themePieceOrcishIron.
  ///
  /// In tr, this message translates to:
  /// **'Ork Demiri'**
  String get themePieceOrcishIron;

  /// No description provided for @themePieceCosmicDust.
  ///
  /// In tr, this message translates to:
  /// **'Kozmik Toz'**
  String get themePieceCosmicDust;

  /// No description provided for @themePieceGoldSilver.
  ///
  /// In tr, this message translates to:
  /// **'Altın & Gümüş'**
  String get themePieceGoldSilver;

  /// No description provided for @themePieceBlackPearl.
  ///
  /// In tr, this message translates to:
  /// **'Siyah İnci'**
  String get themePieceBlackPearl;

  /// No description provided for @themePieceMalachite.
  ///
  /// In tr, this message translates to:
  /// **'Malahit'**
  String get themePieceMalachite;

  /// No description provided for @themePieceVenetianGlass.
  ///
  /// In tr, this message translates to:
  /// **'Venedik Camı'**
  String get themePieceVenetianGlass;

  /// No description provided for @themePieceGatsby.
  ///
  /// In tr, this message translates to:
  /// **'Gatsby'**
  String get themePieceGatsby;

  /// No description provided for @themePieceDiamond.
  ///
  /// In tr, this message translates to:
  /// **'Elmas'**
  String get themePieceDiamond;

  /// No description provided for @themePieceRuby.
  ///
  /// In tr, this message translates to:
  /// **'Yakut'**
  String get themePieceRuby;

  /// No description provided for @themePieceSapphire.
  ///
  /// In tr, this message translates to:
  /// **'Safir'**
  String get themePieceSapphire;

  /// No description provided for @themePieceModernMinimalist.
  ///
  /// In tr, this message translates to:
  /// **'Modern Minimalist'**
  String get themePieceModernMinimalist;

  /// No description provided for @themePieceRobotic.
  ///
  /// In tr, this message translates to:
  /// **'Robotik'**
  String get themePieceRobotic;

  /// No description provided for @themePieceMetallicGradient.
  ///
  /// In tr, this message translates to:
  /// **'Metalik Gradyan'**
  String get themePieceMetallicGradient;

  /// No description provided for @themePieceGlossyPlastic.
  ///
  /// In tr, this message translates to:
  /// **'Parlak Plastik'**
  String get themePieceGlossyPlastic;

  /// No description provided for @themePieceHolographic.
  ///
  /// In tr, this message translates to:
  /// **'Holografik'**
  String get themePieceHolographic;

  /// No description provided for @themePieceMattePastel.
  ///
  /// In tr, this message translates to:
  /// **'Mat Pastel'**
  String get themePieceMattePastel;

  /// No description provided for @themePieceRubber.
  ///
  /// In tr, this message translates to:
  /// **'Kauçuk'**
  String get themePieceRubber;

  /// No description provided for @themePieceLightShadow.
  ///
  /// In tr, this message translates to:
  /// **'Işık & Gölge'**
  String get themePieceLightShadow;

  /// No description provided for @themePieceConfectionery.
  ///
  /// In tr, this message translates to:
  /// **'Şekerleme'**
  String get themePieceConfectionery;

  /// No description provided for @themePieceChocolate.
  ///
  /// In tr, this message translates to:
  /// **'Çikolata'**
  String get themePieceChocolate;

  /// No description provided for @themePieceFruitBasket.
  ///
  /// In tr, this message translates to:
  /// **'Meyve Sepeti'**
  String get themePieceFruitBasket;

  /// No description provided for @themePieceGummy.
  ///
  /// In tr, this message translates to:
  /// **'Jelibon'**
  String get themePieceGummy;

  /// No description provided for @themePieceWatermelon.
  ///
  /// In tr, this message translates to:
  /// **'Karpuz'**
  String get themePieceWatermelon;

  /// No description provided for @themePieceCosmonaut.
  ///
  /// In tr, this message translates to:
  /// **'Kozmonot'**
  String get themePieceCosmonaut;

  /// No description provided for @themePieceSuperhero.
  ///
  /// In tr, this message translates to:
  /// **'Süper Kahraman'**
  String get themePieceSuperhero;

  /// No description provided for @themePieceSeashell.
  ///
  /// In tr, this message translates to:
  /// **'Deniz Kabuğu'**
  String get themePieceSeashell;

  /// No description provided for @languageSpanish.
  ///
  /// In tr, this message translates to:
  /// **'İspanyolca'**
  String get languageSpanish;

  /// No description provided for @languageRussian.
  ///
  /// In tr, this message translates to:
  /// **'Rusça'**
  String get languageRussian;

  /// No description provided for @languageGerman.
  ///
  /// In tr, this message translates to:
  /// **'Almanca'**
  String get languageGerman;

  /// No description provided for @languagePortuguese.
  ///
  /// In tr, this message translates to:
  /// **'Portekizce'**
  String get languagePortuguese;

  /// No description provided for @languageFrench.
  ///
  /// In tr, this message translates to:
  /// **'Fransızca'**
  String get languageFrench;

  /// No description provided for @languageItalian.
  ///
  /// In tr, this message translates to:
  /// **'İtalyanca'**
  String get languageItalian;

  /// No description provided for @privacyPolicy.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik Politikası'**
  String get privacyPolicy;

  /// No description provided for @version.
  ///
  /// In tr, this message translates to:
  /// **'Sürüm'**
  String get version;

  /// No description provided for @aboutHeader.
  ///
  /// In tr, this message translates to:
  /// **'HAKKINDA'**
  String get aboutHeader;

  /// No description provided for @noInternetConnection.
  ///
  /// In tr, this message translates to:
  /// **'İnternet Bağlantısı Yok'**
  String get noInternetConnection;

  /// No description provided for @noInternetConnectionMessage.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen internet bağlantınızı kontrol edip tekrar deneyin.'**
  String get noInternetConnectionMessage;

  /// No description provided for @savedGameDialogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlı bir oyunun var. Ne yapmak istersin?'**
  String get savedGameDialogTitle;

  /// No description provided for @deleteAction.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get deleteAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'it',
        'pt',
        'ru',
        'tr'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
