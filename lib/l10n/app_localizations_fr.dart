// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Monde des Dames';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get languageHeader => 'LANGUE';

  @override
  String get language => 'Langue';

  @override
  String get languageSelectionTitle => 'Sélectionner la langue';

  @override
  String get languageSystem => 'Système';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageTurkish => 'Turc';

  @override
  String get appearanceHeader => 'APPARENCE';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeDark => 'Sombre';

  @override
  String get gameExperienceHeader => 'EXPÉRIENCE DE JEU';

  @override
  String get soundEffects => 'Effets Sonores';

  @override
  String get haptics => 'Retour haptique';

  @override
  String get showCoordinates => 'Afficher les coordonnées';

  @override
  String get gamePreferencesHeader => 'PRÉFÉRENCES DE JEU';

  @override
  String get gamePreferencesDescription =>
      'Choisissez la couleur avec laquelle vous voulez commencer lorsque vous jouez contre l\'ordinateur.';

  @override
  String get colorWhite => 'Blanc';

  @override
  String get colorRandom => 'Aléatoire';

  @override
  String get colorBlack => 'Noir';

  @override
  String get progressHeader => 'PROGRESSION';

  @override
  String get resetAllRanks => 'Réinitialiser tous les rangs';

  @override
  String get resetProgressConfirmationTitle => 'Réinitialiser la progression ?';

  @override
  String get resetProgressConfirmationBody =>
      'Votre progression de rang dans tous les modes de jeu sera définitivement supprimée. Cette action est irréversible.';

  @override
  String get dialogCancel => 'Annuler';

  @override
  String get dialogReset => 'Réinitialiser';

  @override
  String get progressResetSuccess => 'Progression réinitialisée';

  @override
  String get dialogOK => 'OK';

  @override
  String get mainMenuPlayButtonAI => 'Sélectionner le niveau';

  @override
  String get mainMenuPlayButtonHuman => 'Nouveau jeu';

  @override
  String get mainMenuContinue => 'Continuer';

  @override
  String get mainMenuOpponentAI => 'Intelligence Artificielle';

  @override
  String get mainMenuOpponentHuman => 'Deux joueurs';

  @override
  String get mainMenuRules => 'Règles';

  @override
  String get mainMenuExploreThemes => 'Explorer les thèmes';

  @override
  String get close => 'Fermer';

  @override
  String levelNumber(int level) {
    return 'Niveau $level';
  }

  @override
  String get themeStoreTitle => 'Magasin de thèmes';

  @override
  String get searchBoardPlaceholder => 'Rechercher des plateaux';

  @override
  String get searchPiecePlaceholder => 'Rechercher des pions';

  @override
  String get boards => 'Plateaux';

  @override
  String get pieces => 'Pions';

  @override
  String get noResults => 'Aucun résultat trouvé';

  @override
  String get loadingStatusInitializing => 'Initialisation...';

  @override
  String get loadingStatusSettings => 'Chargement des paramètres...';

  @override
  String get loadingStatusUI => 'Optimisation de l\'interface...';

  @override
  String get loadingStatusReady => 'Prêt !';

  @override
  String get gameScreenConfirmExitTitle => 'Retour au menu principal';

  @override
  String get gameScreenConfirmExitBody =>
      'Voulez-vous sauvegarder la partie en cours ?';

  @override
  String get gameScreenSaveAndExit => 'Sauvegarder et quitter';

  @override
  String get gameScreenExitWithoutSaving => 'Quitter sans sauvegarder';

  @override
  String get gameScreenPaused => 'En pause';

  @override
  String get gameScreenResume => 'Reprendre';

  @override
  String get gameScreenRestart => 'Recommencer';

  @override
  String get gameScreenReturnToMenu => 'Retour au menu';

  @override
  String get gameOverWinTitle => 'Félicitations, vous avez gagné !';

  @override
  String get gameOverWinBody => 'Une belle victoire !';

  @override
  String get gameOverNewRankBody => 'Vous avez atteint un nouveau rang !';

  @override
  String get gameOverNewRankTitle => 'PROMOTION DE RANG !';

  @override
  String get gameOverLoseTitle => 'Vous avez perdu';

  @override
  String get gameOverLoseBody => 'Vous devriez vous entraîner davantage.';

  @override
  String get gameOverDrawTitle => 'Égalité !';

  @override
  String get gameOverTitle => 'Partie terminée !';

  @override
  String gameOverWinner(String winner) {
    return 'Gagnant : $winner';
  }

  @override
  String get gameOverNewGame => 'Nouveau jeu';

  @override
  String get playerYou => 'Vous';

  @override
  String get playerComputer => 'Ordinateur';

  @override
  String get playerWhite => 'Blanc';

  @override
  String get playerBlack => 'Noir';

  @override
  String get aiThinking => 'Réflexion...';

  @override
  String get nextMove => 'Prochain coup';

  @override
  String get waiting => 'En attente...';

  @override
  String tutorialTitle(String gameMode) {
    return 'Tutoriel de $gameMode';
  }

  @override
  String get tutorialNext => 'Suivant';

  @override
  String get tutorialPrevious => 'Précédent';

  @override
  String get tutorialPlay => 'Jouer';

  @override
  String get rankNovice => 'Novice';

  @override
  String get rankApprentice => 'Apprenti';

  @override
  String get rankJourneyman => 'Compagnon';

  @override
  String get rankMaster => 'Maître';

  @override
  String get rankExpert => 'Expert';

  @override
  String get rankVirtuoso => 'Virtuose';

  @override
  String get rankGrandmaster => 'Grand Maître';

  @override
  String get drawReasonThreefoldRepetition =>
      'La même position a été répétée trois fois.';

  @override
  String get drawReasonFiftyMoveRule =>
      'Aucun pion n\'a été capturé ou promu pendant 50 coups.';

  @override
  String get drawReasonFortyMoveRule =>
      'Aucun pion n\'a été capturé ou promu pendant 40 coups.';

  @override
  String get drawReasonTwentyFiveMoveRule =>
      'Aucun pion n\'a été capturé ou promu pendant 25 coups.';

  @override
  String get drawReasonFifteenMoveRule =>
      'Aucun pion n\'a été capturé ou promu pendant 15 coups.';

  @override
  String get drawReasonInsufficientMaterial =>
      'Les pièces restantes sont insuffisantes pour gagner la partie.';

  @override
  String get drawReasonStalemate =>
      'Aucun joueur n\'a de coups légaux restants.';

  @override
  String get gameModeTurkishName => 'Dames turques';

  @override
  String get gameModeTurkishDescription =>
      'Joué sur un plateau de 8x8. Les pions se déplacent vers l\'avant et sur les côtés.';

  @override
  String get gameModeEnglishName => 'Dames anglaises';

  @override
  String get gameModeEnglishDescription =>
      'Joué sur un plateau de 8x8. Les hommes ne peuvent pas capturer en arrière et les rois ne volent pas.';

  @override
  String get gameModeInternationalName => 'Dames internationales';

  @override
  String get gameModeInternationalDescription =>
      'Joué sur un plateau de 10x10. La capture maximale est obligatoire et les rois volent.';

  @override
  String get gameModeRussianName => 'Dames russes';

  @override
  String get gameModeRussianDescription =>
      'Un pion promu en capturant peut continuer à capturer dans le même coup.';

  @override
  String get gameModeSpanishName => 'Dames espagnoles';

  @override
  String get gameModeSpanishDescription =>
      'Les hommes ne peuvent se déplacer/capturer que vers l\'avant. La capture maximale est obligatoire et les rois volent.';

  @override
  String get gameModeAntiCheckersName => 'Anti-Dames (Jeu de perte)';

  @override
  String get gameModeAntiCheckersDescription =>
      'Le premier joueur à perdre tous ses pions ou à ne plus avoir de coups gagne.';

  @override
  String get ruleTitleManMove => 'Mouvement de l\'homme';

  @override
  String get ruleDescManMoveForward =>
      'Les hommes ne se déplacent que d\'une case en diagonale vers l\'avant.';

  @override
  String get ruleTitleManCapture => 'Capture de l\'homme';

  @override
  String get ruleDescManCaptureForward =>
      'Les hommes ne capturent qu\'en sautant en diagonale vers l\'avant.';

  @override
  String get ruleDescManCaptureBackward =>
      'Les hommes peuvent capturer en sautant en diagonale vers l\'avant et vers l\'arrière.';

  @override
  String get ruleTitleKingMove => 'Mouvement du roi';

  @override
  String get ruleDescKingShort =>
      'Les rois se déplacent et capturent d\'une case en diagonale dans n\'importe quelle direction.';

  @override
  String get ruleDescKingFlying =>
      'Les rois (ou rois volants) peuvent se déplacer d\'un nombre quelconque de cases vides en diagonale.';

  @override
  String get ruleTitleMandatoryCapture => 'Capture obligatoire';

  @override
  String get ruleDescMandatoryCapture =>
      'Si une capture est disponible, elle doit être effectuée.';

  @override
  String get ruleTitleMaxCapture => 'Capture maximale';

  @override
  String get ruleDescMaxCapture =>
      'Si plusieurs séquences de capture sont disponibles, celle qui capture le plus de pièces doit être choisie.';

  @override
  String get ruleTitleTurkishManMove => 'Mouvement de l\'homme';

  @override
  String get ruleDescTurkishManMove =>
      'Les hommes se déplacent d\'une case vers l\'avant ou sur les côtés, mais pas en arrière.';

  @override
  String get ruleTitleTurkishCapture => 'Capture';

  @override
  String get ruleDescTurkishCapture =>
      'Les pièces sont capturées en sautant par-dessus.';

  @override
  String get ruleTitlePromotion => 'Règle de promotion';

  @override
  String get ruleDescPromotionStops =>
      'Un homme qui est promu roi lors d\'une séquence de capture arrête son tour.';

  @override
  String get ruleDescPromotionContinues =>
      'Un homme qui est promu roi lors d\'une séquence de capture peut continuer à capturer en tant que roi dans le même tour.';

  @override
  String get ruleTitleAntiCheckersAim => 'Objectif';

  @override
  String get ruleDescAntiCheckersAim =>
      'Le but est de perdre toutes vos pièces ou de ne plus pouvoir bouger.';

  @override
  String get tutorialStepWelcomeTitle => 'Bienvenue';

  @override
  String get tutorialStepWelcomeDescTurkish =>
      'Bienvenue aux Dames turques ! Les pièces sont disposées sur les deuxième et troisième rangées pour les deux côtés. Le but est de capturer toutes les pièces de votre adversaire.';

  @override
  String get tutorialStepManMoveDescTurkish =>
      'Les hommes se déplacent d\'une case vers l\'avant ou sur les côtés. Ils ne peuvent pas reculer.';

  @override
  String get tutorialStepCaptureTitle => 'Capture de pièce';

  @override
  String get tutorialStepCaptureDescTurkish =>
      'Les pièces sont capturées en sautant par-dessus une pièce de l\'adversaire dans la case vide derrière elle.';

  @override
  String get tutorialStepMaxCaptureTitle => 'Capture maximale';

  @override
  String get tutorialStepMaxCaptureDesc =>
      'S\'il existe plusieurs options de capture, vous devez choisir le chemin qui capture le plus de pièces.';

  @override
  String get tutorialStepPromotionTitle => 'Promotion';

  @override
  String get tutorialStepPromotionDesc =>
      'Lorsqu\'un homme atteint la dernière rangée de l\'adversaire, il est promu roi.';

  @override
  String get tutorialStepKingMoveDescTurkish =>
      'Un roi peut se déplacer d\'un nombre quelconque de cases vides vers l\'avant, vers l\'arrière ou sur les côtés (comme une tour aux échecs) et capture en sautant par-dessus une pièce vers n\'importe quelle case vide derrière elle sur la même ligne.';

  @override
  String get tutorialStepDrawTitle => 'Conditions de nullité';

  @override
  String get tutorialStepDrawDescTurkish =>
      'Une partie est nulle si la même position est répétée trois fois, ou si aucune capture n\'est effectuée pendant 25 coups.';

  @override
  String get tutorialStepWelcomeDescEnglish =>
      'Bienvenue aux Dames anglaises ! Le but est de capturer toutes les pièces de votre adversaire. Tous les mouvements et captures se font sur les cases sombres.';

  @override
  String get tutorialStepManMoveDescEnglish =>
      'Les hommes ne se déplacent que d\'une case en diagonale vers l\'avant vers une case vide.';

  @override
  String get tutorialStepCaptureDescEnglish =>
      'Les hommes capturent en sautant par-dessus une pièce de l\'adversaire en diagonale vers l\'avant vers la case vide juste au-delà.';

  @override
  String get tutorialStepManCannotCaptureBackwardTitle =>
      'Impossible de capturer en arrière';

  @override
  String get tutorialStepManCannotCaptureBackwardDesc =>
      'Les hommes ne peuvent pas capturer en arrière. Ici, la pièce blanche ne peut pas capturer la pièce noire derrière elle.';

  @override
  String get tutorialStepMultipleCaptureTitle => 'Captures multiples';

  @override
  String get tutorialStepMultipleCaptureDesc =>
      'Si un saut mène à un autre saut possible, vous devez continuer à capturer dans le même tour.';

  @override
  String get tutorialStepPromotionDescEnglish =>
      'Lorsqu\'un homme atteint la rangée la plus éloignée de sa position de départ, il est promu roi. Le coup se termine lorsqu\'une pièce est promue.';

  @override
  String get tutorialStepKingMoveDescEnglish =>
      'Un roi peut se déplacer et capturer d\'une case en diagonale dans n\'importe quelle direction, vers l\'avant ou vers l\'arrière.';

  @override
  String get tutorialStepDrawDescEnglish =>
      'Une partie est nulle si la même position est répétée trois fois, ou par accord. De plus, s\'il y a un roi contre un roi, la partie est nulle.';

  @override
  String get tutorialStepWelcomeDescInternational =>
      'Bienvenue aux Dames internationales, jouées sur un plateau de 10x10 ! Les règles sont similaires à d\'autres variantes, mais avec quelques différences clés.';

  @override
  String get tutorialStepManCaptureDescInternational =>
      'Les hommes se déplacent en diagonale vers l\'avant mais peuvent capturer à la fois en diagonale vers l\'avant et vers l\'arrière.';

  @override
  String get tutorialStepKingMoveDescInternational =>
      'Un roi est « volant ». Il peut se déplacer d\'un nombre quelconque de cases vides en diagonale dans n\'importe quelle direction.';

  @override
  String get tutorialStepKingCaptureTitle => 'Capture du roi';

  @override
  String get tutorialStepKingCaptureDesc =>
      'Un roi volant peut capturer une pièce à distance en sautant vers n\'importe quelle case vide derrière elle, tant que le chemin est libre.';

  @override
  String get tutorialStepKingMultipleCaptureTitle => 'Capture multiple du roi';

  @override
  String get tutorialStepKingMultipleCaptureDesc =>
      'Un roi peut effectuer une séquence de captures, changeant souvent de direction après chaque saut.';

  @override
  String get tutorialStepDrawDescInternational =>
      'Une partie est nulle si la même position est répétée trois fois, ou si aucune capture ou aucun mouvement d\'homme n\'est effectué pendant 50 coups. Certaines fins de partie, comme deux rois contre un roi, sont également nulles.';

  @override
  String get tutorialStepLosingAimTitle => 'Objectif du jeu';

  @override
  String get tutorialStepLosingAimDesc =>
      'Bienvenue aux Anti-Dames ! L\'objectif est le contraire des dames normales : vous gagnez en perdant toutes vos pièces ou en ne pouvant plus effectuer de coup légal.';

  @override
  String get tutorialStepMandatoryCaptureDescLosing =>
      'Tout comme aux dames ordinaires, les captures sont obligatoires. Vous devez donner vos pièces si vous en avez l\'occasion !';

  @override
  String get tutorialStepTrapTitle => 'Tendre un piège';

  @override
  String get tutorialStepTrapDesc =>
      'Une stratégie courante consiste à forcer votre adversaire dans une position où il doit effectuer une longue séquence de capture, prenant plusieurs de vos pièces.';

  @override
  String get tutorialStepFallingIntoTrapTitle => 'Tomber dans le piège';

  @override
  String get tutorialStepFallingIntoTrapDesc =>
      'Le joueur noir est maintenant obligé de capturer la pièce blanche, ce qui est exactement ce que voulait le Blanc.';

  @override
  String get tutorialStepLosingEndgameTitle => 'Fin de partie';

  @override
  String get tutorialStepLosingEndgameDesc =>
      'La partie se termine lorsqu\'un joueur n\'a plus de pièces sur le plateau, ou ne peut plus bouger. Ce joueur est le gagnant ! Ici, le Noir a gagné car il n\'a plus de pièces.';

  @override
  String get tutorialStepDrawDescLosing =>
      'Les nullités sont rares mais peuvent se produire, par exemple, par triple répétition d\'une position.';

  @override
  String get tutorialStepWelcomeDescRussian =>
      'Bienvenue aux Dames russes (Shashki) ! Elles ont une règle de promotion unique.';

  @override
  String get tutorialStepManCaptureBackwardTitle =>
      'Capture en arrière par les hommes';

  @override
  String get tutorialStepManCaptureBackwardDesc =>
      'Comme aux Dames internationales, les hommes se déplacent vers l\'avant mais peuvent capturer à la fois vers l\'avant et vers l\'arrière.';

  @override
  String get tutorialStepPromotionDescRussian =>
      'Lorsqu\'un homme atteint la dernière rangée de l\'adversaire par un mouvement sans capture, il est promu roi et le tour se termine.';

  @override
  String get tutorialStepPromotionRuleTitle => 'Règle de promotion spéciale';

  @override
  String get tutorialStepPromotionRuleDescRussian =>
      'LA RÈGLE CLÉ : Si un homme atteint la rangée de promotion via une capture, il devient immédiatement un roi et DOIT continuer à capturer dans le même tour si possible.';

  @override
  String get tutorialStepDrawDescRussian =>
      'Une partie peut être nulle par triple répétition ou si aucune capture n\'est effectuée pendant 15 coups alors qu\'il n\'y a que des rois sur le plateau.';

  @override
  String get tutorialStepWelcomeDescSpanish =>
      'Bienvenue aux Dames espagnoles ! Cette variante combine les règles des Dames anglaises et internationales.';

  @override
  String get tutorialStepManMoveDescSpanish =>
      'Les hommes se déplacent et capturent en diagonale vers l\'avant uniquement, tout comme aux Dames anglaises.';

  @override
  String get tutorialStepMandatoryCaptureTitle => 'Capture obligatoire';

  @override
  String get tutorialStepMandatoryCaptureDescSpanish =>
      'Les captures sont obligatoires. S\'il existe plusieurs options de capture, vous devez en choisir une ; il n\'y a pas de règle de « capture maximale » pour les hommes.';

  @override
  String get tutorialStepPromotionDescSpanish =>
      'Lorsqu\'un homme atteint la rangée la plus éloignée, il est promu roi. Le tour se termine lors de la promotion.';

  @override
  String get tutorialStepKingMoveDescSpanish =>
      'Les rois sont « volants », ce qui signifie qu\'ils peuvent se déplacer et capturer sur plusieurs cases, tout comme aux Dames internationales.';

  @override
  String get tutorialStepDrawDescSpanish =>
      'Une partie peut être nulle par triple répétition ou si aucun mouvement significatif (captures ou mouvements d\'hommes) n\'est effectué pendant 50 coups.';

  @override
  String get tutorialStepManMoveTitle => 'Mouvement de l\'homme';

  @override
  String get tutorialStepKingMoveTitle => 'Mouvement du roi';

  @override
  String get tutorialStepManCaptureTitle => 'Capture de l\'homme';

  @override
  String get categoryClassicNatural => 'Classique & Naturel';

  @override
  String get categoryCulturalHistorical => 'Culturel & Historique';

  @override
  String get categoryFantasySciFi => 'Fantaisie & Science-Fiction';

  @override
  String get categoryLuxuryArtistic => 'Luxe & Artistique';

  @override
  String get categoryModernMinimalist => 'Moderne & Minimaliste';

  @override
  String get categoryFunColorful => 'Amusant & Coloré';

  @override
  String get themeBoardClassicWood => 'Bois classique';

  @override
  String get themeBoardMarble => 'Marbre';

  @override
  String get themeBoardGreenVelvet => 'Velours vert';

  @override
  String get themeBoardOceanBlue => 'Bleu océan';

  @override
  String get themeBoardAutumn => 'Automne';

  @override
  String get themeBoardGranite => 'Granit';

  @override
  String get themeBoardWinterForest => 'Forêt d\'hiver';

  @override
  String get themeBoardRiverStone => 'Pierre de rivière';

  @override
  String get themeBoardOttomanTile => 'Carreau ottoman';

  @override
  String get themeBoardEgyptianPapyrus => 'Papyrus égyptien';

  @override
  String get themeBoardRomanMosaic => 'Mosaïque romaine';

  @override
  String get themeBoardJapaneseSakura => 'Sakura japonais';

  @override
  String get themeBoardScandinavianRune => 'Rune scandinave';

  @override
  String get themeBoardAztecSunStone => 'Pierre du soleil aztèque';

  @override
  String get themeBoardCelticKnot => 'Nœud celtique';

  @override
  String get themeBoardVictorian => 'Victorien';

  @override
  String get themeBoardGalaxy => 'Galaxie';

  @override
  String get themeBoardEnchantedForest => 'Forêt enchantée';

  @override
  String get themeBoardHellfire => 'Feu de l\'enfer';

  @override
  String get themeBoardGlacierKingdom => 'Royaume des glaciers';

  @override
  String get themeBoardCyberCircuit => 'Circuit cybernétique';

  @override
  String get themeBoardSteampunk => 'Steampunk';

  @override
  String get themeBoardAtlantis => 'Atlantide';

  @override
  String get themeBoardCanadaSpace => 'Espace Canada';

  @override
  String get themeBoardBlackGold => 'Noir & Or';

  @override
  String get themeBoardRubyEmerald => 'Rubis & Émeraude';

  @override
  String get themeBoardArtDeco => 'Art déco';

  @override
  String get themeBoardRoyalVelvet => 'Velours royal';

  @override
  String get themeBoardPorcelain => 'Porcelaine';

  @override
  String get themeBoardStainedGlass => 'Vitrail';

  @override
  String get themeBoardPearl => 'Perle';

  @override
  String get themeBoardBrushStrokes => 'Coups de pinceau';

  @override
  String get themeBoardMatteBlack => 'Noir mat';

  @override
  String get themeBoardConcreteSteel => 'Béton & Acier';

  @override
  String get themeBoardCarbonFiber => 'Fibre de carbone';

  @override
  String get themeBoardGlass => 'Verre';

  @override
  String get themeBoardPaper => 'Papier';

  @override
  String get themeBoardDigitalPixel => 'Pixel numérique';

  @override
  String get themeBoardPastelGeometry => 'Géométrie pastel';

  @override
  String get themeBoardMonochromeGradient => 'Dégradé monochrome';

  @override
  String get themeBoardCandyLand => 'Pays des bonbons';

  @override
  String get themeBoardComicBook => 'Bande dessinée';

  @override
  String get themeBoard8BitRetro => 'Rétro 8 bits';

  @override
  String get themeBoardToyBlocks => 'Blocs de jouets';

  @override
  String get themeBoardRainbow => 'Arc-en-ciel';

  @override
  String get themeBoardGraffiti => 'Graffiti';

  @override
  String get themeBoardWatercolor => 'Aquarelle';

  @override
  String get themeBoardHoneycomb => 'Nid d\'abeille';

  @override
  String get themePieceCarvedWood => 'Bois sculpté';

  @override
  String get themePieceIvoryEbony => 'Ivoire & Ébène';

  @override
  String get themePiecePolishedPebble => 'Galet poli';

  @override
  String get themePieceEarthenware => 'Faïence';

  @override
  String get themePieceFrostedGlass => 'Verre dépoli';

  @override
  String get themePieceRedJasper => 'Jaspe rouge';

  @override
  String get themePieceBamboo => 'Bambou';

  @override
  String get themePieceAmber => 'Ambre';

  @override
  String get themePieceIznikTile => 'Carreau d\'Iznik';

  @override
  String get themePieceLapisLazuli => 'Lapis-lazuli';

  @override
  String get themePieceJade => 'Jade';

  @override
  String get themePieceAncientBronze => 'Bronze antique';

  @override
  String get themePieceObsidian => 'Obsidienne';

  @override
  String get themePieceParchment => 'Parchemin';

  @override
  String get themePieceTerracotta => 'Terre cuite';

  @override
  String get themePieceIronRune => 'Rune de fer';

  @override
  String get themePieceDragonScale => 'Écaille de dragon';

  @override
  String get themePieceCrystal => 'Cristal';

  @override
  String get themePieceNeonLights => 'Néons';

  @override
  String get themePieceGhost => 'Fantôme';

  @override
  String get themePieceVolcanicMagma => 'Magma volcanique';

  @override
  String get themePieceElvenMithril => 'Mithril elfique';

  @override
  String get themePieceOrcishIron => 'Fer orque';

  @override
  String get themePieceCosmicDust => 'Poussière cosmique';

  @override
  String get themePieceGoldSilver => 'Or & Argent';

  @override
  String get themePieceBlackPearl => 'Perle noire';

  @override
  String get themePieceMalachite => 'Malachite';

  @override
  String get themePieceVenetianGlass => 'Verre de Venise';

  @override
  String get themePieceGatsby => 'Gatsby';

  @override
  String get themePieceDiamond => 'Diamant';

  @override
  String get themePieceRuby => 'Rubis';

  @override
  String get themePieceSapphire => 'Saphir';

  @override
  String get themePieceModernMinimalist => 'Minimaliste moderne';

  @override
  String get themePieceRobotic => 'Robotique';

  @override
  String get themePieceMetallicGradient => 'Dégradé métallique';

  @override
  String get themePieceGlossyPlastic => 'Plastique brillant';

  @override
  String get themePieceHolographic => 'Holographique';

  @override
  String get themePieceMattePastel => 'Pastel mat';

  @override
  String get themePieceRubber => 'Caoutchouc';

  @override
  String get themePieceLightShadow => 'Lumière & Ombre';

  @override
  String get themePieceConfectionery => 'Confiserie';

  @override
  String get themePieceChocolate => 'Chocolat';

  @override
  String get themePieceFruitBasket => 'Corbeille de fruits';

  @override
  String get themePieceGummy => 'Gélifié';

  @override
  String get themePieceWatermelon => 'Pastèque';

  @override
  String get themePieceCosmonaut => 'Cosmonaute';

  @override
  String get themePieceSuperhero => 'Super-héros';

  @override
  String get themePieceSeashell => 'Coquillage';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageRussian => 'Russe';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languagePortuguese => 'Portugais';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageItalian => 'Italien';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get version => 'Version';

  @override
  String get aboutHeader => 'À PROPOS';

  @override
  String get noInternetConnection => 'Pas de connexion Internet';

  @override
  String get noInternetConnectionMessage =>
      'Veuillez vérifier votre connexion Internet et réessayer.';

  @override
  String get savedGameDialogTitle =>
      'Vous avez une partie sauvegardée. Que souhaitez-vous faire ?';

  @override
  String get deleteAction => 'Supprimer';
}
