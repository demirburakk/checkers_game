// lib/domain/ai/ai_player.dart
import 'dart:math';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/providers/zobrist_hash.dart';
import 'package:flutter/foundation.dart';

/// Type of entry in the Transposition Table.
/// Used to determine how to use the cached score during Alpha-Beta pruning.
enum TTEntryType { 
  /// The score is exact.
  exact, 
  /// The score is a lower bound (alpha cut-off).
  lowerBound, 
  /// The score is an upper bound (beta cut-off).
  upperBound 
}

/// A record representing an entry in the Transposition Table.
/// Stores the calculated score, the depth at which it was calculated, and the entry type.
typedef TTEntry = ({double score, int depth, TTEntryType type});

/// Transposition Table maps board hash (Zobrist) to a [TTEntry].
/// This allows reusing previously calculated evaluations for the same board states.
typedef TranspositionTable = Map<int, TTEntry>;

/// The AI Player class containing logic for move calculation using Minimax, Alpha-Beta pruning, 
/// and iterative deepening.
class AiPlayer {
  
  /// Finds the best move for the AI given the current [gameState] and difficulty [level].
  /// 
  /// Uses a combination of random moves for level 1 and iterative deepening search 
  /// for levels 2 and above.
  static Move findBestMove(GameState gameState, int level, ZobristHash zobrist) {
    // Check if there are any available moves. If not, the game might be over.
    // This prevents "Bad state: No element" errors when calling .first on empty lists.
    if (gameState.possibleMoves.isEmpty) {
      debugPrint("AI called with empty move list. The game should have ended.");
      // Throwing an exception allows the caller (e.g., GameProvider) to handle the 
      // end-game state gracefully instead of crashing.
      throw Exception("No moves available for AI.");
    }

    // Logic for Level 1: Randomly select any valid move.
    if (level == 1) {
      final random = Random();
      return gameState.possibleMoves[random.nextInt(gameState.possibleMoves.length)];
    }

    int timeLimitMs;
    int maxDepth;
    
    // Configure search depth and time limits based on the difficulty level.
    switch (level) {
      case 2: timeLimitMs = 500;  maxDepth = 3; break; // Shallow search for easy AI
      case 3: timeLimitMs = 1500; maxDepth = 5; break;
      case 4: timeLimitMs = 3000; maxDepth = 6; break;
      case 5: timeLimitMs = 5000; maxDepth = 7; break;
      case 6: timeLimitMs = 8000; maxDepth = 8; break;
      case 7: timeLimitMs = 12000; maxDepth = 9; break;
      default: timeLimitMs = 1500; maxDepth = 5;
    }

    Move? bestMoveOverall = gameState.possibleMoves.first;

    final stopwatch = Stopwatch()..start();
    final transpositionTable = TranspositionTable();

    // Iterative Deepening: Start searching from depth 1 and increase until maxDepth or time limit.
    // This ensures we always have a "best move" even if we run out of time for deeper searches.
    for (int currentDepth = 1; currentDepth <= maxDepth; currentDepth++) {
      if (stopwatch.elapsedMilliseconds > timeLimitMs) break;
      try {
        final bestMoveResult = _alphaBeta(
            gameState, currentDepth, double.negativeInfinity, double.infinity,
            true, gameState.currentPlayer, transpositionTable, zobrist, level);
        
        if (bestMoveResult.move != null) {
          bestMoveOverall = bestMoveResult.move;
        }
      } catch (e) {
        debugPrint("AI search at depth $currentDepth failed: $e");
        break;
      }
    }
    stopwatch.stop();

    return bestMoveOverall!;
  }

