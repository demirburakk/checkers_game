import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial.dart';
import 'package:checkers_game/domain/rules/russian_rules.dart';

import '../models/tutorial_step.dart';

/// Defines the tutorial for Russian Draughts (Shashki).
/// This tutorial covers backward captures for men, the "flying king" rule,
/// and the special rule where a man becomes a king mid-jump.
Tutorial russianTutorial(AppLocalizations l10n) => Tutorial(
  title: l10n.gameModeRussianName,
  steps: [
    // Step 1: Initial Setup
    TutorialStep(
      title: l10n.tutorialStepWelcomeTitle,
      description: l10n.tutorialStepWelcomeDescRussian,
      initialState: GameState(
        board: RussianRules().initializeBoard(),
        gameMode: GameMode.russian,
      ),
    ),

    // Step 2: Backward Capture with a Man
    TutorialStep(
      title: l10n.tutorialStepManCaptureBackwardTitle,
      description: l10n.tutorialStepManCaptureBackwardDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(4, 3): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(5, 2): Piece(id: 'b1', color: PieceColor.black), // Opponent behind the man
          const BoardPosition(2, 1): Piece(id: 'b2', color: PieceColor.black),
          const BoardPosition(7, 4): Piece(id: 'w2', color: PieceColor.white),
        }),
        gameMode: GameMode.russian,
      ),
      moveToShow: const Move(
        from: BoardPosition(4, 3),
        to: BoardPosition(6, 1),
        capturedPieces: [BoardPosition(5, 2)],
      ),
    ),

    // Step 3: Standard King Promotion
    TutorialStep(
      title: l10n.tutorialStepPromotionTitle,
      description: l10n.tutorialStepPromotionDescRussian,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(1, 6): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(3, 4): Piece(id: 'b1', color: PieceColor.black),
        }),
        gameMode: GameMode.russian,
      ),
      moveToShow: const Move(
        from: BoardPosition(1, 6),
        to: BoardPosition(0, 7),
        becomesKing: true,
      ),
    ),

    // Step 4: Special Mid-Jump Promotion Rule
    // In Russian Draughts, if a man reaches the promotion line during a sequence of jumps,
    // it becomes a king and continues jumping as a king.
    TutorialStep(
      title: l10n.tutorialStepPromotionRuleTitle,
      description: l10n.tutorialStepPromotionRuleDescRussian,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(2, 1): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(1, 2): Piece(id: 'b1', color: PieceColor.black), // Piece that leads to the last row
          const BoardPosition(1, 4): Piece(id: 'b2', color: PieceColor.black), // Piece to be captured after promotion
          const BoardPosition(5, 6): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(4, 7): Piece(id: 'b3', color: PieceColor.black),
        }),
        gameMode: GameMode.russian,
      ),
      moveToShow: const Move(
        from: BoardPosition(2, 1),
        to: BoardPosition(2, 5),
        capturedPieces: [BoardPosition(1, 2), BoardPosition(1, 4)],
        becomesKing: true, // Becomes king during the sequence
        sequence: [
          Move(from: BoardPosition(2, 1), to: BoardPosition(0, 3), capturedPieces: [BoardPosition(1, 2)]),
          Move(from: BoardPosition(0, 3), to: BoardPosition(2, 5), capturedPieces: [BoardPosition(1, 4)]),
        ],
      ),
    ),

    // Step 5: Draw Rules
    TutorialStep(
      title: l10n.tutorialStepDrawTitle,
      description: l10n.tutorialStepDrawDescRussian,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(0, 1): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(2, 3): Piece(id: 'b1', color: PieceColor.black, type: PieceType.king),
          const BoardPosition(4, 5): Piece(id: 'b2', color: PieceColor.black, type: PieceType.king),
        }),
        gameMode: GameMode.russian,
      ),
    ),
  ],
);

/// A helper function that creates a 2D board array from a map of [BoardPosition] and [Piece].
/// This is used to set up specific scenarios for Russian tutorial steps.
List<List<Piece?>> _createBoardFromMap(Map<BoardPosition, Piece> pieces, {int boardSize = 8}) {
  final board = List.generate(boardSize, (_) => List<Piece?>.filled(boardSize, null));
  for (var entry in pieces.entries) {
    board[entry.key.row][entry.key.col] = entry.value;
  }
  return board;
}
