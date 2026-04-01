import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/game_rules.dart';

/// Defines the strategy for piece capture logic and algorithms.
///
/// This abstract class provides the core framework for identifying all possible 
/// capture sequences (including multi-jump chains) according to specific game rules.
/// Capture logic is usually recursive because a single move can involve multiple 
/// jumps if more opponent pieces are reachable after the first jump.
abstract class CaptureStrategy {
  /// The size of the checkers board (e.g., 8, 10, or 12 squares per side).
  final int boardSize;

  CaptureStrategy(this.boardSize);

  /// Finds all possible capture move chains for the current player in the given [state].
  ///
  /// This method iterates through the entire board, finds every piece belonging 
  /// to the current player, and calculates all potential capture sequences starting 
  /// from each piece.
  /// 
  /// Returns a list of [Move] objects, where each Move may contain a sequence of 
  /// individual jumps.
  List<Move> findAllCaptureMoves(GameState state) {
    List<Move> allMoves = [];
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        final piece = state.board[r][c];
        // Only consider pieces belonging to the current player.
        if (piece != null && piece.color == state.currentPlayer) {
          // Use a clone of the board to simulate jumps without modifying the actual state.
          // This is necessary because multi-jumps remove pieces from the board during the sequence.
          final boardClone = state.board.map((row) => List<Piece?>.from(row)).toList();
          allMoves.addAll(_findCapturePathsForPiece(boardClone, BoardPosition(r, c), piece.type, state.rules));
        }
      }
    }
    return allMoves;
  }

  /// Initiates a recursive search for all capture sequences starting from [startPos].
  ///
  /// [board] is the simulated board state.
  /// [startPos] is where the capture sequence begins.
  /// [originalStartPieceType] tracks whether the piece started as a man or a king.
  /// [rules] provides the specific game rules (e.g., promotion rules).
  List<Move> _findCapturePathsForPiece(
    List<List<Piece?>> board,
    BoardPosition startPos,
    PieceType originalStartPieceType,
    GameRules rules,
  ) {
    List<Move> sequences = [];
    _findCapturePathsRecursive(
      board,
      startPos,
      [], // currentPath: stores the sequence of jumps in the current branch.
      [], // capturedInPath: stores the positions of captured pieces in the current branch.
      sequences,
      rules,
      originalStartPieceType,
      promotionHasOccurredInPath: false, // Initially, no promotion has occurred.
    );
    return sequences;
  }

  /// Recursively explores all possible capture paths from [currentPos].
  ///
  /// This method handles complex logic such as multi-jumps, mid-sequence promotions,
  /// and rule-specific restrictions on whether a piece can continue capturing after 
  /// reaching a promotion square.
  void _findCapturePathsRecursive(
    List<List<Piece?>> board,
    BoardPosition currentPos,
    List<Move> currentPath,
    List<BoardPosition> capturedInPath,
    List<Move> allSequences,
    GameRules rules,
    PieceType originalStartPieceType,
    {required bool promotionHasOccurredInPath}
  ) {
    final pieceOnSquare = board[currentPos.row][currentPos.col];
    if (pieceOnSquare == null) return;

    // Determine the effective piece type for finding the next jump.
    // If it started as a king or promoted during this sequence, it acts as a king.
    // This is important for variants like International where a man stays a man 
    // until the end of the turn, vs Russian where it promotes instantly.
    final Piece pieceToUseForFindingJumps =
        (promotionHasOccurredInPath || originalStartPieceType == PieceType.king)
            ? pieceOnSquare.promote() // Effectively treat as a king
            : pieceOnSquare;

    // Identify all immediate single-jump moves from the current position.
    final availableJumps = getJumpsFrom(board, currentPos, pieceToUseForFindingJumps, capturedInPath);

    if (availableJumps.isEmpty) {
      // Base case: If no further jumps are possible from this position, 
      // the current path is a complete capture sequence.
      if (currentPath.isNotEmpty) {
        allSequences.add(Move(
          from: currentPath.first.from,
          to: currentPath.last.finalDestination,
          capturedPieces: List.from(capturedInPath),
          sequence: List.from(currentPath),
          // Indicate if the man was promoted to a king during this specific capture chain.
          becomesKing: (originalStartPieceType == PieceType.man && promotionHasOccurredInPath),
        ));
      }
    } else {
      // Recursive step: Try every possible jump from the current square.
      for (final jump in availableJumps) {
        final capturedPiecePos = jump.capturedPieces.first;
        final capturedPiece = board[capturedPiecePos.row][capturedPiecePos.col];
        if (capturedPiece == null) continue;

        // Simulate the jump on the temporary board.
        final pieceAtJumpOrigin = board[jump.from.row][jump.from.col]!;
        board[jump.to.row][jump.to.col] = pieceAtJumpOrigin;
        board[jump.from.row][jump.from.col] = null;
        
        // RULE: In most variants, captured pieces are removed immediately (e.g., Russian).
        // In others (e.g., International), they are removed only at the end of the move,
        // but cannot be jumped twice. We handle this by passing `capturedInPath`.
        board[capturedPiecePos.row][capturedPiecePos.col] = null;

        currentPath.add(jump);
        capturedInPath.add(capturedPiecePos);

        // Check if this specific jump lands the piece on a promotion square.
        bool promotionHappenedAtThisSpecificJump = false;
        if (originalStartPieceType == PieceType.man && !promotionHasOccurredInPath) {
          if (rules.isPromotionSquare(jump.to, pieceAtJumpOrigin.color)) {
            promotionHappenedAtThisSpecificJump = true;
          }
        }
        
        // Some rules (e.g., International) allow continuing captures after promotion only 
        // if the piece was already a king, or they stop the turn upon promotion.
        if (promotionHappenedAtThisSpecificJump && !rules.kingCanContinueCaptureAfterPromotion) {
          allSequences.add(Move(
            from: currentPath.first.from,
            to: jump.to,
            capturedPieces: List.from(capturedInPath),
            sequence: List.from(currentPath),
            becomesKing: true,
          ));
        } else {
          // Recurse to find the next jump in the sequence from the new position.
          _findCapturePathsRecursive(
            board,
            jump.to,
            currentPath,
            capturedInPath,
            allSequences,
            rules,
            originalStartPieceType,
            promotionHasOccurredInPath: promotionHasOccurredInPath || promotionHappenedAtThisSpecificJump,
          );
        }

        // Backtrack: Restore the board state and path to explore other branching paths.
        capturedInPath.removeLast();
        currentPath.removeLast();
        board[jump.from.row][jump.from.col] = pieceAtJumpOrigin;
        board[jump.to.row][jump.to.col] = null;
        board[capturedPiecePos.row][capturedPiecePos.col] = capturedPiece;
      }
    }
  }

  /// Returns a list of single-jump moves from [from] for the given [piece].
  ///
  /// This must be implemented by concrete classes to account for rule differences 
  /// like orthogonal vs. diagonal jumping or flying kings.
  List<Move> getJumpsFrom(List<List<Piece?>> board, BoardPosition from, Piece piece, List<BoardPosition> capturedInPath);

  /// Utility to check if [pos] is within the board's boundaries.
  bool isOnBoard(BoardPosition pos) {
    return pos.row >= 0 && pos.row < boardSize && pos.col >= 0 && pos.col < boardSize;
  }
}

