// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'World of Checkers';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageHeader => 'Language';

  @override
  String get language => 'App Language';

  @override
  String get languageSelectionTitle => 'Select Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageTurkish => 'Turkish';

  @override
  String get appearanceHeader => 'Appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get themeDark => 'Dark';

  @override
  String get gameExperienceHeader => 'Game Experience';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get haptics => 'Haptic Feedback';

  @override
  String get showCoordinates => 'Show Coordinates';

  @override
  String get gamePreferencesHeader => 'Game Preferences';

  @override
  String get gamePreferencesDescription =>
      'This setting only applies when starting a new game.';

  @override
  String get colorWhite => 'White';

  @override
  String get colorRandom => 'Random';

  @override
  String get colorBlack => 'Black';

  @override
  String get progressHeader => 'Progress';

  @override
  String get resetAllRanks => 'Reset All Ranks';

  @override
  String get resetProgressConfirmationTitle => 'Reset Progress?';

  @override
  String get resetProgressConfirmationBody =>
      'Your progress and unlocked levels in all game modes will be permanently deleted. This action cannot be undone.';

  @override
  String get dialogCancel => 'Cancel';

  @override
  String get dialogReset => 'Reset';

  @override
  String get progressResetSuccess => 'Progress Reset';

  @override
  String get dialogOK => 'OK';

  @override
  String get mainMenuPlayButtonAI => 'Play Against AI';

  @override
  String get mainMenuPlayButtonHuman => 'Play with a Friend';

  @override
  String get mainMenuContinue => 'Continue';

  @override
  String get mainMenuOpponentAI => 'Artificial Intelligence';

  @override
  String get mainMenuOpponentHuman => 'Play with a Friend';

  @override
  String get mainMenuRules => 'Rules';

  @override
  String get mainMenuExploreThemes => 'Explore Themes';

  @override
  String get close => 'Close';

  @override
  String levelNumber(int level) {
    return 'Level $level';
  }

  @override
  String get themeStoreTitle => 'Theme Store';

  @override
  String get searchBoardPlaceholder => 'Search boards...';

  @override
  String get searchPiecePlaceholder => 'Search pieces...';

  @override
  String get boards => 'Boards';

  @override
  String get pieces => 'Pieces';

  @override
  String get noResults => 'No results found';

  @override
  String get loadingStatusInitializing => 'Initializing...';

  @override
  String get loadingStatusSettings => 'Loading settings...';

  @override
  String get loadingStatusUI => 'Preparing interface...';

  @override
  String get loadingStatusReady => 'Ready!';

  @override
  String get gameScreenConfirmExitTitle => 'Exit Game?';

  @override
  String get gameScreenConfirmExitBody =>
      'Do you want to save the current game before exiting?';

  @override
  String get gameScreenSaveAndExit => 'Save and Exit';

  @override
  String get gameScreenExitWithoutSaving => 'Exit Without Saving';

  @override
  String get gameScreenPaused => 'Game Paused';

  @override
  String get gameScreenResume => 'Resume';

  @override
  String get gameScreenRestart => 'Restart';

  @override
  String get gameScreenReturnToMenu => 'Return to Menu';

  @override
  String get gameOverWinTitle => 'You Won!';

  @override
  String get gameOverWinBody =>
      'Congratulations! You have defeated the opponent.';

  @override
  String get gameOverNewRankBody => 'You have achieved a new rank!';

  @override
  String get gameOverNewRankTitle => 'New Rank Unlocked!';

  @override
  String get gameOverLoseTitle => 'You Lost!';

  @override
  String get gameOverLoseBody => 'Better luck next time!';

  @override
  String get gameOverDrawTitle => 'Draw!';

  @override
  String get gameOverTitle => 'Game Over';

  @override
  String gameOverWinner(String winner) {
    return '$winner wins!';
  }

  @override
  String get gameOverNewGame => 'New Game';

  @override
  String get playerYou => 'You';

  @override
  String get playerComputer => 'Computer';

  @override
  String get playerWhite => 'White';

  @override
  String get playerBlack => 'Black';

  @override
  String get aiThinking => 'Thinking...';

  @override
  String get nextMove => 'Your Turn';

  @override
  String get waiting => 'Waiting...';

  @override
  String tutorialTitle(String gameMode) {
    return '$gameMode Tutorial';
  }

  @override
  String get tutorialNext => 'Next';

  @override
  String get tutorialPrevious => 'Previous';

  @override
  String get tutorialPlay => 'Play';

  @override
  String get rankNovice => 'Novice';

  @override
  String get rankApprentice => 'Apprentice';

  @override
  String get rankJourneyman => 'Journeyman';

  @override
  String get rankMaster => 'Master';

  @override
  String get rankExpert => 'Expert';

  @override
  String get rankVirtuoso => 'Virtuoso';

  @override
  String get rankGrandmaster => 'Grandmaster';

  @override
  String get drawReasonThreefoldRepetition =>
      'The same position was repeated three times.';

  @override
  String get drawReasonFiftyMoveRule =>
      'No piece has been captured or promoted for 50 moves.';

  @override
  String get drawReasonFortyMoveRule =>
      'No piece has been captured or promoted for 40 moves.';

  @override
  String get drawReasonTwentyFiveMoveRule =>
      'No piece has been captured or promoted for 25 moves.';

  @override
  String get drawReasonFifteenMoveRule =>
      'No piece has been captured or promoted for 15 moves.';

  @override
  String get drawReasonInsufficientMaterial =>
      'The remaining pieces are insufficient to win the game.';

  @override
  String get drawReasonStalemate => 'Neither player has any legal moves left.';

  @override
  String get gameModeTurkishName => 'Turkish Checkers';

  @override
  String get gameModeTurkishDescription =>
      'A unique variant where pieces move orthogonally. Strategic depth arises from its distinct movement and capture rules.';

  @override
  String get gameModeEnglishName => 'English Checkers';

  @override
  String get gameModeEnglishDescription =>
      'The classic game. Simple to learn, but with a high skill ceiling. Known as American Checkers or Straight Checkers.';

  @override
  String get gameModeInternationalName => 'International Draughts';

  @override
  String get gameModeInternationalDescription =>
      'The world standard for competitive draughts, played on a 10x10 board with powerful flying kings.';

  @override
  String get gameModeRussianName => 'Russian Checkers';

  @override
  String get gameModeRussianDescription =>
      'A dynamic variant where men can capture backward and promotion has a unique twist.';

  @override
  String get gameModeSpanishName => 'Spanish Checkers';

  @override
  String get gameModeSpanishDescription =>
      'Similar to International Draughts but on an 8x8 board. Emphasizes aggressive capture strategies.';

  @override
  String get gameModeAntiCheckersName => 'Anti-Checkers';

  @override
  String get gameModeAntiCheckersDescription =>
      'The goal is reversed! Force your opponent to capture all your pieces to win. A game of clever sacrifices.';

  @override
  String get ruleTitleManMove => 'Man Movement';

  @override
  String get ruleDescManMoveForward => 'Men move one step diagonally forward.';

  @override
  String get ruleTitleManCapture => 'Man Capture';

  @override
  String get ruleDescManCaptureForward =>
      'Men capture by jumping one step diagonally forward.';

  @override
  String get ruleDescManCaptureBackward =>
      'Men can capture both forward and backward.';

  @override
  String get ruleTitleKingMove => 'King Movement';

  @override
  String get ruleDescKingShort =>
      'Kings move one step diagonally in any direction.';

  @override
  String get ruleDescKingFlying =>
      'Kings can move any number of empty squares diagonally.';

  @override
  String get ruleTitleMandatoryCapture => 'Mandatory Capture';

  @override
  String get ruleDescMandatoryCapture =>
      'If a capture is available, it must be made.';

  @override
  String get ruleTitleMaxCapture => 'Maximum Capture';

  @override
  String get ruleDescMaxCapture =>
      'If multiple capture sequences are available, the one that captures the most pieces must be chosen.';

  @override
  String get ruleTitleTurkishManMove => 'Man Movement (Turkish)';

  @override
  String get ruleDescTurkishManMove => 'Men move one step forward or sideways.';

  @override
  String get ruleTitleTurkishCapture => 'Man Capture (Turkish)';

  @override
  String get ruleDescTurkishCapture =>
      'Men capture by jumping over an opponent (forward, backward, or sideways).';

  @override
  String get ruleTitlePromotion => 'Promotion';

  @override
  String get ruleDescPromotionStops =>
      'The turn ends when a piece is promoted. It cannot continue a capture sequence in the same turn.';

  @override
  String get ruleDescPromotionContinues =>
      'If a piece is promoted during a capture sequence, it continues the sequence as a King in the same turn.';

  @override
  String get ruleTitleAntiCheckersAim => 'Objective';

  @override
  String get ruleDescAntiCheckersAim =>
      'The goal is to give away all your pieces or have no legal moves.';

  @override
  String get tutorialStepWelcomeTitle => 'Welcome!';

  @override
  String get tutorialStepWelcomeDescTurkish =>
      'Welcome to Turkish Checkers! Pieces move orthogonally (forward or sideways).';

  @override
  String get tutorialStepManMoveDescTurkish =>
      'Men move one square forward or sideways, not diagonally.';

  @override
  String get tutorialStepCaptureTitle => 'Capture';

  @override
  String get tutorialStepCaptureDescTurkish =>
      'Men capture by jumping over an opponent\'s piece to the empty square beyond (forward, backward, or sideways).';

  @override
  String get tutorialStepMaxCaptureTitle => 'Maximum Capture Rule';

  @override
  String get tutorialStepMaxCaptureDesc =>
      'It is mandatory to capture the maximum possible number of opponent\'s pieces.';

  @override
  String get tutorialStepPromotionTitle => 'Promotion';

  @override
  String get tutorialStepPromotionDesc =>
      'When a man reaches the last row, it becomes a King.';

  @override
  String get tutorialStepKingMoveDescTurkish =>
      'Kings move like a rook in chess, any number of squares horizontally or vertically.';

  @override
  String get tutorialStepDrawTitle => 'Draw';

  @override
  String get tutorialStepDrawDescTurkish =>
      'The game is a draw if 20 moves are made without any capture.';

  @override
  String get tutorialStepWelcomeDescEnglish =>
      'This is the starting position for English Checkers. The goal is to capture all of your opponent\'s pieces.';

  @override
  String get tutorialStepManMoveDescEnglish =>
      'Men can only move one step forward diagonally.';

  @override
  String get tutorialStepCaptureDescEnglish =>
      'Men capture by jumping over an opponent\'s piece to the empty square beyond.';

  @override
  String get tutorialStepManCannotCaptureBackwardTitle =>
      'Cannot Capture Backward';

  @override
  String get tutorialStepManCannotCaptureBackwardDesc =>
      'Men cannot capture backward.';

  @override
  String get tutorialStepMultipleCaptureTitle => 'Multiple Captures';

  @override
  String get tutorialStepMultipleCaptureDesc =>
      'If possible, you must complete a sequence of captures in a single turn.';

  @override
  String get tutorialStepPromotionDescEnglish =>
      'When a man reaches the last row, it is promoted to a King.';

  @override
  String get tutorialStepKingMoveDescEnglish =>
      'Kings can move and capture both forward and backward.';

  @override
  String get tutorialStepDrawDescEnglish =>
      'The game is a draw if no captures have been made in 40 moves.';

  @override
  String get tutorialStepWelcomeDescInternational =>
      'This is International Draughts, played on a 10x10 board. The goal is to capture all opponent pieces.';

  @override
  String get tutorialStepManCaptureDescInternational =>
      'Men can capture both forward and backward.';

  @override
  String get tutorialStepKingMoveDescInternational =>
      'Kings are \'flying\'. They can move any number of empty squares diagonally.';

  @override
  String get tutorialStepKingCaptureTitle => 'King Capture';

  @override
  String get tutorialStepKingCaptureDesc =>
      'A flying king can jump over an opponent\'s piece from any distance to any empty square beyond it.';

  @override
  String get tutorialStepKingMultipleCaptureTitle => 'Multiple King Captures';

  @override
  String get tutorialStepKingMultipleCaptureDesc =>
      'A flying king can change direction during a multiple capture sequence.';

  @override
  String get tutorialStepDrawDescInternational =>
      'The game is a draw if, for 25 moves, only kings have been moved, without any captures.';

  @override
  String get tutorialStepLosingAimTitle => 'The Goal of the Game';

  @override
  String get tutorialStepLosingAimDesc =>
      'The goal in Anti-Checkers is to lose all your pieces or be unable to make a move.';

  @override
  String get tutorialStepMandatoryCaptureDescLosing =>
      'If you can capture an opponent\'s piece, you must. This is how you force your opponent to take your pieces.';

  @override
  String get tutorialStepTrapTitle => 'Setting a Trap';

  @override
  String get tutorialStepTrapDesc =>
      'Force your opponent to take your pieces by leaving them no other choice.';

  @override
  String get tutorialStepFallingIntoTrapTitle => 'Falling into the Trap';

  @override
  String get tutorialStepFallingIntoTrapDesc =>
      'The opponent has no choice but to capture your piece.';

  @override
  String get tutorialStepLosingEndgameTitle => 'Endgame';

  @override
  String get tutorialStepLosingEndgameDesc =>
      'The player who runs out of pieces first wins!';

  @override
  String get tutorialStepDrawDescLosing =>
      'The game is a draw if no captures have been made in 40 moves.';

  @override
  String get tutorialStepWelcomeDescRussian =>
      'Welcome to Russian Checkers! The rules are similar to English Checkers, but with some key differences.';

  @override
  String get tutorialStepManCaptureBackwardTitle => 'Men Capture Backward';

  @override
  String get tutorialStepManCaptureBackwardDesc =>
      'Unlike English Checkers, men can capture backward.';

  @override
  String get tutorialStepPromotionDescRussian =>
      'A man is promoted to a King if it reaches the last row.';

  @override
  String get tutorialStepPromotionRuleTitle => 'Special Promotion Rule';

  @override
  String get tutorialStepPromotionRuleDescRussian =>
      'If a man reaches the promotion row via a capture and can continue jumping, it does so as a man, only becoming a king at the end of the turn.';

  @override
  String get tutorialStepDrawDescRussian =>
      'The game is a draw if, for 15 moves, only kings have been moved, without any captures.';

  @override
  String get tutorialStepWelcomeDescSpanish =>
      'Welcome to Spanish Checkers! It shares rules with International Draughts but is played on an 8x8 board.';

  @override
  String get tutorialStepManMoveDescSpanish =>
      'Men move forward and capture by jumping over an opponent\'s piece.';

  @override
  String get tutorialStepMandatoryCaptureTitle => 'Forced Capture';

  @override
  String get tutorialStepMandatoryCaptureDescSpanish =>
      'Capturing is mandatory. If there are multiple capture options, the one that takes the most pieces must be chosen.';

  @override
  String get tutorialStepPromotionDescSpanish =>
      'A man that reaches the last row is promoted to a King.';

  @override
  String get tutorialStepKingMoveDescSpanish =>
      'Kings are \'flying\' and can move and capture over multiple squares.';

  @override
  String get tutorialStepDrawDescSpanish =>
      'The game is a draw if no captures have been made in 50 moves.';

  @override
  String get tutorialStepManMoveTitle => 'Man Movement';

  @override
  String get tutorialStepKingMoveTitle => 'King Movement';

  @override
  String get tutorialStepManCaptureTitle => 'Man Capture';

  @override
  String get categoryClassicNatural => 'Classic & Natural';

  @override
  String get categoryCulturalHistorical => 'Cultural & Historical';

  @override
  String get categoryFantasySciFi => 'Fantasy & Sci-Fi';

  @override
  String get categoryLuxuryArtistic => 'Luxury & Artistic';

  @override
  String get categoryModernMinimalist => 'Modern & Minimalist';

  @override
  String get categoryFunColorful => 'Fun & Colorful';

  @override
  String get themeBoardClassicWood => 'Classic Wood';

  @override
  String get themeBoardMarble => 'Marble';

  @override
  String get themeBoardGreenVelvet => 'Green Velvet';

  @override
  String get themeBoardOceanBlue => 'Ocean Blue';

  @override
  String get themeBoardAutumn => 'Autumn';

  @override
  String get themeBoardGranite => 'Granite';

  @override
  String get themeBoardWinterForest => 'Winter Forest';

  @override
  String get themeBoardRiverStone => 'River Stone';

  @override
  String get themeBoardOttomanTile => 'Ottoman Tile';

  @override
  String get themeBoardEgyptianPapyrus => 'Egyptian Papyrus';

  @override
  String get themeBoardRomanMosaic => 'Roman Mosaic';

  @override
  String get themeBoardJapaneseSakura => 'Japanese Sakura';

  @override
  String get themeBoardScandinavianRune => 'Scandinavian Rune';

  @override
  String get themeBoardAztecSunStone => 'Aztec Sun Stone';

  @override
  String get themeBoardCelticKnot => 'Celtic Knot';

  @override
  String get themeBoardVictorian => 'Victorian';

  @override
  String get themeBoardGalaxy => 'Galaxy';

  @override
  String get themeBoardEnchantedForest => 'Enchanted Forest';

  @override
  String get themeBoardHellfire => 'Hellfire';

  @override
  String get themeBoardGlacierKingdom => 'Glacier Kingdom';

  @override
  String get themeBoardCyberCircuit => 'Cyber Circuit';

  @override
  String get themeBoardSteampunk => 'Steampunk';

  @override
  String get themeBoardAtlantis => 'Atlantis';

  @override
  String get themeBoardCanadaSpace => 'Canada Space';

  @override
  String get themeBoardBlackGold => 'Black & Gold';

  @override
  String get themeBoardRubyEmerald => 'Ruby & Emerald';

  @override
  String get themeBoardArtDeco => 'Art Deco';

  @override
  String get themeBoardRoyalVelvet => 'Royal Velvet';

  @override
  String get themeBoardPorcelain => 'Porcelain';

  @override
  String get themeBoardStainedGlass => 'Stained Glass';

  @override
  String get themeBoardPearl => 'Pearl';

  @override
  String get themeBoardBrushStrokes => 'Brush Strokes';

  @override
  String get themeBoardMatteBlack => 'Matte Black';

  @override
  String get themeBoardConcreteSteel => 'Concrete & Steel';

  @override
  String get themeBoardCarbonFiber => 'Carbon Fiber';

  @override
  String get themeBoardGlass => 'Glass';

  @override
  String get themeBoardPaper => 'Paper';

  @override
  String get themeBoardDigitalPixel => 'Digital Pixel';

  @override
  String get themeBoardPastelGeometry => 'Pastel Geometry';

  @override
  String get themeBoardMonochromeGradient => 'Monochrome Gradient';

  @override
  String get themeBoardCandyLand => 'Candy Land';

  @override
  String get themeBoardComicBook => 'Comic Book';

  @override
  String get themeBoard8BitRetro => '8-Bit Retro';

  @override
  String get themeBoardToyBlocks => 'Toy Blocks';

  @override
  String get themeBoardRainbow => 'Rainbow';

  @override
  String get themeBoardGraffiti => 'Graffiti';

  @override
  String get themeBoardWatercolor => 'Watercolor';

  @override
  String get themeBoardHoneycomb => 'Honeycomb';

  @override
  String get themePieceCarvedWood => 'Carved Wood';

  @override
  String get themePieceIvoryEbony => 'Ivory & Ebony';

  @override
  String get themePiecePolishedPebble => 'Polished Pebble';

  @override
  String get themePieceEarthenware => 'Earthenware';

  @override
  String get themePieceFrostedGlass => 'Frosted Glass';

  @override
  String get themePieceRedJasper => 'Red Jasper';

  @override
  String get themePieceBamboo => 'Bamboo';

  @override
  String get themePieceAmber => 'Amber';

  @override
  String get themePieceIznikTile => 'Iznik Tile';

  @override
  String get themePieceLapisLazuli => 'Lapis Lazuli';

  @override
  String get themePieceJade => 'Jade';

  @override
  String get themePieceAncientBronze => 'Ancient Bronze';

  @override
  String get themePieceObsidian => 'Obsidian';

  @override
  String get themePieceParchment => 'Parchment';

  @override
  String get themePieceTerracotta => 'Terracotta';

  @override
  String get themePieceIronRune => 'Iron Rune';

  @override
  String get themePieceDragonScale => 'Dragon Scale';

  @override
  String get themePieceCrystal => 'Crystal';

  @override
  String get themePieceNeonLights => 'Neon Lights';

  @override
  String get themePieceGhost => 'Ghost';

  @override
  String get themePieceVolcanicMagma => 'Volcanic Magma';

  @override
  String get themePieceElvenMithril => 'Elven Mithril';

  @override
  String get themePieceOrcishIron => 'Orcish Iron';

  @override
  String get themePieceCosmicDust => 'Cosmic Dust';

  @override
  String get themePieceGoldSilver => 'Gold & Silver';

  @override
  String get themePieceBlackPearl => 'Black Pearl';

  @override
  String get themePieceMalachite => 'Malachite';

  @override
  String get themePieceVenetianGlass => 'Venetian Glass';

  @override
  String get themePieceGatsby => 'Gatsby';

  @override
  String get themePieceDiamond => 'Diamond';

  @override
  String get themePieceRuby => 'Ruby';

  @override
  String get themePieceSapphire => 'Sapphire';

  @override
  String get themePieceModernMinimalist => 'Modern Minimalist';

  @override
  String get themePieceRobotic => 'Robotic';

  @override
  String get themePieceMetallicGradient => 'Metallic Gradient';

  @override
  String get themePieceGlossyPlastic => 'Glossy Plastic';

  @override
  String get themePieceHolographic => 'Holographic';

  @override
  String get themePieceMattePastel => 'Matte Pastel';

  @override
  String get themePieceRubber => 'Rubber';

  @override
  String get themePieceLightShadow => 'Light & Shadow';

  @override
  String get themePieceConfectionery => 'Confectionery';

  @override
  String get themePieceChocolate => 'Chocolate';

  @override
  String get themePieceFruitBasket => 'Fruit Basket';

  @override
  String get themePieceGummy => 'Gummy';

  @override
  String get themePieceWatermelon => 'Watermelon';

  @override
  String get themePieceCosmonaut => 'Cosmonaut';

  @override
  String get themePieceSuperhero => 'Superhero';

  @override
  String get themePieceSeashell => 'Seashell';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageGerman => 'German';

  @override
  String get languagePortuguese => 'Portuguese';

  @override
  String get languageFrench => 'French';

  @override
  String get languageItalian => 'Italian';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get version => 'Version';

  @override
  String get aboutHeader => 'About';

  @override
  String get noInternetConnection => 'No Internet Connection';

  @override
  String get noInternetConnectionMessage =>
      'Please check your internet connection and try again.';

  @override
  String get savedGameDialogTitle =>
      'You have a saved game. What would you like to do?';

  @override
  String get deleteAction => 'Delete';
}
