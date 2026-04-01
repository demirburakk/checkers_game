// lib/utils/prewarming_service.dart

import 'dart:ui' as ui;
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/presentation/screens/main_menu_screen.dart';
import 'package:checkers_game/providers/rank_provider.dart';
import 'package:checkers_game/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// Centralized and independent service containing advanced methods for caching shaders and assets.
/// This service helps reduce UI "jank" (stuttering) by pre-loading resources before they are needed.
class PrewarmingService {
  // Private constructor to prevent instantiation.
  PrewarmingService._();

  /// Pre-compiles expensive shaders that might cause jank during the initial app interaction.
  /// 
  /// This method pushes a temporary [Offstage] route to trigger the Flutter engine
  /// to compile the shaders required by the widgets inside.
  static Future<void> prewarmShaders(BuildContext context) {
    // List of widgets to be pre-warmed.
    final widgetsToWarmup = <Widget>[
      // The blur effect (BackdropFilter) is a common source of shader compilation jank.
      BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(color: CupertinoColors.black.withAlpha(25)),
      ),

      // Pre-rendering the AI level selection dialog compiles the shaders used in its UI.
      const AiLevelSelectionDialog(gameMode: GameMode.turkish),
    ];

    // Triggers shader compilation by rendering the widgets once off-screen.
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, _, __) {
          // Immediately pop the route once it has been rendered.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          });
          
          return Offstage(
            offstage: true,
            // Provide necessary providers to the off-screen widgets to avoid errors.
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: context.read<RankProvider>()),
              ],
              child: Stack(children: widgetsToWarmup),
            ),
          );
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  /// Caches all image assets to be used in the application into the image cache.
  /// 
  /// This includes all board themes and piece themes across different game variants.
  static Future<void> precacheImages(BuildContext context) async {
    final themeProvider = context.read<ThemeProvider>();
    final allImageFutures = <Future>[];

    // Pre-cache board theme images for various board sizes.
    for (final boardTheme in themeProvider.boardThemes) {
      allImageFutures.add(precacheImage(AssetImage(themeProvider.getBoardAssetPath(boardTheme, 8)), context));
      allImageFutures.add(precacheImage(AssetImage(themeProvider.getBoardAssetPath(boardTheme, 10)), context));
    }

    // Pre-cache all piece theme images (color x type x theme combinations).
    for (final pieceTheme in themeProvider.allPieceThemes) {
      for (final color in PieceColor.values) {
        for (final type in PieceType.values) {
          allImageFutures.add(precacheImage(themeProvider.getPieceImageProvider(Piece(id: 'pre', color: color, type: type), pieceTheme), context));
        }
      }
    }

    // Wait for all image pre-caching operations to complete.
    await Future.wait(allImageFutures);
  }
}
