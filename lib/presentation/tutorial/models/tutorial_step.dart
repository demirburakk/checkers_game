import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:flutter/cupertino.dart';
import 'package:checkers_game/providers/zobrist_hash.dart';

/// A model representing a single step within a tutorial.
/// 
/// Each step contains instructions, an initial board state, and optionally 
/// a move to demonstrate.
@immutable
class TutorialStep {
  /// The title of the tutorial step (e.g., "Pawn Movement").
  final String title;

  /// The descriptive text explaining the rules or concepts for this step.
  final String description;

  /// The [GameState] representing the board configuration at the start of this step.
  final GameState initialState;

  /// The move to be animated in this step.
  /// If null, the step just displays a static board state.
  final Move? moveToShow;

  /// The final [GameState] after the [moveToShow] is applied.
  /// The tutorial will transition to this state after the animation completes.
  final GameState endState;

  /// Creates a [TutorialStep] and automatically calculates the [endState].
  TutorialStep({
    required this.title,
    required this.description,
    required this.initialState,
    this.moveToShow,
  }) : endState = _calculateEndState(initialState, moveToShow);

  /// Calculates the final game state based on the initial state and the move to show.
  static GameState _calculateEndState(GameState initial, Move? move) {
    if (move == null) {
      // If no move is shown, the initial and final states are identical.
      return initial;
    }
    
    // Apply the move using the game rules. 
    // We create a temporary ZobristHash for the state transition calculation.
    return initial.rules.applyMove(
      initial, 
      move, 
      initial.rules.boardSize == 8 ? ZobristHash(8) : ZobristHash(10),
    );
  }
}
