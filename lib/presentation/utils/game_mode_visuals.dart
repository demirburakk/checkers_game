// lib/presentation/utils/game_mode_visuals.dart

import 'package:flutter/cupertino.dart';
import 'package:checkers_game/domain/models/game_mode.dart';

/// Represents the visual style of a game mode, including its theme colors and icon.
class GameModeVisual {
  /// The list of colors used for the background gradient of the game mode's UI elements.
  final List<Color> gradientColors;

  /// The icon that represents this game mode.
  final IconData icon;

  GameModeVisual({required this.gradientColors, required this.icon});
}

/// A helper class to retrieve visual configurations for different [GameMode]s.
class GameModeVisualsHelper {
  /// Returns a [GameModeVisual] containing the theme colors and icon for the given [mode].
  static GameModeVisual getVisuals(GameMode mode) {
    switch (mode) {
      // Define gradient and the most suitable icon for each mode.
      case GameMode.turkish:
        return GameModeVisual(
          gradientColors: [const Color(0xFFD32F2F), const Color(0xFFEF5350)],
          icon: CupertinoIcons.flag,
        );
      case GameMode.english:
        return GameModeVisual(
          gradientColors: [const Color(0xFF0D47A1), const Color(0xFF1976D2)],
          icon: CupertinoIcons.shield_fill,
        );
      case GameMode.international:
        return GameModeVisual(
          gradientColors: [const Color(0xFF004D40), const Color(0xFF26A69A)],
          icon: CupertinoIcons.globe,
        );
      case GameMode.russian:
        return GameModeVisual(
          gradientColors: [const Color(0xFF4A148C), const Color(0xFF7B1FA2)],
          icon: CupertinoIcons.snow,
        );
      case GameMode.spanish:
        return GameModeVisual(
          gradientColors: [const Color(0xFFF57F17), const Color(0xFFFFB300)],
          icon: CupertinoIcons.sun_max_fill,
        );
      case GameMode.antiCheckers:
        return GameModeVisual(
          gradientColors: [const Color(0xFF424242), const Color(0xFF757575)],
          icon: CupertinoIcons.xmark_circle_fill,
        );
    }
  }
}