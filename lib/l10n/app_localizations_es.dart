// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Mundo de Damas';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get languageHeader => 'IDIOMA';

  @override
  String get language => 'Idioma';

  @override
  String get languageSelectionTitle => 'Seleccionar Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get appearanceHeader => 'APARIENCIA';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get gameExperienceHeader => 'EXPERIENCIA DE JUEGO';

  @override
  String get soundEffects => 'Efectos de Sonido';

  @override
  String get haptics => 'Respuesta Háptica';

  @override
  String get showCoordinates => 'Mostrar Coordenadas';

  @override
  String get gamePreferencesHeader => 'PREFERENCIAS DE JUEGO';

  @override
  String get gamePreferencesDescription =>
      'Elige con qué color quieres empezar cuando juegues contra el ordenador.';

  @override
  String get colorWhite => 'Blancas';

  @override
  String get colorRandom => 'Aleatorio';

  @override
  String get colorBlack => 'Negras';

  @override
  String get progressHeader => 'PROGRESO';

  @override
  String get resetAllRanks => 'Restablecer Todos los Rangos';

  @override
  String get resetProgressConfirmationTitle => '¿Restablecer Progreso?';

  @override
  String get resetProgressConfirmationBody =>
      'Tu progreso de rango en todos los modos de juego se eliminará permanentemente. Esta acción no se puede deshacer.';

  @override
  String get dialogCancel => 'Cancelar';

  @override
  String get dialogReset => 'Restablecer';

  @override
  String get progressResetSuccess => 'Progreso Restablecido';

  @override
  String get dialogOK => 'Aceptar';

  @override
  String get mainMenuPlayButtonAI => 'Seleccionar Nivel';

  @override
  String get mainMenuPlayButtonHuman => 'Nuevo Juego';

  @override
  String get mainMenuContinue => 'Continuar';

  @override
  String get mainMenuOpponentAI => 'Inteligencia Artificial';

  @override
  String get mainMenuOpponentHuman => 'Dos Jugadores';

  @override
  String get mainMenuRules => 'Reglas';

  @override
  String get mainMenuExploreThemes => 'Explorar Temas';

  @override
  String get close => 'Cerrar';

  @override
  String levelNumber(int level) {
    return 'Nivel $level';
  }

  @override
  String get themeStoreTitle => 'Tienda de Temas';

  @override
  String get searchBoardPlaceholder => 'Buscar Tableros';

  @override
  String get searchPiecePlaceholder => 'Buscar Fichas';

  @override
  String get boards => 'Tableros';

  @override
  String get pieces => 'Fichas';

  @override
  String get noResults => 'No se encontraron resultados';

  @override
  String get loadingStatusInitializing => 'Iniciando...';

  @override
  String get loadingStatusSettings => 'Cargando ajustes...';

  @override
  String get loadingStatusUI => 'Optimizando interfaz...';

  @override
  String get loadingStatusReady => '¡Listo!';

  @override
  String get gameScreenConfirmExitTitle => 'Volver al Menú Principal';

  @override
  String get gameScreenConfirmExitBody => '¿Quieres guardar la partida actual?';

  @override
  String get gameScreenSaveAndExit => 'Guardar y Salir';

  @override
  String get gameScreenExitWithoutSaving => 'Salir sin Guardar';

  @override
  String get gameScreenPaused => 'Pausado';

  @override
  String get gameScreenResume => 'Reanudar';

  @override
  String get gameScreenRestart => 'Reiniciar';

  @override
  String get gameScreenReturnToMenu => 'Volver al Menú';

  @override
  String get gameOverWinTitle => '¡Felicidades, has ganado!';

  @override
  String get gameOverWinBody => '¡Una gran victoria!';

  @override
  String get gameOverNewRankBody => '¡Has conseguido un nuevo rango!';

  @override
  String get gameOverNewRankTitle => '¡RANGO AUMENTADO!';

  @override
  String get gameOverLoseTitle => 'Has perdido';

  @override
  String get gameOverLoseBody => 'Deberías practicar más.';

  @override
  String get gameOverDrawTitle => '¡Empate!';

  @override
  String get gameOverTitle => '¡Fin del Juego!';

  @override
  String gameOverWinner(String winner) {
    return 'Ganador: $winner';
  }

  @override
  String get gameOverNewGame => 'Nuevo Juego';

  @override
  String get playerYou => 'Tú';

  @override
  String get playerComputer => 'Ordenador';

  @override
  String get playerWhite => 'Blancas';

  @override
  String get playerBlack => 'Negras';

  @override
  String get aiThinking => 'Pensando...';

  @override
  String get nextMove => 'Siguiente Movimiento';

  @override
  String get waiting => 'Esperando...';

  @override
  String tutorialTitle(String gameMode) {
    return 'Tutorial de $gameMode';
  }

  @override
  String get tutorialNext => 'Siguiente';

  @override
  String get tutorialPrevious => 'Anterior';

  @override
  String get tutorialPlay => 'Reproducir';

  @override
  String get rankNovice => 'Novato';

  @override
  String get rankApprentice => 'Aprendiz';

  @override
  String get rankJourneyman => 'Oficial';

  @override
  String get rankMaster => 'Maestro';

  @override
  String get rankExpert => 'Experto';

  @override
  String get rankVirtuoso => 'Virtuoso';

  @override
  String get rankGrandmaster => 'Gran Maestro';

  @override
  String get drawReasonThreefoldRepetition =>
      'La misma posición se repitió tres veces.';

  @override
  String get drawReasonFiftyMoveRule =>
      'No se capturó ni promocionó ninguna ficha durante 50 movimientos.';

  @override
  String get drawReasonFortyMoveRule =>
      'No se capturó ni promocionó ninguna ficha durante 40 movimientos.';

  @override
  String get drawReasonTwentyFiveMoveRule =>
      'No se capturó ni promocionó ninguna ficha durante 25 movimientos.';

  @override
  String get drawReasonFifteenMoveRule =>
      'No se capturó ni promocionó ninguna ficha durante 15 movimientos.';

  @override
  String get drawReasonInsufficientMaterial =>
      'Las fichas restantes son insuficientes para ganar la partida.';

  @override
  String get drawReasonStalemate => 'Ningún jugador tiene movimientos legales.';

  @override
  String get gameModeTurkishName => 'Damas Turcas';

  @override
  String get gameModeTurkishDescription =>
      'Se juega en un tablero de 8x8. Las fichas se mueven hacia adelante y hacia los lados.';

  @override
  String get gameModeEnglishName => 'Damas Inglesas';

  @override
  String get gameModeEnglishDescription =>
      'Se juega en un tablero de 8x8. Los peones no pueden capturar hacia atrás y las damas no vuelan.';

  @override
  String get gameModeInternationalName => 'Damas Internacionales';

  @override
  String get gameModeInternationalDescription =>
      'Se juega en un tablero de 10x10. La captura máxima es obligatoria y las damas vuelan.';

  @override
  String get gameModeRussianName => 'Damas Rusas';

  @override
  String get gameModeRussianDescription =>
      'Una ficha que se convierte en dama capturando puede continuar capturando en el mismo movimiento.';

  @override
  String get gameModeSpanishName => 'Damas Españolas';

  @override
  String get gameModeSpanishDescription =>
      'Los peones solo pueden moverse/capturar hacia adelante. La captura máxima es obligatoria y las damas vuelan.';

  @override
  String get gameModeAntiCheckersName => 'Anti-Damas (Pierde-Gana)';

  @override
  String get gameModeAntiCheckersDescription =>
      'El primer jugador que pierde todas sus fichas o no tiene movimientos, gana.';

  @override
  String get ruleTitleManMove => 'Movimiento del Peón';

  @override
  String get ruleDescManMoveForward =>
      'Los peones solo se mueven un paso en diagonal hacia adelante.';

  @override
  String get ruleTitleManCapture => 'Captura del Peón';

  @override
  String get ruleDescManCaptureForward =>
      'Los peones solo capturan saltando en diagonal hacia adelante.';

  @override
  String get ruleDescManCaptureBackward =>
      'Los peones pueden capturar saltando en diagonal tanto hacia adelante como hacia atrás.';

  @override
  String get ruleTitleKingMove => 'Movimiento de la Dama';

  @override
  String get ruleDescKingShort =>
      'Las damas se mueven y capturan un paso en diagonal en cualquier dirección.';

  @override
  String get ruleDescKingFlying =>
      'Las damas (o Damas Voladoras) pueden moverse cualquier número de casillas vacías en diagonal.';

  @override
  String get ruleTitleMandatoryCapture => 'Captura Obligatoria';

  @override
  String get ruleDescMandatoryCapture =>
      'Si hay una captura disponible, debe realizarse.';

  @override
  String get ruleTitleMaxCapture => 'Captura Máxima';

  @override
  String get ruleDescMaxCapture =>
      'Si hay varias secuencias de captura disponibles, se debe elegir la que capture más fichas.';

  @override
  String get ruleTitleTurkishManMove => 'Movimiento del Peón';

  @override
  String get ruleDescTurkishManMove =>
      'Los peones se mueven una casilla hacia adelante o hacia los lados, pero no hacia atrás.';

  @override
  String get ruleTitleTurkishCapture => 'Regla de Captura';

  @override
  String get ruleDescTurkishCapture =>
      'Las fichas se capturan saltando sobre ellas en línea recta o lateralmente.';

  @override
  String get ruleTitlePromotion => 'Regla de Promoción';

  @override
  String get ruleDescPromotionStops =>
      'Un peón que se convierte en dama durante una captura detiene su turno.';

  @override
  String get ruleDescPromotionContinues =>
      'Un peón que se convierte en dama durante una captura puede seguir capturando como dama en el mismo turno.';

  @override
  String get ruleTitleAntiCheckersAim => 'Objetivo';

  @override
  String get ruleDescAntiCheckersAim =>
      'El objetivo es perder todas tus fichas o quedarte sin poder mover.';

  @override
  String get tutorialStepWelcomeTitle => 'Bienvenido';

  @override
  String get tutorialStepWelcomeDescTurkish =>
      '¡Bienvenido a las Damas Turcas! Las fichas se colocan en la segunda y tercera fila para ambos lados. El objetivo es capturar todas las fichas del oponente.';

  @override
  String get tutorialStepManMoveDescTurkish =>
      'Los peones se mueven una casilla hacia adelante o hacia los lados. No pueden moverse hacia atrás.';

  @override
  String get tutorialStepCaptureTitle => 'Captura de Ficha';

  @override
  String get tutorialStepCaptureDescTurkish =>
      'Las fichas se capturan saltando sobre una ficha del oponente a la casilla vacía detrás de ella.';

  @override
  String get tutorialStepMaxCaptureTitle => 'Captura Máxima';

  @override
  String get tutorialStepMaxCaptureDesc =>
      'Si hay varias opciones de captura, debes elegir el camino que capture la mayor cantidad de fichas.';

  @override
  String get tutorialStepPromotionTitle => 'Promoción a Dama';

  @override
  String get tutorialStepPromotionDesc =>
      'Cuando un peón llega a la última fila del oponente, se convierte en Dama y gana habilidades especiales.';

  @override
  String get tutorialStepKingMoveDescTurkish =>
      'Una Dama puede moverse cualquier número de casillas vacías hacia adelante, atrás o a los lados (como una torre en ajedrez) y captura saltando sobre una ficha a cualquier casilla vacía detrás de ella en la misma línea.';

  @override
  String get tutorialStepDrawTitle => 'Condiciones de Empate';

  @override
  String get tutorialStepDrawDescTurkish =>
      'Un empate ocurre si la misma posición se repite tres veces, o si no se realizan capturas durante 25 movimientos.';

  @override
  String get tutorialStepWelcomeDescEnglish =>
      '¡Bienvenido a las Damas Inglesas! El objetivo es capturar todas las fichas de tu oponente. Todos los movimientos y capturas se realizan en las casillas oscuras.';

  @override
  String get tutorialStepManMoveDescEnglish =>
      'Los peones solo se mueven un paso en diagonal hacia adelante a una casilla vacía.';

  @override
  String get tutorialStepCaptureDescEnglish =>
      'Los peones capturan saltando sobre una ficha del oponente en diagonal hacia adelante a la casilla vacía justo detrás.';

  @override
  String get tutorialStepManCannotCaptureBackwardTitle =>
      'No se puede Capturar hacia Atrás';

  @override
  String get tutorialStepManCannotCaptureBackwardDesc =>
      'Los peones no pueden capturar hacia atrás. Aquí, la ficha blanca no puede capturar a la ficha negra detrás de ella.';

  @override
  String get tutorialStepMultipleCaptureTitle => 'Capturas Múltiples';

  @override
  String get tutorialStepMultipleCaptureDesc =>
      'Si un salto lleva a otro posible salto, debes continuar capturando en el mismo turno.';

  @override
  String get tutorialStepPromotionDescEnglish =>
      'Cuando un peón llega a la fila más lejana de su posición inicial, se convierte en Dama. El movimiento termina cuando una ficha es promocionada.';

  @override
  String get tutorialStepKingMoveDescEnglish =>
      'Una Dama puede moverse y capturar un paso en diagonal en cualquier dirección, hacia adelante o hacia atrás.';

  @override
  String get tutorialStepDrawDescEnglish =>
      'Un empate ocurre si la misma posición se repite tres veces, o por acuerdo. También, si queda una dama contra una dama, la partida es un empate.';

  @override
  String get tutorialStepWelcomeDescInternational =>
      '¡Bienvenido a las Damas Internacionales, jugadas en un tablero de 10x10! Las reglas son similares a otras variantes, pero con algunas diferencias clave.';

  @override
  String get tutorialStepManCaptureDescInternational =>
      'Los peones se mueven en diagonal hacia adelante pero pueden capturar tanto en diagonal hacia adelante como hacia atrás.';

  @override
  String get tutorialStepKingMoveDescInternational =>
      'Una Dama es \'voladora\'. Puede moverse cualquier número de casillas vacías en diagonal en cualquier dirección.';

  @override
  String get tutorialStepKingCaptureTitle => 'Captura de la Dama';

  @override
  String get tutorialStepKingCaptureDesc =>
      'Una Dama voladora puede capturar una ficha a distancia saltando a cualquier casilla vacía detrás de ella, siempre que el camino esté despejado.';

  @override
  String get tutorialStepKingMultipleCaptureTitle =>
      'Captura Múltiple de la Dama';

  @override
  String get tutorialStepKingMultipleCaptureDesc =>
      'Una Dama puede realizar una secuencia de capturas, a menudo cambiando de dirección después de cada salto.';

  @override
  String get tutorialStepDrawDescInternational =>
      'Un empate ocurre si la misma posición se repite tres veces, o si no se realizan capturas o movimientos de peón durante 50 movimientos. Ciertos finales, como dos damas contra una, también son empate.';

  @override
  String get tutorialStepLosingAimTitle => 'Objetivo del Juego';

  @override
  String get tutorialStepLosingAimDesc =>
      '¡Bienvenido a Anti-Damas! El objetivo es el opuesto a las damas normales: ganas perdiendo todas tus fichas o si no puedes hacer un movimiento legal.';

  @override
  String get tutorialStepMandatoryCaptureDescLosing =>
      'Al igual que en las damas normales, las capturas son obligatorias. ¡Debes entregar tus fichas si tienes la oportunidad!';

  @override
  String get tutorialStepTrapTitle => 'Poniendo una Trampa';

  @override
  String get tutorialStepTrapDesc =>
      'Una estrategia común es forzar a tu oponente a una posición en la que deba hacer una larga secuencia de captura, tomando muchas de tus fichas.';

  @override
  String get tutorialStepFallingIntoTrapTitle => 'Cayendo en la Trampa';

  @override
  String get tutorialStepFallingIntoTrapDesc =>
      'El jugador negro ahora está obligado a capturar la ficha blanca, que es exactamente lo que el Blanco quería.';

  @override
  String get tutorialStepLosingEndgameTitle => 'Final del Juego';

  @override
  String get tutorialStepLosingEndgameDesc =>
      'El juego termina cuando un jugador no tiene fichas en el tablero, o no puede hacer un movimiento. ¡Ese jugador es el ganador! Aquí, el Negro ha ganado porque no le quedan fichas.';

  @override
  String get tutorialStepDrawDescLosing =>
      'Los empates son raros pero pueden ocurrir, por ejemplo, por la triple repetición de una posición.';

  @override
  String get tutorialStepWelcomeDescRussian =>
      '¡Bienvenido a las Damas Rusas (Shashki)! Tiene una regla de promoción única.';

  @override
  String get tutorialStepManCaptureBackwardTitle =>
      'Captura hacia Atrás por Peones';

  @override
  String get tutorialStepManCaptureBackwardDesc =>
      'Al igual que en las Damas Internacionales, los peones se mueven hacia adelante pero pueden capturar tanto hacia adelante como hacia atrás.';

  @override
  String get tutorialStepPromotionDescRussian =>
      'Cuando un peón llega a la última fila del oponente con un movimiento sin captura, se convierte en Dama y el turno termina.';

  @override
  String get tutorialStepPromotionRuleTitle => 'Regla Especial de Promoción';

  @override
  String get tutorialStepPromotionRuleDescRussian =>
      'LA REGLA CLAVE: Si un peón llega a la fila de promoción mediante una captura, se convierte inmediatamente en Dama y DEBE continuar capturando en el mismo turno si es posible.';

  @override
  String get tutorialStepDrawDescRussian =>
      'Un empate puede ocurrir por triple repetición o si no se realizan capturas durante 15 movimientos cuando solo hay damas en el tablero.';

  @override
  String get tutorialStepWelcomeDescSpanish =>
      '¡Bienvenido a las Damas Españolas! Esta variante combina reglas de las Damas Inglesas e Internacionales.';

  @override
  String get tutorialStepManMoveDescSpanish =>
      'Los peones se mueven y capturan solo en diagonal hacia adelante, al igual que en las Damas Inglesas.';

  @override
  String get tutorialStepMandatoryCaptureTitle => 'Captura Obligatoria';

  @override
  String get tutorialStepMandatoryCaptureDescSpanish =>
      'Las capturas son obligatorias. Si hay múltiples opciones de captura, debes elegir una; no hay regla de \'captura máxima\' para los peones.';

  @override
  String get tutorialStepPromotionDescSpanish =>
      'Cuando un peón llega a la fila más lejana, se convierte en Dama. El turno termina con la promoción.';

  @override
  String get tutorialStepKingMoveDescSpanish =>
      'Las damas son \'voladoras\', lo que significa que pueden moverse y capturar sobre múltiples casillas, al igual que en las Damas Internacionales.';

  @override
  String get tutorialStepDrawDescSpanish =>
      'Un empate puede ocurrir por triple repetición o si no se realizan movimientos significativos (capturas o movimientos de peón) durante 50 movimientos.';

  @override
  String get tutorialStepManMoveTitle => 'Movimiento del Peón';

  @override
  String get tutorialStepKingMoveTitle => 'Movimiento de la Dama';

  @override
  String get tutorialStepManCaptureTitle => 'Captura de Peón';

  @override
  String get categoryClassicNatural => 'Clásico y Natural';

  @override
  String get categoryCulturalHistorical => 'Cultural e Histórico';

  @override
  String get categoryFantasySciFi => 'Fantasía y Ciencia Ficción';

  @override
  String get categoryLuxuryArtistic => 'Lujo y Artístico';

  @override
  String get categoryModernMinimalist => 'Moderno y Minimalista';

  @override
  String get categoryFunColorful => 'Divertido y Colorido';

  @override
  String get themeBoardClassicWood => 'Madera Clásica';

  @override
  String get themeBoardMarble => 'Mármol';

  @override
  String get themeBoardGreenVelvet => 'Terciopelo Verde';

  @override
  String get themeBoardOceanBlue => 'Azul Océano';

  @override
  String get themeBoardAutumn => 'Otoño';

  @override
  String get themeBoardGranite => 'Granito';

  @override
  String get themeBoardWinterForest => 'Bosque de Invierno';

  @override
  String get themeBoardRiverStone => 'Piedra de Río';

  @override
  String get themeBoardOttomanTile => 'Azulejo Otomano';

  @override
  String get themeBoardEgyptianPapyrus => 'Papiro Egipcio';

  @override
  String get themeBoardRomanMosaic => 'Mosaico Romano';

  @override
  String get themeBoardJapaneseSakura => 'Sakura Japonés';

  @override
  String get themeBoardScandinavianRune => 'Runa Escandinava';

  @override
  String get themeBoardAztecSunStone => 'Piedra del Sol Azteca';

  @override
  String get themeBoardCelticKnot => 'Nudo Celta';

  @override
  String get themeBoardVictorian => 'Victoriano';

  @override
  String get themeBoardGalaxy => 'Galaxia';

  @override
  String get themeBoardEnchantedForest => 'Bosque Encantado';

  @override
  String get themeBoardHellfire => 'Fuego Infernal';

  @override
  String get themeBoardGlacierKingdom => 'Reino Glaciar';

  @override
  String get themeBoardCyberCircuit => 'Circuito Cibernético';

  @override
  String get themeBoardSteampunk => 'Steampunk';

  @override
  String get themeBoardAtlantis => 'Atlántida';

  @override
  String get themeBoardCanadaSpace => 'Espacio de Canadá';

  @override
  String get themeBoardBlackGold => 'Negro y Oro';

  @override
  String get themeBoardRubyEmerald => 'Rubí y Esmeralda';

  @override
  String get themeBoardArtDeco => 'Art Déco';

  @override
  String get themeBoardRoyalVelvet => 'Terciopelo Real';

  @override
  String get themeBoardPorcelain => 'Porcelana';

  @override
  String get themeBoardStainedGlass => 'Vidriera';

  @override
  String get themeBoardPearl => 'Perla';

  @override
  String get themeBoardBrushStrokes => 'Pinceladas';

  @override
  String get themeBoardMatteBlack => 'Negro Mate';

  @override
  String get themeBoardConcreteSteel => 'Hormigón y Acero';

  @override
  String get themeBoardCarbonFiber => 'Fibra de Carbono';

  @override
  String get themeBoardGlass => 'Cristal';

  @override
  String get themeBoardPaper => 'Papel';

  @override
  String get themeBoardDigitalPixel => 'Píxel Digital';

  @override
  String get themeBoardPastelGeometry => 'Geometría Pastel';

  @override
  String get themeBoardMonochromeGradient => 'Gradiente Monocromático';

  @override
  String get themeBoardCandyLand => 'Tierra de Dulces';

  @override
  String get themeBoardComicBook => 'Cómic';

  @override
  String get themeBoard8BitRetro => 'Retro de 8 bits';

  @override
  String get themeBoardToyBlocks => 'Bloques de Juguete';

  @override
  String get themeBoardRainbow => 'Arcoíris';

  @override
  String get themeBoardGraffiti => 'Grafiti';

  @override
  String get themeBoardWatercolor => 'Acuarela';

  @override
  String get themeBoardHoneycomb => 'Panal de Abeja';

  @override
  String get themePieceCarvedWood => 'Madera Tallada';

  @override
  String get themePieceIvoryEbony => 'Marfil y Ébano';

  @override
  String get themePiecePolishedPebble => 'Guijarro Pulido';

  @override
  String get themePieceEarthenware => 'Loza de Barro';

  @override
  String get themePieceFrostedGlass => 'Vidrio Esmerilado';

  @override
  String get themePieceRedJasper => 'Jaspe Rojo';

  @override
  String get themePieceBamboo => 'Bambú';

  @override
  String get themePieceAmber => 'Ámbar';

  @override
  String get themePieceIznikTile => 'Azulejo de Iznik';

  @override
  String get themePieceLapisLazuli => 'Lapislázuli';

  @override
  String get themePieceJade => 'Jade';

  @override
  String get themePieceAncientBronze => 'Bronce Antiguo';

  @override
  String get themePieceObsidian => 'Obsidiana';

  @override
  String get themePieceParchment => 'Pergamino';

  @override
  String get themePieceTerracotta => 'Terracota';

  @override
  String get themePieceIronRune => 'Runa de Hierro';

  @override
  String get themePieceDragonScale => 'Escama de Dragón';

  @override
  String get themePieceCrystal => 'Cristal';

  @override
  String get themePieceNeonLights => 'Luces de Neón';

  @override
  String get themePieceGhost => 'Fantasma';

  @override
  String get themePieceVolcanicMagma => 'Magma Volcánico';

  @override
  String get themePieceElvenMithril => 'Mithril Élfico';

  @override
  String get themePieceOrcishIron => 'Hierro Órquico';

  @override
  String get themePieceCosmicDust => 'Polvo Cósmico';

  @override
  String get themePieceGoldSilver => 'Oro y Plata';

  @override
  String get themePieceBlackPearl => 'Perla Negra';

  @override
  String get themePieceMalachite => 'Malaquita';

  @override
  String get themePieceVenetianGlass => 'Cristal de Venecia';

  @override
  String get themePieceGatsby => 'Gatsby';

  @override
  String get themePieceDiamond => 'Diamante';

  @override
  String get themePieceRuby => 'Rubí';

  @override
  String get themePieceSapphire => 'Zafiro';

  @override
  String get themePieceModernMinimalist => 'Minimalista Moderno';

  @override
  String get themePieceRobotic => 'Robótico';

  @override
  String get themePieceMetallicGradient => 'Gradiente Metálico';

  @override
  String get themePieceGlossyPlastic => 'Plástico Brillante';

  @override
  String get themePieceHolographic => 'Holográfico';

  @override
  String get themePieceMattePastel => 'Pastel Mate';

  @override
  String get themePieceRubber => 'Goma';

  @override
  String get themePieceLightShadow => 'Luz y Sombra';

  @override
  String get themePieceConfectionery => 'Confitería';

  @override
  String get themePieceChocolate => 'Chocolate';

  @override
  String get themePieceFruitBasket => 'Cesta de Frutas';

  @override
  String get themePieceGummy => 'Gominola';

  @override
  String get themePieceWatermelon => 'Sandía';

  @override
  String get themePieceCosmonaut => 'Cosmonauta';

  @override
  String get themePieceSuperhero => 'Superhéroe';

  @override
  String get themePieceSeashell => 'Concha de Mar';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageRussian => 'Ruso';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get languagePortuguese => 'Portugués';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get version => 'Versión';

  @override
  String get aboutHeader => 'ACERCA DE';

  @override
  String get noInternetConnection => 'No hay conexión a Internet';

  @override
  String get noInternetConnectionMessage =>
      'Por favor, comprueba tu conexión a Internet y vuelve a intentarlo.';

  @override
  String get savedGameDialogTitle =>
      'Tienes una partida guardada. ¿Qué te gustaría hacer?';

  @override
  String get deleteAction => 'Eliminar';
}
