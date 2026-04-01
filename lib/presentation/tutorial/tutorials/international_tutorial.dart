import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial.dart';
import 'package:checkers_game/domain/rules/international_rules.dart';

import '../models/tutorial_step.dart';

/// Defines the tutorial for International Draughts (10x10).
/// This tutorial covers 10x10 board setup, backward captures for pawns,
/// the "majority capture" rule, flying kings, and king movement.
Tutorial internationalTutorial(AppLocalizations l10n) => Tutorial(
  title: l10n.gameModeInternationalName,
  steps: [
    // Step 1: Initial Setup
    TutorialStep(
      title: l10n.tutorialStepWelcomeTitle,
      description: l10n.tutorialStepWelcomeDescInternational,
      initialState: GameState(
        board: InternationalRules().initializeBoard(),
        gameMode: GameMode.international,
      ),
    ),

    // Step 2: Capturing Forward and Backward with a Man
    TutorialStep(
      title: l10n.tutorialStepManCaptureTitle,
      description: l10n.tutorialStepManCaptureDescInternational,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(5, 4): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(4, 5): Piece(id: 'b1', color: PieceColor.black), // Opponent in forward direction
          const BoardPosition(4, 7): Piece(id: 'b2', color: PieceColor.black), // Opponent in backward direction
          const BoardPosition(8, 1): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(1, 2): Piece(id: 'b3', color: PieceColor.black),
        }),
        gameMode: GameMode.international,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 4),
        to: BoardPosition(5, 8),
        capturedPieces: [BoardPosition(4, 5), BoardPosition(4, 7)],
        sequence: [
          Move(from: BoardPosition(5, 4), to: BoardPosition(3, 6), capturedPieces: [BoardPosition(4, 5)]),
          Move(from: BoardPosition(3, 6), to: BoardPosition(5, 8), capturedPieces: [BoardPosition(4, 7)]),
        ],
      ),
    ),

    // Step 3: Maximum Capture Rule (Majority Rule)
    TutorialStep(
      title: l10n.tutorialStepMaxCaptureTitle,
      description: l10n.tutorialStepMaxCaptureDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(7, 2): Piece(id: 'w1', color: PieceColor.white),
          // Path with 2 captures
          const BoardPosition(6, 3): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(4, 5): Piece(id: 'b2', color: PieceColor.black),
          // Path with 1 capture (not allowed to take this path)
          const BoardPosition(6, 1): Piece(id: 'b3', color: PieceColor.black),
          // Decoration
          const BoardPosition(8, 9): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(2, 9): Piece(id: 'b4', color: PieceColor.black),
        }),
        gameMode: GameMode.international,
      ),
      moveToShow: const Move(
        from: BoardPosition(7, 2),
        to: BoardPosition(3, 6),
        capturedPieces: [BoardPosition(6, 3), BoardPosition(4, 5)],
        sequence: [
          Move(from: BoardPosition(7, 2), to: BoardPosition(5, 4), capturedPieces: [BoardPosition(6, 3)]),
          Move(from: BoardPosition(5, 4), to: BoardPosition(3, 6), capturedPieces: [BoardPosition(4, 5)]),
        ],
      ),
    ),

    // Step 4: King Promotion
    TutorialStep(
      title: l10n.tutorialStepPromotionTitle,
      description: l10n.tutorialStepPromotionDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(1, 6): Piece(id: 'w1', color: PieceColor.white),
          // Decorative pieces (placed so they don't create mandatory captures)
          const BoardPosition(3, 0): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(5, 2): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(2, 9): Piece(id: 'b2', color: PieceColor.black),
        }),
        gameMode: GameMode.international,
      ),
      moveToShow: const Move(
        from: BoardPosition(1, 6),
        to: BoardPosition(0, 7),
        becomesKing: true,
      ),
    ),

    // Step 5: Flying King Movement
    TutorialStep(
      title: l10n.tutorialStepKingMoveTitle,
      description: l10n.tutorialStepKingMoveDescInternational,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(9, 0): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(2, 8): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(8, 7): Piece(id: 'w2', color: PieceColor.white),
        }),
        gameMode: GameMode.international,
      ),
      moveToShow: const Move(
        from: BoardPosition(9, 0),
        to: BoardPosition(0, 9),
      ),
    ),

    // Step 6: Simple Capture with a Flying King
    TutorialStep(
      title: l10n.tutorialStepKingCaptureTitle,
      description: l10n.tutorialStepKingCaptureDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(7, 0): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(4, 3): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(8, 9): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(1, 8): Piece(id: 'b2', color: PieceColor.black),
        }),
        gameMode: GameMode.international,
      ),
      moveToShow: const Move(
        from: BoardPosition(7, 0),
        to: BoardPosition(2, 5),
        capturedPieces: [BoardPosition(4, 3)],
      ),
    ),

    // Step 7: Multiple Captures with a Flying King
    TutorialStep(
      title: l10n.tutorialStepKingMultipleCaptureTitle,
      description: l10n.tutorialStepKingMultipleCaptureDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(9, 0): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(7, 2): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(3, 6): Piece(id: 'b2', color: PieceColor.black),
          const BoardPosition(8, 9): Piece(id: 'w2', color: PieceColor.white),
        }),
        gameMode: GameMode.international,
      ),
      moveToShow: const Move(
        from: BoardPosition(9, 0),
        to: BoardPosition(1, 8),
        capturedPieces: [BoardPosition(7, 2), BoardPosition(3, 6)],
        sequence: [
          Move(from: BoardPosition(9, 0), to: BoardPosition(5, 4), capturedPieces: [BoardPosition(7, 2)]),
          Move(from: BoardPosition(5, 4), to: BoardPosition(1, 8), capturedPieces: [BoardPosition(3, 6)]),
        ],
      ),
    ),

    // Step 8: Draw Rules
    TutorialStep(
      title: l10n.tutorialStepDrawTitle,
      description: l10n.tutorialStepDrawDescInternational,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(1, 0): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(9, 8): Piece(id: 'b1', color: PieceColor.black, type: PieceType.king),
          const BoardPosition(7, 6): Piece(id: 'b2', color: PieceColor.black, type: PieceType.king),
        }),
        gameMode: GameMode.international,
      ),
    ),
  ],
);

/// A helper function that creates a 10x10 board array from a map of [BoardPosition] and [Piece].
/// This is used to set up specific scenarios for International tutorial steps.
List<List<Piece?>> _createBoardFromMap(Map<BoardPosition, Piece> pieces, {int boardSize = 10}) {
  final board = List.generate(boardSize, (_) => List<Piece?>.filled(boardSize, null));
  for (var entry in pieces.entries) {
    board[entry.key.row][entry.key.col] = entry.value;
  }
  return board;
}
