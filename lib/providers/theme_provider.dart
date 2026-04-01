// lib/providers/theme_provider.dart

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/models/theme_model.dart';

/// [ThemeProvider] manages the visual themes of the game, including board and piece styles.
/// It handles theme selection, persistence using SharedPreferences, and provides
/// theme-related assets and colors to the UI.
class ThemeProvider with ChangeNotifier {
  /// Instance of SharedPreferences for persisting user theme selections.
  late SharedPreferences _prefs;

  /// A comprehensive list of available board themes categorized by style.
  /// Each [BoardTheme] defines the colors and asset names for the game board.
  final List<BoardTheme> boardThemes = [
    BoardTheme(nameKey: 'themeBoardClassicWood', assetName: 'Klasik_Ahşap', category: 'Klasik & Doğal', lightSquareColor: const Color(0xFFF0D9B5), darkSquareColor: const Color(0xFFB58863)),
    BoardTheme(nameKey: 'themeBoardMarble', assetName: 'Mermer', category: 'Klasik & Doğal', lightSquareColor: const Color(0xFFE0E0E0), darkSquareColor: const Color(0xFF757575)),
    BoardTheme(nameKey: 'themeBoardGreenVelvet', assetName: 'Yeşil_Kadife', category: 'Klasik & Doğal', lightSquareColor: const Color(0xFFC8E6C9), darkSquareColor: const Color(0xFF388E3C)),
    BoardTheme(nameKey: 'themeBoardOceanBlue', assetName: 'Okyanus_Mavisi', category: 'Klasik & Doğal', lightSquareColor: const Color(0xFFB3E5FC), darkSquareColor: const Color(0xFF0277BD)),
    BoardTheme(nameKey: 'themeBoardAutumn', assetName: 'Sonbahar', category: 'Klasik & Doğal', lightSquareColor: const Color(0xFFFFE0B2), darkSquareColor: const Color(0xFFE65100)),
    BoardTheme(nameKey: 'themeBoardGranite', assetName: 'Granit', category: 'Klasik & Doğal', lightSquareColor: const Color(0xFFCFD8DC), darkSquareColor: const Color(0xFF546E7A)),
    BoardTheme(nameKey: 'themeBoardWinterForest', assetName: 'Kış_Ormanı', category: 'Klasik & Doğal', lightSquareColor: const Color(0xFFECEFF1), darkSquareColor: const Color(0xFF455A64)),
    BoardTheme(nameKey: 'themeBoardRiverStone', assetName: 'Nehir_Taşı', category: 'Klasik & Doğal', lightSquareColor: const Color(0xFFD7CCC8), darkSquareColor: const Color(0xFF6D4C41)),
    BoardTheme(nameKey: 'themeBoardOttomanTile', assetName: 'Osmanlı_Çinisi', category: 'Kültürel & Tarihi', lightSquareColor: const Color(0xFFE3F2FD), darkSquareColor: const Color(0xFF1565C0)),
    BoardTheme(nameKey: 'themeBoardEgyptianPapyrus', assetName: 'Mısır_Papirüsü', category: 'Kültürel & Tarihi', lightSquareColor: const Color(0xFFF5E8C5), darkSquareColor: const Color(0xFF4B6A7D)),
    BoardTheme(nameKey: 'themeBoardRomanMosaic', assetName: 'Roma_Mozaiği', category: 'Kültürel & Tarihi', lightSquareColor: const Color(0xFFFFF8E1), darkSquareColor: const Color(0xFF795548)),
    BoardTheme(nameKey: 'themeBoardJapaneseSakura', assetName: 'Japon_Sakura', category: 'Kültürel & Tarihi', lightSquareColor: const Color(0xFFFCE4EC), darkSquareColor: const Color(0xFFF06292)),
    BoardTheme(nameKey: 'themeBoardScandinavianRune', assetName: 'İskandinav_Rün', category: 'Kültürel & Tarihi', lightSquareColor: const Color(0xFFB0BEC5), darkSquareColor: const Color(0xFF37474F)),
    BoardTheme(nameKey: 'themeBoardAztecSunStone', assetName: 'Aztek_Güneş_Taşı', category: 'Kültürel & Tarihi', lightSquareColor: const Color(0xFFFFCC80), darkSquareColor: const Color(0xFFD84315)),
    BoardTheme(nameKey: 'themeBoardCelticKnot', assetName: 'Kelt_Düğümü', category: 'Kültürel & Tarihi', lightSquareColor: const Color(0xFFDCEED7), darkSquareColor: const Color(0xFF2E7D32)),
    BoardTheme(nameKey: 'themeBoardVictorian', assetName: 'Viktorya', category: 'Kültürel & Tarihi', lightSquareColor: const Color(0xFFFFF9C4), darkSquareColor: const Color(0xFF5D4037)),
    BoardTheme(nameKey: 'themeBoardGalaxy', assetName: 'Galaksi', category: 'Fantastik & Bilimkurgu', lightSquareColor: const Color(0xFF4A148C), darkSquareColor: const Color(0xFF000000)),
    BoardTheme(nameKey: 'themeBoardEnchantedForest', assetName: 'Büyülü_Orman', category: 'Fantastik & Bilimkurgu', lightSquareColor: const Color(0xFFD1C4E9), darkSquareColor: const Color(0xFF512DA8)),
    BoardTheme(nameKey: 'themeBoardHellfire', assetName: 'Cehennem_Ateşi', category: 'Fantastik & Bilimkurgu', lightSquareColor: const Color(0xFFFBE9E7), darkSquareColor: const Color(0xFFBF360C)),
    BoardTheme(nameKey: 'themeBoardGlacierKingdom', assetName: 'Buzul_Krallığı', category: 'Fantastik & Bilimkurgu', lightSquareColor: const Color(0xFFE0F7FA), darkSquareColor: const Color(0xFF4DD0E1)),
    BoardTheme(nameKey: 'themeBoardCyberCircuit', assetName: 'Siber_Devre', category: 'Fantastik & Bilimkurgu', lightSquareColor: const Color(0xFFE8F5E9), darkSquareColor: const Color(0xFF004D40)),
    BoardTheme(nameKey: 'themeBoardSteampunk', assetName: 'Steampunk', category: 'Fantastik & Bilimkurgu', lightSquareColor: const Color(0xFFEFEBE9), darkSquareColor: const Color(0xFF4E342E)),
    BoardTheme(nameKey: 'themeBoardAtlantis', assetName: 'Atlantis', category: 'Fantastik & Bilimkurgu', lightSquareColor: const Color(0xFFE0F2F1), darkSquareColor: const Color(0xFF00695C)),
    BoardTheme(nameKey: 'themeBoardCanadaSpace', assetName: 'Kanada_Uzayı', category: 'Fantastik & Bilimkurgu', lightSquareColor: const Color(0xFF311B92), darkSquareColor: const Color(0xFF000000)),
    BoardTheme(nameKey: 'themeBoardBlackGold', assetName: 'Siyah_Altın', category: 'Lüks & Sanatsal', lightSquareColor: const Color(0xFFCFB53B), darkSquareColor: const Color(0xFF121212)),
    BoardTheme(nameKey: 'themeBoardRubyEmerald', assetName: 'Yakut_and_Zümrüt', category: 'Lüks & Sanatsal', lightSquareColor: const Color(0xFFF1F8E9), darkSquareColor: const Color(0xFF880E4F)),
    BoardTheme(nameKey: 'themeBoardArtDeco', assetName: 'Art_Deco', category: 'Lüks & Sanatsal', lightSquareColor: const Color(0xFFEAEAEA), darkSquareColor: const Color(0xFF212121)),
    BoardTheme(nameKey: 'themeBoardRoyalVelvet', assetName: 'Kraliyet_Kadifesi', category: 'Lüks & Sanatsal', lightSquareColor: const Color(0xFFEDE7F6), darkSquareColor: const Color(0xFF4527A0)),
    BoardTheme(nameKey: 'themeBoardPorcelain', assetName: 'Porselen', category: 'Lüks & Sanatsal', lightSquareColor: const Color(0xFFFFFFFF), darkSquareColor: const Color(0xFF0D47A1)),
    BoardTheme(nameKey: 'themeBoardStainedGlass', assetName: 'Vitray', category: 'Lüks & Sanatsal', lightSquareColor: const Color(0xFFE1F5FE), darkSquareColor: const Color(0xFF1A237E)),
    BoardTheme(nameKey: 'themeBoardPearl', assetName: 'İnci', category: 'Lüks & Sanatsal', lightSquareColor: const Color(0xFFF5F5F5), darkSquareColor: const Color(0xFFE0E0E0)),
    BoardTheme(nameKey: 'themeBoardBrushStrokes', assetName: 'Fırça_Darbeleri', category: 'Lüks & Sanatsal', lightSquareColor: const Color(0xFFFAFAFA), darkSquareColor: const Color(0xFF757575)),
    BoardTheme(nameKey: 'themeBoardMatteBlack', assetName: 'Mat_Siyah', category: 'Modern & Minimalist', lightSquareColor: const Color(0xFF424242), darkSquareColor: const Color(0xFF111111)),
    BoardTheme(nameKey: 'themeBoardConcreteSteel', assetName: 'Beton_and_Çelik', category: 'Modern & Minimalist', lightSquareColor: const Color(0xFFEEEEEE), darkSquareColor: const Color(0xFF9E9E9E)),
    BoardTheme(nameKey: 'themeBoardCarbonFiber', assetName: 'Karbon_Fiber', category: 'Modern & Minimalist', lightSquareColor: const Color(0xFF616161), darkSquareColor: const Color(0xFF212121)),
    BoardTheme(nameKey: 'themeBoardGlass', assetName: 'Cam', category: 'Modern & Minimalist', lightSquareColor: const Color(0xFFE8EAF6), darkSquareColor: const Color(0xFFC5CAE9)),
    BoardTheme(nameKey: 'themeBoardPaper', assetName: 'Kağıt', category: 'Modern & Minimalist', lightSquareColor: const Color(0xFFFFFFFF), darkSquareColor: const Color(0xFFF5F5F5)),
    BoardTheme(nameKey: 'themeBoardDigitalPixel', assetName: 'Dijital_Piksel', category: 'Modern & Minimalist', lightSquareColor: const Color(0xFFB2EBF2), darkSquareColor: const Color(0xFF00BCD4)),
    BoardTheme(nameKey: 'themeBoardPastelGeometry', assetName: 'Pastel_Geometri', category: 'Modern & Minimalist', lightSquareColor: const Color(0xFFF3E5F5), darkSquareColor: const Color(0xFFE1BEE7)),
    BoardTheme(nameKey: 'themeBoardMonochromeGradient', assetName: 'Tek_Renk_Gradyan', category: 'Modern & Minimalist', lightSquareColor: const Color(0xFFC8E6C9), darkSquareColor: const Color(0xFF81C784)),
    BoardTheme(nameKey: 'themeBoardCandyLand', assetName: 'Şeker_Diyarı', category: 'Eğlenceli & Renkli', lightSquareColor: const Color(0xFFF8BBD0), darkSquareColor: const Color(0xFFEC407A)),
    BoardTheme(nameKey: 'themeBoardComicBook', assetName: 'Çizgi_Roman', category: 'Eğlenceli & Renkli', lightSquareColor: const Color(0xFFFFF176), darkSquareColor: const Color(0xFFF57F17)),
    BoardTheme(nameKey: 'themeBoard8BitRetro', assetName: '8-Bit_Retro', category: 'Eğlenceli & Renkli', lightSquareColor: const Color(0xFFB3E5FC), darkSquareColor: const Color(0xFF03A9F4)),
    BoardTheme(nameKey: 'themeBoardToyBlocks', assetName: 'Oyuncak_Bloklar', category: 'Eğlenceli & Renkli', lightSquareColor: const Color(0xFFFFE082), darkSquareColor: const Color(0xFFF44336)),
    BoardTheme(nameKey: 'themeBoardRainbow', assetName: 'Gökkuşağı', category: 'Eğlenceli & Renkli', lightSquareColor: const Color(0xFFE1F5FE), darkSquareColor: const Color(0xFFE57373)),
    BoardTheme(nameKey: 'themeBoardGraffiti', assetName: 'Graffiti', category: 'Eğlenceli & Renkli', lightSquareColor: const Color(0xFFE0E0E0), darkSquareColor: const Color(0xFF7B1FA2)),
    BoardTheme(nameKey: 'themeBoardWatercolor', assetName: 'Suluboya', category: 'Eğlenceli & Renkli', lightSquareColor: const Color(0xFFE0F7FA), darkSquareColor: const Color(0xFF009688)),
    BoardTheme(nameKey: 'themeBoardHoneycomb', assetName: 'Bal_Peteği', category: 'Eğlenceli & Renkli', lightSquareColor: const Color(0xFFFFF59D), darkSquareColor: const Color(0xFFFFB300)),
  ];

