import 'package:checkers_game/domain/models/theme_base.dart';
import 'package:flutter/material.dart';

/// Represents a visual theme for the checkers board.
class BoardTheme implements ThemeBase {
  @override
  final String nameKey;
  
  /// The filename or path of the asset associated with this board theme.
  final String assetName;
  
  /// The grouping category for this theme (e.g., "Classic", "Modern", "Fantasy").
  final String category;
  
  /// The color for the lighter-colored squares on the board.
  final Color lightSquareColor;
  
  /// The color for the darker-colored squares on the board.
  final Color darkSquareColor;

  /// Creates a new [BoardTheme] instance.
  BoardTheme({
    required this.nameKey,
    required this.assetName,
    required this.category,
    required this.lightSquareColor,
    required this.darkSquareColor,
  });
}

/// Represents a visual theme for the checkers pieces.
class PieceTheme implements ThemeBase {
  @override
  final String nameKey;
  
  /// The filename or path of the asset associated with this piece theme.
  final String assetName;
  
  /// The grouping category for this theme.
  final String category;
  
  /// The gradient colors used for Player 1's (White) pieces.
  final List<Color> player1Gradient;
  
  /// The border color used for Player 1's (White) pieces.
  final Color player1BorderColor;
  
  /// The gradient colors used for Player 2's (Black) pieces.
  final List<Color> player2Gradient;
  
  /// The border color used for Player 2's (Black) pieces.
  final Color player2BorderColor;

  /// Creates a new [PieceTheme] instance.
  PieceTheme({
    required this.nameKey,
    required this.assetName,
    required this.category,
    required this.player1Gradient,
    required this.player1BorderColor,
    required this.player2Gradient,
    required this.player2BorderColor,
  });
}