/// Capture strategy for English/American Checkers (Straight Checkers).
///
/// Key rules:
/// - Men jump only forward diagonally. 
/// - Kings jump in all four diagonal directions.
/// - Captured pieces are removed immediately.
class EnglishCaptureStrategy extends CaptureStrategy {
  EnglishCaptureStrategy(super.boardSize);

  @override
  List<Move> getJumpsFrom(List<List<Piece?>> board, BoardPosition from, Piece piece, List<BoardPosition> capturedInPath) {
    final List<Move> jumps = [];
    final directions = [[-1, -1], [-1, 1], [1, -1], [1, 1]];

    // Determine relevant directions: men only jump forward, kings jump in all directions.
    final manForwardDirections = piece.color == PieceColor.white
        ? directions.where((d) => d[0] == -1)
        : directions.where((d) => d[0] == 1);

    final relevantDirections = piece.type == PieceType.man ? manForwardDirections : directions;

    for (var dir in relevantDirections) {
      final jumpedPos = BoardPosition(from.row + dir[0], from.col + dir[1]);
      final toPos = BoardPosition(from.row + 2 * dir[0], from.col + 2 * dir[1]);
      
      if (_isValidJump(board, from, jumpedPos, toPos, capturedInPath)) {
        jumps.add(Move(from: from, to: toPos, capturedPieces: [jumpedPos]));
      }
    }
    return jumps;
  }

