// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Mondo della Dama';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get languageHeader => 'LINGUA';

  @override
  String get language => 'Lingua';

  @override
  String get languageSelectionTitle => 'Seleziona la lingua';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageEnglish => 'Inglese';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get appearanceHeader => 'ASPETTO';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeDark => 'Scuro';

  @override
  String get gameExperienceHeader => 'ESPERIENZA DI GIOCO';

  @override
  String get soundEffects => 'Effetti Sonori';

  @override
  String get haptics => 'Feedback aptico';

  @override
  String get showCoordinates => 'Mostra coordinate';

  @override
  String get gamePreferencesHeader => 'PREFERENZE DI GIOCO';

  @override
  String get gamePreferencesDescription =>
      'Scegli con quale colore iniziare quando giochi contro il computer.';

  @override
  String get colorWhite => 'Bianco';

  @override
  String get colorRandom => 'Casuale';

  @override
  String get colorBlack => 'Nero';

  @override
  String get progressHeader => 'PROGRESSO';

  @override
  String get resetAllRanks => 'Azzera tutti i gradi';

  @override
  String get resetProgressConfirmationTitle => 'Azzerare i progressi?';

  @override
  String get resetProgressConfirmationBody =>
      'I tuoi progressi di grado in tutte le modalità di gioco verranno eliminati definitivamente. Questa azione non può essere annullata.';

  @override
  String get dialogCancel => 'Annulla';

  @override
  String get dialogReset => 'Azzera';

  @override
  String get progressResetSuccess => 'Progressi azzerati';

  @override
  String get dialogOK => 'OK';

  @override
  String get mainMenuPlayButtonAI => 'Seleziona livello';

  @override
  String get mainMenuPlayButtonHuman => 'Nuova partita';

  @override
  String get mainMenuContinue => 'Continua';

  @override
  String get mainMenuOpponentAI => 'Intelligenza Artificiale';

  @override
  String get mainMenuOpponentHuman => 'Due giocatori';

  @override
  String get mainMenuRules => 'Regole';

  @override
  String get mainMenuExploreThemes => 'Esplora temi';

  @override
  String get close => 'Chiudi';

  @override
  String levelNumber(int level) {
    return 'Livello $level';
  }

  @override
  String get themeStoreTitle => 'Negozio di temi';

  @override
  String get searchBoardPlaceholder => 'Cerca tavolieri';

  @override
  String get searchPiecePlaceholder => 'Cerca pedine';

  @override
  String get boards => 'Tavolieri';

  @override
  String get pieces => 'Pedine';

  @override
  String get noResults => 'Nessun risultato trovato';

  @override
  String get loadingStatusInitializing => 'Inizializzazione...';

  @override
  String get loadingStatusSettings => 'Caricamento impostazioni...';

  @override
  String get loadingStatusUI => 'Ottimizzazione interfaccia...';

  @override
  String get loadingStatusReady => 'Pronto!';

  @override
  String get gameScreenConfirmExitTitle => 'Torna al menu principale';

  @override
  String get gameScreenConfirmExitBody => 'Vuoi salvare la partita in corso?';

  @override
  String get gameScreenSaveAndExit => 'Salva ed esci';

  @override
  String get gameScreenExitWithoutSaving => 'Esci senza salvare';

  @override
  String get gameScreenPaused => 'In pausa';

  @override
  String get gameScreenResume => 'Riprendi';

  @override
  String get gameScreenRestart => 'Ricomincia';

  @override
  String get gameScreenReturnToMenu => 'Torna al menu';

  @override
  String get gameOverWinTitle => 'Congratulazioni, hai vinto!';

  @override
  String get gameOverWinBody => 'Una grande vittoria!';

  @override
  String get gameOverNewRankBody => 'Hai ottenuto un nuovo grado!';

  @override
  String get gameOverNewRankTitle => 'AUMENTO DI GRADO!';

  @override
  String get gameOverLoseTitle => 'Hai perso';

  @override
  String get gameOverLoseBody => 'Dovresti allenarti di più.';

  @override
  String get gameOverDrawTitle => 'Patta!';

  @override
  String get gameOverTitle => 'Partita finita!';

  @override
  String gameOverWinner(String winner) {
    return 'Vincitore: $winner';
  }

  @override
  String get gameOverNewGame => 'Nuova partita';

  @override
  String get playerYou => 'Tu';

  @override
  String get playerComputer => 'Computer';

  @override
  String get playerWhite => 'Bianco';

  @override
  String get playerBlack => 'Nero';

  @override
  String get aiThinking => 'Sto pensando...';

  @override
  String get nextMove => 'Prossima mossa';

  @override
  String get waiting => 'In attesa...';

  @override
  String tutorialTitle(String gameMode) {
    return 'Tutorial di $gameMode';
  }

  @override
  String get tutorialNext => 'Avanti';

  @override
  String get tutorialPrevious => 'Indietro';

  @override
  String get tutorialPlay => 'Gioca';

  @override
  String get rankNovice => 'Novizio';

  @override
  String get rankApprentice => 'Apprendista';

  @override
  String get rankJourneyman => 'Esperto';

  @override
  String get rankMaster => 'Maestro';

  @override
  String get rankExpert => 'Esperto';

  @override
  String get rankVirtuoso => 'Virtuoso';

  @override
  String get rankGrandmaster => 'Grande Maestro';

  @override
  String get drawReasonThreefoldRepetition =>
      'La stessa posizione è stata ripetuta tre volte.';

  @override
  String get drawReasonFiftyMoveRule =>
      'Nessuna pedina è stata catturata o promossa per 50 mosse.';

  @override
  String get drawReasonFortyMoveRule =>
      'Nessuna pedina è stata catturata o promossa per 40 mosse.';

  @override
  String get drawReasonTwentyFiveMoveRule =>
      'Nessuna pedina è stata catturata o promossa per 25 mosse.';

  @override
  String get drawReasonFifteenMoveRule =>
      'Nessuna pedina è stata catturata o promossa per 15 mosse.';

  @override
  String get drawReasonInsufficientMaterial =>
      'Le pedine rimaste non sono sufficienti per vincere la partita.';

  @override
  String get drawReasonStalemate => 'Nessun giocatore ha mosse legali rimaste.';

  @override
  String get gameModeTurkishName => 'Dama turca';

  @override
  String get gameModeTurkishDescription =>
      'Giocata su una scacchiera 8x8. Le pedine si muovono in avanti e di lato.';

  @override
  String get gameModeEnglishName => 'Dama inglese';

  @override
  String get gameModeEnglishDescription =>
      'Giocata su una scacchiera 8x8. Le pedine non possono catturare all\'indietro e le dame non volano.';

  @override
  String get gameModeInternationalName => 'Dama internazionale';

  @override
  String get gameModeInternationalDescription =>
      'Giocata su una scacchiera 10x10. La cattura massima è obbligatoria e le dame volano.';

  @override
  String get gameModeRussianName => 'Dama russa';

  @override
  String get gameModeRussianDescription =>
      'Una pedina promossa catturando può continuare a catturare nella stessa mossa.';

  @override
  String get gameModeSpanishName => 'Dama spagnola';

  @override
  String get gameModeSpanishDescription =>
      'Le pedine possono solo muoversi/catturare in avanti. La cattura massima è obbligatoria e le dame volano.';

  @override
  String get gameModeAntiCheckersName => 'Antidama (vince chi perde)';

  @override
  String get gameModeAntiCheckersDescription =>
      'Il primo giocatore che perde tutte le sue pedine o non ha più mosse vince.';

  @override
  String get ruleTitleManMove => 'Movimento della pedina';

  @override
  String get ruleDescManMoveForward =>
      'Le pedine si muovono solo di un passo in diagonale in avanti.';

  @override
  String get ruleTitleManCapture => 'Cattura della pedina';

  @override
  String get ruleDescManCaptureForward =>
      'Le pedine catturano solo saltando in diagonale in avanti.';

  @override
  String get ruleDescManCaptureBackward =>
      'Le pedine possono catturare saltando in diagonale sia in avanti che all\'indietro.';

  @override
  String get ruleTitleKingMove => 'Movimento della dama';

  @override
  String get ruleDescKingShort =>
      'Le dame si muovono e catturano di un passo in diagonale in qualsiasi direzione.';

  @override
  String get ruleDescKingFlying =>
      'Le dame (o dame volanti) possono muoversi di un numero qualsiasi di caselle vuote in diagonale.';

  @override
  String get ruleTitleMandatoryCapture => 'Cattura obbligatoria';

  @override
  String get ruleDescMandatoryCapture =>
      'Se è disponibile una cattura, deve essere effettuata.';

  @override
  String get ruleTitleMaxCapture => 'Cattura massima';

  @override
  String get ruleDescMaxCapture =>
      'Se sono disponibili più sequenze di cattura, deve essere scelta quella che cattura il maggior numero di pedine.';

  @override
  String get ruleTitleTurkishManMove => 'Movimento della pedina';

  @override
  String get ruleDescTurkishManMove =>
      'Le pedine si muovono di una casella in avanti o di lato, ma non all\'indietro.';

  @override
  String get ruleTitleTurkishCapture => 'Cattura';

  @override
  String get ruleDescTurkishCapture =>
      'Le pedine vengono catturate saltandoci sopra.';

  @override
  String get ruleTitlePromotion => 'Regola della promozione';

  @override
  String get ruleDescPromotionStops =>
      'Una pedina che viene promossa a dama durante una sequenza di cattura interrompe il suo turno.';

  @override
  String get ruleDescPromotionContinues =>
      'Una pedina che viene promossa a dama durante una sequenza di cattura può continuare a catturare come dama nello stesso turno.';

  @override
  String get ruleTitleAntiCheckersAim => 'Obiettivo';

  @override
  String get ruleDescAntiCheckersAim =>
      'L\'obiettivo è perdere tutte le proprie pedine o non essere in grado di muoversi.';

  @override
  String get tutorialStepWelcomeTitle => 'Benvenuto';

  @override
  String get tutorialStepWelcomeDescTurkish =>
      'Benvenuto nella Dama turca! Le pedine sono disposte sulla seconda e terza riga per entrambi i lati. L\'obiettivo è catturare tutte le pedine del tuo avversario.';

  @override
  String get tutorialStepManMoveDescTurkish =>
      'Le pedine si muovono di una casella in avanti o di lato. Non possono muoversi all\'indietro.';

  @override
  String get tutorialStepCaptureTitle => 'Cattura della pedina';

  @override
  String get tutorialStepCaptureDescTurkish =>
      'Le pedine vengono catturate saltando sopra una pedina dell\'avversario nella casella vuota dietro di essa.';

  @override
  String get tutorialStepMaxCaptureTitle => 'Cattura massima';

  @override
  String get tutorialStepMaxCaptureDesc =>
      'Se ci sono più opzioni di cattura, devi scegliere il percorso che cattura il maggior numero di pedine.';

  @override
  String get tutorialStepPromotionTitle => 'Promozione';

  @override
  String get tutorialStepPromotionDesc =>
      'Quando una pedina raggiunge l\'ultima riga dell\'avversario, viene promossa a Dama.';

  @override
  String get tutorialStepKingMoveDescTurkish =>
      'Una Dama può muoversi di un numero qualsiasi di caselle vuote in avanti, all\'indietro o di lato (come una torre negli scacchi) e cattura saltando sopra una pedina in una qualsiasi casella vuota dietro di essa lungo la stessa linea.';

  @override
  String get tutorialStepDrawTitle => 'Condizioni di parità';

  @override
  String get tutorialStepDrawDescTurkish =>
      'Una partita è patta se la stessa posizione si ripete per tre volte, o se non vengono effettuate catture per 25 mosse.';

  @override
  String get tutorialStepWelcomeDescEnglish =>
      'Benvenuto nella Dama inglese! L\'obiettivo è catturare tutte le pedine del tuo avversario. Tutte le mosse e le catture vengono effettuate sulle caselle scure.';

  @override
  String get tutorialStepManMoveDescEnglish =>
      'Le pedine si muovono solo di un passo in diagonale in avanti verso una casella vuota.';

  @override
  String get tutorialStepCaptureDescEnglish =>
      'Le pedine catturano saltando sopra una pedina dell\'avversario in diagonale in avanti verso la casella vuota subito dopo.';

  @override
  String get tutorialStepManCannotCaptureBackwardTitle =>
      'Impossibile catturare all\'indietro';

  @override
  String get tutorialStepManCannotCaptureBackwardDesc =>
      'Le pedine non possono catturare all\'indietro. Qui, la pedina bianca non può catturare la pedina nera dietro di essa.';

  @override
  String get tutorialStepMultipleCaptureTitle => 'Catture multiple';

  @override
  String get tutorialStepMultipleCaptureDesc =>
      'Se un salto porta a un altro possibile salto, devi continuare a catturare nello stesso turno.';

  @override
  String get tutorialStepPromotionDescEnglish =>
      'Quando una pedina raggiunge la riga più lontana dalla sua posizione di partenza, viene promossa a Dama. La mossa termina quando una pedina viene promossa.';

  @override
  String get tutorialStepKingMoveDescEnglish =>
      'Una Dama può muoversi e catturare di un passo in diagonale in qualsiasi direzione, avanti o indietro.';

  @override
  String get tutorialStepDrawDescEnglish =>
      'Una partita è patta se la stessa posizione si ripete per tre volte, o per accordo. Inoltre, se c\'è una dama contro una dama, la partita è patta.';

  @override
  String get tutorialStepWelcomeDescInternational =>
      'Benvenuto nella Dama internazionale, giocata su una scacchiera 10x10! Le regole sono simili ad altre varianti, ma con alcune differenze chiave.';

  @override
  String get tutorialStepManCaptureDescInternational =>
      'Le pedine si muovono in diagonale in avanti ma possono catturare sia in diagonale in avanti che all\'indietro.';

  @override
  String get tutorialStepKingMoveDescInternational =>
      'Una Dama è \'volante\'. Può muoversi di un numero qualsiasi di caselle vuote in diagonale in qualsiasi direzione.';

  @override
  String get tutorialStepKingCaptureTitle => 'Cattura della dama';

  @override
  String get tutorialStepKingCaptureDesc =>
      'Una Dama volante può catturare una pedina a distanza saltando in una qualsiasi casella vuota dietro di essa, purché il percorso sia libero.';

  @override
  String get tutorialStepKingMultipleCaptureTitle =>
      'Cattura multipla della dama';

  @override
  String get tutorialStepKingMultipleCaptureDesc =>
      'Una Dama può eseguire una sequenza di catture, spesso cambiando direzione dopo ogni salto.';

  @override
  String get tutorialStepDrawDescInternational =>
      'Una partita è patta se la stessa posizione si ripete per tre volte, o se non vengono effettuate catture o mosse di pedina per 50 mosse. Anche alcuni finali, come due dame contro una, sono patti.';

  @override
  String get tutorialStepLosingAimTitle => 'Obiettivo del gioco';

  @override
  String get tutorialStepLosingAimDesc =>
      'Benvenuto all\'Antidama! L\'obiettivo è l\'opposto della dama normale: vinci perdendo tutte le tue pedine o non potendo più fare una mossa legale.';

  @override
  String get tutorialStepMandatoryCaptureDescLosing =>
      'Proprio come nella dama normale, le catture sono obbligatorie. Devi cedere le tue pedine se ne hai la possibilità!';

  @override
  String get tutorialStepTrapTitle => 'Tendendo una trappola';

  @override
  String get tutorialStepTrapDesc =>
      'Una strategia comune è costringere il tuo avversario in una posizione in cui deve effettuare una lunga sequenza di catture, prendendo molte delle tue pedine.';

  @override
  String get tutorialStepFallingIntoTrapTitle => 'Cadere nella trappola';

  @override
  String get tutorialStepFallingIntoTrapDesc =>
      'Il giocatore nero è ora costretto a catturare la pedina bianca, che è esattamente ciò che voleva il Bianco.';

  @override
  String get tutorialStepLosingEndgameTitle => 'Fine del gioco';

  @override
  String get tutorialStepLosingEndgameDesc =>
      'La partita termina quando un giocatore non ha più pedine sulla scacchiera, o non può muovere. Quel giocatore è il vincitore! Qui, il Nero ha vinto perché non ha più pedine.';

  @override
  String get tutorialStepDrawDescLosing =>
      'Le patte sono rare ma possono verificarsi, ad esempio, per triplice ripetizione di una posizione.';

  @override
  String get tutorialStepWelcomeDescRussian =>
      'Benvenuto nella Dama russa (Shashki)! Ha una regola di promozione unica.';

  @override
  String get tutorialStepManCaptureBackwardTitle =>
      'Cattura all\'indietro da parte delle pedine';

  @override
  String get tutorialStepManCaptureBackwardDesc =>
      'Come nella Dama internazionale, le pedine si muovono in avanti ma possono catturare sia in avanti che all\'indietro.';

  @override
  String get tutorialStepPromotionDescRussian =>
      'Quando una pedina raggiunge l\'ultima riga dell\'avversario con una mossa senza cattura, viene promossa a Dama e il turno termina.';

  @override
  String get tutorialStepPromotionRuleTitle => 'Regola speciale di promozione';

  @override
  String get tutorialStepPromotionRuleDescRussian =>
      'LA REGOLA CHIAVE: Se una pedina raggiunge la riga di promozione tramite una cattura, diventa immediatamente una Dama e DEVE continuare a catturare nello stesso turno, se possibile.';

  @override
  String get tutorialStepDrawDescRussian =>
      'Una partita può essere patta per triplice ripetizione o se non vengono effettuate catture per 15 mosse quando sulla scacchiera ci sono solo dame.';

  @override
  String get tutorialStepWelcomeDescSpanish =>
      'Benvenuto nella Dama spagnola! Questa variante combina le regole della Dama inglese e internazionale.';

  @override
  String get tutorialStepManMoveDescSpanish =>
      'Le pedine si muovono e catturano solo in diagonale in avanti, proprio come nella Dama inglese.';

  @override
  String get tutorialStepMandatoryCaptureTitle => 'Cattura obbligatoria';

  @override
  String get tutorialStepMandatoryCaptureDescSpanish =>
      'Le catture sono obbligatorie. Se ci sono più opzioni di cattura, devi sceglierne una; non esiste una regola di \'cattura massima\' per le pedine.';

  @override
  String get tutorialStepPromotionDescSpanish =>
      'Quando una pedina raggiunge la riga più lontana, viene promossa a Dama. Il turno termina con la promozione.';

  @override
  String get tutorialStepKingMoveDescSpanish =>
      'Le dame sono \'volanti\', il che significa che possono muoversi e catturare su più caselle, proprio come nella Dama internazionale.';

  @override
  String get tutorialStepDrawDescSpanish =>
      'Una partita può essere patta per triplice ripetizione o se non vengono effettuate mosse significative (catture o mosse di pedina) per 50 mosse.';

  @override
  String get tutorialStepManMoveTitle => 'Movimento della pedina';

  @override
  String get tutorialStepKingMoveTitle => 'Movimento della dama';

  @override
  String get tutorialStepManCaptureTitle => 'Cattura della pedina';

  @override
  String get categoryClassicNatural => 'Classico e naturale';

  @override
  String get categoryCulturalHistorical => 'Culturale e storico';

  @override
  String get categoryFantasySciFi => 'Fantasy e fantascienza';

  @override
  String get categoryLuxuryArtistic => 'Lusso e artistico';

  @override
  String get categoryModernMinimalist => 'Moderno e minimalista';

  @override
  String get categoryFunColorful => 'Divertente e colorato';

  @override
  String get themeBoardClassicWood => 'Legno classico';

  @override
  String get themeBoardMarble => 'Marmo';

  @override
  String get themeBoardGreenVelvet => 'Velluto verde';

  @override
  String get themeBoardOceanBlue => 'Blu oceano';

  @override
  String get themeBoardAutumn => 'Autunno';

  @override
  String get themeBoardGranite => 'Granito';

  @override
  String get themeBoardWinterForest => 'Foresta invernale';

  @override
  String get themeBoardRiverStone => 'Pietra di fiume';

  @override
  String get themeBoardOttomanTile => 'Piastrella ottomana';

  @override
  String get themeBoardEgyptianPapyrus => 'Papiro egiziano';

  @override
  String get themeBoardRomanMosaic => 'Mosaico romano';

  @override
  String get themeBoardJapaneseSakura => 'Sakura giapponese';

  @override
  String get themeBoardScandinavianRune => 'Runa scandinava';

  @override
  String get themeBoardAztecSunStone => 'Pietra del sole azteca';

  @override
  String get themeBoardCelticKnot => 'Nodo celtico';

  @override
  String get themeBoardVictorian => 'Vittoriano';

  @override
  String get themeBoardGalaxy => 'Galassia';

  @override
  String get themeBoardEnchantedForest => 'Foresta incantata';

  @override
  String get themeBoardHellfire => 'Fuoco infernale';

  @override
  String get themeBoardGlacierKingdom => 'Regno dei ghiacciai';

  @override
  String get themeBoardCyberCircuit => 'Circuito cibernetico';

  @override
  String get themeBoardSteampunk => 'Steampunk';

  @override
  String get themeBoardAtlantis => 'Atlantide';

  @override
  String get themeBoardCanadaSpace => 'Spazio Canada';

  @override
  String get themeBoardBlackGold => 'Nero e oro';

  @override
  String get themeBoardRubyEmerald => 'Rubino e smeraldo';

  @override
  String get themeBoardArtDeco => 'Art déco';

  @override
  String get themeBoardRoyalVelvet => 'Velluto reale';

  @override
  String get themeBoardPorcelain => 'Porcellana';

  @override
  String get themeBoardStainedGlass => 'Vetrata';

  @override
  String get themeBoardPearl => 'Perla';

  @override
  String get themeBoardBrushStrokes => 'Pennellate';

  @override
  String get themeBoardMatteBlack => 'Nero opaco';

  @override
  String get themeBoardConcreteSteel => 'Cemento e acciaio';

  @override
  String get themeBoardCarbonFiber => 'Fibra di carbonio';

  @override
  String get themeBoardGlass => 'Vetro';

  @override
  String get themeBoardPaper => 'Carta';

  @override
  String get themeBoardDigitalPixel => 'Pixel digitale';

  @override
  String get themeBoardPastelGeometry => 'Geometria pastello';

  @override
  String get themeBoardMonochromeGradient => 'Gradiente monocromatico';

  @override
  String get themeBoardCandyLand => 'Paese delle caramelle';

  @override
  String get themeBoardComicBook => 'Fumetto';

  @override
  String get themeBoard8BitRetro => 'Retrò a 8 bit';

  @override
  String get themeBoardToyBlocks => 'Blocchi giocattolo';

  @override
  String get themeBoardRainbow => 'Arcobaleno';

  @override
  String get themeBoardGraffiti => 'Graffiti';

  @override
  String get themeBoardWatercolor => 'Acquerello';

  @override
  String get themeBoardHoneycomb => 'Nido d\'ape';

  @override
  String get themePieceCarvedWood => 'Legno intagliato';

  @override
  String get themePieceIvoryEbony => 'Avorio ed ebano';

  @override
  String get themePiecePolishedPebble => 'Ciottolo levigato';

  @override
  String get themePieceEarthenware => 'Terracotta';

  @override
  String get themePieceFrostedGlass => 'Vetro smerigliato';

  @override
  String get themePieceRedJasper => 'Diaspro rosso';

  @override
  String get themePieceBamboo => 'Bambù';

  @override
  String get themePieceAmber => 'Ambra';

  @override
  String get themePieceIznikTile => 'Piastrella di Iznik';

  @override
  String get themePieceLapisLazuli => 'Lapislazzuli';

  @override
  String get themePieceJade => 'Giada';

  @override
  String get themePieceAncientBronze => 'Bronzo antico';

  @override
  String get themePieceObsidian => 'Ossidiana';

  @override
  String get themePieceParchment => 'Pergamena';

  @override
  String get themePieceTerracotta => 'Terracotta';

  @override
  String get themePieceIronRune => 'Runa di ferro';

  @override
  String get themePieceDragonScale => 'Scaglia di drago';

  @override
  String get themePieceCrystal => 'Cristallo';

  @override
  String get themePieceNeonLights => 'Luci al neon';

  @override
  String get themePieceGhost => 'Fantasma';

  @override
  String get themePieceVolcanicMagma => 'Magma vulcanico';

  @override
  String get themePieceElvenMithril => 'Mithril elfico';

  @override
  String get themePieceOrcishIron => 'Ferro orchesco';

  @override
  String get themePieceCosmicDust => 'Polvere cosmica';

  @override
  String get themePieceGoldSilver => 'Oro e argento';

  @override
  String get themePieceBlackPearl => 'Perla nera';

  @override
  String get themePieceMalachite => 'Malachite';

  @override
  String get themePieceVenetianGlass => 'Vetro di Venezia';

  @override
  String get themePieceGatsby => 'Gatsby';

  @override
  String get themePieceDiamond => 'Diamante';

  @override
  String get themePieceRuby => 'Rubino';

  @override
  String get themePieceSapphire => 'Zaffiro';

  @override
  String get themePieceModernMinimalist => 'Minimalista moderno';

  @override
  String get themePieceRobotic => 'Robotico';

  @override
  String get themePieceMetallicGradient => 'Gradiente metallico';

  @override
  String get themePieceGlossyPlastic => 'Plastica lucida';

  @override
  String get themePieceHolographic => 'Olografico';

  @override
  String get themePieceMattePastel => 'Pastello opaco';

  @override
  String get themePieceRubber => 'Gomma';

  @override
  String get themePieceLightShadow => 'Luce e ombra';

  @override
  String get themePieceConfectionery => 'Dolciumi';

  @override
  String get themePieceChocolate => 'Cioccolato';

  @override
  String get themePieceFruitBasket => 'Cesto di frutta';

  @override
  String get themePieceGummy => 'Gommoso';

  @override
  String get themePieceWatermelon => 'Anguria';

  @override
  String get themePieceCosmonaut => 'Cosmonauta';

  @override
  String get themePieceSuperhero => 'Supereroe';

  @override
  String get themePieceSeashell => 'Conchiglia';

  @override
  String get languageSpanish => 'Spagnolo';

  @override
  String get languageRussian => 'Russo';

  @override
  String get languageGerman => 'Tedesco';

  @override
  String get languagePortuguese => 'Portoghese';

  @override
  String get languageFrench => 'Francese';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get version => 'Sürüm';

  @override
  String get aboutHeader => 'HAKKINDA';

  @override
  String get noInternetConnection => 'Nessuna connessione a Internet';

  @override
  String get noInternetConnectionMessage =>
      'Controlla la tua connessione internet e riprova.';

  @override
  String get savedGameDialogTitle =>
      'Hai una partita salvata. Cosa vorresti fare?';

  @override
  String get deleteAction => 'Elimina';
}
