// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Mundo das Damas';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get languageHeader => 'IDIOMA';

  @override
  String get language => 'Idioma';

  @override
  String get languageSelectionTitle => 'Selecionar Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get appearanceHeader => 'APARÊNCIA';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeDark => 'Escuro';

  @override
  String get gameExperienceHeader => 'EXPERIÊNCIA DE JOGO';

  @override
  String get soundEffects => 'Efeitos Sonoros';

  @override
  String get haptics => 'Feedback Tátil';

  @override
  String get showCoordinates => 'Mostrar Coordenadas';

  @override
  String get gamePreferencesHeader => 'PREFERÊNCIAS DE JOGO';

  @override
  String get gamePreferencesDescription =>
      'Escolha com que cor você quer começar ao jogar contra o computador.';

  @override
  String get colorWhite => 'Branco';

  @override
  String get colorRandom => 'Aleatório';

  @override
  String get colorBlack => 'Preto';

  @override
  String get progressHeader => 'PROGRESSO';

  @override
  String get resetAllRanks => 'Redefinir Todas as Classificações';

  @override
  String get resetProgressConfirmationTitle => 'Redefinir Progresso?';

  @override
  String get resetProgressConfirmationBody =>
      'Seu progresso de classificação em todos os modos de jogo será excluído permanentemente. Esta ação não pode ser desfeita.';

  @override
  String get dialogCancel => 'Cancelar';

  @override
  String get dialogReset => 'Redefinir';

  @override
  String get progressResetSuccess => 'Progresso Redefinido';

  @override
  String get dialogOK => 'OK';

  @override
  String get mainMenuPlayButtonAI => 'Selecionar Nível';

  @override
  String get mainMenuPlayButtonHuman => 'Novo Jogo';

  @override
  String get mainMenuContinue => 'Continuar';

  @override
  String get mainMenuOpponentAI => 'Inteligência Artificial';

  @override
  String get mainMenuOpponentHuman => 'Dois Jogadores';

  @override
  String get mainMenuRules => 'Regras';

  @override
  String get mainMenuExploreThemes => 'Explorar Temas';

  @override
  String get close => 'Fechar';

  @override
  String levelNumber(int level) {
    return 'Nível $level';
  }

  @override
  String get themeStoreTitle => 'Loja de Temas';

  @override
  String get searchBoardPlaceholder => 'Buscar Tabuleiros';

  @override
  String get searchPiecePlaceholder => 'Buscar Peças';

  @override
  String get boards => 'Tabuleiros';

  @override
  String get pieces => 'Peças';

  @override
  String get noResults => 'Nenhum resultado encontrado';

  @override
  String get loadingStatusInitializing => 'Inicializando...';

  @override
  String get loadingStatusSettings => 'Carregando configurações...';

  @override
  String get loadingStatusUI => 'Otimizando interface...';

  @override
  String get loadingStatusReady => 'Pronto!';

  @override
  String get gameScreenConfirmExitTitle => 'Voltar ao Menu Principal';

  @override
  String get gameScreenConfirmExitBody => 'Deseja salvar o jogo atual?';

  @override
  String get gameScreenSaveAndExit => 'Salvar e Sair';

  @override
  String get gameScreenExitWithoutSaving => 'Sair Sem Salvar';

  @override
  String get gameScreenPaused => 'Pausado';

  @override
  String get gameScreenResume => 'Retomar';

  @override
  String get gameScreenRestart => 'Reiniciar';

  @override
  String get gameScreenReturnToMenu => 'Voltar ao Menu';

  @override
  String get gameOverWinTitle => 'Parabéns, Você Venceu!';

  @override
  String get gameOverWinBody => 'Uma grande vitória!';

  @override
  String get gameOverNewRankBody => 'Você alcançou uma nova classificação!';

  @override
  String get gameOverNewRankTitle => 'SUBIU DE RANK!';

  @override
  String get gameOverLoseTitle => 'Você Perdeu';

  @override
  String get gameOverLoseBody => 'Você deveria praticar mais.';

  @override
  String get gameOverDrawTitle => 'Empate!';

  @override
  String get gameOverTitle => 'Fim de Jogo!';

  @override
  String gameOverWinner(String winner) {
    return 'Vencedor: $winner';
  }

  @override
  String get gameOverNewGame => 'Novo Jogo';

  @override
  String get playerYou => 'Você';

  @override
  String get playerComputer => 'Computador';

  @override
  String get playerWhite => 'Branco';

  @override
  String get playerBlack => 'Preto';

  @override
  String get aiThinking => 'Pensando...';

  @override
  String get nextMove => 'Próxima Jogada';

  @override
  String get waiting => 'Aguardando...';

  @override
  String tutorialTitle(String gameMode) {
    return 'Tutorial de $gameMode';
  }

  @override
  String get tutorialNext => 'Próximo';

  @override
  String get tutorialPrevious => 'Anterior';

  @override
  String get tutorialPlay => 'Jogar';

  @override
  String get rankNovice => 'Novato';

  @override
  String get rankApprentice => 'Aprendiz';

  @override
  String get rankJourneyman => 'Experiente';

  @override
  String get rankMaster => 'Mestre';

  @override
  String get rankExpert => 'Especialista';

  @override
  String get rankVirtuoso => 'Virtuoso';

  @override
  String get rankGrandmaster => 'Grão-Mestre';

  @override
  String get drawReasonThreefoldRepetition =>
      'A mesma posição foi repetida três vezes.';

  @override
  String get drawReasonFiftyMoveRule =>
      'Nenhuma peça foi capturada ou promovida por 50 lances.';

  @override
  String get drawReasonFortyMoveRule =>
      'Nenhuma peça foi capturada ou promovida por 40 lances.';

  @override
  String get drawReasonTwentyFiveMoveRule =>
      'Nenhuma peça foi capturada ou promovida por 25 lances.';

  @override
  String get drawReasonFifteenMoveRule =>
      'Nenhuma peça foi capturada ou promovida por 15 lances.';

  @override
  String get drawReasonInsufficientMaterial =>
      'As peças restantes são insuficientes para vencer o jogo.';

  @override
  String get drawReasonStalemate =>
      'Nenhum jogador tem mais movimentos legais.';

  @override
  String get gameModeTurkishName => 'Damas Turcas';

  @override
  String get gameModeTurkishDescription =>
      'Jogado em um tabuleiro 8x8. As peças se movem para frente e para os lados.';

  @override
  String get gameModeEnglishName => 'Damas Inglesas';

  @override
  String get gameModeEnglishDescription =>
      'Jogado em um tabuleiro 8x8. Peças comuns não podem capturar para trás e as damas não são voadoras.';

  @override
  String get gameModeInternationalName => 'Damas Internacionais';

  @override
  String get gameModeInternationalDescription =>
      'Jogado em um tabuleiro 10x10. A captura máxima é obrigatória e as damas são voadoras.';

  @override
  String get gameModeRussianName => 'Damas Russas';

  @override
  String get gameModeRussianDescription =>
      'Uma peça promovida ao capturar pode continuar capturando no mesmo lance.';

  @override
  String get gameModeSpanishName => 'Damas Espanholas';

  @override
  String get gameModeSpanishDescription =>
      'Peças comuns só podem se mover/capturar para frente. A captura máxima é obrigatória e as damas são voadoras.';

  @override
  String get gameModeAntiCheckersName => 'Anti-Damas (Jogo de Perda)';

  @override
  String get gameModeAntiCheckersDescription =>
      'O primeiro jogador a perder todas as suas peças ou não ter mais lances vence.';

  @override
  String get ruleTitleManMove => 'Movimento da Peça Comum';

  @override
  String get ruleDescManMoveForward =>
      'Peças comuns movem-se apenas um passo na diagonal para a frente.';

  @override
  String get ruleTitleManCapture => 'Captura da Peça Comum';

  @override
  String get ruleDescManCaptureForward =>
      'Peças comuns capturam apenas pulando na diagonal para a frente.';

  @override
  String get ruleDescManCaptureBackward =>
      'Peças comuns podem capturar pulando na diagonal tanto para a frente quanto para trás.';

  @override
  String get ruleTitleKingMove => 'Movimento da Dama';

  @override
  String get ruleDescKingShort =>
      'Damas movem-se e capturam um passo na diagonal em qualquer direção.';

  @override
  String get ruleDescKingFlying =>
      'Damas (ou Damas Voadoras) podem mover-se qualquer número de casas vazias na diagonal.';

  @override
  String get ruleTitleMandatoryCapture => 'Captura Obrigatória';

  @override
  String get ruleDescMandatoryCapture =>
      'Se uma captura estiver disponível, ela deve ser feita.';

  @override
  String get ruleTitleMaxCapture => 'Captura Máxima';

  @override
  String get ruleDescMaxCapture =>
      'Se várias sequências de captura estiverem disponíveis, a que captura mais peças deve ser escolhida.';

  @override
  String get ruleTitleTurkishManMove => 'Movimento da Peça Comum';

  @override
  String get ruleDescTurkishManMove =>
      'Peças comuns movem-se uma casa para frente ou para os lados, mas não para trás.';

  @override
  String get ruleTitleTurkishCapture => 'Captura';

  @override
  String get ruleDescTurkishCapture =>
      'As peças são capturadas pulando sobre elas.';

  @override
  String get ruleTitlePromotion => 'Regra de Promoção';

  @override
  String get ruleDescPromotionStops =>
      'Uma peça comum que é promovida a dama durante uma sequência de captura encerra seu turno.';

  @override
  String get ruleDescPromotionContinues =>
      'Uma peça comum que é promovida a dama durante uma sequência de captura pode continuar capturando como dama no mesmo turno.';

  @override
  String get ruleTitleAntiCheckersAim => 'Objetivo';

  @override
  String get ruleDescAntiCheckersAim =>
      'O objetivo é perder todas as suas peças ou ficar impossibilitado de se mover.';

  @override
  String get tutorialStepWelcomeTitle => 'Bem-vindo';

  @override
  String get tutorialStepWelcomeDescTurkish =>
      'Bem-vindo às Damas Turcas! As peças são dispostas na segunda e terceira fileiras para ambos os lados. O objetivo é capturar todas as peças do seu oponente.';

  @override
  String get tutorialStepManMoveDescTurkish =>
      'As peças comuns movem-se uma casa para a frente ou para os lados. Elas não podem se mover para trás.';

  @override
  String get tutorialStepCaptureTitle => 'Captura de Peça';

  @override
  String get tutorialStepCaptureDescTurkish =>
      'As peças são capturadas pulando sobre uma peça do oponente para a casa vazia atrás dela.';

  @override
  String get tutorialStepMaxCaptureTitle => 'Captura Máxima';

  @override
  String get tutorialStepMaxCaptureDesc =>
      'Se houver várias opções de captura, você deve escolher o caminho que captura o maior número de peças.';

  @override
  String get tutorialStepPromotionTitle => 'Promoção';

  @override
  String get tutorialStepPromotionDesc =>
      'Quando uma peça comum alcança a fileira de trás do oponente, ela é promovida a Dama.';

  @override
  String get tutorialStepKingMoveDescTurkish =>
      'Uma Dama pode mover-se qualquer número de casas vazias para a frente, para trás ou para os lados (como uma torre no xadrez) e captura pulando sobre uma peça para qualquer casa vazia atrás dela na mesma linha.';

  @override
  String get tutorialStepDrawTitle => 'Condições de Empate';

  @override
  String get tutorialStepDrawDescTurkish =>
      'Ocorre um empate se a mesma posição for repetida três vezes, ou se nenhuma captura for feita por 25 lances.';

  @override
  String get tutorialStepWelcomeDescEnglish =>
      'Bem-vindo às Damas Inglesas! O objetivo é capturar todas as peças do seu oponente. Todos os movimentos e capturas são feitos nas casas escuras.';

  @override
  String get tutorialStepManMoveDescEnglish =>
      'As peças comuns movem-se apenas um passo na diagonal para a frente para uma casa vazia.';

  @override
  String get tutorialStepCaptureDescEnglish =>
      'As peças comuns capturam pulando sobre uma peça do oponente na diagonal para a frente para a casa vazia logo além dela.';

  @override
  String get tutorialStepManCannotCaptureBackwardTitle =>
      'Não Pode Capturar para Trás';

  @override
  String get tutorialStepManCannotCaptureBackwardDesc =>
      'As peças comuns não podem capturar para trás. Aqui, a peça branca não pode capturar a peça preta atrás dela.';

  @override
  String get tutorialStepMultipleCaptureTitle => 'Capturas Múltiplas';

  @override
  String get tutorialStepMultipleCaptureDesc =>
      'Se um pulo levar a outro pulo possível, você deve continuar capturando no mesmo turno.';

  @override
  String get tutorialStepPromotionDescEnglish =>
      'Quando uma peça comum alcança a fileira mais distante de sua posição inicial, ela é promovida a Dama. O lance termina quando uma peça é promovida.';

  @override
  String get tutorialStepKingMoveDescEnglish =>
      'Uma Dama pode mover-se e capturar um passo na diagonal em qualquer direção, para a frente ou para trás.';

  @override
  String get tutorialStepDrawDescEnglish =>
      'Ocorre um empate se a mesma posição for repetida três vezes, ou por acordo. Além disso, se houver uma dama contra uma dama, o jogo é um empate.';

  @override
  String get tutorialStepWelcomeDescInternational =>
      'Bem-vindo às Damas Internacionais, jogadas em um tabuleiro 10x10! As regras são semelhantes a outras variantes, mas com algumas diferenças importantes.';

  @override
  String get tutorialStepManCaptureDescInternational =>
      'As peças comuns movem-se na diagonal para a frente, mas podem capturar tanto na diagonal para a frente quanto para trás.';

  @override
  String get tutorialStepKingMoveDescInternational =>
      'Uma Dama é \'voadora\'. Ela pode mover-se qualquer número de casas vazias na diagonal em qualquer direção.';

  @override
  String get tutorialStepKingCaptureTitle => 'Captura com a Dama';

  @override
  String get tutorialStepKingCaptureDesc =>
      'Uma Dama voadora pode capturar uma peça à distância pulando para qualquer casa vazia atrás dela, desde que o caminho esteja livre.';

  @override
  String get tutorialStepKingMultipleCaptureTitle => 'Captura Múltipla da Dama';

  @override
  String get tutorialStepKingMultipleCaptureDesc =>
      'Uma Dama pode realizar uma sequência de capturas, muitas vezes mudando de direção após cada pulo.';

  @override
  String get tutorialStepDrawDescInternational =>
      'Ocorre um empate se a mesma posição for repetida três vezes, ou se nenhuma captura ou movimento de peça comum for feito por 50 lances. Certos finais de jogo, como duas damas contra uma, também são empates.';

  @override
  String get tutorialStepLosingAimTitle => 'Objetivo do Jogo';

  @override
  String get tutorialStepLosingAimDesc =>
      'Bem-vindo ao Anti-Damas! O objetivo é o oposto das damas normais: você vence perdendo todas as suas peças ou ficando impossibilitado de fazer um lance legal.';

  @override
  String get tutorialStepMandatoryCaptureDescLosing =>
      'Assim como nas damas normais, as capturas são obrigatórias. Você deve entregar suas peças se tiver a chance!';

  @override
  String get tutorialStepTrapTitle => 'Armando uma Armadilha';

  @override
  String get tutorialStepTrapDesc =>
      'Uma estratégia comum é forçar seu oponente a uma posição onde ele deve fazer uma longa sequência de capturas, tomando muitas de suas peças.';

  @override
  String get tutorialStepFallingIntoTrapTitle => 'Caindo na Armadilha';

  @override
  String get tutorialStepFallingIntoTrapDesc =>
      'O jogador preto agora é forçado a capturar a peça branca, que é exatamente o que o Branco queria.';

  @override
  String get tutorialStepLosingEndgameTitle => 'Final de Jogo';

  @override
  String get tutorialStepLosingEndgameDesc =>
      'O jogo termina quando um jogador não tem mais peças no tabuleiro, ou não pode fazer um lance. Esse jogador é o vencedor! Aqui, o Preto venceu porque não tem mais peças.';

  @override
  String get tutorialStepDrawDescLosing =>
      'Empates são raros, mas podem ocorrer, por exemplo, por repetição tripla de uma posição.';

  @override
  String get tutorialStepWelcomeDescRussian =>
      'Bem-vindo às Damas Russas (Shashki)! Possui uma regra de promoção única.';

  @override
  String get tutorialStepManCaptureBackwardTitle =>
      'Captura para Trás por Peças Comuns';

  @override
  String get tutorialStepManCaptureBackwardDesc =>
      'Como nas Damas Internacionais, as peças comuns movem-se para a frente, mas podem capturar tanto para a frente quanto para trás.';

  @override
  String get tutorialStepPromotionDescRussian =>
      'Quando uma peça comum alcança a fileira de trás do oponente com um movimento sem captura, ela é promovida a Dama e o turno termina.';

  @override
  String get tutorialStepPromotionRuleTitle => 'Regra Especial de Promoção';

  @override
  String get tutorialStepPromotionRuleDescRussian =>
      'A REGRA CHAVE: Se uma peça comum alcançar a fileira de promoção através de uma captura, ela se torna imediatamente uma Dama e DEVE continuar capturando no mesmo turno, se possível.';

  @override
  String get tutorialStepDrawDescRussian =>
      'Um empate pode ocorrer por repetição tripla ou se nenhuma captura for feita por 15 lances quando apenas damas estiverem no tabuleiro.';

  @override
  String get tutorialStepWelcomeDescSpanish =>
      'Bem-vindo às Damas Espanholas! Esta variante combina regras das Damas Inglesas e Internacionais.';

  @override
  String get tutorialStepManMoveDescSpanish =>
      'As peças comuns movem-se e capturam apenas na diagonal para a frente, assim como nas Damas Inglesas.';

  @override
  String get tutorialStepMandatoryCaptureTitle => 'Captura Obrigatória';

  @override
  String get tutorialStepMandatoryCaptureDescSpanish =>
      'As capturas são obrigatórias. Se houver várias opções de captura, você deve escolher uma; não há regra de \'captura máxima\' para peças comuns.';

  @override
  String get tutorialStepPromotionDescSpanish =>
      'Quando uma peça comum alcança a fileira mais distante, ela é promovida a Dama. O turno termina com a promoção.';

  @override
  String get tutorialStepKingMoveDescSpanish =>
      'As damas são \'voadoras\', o que significa que podem mover-se e capturar sobre várias casas, assim como nas Damas Internacionais.';

  @override
  String get tutorialStepDrawDescSpanish =>
      'Um empate pode ocorrer por repetição tripla ou se nenhum movimento significativo (capturas ou movimentos de peças comuns) for feito por 50 lances.';

  @override
  String get tutorialStepManMoveTitle => 'Movimento da Peça Comum';

  @override
  String get tutorialStepKingMoveTitle => 'Movimento da Dama';

  @override
  String get tutorialStepManCaptureTitle => 'Captura com Peça Comum';

  @override
  String get categoryClassicNatural => 'Clássico & Natural';

  @override
  String get categoryCulturalHistorical => 'Cultural & Histórico';

  @override
  String get categoryFantasySciFi => 'Fantasia & Ficção Científica';

  @override
  String get categoryLuxuryArtistic => 'Luxo & Artístico';

  @override
  String get categoryModernMinimalist => 'Moderno & Minimalista';

  @override
  String get categoryFunColorful => 'Divertido & Colorido';

  @override
  String get themeBoardClassicWood => 'Madeira Clássica';

  @override
  String get themeBoardMarble => 'Mármore';

  @override
  String get themeBoardGreenVelvet => 'Veludo Verde';

  @override
  String get themeBoardOceanBlue => 'Azul Oceano';

  @override
  String get themeBoardAutumn => 'Outono';

  @override
  String get themeBoardGranite => 'Granito';

  @override
  String get themeBoardWinterForest => 'Floresta de Inverno';

  @override
  String get themeBoardRiverStone => 'Pedra de Rio';

  @override
  String get themeBoardOttomanTile => 'Azulejo Otomano';

  @override
  String get themeBoardEgyptianPapyrus => 'Papiro Egípcio';

  @override
  String get themeBoardRomanMosaic => 'Mosaico Romano';

  @override
  String get themeBoardJapaneseSakura => 'Sakura Japonês';

  @override
  String get themeBoardScandinavianRune => 'Runa Escandinava';

  @override
  String get themeBoardAztecSunStone => 'Pedra do Sol Asteca';

  @override
  String get themeBoardCelticKnot => 'Nó Celta';

  @override
  String get themeBoardVictorian => 'Vitoriano';

  @override
  String get themeBoardGalaxy => 'Galáxia';

  @override
  String get themeBoardEnchantedForest => 'Floresta Encantada';

  @override
  String get themeBoardHellfire => 'Fogo do Inferno';

  @override
  String get themeBoardGlacierKingdom => 'Reino Glacial';

  @override
  String get themeBoardCyberCircuit => 'Circuito Cibernético';

  @override
  String get themeBoardSteampunk => 'Steampunk';

  @override
  String get themeBoardAtlantis => 'Atlântida';

  @override
  String get themeBoardCanadaSpace => 'Espaço Canadá';

  @override
  String get themeBoardBlackGold => 'Preto & Dourado';

  @override
  String get themeBoardRubyEmerald => 'Rubi & Esmeralda';

  @override
  String get themeBoardArtDeco => 'Art Déco';

  @override
  String get themeBoardRoyalVelvet => 'Veludo Real';

  @override
  String get themeBoardPorcelain => 'Porcelana';

  @override
  String get themeBoardStainedGlass => 'Vitral';

  @override
  String get themeBoardPearl => 'Pérola';

  @override
  String get themeBoardBrushStrokes => 'Pinceladas';

  @override
  String get themeBoardMatteBlack => 'Preto Fosco';

  @override
  String get themeBoardConcreteSteel => 'Concreto & Aço';

  @override
  String get themeBoardCarbonFiber => 'Fibra de Carbono';

  @override
  String get themeBoardGlass => 'Vidro';

  @override
  String get themeBoardPaper => 'Papel';

  @override
  String get themeBoardDigitalPixel => 'Pixel Digital';

  @override
  String get themeBoardPastelGeometry => 'Geometria Pastel';

  @override
  String get themeBoardMonochromeGradient => 'Gradiente Monocromático';

  @override
  String get themeBoardCandyLand => 'Terra dos Doces';

  @override
  String get themeBoardComicBook => 'História em Quadrinhos';

  @override
  String get themeBoard8BitRetro => 'Retrô 8-Bits';

  @override
  String get themeBoardToyBlocks => 'Blocos de Brinquedo';

  @override
  String get themeBoardRainbow => 'Arco-Íris';

  @override
  String get themeBoardGraffiti => 'Grafite';

  @override
  String get themeBoardWatercolor => 'Aquarela';

  @override
  String get themeBoardHoneycomb => 'Favo de Mel';

  @override
  String get themePieceCarvedWood => 'Madeira Esculpida';

  @override
  String get themePieceIvoryEbony => 'Marfim & Ébano';

  @override
  String get themePiecePolishedPebble => 'Seixo Polido';

  @override
  String get themePieceEarthenware => 'Barro';

  @override
  String get themePieceFrostedGlass => 'Vidro Fosco';

  @override
  String get themePieceRedJasper => 'Jaspe Vermelho';

  @override
  String get themePieceBamboo => 'Bambu';

  @override
  String get themePieceAmber => 'Âmbar';

  @override
  String get themePieceIznikTile => 'Azulejo de İznik';

  @override
  String get themePieceLapisLazuli => 'Lápis-lazúli';

  @override
  String get themePieceJade => 'Jade';

  @override
  String get themePieceAncientBronze => 'Bronze Antigo';

  @override
  String get themePieceObsidian => 'Obsidiana';

  @override
  String get themePieceParchment => 'Pergaminho';

  @override
  String get themePieceTerracotta => 'Terracota';

  @override
  String get themePieceIronRune => 'Runa de Ferro';

  @override
  String get themePieceDragonScale => 'Escama de Dragão';

  @override
  String get themePieceCrystal => 'Cristal';

  @override
  String get themePieceNeonLights => 'Luzes de Neon';

  @override
  String get themePieceGhost => 'Fantasma';

  @override
  String get themePieceVolcanicMagma => 'Magma Vulcânico';

  @override
  String get themePieceElvenMithril => 'Mithril Élfico';

  @override
  String get themePieceOrcishIron => 'Ferro Órquico';

  @override
  String get themePieceCosmicDust => 'Poeira Cósmica';

  @override
  String get themePieceGoldSilver => 'Ouro & Prata';

  @override
  String get themePieceBlackPearl => 'Pérola Negra';

  @override
  String get themePieceMalachite => 'Malaquita';

  @override
  String get themePieceVenetianGlass => 'Vidro Veneziano';

  @override
  String get themePieceGatsby => 'Gatsby';

  @override
  String get themePieceDiamond => 'Diamante';

  @override
  String get themePieceRuby => 'Rubi';

  @override
  String get themePieceSapphire => 'Safira';

  @override
  String get themePieceModernMinimalist => 'Minimalista Moderno';

  @override
  String get themePieceRobotic => 'Robótico';

  @override
  String get themePieceMetallicGradient => 'Gradiente Metálico';

  @override
  String get themePieceGlossyPlastic => 'Plástico Brilhante';

  @override
  String get themePieceHolographic => 'Holográfico';

  @override
  String get themePieceMattePastel => 'Pastel Fosco';

  @override
  String get themePieceRubber => 'Borracha';

  @override
  String get themePieceLightShadow => 'Luz & Sombra';

  @override
  String get themePieceConfectionery => 'Confeitaria';

  @override
  String get themePieceChocolate => 'Chocolate';

  @override
  String get themePieceFruitBasket => 'Cesta de Frutas';

  @override
  String get themePieceGummy => 'Goma';

  @override
  String get themePieceWatermelon => 'Melancia';

  @override
  String get themePieceCosmonaut => 'Cosmonauta';

  @override
  String get themePieceSuperhero => 'Super-herói';

  @override
  String get themePieceSeashell => 'Concha do Mar';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languageRussian => 'Russo';

  @override
  String get languageGerman => 'Alemão';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get languageFrench => 'Francês';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get version => 'Versão';

  @override
  String get aboutHeader => 'SOBRE';

  @override
  String get noInternetConnection => 'Sem conexão com a Internet';

  @override
  String get noInternetConnectionMessage =>
      'Por favor, verifique sua conexão com a internet e tente novamente.';

  @override
  String get savedGameDialogTitle =>
      'Você tem um jogo salvo. O que você gostaria de fazer?';

  @override
  String get deleteAction => 'Excluir';
}