  /// Validates if a single jump from [from] over [jumped] to [to] is legal.
  bool _isValidJump(List<List<Piece?>> board, BoardPosition from, BoardPosition jumped, BoardPosition to, List<BoardPosition> capturedInPath) {
    if (!isOnBoard(to) || !isOnBoard(jumped)) return false;

    final currentPiece = board[from.row][from.col];
    final pieceToJump = board[jumped.row][jumped.col];
    final destination = board[to.row][to.col];

    return currentPiece != null &&
        pieceToJump != null &&
        pieceToJump.color != currentPiece.color && // Must jump an opponent's piece.
        destination == null && // Landing square must be empty.
        !capturedInPath.contains(jumped); // Cannot jump the same piece twice in one chain.
  }
}

/// Capture strategy for Turkish Checkers (Dama).
///
/// Turkish Draughts has several unique and complex rules:
/// - Movement and jumping are orthogonal (no diagonals).
/// - Men jump forward, left, or right.
/// - Pieces are NOT removed until the end of the sequence (Huffing).
/// - Kings are "Flying Kings" that can jump over any number of empty squares, 
///   capture one opponent, and land on any empty square beyond it.
/// - A piece that promotes during a sequence only gains king powers from the next turn.
class TurkishCaptureStrategy extends CaptureStrategy {
  TurkishCaptureStrategy(super.boardSize);

  final List<List<int>> _orthogonalDirections = const [[-1, 0], [1, 0], [0, -1], [0, 1]];

  @override
  List<Move> findAllCaptureMoves(GameState state) {
    List<Move> allMoves = [];
    final lastMove = state.lastMoveInSequence;

    // In Turkish Draughts, if a piece starts capturing, it must finish its sequence.
    // If we are in the middle of a multi-jump sequence, only continue with the moving piece.
    if (lastMove != null && lastMove.isCapture) {
      final piece = state.board[lastMove.to.row][lastMove.to.col];
      if (piece != null && piece.color == state.currentPlayer) {
        final boardClone = state.board.map((row) => List<Piece?>.from(row)).toList();
        allMoves.addAll(_findTurkishCapturePathsForPiece(boardClone, lastMove.to, lastMove, state.rules, piece.type));
      }
    } else {
      // Otherwise, check every piece of the current player to start a new capture.
      for (int r = 0; r < boardSize; r++) {
        for (int c = 0; c < boardSize; c++) {
          final piece = state.board[r][c];
          if (piece != null && piece.color == state.currentPlayer) {
            final boardClone = state.board.map((row) => List<Piece?>.from(row)).toList();
            allMoves.addAll(_findTurkishCapturePathsForPiece(boardClone, BoardPosition(r, c), null, state.rules, piece.type));
          }
        }
      }
    }
    return allMoves;
  }

  /// Turkish Draughts specific search to handle its unique multi-jump rules.
  List<Move> _findTurkishCapturePathsForPiece(List<List<Piece?>> board, BoardPosition startPos, Move? lastMove, GameRules rules, PieceType originalStartPieceType) {
    List<Move> sequences = [];
    _turkishRecursiveSearch(
      board,
      startPos,
      [], // currentPath
      [], // capturedInPath
      sequences,
      {startPos}, // visitedOnPath: Turkish rules prevent a king from landing on a square it already visited.
      lastMove, 
      rules,
      originalStartPieceType,
      false // promotionHasOccurredInPath
    );
    return sequences;
  }

