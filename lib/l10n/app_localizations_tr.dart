// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Dama Koleksiyonu';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get languageHeader => 'DİL';

  @override
  String get language => 'Dil';

  @override
  String get languageSelectionTitle => 'Dil Seçin';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get languageEnglish => 'İngilizce';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get appearanceHeader => 'GÖRÜNÜM';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeDark => 'Koyu';

  @override
  String get gameExperienceHeader => 'OYUN DENEYİMİ';

  @override
  String get soundEffects => 'Ses Efektleri';

  @override
  String get haptics => 'Dokunsal Geri Bildirim';

  @override
  String get showCoordinates => 'Koordinatları Göster';

  @override
  String get gamePreferencesHeader => 'OYUN TERCİHLERİ';

  @override
  String get gamePreferencesDescription =>
      'Bilgisayara karşı oynarken hangi renkle başlamak istediğinizi seçin.';

  @override
  String get colorWhite => 'Beyaz';

  @override
  String get colorRandom => 'Rastgele';

  @override
  String get colorBlack => 'Siyah';

  @override
  String get progressHeader => 'İLERLEME';

  @override
  String get resetAllRanks => 'Tüm Rütbeleri Sıfırla';

  @override
  String get resetProgressConfirmationTitle => 'İlerleme Sıfırlansın mı?';

  @override
  String get resetProgressConfirmationBody =>
      'Tüm oyun modlarındaki rütbe ilerlemeniz kalıcı olarak silinecektir. Bu işlem geri alınamaz.';

  @override
  String get dialogCancel => 'Vazgeç';

  @override
  String get dialogReset => 'Sıfırla';

  @override
  String get progressResetSuccess => 'İlerleme Sıfırlandı';

  @override
  String get dialogOK => 'Tamam';

  @override
  String get mainMenuPlayButtonAI => 'Seviye Seç';

  @override
  String get mainMenuPlayButtonHuman => 'Yeni Oyun';

  @override
  String get mainMenuContinue => 'Devam Et';

  @override
  String get mainMenuOpponentAI => 'Yapay Zeka';

  @override
  String get mainMenuOpponentHuman => 'İki Kişilik';

  @override
  String get mainMenuRules => 'Kurallar';

  @override
  String get mainMenuExploreThemes => 'Temaları Keşfet';

  @override
  String get close => 'Kapat';

  @override
  String levelNumber(int level) {
    return 'Seviye $level';
  }

  @override
  String get themeStoreTitle => 'Tema Mağazası';

  @override
  String get searchBoardPlaceholder => 'Tahta Ara';

  @override
  String get searchPiecePlaceholder => 'Taş Ara';

  @override
  String get boards => 'Tahtalar';

  @override
  String get pieces => 'Taşlar';

  @override
  String get noResults => 'Sonuç bulunamadı';

  @override
  String get loadingStatusInitializing => 'Başlatılıyor...';

  @override
  String get loadingStatusSettings => 'Ayarlar yükleniyor...';

  @override
  String get loadingStatusUI => 'Arayüz optimize ediliyor...';

  @override
  String get loadingStatusReady => 'Hazır!';

  @override
  String get gameScreenConfirmExitTitle => 'Ana Menüye Dön';

  @override
  String get gameScreenConfirmExitBody =>
      'Devam eden oyunu kaydetmek ister misiniz?';

  @override
  String get gameScreenSaveAndExit => 'Kaydet ve Çık';

  @override
  String get gameScreenExitWithoutSaving => 'Kaydetmeden Çık';

  @override
  String get gameScreenPaused => 'Duraklatıldı';

  @override
  String get gameScreenResume => 'Devam Et';

  @override
  String get gameScreenRestart => 'Yeniden Başlat';

  @override
  String get gameScreenReturnToMenu => 'Ana Menüye Dön';

  @override
  String get gameOverWinTitle => 'Tebrikler, Kazandın!';

  @override
  String get gameOverWinBody => 'Harika bir zafer!';

  @override
  String get gameOverNewRankBody => 'Yeni bir rütbe kazandın!';

  @override
  String get gameOverNewRankTitle => 'RÜTBE ATLANDI!';

  @override
  String get gameOverLoseTitle => 'Kaybettin';

  @override
  String get gameOverLoseBody => 'Daha sıkı çalışmalısın.';

  @override
  String get gameOverDrawTitle => 'Berabere!';

  @override
  String get gameOverTitle => 'Oyun Bitti!';

  @override
  String gameOverWinner(String winner) {
    return 'Kazanan: $winner';
  }

  @override
  String get gameOverNewGame => 'Yeni Oyun';

  @override
  String get playerYou => 'Siz';

  @override
  String get playerComputer => 'Bilgisayar';

  @override
  String get playerWhite => 'Beyaz';

  @override
  String get playerBlack => 'Siyah';

  @override
  String get aiThinking => 'Düşünüyor...';

  @override
  String get nextMove => 'Sıradaki Hamle';

  @override
  String get waiting => 'Bekleniyor...';

  @override
  String tutorialTitle(String gameMode) {
    return '$gameMode Öğreticisi';
  }

  @override
  String get tutorialNext => 'İleri';

  @override
  String get tutorialPrevious => 'Geri';

  @override
  String get tutorialPlay => 'Oynat';

  @override
  String get rankNovice => 'Acemi';

  @override
  String get rankApprentice => 'Çırak';

  @override
  String get rankJourneyman => 'Kalfa';

  @override
  String get rankMaster => 'Usta';

  @override
  String get rankExpert => 'Uzman';

  @override
  String get rankVirtuoso => 'Virtüöz';

  @override
  String get rankGrandmaster => 'Büyük Usta';

  @override
  String get drawReasonThreefoldRepetition =>
      'Aynı pozisyon üç kez tekrarlandı.';

  @override
  String get drawReasonFiftyMoveRule =>
      '50 hamle boyunca taş alınmadı veya dama yapılmadı.';

  @override
  String get drawReasonFortyMoveRule =>
      '40 hamle boyunca taş alınmadı veya dama yapılmadı.';

  @override
  String get drawReasonTwentyFiveMoveRule =>
      '25 hamle boyunca taş alınmadı veya dama yapılmadı.';

  @override
  String get drawReasonFifteenMoveRule =>
      '15 hamle boyunca taş alınmadı veya dama yapılmadı.';

  @override
  String get drawReasonInsufficientMaterial =>
      'Kalan taşlar oyunu kazanmak için yetersiz.';

  @override
  String get drawReasonStalemate =>
      'Her iki oyuncunun da geçerli hamlesi kalmadı.';

  @override
  String get gameModeTurkishName => 'Türk Daması';

  @override
  String get gameModeTurkishDescription =>
      '8x8 tahtada oynanır. Taşlar ileri ve yanlara doğru hareket eder.';

  @override
  String get gameModeEnglishName => 'İngiliz Daması';

  @override
  String get gameModeEnglishDescription =>
      '8x8 tahtada oynanır. Normal taşlar geriye doğru yiyemez ve damalar uçmaz.';

  @override
  String get gameModeInternationalName => 'Uluslararası Dama';

  @override
  String get gameModeInternationalDescription =>
      '10x10 tahtada oynanır. En çok yeme zorunluluğu vardır ve damalar uçar.';

  @override
  String get gameModeRussianName => 'Rus Daması';

  @override
  String get gameModeRussianDescription =>
      'Yiyerek dama olan taş, aynı hamlede yemeye devam edebilir.';

  @override
  String get gameModeSpanishName => 'İspanyol Daması';

  @override
  String get gameModeSpanishDescription =>
      'Normal taşlar sadece ileri yiyebilir/gider. En çok yeme zorunludur ve damalar uçar.';

  @override
  String get gameModeAntiCheckersName => 'Ters Dama';

  @override
  String get gameModeAntiCheckersDescription =>
      'Tüm taşlarını ilk bitiren veya hamlesi kalmayan oyuncu kazanır.';

  @override
  String get ruleTitleManMove => 'Normal Taş Hareketi';

  @override
  String get ruleDescManMoveForward =>
      'Normal taşlar sadece ileri doğru bir kare çapraz hareket eder.';

  @override
  String get ruleTitleManCapture => 'Normal Taş Yeme';

  @override
  String get ruleDescManCaptureForward =>
      'Normal taşlar sadece ileri doğru çapraz yiyebilir.';

  @override
  String get ruleDescManCaptureBackward =>
      'Normal taşlar hem ileri hem de geri çapraz yiyebilir.';

  @override
  String get ruleTitleKingMove => 'Dama Hareketi';

  @override
  String get ruleDescKingShort =>
      'Dama olan taş (King), her yöne sadece bir kare çapraz hareket eder ve yer.';

  @override
  String get ruleDescKingFlying =>
      'Dama olan taş (King), her yöne boş kareler üzerinden kayarak (uçarak) hareket eder ve yer.';

  @override
  String get ruleTitleMandatoryCapture => 'Zorunlu Yeme';

  @override
  String get ruleDescMandatoryCapture =>
      'Yeme hamlesi varsa, yapılması zorunludur.';

  @override
  String get ruleTitleMaxCapture => 'En Çok Yeme';

  @override
  String get ruleDescMaxCapture =>
      'Birden fazla yeme yolu varsa, en çok sayıda taşı yiyen hamle dizisi zorunludur.';

  @override
  String get ruleTitleTurkishManMove => 'Normal Taş Hareketi';

  @override
  String get ruleDescTurkishManMove =>
      'Normal taşlar ileri ve yanlara doğru bir kare hareket eder.';

  @override
  String get ruleTitleTurkishCapture => 'Yeme Kuralı';

  @override
  String get ruleDescTurkishCapture =>
      'Taşlar, rakip taşın üzerinden düz veya yan atlayarak yer.';

  @override
  String get ruleTitlePromotion => 'Terfi Kuralı';

  @override
  String get ruleDescPromotionStops =>
      'Yeme hamlesi sırasında terfi eden taş, hamlesini durdurur. Sıra rakibe geçer.';

  @override
  String get ruleDescPromotionContinues =>
      'Yeme hamlesi sırasında terfi eden taş, aynı hamle içinde Dama olarak yemeye devam edebilir.';

  @override
  String get ruleTitleAntiCheckersAim => 'Amaç';

  @override
  String get ruleDescAntiCheckersAim =>
      'Oyunun amacı, tüm taşlarını rakibe yedirmek veya hamle yapamaz duruma düşmektir.';

  @override
  String get tutorialStepWelcomeTitle => 'Hoş Geldiniz';

  @override
  String get tutorialStepWelcomeDescTurkish =>
      'Türk Daması\'na hoş geldiniz! Taşlar her iki taraf için de ikinci ve üçüncü sıralara dizilir. Amaç, rakibin tüm taşlarını yemektir.';

  @override
  String get tutorialStepManMoveDescTurkish =>
      'Piyonlar bir kare ileri veya yana doğru hareket eder. Geriye doğru hareket edemezler.';

  @override
  String get tutorialStepCaptureTitle => 'Taş Alma';

  @override
  String get tutorialStepCaptureDescTurkish =>
      'Taşlar, rakip bir taşın üzerinden atlayarak arkasındaki boş kareye gelerek alınır.';

  @override
  String get tutorialStepMaxCaptureTitle => 'En Çok Taşı Alma';

  @override
  String get tutorialStepMaxCaptureDesc =>
      'Birden fazla taş alma seçeneği varsa, en çok sayıda taşı alacağınız yolu seçmek zorundasınız.';

  @override
  String get tutorialStepPromotionTitle => 'Dama Olma (Terfi)';

  @override
  String get tutorialStepPromotionDesc =>
      'Bir piyon rakibin son sırasına ulaştığında, Dama olur ve özel yetenekler kazanır.';

  @override
  String get tutorialStepKingMoveDescTurkish =>
      'Dama, satrançtaki kale gibi ileri, geri ve yanlara doğru istediği kadar boş karede hareket edebilir ve aynı hat üzerindeki bir taşı üzerinden atlayarak yer.';

  @override
  String get tutorialStepDrawTitle => 'Beraberlik Durumları';

  @override
  String get tutorialStepDrawDescTurkish =>
      'Aynı pozisyon üç kez tekrarlanırsa veya 25 hamle boyunca hiç taş alınmazsa oyun berabere biter.';

  @override
  String get tutorialStepWelcomeDescEnglish =>
      'İngiliz Daması\'na hoş geldiniz! Amaç, rakibin tüm taşlarını yemektir. Tüm hamleler ve taş almalar koyu renkli karelerde yapılır.';

  @override
  String get tutorialStepManMoveDescEnglish =>
      'Piyonlar sadece boş bir kareye doğru ileri çapraz bir adım hareket eder.';

  @override
  String get tutorialStepCaptureDescEnglish =>
      'Piyonlar, rakip bir taşın üzerinden ileri çapraz atlayarak hemen arkasındaki boş kareye gelerek taş alırlar.';

  @override
  String get tutorialStepManCannotCaptureBackwardTitle =>
      'Geriye Doğru Yiyememe';

  @override
  String get tutorialStepManCannotCaptureBackwardDesc =>
      'Piyonlar geriye doğru taş alamazlar. Burada, beyaz piyon arkasındaki siyah piyonu alamaz.';

  @override
  String get tutorialStepMultipleCaptureTitle => 'Çoklu Taş Alma';

  @override
  String get tutorialStepMultipleCaptureDesc =>
      'Bir taş alma hamlesi sizi başka bir taş alma pozisyonuna getirirse, aynı turda taş almaya devam etmelisiniz.';

  @override
  String get tutorialStepPromotionDescEnglish =>
      'Bir piyon, başlangıç konumundan en uzak sıraya ulaştığında Dama\'ya terfi eder. Bir taş terfi ettiğinde hamle sırası sona erer.';

  @override
  String get tutorialStepKingMoveDescEnglish =>
      'Bir Dama, ileri veya geri olmak üzere her yöne çapraz olarak bir adım hareket edebilir ve taş alabilir.';

  @override
  String get tutorialStepDrawDescEnglish =>
      'Aynı pozisyon üç kez tekrarlanırsa veya anlaşma ile oyun berabere biter. Ayrıca, bir damaya karşı bir dama kalması durumunda da oyun beraberedir.';

  @override
  String get tutorialStepWelcomeDescInternational =>
      '10x10\'luk bir tahtada oynanan Uluslararası Dama\'ya hoş geldiniz! Kurallar diğer varyantlara benzer, ancak bazı önemli farkları vardır.';

  @override
  String get tutorialStepManCaptureDescInternational =>
      'Piyonlar ileri çapraz hareket eder ancak hem ileri hem de geri çapraz taş alabilirler.';

  @override
  String get tutorialStepKingMoveDescInternational =>
      'Dama \'uçar\'. Herhangi bir yöne doğru istediği kadar boş karede çapraz olarak hareket edebilir.';

  @override
  String get tutorialStepKingCaptureTitle => 'Dama ile Taş Alma';

  @override
  String get tutorialStepKingCaptureDesc =>
      'Uçan bir Dama, yolu açık olduğu sürece bir taşın üzerinden atlayarak arkasındaki herhangi bir boş kareye konarak uzaktan taş alabilir.';

  @override
  String get tutorialStepKingMultipleCaptureTitle => 'Dama ile Çoklu Taş Alma';

  @override
  String get tutorialStepKingMultipleCaptureDesc =>
      'Bir Dama, genellikle her atlayıştan sonra yön değiştirerek bir dizi taş alma hamlesi yapabilir.';

  @override
  String get tutorialStepDrawDescInternational =>
      'Aynı pozisyon üç kez tekrarlanırsa veya 50 hamle boyunca piyon hamlesi veya taş alma olmazsa oyun berabere biter. İki damanın bir damaya karşı olduğu bazı oyun sonları da beraberedir.';

  @override
  String get tutorialStepLosingAimTitle => 'Oyunun Amacı';

  @override
  String get tutorialStepLosingAimDesc =>
      'Ters Dama\'ya hoş geldiniz! Amaç, normal damanın tam tersidir: tüm taşlarınızı kaybederek veya yasal bir hamleniz kalmayarak kazanırsınız.';

  @override
  String get tutorialStepMandatoryCaptureDescLosing =>
      'Tıpkı normal damada olduğu gibi, taş almak zorunludur. Fırsatınız varsa taşlarınızı rakibe vermek zorundasınız!';

  @override
  String get tutorialStepTrapTitle => 'Tuzak Kurma';

  @override
  String get tutorialStepTrapDesc =>
      'Yaygın bir strateji, rakibinizi birçok taşınızı alacağı uzun bir taş alma dizisine zorlayacak bir konuma getirmektir.';

  @override
  String get tutorialStepFallingIntoTrapTitle => 'Tuzağa Düşme';

  @override
  String get tutorialStepFallingIntoTrapDesc =>
      'Siyah oyuncu şimdi beyaz taşı almak zorunda, ki bu tam da Beyaz\'ın istediği şeydi.';

  @override
  String get tutorialStepLosingEndgameTitle => 'Oyun Sonu';

  @override
  String get tutorialStepLosingEndgameDesc =>
      'Oyun, bir oyuncunun tahtada hiç taşı kalmadığında veya hamle yapamadığında sona erer. O oyuncu kazanır! Burada, Siyah hiç taşı kalmadığı için kazanmıştır.';

  @override
  String get tutorialStepDrawDescLosing =>
      'Beraberlik nadirdir ancak örneğin bir pozisyonun üç kez tekrarlanmasıyla meydana gelebilir.';

  @override
  String get tutorialStepWelcomeDescRussian =>
      'Rus Daması\'na (Şaški) hoş geldiniz! Benzersiz bir terfi kuralı vardır.';

  @override
  String get tutorialStepManCaptureBackwardTitle => 'Piyonla Geriye Taş Alma';

  @override
  String get tutorialStepManCaptureBackwardDesc =>
      'Uluslararası Dama\'da olduğu gibi, piyonlar ileri hareket eder ancak hem ileri hem de geri taş alabilirler.';

  @override
  String get tutorialStepPromotionDescRussian =>
      'Bir piyon, taş almadan rakibin son sırasına ulaştığında Dama\'ya terfi eder ve sıra sona erer.';

  @override
  String get tutorialStepPromotionRuleTitle => 'Özel Terfi Kuralı';

  @override
  String get tutorialStepPromotionRuleDescRussian =>
      'ANA KURAL: Eğer bir piyon, taş alarak terfi sırasına ulaşırsa, anında Dama olur ve mümkünse aynı turda Dama olarak taş almaya DEVAM ETMEK ZORUNDADIR.';

  @override
  String get tutorialStepDrawDescRussian =>
      'Pozisyonun üç kez tekrarlanmasıyla veya tahtada sadece damalar varken 15 hamle boyunca taş alınmazsa oyun berabere bitebilir.';

  @override
  String get tutorialStepWelcomeDescSpanish =>
      'İspanyol Daması\'na hoş geldiniz! Bu varyant, İngiliz ve Uluslararası Dama kurallarını birleştirir.';

  @override
  String get tutorialStepManMoveDescSpanish =>
      'Piyonlar, tıpkı İngiliz Daması\'nda olduğu gibi, sadece ileri çapraz hareket eder ve taş alır.';

  @override
  String get tutorialStepMandatoryCaptureTitle => 'Zorunlu Taş Alma';

  @override
  String get tutorialStepMandatoryCaptureDescSpanish =>
      'Taş almak zorunludur. Birden fazla taş alma seçeneği varsa, birini seçmelisiniz; piyonlar için \'en çok yeme\' kuralı yoktur.';

  @override
  String get tutorialStepPromotionDescSpanish =>
      'Bir piyon en uzak sıraya ulaştığında, Dama\'ya terfi eder. Terfi üzerine sıra sona erer.';

  @override
  String get tutorialStepKingMoveDescSpanish =>
      'Damalar \'uçar\', yani Uluslararası Dama\'da olduğu gibi birden fazla kare üzerinden hareket edebilir ve taş alabilirler.';

  @override
  String get tutorialStepDrawDescSpanish =>
      'Pozisyonun üç kez tekrarlanmasıyla veya 50 hamle boyunca önemli bir hamle (taş alma veya piyon hamlesi) yapılmazsa oyun berabere bitebilir.';

  @override
  String get tutorialStepManMoveTitle => 'Piyon Hareketi';

  @override
  String get tutorialStepKingMoveTitle => 'Dama Hareketi';

  @override
  String get tutorialStepManCaptureTitle => 'Piyonla Taş Alma';

  @override
  String get categoryClassicNatural => 'Klasik & Doğal';

  @override
  String get categoryCulturalHistorical => 'Kültürel & Tarihi';

  @override
  String get categoryFantasySciFi => 'Fantastik & Bilimkurgu';

  @override
  String get categoryLuxuryArtistic => 'Lüks & Sanatsal';

  @override
  String get categoryModernMinimalist => 'Modern & Minimalist';

  @override
  String get categoryFunColorful => 'Eğlenceli & Renkli';

  @override
  String get themeBoardClassicWood => 'Klasik Ahşap';

  @override
  String get themeBoardMarble => 'Mermer';

  @override
  String get themeBoardGreenVelvet => 'Yeşil Kadife';

  @override
  String get themeBoardOceanBlue => 'Okyanus Mavisi';

  @override
  String get themeBoardAutumn => 'Sonbahar';

  @override
  String get themeBoardGranite => 'Granit';

  @override
  String get themeBoardWinterForest => 'Kış Ormanı';

  @override
  String get themeBoardRiverStone => 'Nehir Taşı';

  @override
  String get themeBoardOttomanTile => 'Osmanlı Çinisi';

  @override
  String get themeBoardEgyptianPapyrus => 'Mısır Papirüsü';

  @override
  String get themeBoardRomanMosaic => 'Roma Mozaiği';

  @override
  String get themeBoardJapaneseSakura => 'Japon Sakura';

  @override
  String get themeBoardScandinavianRune => 'İskandinav Rün';

  @override
  String get themeBoardAztecSunStone => 'Aztek Güneş Taşı';

  @override
  String get themeBoardCelticKnot => 'Kelt Düğümü';

  @override
  String get themeBoardVictorian => 'Viktorya';

  @override
  String get themeBoardGalaxy => 'Galaksi';

  @override
  String get themeBoardEnchantedForest => 'Büyülü Orman';

  @override
  String get themeBoardHellfire => 'Cehennem Ateşi';

  @override
  String get themeBoardGlacierKingdom => 'Buzul Krallığı';

  @override
  String get themeBoardCyberCircuit => 'Siber Devre';

  @override
  String get themeBoardSteampunk => 'Steampunk';

  @override
  String get themeBoardAtlantis => 'Atlantis';

  @override
  String get themeBoardCanadaSpace => 'Kanada Uzayı';

  @override
  String get themeBoardBlackGold => 'Siyah & Altın';

  @override
  String get themeBoardRubyEmerald => 'Yakut & Zümrüt';

  @override
  String get themeBoardArtDeco => 'Art Deco';

  @override
  String get themeBoardRoyalVelvet => 'Kraliyet Kadifesi';

  @override
  String get themeBoardPorcelain => 'Porselen';

  @override
  String get themeBoardStainedGlass => 'Vitray';

  @override
  String get themeBoardPearl => 'İnci';

  @override
  String get themeBoardBrushStrokes => 'Fırça Darbeleri';

  @override
  String get themeBoardMatteBlack => 'Mat Siyah';

  @override
  String get themeBoardConcreteSteel => 'Beton & Çelik';

  @override
  String get themeBoardCarbonFiber => 'Karbon Fiber';

  @override
  String get themeBoardGlass => 'Cam';

  @override
  String get themeBoardPaper => 'Kağıt';

  @override
  String get themeBoardDigitalPixel => 'Dijital Piksel';

  @override
  String get themeBoardPastelGeometry => 'Pastel Geometri';

  @override
  String get themeBoardMonochromeGradient => 'Tek Renk Gradyan';

  @override
  String get themeBoardCandyLand => 'Şeker Diyarı';

  @override
  String get themeBoardComicBook => 'Çizgi Roman';

  @override
  String get themeBoard8BitRetro => '8-Bit Retro';

  @override
  String get themeBoardToyBlocks => 'Oyuncak Bloklar';

  @override
  String get themeBoardRainbow => 'Gökkuşağı';

  @override
  String get themeBoardGraffiti => 'Graffiti';

  @override
  String get themeBoardWatercolor => 'Suluboya';

  @override
  String get themeBoardHoneycomb => 'Bal Peteği';

  @override
  String get themePieceCarvedWood => 'Oymalı Ahşap';

  @override
  String get themePieceIvoryEbony => 'Fildişi & Abanoz';

  @override
  String get themePiecePolishedPebble => 'Parlak Çakıl';

  @override
  String get themePieceEarthenware => 'Toprak Pota';

  @override
  String get themePieceFrostedGlass => 'Buzlu Cam';

  @override
  String get themePieceRedJasper => 'Kırmızı Jasper';

  @override
  String get themePieceBamboo => 'Bambu';

  @override
  String get themePieceAmber => 'Kehribar';

  @override
  String get themePieceIznikTile => 'İznik Çinisi';

  @override
  String get themePieceLapisLazuli => 'Lapis Lazuli';

  @override
  String get themePieceJade => 'Yeşim Taşı';

  @override
  String get themePieceAncientBronze => 'Antik Bronz';

  @override
  String get themePieceObsidian => 'Obsidyen';

  @override
  String get themePieceParchment => 'Parşömen';

  @override
  String get themePieceTerracotta => 'Terrakotta';

  @override
  String get themePieceIronRune => 'Demir Rün';

  @override
  String get themePieceDragonScale => 'Ejderha Pulu';

  @override
  String get themePieceCrystal => 'Kristal';

  @override
  String get themePieceNeonLights => 'Neon Işıkları';

  @override
  String get themePieceGhost => 'Hayalet';

  @override
  String get themePieceVolcanicMagma => 'Volkanik Magma';

  @override
  String get themePieceElvenMithril => 'Elf Mithrili';

  @override
  String get themePieceOrcishIron => 'Ork Demiri';

  @override
  String get themePieceCosmicDust => 'Kozmik Toz';

  @override
  String get themePieceGoldSilver => 'Altın & Gümüş';

  @override
  String get themePieceBlackPearl => 'Siyah İnci';

  @override
  String get themePieceMalachite => 'Malahit';

  @override
  String get themePieceVenetianGlass => 'Venedik Camı';

  @override
  String get themePieceGatsby => 'Gatsby';

  @override
  String get themePieceDiamond => 'Elmas';

  @override
  String get themePieceRuby => 'Yakut';

  @override
  String get themePieceSapphire => 'Safir';

  @override
  String get themePieceModernMinimalist => 'Modern Minimalist';

  @override
  String get themePieceRobotic => 'Robotik';

  @override
  String get themePieceMetallicGradient => 'Metalik Gradyan';

  @override
  String get themePieceGlossyPlastic => 'Parlak Plastik';

  @override
  String get themePieceHolographic => 'Holografik';

  @override
  String get themePieceMattePastel => 'Mat Pastel';

  @override
  String get themePieceRubber => 'Kauçuk';

  @override
  String get themePieceLightShadow => 'Işık & Gölge';

  @override
  String get themePieceConfectionery => 'Şekerleme';

  @override
  String get themePieceChocolate => 'Çikolata';

  @override
  String get themePieceFruitBasket => 'Meyve Sepeti';

  @override
  String get themePieceGummy => 'Jelibon';

  @override
  String get themePieceWatermelon => 'Karpuz';

  @override
  String get themePieceCosmonaut => 'Kozmonot';

  @override
  String get themePieceSuperhero => 'Süper Kahraman';

  @override
  String get themePieceSeashell => 'Deniz Kabuğu';

  @override
  String get languageSpanish => 'İspanyolca';

  @override
  String get languageRussian => 'Rusça';

  @override
  String get languageGerman => 'Almanca';

  @override
  String get languagePortuguese => 'Portekizce';

  @override
  String get languageFrench => 'Fransızca';

  @override
  String get languageItalian => 'İtalyanca';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get version => 'Sürüm';

  @override
  String get aboutHeader => 'HAKKINDA';

  @override
  String get noInternetConnection => 'İnternet Bağlantısı Yok';

  @override
  String get noInternetConnectionMessage =>
      'Lütfen internet bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get savedGameDialogTitle =>
      'Kayıtlı bir oyunun var. Ne yapmak istersin?';

  @override
  String get deleteAction => 'Sil';
}