  /// Alpha-Beta pruning algorithm to efficiently explore the game tree.
  /// 
  /// [state]: Current game state being evaluated.
  /// [depth]: Remaining search depth.
  /// [alpha]: The best score that the maximizing player can guarantee.
  /// [beta]: The best score that the minimizing player can guarantee.
  /// [isMaximizingPlayer]: True if we are trying to maximize the score (AI's turn in simulation).
  /// [aiColor]: The color of the AI player.
  /// [tt]: Transposition Table for caching results.
  /// [zobrist]: Zobrist hashing instance.
  /// [level]: Difficulty level to determine evaluation complexity.
  static ({double score, Move? move}) _alphaBeta(
      GameState state, int depth, double alpha, double beta,
      bool isMaximizingPlayer, PieceColor aiColor,
      TranspositionTable tt, ZobristHash zobrist, int level
      ) {
    final int boardKey = state.boardHash;

    // Look up current board state in the Transposition Table.
    final ttEntry = tt[boardKey];
    if (ttEntry != null && ttEntry.depth >= depth) {
      if (ttEntry.type == TTEntryType.exact) {
        return (score: ttEntry.score, move: null);
      } else if (ttEntry.type == TTEntryType.lowerBound) {
        alpha = max(alpha, ttEntry.score);
      } else if (ttEntry.type == TTEntryType.upperBound) {
        beta = min(beta, ttEntry.score);
      }
      
      // Cut-off if possible.
      if (alpha >= beta) {
        return (score: ttEntry.score, move: null);
      }
    }

    // Base case: reaching depth limit. Switch to Quiescence search to handle captures.
    if (depth <= 0) {
      return (score: _quiescenceSearch(state, alpha, beta, isMaximizingPlayer, aiColor, zobrist, level), move: null);
    }
    
    // Base case: game over.
    if (state.rules.checkForWinner(state) != null || state.possibleMoves.isEmpty) {
      final score = (level <= 2)
          ? _simpleEvaluate(state, aiColor)
          : state.rules.evaluate(state, aiColor);
      return (score: score, move: null);
    }

    // Move Ordering: Evaluate most promising moves first (captures, becoming king) to improve pruning.
    final orderedMoves = _orderMoves(state.possibleMoves, state);
    Move? bestMove = orderedMoves.first;
    double bestScore;

    if (isMaximizingPlayer) {
      bestScore = double.negativeInfinity;
      for (final move in orderedMoves) {
        final newState = state.rules.applyMove(state, move, zobrist);
        final evalResult = _alphaBeta(newState, depth - 1, alpha, beta, false, aiColor, tt, zobrist, level);
        if (evalResult.score > bestScore) {
          bestScore = evalResult.score;
          bestMove = move;
        }
        alpha = max(alpha, bestScore);
        if (beta <= alpha) break; // Beta cut-off
      }
    } else { // Minimizing Player
      bestScore = double.infinity;
      for (final move in orderedMoves) {
        final newState = state.rules.applyMove(state, move, zobrist);
        final evalResult = _alphaBeta(newState, depth - 1, alpha, beta, true, aiColor, tt, zobrist, level);
        if (evalResult.score < bestScore) {
          bestScore = evalResult.score;
          bestMove = move;
        }
        beta = min(beta, bestScore);
        if (beta <= alpha) break; // Alpha cut-off
      }
    }

    // Cache the result in the Transposition Table before returning.
    TTEntryType entryType;
    if (bestScore <= alpha) {
      entryType = TTEntryType.upperBound;
    } else if (bestScore >= beta) {
      entryType = TTEntryType.lowerBound;
    } else {
      entryType = TTEntryType.exact;
    }
    tt[boardKey] = (score: bestScore, depth: depth, type: entryType);

    return (score: bestScore, move: bestMove);
  }

  /// Quiescence Search: Continues searching capture moves beyond the depth limit 
  /// to avoid the "horizon effect" where a move looks good only because the 
  /// following capture is hidden just past the search horizon.
  static double _quiescenceSearch(
      GameState state, double alpha, double beta,
      bool isMaximizingPlayer, PieceColor aiColor, ZobristHash zobrist, int level
      ) {
    // Static evaluation of the current position.
    final standPat = (level <= 2)
        ? _simpleEvaluate(state, aiColor)
        : state.rules.evaluate(state, aiColor);

    if (isMaximizingPlayer) {
      if (standPat >= beta) return beta;
      alpha = max(alpha, standPat);
    } else {
      if (standPat <= alpha) return alpha;
      beta = min(beta, standPat);
    }

    // Only consider capture moves in quiescence search.
    final captureMoves = state.rules.getPossibleMoves(state).where((m) => m.isCapture).toList();
    if (captureMoves.isEmpty) {
      return standPat;
    }

    final orderedCaptureMoves = _orderMoves(captureMoves, state);

    for (final move in orderedCaptureMoves) {
      final newState = state.rules.applyMove(state, move, zobrist);
      final score = _quiescenceSearch(newState, alpha, beta, !isMaximizingPlayer, aiColor, zobrist, level);
      if (isMaximizingPlayer) {
        alpha = max(alpha, score);
      } else {
        beta = min(beta, score);
      }
      if (alpha >= beta) break;
    }
    return isMaximizingPlayer ? alpha : beta;
  }

  /// Simple heuristic evaluation for lower difficulty levels.
  /// Counts the total material on the board.
  static double _simpleEvaluate(GameState state, PieceColor aiColor) {
    double score = 0;
    const double pieceValue = 1.0;
    const double kingValue = 3.0;

    // Nested loops to iterate through the 2D board array.
    for (final row in state.board) {
      for (final piece in row) {
        if (piece != null) {
          double value = piece.type == PieceType.king ? kingValue : pieceValue;
          if (piece.color == aiColor) {
            score += value;
          } else {
            score -= value;
          }
        }
      }
    }
    return score;
  }

  /// Orders moves to prioritize those more likely to be good (like captures).
  /// This helps Alpha-Beta pruning find cut-offs earlier, significantly improving performance.
  static List<Move> _orderMoves(List<Move> moves, GameState state) {
    moves.sort((a, b) {
      int scoreA = 0;
      int scoreB = 0;
      
      // Prioritize captures based on the number of pieces captured.
      if (a.isCapture) scoreA += 100 * a.capturedPieces.length;
      if (b.isCapture) scoreB += 100 * b.capturedPieces.length;
      
      // Prioritize moves that result in a king.
      if (a.becomesKing) scoreA += 50;
      if (b.becomesKing) scoreB += 50;
      
      return scoreB.compareTo(scoreA);
    });
    return moves;
  }
}