  /// Turkish Draughts recursive search with visited path tracking and promotion logic.
  void _turkishRecursiveSearch(
      List<List<Piece?>> board,
      BoardPosition currentPos,
      List<Move> currentPath,
      List<BoardPosition> capturedInPath,
      List<Move> allSequences,
      Set<BoardPosition> visitedOnPath,
      Move? lastMove,
      GameRules rules,
      PieceType originalStartPieceType,
      bool promotionHasOccurredInPath
      ) {
    final originalPieceOnSquare = board[currentPos.row][currentPos.col];
    if (originalPieceOnSquare == null) return;

    // RULE: In Turkish Draughts, if a man promotes mid-capture, it continues 
    // to jump like a man for the rest of that turn. It only gains king powers 
    // from the next turn onwards.
    bool currentStepPromotion = originalStartPieceType == PieceType.man && rules.isPromotionSquare(currentPos, originalPieceOnSquare.color);
    bool newPromotionOccurredInPath = promotionHasOccurredInPath || currentStepPromotion;

    final Piece pieceToUse;
    if (newPromotionOccurredInPath) {
      // Force man-like movement behavior even if promoted during this sequence.
      pieceToUse = originalPieceOnSquare.copyWith(type: PieceType.man);
    } else {
      pieceToUse = originalPieceOnSquare;
    }

    final availableJumps = _getAvailableJumps(board, currentPos, pieceToUse, capturedInPath, visitedOnPath, currentPath.isEmpty ? lastMove : currentPath.last);

    if (availableJumps.isEmpty) {
      if (currentPath.isNotEmpty) {
        allSequences.add(Move(
          from: currentPath.first.from,
          to: currentPath.last.finalDestination,
          capturedPieces: List.from(capturedInPath),
          sequence: List.from(currentPath),
          becomesKing: (originalStartPieceType == PieceType.man && newPromotionOccurredInPath),
        ));
      }
    } else {
      for (final jump in availableJumps) {
        final capturedPiecePos = jump.capturedPieces.first;
        final capturedPiece = board[capturedPiecePos.row][capturedPiecePos.col];
        if (capturedPiece == null) continue;

        // Update visited squares for the king's path constraint (cannot land on same square twice).
        final newVisitedOnPath = Set<BoardPosition>.from(visitedOnPath);
        int dx = (jump.to.col - jump.from.col).sign;
        int dy = (jump.to.row - jump.from.row).sign;
        BoardPosition tempPos = jump.from;
        while (tempPos != jump.to) {
          tempPos = BoardPosition(tempPos.row + dy, tempPos.col + dx);
          newVisitedOnPath.add(tempPos);
        }

        final pieceAtJumpOrigin = board[jump.from.row][jump.from.col]!;
        board[jump.to.row][jump.to.col] = pieceAtJumpOrigin;
        board[jump.from.row][jump.from.col] = null;
        board[capturedPiecePos.row][capturedPiecePos.col] = null;
        
        currentPath.add(jump);
        capturedInPath.add(capturedPiecePos);

        _turkishRecursiveSearch(board, jump.to, currentPath, capturedInPath, allSequences, newVisitedOnPath, jump, rules, originalStartPieceType, newPromotionOccurredInPath);

        // Backtrack
        capturedInPath.removeLast();
        currentPath.removeLast();
        board[jump.from.row][jump.from.col] = pieceAtJumpOrigin;
        board[jump.to.row][jump.to.col] = null;
        board[capturedPiecePos.row][capturedPiecePos.col] = capturedPiece;
      }
    }
  }

