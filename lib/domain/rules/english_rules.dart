import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/game_rules.dart';
import 'package:checkers_game/domain/rules/strategies/capture_rule.dart';
import 'package:checkers_game/domain/rules/strategies/capture_strategy.dart';
import 'package:checkers_game/domain/rules/strategies/move_strategy.dart';
import 'package:checkers_game/domain/models/draw_reason.dart';

/// Defines the rules for English Draughts (also known as American Checkers).
/// 
/// Characteristics:
/// - 8x8 board.
/// - Played only on dark squares.
/// - Men move and capture forward only.
/// - Kings move and capture forward and backward but only one square at a time (short-range).
/// - Capturing is mandatory (any capture will do).
/// - A man promoting to king ends the turn immediately.
class EnglishRules extends GameRules {
  @override
  String get name => 'English Draughts';

  @override
  String get description => 'Played on an 8x8 board. Normal pieces cannot capture backwards, and kings move only one square at a time.';

  @override
  int get boardSize => 8;

  @override
  bool get isPlayedOnDarkSquares => true;

  @override
  bool get kingCanContinueCaptureAfterPromotion => false;

  @override
  CaptureRule get captureRule => AnyCaptureIsMandatory();

  // --- Strategy Assignments ---

  @override
  MoveStrategy get manMoveStrategy => ForwardManMoveStrategy(boardSize);

  @override
  MoveStrategy get kingMoveStrategy => ShortRangeKingMoveStrategy(boardSize);

  @override
  CaptureStrategy get captureStrategy => EnglishCaptureStrategy(boardSize);

  // --- Rule-Specific Methods ---

  /// Checks for draw conditions specific to English Draughts.
  @override
  DrawReason? checkForDraw(GameState state) {
    // Rule 1: Threefold Repetition Rule
    // If the same position (with the same player to move) occurs three times, it's a draw.
    if ((state.positionHistory[state.boardHash] ?? 0) >= 3) {
      return DrawReason.threefoldRepetition;
    }

    // Rule 2: 40-Move Rule (80 individual half-moves)
    // If 40 full moves (80 half-moves) occur without a capture or a man moving, it's a draw.
    if (state.movesSinceSignificantEvent >= 80) {
      return DrawReason.fortyMoveRule;
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
    // A classic draw case: 1 King vs 1 King.
    if (whiteMen == 0 && blackMen == 0 && whiteKings == 1 && blackKings == 1) {
      return DrawReason.insufficientMaterial;
    }

    // Rule 4: Stalemate
    // If the current player has no moves, check if the opponent also has no moves.
    // In English Draughts, if a player cannot move, they lose (checked in checkForWinner).
    // A true stalemate draw occurs only if NEITHER player can move.
    if (state.possibleMoves.isEmpty) {
      final opponentState = state.copyWith(
        currentPlayer: state.currentPlayer == PieceColor.white ? PieceColor.black : PieceColor.white,
      );
      final opponentMoves = getPossibleMoves(opponentState);
      if (opponentMoves.isEmpty) {
        return DrawReason.stalemate;
      }
    }

    return null;
  }

  @override
  Player? checkForWinner(GameState state) {
    // If there is no draw and the current player has no legal moves, they lose.
    // This check is performed after the stalemate draw check in the game loop.
    if (state.possibleMoves.isEmpty) {
      return state.currentPlayer == PieceColor.white ? Player.black : Player.white;
    }

    // If a player has no pieces left, they lose.
    bool whiteHasPieces = false;
    bool blackHasPieces = false;
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

    if (!whiteHasPieces) return Player.black;
    if (!blackHasPieces) return Player.white;

    return null; // Game continues.
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
  bool isPromotionSquare(BoardPosition pos, PieceColor color) {
    // White promotes on the top row (0), Black on the bottom row (7).
    return (color == PieceColor.white && pos.row == 0) || (color == PieceColor.black && pos.row == boardSize - 1);
  }

  @override
  int getCapturedPiecesCount(List<List<Piece?>> board, PieceColor opponentColor) {
    const int initialCount = 12; // Each player starts with 12 pieces in English Draughts.
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
    // Check for terminal states first.
    final winner = checkForWinner(state);
    if (winner != null) {
      final aiPlayer = aiColor == PieceColor.white ? Player.white : Player.black;
      return winner == aiPlayer ? 9999.0 : -9999.0;
    }

    if (checkForDraw(state) != null) {
      return 0.0;
    }

    double score = 0.0;
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        final piece = state.board[r][c];
        if (piece != null) {
          // Kings are more valuable than men.
          double pieceValue = (piece.type == PieceType.king) ? 1.5 : 1.0;

          // Men are more valuable as they approach promotion.
          if (piece.type == PieceType.man) {
            if (piece.color == PieceColor.white) {
              pieceValue += 0.2 * (boardSize - 1 - r) / (boardSize - 1);
            } else {
              pieceValue += 0.2 * r / (boardSize - 1);
            }
          }
          
          // Control of the center is generally advantageous.
          if ((r > 1 && r < 6) && (c > 1 && c < 6)) {
            pieceValue += 0.1;
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
