import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial.dart';
import 'package:checkers_game/domain/rules/spanish_rules.dart';

import '../models/tutorial_step.dart';

/// Defines the tutorial for Spanish Draughts (Damas).
/// This tutorial covers movement, mandatory captures (including king priority),
/// promotion, and flying king captures.
Tutorial spanishTutorial(AppLocalizations l10n) => Tutorial(
  title: l10n.gameModeSpanishName,
  steps: [
    // Step 1: Initial Setup
    TutorialStep(
      title: l10n.tutorialStepWelcomeTitle,
      description: l10n.tutorialStepWelcomeDescSpanish,
      initialState: GameState(
        board: SpanishRules().initializeBoard(),
        gameMode: GameMode.spanish,
      ),
    ),

    // Step 2: Man Movement and Capturing
    TutorialStep(
      title: l10n.tutorialStepManMoveTitle,
      description: l10n.tutorialStepManMoveDescSpanish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(5, 2): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(4, 3): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(2, 1): Piece(id: 'b2', color: PieceColor.black),
          const BoardPosition(6, 5): Piece(id: 'w2', color: PieceColor.white),
        }),
        gameMode: GameMode.spanish,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 2),
        to: BoardPosition(3, 4),
        capturedPieces: [BoardPosition(4, 3)],
      ),
    ),

    // Step 3: Mandatory Capture Rule
    TutorialStep(
      title: l10n.tutorialStepMandatoryCaptureTitle,
      description: l10n.tutorialStepMandatoryCaptureDescSpanish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(5, 2): Piece(id: 'w1', color: PieceColor.white),
          // Option 1
          const BoardPosition(4, 1): Piece(id: 'b1', color: PieceColor.black),
          // Option 2
          const BoardPosition(4, 3): Piece(id: 'b2', color: PieceColor.black),
          // Decoration
          const BoardPosition(7, 6): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(1, 6): Piece(id: 'b3', color: PieceColor.black),
        }),
        gameMode: GameMode.spanish,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 2),
        to: BoardPosition(3, 0),
        capturedPieces: [BoardPosition(4, 1)],
      ),
    ),

    // Step 4: King Promotion
    TutorialStep(
      title: l10n.tutorialStepPromotionTitle,
      description: l10n.tutorialStepPromotionDescSpanish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(1, 2): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(3, 4): Piece(id: 'b1', color: PieceColor.black),
        }),
        gameMode: GameMode.spanish,
      ),
      moveToShow: const Move(
        from: BoardPosition(1, 2),
        to: BoardPosition(0, 1),
        becomesKing: true,
      ),
    ),

    // Step 5: Multiple Captures with a Flying King
    TutorialStep(
      title: l10n.tutorialStepKingMoveTitle,
      description: l10n.tutorialStepKingMoveDescSpanish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(7, 0): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(5, 2): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(2, 5): Piece(id: 'b2', color: PieceColor.black),
          const BoardPosition(6, 7): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(0, 7): Piece(id: 'b3', color: PieceColor.black),
        }),
        gameMode: GameMode.spanish,
      ),
      moveToShow: const Move(
        from: BoardPosition(7, 0),
        to: BoardPosition(1, 6),
        capturedPieces: [BoardPosition(5, 2), BoardPosition(2, 5)],
        sequence: [
          Move(from: BoardPosition(7, 0), to: BoardPosition(3, 4), capturedPieces: [BoardPosition(5, 2)]),
          Move(from: BoardPosition(3, 4), to: BoardPosition(1, 6), capturedPieces: [BoardPosition(2, 5)]),
        ],
      ),
    ),

    // Step 6: Draw Rules
    TutorialStep(
      title: l10n.tutorialStepDrawTitle,
      description: l10n.tutorialStepDrawDescSpanish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(0, 1): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(2, 3): Piece(id: 'b1', color: PieceColor.black, type: PieceType.king),
        }),
        gameMode: GameMode.spanish,
      ),
    ),
  ],
);

/// A helper function that creates a 2D board array from a map of [BoardPosition] and [Piece].
/// This is used to set up specific scenarios for Spanish tutorial steps.
List<List<Piece?>> _createBoardFromMap(Map<BoardPosition, Piece> pieces, {int boardSize = 8}) {
  final board = List.generate(boardSize, (_) => List<Piece?>.filled(boardSize, null));
  for (var entry in pieces.entries) {
    board[entry.key.row][entry.key.col] = entry.value;
  }
  return board;
}