  /// Calculates available jumps considering Turkish Draughts' orthogonal movement 
  /// and king capture rules (flying over any distance).
  List<Move> _getAvailableJumps(List<List<Piece?>> board, BoardPosition from, Piece piece, List<BoardPosition> capturedInPath, Set<BoardPosition> visitedOnPath, Move? lastMove) {
    final List<Move> jumps = [];

    if (piece.type == PieceType.man) {
      // Men jump forward, left, or right orthogonally.
      final manDirections = piece.color == PieceColor.white
          ? [[-1, 0], [0, -1], [0, 1]]
          : [[1, 0], [0, -1], [0, 1]];

      for (var dir in manDirections) {
        final jumpedPos = BoardPosition(from.row + dir[0], from.col + dir[1]);
        final toPos = BoardPosition(from.row + 2 * dir[0], from.col + 2 * dir[1]);
        if (_isValidSimpleJump(board, from, jumpedPos, toPos, capturedInPath)) {
          jumps.add(Move(from: from, to: toPos, capturedPieces: [jumpedPos]));
        }
      }
    } else { 
      // King Logic: Can fly over empty squares, jump one opponent piece, 
      // and land on any subsequent empty square in that direction.
      for (var dir in _orthogonalDirections) {
        // RULE: A king cannot immediately jump back in the direction it just came from 
        // if it's continuing a multi-jump sequence.
        if (lastMove != null) {
          int lastDy = (from.row - lastMove.from.row).sign;
          int lastDx = (from.col - lastMove.from.col).sign;
          if (dir[0] == -lastDy && dir[1] == -lastDx && (lastDx != 0 || lastDy != 0)) {
            continue;
          }
        }

        BoardPosition? capturedPiecePosLocal;
        for (int i = 1; i < boardSize; i++) {
          final pos = BoardPosition(from.row + i * dir[0], from.col + i * dir[1]);
          if (!isOnBoard(pos)) break;
          
          // King cannot land on or fly over squares it already occupied in this sequence.
          if (visitedOnPath.contains(pos) && pos != from ) break; 

          final p = board[pos.row][pos.col];
          if (p != null) {
            // Check if the encountered piece is an opponent and hasn't been captured yet.
            if (p.color != piece.color && !capturedInPath.contains(pos)) {
              capturedPiecePosLocal = pos;
            }
            break; // A king can only jump over exactly one piece at a time.
          }
        }

        // If an opponent was found, identify all valid landing squares beyond it.
        if (capturedPiecePosLocal != null) {
          for (int j = 1; j < boardSize; j++) {
            final toPos = BoardPosition(capturedPiecePosLocal.row + j * dir[0], capturedPiecePosLocal.col + j * dir[1]);
            if (!isOnBoard(toPos)) break;
            
            // Cannot land on or leap over another piece.
            if (board[toPos.row][toPos.col] != null) break; 
            
            // King cannot land on squares it already visited in this sequence.
            if (visitedOnPath.contains(toPos) && toPos != from) continue; 
            
            jumps.add(Move(from: from, to: toPos, capturedPieces: [capturedPiecePosLocal]));
          }
        }
      }
    }
    return jumps;
  }

  /// Validates a simple orthogonal jump for a man.
  bool _isValidSimpleJump(List<List<Piece?>> board, BoardPosition from, BoardPosition jumped, BoardPosition to, List<BoardPosition> capturedInPath) {
    if (!isOnBoard(to) || !isOnBoard(jumped)) return false;
    final pieceToJump = board[jumped.row][jumped.col];
    final destination = board[to.row][to.col];
    final currentPiece = board[from.row][from.col];
    return currentPiece != null &&
        pieceToJump != null &&
        pieceToJump.color != currentPiece.color &&
        destination == null &&
        !capturedInPath.contains(jumped);
  }

  @override
  List<Move> getJumpsFrom(List<List<Piece?>> board, BoardPosition from, Piece piece, List<BoardPosition> capturedInPath) {
    // Basic wrapper to satisfy abstract requirements; complex Turkish logic uses _getAvailableJumps directly.
    return _getAvailableJumps(board, from, piece, capturedInPath, {from}, null);
  }
}

/// Capture strategy for International Checkers (10x10).
///
/// Key rules:
/// - Men jump diagonally in all four directions (both forward and backward).
/// - Kings are "Flying Kings" and can jump diagonally over any distance.
/// - Captured pieces are removed ONLY after the entire sequence is complete.
/// - A piece cannot jump the same opponent piece twice in a single sequence.
class InternationalCaptureStrategy extends CaptureStrategy {
  InternationalCaptureStrategy(super.boardSize);

  final List<List<int>> _diagonalDirections = const [[-1, -1], [-1, 1], [1, -1], [1, 1]];

