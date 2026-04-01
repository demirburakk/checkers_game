import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial.dart';
import 'package:checkers_game/domain/rules/losing_rules.dart';

import '../models/tutorial_step.dart';

/// Defines the tutorial for Losing Draughts (Anti-Checkers/Suicide Checkers).
/// In this mode, the goal is to lose all pieces or be unable to move.
/// This tutorial covers the objective, mandatory captures, and strategy (traps).
Tutorial losingTutorial(AppLocalizations l10n) => Tutorial(
  title: l10n.gameModeAntiCheckersName,
  steps: [
    // Step 1: Objective of the Game
    TutorialStep(
      title: l10n.tutorialStepLosingAimTitle,
      description: l10n.tutorialStepLosingAimDesc,
      initialState: GameState(
        board: LosingRules().initializeBoard(),
        gameMode: GameMode.antiCheckers,
      ),
    ),

    // Step 2: Mandatory Captures (Forcing the opponent to take your pieces)
    TutorialStep(
      title: l10n.tutorialStepMandatoryCaptureTitle,
      description: l10n.tutorialStepMandatoryCaptureDescLosing,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(5, 2): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(4, 3): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(7, 0): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(2, 1): Piece(id: 'b2', color: PieceColor.black),
        }),
        gameMode: GameMode.antiCheckers,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 2),
        to: BoardPosition(3, 4),
        capturedPieces: [BoardPosition(4, 3)],
      ),
    ),

    // Step 3: Setting a Trap
    TutorialStep(
      title: l10n.tutorialStepTrapTitle,
      description: l10n.tutorialStepTrapDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(5, 0): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(2, 3): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(7, 2): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(1, 2): Piece(id: 'b2', color: PieceColor.black),
        }),
        gameMode: GameMode.antiCheckers,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 0),
        to: BoardPosition(4, 1),
      ),
    ),

    // Step 4: Falling into the Trap (Mandatory capture for the opponent)
    TutorialStep(
      title: l10n.tutorialStepFallingIntoTrapTitle,
      description: l10n.tutorialStepFallingIntoTrapDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(4, 1): Piece(id: 'w1', color: PieceColor.white), // Piece sacrificed by White
          const BoardPosition(2, 3): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(7, 2): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(1, 2): Piece(id: 'b2', color: PieceColor.black),
        }),
        gameMode: GameMode.antiCheckers,
        currentPlayer: PieceColor.black, // Black's turn
      ),
      moveToShow: const Move(
        from: BoardPosition(2, 3),
        to: BoardPosition(5, 0),
        capturedPieces: [BoardPosition(4, 1)],
      ),
    ),

    // Step 5: Endgame Goal
    TutorialStep(
      title: l10n.tutorialStepLosingEndgameTitle,
      description: l10n.tutorialStepLosingEndgameDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(2, 3): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(0, 5): Piece(id: 'b2', color: PieceColor.black),
        }),
        gameMode: GameMode.antiCheckers,
      ),
    ),

    // Step 6: Draw Rules
    TutorialStep(
        title: l10n.tutorialStepDrawTitle,
        description: l10n.tutorialStepDrawDescLosing,
        initialState: GameState(
            board: _createBoardFromMap({
                const BoardPosition(0, 1): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
                const BoardPosition(2, 3): Piece(id: 'b1', color: PieceColor.black, type: PieceType.king),
            }),
            gameMode: GameMode.antiCheckers
        )
    )
  ],
);

/// A helper function that creates a 2D board array from a map of [BoardPosition] and [Piece].
/// This is used to set up specific scenarios for Losing tutorial steps.
List<List<Piece?>> _createBoardFromMap(Map<BoardPosition, Piece> pieces, {int boardSize = 8}) {
  final board = List.generate(boardSize, (_) => List<Piece?>.filled(boardSize, null));
  for (var entry in pieces.entries) {
    board[entry.key.row][entry.key.col] = entry.value;
  }
  return board;
}
