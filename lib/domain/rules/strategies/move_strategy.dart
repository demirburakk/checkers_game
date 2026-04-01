import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';

/// Defines the strategy for calculating regular (non-capture) moves for a piece.
///
/// Regular moves are the standard one-square diagonal or orthogonal steps taken 
/// when no capture is being performed. This abstract class provides the foundation 
/// for different movement behaviors across various checkers variants, allowing 
/// the game engine to remain flexible.
abstract class MoveStrategy {
  /// The size of the checkers board (e.g., 8x8, 10x10, or 12x12).
  /// This is used to ensure moves stay within the board boundaries.
  final int boardSize;

  MoveStrategy(this.boardSize);

  /// Returns all possible regular moves for the given [piece] from its current position [from].
  ///
  /// [piece] represents the piece being moved (its color and type: man or king).
  /// [from] is the starting board coordinates.
  /// [board] is the current state of the board, used to check for empty destination squares.
  /// 
  /// Returns a list of [Move] objects representing all valid non-capture destinations.
  List<Move> getPossibleMoves(Piece piece, BoardPosition from, List<List<Piece?>> board);

  /// Utility method to check if a given [pos] is within the valid boundaries of the board.
  ///
  /// Returns true if the row and column are both between 0 (inclusive) and [boardSize] (exclusive).
  bool isOnBoard(BoardPosition pos) {
    return pos.row >= 0 && pos.row < boardSize && pos.col >= 0 && pos.col < boardSize;
  }
}

/// A strategy for a standard piece ("man") that can only move forward diagonally.
///
/// This is the most common movement rule for starting pieces. In variants like 
/// International, English, and Spanish checkers, men can only step forward 
/// to an adjacent empty diagonal square.
class ForwardManMoveStrategy extends MoveStrategy {
  ForwardManMoveStrategy(super.boardSize);

  @override
  List<Move> getPossibleMoves(Piece piece, BoardPosition from, List<List<Piece?>> board) {
    final List<Move> moves = [];
    
    // Determine the forward direction based on piece color.
    // In our coordinate system, White usually starts at the bottom (moving up, -1)
    // and Black starts at the top (moving down, +1).
    final forwardRow = piece.color == PieceColor.white ? -1 : 1;
    final directions = [[forwardRow, -1], [forwardRow, 1]];

    for (final dir in directions) {
      final toPos = BoardPosition(from.row + dir[0], from.col + dir[1]);
      
      // A regular move is valid only if the target position is on the board and currently empty.
      if (isOnBoard(toPos) && board[toPos.row][toPos.col] == null) {
        // Check if this move results in a promotion.
        // A man becomes a king if it reaches the furthest row from its starting side.
        final isPromotion = (piece.color == PieceColor.white && toPos.row == 0) || 
                           (piece.color == PieceColor.black && toPos.row == boardSize - 1);
        
        moves.add(Move(from: from, to: toPos, becomesKing: isPromotion));
      }
    }
    return moves;
  }
}

/// A strategy for kings that can move only one square in any diagonal direction.
///
/// This "short-range" movement is a defining feature of Italian Checkers (Dama Italiana).
/// Unlike "Flying Kings", these kings are limited to a single step, making their 
/// range of influence much smaller.
class ShortRangeKingMoveStrategy extends MoveStrategy {
  ShortRangeKingMoveStrategy(super.boardSize);

  @override
  List<Move> getPossibleMoves(Piece piece, BoardPosition from, List<List<Piece?>> board) {
    final List<Move> moves = [];
    
    // Kings can move one step in any of the four diagonal directions (both forward and backward).
    final directions = [[-1, -1], [-1, 1], [1, -1], [1, 1]];

    for (final dir in directions) {
      final toPos = BoardPosition(from.row + dir[0], from.col + dir[1]);
      
      // Destination must be on the board and unoccupied.
      if (isOnBoard(toPos) && board[toPos.row][toPos.col] == null) {
        moves.add(Move(from: from, to: toPos));
      }
    }
    return moves;
  }
}

/// A strategy for a piece that can move forward, left, or right, but not diagonally.
///
/// This unique orthogonal movement is the core mechanic of Turkish Checkers (Dama).
/// Pieces move like a "rook" in chess but only by one square at a time, and 
/// cannot move backwards.
class OrthogonalManMoveStrategy extends MoveStrategy {
  OrthogonalManMoveStrategy(super.boardSize);

  @override
  List<Move> getPossibleMoves(Piece piece, BoardPosition from, List<List<Piece?>> board) {
    final List<Move> moves = [];
    
    // Determine forward direction: White moves up (-1), Black moves down (+1).
    final forwardRow = piece.color == PieceColor.white ? -1 : 1;
    final directions = [
      [forwardRow, 0], // Forward step
      [0, -1],         // Left step
      [0, 1],          // Right step
    ];

    for (final dir in directions) {
      final toPos = BoardPosition(from.row + dir[0], from.col + dir[1]);
      
      // Orthogonal move is valid if destination is on the board and empty.
      if (isOnBoard(toPos) && board[toPos.row][toPos.col] == null) {
        // Promotion occurs when a piece reaches the opponent's back rank.
        final isPromotion = (piece.color == PieceColor.white && toPos.row == 0) || 
                           (piece.color == PieceColor.black && toPos.row == boardSize - 1);
        
        moves.add(Move(from: from, to: toPos, becomesKing: isPromotion));
      }
    }
    return moves;
  }
}

/// A general-purpose strategy for "Flying Kings" that can move any number of empty 
/// squares in specified directions.
///
/// Flying kings (used in International, Russian, Spanish, and Turkish variants) 
/// can slide across the board like a Bishop or Rook in Chess, provided the path 
/// is clear of other pieces.
class FlyingKingMoveStrategy extends MoveStrategy {
  /// The set of allowed directions for the king's movement.
  /// For most variants, this will be diagonals; for Turkish Draughts, it is orthogonals.
  final List<List<int>> directions;

  FlyingKingMoveStrategy(super.boardSize, {required this.directions});

  @override
  List<Move> getPossibleMoves(Piece piece, BoardPosition from, List<List<Piece?>> board) {
    final List<Move> moves = [];
    
    for (final dir in directions) {
      // Continue extending the move in the current direction until an obstacle 
      // or the board edge is reached.
      for (int i = 1; i < boardSize; i++) {
        final toPos = BoardPosition(from.row + i * dir[0], from.col + i * dir[1]);
        
        // Stop the search in this direction if we go off-board.
        if (!isOnBoard(toPos)) {
          break;
        }
        
        // Stop if the square is occupied. Flying kings cannot leap over pieces 
        // during a regular (non-capture) move.
        if (board[toPos.row][toPos.col] != null) {
          break;
        }
        
        // Each empty square along the path is a valid destination.
        moves.add(Move(from: from, to: toPos));
      }
    }
    return moves;
  }
}
