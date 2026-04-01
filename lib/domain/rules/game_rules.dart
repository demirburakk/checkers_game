import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/draw_reason.dart';
import 'package:checkers_game/domain/rules/strategies/capture_rule.dart';
import 'package:checkers_game/domain/rules/strategies/capture_strategy.dart';
import 'package:checkers_game/domain/rules/strategies/move_strategy.dart';
import 'package:checkers_game/providers/zobrist_hash.dart';

/// Represents the players in the game.
enum Player { white, black }

/// Abstract class defining the core rules and logic for a checkers game.
/// 
/// This class employs the Strategy Design Pattern, allowing different rule variants
/// (like International, Turkish, or English checkers) to be composed from
/// reusable strategy components for moving, capturing, and filtering moves.
abstract class GameRules {
  // --- Rule-Specific Core Information (Must be implemented by each subclass) ---

  /// The name of the checkers variant (e.g., "International Checkers").
  String get name;

  /// A brief description of the rules for this variant.
  String get description;

  /// The size of the square board (e.g., 8 for 8x8, 10 for 10x10).
  int get boardSize;

  /// Whether the game is played only on the dark squares of the board.
  bool get isPlayedOnDarkSquares;

  /// Whether a piece that just promoted to a king can continue capturing in the same turn.
  bool get kingCanContinueCaptureAfterPromotion;

  /// Strategy for how a regular man piece moves.
  MoveStrategy get manMoveStrategy;

  /// Strategy for how a king piece moves.
  MoveStrategy get kingMoveStrategy;

  /// Strategy for identifying all possible capture moves on the board.
  CaptureStrategy get captureStrategy;

  /// Rule for filtering possible captures (e.g., mandatory to take the maximum number of pieces).
  CaptureRule get captureRule;

  /// Initializes the board with pieces in their starting positions according to the specific rules.
  List<List<Piece?>> initializeBoard();

  /// Calculates how many pieces of the [opponentColor] have been captured.
  int getCapturedPiecesCount(List<List<Piece?>> board, PieceColor opponentColor);

  /// Determines if a piece at [pos] should be promoted to a king for the given [color].
  bool isPromotionSquare(BoardPosition pos, PieceColor color);

  /// Evaluates the current [state] for the AI, returning a score from [aiColor]'s perspective.
  double evaluate(GameState state, PieceColor aiColor);

  /// Checks if the current game state results in a draw according to specific rules.
  DrawReason? checkForDraw(GameState state);

