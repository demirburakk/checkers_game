import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial.dart';
import 'package:checkers_game/domain/rules/english_rules.dart';

import '../models/tutorial_step.dart';

/// Defines the tutorial for English Draughts (Checkers).
/// This tutorial covers basic movement, captures (forward only for pawns),
/// multiple captures, king promotion, and king movement.
Tutorial englishTutorial(AppLocalizations l10n) => Tutorial(
  title: l10n.gameModeEnglishName,
  steps: [
    // Step 1: Initial Setup
    TutorialStep(
      title: l10n.tutorialStepWelcomeTitle,
      description: l10n.tutorialStepWelcomeDescEnglish,
      initialState: GameState(
        board: EnglishRules().initializeBoard(),
        gameMode: GameMode.english,
      ),
    ),

    // Step 2: Movement of Men (Pawns)
    TutorialStep(
      title: l10n.tutorialStepManMoveTitle,
      description: l10n.tutorialStepManMoveDescEnglish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(5, 0): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(2, 1): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(6, 3): Piece(id: 'w2', color: PieceColor.white),
        }),
        gameMode: GameMode.english,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 0),
        to: BoardPosition(4, 1),
      ),
    ),

    // Step 3: Capturing with a Man (Forward Only)
    TutorialStep(
      title: l10n.tutorialStepCaptureTitle,
      description: l10n.tutorialStepCaptureDescEnglish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(5, 2): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(4, 3): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(1, 0): Piece(id: 'b2', color: PieceColor.black),
          const BoardPosition(7, 4): Piece(id: 'w2', color: PieceColor.white),
        }),
        gameMode: GameMode.english,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 2),
        to: BoardPosition(3, 4),
        capturedPieces: [BoardPosition(4, 3)],
      ),
    ),

    // Step 4: No Backward Captures for Men
    TutorialStep(
      title: l10n.tutorialStepManCannotCaptureBackwardTitle,
      description: l10n.tutorialStepManCannotCaptureBackwardDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(3, 4): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(4, 3): Piece(id: 'b1', color: PieceColor.black), // Piece that cannot be captured
          const BoardPosition(2, 3): Piece(id: 'b2', color: PieceColor.black), // Piece that could be captured if it were forward
          const BoardPosition(5, 0): Piece(id: 'w2', color: PieceColor.white),
        }),
        gameMode: GameMode.english,
      ),
    ),

    // Step 5: Multiple Captures
    TutorialStep(
      title: l10n.tutorialStepMultipleCaptureTitle,
      description: l10n.tutorialStepMultipleCaptureDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(6, 1): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(5, 2): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(3, 4): Piece(id: 'b2', color: PieceColor.black),
          // Decorative piece
          const BoardPosition(7, 6): Piece(id: 'w2', color: PieceColor.white),
        }),
        gameMode: GameMode.english,
      ),
      moveToShow: const Move(
        from: BoardPosition(6, 1),
        to: BoardPosition(2, 5),
        capturedPieces: [BoardPosition(5, 2), BoardPosition(3, 4)],
        sequence: [
          Move(from: BoardPosition(6, 1), to: BoardPosition(4, 3), capturedPieces: [BoardPosition(5, 2)]),
          Move(from: BoardPosition(4, 3), to: BoardPosition(2, 5), capturedPieces: [BoardPosition(3, 4)]),
        ],
      ),
    ),

    // Step 6: King Promotion
    TutorialStep(
      title: l10n.tutorialStepPromotionTitle,
      description: l10n.tutorialStepPromotionDescEnglish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(1, 2): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(2, 1): Piece(id: 'b1', color: PieceColor.black),
        }),
        gameMode: GameMode.english,
      ),
      moveToShow: const Move(
        from: BoardPosition(1, 2),
        to: BoardPosition(0, 3),
        becomesKing: true,
      ),
    ),

    // Step 7: King Movement and Capturing (Forward and Backward)
    TutorialStep(
      title: l10n.tutorialStepKingMoveTitle,
      description: l10n.tutorialStepKingMoveDescEnglish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(4, 3): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(5, 4): Piece(id: 'b1', color: PieceColor.black), // Piece to be captured backward
          const BoardPosition(5, 6): Piece(id: 'b2', color: PieceColor.black), // Piece to be captured forward
          // Decoration
          const BoardPosition(7, 2): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(0, 5): Piece(id: 'b3', color: PieceColor.black),
        }),
        gameMode: GameMode.english,
      ),
      moveToShow: const Move(
        from: BoardPosition(4, 3),
        to: BoardPosition(4, 7),
        capturedPieces: [BoardPosition(5, 4), BoardPosition(5, 6)],
        sequence: [
          Move(from: BoardPosition(4, 3), to: BoardPosition(6, 5), capturedPieces: [BoardPosition(5, 4)]),
          Move(from: BoardPosition(6, 5), to: BoardPosition(4, 7), capturedPieces: [BoardPosition(5, 6)]),
        ],
      ),
    ),

    // Step 8: Draw Rules
    TutorialStep(
      title: l10n.tutorialStepDrawTitle,
      description: l10n.tutorialStepDrawDescEnglish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(0, 1): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(2, 3): Piece(id: 'b1', color: PieceColor.black, type: PieceType.king),
        }),
        gameMode: GameMode.english,
      ),
    ),
  ],
);

/// A helper function that creates a 2D board array from a map of [BoardPosition] and [Piece].
/// This is used to set up specific scenarios for tutorial steps.
List<List<Piece?>> _createBoardFromMap(Map<BoardPosition, Piece> pieces, {int boardSize = 8}) {
  final board = List.generate(boardSize, (_) => List<Piece?>.filled(boardSize, null));
  for (var entry in pieces.entries) {
    board[entry.key.row][entry.key.col] = entry.value;
  }
  return board;
}