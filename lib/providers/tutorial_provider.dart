// lib/providers/tutorial_provider.dart

import 'dart:async';
import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/draw_reason.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial_step.dart';
import 'package:checkers_game/providers/game_provider.dart';
import 'package:checkers_game/providers/settings_provider.dart';
import 'package:checkers_game/utils/sound_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:checkers_game/domain/models/game_mode.dart';

import '../presentation/utils/player_type.dart';

/// [TutorialProvider] handles the logic for a single tutorial step.
/// It implements [GameProvider] to allow the tutorial to use the same
/// [GameBoard] widget as the main game without modifying the widget's code.
class TutorialProvider with ChangeNotifier implements GameProvider {
  /// The specific tutorial step being presented.
  final TutorialStep _step;

  /// The current state of the game board for this tutorial step.
  @override
  late GameState gameState;

  /// Indicates if a loading process is active. Always false for tutorials.
  @override
  bool isLoading = false;

  /// The move currently being animated on the board.
  @override
  AnimatedMove? moveBeingAnimated;

  /// Initializes the provider with a tutorial step and sets up the initial game state.
  TutorialProvider(this._step) {
    // Initialize gameState in the constructor to avoid LateInitializationError.
    gameState = _step.initialState;
    settingsProvider = SettingsProvider(initialLocale: null)..init();
  }

  // --- Tutorial-Specific Methods and Getters ---

  /// Description of the current tutorial step.
  String get description => _step.description;

  /// Title of the current tutorial step.
  String get title => _step.title;

  /// The move to be demonstrated in this step, if any.
  Move? get moveToShow => _step.moveToShow;

  /// Plays the animation of the demonstration move defined in the tutorial step.
  Future<void> playAnimation() async {
    if (moveBeingAnimated != null || _step.moveToShow == null) return;

    final move = _step.moveToShow!;
    final pieceToMove = gameState.board[move.from.row][move.from.col];
    if (pieceToMove == null) return;

    // Create a temporary board to update during animation steps.
    var tempBoard = gameState.board.map((row) => List<Piece?>.from(row)).toList();
    gameState = gameState.copyWith(
        board: tempBoard,
        selectedPosition: () => null,
        possibleMoves: []);

    // Support for multiple steps in a single move (e.g., multiple captures).
    final steps = move.sequence.isNotEmpty ? move.sequence : [move];

    for (final step in steps) {
      // Remove captured pieces.
      for (var capturedPos in step.capturedPieces) {
        tempBoard[capturedPos.row][capturedPos.col] = null;
      }
      
      // Trigger the animation for this step.
      moveBeingAnimated = AnimatedMove(pieceToMove, step);
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 400));
      
      // Update piece position on the board.
      tempBoard[step.from.row][step.from.col] = null;
      tempBoard[step.to.row][step.to.col] = pieceToMove;
    }

    // Set final state after animation completes.
    gameState = _step.endState;
    moveBeingAnimated = null;
    notifyListeners();
  }

  /// Resets the tutorial step to its initial state.
  void reset() {
    moveBeingAnimated = null;
    gameState = _step.initialState;
    notifyListeners();
  }

  // --- GameProvider Interface Implementations ---
  // These are required by the GameProvider interface and expected by GameBoard,
  // but are mostly unused or return default values in the context of a tutorial.

  @override
  bool get isAiThinking => false;
  
  @override
  bool get isBoardFlipped => false;
  
  @override
  bool get isDialogShowing => false;
  
  @override
  set isDialogShowing(bool value) {}
  
  @override
  bool get isDraw => false;
  
  @override
  DrawReason? get drawReason => null;
  
  @override
  bool get isGameOver => false;
  
  @override
  void onSquareTapped(int row, int col) {
    // Taps are disabled during tutorials.
  }
  
  @override
  bool canUndo() => false;
  
  @override
  void undoMove() {}
  
  @override
  void resetGame({int? aiLevel}) {}
  
  @override
  void flipBoard() {}
  
  @override
  void clearHint() {}
  
  @override
  Future<void> getHint() async {}
  
  @override
  Future<void> saveCurrentGame() async {}
  
  @override
  Set<BoardPosition> get capturedPiecePositions => {};
  
  @override
  Move? get hintMove => null;
  
  @override
  Move? get lastMove => moveToShow;
  
  @override
  BoardPosition? get invalidSelectionPosition => null;
  
  @override
  late SettingsProvider settingsProvider;

  @override
  void updateSettings(SettingsProvider newSettingsProvider) {
    // This provider does not use settings, so this is a no-op.
  }
  
  @override
  bool get showCoordinates => true;
  
  @override
  SoundManager get soundManager => throw UnimplementedError(); // Not used directly in Tutorial
  
  @override
  Future<void> initializeGame({
    required GameMode gameMode,
    required PlayerType opponentType,
    bool loadFromSave = false,
    int aiLevel = 3,
  }) async {}
}