  /// Returns a list of all legal moves for the current player in the given [state].
  /// 
  /// Priority is given to capture moves. If captures are available, they are filtered
  /// by the [captureRule] and returned. Otherwise, normal moves are calculated.
  List<Move> getPossibleMoves(GameState state) {
    // Check for capture moves first as they are generally mandatory in checkers.
    final allPossibleCaptures = captureStrategy.findAllCaptureMoves(state);
    if (allPossibleCaptures.isNotEmpty) {
      // Filter captures based on variant-specific rules (e.g., majority capture).
      return captureRule.filter(allPossibleCaptures, state);
    }

    // If no captures are possible, look for normal moves.
    final List<Move> normalMoves = [];
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        final piece = state.board[r][c];
        if (piece != null && piece.color == state.currentPlayer) {
          final moveStrategy = (piece.type == PieceType.man) ? manMoveStrategy : kingMoveStrategy;
          normalMoves.addAll(moveStrategy.getPossibleMoves(piece, BoardPosition(r, c), state.board));
        }
      }
    }
    return normalMoves;
  }

  /// Applies a [move] to the [currentState] and returns the resulting [GameState].
  GameState applyMove(GameState currentState, Move move, ZobristHash zobrist) {
    return GameRules.defaultApplyMove(this, currentState, move, zobrist);
  }

  /// Checks if there is a winner in the current [state].
  /// 
  /// Returns [Player.white] or [Player.black] if one has won, or null if the game continues.
  Player? checkForWinner(GameState state) {
    // If the current player has no legal moves, the opponent wins.
    if (state.possibleMoves.isEmpty) {
      return state.currentPlayer == PieceColor.white ? Player.black : Player.white;
    }

    // Check if either player has run out of pieces.
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
    return null;
  }

  /// Default implementation for applying a move to the game state.
  /// 
  /// This method handles:
  /// 1. Updating the board and Zobrist hash (removing moving/captured pieces, placing piece at destination).
  /// 2. Checking for and applying piece promotion.
  /// 3. Determining if the turn continues (multiple captures) or ends.
  static GameState defaultApplyMove(GameRules rules, GameState currentState, Move move, ZobristHash zobrist) {
    var board = currentState.board.map((row) => List.of(row)).toList();
    var newHash = currentState.boardHash;
    final movingPiece = board[move.from.row][move.from.col]!;

    // 1. Update the board and hash.
    // Remove the piece from its starting position.
    newHash ^= zobrist.getPieceHash(move.from.row, move.from.col, movingPiece);
    board[move.from.row][move.from.col] = null;

    // Remove all captured pieces from the board and update hash.
    for (final capturedPos in move.capturedPieces) {
      final capturedPiece = board[capturedPos.row][capturedPos.col]!;
      newHash ^= zobrist.getPieceHash(capturedPos.row, capturedPos.col, capturedPiece);
      board[capturedPos.row][capturedPos.col] = null;
    }

    // Place the moving piece at its final destination.
    final finalDestination = move.finalDestination;
    board[finalDestination.row][finalDestination.col] = movingPiece;
    newHash ^= zobrist.getPieceHash(finalDestination.row, finalDestination.col, movingPiece);

    // 2. Promotion check.
    var pieceAtDestination = board[finalDestination.row][finalDestination.col]!;
    bool promotionOccurred = false;
    if (pieceAtDestination.type == PieceType.man && rules.isPromotionSquare(finalDestination, pieceAtDestination.color)) {
      final promotedPiece = pieceAtDestination.promote();
      board[finalDestination.row][finalDestination.col] = promotedPiece;
      // Update hash for promotion (remove man, add king).
      newHash ^= zobrist.getPieceHash(finalDestination.row, finalDestination.col, pieceAtDestination);
      newHash ^= zobrist.getPieceHash(finalDestination.row, finalDestination.col, promotedPiece);
      pieceAtDestination = promotedPiece;
      promotionOccurred = true;
    }

    // 3. Create a temporary state to evaluate possible follow-up moves.
    final tempState = GameState(
      board: board,
      gameMode: currentState.gameMode,
      currentPlayer: currentState.currentPlayer,
      whitePlayerType: currentState.whitePlayerType,
      blackPlayerType: currentState.blackPlayerType,
      boardHash: newHash,
      lastMoveInSequence: move, // Pass the current move to the next step.
    );

    // 4. MULTIPLE CAPTURE CHECK.
    // Find all possible capture moves starting from the new position.
    final allPossibleFollowUps = rules.captureStrategy.findAllCaptureMoves(tempState)
        .where((m) => m.from == finalDestination)
        .toList();

    // Filter follow-up moves based on the variant's capture rules (e.g., must take max pieces).
    final filteredFollowUps = rules.captureRule.filter(allPossibleFollowUps, tempState);

    // 5. Determine if the move sequence continues.
    // A turn continues if a capture was made, there are more captures possible,
    // and the rule allows it (e.g., kings might not be allowed to continue immediately after promotion).
    final bool canContinue = !promotionOccurred || rules.kingCanContinueCaptureAfterPromotion;

    if (move.isCapture && filteredFollowUps.isNotEmpty && canContinue) {
      // MULTIPLE CAPTURE CONTINUES: Return state for the same player.
      return currentState.copyWith(
        board: board,
        boardHash: newHash,
        possibleMoves: filteredFollowUps,
        selectedPosition: () => finalDestination,
        lastMoveInSequence: () => move,
      );
    } else {
      // TURN ENDED: Switch to the next player.
      final nextPlayer = currentState.currentPlayer == PieceColor.white ? PieceColor.black : PieceColor.white;
      final finalHash = newHash ^ zobrist.playerHash; // Toggle player bit in Zobrist hash.
      final nextTurnState = GameState(
          board: board,
          gameMode: currentState.gameMode,
          currentPlayer: nextPlayer,
          whitePlayerType: currentState.whitePlayerType,
          blackPlayerType: currentState.blackPlayerType,
          boardHash: finalHash
      );
      // Pre-calculate possible moves for the next player.
      final opponentPossibleMoves = rules.getPossibleMoves(nextTurnState);
      return nextTurnState.copyWith(
        selectedPosition: () => null,
        possibleMoves: opponentPossibleMoves,
        lastMoveInSequence: () => null,
      );
    }
  }
}
