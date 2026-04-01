import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';

/// Defines the rule for filtering mandatory capture moves from a list of possible moves.
/// 
/// In many checkers variants, if a capture is possible, it must be taken. However,
/// different variants have different rules about which capture sequence must be 
/// chosen if multiple capture paths are available.
abstract class CaptureRule {
  /// Filters the given list of capture moves according to the specific capture rule.
  ///
  /// The [allCaptureMoves] parameter is the list of all possible capture moves identified 
  /// by the capture strategy.
  /// The [state] parameter provides the current game state, including the board layout,
  /// which is necessary for rules that depend on the type of pieces being captured.
  /// 
  /// Returns a subset of [allCaptureMoves] that are legal according to this rule.
  List<Move> filter(List<Move> allCaptureMoves, GameState state);
}

/// A capture rule where any capture move is mandatory if one exists.
///
/// This is used in variants where the player only needs to make a capture, 
/// regardless of how many pieces are captured or what type of pieces are involved.
/// If multiple capture paths are available, the player is free to choose any of them.
class AnyCaptureIsMandatory implements CaptureRule {
  @override
  List<Move> filter(List<Move> allCaptureMoves, GameState state) {
    // This rule does not apply any additional filtering to the available capture moves.
    // If capture moves exist, any of them can be selected by the player.
    return allCaptureMoves;
  }
}

/// A capture rule where the path that captures the maximum number of pieces is mandatory.
///
/// This rule is common in International and Spanish checkers. It requires the player
/// to choose the move sequence that results in the highest number of opponent pieces 
/// being removed from the board.
class MaxCaptureIsMandatory implements CaptureRule {
  @override
  List<Move> filter(List<Move> allCaptureMoves, GameState state) {
    // If there are no capture moves available, return an empty list.
    if (allCaptureMoves.isEmpty) {
      return [];
    }

    // Step 1: Identify the maximum number of pieces that can be captured in any single sequence.
    int maxCaptures = 0;
    for (final move in allCaptureMoves) {
      if (move.capturedPieces.length > maxCaptures) {
        maxCaptures = move.capturedPieces.length;
      }
    }

    // Step 2: Filter the list to include only those moves that achieve the maximum capture count.
    // If multiple different paths capture the same maximum number of pieces, all are considered valid.
    return allCaptureMoves.where((move) => move.capturedPieces.length == maxCaptures).toList();
  }
}

/// Implements the complex capture priority rules specific to Italian Checkers.
///
/// Italian Checkers (Dama Italiana) has a strict hierarchy for mandatory captures
/// to resolve situations where multiple capture sequences are possible:
/// 1. Maximum Quantity: Priority is given to the path that captures the most pieces.
/// 2. Piece Quality (Captured): If the number of captures is equal, priority is given 
///    to the path that captures the most kings.
/// 3. Piece Quality (Capturing): If still equal, priority is given to the path 
///    where the capture is performed by a king.
/// 4. King Capture Order: If still equal, priority is given to the path that 
///    captures a king first (though this is often simplified in many implementations).
class ItalianCaptureRule implements CaptureRule {
  @override
  List<Move> filter(List<Move> allCaptureMoves, GameState state) {
    // Return early if no captures are possible.
    if (allCaptureMoves.isEmpty) {
      return [];
    }

    // Priority 1: Capture the maximum number of pieces.
    int maxCaptures = 0;
    for (final move in allCaptureMoves) {
      if (move.capturedPieces.length > maxCaptures) {
        maxCaptures = move.capturedPieces.length;
      }
    }
    List<Move> filteredMoves = allCaptureMoves.where((m) => m.capturedPieces.length == maxCaptures).toList();

    // If only one move remains after the first priority check, it is the mandatory move.
    if (filteredMoves.length <= 1) return filteredMoves;

    // Priority 2: Priority to capturing a king.
    // We count how many kings are captured in each sequence and keep those with the maximum count.
    int maxKingsCaptured = 0;
    for (final move in filteredMoves) {
      int kingsInThisMove = move.capturedPieces.where((pos) => 
        state.board[pos.row][pos.col]?.type == PieceType.king
      ).length;
      if (kingsInThisMove > maxKingsCaptured) {
        maxKingsCaptured = kingsInThisMove;
      }
    }
    
    List<Move> kingCaptureMoves = filteredMoves.where((move) {
      int kingsInThisMove = move.capturedPieces.where((pos) => 
        state.board[pos.row][pos.col]?.type == PieceType.king
      ).length;
      return kingsInThisMove == maxKingsCaptured;
    }).toList();
    
    if (kingCaptureMoves.isNotEmpty) {
      filteredMoves = kingCaptureMoves;
    }
    
    // If only one move remains after the second priority check, return it.
    if (filteredMoves.length <= 1) return filteredMoves;

    // Priority 3: Priority to capturing with a king.
    // A move made by a king takes precedence over a move made by a regular piece (man).
    List<Move> movesByKing = filteredMoves.where((m) => 
      state.board[m.from.row][m.from.col]?.type == PieceType.king
    ).toList();
    
    if (movesByKing.isNotEmpty) {
      return movesByKing;
    }

    // If all priorities are still tied, all remaining filtered moves are considered valid options.
    return filteredMoves;
  }
}
