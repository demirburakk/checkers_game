// lib/presentation/widgets/animated_game_piece.dart

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/providers/theme_provider.dart';

/// A widget that represents an animated checkers piece on the game board.
/// 
/// It handles animations for movement, selection, and capture.
class AnimatedGamePiece extends StatelessWidget {
  /// The [Piece] data object containing piece information (color, type, etc.).
  final Piece piece;
  
  /// The top position of the piece on the board.
  final double top;
  
  /// The left position of the piece on the board.
  final double left;
  
  /// The width and height of the piece.
  final double size;
  
  /// Whether the piece is currently selected by the player.
  final bool isSelected;
  
  /// Whether the piece has been captured.
  final bool isCaptured;

  /// Creates an [AnimatedGamePiece] with the given parameters.
  const AnimatedGamePiece({
    required super.key,
    required this.piece,
    required this.top,
    required this.left,
    required this.size,
    this.isSelected = false,
    this.isCaptured = false,
  });

  @override
  Widget build(BuildContext context) {
    // Access the current theme settings.
    final themeProvider = context.read<ThemeProvider>();
    final selectedPieceTheme = themeProvider.selectedPieceTheme;
    final imageProvider = themeProvider.getPieceImageProvider(piece, selectedPieceTheme);

    // AnimatedPositioned handles the smooth movement of the piece across the board.
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      top: top,
      left: left,
      width: size,
      height: size,
      child: IgnorePointer(
        // The piece itself shouldn't capture touch events; the board or square handles them.
        child: AnimatedOpacity(
          // Fades out the piece when it is captured.
          duration: const Duration(milliseconds: 250),
          opacity: isCaptured ? 0.0 : 1.0,
          child: AnimatedScale(
            // Slightly enlarges the piece when it is selected for a better visual feedback.
            duration: const Duration(milliseconds: 250),
            scale: isSelected ? 1.08 : 1.0,

            // CHANGE: We wrap the piece itself with a Padding.
            // This ensures that the piece is drawn slightly inside the square boundaries,
            // making it look smaller and more aesthetically pleasing.
            child: Padding(
              padding: const EdgeInsets.all(5.0), // NEW: Added internal padding.
              child: Image(
                image: imageProvider,
                fit: BoxFit.contain,
                gaplessPlayback: true,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(CupertinoIcons.exclamationmark_triangle, color: CupertinoColors.systemRed),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
