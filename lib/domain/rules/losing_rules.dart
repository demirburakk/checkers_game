import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/game_rules.dart';
import 'package:checkers_game/domain/rules/strategies/capture_rule.dart';
import 'package:checkers_game/domain/rules/strategies/capture_strategy.dart';
import 'package:checkers_game/domain/rules/strategies/move_strategy.dart';
import 'package:checkers_game/domain/models/draw_reason.dart';

/// Defines the rules for Losing Checkers (also known as Anticheckers or Suicide Checkers).
/// 
/// In this variant, the goal is the opposite of traditional checkers:
/// the first player to have no legal moves (either by losing all pieces or being blocked) wins.
class LosingRules extends GameRules {
  @override
  String get name => 'Losing Checkers';

  @override
  String get description => 'The player who loses all their pieces or has no remaining moves wins.';

  @override
  int get boardSize => 8;

  @override
  bool get isPlayedOnDarkSquares => true;

  @override
  bool get kingCanContinueCaptureAfterPromotion => false;

  // --- Strategy Assignments ---
  // Mechanically, movement and captures are identical to English Draughts.
  
  @override
  MoveStrategy get manMoveStrategy => ForwardManMoveStrategy(boardSize);

  @override
  MoveStrategy get kingMoveStrategy => ShortRangeKingMoveStrategy(boardSize);

  @override
  CaptureStrategy get captureStrategy => EnglishCaptureStrategy(boardSize);

  @override
  CaptureRule get captureRule => AnyCaptureIsMandatory();

  // --- Rule-Specific Methods ---

  /// Checks for draw conditions.
  @override
  DrawReason? checkForDraw(GameState state) {
    // Draws are rare in Losing Checkers, but threefold repetition is still possible.
    if ((state.positionHistory[state.boardHash] ?? 0) >= 3) {
      return DrawReason.threefoldRepetition;
    }
    return null;
  }

  /// Determines the winner based on Losing Checkers logic.
  @override
  Player? checkForWinner(GameState state) {
    bool whiteHasPieces = false;
    bool blackHasPieces = false;
    
    // Check which players still have pieces on the board.
    for (var row in state.board) {
      for (var piece in row) {
        if (piece != null) {
          if (piece.color == PieceColor.white) {
            whiteHasPieces = true;
          } else {
            blackHasPieces = true;
          }
        }
      }
    }

    // If White has no pieces left, White WINS.
    if (!whiteHasPieces) return Player.white;
    // If Black has no pieces left, Black WINS.
    if (!blackHasPieces) return Player.black;

    // If the current player has no legal moves left, they WIN.
    if (state.possibleMoves.isEmpty) {
      return state.currentPlayer == PieceColor.white ? Player.white : Player.black;
    }

    return null; // Game continues.
  }

  /// Evaluates the board state for the AI.
  /// In Losing Checkers, having fewer and less powerful pieces is advantageous.
  @override
  double evaluate(GameState state, PieceColor aiColor) {
    // Check for terminal states.
    final winner = checkForWinner(state);
    if (winner != null) {
      final aiPlayer = aiColor == PieceColor.white ? Player.white : Player.black;
      return winner == aiPlayer ? 9999.0 : -9999.0;
    }

    // A draw is considered a neutral outcome.
    if (checkForDraw(state) != null) {
      return 0.0;
    }

    // Inverse evaluation: Fewer pieces and weaker pieces result in a higher score.
    double score = 0.0;
    for (var row in state.board) {
      for (var piece in row) {
        if (piece != null) {
          // Kings are generally harder to get rid of, so they are "worse" to have.
          double pieceValue = (piece.type == PieceType.king) ? 1.5 : 1.0;
          
          if (piece.color == aiColor) {
            // Subtract points for our own pieces.
            score -= pieceValue;
          } else {
            // Add points for opponent pieces.
            score += pieceValue;
          }
        }
      }
    }
    return score;
  }

  @override
  List<List<Piece?>> initializeBoard() {
    final board = List.generate(boardSize, (_) => List<Piece?>.filled(boardSize, null));
    // Place black pieces on the first 3 rows.
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < boardSize; col++) {
        if ((row + col).isOdd) {
          board[row][col] = Piece(id: 'b_${row}_$col', color: PieceColor.black);
        }
      }
    }
    // Place white pieces on the last 3 rows.
    for (int row = 5; row < 8; row++) {
      for (int col = 0; col < boardSize; col++) {
        if ((row + col).isOdd) {
          board[row][col] = Piece(id: 'w_${row}_$col', color: PieceColor.white);
        }
      }
    }
    return board;
  }

  @override
  int getCapturedPiecesCount(List<List<Piece?>> board, PieceColor opponentColor) {
    const int initialCount = 12; // Each player starts with 12 pieces.
    int currentCount = 0;
    for (var row in board) {
      for (var piece in row) {
        if (piece != null && piece.color == opponentColor) {
          currentCount++;
        }
      }
    }
    return initialCount - currentCount;
  }

  @override
  bool isPromotionSquare(BoardPosition pos, PieceColor color) {
    // White promotes on the top row, Black on the bottom row.
    return (color == PieceColor.white && pos.row == 0) || (color == PieceColor.black && pos.row == boardSize - 1);
  }
}
