import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/game_rules.dart';
import 'package:checkers_game/domain/rules/strategies/capture_rule.dart';
import 'package:checkers_game/domain/rules/strategies/capture_strategy.dart';
import 'package:checkers_game/domain/rules/strategies/move_strategy.dart';
import 'package:checkers_game/domain/models/draw_reason.dart';

/// Defines the rules for Turkish Checkers (Dama).
/// 
/// Characteristics:
/// - 8x8 board.
/// - Played on all squares (not just dark squares).
/// - Pieces move and capture orthogonally (forward and sideways), never diagonally.
/// - Kings are "flying kings" (long-range) that move in straight lines (forward, backward, sideways).
/// - Majority capture is mandatory.
class TurkishRules extends GameRules {
  @override
  String get name => 'Turkish Checkers';

  @override
  String get description => 'Played on an 8x8 board. Pieces move forward and sideways, but not diagonally.';

  @override
  int get boardSize => 8;

  @override
  bool get isPlayedOnDarkSquares => false; // Played on all squares.

  @override
  bool get kingCanContinueCaptureAfterPromotion => false;

  // --- Strategy Assignments ---

  @override
  MoveStrategy get manMoveStrategy => OrthogonalManMoveStrategy(boardSize);

  @override
  MoveStrategy get kingMoveStrategy => FlyingKingMoveStrategy(boardSize, directions: const [[-1, 0], [1, 0], [0, -1], [0, 1]]);

  @override
  CaptureStrategy get captureStrategy => TurkishCaptureStrategy(boardSize);

  @override
  CaptureRule get captureRule => MaxCaptureIsMandatory();

  // --- Rule-Specific Methods ---

  /// Checks for draw conditions specific to Turkish Checkers.
  @override
  DrawReason? checkForDraw(GameState state) {
    // Rule 1: Threefold Repetition Rule
    if ((state.positionHistory[state.boardHash] ?? 0) >= 3) {
      return DrawReason.threefoldRepetition;
    }

    // Rule 2: 25-Move Rule (50 half-moves)
    // Award a draw if there's no capture or man move for a long period.
    if (state.movesSinceSignificantEvent >= 50) {
      return DrawReason.twentyFiveMoveRule;
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
    // Only 1 white king and 1 black king remaining is a draw.
    if (whiteMen == 0 && blackMen == 0 && whiteKings == 1 && blackKings == 1) {
      return DrawReason.insufficientMaterial;
    }

    // Rule 4: Stalemate
    // If neither player can move, it's a draw.
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

  /// Checks for a winner. In Turkish Checkers, a player loses if they have no moves.
  @override
  Player? checkForWinner(GameState state) {
    // A player with no legal moves loses (unless it's a stalemate draw).
    if (state.possibleMoves.isEmpty) {
      return state.currentPlayer == PieceColor.white ? Player.black : Player.white;
    }

    // A player with no pieces left loses.
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
    // Black pieces on rows 1 and 2.
    for (int i = 0; i < 8; i++) {
      board[1][i] = Piece(id: 'b_1_$i', color: PieceColor.black);
      board[2][i] = Piece(id: 'b_2_$i', color: PieceColor.black);
      // White pieces on rows 5 and 6.
      board[5][i] = Piece(id: 'w_5_$i', color: PieceColor.white);
      board[6][i] = Piece(id: 'w_6_$i', color: PieceColor.white);
    }
    return board;
  }

  @override
  bool isPromotionSquare(BoardPosition pos, PieceColor color) {
    // Pieces promote on the last row of the board.
    return (color == PieceColor.white && pos.row == 0) || (color == PieceColor.black && pos.row == 7);
  }

  @override
  int getCapturedPiecesCount(List<List<Piece?>> board, PieceColor opponentColor) {
    const int initialCount = 16; // Each player starts with 16 pieces in Turkish Checkers.
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
          // Kings are highly valuable in Turkish Checkers.
          double pieceValue = (piece.type == PieceType.king) ? 2.5 : 1.0;
          
          // Pieces on the edge are slightly less useful for movement.
          if (r == 0 || r == 7 || c == 0 || c == 7) {
            pieceValue -= 0.1;
          } else if (r > 1 && r < 6 && c > 1 && c < 6) {
            // Control of the inner squares is advantageous.
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