  /// A list of available piece themes categorized by style.
  /// Each [PieceTheme] defines the visual appearance of the game pieces,
  /// including gradients and border colors for both players.
  final List<PieceTheme> allPieceThemes = [
    PieceTheme(nameKey: 'themePieceCarvedWood', assetName: 'Oymalı_Ahşap', category: 'Klasik & Doğal', player1Gradient: [const Color(0xFFE3C49F), const Color(0xFFC19A6B)], player1BorderColor: const Color(0xFF6B4F35), player2Gradient: [const Color(0xFF5A3825), const Color(0xFF4B2E1F)], player2BorderColor: const Color(0xFF3A2419)),
    PieceTheme(nameKey: 'themePieceIvoryEbony', assetName: 'Fildişi_and_Abanoz', category: 'Klasik & Doğal', player1Gradient: [const Color(0xFFFFF9E8), const Color(0xFFEFE8D8)], player1BorderColor: const Color(0xFFA89F91), player2Gradient: [const Color(0xFF2C2C2C), const Color(0xFF1A1A1A)], player2BorderColor: const Color(0xFF454545)),
    PieceTheme(nameKey: 'themePiecePolishedPebble', assetName: 'Parlak_Çakıl', category: 'Klasik & Doğal', player1Gradient: [const Color(0xFFFAFAFA), const Color(0xFFE0E0E0)], player1BorderColor: const Color(0xFF9E9E9E), player2Gradient: [const Color(0xFF546E7A), const Color(0xFF37474F)], player2BorderColor: const Color(0xFF263238)),
    PieceTheme(nameKey: 'themePieceEarthenware', assetName: 'Toprak_Pota', category: 'Klasik & Doğal', player1Gradient: [const Color(0xFFFBE9E7), const Color(0xFFFFCCBC)], player1BorderColor: const Color(0xFFE64A19), player2Gradient: [const Color(0xFF8D6E63), const Color(0xFF5D4037)], player2BorderColor: const Color(0xFF3E2723)),
    PieceTheme(nameKey: 'themePieceFrostedGlass', assetName: 'Buzlu_Cam', category: 'Klasik & Doğal', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFE1F5FE)], player1BorderColor: const Color(0xFFB3E5FC), player2Gradient: [const Color(0xFFCFD8DC), const Color(0xFF90A4AE)], player2BorderColor: const Color(0xFF546E7A)),
    PieceTheme(nameKey: 'themePieceRedJasper', assetName: 'Kırmızı_Jasper', category: 'Klasik & Doğal', player1Gradient: [const Color(0xFFF1F8E9), const Color(0xFFDCEDC8)], player1BorderColor: const Color(0xFF9CCC65), player2Gradient: [const Color(0xFFD32F2F), const Color(0xFFB71C1C)], player2BorderColor: const Color(0xFF7F0000)),
    PieceTheme(nameKey: 'themePieceBamboo', assetName: 'Bambu', category: 'Klasik & Doğal', player1Gradient: [const Color(0xFFF1F8E9), const Color(0xFFDCEDC8)], player1BorderColor: const Color(0xFF8BC34A), player2Gradient: [const Color(0xFFC8E6C9), const Color(0xFFA5D6A7)], player2BorderColor: const Color(0xFF4CAF50)),
    PieceTheme(nameKey: 'themePieceAmber', assetName: 'Kehribar', category: 'Klasik & Doğal', player1Gradient: [const Color(0xFFFFF3E0), const Color(0xFFFFE0B2)], player1BorderColor: const Color(0xFFFF9800), player2Gradient: [const Color(0xFFFFB74D), const Color(0xFFFB8C00)], player2BorderColor: const Color(0xFFE65100)),
    PieceTheme(nameKey: 'themePieceIznikTile', assetName: 'İznik_Çinisi', category: 'Kültürel & Tarihi', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFE3F2FD)], player1BorderColor: const Color(0xFF90CAF9), player2Gradient: [const Color(0xFF1976D2), const Color(0xFF0D47A1)], player2BorderColor: const Color(0xFF002171)),
    PieceTheme(nameKey: 'themePieceLapisLazuli', assetName: 'Lapis_Lazuli', category: 'Kültürel & Tarihi', player1Gradient: [const Color(0xFFFFFDE7), const Color(0xFFFFF59D)], player1BorderColor: const Color(0xFFFBC02D), player2Gradient: [const Color(0xFF1A237E), const Color(0xFF000051)], player2BorderColor: const Color(0xFF283593)),
    PieceTheme(nameKey: 'themePieceJade', assetName: 'Yeşim_Taşı', category: 'Kültürel & Tarihi', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFF1F8E9)], player1BorderColor: const Color(0xFFC5E1A5), player2Gradient: [const Color(0xFF33691E), const Color(0xFF1B5E20)], player2BorderColor: const Color(0xFF003300)),
    PieceTheme(nameKey: 'themePieceAncientBronze', assetName: 'Antik_Bronz', category: 'Kültürel & Tarihi', player1Gradient: [const Color(0xFFCFD8DC), const Color(0xFFB0BEC5)], player1BorderColor: const Color(0xFF78909C), player2Gradient: [const Color(0xFF8C6D46), const Color(0xFF5E493B)], player2BorderColor: const Color(0xFF3E2723)),
    PieceTheme(nameKey: 'themePieceObsidian', assetName: 'Obsidyen', category: 'Kültürel & Tarihi', player1Gradient: [const Color(0xFFF5F5F5), const Color(0xFFE0E0E0)], player1BorderColor: const Color(0xFFBDBDBD), player2Gradient: [const Color(0xFF212121), const Color(0xFF000000)], player2BorderColor: const Color(0xFF313131)),
    PieceTheme(nameKey: 'themePieceParchment', assetName: 'Parşömen', category: 'Kültürel & Tarihi', player1Gradient: [const Color(0xFFFFF9C4), const Color(0xFFFFF59D)], player1BorderColor: const Color(0xFFFBC02D), player2Gradient: [const Color(0xFF5D4037), const Color(0xFF3E2723)], player2BorderColor: const Color(0xFF2A1A17)),
    PieceTheme(nameKey: 'themePieceTerracotta', assetName: 'Terrakotta', category: 'Kültürel & Tarihi', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFE0E0E0)], player1BorderColor: const Color(0xFFBDBDBD), player2Gradient: [const Color(0xFFE57373), const Color(0xFFD32F2F)], player2BorderColor: const Color(0xFFB71C1C)),
    PieceTheme(nameKey: 'themePieceIronRune', assetName: 'Demir_Rün', category: 'Kültürel & Tarihi', player1Gradient: [const Color(0xFFB0BEC5), const Color(0xFF78909C)], player1BorderColor: const Color(0xFF455A64), player2Gradient: [const Color(0xFF424242), const Color(0xFF212121)], player2BorderColor: const Color(0xFF101010)),
    PieceTheme(nameKey: 'themePieceDragonScale', assetName: 'Ejderha_Pulu', category: 'Fantastik & Bilimkurgu', player1Gradient: [const Color(0xFFD32F2F), const Color(0xFFC62828)], player1BorderColor: const Color(0xFFB71C1C), player2Gradient: [const Color(0xFF1976D2), const Color(0xFF1565C0)], player2BorderColor: const Color(0xFF0D47A1)),
    PieceTheme(nameKey: 'themePieceCrystal', assetName: 'Kristal', category: 'Fantastik & Bilimkurgu', player1Gradient: [const Color(0xFF90F0FF), const Color(0xFF65B8D8)], player1BorderColor: const Color(0xFF8DEBFF), player2Gradient: [const Color(0xFFF4A8FF), const Color(0xFFD475E9)], player2BorderColor: const Color(0xFFFFD4FD)),
    PieceTheme(nameKey: 'themePieceNeonLights', assetName: 'Neon_Işıkları', category: 'Fantastik & Bilimkurgu', player1Gradient: [const Color(0xFF00FFFF), const Color(0xFF00BFFF)], player1BorderColor: const Color(0xFFFFFFFF), player2Gradient: [const Color(0xFFFF00FF), const Color(0xFFBF00BF)], player2BorderColor: const Color(0xFFFFFFFF)),
    PieceTheme(nameKey: 'themePieceGhost', assetName: 'Hayalet', category: 'Fantastik & Bilimkurgu', player1Gradient: [const Color(0xAAFFFFFF), const Color(0xAAE0F7FA)], player1BorderColor: const Color(0xCCFFFFFF), player2Gradient: [const Color(0xAAB0BEC5), const Color(0xAA90A4AE)], player2BorderColor: const Color(0xCCCFD8DC)),
    PieceTheme(nameKey: 'themePieceVolcanicMagma', assetName: 'Volkanik_Magma', category: 'Fantastik & Bilimkurgu', player1Gradient: [const Color(0xFFFFC947), const Color(0xFFE16428)], player1BorderColor: const Color(0xFFA53B0B), player2Gradient: [const Color(0xFF2E3138), const Color(0xFF1B1D21)], player2BorderColor: const Color(0xFF484B52)),
    PieceTheme(nameKey: 'themePieceElvenMithril', assetName: 'Elf_Mithrili', category: 'Fantastik & Bilimkurgu', player1Gradient: [const Color(0xFFE8EAF6), const Color(0xFFC5CAE9)], player1BorderColor: const Color(0xFF9FA8DA), player2Gradient: [const Color(0xFFC8E6C9), const Color(0xFFA5D6A7)], player2BorderColor: const Color(0xFF81C784)),
    PieceTheme(nameKey: 'themePieceOrcishIron', assetName: 'Ork_Demiri', category: 'Fantastik & Bilimkurgu', player1Gradient: [const Color(0xFFBCAAA4), const Color(0xFF8D6E63)], player1BorderColor: const Color(0xFF5D4037), player2Gradient: [const Color(0xFF4CAF50), const Color(0xFF388E3C)], player2BorderColor: const Color(0xFF1B5E20)),
    PieceTheme(nameKey: 'themePieceCosmicDust', assetName: 'Kozmik_Toz', category: 'Fantastik & Bilimkurgu', player1Gradient: [const Color(0xFFEDE7F6), const Color(0xFFD1C4E9)], player1BorderColor: const Color(0xFFB39DDB), player2Gradient: [const Color(0xFF4A148C), const Color(0xFF311B92)], player2BorderColor: const Color(0xFF1A237E)),
    PieceTheme(nameKey: 'themePieceGoldSilver', assetName: 'Altın_and_Gümüş', category: 'Lüks & Sanatsal', player1Gradient: [const Color(0xFFCFD8DC), const Color(0xFFB0BEC5)], player1BorderColor: const Color(0xFF90A4AE), player2Gradient: [const Color(0xFFFFD54F), const Color(0xFFFFB300)], player2BorderColor: const Color(0xFFE65100)),
    PieceTheme(nameKey: 'themePieceBlackPearl', assetName: 'Siyah_İnci', category: 'Lüks & Sanatsal', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFF5F5F5)], player1BorderColor: const Color(0xFFEEEEEE), player2Gradient: [const Color(0xFF424242), const Color(0xFF212121)], player2BorderColor: const Color(0xFF000000)),
    PieceTheme(nameKey: 'themePieceMalachite', assetName: 'Malahit', category: 'Lüks & Sanatsal', player1Gradient: [const Color(0xFFFFF9C4), const Color(0xFFFFF176)], player1BorderColor: const Color(0xFFFDD835), player2Gradient: [const Color(0xFF1B5E20), const Color(0xFF003300)], player2BorderColor: const Color(0xFF2E7D32)),
    PieceTheme(nameKey: 'themePieceVenetianGlass', assetName: 'Venedik_Camı', category: 'Lüks & Sanatsal', player1Gradient: [const Color(0xFFFCE4EC), const Color(0xFFF8BBD0)], player1BorderColor: const Color(0xFFF48FB1), player2Gradient: [const Color(0xFFE91E63), const Color(0xFFC2185B)], player2BorderColor: const Color(0xFF880E4F)),
    PieceTheme(nameKey: 'themePieceGatsby', assetName: 'Gatsby', category: 'Lüks & Sanatsal', player1Gradient: [const Color(0xFFF7F2E2), const Color(0xFFE8D7A8)], player1BorderColor: const Color(0xFFD4AF37), player2Gradient: [const Color(0xFF212121), const Color(0xFF0A0A0A)], player2BorderColor: const Color(0xFF3D3D3D)),
    PieceTheme(nameKey: 'themePieceDiamond', assetName: 'Elmas', category: 'Lüks & Sanatsal', player1Gradient: [const Color(0xFFE1F5FE), const Color(0xFFB3E5FC)], player1BorderColor: const Color(0xFF81D4FA), player2Gradient: [const Color(0xFFF1E6FF), const Color(0xFFD0BCFF)], player2BorderColor: const Color(0xFFB388FF)),
    PieceTheme(nameKey: 'themePieceRuby', assetName: 'Yakut', category: 'Lüks & Sanatsal', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFEEEEEE)], player1BorderColor: const Color(0xFFE0E0E0), player2Gradient: [const Color(0xFFE53935), const Color(0xFFB71C1C)], player2BorderColor: const Color(0xFF7F0000)),
    PieceTheme(nameKey: 'themePieceSapphire', assetName: 'Safir', category: 'Lüks & Sanatsal', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFEEEEEE)], player1BorderColor: const Color(0xFFE0E0E0), player2Gradient: [const Color(0xFF1976D2), const Color(0xFF0D47A1)], player2BorderColor: const Color(0xFF002171)),
    PieceTheme(nameKey: 'themePieceModernMinimalist', assetName: 'Modern_Minimalist', category: 'Modern & Minimalist', player1Gradient: [const Color(0xFFF5F5F5), const Color(0xFFE0E0E0)], player1BorderColor: const Color(0xFFBDBDBD), player2Gradient: [const Color(0xFF303030), const Color(0xFF212121)], player2BorderColor: const Color(0xFF424242)),
    PieceTheme(nameKey: 'themePieceRobotic', assetName: 'Robotik', category: 'Modern & Minimalist', player1Gradient: [const Color(0xFFCFD8DC), const Color(0xFFB0BEC5)], player1BorderColor: const Color(0xFF90A4AE), player2Gradient: [const Color(0xFF424242), const Color(0xFF303030)], player2BorderColor: const Color(0xFF616161)),
    PieceTheme(nameKey: 'themePieceMetallicGradient', assetName: 'Metalik_Gradyan', category: 'Modern & Minimalist', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFE0E0E0)], player1BorderColor: const Color(0xFFBDBDBD), player2Gradient: [const Color(0xFF81C784), const Color(0xFF4CAF50)], player2BorderColor: const Color(0xFF2E7D32)),
    PieceTheme(nameKey: 'themePieceGlossyPlastic', assetName: 'Parlak_Plastik', category: 'Modern & Minimalist', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFF5F5F5)], player1BorderColor: const Color(0xFFEEEEEE), player2Gradient: [const Color(0xFF03A9F4), const Color(0xFF0288D1)], player2BorderColor: const Color(0xFF01579B)),
    PieceTheme(nameKey: 'themePieceHolographic', assetName: 'Holografik', category: 'Modern & Minimalist', player1Gradient: [const Color(0xFFE0F7FA), const Color(0xFFB2EBF2)], player1BorderColor: const Color(0xFF80DEEA), player2Gradient: [const Color(0xFFF3E5F5), const Color(0xFFE1BEE7)], player2BorderColor: const Color(0xFFCE93D8)),
    PieceTheme(nameKey: 'themePieceMattePastel', assetName: 'Mat_Pastel', category: 'Modern & Minimalist', player1Gradient: [const Color(0xFFC5CAE9), const Color(0xFF9FA8DA)], player1BorderColor: const Color(0xFF7986CB), player2Gradient: [const Color(0xFFF8BBD0), const Color(0xFFF48FB1)], player2BorderColor: const Color(0xFFF06292)),
    PieceTheme(nameKey: 'themePieceRubber', assetName: 'Kauçuk', category: 'Modern & Minimalist', player1Gradient: [const Color(0xFFFAFAFA), const Color(0xFFF5F5F5)], player1BorderColor: const Color(0xFFE0E0E0), player2Gradient: [const Color(0xFF263238), const Color(0xFF102027)], player2BorderColor: const Color(0xFF000A12)),
    PieceTheme(nameKey: 'themePieceLightShadow', assetName: 'Işık_and_Gölge', category: 'Modern & Minimalist', player1Gradient: [const Color(0xFFFFFFFF), const Color(0xFFE0E0E0)], player1BorderColor: const Color(0xFFBDBDBD), player2Gradient: [const Color(0xFF212121), const Color(0xFF000000)], player2BorderColor: const Color(0xFF333333)),
    PieceTheme(nameKey: 'themePieceConfectionery', assetName: 'Şekerleme', category: 'Eğlenceli & Renkli', player1Gradient: [const Color(0xFFFCE4EC), const Color(0xFFF8BBD0)], player1BorderColor: const Color(0xFFF48FB1), player2Gradient: [const Color(0xFFE1F5FE), const Color(0xFFB3E5FC)], player2BorderColor: const Color(0xFF81D4FA)),
    PieceTheme(nameKey: 'themePieceChocolate', assetName: 'Çikolata', category: 'Eğlenceli & Renkli', player1Gradient: [const Color(0xFFFCF0E3), const Color(0xFFEAE0D6)], player1BorderColor: const Color(0xFFD3C5B9), player2Gradient: [const Color(0xFF7B3F00), const Color(0xFF633200)], player2BorderColor: const Color(0xFF4F2800)),
    PieceTheme(nameKey: 'themePieceFruitBasket', assetName: 'Meyve_Sepeti', category: 'Eğlenceli & Renkli', player1Gradient: [const Color(0xFFFFEB3B), const Color(0xFFFDD835)], player1BorderColor: const Color(0xFFFBC02D), player2Gradient: [const Color(0xFFF44336), const Color(0xFFE53935)], player2BorderColor: const Color(0xFFD32F2F)),
    PieceTheme(nameKey: 'themePieceGummy', assetName: 'Jelibon', category: 'Eğlenceli & Renkli', player1Gradient: [const Color(0xFFC8E6C9), const Color(0xFFA5D6A7)], player1BorderColor: const Color(0xFF81C784), player2Gradient: [const Color(0xFFBBDEFB), const Color(0xFF90CAF9)], player2BorderColor: const Color(0xFF64B5F6)),
    PieceTheme(nameKey: 'themePieceWatermelon', assetName: 'Karpuz', category: 'Eğlenceli & Renkli', player1Gradient: [const Color(0xFFFCE4EC), const Color(0xFFF8BBD0)], player1BorderColor: const Color(0xFFF48FB1), player2Gradient: [const Color(0xFFC8E6C9), const Color(0xFF81C784)], player2BorderColor: const Color(0xFF4CAF50)),
    PieceTheme(nameKey: 'themePieceCosmonaut', assetName: 'Kozmonot', category: 'Eğlenceli & Renkli', player1Gradient: [const Color(0xFFFAFAFA), const Color(0xFFF5F5F5)], player1BorderColor: const Color(0xFFE0E0E0), player2Gradient: [const Color(0xFF4FC3F7), const Color(0xFF03A9F4)], player2BorderColor: const Color(0xFF0277BD)),
    PieceTheme(nameKey: 'themePieceSuperhero', assetName: 'Süper_Kahraman', category: 'Eğlenceli & Renkli', player1Gradient: [const Color(0xFFE53935), const Color(0xFFC62828)], player1BorderColor: const Color(0xFFB71C1C), player2Gradient: [const Color(0xFF1565C0), const Color(0xFF0D47A1)], player2BorderColor: const Color(0xFF002171)),
    PieceTheme(nameKey: 'themePieceSeashell', assetName: 'Deniz_Kabuğu', category: 'Eğlenceli & Renkli', player1Gradient: [const Color(0xFFFFF3E0), const Color(0xFFFFE0B2)], player1BorderColor: const Color(0xFFFFCC80), player2Gradient: [const Color(0xFFE0F2F1), const Color(0xFFB2DFDB)], player2BorderColor: const Color(0xFF80CBC4)),
  ];

  /// The currently selected board theme.
  late BoardTheme _selectedBoardTheme;

  /// The currently selected piece theme.
  late PieceTheme _selectedPieceTheme;

  /// Initializes the [ThemeProvider] with default themes.
  ThemeProvider() {
    _selectedBoardTheme = boardThemes.first;
    _selectedPieceTheme = allPieceThemes.first;
  }

  /// Initializes SharedPreferences and loads saved theme selections.
  /// If no saved themes are found, it defaults to the first available themes.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final boardThemeKey = _prefs.getString('boardThemeNameKey') ?? boardThemes.first.nameKey;
    final pieceThemeKey = _prefs.getString('pieceThemeNameKey') ?? allPieceThemes.first.nameKey;
    _selectedBoardTheme = boardThemes.firstWhere((t) => t.nameKey == boardThemeKey, orElse: () => boardThemes.first);
    _selectedPieceTheme = allPieceThemes.firstWhere((t) => t.nameKey == pieceThemeKey, orElse: () => allPieceThemes.first);
  }

  /// Returns the currently selected board theme.
  BoardTheme get selectedBoardTheme => _selectedBoardTheme;

  /// Returns the currently selected piece theme.
  PieceTheme get selectedPieceTheme => _selectedPieceTheme;

  /// Returns a unique list of categories available across all board themes.
  List<String> get categories => boardThemes.map((t) => t.category).toSet().toList();

  /// Filters and returns board themes belonging to a specific category.
  List<BoardTheme> getBoardThemesByCategory(String category) => boardThemes.where((theme) => theme.category == category).toList();

  /// Filters and returns piece themes belonging to a specific category.
  List<PieceTheme> getPieceThemesByCategory(String category) => allPieceThemes.where((theme) => theme.category == category).toList();

  /// Constructs the asset path for a board image based on theme and board size.
  String getBoardAssetPath(BoardTheme theme, int boardSize) {
    return 'assets/boards/${theme.assetName}_${boardSize}x$boardSize.png';
  }

  /// Returns an [ImageProvider] for a specific piece based on its color, type, and current theme.
  ImageProvider getPieceImageProvider(Piece piece, PieceTheme theme) {
    final path = 'assets/pieces/${theme.assetName}_${piece.color.name}_${piece.type.name}.png';
    return AssetImage(path);
  }

  /// Updates the selected board theme and persists the choice.
  void setBoardTheme(BoardTheme theme) {
    if (_selectedBoardTheme.nameKey == theme.nameKey) return;
    _selectedBoardTheme = theme;
    _saveTheme();
    notifyListeners();
  }

  /// Updates the selected piece theme and persists the choice.
  void setPieceTheme(PieceTheme theme) {
    if (_selectedPieceTheme.nameKey == theme.nameKey) return;
    _selectedPieceTheme = theme;
    _saveTheme();
    notifyListeners();
  }

  /// Persists the current theme selections to SharedPreferences.
  Future<void> _saveTheme() async {
    await _prefs.setString('boardThemeNameKey', _selectedBoardTheme.nameKey);
    await _prefs.setString('pieceThemeNameKey', _selectedPieceTheme.nameKey);
  }
}