  @override
  List<Move> getJumpsFrom(List<List<Piece?>> board, BoardPosition from, Piece piece, List<BoardPosition> capturedInPath) {
    final List<Move> jumps = [];

    if (piece.type == PieceType.man) {
      // Men can jump diagonally in all four directions.
      for (var dir in _diagonalDirections) {
        final jumpedPos = BoardPosition(from.row + dir[0], from.col + dir[1]);
        final toPos = BoardPosition(from.row + 2 * dir[0], from.col + 2 * dir[1]);
        if (_isValidJump(board, from, jumpedPos, toPos, capturedInPath)) {
          jumps.add(Move(from: from, to: toPos, capturedPieces: [jumpedPos]));
        }
      }
    } else { 
      // Flying King: Can jump over an opponent at any distance on a diagonal 
      // and land on any empty square behind it.
      for (var dir in _diagonalDirections) {
        BoardPosition? capturedPiecePosLocal;
        for (int i = 1; i < boardSize; i++) {
          final pos = BoardPosition(from.row + i * dir[0], from.col + i * dir[1]);
          if (!isOnBoard(pos)) break;
          final p = board[pos.row][pos.col];
          if (p != null) {
            if (p.color != piece.color && !capturedInPath.contains(pos)) {
              capturedPiecePosLocal = pos;
            }
            break; // Stop at first piece.
          }
        }
        
        // If an opponent piece was found, find all possible landing squares beyond it.
        if (capturedPiecePosLocal != null) {
          for (int j = 1; j < boardSize; j++) {
            final toPos = BoardPosition(capturedPiecePosLocal.row + j * dir[0], capturedPiecePosLocal.col + j * dir[1]);
            // Square must be on board and empty.
            if (!isOnBoard(toPos) || board[toPos.row][toPos.col] != null) break;
            jumps.add(Move(from: from, to: toPos, capturedPieces: [capturedPiecePosLocal]));
          }
        }
      }
    }
    return jumps;
  }

  /// Standard diagonal jump validation.
  bool _isValidJump(List<List<Piece?>> board, BoardPosition from, BoardPosition jumped, BoardPosition to, List<BoardPosition> capturedInPath) {
    if (!isOnBoard(to) || !isOnBoard(jumped)) return false;
    final pieceToJump = board[jumped.row][jumped.col];
    final destination = board[to.row][to.col];
    final currentPiece = board[from.row][from.col];
    return currentPiece != null &&
        pieceToJump != null &&
        pieceToJump.color != currentPiece.color &&
        destination == null &&
        !capturedInPath.contains(jumped);
  }
}

/// Capture strategy for Spanish Checkers.
///
/// Similar to International, but with one key difference:
/// - Men can only jump FORWARD diagonally (unlike International where they jump 4 ways).
/// - Kings remain flying kings.
class SpanishCaptureStrategy extends CaptureStrategy {
  SpanishCaptureStrategy(super.boardSize);

  final List<List<int>> _diagonalDirections = const [[-1, -1], [-1, 1], [1, -1], [1, 1]];

  @override
  List<Move> getJumpsFrom(List<List<Piece?>> board, BoardPosition from, Piece piece, List<BoardPosition> capturedInPath) {
    final List<Move> jumps = [];

    if (piece.type == PieceType.man) {
      // RULE: Men only jump in forward diagonal directions.
      final manForwardDirections = piece.color == PieceColor.white
          ? _diagonalDirections.where((d) => d[0] == -1)
          : _diagonalDirections.where((d) => d[0] == 1);

      for (var dir in manForwardDirections) {
        final jumpedPos = BoardPosition(from.row + dir[0], from.col + dir[1]);
        final toPos = BoardPosition(from.row + 2 * dir[0], from.col + 2 * dir[1]);
        if (_isValidJump(board, from, jumpedPos, toPos, capturedInPath)) {
          jumps.add(Move(from: from, to: toPos, capturedPieces: [jumpedPos]));
        }
      }
    } else { 
      // Kings jump like flying kings (same as International).
      for (var dir in _diagonalDirections) {
        BoardPosition? capturedPiecePosLocal;
        for (int i = 1; i < boardSize; i++) {
          final pos = BoardPosition(from.row + i * dir[0], from.col + i * dir[1]);
          if (!isOnBoard(pos)) break;
          final p = board[pos.row][pos.col];
          if (p != null) {
            if (p.color != piece.color && !capturedInPath.contains(pos)) {
              capturedPiecePosLocal = pos;
            }
            break;
          }
        }
        if (capturedPiecePosLocal != null) {
          for (int j = 1; j < boardSize; j++) {
            final toPos = BoardPosition(capturedPiecePosLocal.row + j * dir[0], capturedPiecePosLocal.col + j * dir[1]);
            if (!isOnBoard(toPos) || board[toPos.row][toPos.col] != null) break;
            jumps.add(Move(from: from, to: toPos, capturedPieces: [capturedPiecePosLocal]));
          }
        }
      }
    }
    return jumps;
  }

