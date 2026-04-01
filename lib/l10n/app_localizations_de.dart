// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Welt der Dame';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get languageHeader => 'SPRACHE';

  @override
  String get language => 'Sprache';

  @override
  String get languageSelectionTitle => 'Sprache auswählen';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageTurkish => 'Türkisch';

  @override
  String get appearanceHeader => 'ERSCHEINUNGSBILD';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeSystem => 'System';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get gameExperienceHeader => 'SPIELERLEBNIS';

  @override
  String get soundEffects => 'Soundeffekte';

  @override
  String get haptics => 'Haptisches Feedback';

  @override
  String get showCoordinates => 'Koordinaten anzeigen';

  @override
  String get gamePreferencesHeader => 'SPIELEINSTELLUNGEN';

  @override
  String get gamePreferencesDescription =>
      'Wähle, mit welcher Farbe du gegen den Computer beginnen möchtest.';

  @override
  String get colorWhite => 'Weiß';

  @override
  String get colorRandom => 'Zufällig';

  @override
  String get colorBlack => 'Schwarz';

  @override
  String get progressHeader => 'FORTSCHRITT';

  @override
  String get resetAllRanks => 'Alle Ränge zurücksetzen';

  @override
  String get resetProgressConfirmationTitle => 'Fortschritt zurücksetzen?';

  @override
  String get resetProgressConfirmationBody =>
      'Dein Rangfortschritt in allen Spielmodi wird dauerhaft gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get dialogCancel => 'Abbrechen';

  @override
  String get dialogReset => 'Zurücksetzen';

  @override
  String get progressResetSuccess => 'Fortschritt zurückgesetzt';

  @override
  String get dialogOK => 'OK';

  @override
  String get mainMenuPlayButtonAI => 'Level wählen';

  @override
  String get mainMenuPlayButtonHuman => 'Neues Spiel';

  @override
  String get mainMenuContinue => 'Fortsetzen';

  @override
  String get mainMenuOpponentAI => 'Künstliche Intelligenz';

  @override
  String get mainMenuOpponentHuman => 'Zwei Spieler';

  @override
  String get mainMenuRules => 'Regeln';

  @override
  String get mainMenuExploreThemes => 'Themen entdecken';

  @override
  String get close => 'Schließen';

  @override
  String levelNumber(int level) {
    return 'Level $level';
  }

  @override
  String get themeStoreTitle => 'Themen-Shop';

  @override
  String get searchBoardPlaceholder => 'Bretter suchen';

  @override
  String get searchPiecePlaceholder => 'Steine suchen';

  @override
  String get boards => 'Bretter';

  @override
  String get pieces => 'Steine';

  @override
  String get noResults => 'Keine Ergebnisse gefunden';

  @override
  String get loadingStatusInitializing => 'Initialisiere...';

  @override
  String get loadingStatusSettings => 'Lade Einstellungen...';

  @override
  String get loadingStatusUI => 'Optimiere Oberfläche...';

  @override
  String get loadingStatusReady => 'Bereit!';

  @override
  String get gameScreenConfirmExitTitle => 'Zurück zum Hauptmenü';

  @override
  String get gameScreenConfirmExitBody =>
      'Möchtest du das aktuelle Spiel speichern?';

  @override
  String get gameScreenSaveAndExit => 'Speichern und Beenden';

  @override
  String get gameScreenExitWithoutSaving => 'Beenden ohne Speichern';

  @override
  String get gameScreenPaused => 'Pausiert';

  @override
  String get gameScreenResume => 'Fortsetzen';

  @override
  String get gameScreenRestart => 'Neustart';

  @override
  String get gameScreenReturnToMenu => 'Zum Menü';

  @override
  String get gameOverWinTitle => 'Herzlichen Glückwunsch, du hast gewonnen!';

  @override
  String get gameOverWinBody => 'Ein großartiger Sieg!';

  @override
  String get gameOverNewRankBody => 'Du hast einen neuen Rang erreicht!';

  @override
  String get gameOverNewRankTitle => 'RANG AUFGESTIEGEN!';

  @override
  String get gameOverLoseTitle => 'Du hast verloren';

  @override
  String get gameOverLoseBody => 'Du solltest mehr üben.';

  @override
  String get gameOverDrawTitle => 'Unentschieden!';

  @override
  String get gameOverTitle => 'Spiel beendet!';

  @override
  String gameOverWinner(String winner) {
    return 'Gewinner: $winner';
  }

  @override
  String get gameOverNewGame => 'Neues Spiel';

  @override
  String get playerYou => 'Du';

  @override
  String get playerComputer => 'Computer';

  @override
  String get playerWhite => 'Weiß';

  @override
  String get playerBlack => 'Schwarz';

  @override
  String get aiThinking => 'Denkt nach...';

  @override
  String get nextMove => 'Nächster Zug';

  @override
  String get waiting => 'Wartet...';

  @override
  String tutorialTitle(String gameMode) {
    return 'Tutorial: $gameMode';
  }

  @override
  String get tutorialNext => 'Weiter';

  @override
  String get tutorialPrevious => 'Zurück';

  @override
  String get tutorialPlay => 'Start';

  @override
  String get rankNovice => 'Anfänger';

  @override
  String get rankApprentice => 'Lehrling';

  @override
  String get rankJourneyman => 'Geselle';

  @override
  String get rankMaster => 'Meister';

  @override
  String get rankExpert => 'Experte';

  @override
  String get rankVirtuoso => 'Virtuose';

  @override
  String get rankGrandmaster => 'Großmeister';

  @override
  String get drawReasonThreefoldRepetition =>
      'Die gleiche Stellung wurde dreimal wiederholt.';

  @override
  String get drawReasonFiftyMoveRule =>
      '50 Züge lang wurde kein Stein geschlagen oder zur Dame befördert.';

  @override
  String get drawReasonFortyMoveRule =>
      '40 Züge lang wurde kein Stein geschlagen oder zur Dame befördert.';

  @override
  String get drawReasonTwentyFiveMoveRule =>
      '25 Züge lang wurde kein Stein geschlagen oder zur Dame befördert.';

  @override
  String get drawReasonFifteenMoveRule =>
      '15 Züge lang wurde kein Stein geschlagen oder zur Dame befördert.';

  @override
  String get drawReasonInsufficientMaterial =>
      'Die verbleibenden Steine reichen nicht aus, um das Spiel zu gewinnen.';

  @override
  String get drawReasonStalemate => 'Keiner der Spieler hat einen legalen Zug.';

  @override
  String get gameModeTurkishName => 'Türkische Dame';

  @override
  String get gameModeTurkishDescription =>
      'Gespielt auf einem 8x8-Brett. Steine bewegen sich vorwärts und seitwärts.';

  @override
  String get gameModeEnglishName => 'Englische Dame';

  @override
  String get gameModeEnglishDescription =>
      'Gespielt auf einem 8x8-Brett. Einfache Steine können nicht rückwärts schlagen und Damen fliegen nicht.';

  @override
  String get gameModeInternationalName => 'Internationale Dame';

  @override
  String get gameModeInternationalDescription =>
      'Gespielt auf einem 10x10-Brett. Es besteht Schlagzwang für die meisten Steine und Damen fliegen.';

  @override
  String get gameModeRussianName => 'Russische Dame';

  @override
  String get gameModeRussianDescription =>
      'Ein Stein, der durch Schlagen zur Dame wird, kann im selben Zug weiterschlagen.';

  @override
  String get gameModeSpanishName => 'Spanische Dame';

  @override
  String get gameModeSpanishDescription =>
      'Einfache Steine können nur vorwärts ziehen/schlagen. Es besteht Schlagzwang für die meisten Steine und Damen fliegen.';

  @override
  String get gameModeAntiCheckersName => 'Dame-Verschenken';

  @override
  String get gameModeAntiCheckersDescription =>
      'Der erste Spieler, der alle seine Steine verliert oder keine Züge mehr hat, gewinnt.';

  @override
  String get ruleTitleManMove => 'Zug eines einfachen Steins';

  @override
  String get ruleDescManMoveForward =>
      'Einfache Steine ziehen nur ein Feld diagonal vorwärts.';

  @override
  String get ruleTitleManCapture => 'Schlagen mit einem einfachen Stein';

  @override
  String get ruleDescManCaptureForward =>
      'Einfache Steine schlagen nur durch Überspringen diagonal vorwärts.';

  @override
  String get ruleDescManCaptureBackward =>
      'Einfache Steine können durch Überspringen diagonal vorwärts und rückwärts schlagen.';

  @override
  String get ruleTitleKingMove => 'Zug einer Dame';

  @override
  String get ruleDescKingShort =>
      'Damen ziehen und schlagen ein Feld diagonal in jede Richtung.';

  @override
  String get ruleDescKingFlying =>
      'Damen (oder fliegende Damen) können eine beliebige Anzahl freier Felder diagonal ziehen.';

  @override
  String get ruleTitleMandatoryCapture => 'Schlagzwang';

  @override
  String get ruleDescMandatoryCapture =>
      'Wenn ein Schlag möglich ist, muss er ausgeführt werden.';

  @override
  String get ruleTitleMaxCapture => 'Regel des Maximums';

  @override
  String get ruleDescMaxCapture =>
      'Wenn mehrere Schlagfolgen möglich sind, muss diejenige gewählt werden, die die meisten Steine schlägt.';

  @override
  String get ruleTitleTurkishManMove => 'Zug eines einfachen Steins';

  @override
  String get ruleDescTurkishManMove =>
      'Einfache Steine ziehen ein Feld vorwärts oder seitwärts, aber nicht rückwärts.';

  @override
  String get ruleTitleTurkishCapture => 'Schlagregel';

  @override
  String get ruleDescTurkishCapture =>
      'Steine werden geschlagen, indem man gerade oder seitwärts über sie springt.';

  @override
  String get ruleTitlePromotion => 'Umwandlungsregel';

  @override
  String get ruleDescPromotionStops =>
      'Ein Stein, der während eines Schlagzugs zur Dame wird, beendet seinen Zug.';

  @override
  String get ruleDescPromotionContinues =>
      'Ein Stein, der während eines Schlagzugs zur Dame wird, kann im selben Zug als Dame weiterschlagen.';

  @override
  String get ruleTitleAntiCheckersAim => 'Ziel';

  @override
  String get ruleDescAntiCheckersAim =>
      'Das Ziel des Spiels ist es, alle eigenen Steine zu verlieren oder zugunfähig zu werden.';

  @override
  String get tutorialStepWelcomeTitle => 'Willkommen';

  @override
  String get tutorialStepWelcomeDescTurkish =>
      'Willkommen bei der Türkischen Dame! Die Steine werden auf der zweiten und dritten Reihe für beide Seiten aufgestellt. Das Ziel ist es, alle Steine des Gegners zu schlagen.';

  @override
  String get tutorialStepManMoveDescTurkish =>
      'Einfache Steine bewegen sich ein Feld vorwärts oder seitwärts. Sie können sich nicht rückwärts bewegen.';

  @override
  String get tutorialStepCaptureTitle => 'Stein schlagen';

  @override
  String get tutorialStepCaptureDescTurkish =>
      'Steine werden geschlagen, indem man über einen gegnerischen Stein auf das leere Feld dahinter springt.';

  @override
  String get tutorialStepMaxCaptureTitle => 'Regel des Maximums';

  @override
  String get tutorialStepMaxCaptureDesc =>
      'Wenn es mehrere Schlagmöglichkeiten gibt, müssen Sie den Weg wählen, der die meisten Steine schlägt.';

  @override
  String get tutorialStepPromotionTitle => 'Umwandlung zur Dame';

  @override
  String get tutorialStepPromotionDesc =>
      'Wenn ein einfacher Stein die letzte Reihe des Gegners erreicht, wird er zur Dame befördert.';

  @override
  String get tutorialStepKingMoveDescTurkish =>
      'Eine Dame kann eine beliebige Anzahl von leeren Feldern vorwärts, rückwärts oder seitwärts bewegen (wie ein Turm im Schach) und schlägt, indem sie über einen Stein auf ein beliebiges leeres Feld dahinter in derselben Linie springt.';

  @override
  String get tutorialStepDrawTitle => 'Remis-Bedingungen';

  @override
  String get tutorialStepDrawDescTurkish =>
      'Ein Remis tritt ein, wenn dieselbe Stellung dreimal wiederholt wird oder wenn 25 Züge lang keine Schläge gemacht werden.';

  @override
  String get tutorialStepWelcomeDescEnglish =>
      'Willkommen bei der Englischen Dame! Das Ziel ist es, alle Steine des Gegners zu schlagen. Alle Züge und Schläge werden auf den dunklen Feldern gemacht.';

  @override
  String get tutorialStepManMoveDescEnglish =>
      'Einfache Steine bewegen sich nur einen Schritt diagonal vorwärts auf ein leeres Feld.';

  @override
  String get tutorialStepCaptureDescEnglish =>
      'Einfache Steine schlagen, indem sie über einen gegnerischen Stein diagonal vorwärts auf das leere Feld direkt dahinter springen.';

  @override
  String get tutorialStepManCannotCaptureBackwardTitle =>
      'Rückwärts schlagen nicht möglich';

  @override
  String get tutorialStepManCannotCaptureBackwardDesc =>
      'Einfache Steine können nicht rückwärts schlagen. Hier kann der weiße Stein den schwarzen Stein hinter sich nicht schlagen.';

  @override
  String get tutorialStepMultipleCaptureTitle => 'Mehrfachschläge';

  @override
  String get tutorialStepMultipleCaptureDesc =>
      'Wenn ein Sprung zu einem weiteren möglichen Sprung führt, müssen Sie im selben Zug weiterschlagen.';

  @override
  String get tutorialStepPromotionDescEnglish =>
      'Wenn ein einfacher Stein die entfernteste Reihe von seiner Ausgangsposition erreicht, wird er zur Dame befördert. Der Zug endet, wenn ein Stein befördert wird.';

  @override
  String get tutorialStepKingMoveDescEnglish =>
      'Eine Dame kann einen Schritt diagonal in jede Richtung, vorwärts oder rückwärts, ziehen und schlagen.';

  @override
  String get tutorialStepDrawDescEnglish =>
      'Ein Remis tritt ein, wenn dieselbe Stellung dreimal wiederholt wird oder nach Vereinbarung. Auch wenn eine Dame gegen eine Dame übrig bleibt, ist das Spiel ein Remis.';

  @override
  String get tutorialStepWelcomeDescInternational =>
      'Willkommen bei der Internationalen Dame, gespielt auf einem 10x10-Brett! Die Regeln ähneln anderen Varianten, aber mit einigen wichtigen Unterschieden.';

  @override
  String get tutorialStepManCaptureDescInternational =>
      'Einfache Steine bewegen sich diagonal vorwärts, können aber sowohl diagonal vorwärts als auch rückwärts schlagen.';

  @override
  String get tutorialStepKingMoveDescInternational =>
      'Eine Dame ist \'fliegend\'. Sie kann eine beliebige Anzahl von leeren Feldern diagonal in jede Richtung bewegen.';

  @override
  String get tutorialStepKingCaptureTitle => 'Schlagen mit der Dame';

  @override
  String get tutorialStepKingCaptureDesc =>
      'Eine fliegende Dame kann einen Stein aus der Ferne schlagen, indem sie auf ein beliebiges leeres Feld dahinter springt, solange der Weg frei ist.';

  @override
  String get tutorialStepKingMultipleCaptureTitle => 'Mehrfachschlag der Dame';

  @override
  String get tutorialStepKingMultipleCaptureDesc =>
      'Eine Dame kann eine Reihe von Schlägen ausführen, wobei sie oft nach jedem Sprung die Richtung ändert.';

  @override
  String get tutorialStepDrawDescInternational =>
      'Ein Remis tritt ein, wenn dieselbe Stellung dreimal wiederholt wird oder wenn 50 Züge lang keine Schläge oder Züge mit einfachen Steinen gemacht werden. Bestimmte Endspiele, wie zwei Damen gegen eine, sind ebenfalls Remis.';

  @override
  String get tutorialStepLosingAimTitle => 'Ziel des Spiels';

  @override
  String get tutorialStepLosingAimDesc =>
      'Willkommen bei Dame-Verschenken! Das Ziel ist das Gegenteil der normalen Dame: Sie gewinnen, indem Sie alle Ihre Steine verlieren oder zugunfähig werden.';

  @override
  String get tutorialStepMandatoryCaptureDescLosing =>
      'Genau wie bei der normalen Dame ist das Schlagen obligatorisch. Sie müssen Ihre Steine hergeben, wenn Sie die Chance dazu haben!';

  @override
  String get tutorialStepTrapTitle => 'Eine Falle stellen';

  @override
  String get tutorialStepTrapDesc =>
      'Eine übliche Strategie ist es, den Gegner in eine Position zu zwingen, in der er eine lange Schlagfolge ausführen muss, bei der er viele Ihrer Steine nimmt.';

  @override
  String get tutorialStepFallingIntoTrapTitle => 'In die Falle tappen';

  @override
  String get tutorialStepFallingIntoTrapDesc =>
      'Der schwarze Spieler ist nun gezwungen, den weißen Stein zu schlagen, was genau das war, was Weiß wollte.';

  @override
  String get tutorialStepLosingEndgameTitle => 'Endspiel';

  @override
  String get tutorialStepLosingEndgameDesc =>
      'Das Spiel endet, wenn ein Spieler keine Steine mehr auf dem Brett hat oder nicht ziehen kann. Dieser Spieler ist der Gewinner! Hier hat Schwarz gewonnen, weil ihm keine Steine mehr geblieben sind.';

  @override
  String get tutorialStepDrawDescLosing =>
      'Remis sind selten, können aber vorkommen, zum Beispiel durch dreifache Stellungswiederholung.';

  @override
  String get tutorialStepWelcomeDescRussian =>
      'Willkommen bei der Russischen Dame (Schaschki)! Sie hat eine einzigartige Umwandlungsregel.';

  @override
  String get tutorialStepManCaptureBackwardTitle =>
      'Rückwärtsschlag durch einfache Steine';

  @override
  String get tutorialStepManCaptureBackwardDesc =>
      'Wie bei der Internationalen Dame bewegen sich einfache Steine vorwärts, können aber sowohl vorwärts als auch rückwärts schlagen.';

  @override
  String get tutorialStepPromotionDescRussian =>
      'Wenn ein einfacher Stein die letzte Reihe des Gegners ohne einen Schlagzug erreicht, wird er zur Dame befördert und der Zug endet.';

  @override
  String get tutorialStepPromotionRuleTitle => 'Besondere Umwandlungsregel';

  @override
  String get tutorialStepPromotionRuleDescRussian =>
      'DIE SCHLÜSSELREGEL: Wenn ein einfacher Stein die Umwandlungsreihe durch einen Schlag erreicht, wird er sofort zur Dame und MUSS im selben Zug weiterschlagen, wenn möglich.';

  @override
  String get tutorialStepDrawDescRussian =>
      'Ein Remis kann durch dreifache Stellungswiederholung oder wenn 15 Züge lang keine Schläge gemacht werden, wenn nur noch Damen auf dem Brett sind, eintreten.';

  @override
  String get tutorialStepWelcomeDescSpanish =>
      'Willkommen bei der Spanischen Dame! Diese Variante kombiniert Regeln der Englischen und Internationalen Dame.';

  @override
  String get tutorialStepManMoveDescSpanish =>
      'Einfache Steine bewegen und schlagen nur diagonal vorwärts, genau wie bei der Englischen Dame.';

  @override
  String get tutorialStepMandatoryCaptureTitle => 'Schlagzwang';

  @override
  String get tutorialStepMandatoryCaptureDescSpanish =>
      'Das Schlagen ist obligatorisch. Wenn es mehrere Schlagmöglichkeiten gibt, müssen Sie eine wählen; es gibt keine \'Maximum-Regel\' für einfache Steine.';

  @override
  String get tutorialStepPromotionDescSpanish =>
      'Wenn ein einfacher Stein die entfernteste Reihe erreicht, wird er zur Dame befördert. Der Zug endet mit der Umwandlung.';

  @override
  String get tutorialStepKingMoveDescSpanish =>
      'Damen sind \'fliegend\', was bedeutet, dass sie über mehrere Felder ziehen und schlagen können, genau wie bei der Internationalen Dame.';

  @override
  String get tutorialStepDrawDescSpanish =>
      'Ein Remis kann durch dreifache Stellungswiederholung oder wenn 50 Züge lang keine signifikanten Züge (Schläge oder Züge mit einfachen Steinen) gemacht werden, eintreten.';

  @override
  String get tutorialStepManMoveTitle => 'Zug eines einfachen Steins';

  @override
  String get tutorialStepKingMoveTitle => 'Zug einer Dame';

  @override
  String get tutorialStepManCaptureTitle =>
      'Schlagen mit einem einfachen Stein';

  @override
  String get categoryClassicNatural => 'Klassisch & Natürlich';

  @override
  String get categoryCulturalHistorical => 'Kulturell & Historisch';

  @override
  String get categoryFantasySciFi => 'Fantasy & Sci-Fi';

  @override
  String get categoryLuxuryArtistic => 'Luxus & Künstlerisch';

  @override
  String get categoryModernMinimalist => 'Modern & Minimalistisch';

  @override
  String get categoryFunColorful => 'Spaß & Bunt';

  @override
  String get themeBoardClassicWood => 'Klassisches Holz';

  @override
  String get themeBoardMarble => 'Marmor';

  @override
  String get themeBoardGreenVelvet => 'Grüner Samt';

  @override
  String get themeBoardOceanBlue => 'Ozeanblau';

  @override
  String get themeBoardAutumn => 'Herbst';

  @override
  String get themeBoardGranite => 'Granit';

  @override
  String get themeBoardWinterForest => 'Winterwald';

  @override
  String get themeBoardRiverStone => 'Flussstein';

  @override
  String get themeBoardOttomanTile => 'Osmanische Fliese';

  @override
  String get themeBoardEgyptianPapyrus => 'Ägyptischer Papyrus';

  @override
  String get themeBoardRomanMosaic => 'Römisches Mosaik';

  @override
  String get themeBoardJapaneseSakura => 'Japanische Sakura';

  @override
  String get themeBoardScandinavianRune => 'Skandinavische Rune';

  @override
  String get themeBoardAztecSunStone => 'Aztekischer Sonnenstein';

  @override
  String get themeBoardCelticKnot => 'Keltischer Knoten';

  @override
  String get themeBoardVictorian => 'Viktorianisch';

  @override
  String get themeBoardGalaxy => 'Galaxie';

  @override
  String get themeBoardEnchantedForest => 'Verzauberter Wald';

  @override
  String get themeBoardHellfire => 'Höllenfeuer';

  @override
  String get themeBoardGlacierKingdom => 'Gletscherkönigreich';

  @override
  String get themeBoardCyberCircuit => 'Cyber-Schaltkreis';

  @override
  String get themeBoardSteampunk => 'Steampunk';

  @override
  String get themeBoardAtlantis => 'Atlantis';

  @override
  String get themeBoardCanadaSpace => 'Kanada im Weltraum';

  @override
  String get themeBoardBlackGold => 'Schwarz & Gold';

  @override
  String get themeBoardRubyEmerald => 'Rubin & Smaragd';

  @override
  String get themeBoardArtDeco => 'Art déco';

  @override
  String get themeBoardRoyalVelvet => 'Königlicher Samt';

  @override
  String get themeBoardPorcelain => 'Porzellan';

  @override
  String get themeBoardStainedGlass => 'Buntglas';

  @override
  String get themeBoardPearl => 'Perle';

  @override
  String get themeBoardBrushStrokes => 'Pinselstriche';

  @override
  String get themeBoardMatteBlack => 'Mattschwarz';

  @override
  String get themeBoardConcreteSteel => 'Beton & Stahl';

  @override
  String get themeBoardCarbonFiber => 'Kohlefaser';

  @override
  String get themeBoardGlass => 'Glas';

  @override
  String get themeBoardPaper => 'Papier';

  @override
  String get themeBoardDigitalPixel => 'Digitales Pixel';

  @override
  String get themeBoardPastelGeometry => 'Pastellgeometrie';

  @override
  String get themeBoardMonochromeGradient => 'Monochromer Verlauf';

  @override
  String get themeBoardCandyLand => 'Süßigkeitenland';

  @override
  String get themeBoardComicBook => 'Comic';

  @override
  String get themeBoard8BitRetro => '8-Bit-Retro';

  @override
  String get themeBoardToyBlocks => 'Spielzeugklötze';

  @override
  String get themeBoardRainbow => 'Regenbogen';

  @override
  String get themeBoardGraffiti => 'Graffiti';

  @override
  String get themeBoardWatercolor => 'Aquarell';

  @override
  String get themeBoardHoneycomb => 'Honigwabe';

  @override
  String get themePieceCarvedWood => 'Geschnitztes Holz';

  @override
  String get themePieceIvoryEbony => 'Elfenbein & Ebenholz';

  @override
  String get themePiecePolishedPebble => 'Polierter Kiesel';

  @override
  String get themePieceEarthenware => 'Steingut';

  @override
  String get themePieceFrostedGlass => 'Milchglas';

  @override
  String get themePieceRedJasper => 'Roter Jaspis';

  @override
  String get themePieceBamboo => 'Bambus';

  @override
  String get themePieceAmber => 'Bernstein';

  @override
  String get themePieceIznikTile => 'İznik-Fliese';

  @override
  String get themePieceLapisLazuli => 'Lapislazuli';

  @override
  String get themePieceJade => 'Jade';

  @override
  String get themePieceAncientBronze => 'Antike Bronze';

  @override
  String get themePieceObsidian => 'Obsidian';

  @override
  String get themePieceParchment => 'Pergament';

  @override
  String get themePieceTerracotta => 'Terrakotta';

  @override
  String get themePieceIronRune => 'Eisenrune';

  @override
  String get themePieceDragonScale => 'Drachenschuppe';

  @override
  String get themePieceCrystal => 'Kristall';

  @override
  String get themePieceNeonLights => 'Neonlichter';

  @override
  String get themePieceGhost => 'Geist';

  @override
  String get themePieceVolcanicMagma => 'Vulkanisches Magma';

  @override
  String get themePieceElvenMithril => 'Elfen-Mithril';

  @override
  String get themePieceOrcishIron => 'Ork-Eisen';

  @override
  String get themePieceCosmicDust => 'Kosmischer Staub';

  @override
  String get themePieceGoldSilver => 'Gold & Silber';

  @override
  String get themePieceBlackPearl => 'Schwarze Perle';

  @override
  String get themePieceMalachite => 'Malachit';

  @override
  String get themePieceVenetianGlass => 'Venezianisches Glas';

  @override
  String get themePieceGatsby => 'Gatsby';

  @override
  String get themePieceDiamond => 'Diamant';

  @override
  String get themePieceRuby => 'Rubin';

  @override
  String get themePieceSapphire => 'Saphir';

  @override
  String get themePieceModernMinimalist => 'Moderner Minimalist';

  @override
  String get themePieceRobotic => 'Robotisch';

  @override
  String get themePieceMetallicGradient => 'Metallischer Verlauf';

  @override
  String get themePieceGlossyPlastic => 'Glänzender Kunststoff';

  @override
  String get themePieceHolographic => 'Holografisch';

  @override
  String get themePieceMattePastel => 'Mattes Pastell';

  @override
  String get themePieceRubber => 'Gummi';

  @override
  String get themePieceLightShadow => 'Licht & Schatten';

  @override
  String get themePieceConfectionery => 'Süßwaren';

  @override
  String get themePieceChocolate => 'Schokolade';

  @override
  String get themePieceFruitBasket => 'Obstkorb';

  @override
  String get themePieceGummy => 'Gummibärchen';

  @override
  String get themePieceWatermelon => 'Wassermelone';

  @override
  String get themePieceCosmonaut => 'Kosmonaut';

  @override
  String get themePieceSuperhero => 'Superheld';

  @override
  String get themePieceSeashell => 'Muschel';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageRussian => 'Russisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languagePortuguese => 'Portugiesisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageItalian => 'Italienisch';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get version => 'Version';

  @override
  String get aboutHeader => 'ÜBER';

  @override
  String get noInternetConnection => 'Keine Internetverbindung';

  @override
  String get noInternetConnectionMessage =>
      'Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.';

  @override
  String get savedGameDialogTitle =>
      'Sie haben ein gespeichertes Spiel. Was möchten Sie tun?';

  @override
  String get deleteAction => 'Löschen';
}
