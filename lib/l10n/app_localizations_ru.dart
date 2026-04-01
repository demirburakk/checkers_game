// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Мир Шашек';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get languageHeader => 'ЯЗЫК';

  @override
  String get language => 'Язык';

  @override
  String get languageSelectionTitle => 'Выберите язык';

  @override
  String get languageSystem => 'Системный';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageTurkish => 'Турецкий';

  @override
  String get appearanceHeader => 'ВНЕШНИЙ ВИД';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeDark => 'Темная';

  @override
  String get gameExperienceHeader => 'ИГРОВОЙ ОПЫТ';

  @override
  String get soundEffects => 'Звуковые эффекты';

  @override
  String get haptics => 'Тактильная отдача';

  @override
  String get showCoordinates => 'Показывать координаты';

  @override
  String get gamePreferencesHeader => 'ПРЕДПОЧТЕНИЯ В ИГРЕ';

  @override
  String get gamePreferencesDescription =>
      'Выберите, каким цветом вы хотите начать игру против компьютера.';

  @override
  String get colorWhite => 'Белые';

  @override
  String get colorRandom => 'Случайно';

  @override
  String get colorBlack => 'Черные';

  @override
  String get progressHeader => 'ПРОГРЕСС';

  @override
  String get resetAllRanks => 'Сбросить все ранги';

  @override
  String get resetProgressConfirmationTitle => 'Сбросить прогресс?';

  @override
  String get resetProgressConfirmationBody =>
      'Ваш прогресс во всех игровых режимах будет удален навсегда. Это действие нельзя отменить.';

  @override
  String get dialogCancel => 'Отмена';

  @override
  String get dialogReset => 'Сбросить';

  @override
  String get progressResetSuccess => 'Прогресс сброшен';

  @override
  String get dialogOK => 'OK';

  @override
  String get mainMenuPlayButtonAI => 'Выбрать уровень';

  @override
  String get mainMenuPlayButtonHuman => 'Новая игра';

  @override
  String get mainMenuContinue => 'Продолжить';

  @override
  String get mainMenuOpponentAI => 'Искусственный интеллект';

  @override
  String get mainMenuOpponentHuman => 'Два игрока';

  @override
  String get mainMenuRules => 'Правила';

  @override
  String get mainMenuExploreThemes => 'Магазин тем';

  @override
  String get close => 'Закрыть';

  @override
  String levelNumber(int level) {
    return 'Уровень $level';
  }

  @override
  String get themeStoreTitle => 'Магазин тем';

  @override
  String get searchBoardPlaceholder => 'Поиск досок';

  @override
  String get searchPiecePlaceholder => 'Поиск фишек';

  @override
  String get boards => 'Доски';

  @override
  String get pieces => 'Фишки';

  @override
  String get noResults => 'Ничего не найдено';

  @override
  String get loadingStatusInitializing => 'Инициализация...';

  @override
  String get loadingStatusSettings => 'Загрузка настроек...';

  @override
  String get loadingStatusUI => 'Оптимизация интерфейса...';

  @override
  String get loadingStatusReady => 'Готово!';

  @override
  String get gameScreenConfirmExitTitle => 'Вернуться в главное меню';

  @override
  String get gameScreenConfirmExitBody => 'Хотите сохранить текущую игру?';

  @override
  String get gameScreenSaveAndExit => 'Сохранить и выйти';

  @override
  String get gameScreenExitWithoutSaving => 'Выйти без сохранения';

  @override
  String get gameScreenPaused => 'Пауза';

  @override
  String get gameScreenResume => 'Продолжить';

  @override
  String get gameScreenRestart => 'Начать заново';

  @override
  String get gameScreenReturnToMenu => 'В меню';

  @override
  String get gameOverWinTitle => 'Поздравляем, вы победили!';

  @override
  String get gameOverWinBody => 'Отличная победа!';

  @override
  String get gameOverNewRankBody => 'Вы получили новый ранг!';

  @override
  String get gameOverNewRankTitle => 'НОВЫЙ РАНГ!';

  @override
  String get gameOverLoseTitle => 'Вы проиграли';

  @override
  String get gameOverLoseBody => 'Нужно больше тренироваться.';

  @override
  String get gameOverDrawTitle => 'Ничья!';

  @override
  String get gameOverTitle => 'Игра окончена!';

  @override
  String gameOverWinner(String winner) {
    return 'Победитель: $winner';
  }

  @override
  String get gameOverNewGame => 'Новая игра';

  @override
  String get playerYou => 'Вы';

  @override
  String get playerComputer => 'Компьютер';

  @override
  String get playerWhite => 'Белые';

  @override
  String get playerBlack => 'Черные';

  @override
  String get aiThinking => 'Думает...';

  @override
  String get nextMove => 'Следующий ход';

  @override
  String get waiting => 'Ожидание...';

  @override
  String tutorialTitle(String gameMode) {
    return 'Обучение: $gameMode';
  }

  @override
  String get tutorialNext => 'Далее';

  @override
  String get tutorialPrevious => 'Назад';

  @override
  String get tutorialPlay => 'Пуск';

  @override
  String get rankNovice => 'Новичок';

  @override
  String get rankApprentice => 'Ученик';

  @override
  String get rankJourneyman => 'Подмастерье';

  @override
  String get rankMaster => 'Мастер';

  @override
  String get rankExpert => 'Эксперт';

  @override
  String get rankVirtuoso => 'Виртуоз';

  @override
  String get rankGrandmaster => 'Гроссмейстер';

  @override
  String get drawReasonThreefoldRepetition => 'Троекратное повторение позиции.';

  @override
  String get drawReasonFiftyMoveRule => '50 ходов без взятия или хода пешкой.';

  @override
  String get drawReasonFortyMoveRule => '40 ходов без взятия или хода пешкой.';

  @override
  String get drawReasonTwentyFiveMoveRule =>
      '25 ходов без взятия или хода пешкой.';

  @override
  String get drawReasonFifteenMoveRule =>
      '15 ходов без взятия или хода пешкой.';

  @override
  String get drawReasonInsufficientMaterial =>
      'Недостаточно материала для победы.';

  @override
  String get drawReasonStalemate => 'У обоих игроков нет ходов.';

  @override
  String get gameModeTurkishName => 'Турецкие шашки';

  @override
  String get gameModeTurkishDescription =>
      'Игра на доске 8x8. Фишки ходят вперед и вбок.';

  @override
  String get gameModeEnglishName => 'Английские шашки';

  @override
  String get gameModeEnglishDescription =>
      'Игра на доске 8x8. Пешки не могут бить назад, а дамки не летают.';

  @override
  String get gameModeInternationalName => 'Международные шашки';

  @override
  String get gameModeInternationalDescription =>
      'Игра на доске 10x10. Обязательно бить максимальное количество фишек, дамки летают.';

  @override
  String get gameModeRussianName => 'Русские шашки';

  @override
  String get gameModeRussianDescription =>
      'Фишка, ставшая дамкой во время взятия, может продолжить бить на том же ходу.';

  @override
  String get gameModeSpanishName => 'Испанские шашки';

  @override
  String get gameModeSpanishDescription =>
      'Пешки ходят и бьют только вперед. Обязательно бить максимальное количество фишек, дамки летают.';

  @override
  String get gameModeAntiCheckersName => 'Поддавки';

  @override
  String get gameModeAntiCheckersDescription =>
      'Побеждает тот, кто первым отдаст все свои фишки или не сможет сделать ход.';

  @override
  String get ruleTitleManMove => 'Ход пешки';

  @override
  String get ruleDescManMoveForward =>
      'Пешки ходят только на одно поле по диагонали вперед.';

  @override
  String get ruleTitleManCapture => 'Взятие пешкой';

  @override
  String get ruleDescManCaptureForward =>
      'Пешки бьют только перепрыгивая по диагонали вперед.';

  @override
  String get ruleDescManCaptureBackward =>
      'Пешки могут бить, перепрыгивая по диагонали как вперед, так и назад.';

  @override
  String get ruleTitleKingMove => 'Ход дамки';

  @override
  String get ruleDescKingShort =>
      'Дамки ходят и бьют на одно поле по диагонали в любом направлении.';

  @override
  String get ruleDescKingFlying =>
      'Дамки (или летающие дамки) могут перемещаться на любое количество свободных полей по диагонали.';

  @override
  String get ruleTitleMandatoryCapture => 'Обязательное взятие';

  @override
  String get ruleDescMandatoryCapture =>
      'Если есть возможность взятия, ее необходимо использовать.';

  @override
  String get ruleTitleMaxCapture => 'Правило большинства';

  @override
  String get ruleDescMaxCapture =>
      'Если есть несколько вариантов взятия, необходимо выбрать тот, при котором бьется наибольшее количество фишек.';

  @override
  String get ruleTitleTurkishManMove => 'Ход пешки';

  @override
  String get ruleDescTurkishManMove =>
      'Пешки ходят на одно поле вперед или вбок, но не назад.';

  @override
  String get ruleTitleTurkishCapture => 'Правило взятия';

  @override
  String get ruleDescTurkishCapture =>
      'Фишки бьются, перепрыгивая через них прямо или вбок.';

  @override
  String get ruleTitlePromotion => 'Правило превращения в дамку';

  @override
  String get ruleDescPromotionStops =>
      'Пешка, ставшая дамкой во время взятия, завершает свой ход.';

  @override
  String get ruleDescPromotionContinues =>
      'Пешка, ставшая дамкой во время взятия, может продолжить бить как дамка на том же ходу.';

  @override
  String get ruleTitleAntiCheckersAim => 'Цель';

  @override
  String get ruleDescAntiCheckersAim =>
      'Цель игры — отдать все свои фишки или оказаться в ситуации, когда невозможно сделать ход.';

  @override
  String get tutorialStepWelcomeTitle => 'Добро пожаловать';

  @override
  String get tutorialStepWelcomeDescTurkish =>
      'Добро пожаловать в Турецкие шашки! Фишки расставляются на второй и третьей горизонталях с обеих сторон. Цель - побить все фишки противника.';

  @override
  String get tutorialStepManMoveDescTurkish =>
      'Пешки ходят на одно поле вперед или вбок. Они не могут ходить назад.';

  @override
  String get tutorialStepCaptureTitle => 'Взятие фишки';

  @override
  String get tutorialStepCaptureDescTurkish =>
      'Фишки бьются, перепрыгивая через фишку противника на свободное поле за ней.';

  @override
  String get tutorialStepMaxCaptureTitle => 'Правило большинства';

  @override
  String get tutorialStepMaxCaptureDesc =>
      'Если есть несколько вариантов взятия, вы обязаны выбрать тот путь, который позволяет побить наибольшее количество фишек.';

  @override
  String get tutorialStepPromotionTitle => 'Превращение в дамку';

  @override
  String get tutorialStepPromotionDesc =>
      'Когда пешка достигает последней горизонтали, она превращается в дамку.';

  @override
  String get tutorialStepKingMoveDescTurkish =>
      'Дамка может перемещаться на любое количество свободных полей вперед, назад или вбок (как ладья в шахматах) и бьет, перепрыгивая через фишку на любое свободное поле за ней по той же линии.';

  @override
  String get tutorialStepDrawTitle => 'Условия ничьей';

  @override
  String get tutorialStepDrawDescTurkish =>
      'Ничья объявляется, если одна и та же позиция повторяется трижды, или если в течение 25 ходов не было совершено ни одного взятия.';

  @override
  String get tutorialStepWelcomeDescEnglish =>
      'Добро пожаловать в Английские шашки! Цель - побить все фишки противника. Все ходы и взятия делаются на темных полях.';

  @override
  String get tutorialStepManMoveDescEnglish =>
      'Пешки ходят только на одно поле по диагонали вперед на свободное поле.';

  @override
  String get tutorialStepCaptureDescEnglish =>
      'Пешки бьют, перепрыгивая через фишку противника по диагонали вперед на свободное поле сразу за ней.';

  @override
  String get tutorialStepManCannotCaptureBackwardTitle => 'Нельзя бить назад';

  @override
  String get tutorialStepManCannotCaptureBackwardDesc =>
      'Пешки не могут бить назад. Здесь белая фишка не может побить черную фишку позади себя.';

  @override
  String get tutorialStepMultipleCaptureTitle => 'Множественное взятие';

  @override
  String get tutorialStepMultipleCaptureDesc =>
      'Если после взятия появляется возможность нового взятия, вы должны продолжать бить на том же ходу.';

  @override
  String get tutorialStepPromotionDescEnglish =>
      'Когда пешка достигает самой дальней от себя горизонтали, она превращается в дамку. Ход завершается после превращения.';

  @override
  String get tutorialStepKingMoveDescEnglish =>
      'Дамка может ходить и бить на одно поле по диагонали в любом направлении, вперед или назад.';

  @override
  String get tutorialStepDrawDescEnglish =>
      'Ничья объявляется при троекратном повторении позиции или по соглашению сторон. Также, если на доске остается одна дамка против одной дамки, это ничья.';

  @override
  String get tutorialStepWelcomeDescInternational =>
      'Добро пожаловать в Международные шашки, игра на доске 10x10! Правила похожи на другие варианты, но с ключевыми отличиями.';

  @override
  String get tutorialStepManCaptureDescInternational =>
      'Пешки ходят по диагонали вперед, но могут бить как вперед, так и назад.';

  @override
  String get tutorialStepKingMoveDescInternational =>
      'Дамка является \'летающей\'. Она может перемещаться на любое количество свободных полей по диагонали в любом направлении.';

  @override
  String get tutorialStepKingCaptureTitle => 'Взятие дамкой';

  @override
  String get tutorialStepKingCaptureDesc =>
      'Летающая дамка может побить фишку на расстоянии, перепрыгнув на любое свободное поле за ней, если путь свободен.';

  @override
  String get tutorialStepKingMultipleCaptureTitle =>
      'Множественное взятие дамкой';

  @override
  String get tutorialStepKingMultipleCaptureDesc =>
      'Дамка может выполнить серию взятий, часто меняя направление после каждого прыжка.';

  @override
  String get tutorialStepDrawDescInternational =>
      'Ничья объявляется при троекратном повторении позиции или если в течение 50 ходов не было сделано ни одного взятия или хода пешкой. Некоторые эндшпили, такие как две дамки против одной, также являются ничьей.';

  @override
  String get tutorialStepLosingAimTitle => 'Цель игры';

  @override
  String get tutorialStepLosingAimDesc =>
      'Добро пожаловать в Поддавки! Цель здесь противоположна обычным шашкам: вы выигрываете, отдав все свои фишки или не имея возможности сделать ход.';

  @override
  String get tutorialStepMandatoryCaptureDescLosing =>
      'Как и в обычных шашках, взятие обязательно. Вы должны отдавать свои фишки, если есть такая возможность!';

  @override
  String get tutorialStepTrapTitle => 'Постановка ловушки';

  @override
  String get tutorialStepTrapDesc =>
      'Распространенная стратегия — заставить противника занять позицию, в которой он должен будет совершить длинную серию взятий, забрав много ваших фишек.';

  @override
  String get tutorialStepFallingIntoTrapTitle => 'Попадание в ловушку';

  @override
  String get tutorialStepFallingIntoTrapDesc =>
      'Теперь черный игрок вынужден побить белую фишку, что и было целью Белых.';

  @override
  String get tutorialStepLosingEndgameTitle => 'Эндшпиль';

  @override
  String get tutorialStepLosingEndgameDesc =>
      'Игра заканчивается, когда у одного из игроков не остается фишек на доске или он не может сделать ход. Этот игрок становится победителем! Здесь победили Черные, так как у них не осталось фишек.';

  @override
  String get tutorialStepDrawDescLosing =>
      'Ничьи редки, но могут случиться, например, при троекратном повторении позиции.';

  @override
  String get tutorialStepWelcomeDescRussian =>
      'Добро пожаловать в Русские шашки! У них есть уникальное правило превращения в дамку.';

  @override
  String get tutorialStepManCaptureBackwardTitle => 'Взятие пешкой назад';

  @override
  String get tutorialStepManCaptureBackwardDesc =>
      'Как и в международных шашках, пешки ходят вперед, но могут бить как вперед, так и назад.';

  @override
  String get tutorialStepPromotionDescRussian =>
      'Когда пешка достигает последней горизонтали без взятия, она превращается в дамку, и ход заканчивается.';

  @override
  String get tutorialStepPromotionRuleTitle => 'Особое правило превращения';

  @override
  String get tutorialStepPromotionRuleDescRussian =>
      'КЛЮЧЕВОЕ ПРАВИЛО: Если пешка достигает последней горизонтали в результате взятия, она немедленно становится дамкой и ОБЯЗАНА продолжить взятие на том же ходу, если это возможно.';

  @override
  String get tutorialStepDrawDescRussian =>
      'Ничья может быть зафиксирована при троекратном повторении позиции или если в течение 15 ходов не было произведено ни одного взятия, когда на доске остались только дамки.';

  @override
  String get tutorialStepWelcomeDescSpanish =>
      'Добро пожаловать в Испанские шашки! Этот вариант сочетает в себе правила Английских и Международных шашек.';

  @override
  String get tutorialStepManMoveDescSpanish =>
      'Пешки ходят и бьют только по диагонали вперед, как в Английских шашках.';

  @override
  String get tutorialStepMandatoryCaptureTitle => 'Обязательное взятие';

  @override
  String get tutorialStepMandatoryCaptureDescSpanish =>
      'Взятие обязательно. Если есть несколько вариантов взятия, вы должны выбрать один; для пешек нет правила \'максимального взятия\'.';

  @override
  String get tutorialStepPromotionDescSpanish =>
      'Когда пешка достигает самой дальней горизонтали, она превращается в дамку. Ход заканчивается после превращения.';

  @override
  String get tutorialStepKingMoveDescSpanish =>
      'Дамки являются \'летающими\', что означает, что они могут перемещаться и бить через несколько полей, как в Международных шашках.';

  @override
  String get tutorialStepDrawDescSpanish =>
      'Ничья может быть зафиксирована при троекратном повторении позиции или если в течение 50 ходов не было сделано значимых ходов (взятий или ходов пешками).';

  @override
  String get tutorialStepManMoveTitle => 'Ход пешки';

  @override
  String get tutorialStepKingMoveTitle => 'Ход дамки';

  @override
  String get tutorialStepManCaptureTitle => 'Взятие пешкой';

  @override
  String get categoryClassicNatural => 'Классика и природа';

  @override
  String get categoryCulturalHistorical => 'Культура и история';

  @override
  String get categoryFantasySciFi => 'Фэнтези и научная фантастика';

  @override
  String get categoryLuxuryArtistic => 'Роскошь и искусство';

  @override
  String get categoryModernMinimalist => 'Современный и минималистичный';

  @override
  String get categoryFunColorful => 'Веселый и красочный';

  @override
  String get themeBoardClassicWood => 'Классическое дерево';

  @override
  String get themeBoardMarble => 'Мрамор';

  @override
  String get themeBoardGreenVelvet => 'Зеленый бархат';

  @override
  String get themeBoardOceanBlue => 'Синий океан';

  @override
  String get themeBoardAutumn => 'Осень';

  @override
  String get themeBoardGranite => 'Гранит';

  @override
  String get themeBoardWinterForest => 'Зимний лес';

  @override
  String get themeBoardRiverStone => 'Речной камень';

  @override
  String get themeBoardOttomanTile => 'Османская плитка';

  @override
  String get themeBoardEgyptianPapyrus => 'Египетский папирус';

  @override
  String get themeBoardRomanMosaic => 'Римская мозаика';

  @override
  String get themeBoardJapaneseSakura => 'Японская сакура';

  @override
  String get themeBoardScandinavianRune => 'Скандинавская руна';

  @override
  String get themeBoardAztecSunStone => 'Ацтекский камень солнца';

  @override
  String get themeBoardCelticKnot => 'Кельтский узел';

  @override
  String get themeBoardVictorian => 'Викторианский стиль';

  @override
  String get themeBoardGalaxy => 'Галактика';

  @override
  String get themeBoardEnchantedForest => 'Зачарованный лес';

  @override
  String get themeBoardHellfire => 'Адское пламя';

  @override
  String get themeBoardGlacierKingdom => 'Ледяное королевство';

  @override
  String get themeBoardCyberCircuit => 'Киберсхема';

  @override
  String get themeBoardSteampunk => 'Стимпанк';

  @override
  String get themeBoardAtlantis => 'Атлантида';

  @override
  String get themeBoardCanadaSpace => 'Космос Канады';

  @override
  String get themeBoardBlackGold => 'Черное и золото';

  @override
  String get themeBoardRubyEmerald => 'Рубин и изумруд';

  @override
  String get themeBoardArtDeco => 'Ар-деко';

  @override
  String get themeBoardRoyalVelvet => 'Королевский бархат';

  @override
  String get themeBoardPorcelain => 'Фарфор';

  @override
  String get themeBoardStainedGlass => 'Витраж';

  @override
  String get themeBoardPearl => 'Жемчуг';

  @override
  String get themeBoardBrushStrokes => 'Мазки кистью';

  @override
  String get themeBoardMatteBlack => 'Матовый черный';

  @override
  String get themeBoardConcreteSteel => 'Бетон и сталь';

  @override
  String get themeBoardCarbonFiber => 'Углеволокно';

  @override
  String get themeBoardGlass => 'Стекло';

  @override
  String get themeBoardPaper => 'Бумага';

  @override
  String get themeBoardDigitalPixel => 'Цифровой пиксель';

  @override
  String get themeBoardPastelGeometry => 'Пастельная геометрия';

  @override
  String get themeBoardMonochromeGradient => 'Монохромный градиент';

  @override
  String get themeBoardCandyLand => 'Конфетная страна';

  @override
  String get themeBoardComicBook => 'Комикс';

  @override
  String get themeBoard8BitRetro => '8-битное ретро';

  @override
  String get themeBoardToyBlocks => 'Игрушечные блоки';

  @override
  String get themeBoardRainbow => 'Радуга';

  @override
  String get themeBoardGraffiti => 'Граффити';

  @override
  String get themeBoardWatercolor => 'Акварель';

  @override
  String get themeBoardHoneycomb => 'Пчелиные соты';

  @override
  String get themePieceCarvedWood => 'Резное дерево';

  @override
  String get themePieceIvoryEbony => 'Слоновая кость и эбен';

  @override
  String get themePiecePolishedPebble => 'Полированная галька';

  @override
  String get themePieceEarthenware => 'Гончарные изделия';

  @override
  String get themePieceFrostedGlass => 'Матовое стекло';

  @override
  String get themePieceRedJasper => 'Красная яшма';

  @override
  String get themePieceBamboo => 'Бамбук';

  @override
  String get themePieceAmber => 'Янтарь';

  @override
  String get themePieceIznikTile => 'Изникская плитка';

  @override
  String get themePieceLapisLazuli => 'Лазурит';

  @override
  String get themePieceJade => 'Нефрит';

  @override
  String get themePieceAncientBronze => 'Древняя бронза';

  @override
  String get themePieceObsidian => 'Обсидиан';

  @override
  String get themePieceParchment => 'Пергамент';

  @override
  String get themePieceTerracotta => 'Терракота';

  @override
  String get themePieceIronRune => 'Железная руна';

  @override
  String get themePieceDragonScale => 'Чешуя дракона';

  @override
  String get themePieceCrystal => 'Кристалл';

  @override
  String get themePieceNeonLights => 'Неоновые огни';

  @override
  String get themePieceGhost => 'Призрак';

  @override
  String get themePieceVolcanicMagma => 'Вулканическая магма';

  @override
  String get themePieceElvenMithril => 'Эльфийский мифрил';

  @override
  String get themePieceOrcishIron => 'Орочье железо';

  @override
  String get themePieceCosmicDust => 'Космическая пыль';

  @override
  String get themePieceGoldSilver => 'Золото и серебро';

  @override
  String get themePieceBlackPearl => 'Черный жемчуг';

  @override
  String get themePieceMalachite => 'Малахит';

  @override
  String get themePieceVenetianGlass => 'Венецианское стекло';

  @override
  String get themePieceGatsby => 'Гэтсби';

  @override
  String get themePieceDiamond => 'Алмаз';

  @override
  String get themePieceRuby => 'Рубин';

  @override
  String get themePieceSapphire => 'Сапфир';

  @override
  String get themePieceModernMinimalist => 'Современный минимализм';

  @override
  String get themePieceRobotic => 'Роботизированный';

  @override
  String get themePieceMetallicGradient => 'Металлический градиент';

  @override
  String get themePieceGlossyPlastic => 'Глянцевый пластик';

  @override
  String get themePieceHolographic => 'Голографический';

  @override
  String get themePieceMattePastel => 'Матовый пастельный';

  @override
  String get themePieceRubber => 'Резина';

  @override
  String get themePieceLightShadow => 'Свет и тень';

  @override
  String get themePieceConfectionery => 'Кондитерские изделия';

  @override
  String get themePieceChocolate => 'Шоколад';

  @override
  String get themePieceFruitBasket => 'Фруктовая корзина';

  @override
  String get themePieceGummy => 'Мармелад';

  @override
  String get themePieceWatermelon => 'Арбуз';

  @override
  String get themePieceCosmonaut => 'Космонавт';

  @override
  String get themePieceSuperhero => 'Супергерой';

  @override
  String get themePieceSeashell => 'Морская ракушка';

  @override
  String get languageSpanish => 'испанский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageGerman => 'Немецкий';

  @override
  String get languagePortuguese => 'Португальский';

  @override
  String get languageFrench => 'Французский';

  @override
  String get languageItalian => 'Итальянский';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get version => 'Версия';

  @override
  String get aboutHeader => 'О ПРОЕКТЕ';

  @override
  String get noInternetConnection => 'Нет подключения к Интернету';

  @override
  String get noInternetConnectionMessage =>
      'Пожалуйста, проверьте ваше интернет-соединение и попробуйте еще раз.';

  @override
  String get savedGameDialogTitle =>
      'У вас есть сохраненная игра. Что вы хотите сделать?';

  @override
  String get deleteAction => 'Удалить';
}