  bool _isValidJump(List<List<Piece?>> board, BoardPosition from, BoardPosition jumped, BoardPosition to, List<BoardPosition> capturedInPath) {
    if (!isOnBoard(to) || !isOnBoard(jumped)) return false;
    final pieceToJump = board[jumped.row][jumped.col];
    final destination = board[to.row][to.col];
    final currentPiece = board[from.row][from.col];
    return currentPiece != null &&
        pieceToJump != null &&
        pieceToJump.color != currentPiece.color &&
        destination == null &&
        !capturedInPath.contains(jumped);
  }
}

/// Capture strategy for Italian Checkers.
///
/// Italian Draughts (Dama Italiana) has strict jumping restrictions:
/// - Men only jump forward. 
/// - Kings jump in all 4 diagonal directions but are NOT flying kings 
///   (they only jump one square over an adjacent opponent). 
/// - RULE: Men CANNOT jump kings.
/// - Mandatory capture rules are handled by ItalianCaptureRule (filter).
class ItalianCaptureStrategy extends CaptureStrategy {
  ItalianCaptureStrategy(super.boardSize);

  @override
  List<Move> getJumpsFrom(List<List<Piece?>> board, BoardPosition from, Piece piece, List<BoardPosition> capturedInPath) {
    final List<Move> jumps = [];
    final directions = [[-1, -1], [-1, 1], [1, -1], [1, 1]];

    if (piece.type == PieceType.man) {
      // Men jump forward only.
      final manForwardDirections = piece.color == PieceColor.white
          ? directions.where((d) => d[0] == -1)
          : directions.where((d) => d[0] == 1);

      for (var dir in manForwardDirections) {
        final jumpedPos = BoardPosition(from.row + dir[0], from.col + dir[1]);
        if(!isOnBoard(jumpedPos)) continue;
        
        final pieceToJump = board[jumpedPos.row][jumpedPos.col];
        // SPECIAL RULE: Men cannot jump kings in Italian Draughts.
        if (pieceToJump?.type == PieceType.king) {
          continue; 
        }

        final toPos = BoardPosition(from.row + 2 * dir[0], from.col + 2 * dir[1]);
        if (_isValidJump(board, from, jumpedPos, toPos, capturedInPath)) {
          jumps.add(Move(from: from, to: toPos, capturedPieces: [jumpedPos]));
        }
      }
    } else { 
      // Kings jump exactly one step over an opponent in any of the four diagonal directions.
      for (var dir in directions) {
        final jumpedPos = BoardPosition(from.row + dir[0], from.col + dir[1]);
        final toPos = BoardPosition(from.row + 2 * dir[0], from.col + 2 * dir[1]);
        if (_isValidJump(board, from, jumpedPos, toPos, capturedInPath)) {
          jumps.add(Move(from: from, to: toPos, capturedPieces: [jumpedPos]));
        }
      }
    }
    return jumps;
  }

  bool _isValidJump(List<List<Piece?>> board, BoardPosition from, BoardPosition jumped, BoardPosition to, List<BoardPosition> capturedInPath) {
    if (!isOnBoard(to) || !isOnBoard(jumped)) return false;
    final pieceToJump = board[jumped.row][jumped.col];
    final destination = board[to.row][to.col];
    final currentPiece = board[from.row][from.col];
    return currentPiece != null &&
        pieceToJump != null &&
        pieceToJump.color != currentPiece.color &&
        destination == null &&
        !capturedInPath.contains(jumped);
  }
}

