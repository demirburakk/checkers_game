import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/game_rules.dart';
import 'package:checkers_game/domain/rules/strategies/capture_rule.dart';
import 'package:checkers_game/domain/rules/strategies/capture_strategy.dart';
import 'package:checkers_game/domain/rules/strategies/move_strategy.dart';
import 'package:checkers_game/domain/models/draw_reason.dart';

/// Defines the rules for International Checkers (also known as Polish Draughts).
/// 
/// Characteristics:
/// - 10x10 board.
/// - Played only on dark squares.
/// - Men move forward only but can capture both forward and backward.
/// - Kings are "flying kings" (long-range), meaning they can move any number of squares along diagonals.
/// - Majority capture is mandatory: if multiple capture paths exist, the one that captures the most pieces must be chosen.
/// - A man promoting to king ends the turn immediately, even if it could continue capturing as a king.
class InternationalRules extends GameRules {
  @override
  String get name => 'International Checkers';

  @override
  String get description => 'Played on a 10x10 board. Majority capture is mandatory, and kings have long-range (flying) movement.';

  @override
  int get boardSize => 10;

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
  CaptureStrategy get captureStrategy => InternationalCaptureStrategy(boardSize);

  @override
  CaptureRule get captureRule => MaxCaptureIsMandatory();

  // --- Rule-Specific Methods ---

  /// Checks for draw conditions specific to International Checkers.
  @override
  DrawReason? checkForDraw(GameState state) {
    // Rule 1: Threefold Repetition Rule
    // If the same position (same board layout and same player turn) repeats 3 times.
    if ((state.positionHistory[state.boardHash] ?? 0) >= 3) {
      return DrawReason.threefoldRepetition;
    }

    // Rule 2: 50-Move Rule (100 individual half-moves)
    // If 50 full moves (100 half-moves) occur without a capture or a man moving.
    // Note: In professional rules, this rule is slightly more nuanced depending on the pieces left.
    if (state.movesSinceSignificantEvent >= 100) {
      return DrawReason.fiftyMoveRule;
    }

    // Rule 3: Insufficient Material
    // Certain piece combinations are mathematically proven to be draws.
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

    // If only kings remain on the board.
    if (whiteMen == 0 && blackMen == 0) {
      // 1 King vs 1 King is always a draw.
      if (whiteKings == 1 && blackKings == 1) {
        return DrawReason.insufficientMaterial;
      }
      // 2 Kings vs 1 King (or 1 vs 2) is generally considered a draw in this variant.
      if ((whiteKings == 2 && blackKings == 1) || (whiteKings == 1 && blackKings == 2)) {
        return DrawReason.insufficientMaterial;
      }
    }

    return null;
  }

  @override
  List<List<Piece?>> initializeBoard() {
    final board = List.generate(boardSize, (_) => List<Piece?>.filled(boardSize, null));
    // Black pieces occupy the first 4 rows.
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < boardSize; col++) {
        if ((row + col).isOdd) {
          board[row][col] = Piece(id: 'b_${row}_$col', color: PieceColor.black);
        }
      }
    }
    // White pieces occupy the last 4 rows.
    for (int row = 6; row < 10; row++) {
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
    // White promotes on row 0, Black on row 9.
    return (color == PieceColor.white && pos.row == 0) || (color == PieceColor.black && pos.row == boardSize - 1);
  }

  @override
  int getCapturedPiecesCount(List<List<Piece?>> board, PieceColor opponentColor) {
    const int initialCount = 20; // Each player starts with 20 pieces in International Checkers.
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
    // Check for wins/losses.
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
          // Flying kings are significantly more powerful.
          double pieceValue = (piece.type == PieceType.king) ? 2.0 : 1.0;

          // Advancement bonus for men.
          if (piece.type == PieceType.man) {
            if (piece.color == PieceColor.white) {
              pieceValue += 0.1 * (boardSize - 1 - r) / (boardSize - 1);
            } else {
              pieceValue += 0.1 * r / (boardSize - 1);
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
