import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/game_rules.dart';
import 'package:checkers_game/domain/rules/strategies/capture_rule.dart';
import 'package:checkers_game/domain/rules/strategies/capture_strategy.dart';
import 'package:checkers_game/domain/rules/strategies/move_strategy.dart';
import 'package:checkers_game/domain/models/draw_reason.dart';

/// Defines the rules for Spanish Checkers (Damas).
/// 
/// Characteristics:
/// - 8x8 board.
/// - Played only on dark squares.
/// - Men move and capture forward only.
/// - Kings are "flying kings" (long-range).
/// - Majority capture is mandatory: if multiple capture paths exist, the one that captures the most pieces must be chosen.
/// - If multiple paths capture the same number of pieces, the one capturing more kings must be chosen.
class SpanishRules extends GameRules {
  @override
  String get name => 'Spanish Checkers';

  @override
  String get description => 'Men only capture forward. Majority capture is mandatory, and kings have long-range (flying) movement.';

  @override
  int get boardSize => 8;

  @override
  bool get isPlayedOnDarkSquares => true;

  @override
  bool get kingCanContinueCaptureAfterPromotion => false;

  // --- Strategy Assignments ---

  @override
  MoveStrategy get manMoveStrategy => ForwardManMoveStrategy(boardSize);

  @override
  MoveStrategy get kingMoveStrategy => FlyingKingMoveStrategy(boardSize, directions: const [[-1, -1], [-1, 1], [1, -1], [1, 1]]);

  @override
  CaptureStrategy get captureStrategy => SpanishCaptureStrategy(boardSize); // Spanish variant has its own capture logic.

  @override
  CaptureRule get captureRule => MaxCaptureIsMandatory();

  // --- Rule-Specific Methods ---

  /// Checks for draw conditions specific to Spanish Checkers.
  @override
  DrawReason? checkForDraw(GameState state) {
    // Rule 1: Threefold Repetition Rule
    if ((state.positionHistory[state.boardHash] ?? 0) >= 3) {
      return DrawReason.threefoldRepetition;
    }

    // Rule 2: 50-Move Rule (100 half-moves)
    // Common in Spanish/Portuguese variants.
    if (state.movesSinceSignificantEvent >= 100) {
      return DrawReason.fiftyMoveRule;
    }

    // Rule 3: Insufficient Material
    int whiteKings = 0, blackKings = 0;
    int whiteMen = 0, blackMen = 0;
    for (var row in state.board) {
      for (var piece in row) {
        if (piece != null) {
          if (piece.color == PieceColor.white) {
            if (piece.type == PieceType.king) {
              whiteKings++;
            } else {
              whiteMen++;
            }
          } else {
            if (piece.type == PieceType.king) {
              blackKings++;
            } else {
              blackMen++;
            }
          }
        }
      }
    }

    if (whiteMen == 0 && blackMen == 0) {
      // Basic draw cases for kings.
      if ((whiteKings == 1 && blackKings == 1) || (whiteKings == 2 && blackKings == 1) || (whiteKings == 1 && blackKings == 2)) {
        return DrawReason.insufficientMaterial;
      }
    }

    return null;
  }

  @override
  List<List<Piece?>> initializeBoard() {
    final board = List.generate(boardSize, (_) => List<Piece?>.filled(boardSize, null));
    // Black pieces on the first 3 rows.
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < boardSize; col++) {
        if ((row + col).isOdd) {
          board[row][col] = Piece(id: 'b_${row}_$col', color: PieceColor.black);
        }
      }
    }
    // White pieces on the last 3 rows.
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
  bool isPromotionSquare(BoardPosition pos, PieceColor color) {
    return (color == PieceColor.white && pos.row == 0) || (color == PieceColor.black && pos.row == boardSize - 1);
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
  double evaluate(GameState state, PieceColor aiColor) {
    // Check for terminal states.
    final winner = checkForWinner(state);
    if (winner != null) {
      final aiPlayer = aiColor == PieceColor.white ? Player.white : Player.black;
      return winner == aiPlayer ? 9999.0 : -9999.0;
    }

    // Include draw check in evaluation.
    if (checkForDraw(state) != null) {
      return 0.0;
    }

    double score = 0.0;
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        final piece = state.board[r][c];
        if (piece != null) {
          // Flying kings are significantly more valuable.
          double pieceValue = (piece.type == PieceType.king) ? 2.2 : 1.0;
          
          // Advancement bonus for men.
          if (piece.type == PieceType.man) {
            if (piece.color == PieceColor.white) {
              pieceValue += 0.2 * (boardSize - 1 - r) / (boardSize - 1);
            } else {
              pieceValue += 0.2 * r / (boardSize - 1);
            }
          }

          // Pieces on the edge are slightly less useful for capturing.
          if (c == 0 || c == boardSize - 1) {
            pieceValue -= 0.05;
          }

          if (piece.color == aiColor) {
            score += pieceValue;
          } else {
            score -= pieceValue;
          }
        }
      }
    }
    return score;
  }
}