/// Capture strategy for Russian Checkers (Shashki).
///
/// Similar to International Draughts, but with a critical difference: 
/// - Instant Promotion: If a piece reaches the promotion line during a capture 
///   sequence, it IMMEDIATELY promotes to a king and continues jumping 
///   using its new king powers (flying king) in the same turn.
class RussianCaptureStrategy extends InternationalCaptureStrategy {
  RussianCaptureStrategy(super.boardSize);

  @override
  List<Move> _findCapturePathsForPiece(List<List<Piece?>> board, BoardPosition startPos, PieceType originalStartPieceType, GameRules rules) {
    List<Move> sequences = [];
    // Initiation of the specialized Russian Draughts recursive search.
    _russianRecursiveSearch(board, startPos, [], [], sequences, rules, originalStartPieceType, false);
    return sequences;
  }

  /// Specialized recursive search for Russian Draughts to handle instant promotion.
  void _russianRecursiveSearch(
      List<List<Piece?>> board,
      BoardPosition currentPos,
      List<Move> currentPath,
      List<BoardPosition> capturedInPath,
      List<Move> allSequences,
      GameRules rules, 
      PieceType originalStartPieceType, 
      bool promotionHasOccurredInPath
      ) {
    final pieceOnSquare = board[currentPos.row][currentPos.col];
    if (pieceOnSquare == null) return;

    // RULE: In Russian Draughts, a piece promotes as soon as it touches the promotion line.
    // This differs from English/International where it only promotes if it STOPS on the line.
    bool isCurrentlyPromoted = promotionHasOccurredInPath ||
                               (originalStartPieceType == PieceType.man && rules.isPromotionSquare(currentPos, pieceOnSquare.color));
    
    // If promoted, treat the piece as a king for the next stage of the search.
    final Piece pieceToUseForFindingJumps = isCurrentlyPromoted ? pieceOnSquare.promote() : pieceOnSquare;

    // Reuse jump logic from International Draughts (4-way man jumps, flying kings).
    final availableJumps = getJumpsFrom(board, currentPos, pieceToUseForFindingJumps, capturedInPath);

    if (availableJumps.isEmpty) {
      // If no more jumps are possible, record the sequence.
      if (currentPath.isNotEmpty) {
        allSequences.add(Move(
          from: currentPath.first.from,
          to: currentPath.last.finalDestination,
          capturedPieces: List.from(capturedInPath),
          sequence: List.from(currentPath),
          becomesKing: (originalStartPieceType == PieceType.man && isCurrentlyPromoted),
        ));
      }
    } else {
      for (final jump in availableJumps) {
        final capturedPiecePos = jump.capturedPieces.first;
        final capturedPiece = board[capturedPiecePos.row][capturedPiecePos.col];
        if (capturedPiece == null) continue;

        // Apply jump.
        final pieceAtJumpOrigin = board[jump.from.row][jump.from.col]!;
        board[jump.to.row][jump.to.col] = pieceAtJumpOrigin;
        board[jump.from.row][jump.from.col] = null;
        board[capturedPiecePos.row][capturedPiecePos.col] = null;

        currentPath.add(jump);
        capturedInPath.add(capturedPiecePos);

        // Recurse to find subsequent jumps, maintaining the "isPromoted" state.
        _russianRecursiveSearch(
            board,
            jump.to,
            currentPath,
            capturedInPath,
            allSequences,
            rules,
            originalStartPieceType,
            isCurrentlyPromoted
            );

        // Backtrack to explore other potential paths.
        capturedInPath.removeLast();
        currentPath.removeLast();
        board[jump.from.row][jump.from.col] = pieceAtJumpOrigin;
        board[jump.to.row][jump.to.col] = null;
        board[capturedPiecePos.row][capturedPiecePos.col] = capturedPiece;
      }
    }
  }
}
