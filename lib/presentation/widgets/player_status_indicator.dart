// lib/presentation/widgets/player_status_indicator.dart

import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// A widget that displays the status of a player, including their name,
/// piece color, capture count, and whether it's currently their turn.
class PlayerStatusIndicator extends StatelessWidget {
  /// The color of the player's pieces (white or black).
  final PieceColor playerColor;
  
  /// The number of opponent's pieces captured by this player.
  final int capturedPieces;
  
  /// Whether it is currently this player's turn to move.
  final bool isCurrentTurn;
  
  /// Whether this player is the human user (vs AI or another human).
  final bool isUser;
  
  /// Whether the AI is currently thinking about its move.
  final bool isThinking;

  /// Creates a [PlayerStatusIndicator].
  const PlayerStatusIndicator({
    super.key,
    required this.playerColor,
    required this.capturedPieces,
    required this.isCurrentTurn,
    required this.isUser,
    this.isThinking = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    
    // Use 'watch' to rebuild when the theme changes.
    final themeProvider = context.watch<ThemeProvider>();
    
    final isWhite = playerColor == PieceColor.white;
    
    // TODO: These should ideally be localized using l10n.
    final name = isUser ? "You" : (isWhite ? "White" : "Black");
    final statusText = isThinking ? "Thinking..." : (isCurrentTurn ? "Your Turn" : "Waiting...");
    
    final textColor = isCurrentTurn ? theme.primaryContrastingColor : theme.textTheme.textStyle.color;
    const pieceSize = 40.0;

    // BUG FIX: FutureBuilder was removed for performance.
    // We now get the correct ImageProvider directly from ThemeProvider.
    final imageProvider = themeProvider.getPieceImageProvider(
        Piece(id: 'indicator', color: playerColor, type: PieceType.man),
        themeProvider.selectedPieceTheme
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // Highlighting the current player with a gradient background.
        gradient: LinearGradient(
          colors: isCurrentTurn
              ? [theme.primaryColor, Color.lerp(theme.primaryColor, theme.scaffoldBackgroundColor, 0.5)!]
              : [theme.barBackgroundColor, theme.scaffoldBackgroundColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentTurn ? theme.primaryColor : CupertinoColors.transparent,
          width: 2,
        ),
        // Adding depth with shadows.
        boxShadow: isCurrentTurn ? [
          BoxShadow(color: theme.primaryColor.withAlpha(100), blurRadius: 15, spreadRadius: 0, offset: const Offset(0, 4)),
        ] : [
          BoxShadow(color: CupertinoColors.black.withAlpha(50), blurRadius: 5, spreadRadius: -2, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CHANGE: Using direct Image widget instead of FutureBuilder.
          SizedBox(
            width: pieceSize,
            height: pieceSize,
            child: Image(
              image: imageProvider,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(CupertinoIcons.exclamationmark_triangle),
            ),
          ),
          const SizedBox(width: 12),
          // Player information (Name and Status)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                if(isThinking)
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: CupertinoActivityIndicator(),
                  )
                else
                  Text(statusText, style: TextStyle(fontSize: 12, color: (textColor ?? CupertinoColors.label).withAlpha(200))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Captured pieces counter
          Icon(CupertinoIcons.minus_circled, size: 20, color: textColor?.withAlpha(180)),
          const SizedBox(width: 6),
          Text(capturedPieces.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor)),
        ],
      ),
    );
  }
}
