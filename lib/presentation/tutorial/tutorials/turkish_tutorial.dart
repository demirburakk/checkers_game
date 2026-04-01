import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial.dart';

import '../../../domain/rules/turkish_rules.dart';
import '../models/tutorial_step.dart';

/// Defines the tutorial for Turkish Checkers (Dama).
/// Turkish Checkers is unique as pieces move orthogonally (forward, left, right) 
/// rather than diagonally, and kings have a "flying" movement along lines.
Tutorial turkishTutorial(AppLocalizations l10n) => Tutorial(
  title: l10n.gameModeTurkishName,
  steps: [
    // Step 1: Initial Setup
    TutorialStep(
      title: l10n.tutorialStepWelcomeTitle,
      description: l10n.tutorialStepWelcomeDescTurkish,
      initialState: GameState(
        // Use the initial board state directly from the TurkishRules implementation.
        board: TurkishRules().initializeBoard(),
        gameMode: GameMode.turkish,
      ),
    ),

    // Step 2: Movement of Men (Orthogonal)
    TutorialStep(
      title: l10n.tutorialStepManMoveTitle,
      description: l10n.tutorialStepManMoveDescTurkish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(5, 3): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(2, 2): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(2, 5): Piece(id: 'b2', color: PieceColor.black),
          const BoardPosition(6, 1): Piece(id: 'w2', color: PieceColor.white),
        }, PieceColor.white),
        gameMode: GameMode.turkish,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 3),
        to: BoardPosition(4, 3), // Forward move (orthogonal)
      ),
    ),

    // Step 3: Capturing (Orthogonal)
    TutorialStep(
      title: l10n.tutorialStepCaptureTitle,
      description: l10n.tutorialStepCaptureDescTurkish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(5, 2): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(4, 2): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(6, 5): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(1, 4): Piece(id: 'b2', color: PieceColor.black),
        }, PieceColor.white),
        gameMode: GameMode.turkish,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 2),
        to: BoardPosition(3, 2),
        capturedPieces: [BoardPosition(4, 2)],
      ),
    ),

    // Step 4: Multiple Capturing (Mandatory Maximum Capture)
    TutorialStep(
      title: l10n.tutorialStepMaxCaptureTitle,
      description: l10n.tutorialStepMaxCaptureDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          // The piece that will perform the multi-capture
          const BoardPosition(5, 1): Piece(id: 'w1', color: PieceColor.white),
          // Opponent pieces to be captured
          const BoardPosition(4, 1): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(2, 1): Piece(id: 'b2', color: PieceColor.black),
          // An alternative capture path (only one piece) to illustrate mandatory max-capture
          const BoardPosition(4, 3): Piece(id: 'b3', color: PieceColor.black),
          // Decorative pieces to fill the board
          const BoardPosition(6, 6): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(1, 5): Piece(id: 'b4', color: PieceColor.black),

        }, PieceColor.white),
        gameMode: GameMode.turkish,
      ),
      moveToShow: const Move(
        from: BoardPosition(5, 1),
        to: BoardPosition(1, 1), // Final destination
        capturedPieces: [BoardPosition(4, 1), BoardPosition(2, 1)],
        // The sequence of moves that make up the multi-jump animation
        sequence: [
          Move(from: BoardPosition(5, 1), to: BoardPosition(3, 1), capturedPieces: [BoardPosition(4, 1)]),
          Move(from: BoardPosition(3, 1), to: BoardPosition(1, 1), capturedPieces: [BoardPosition(2, 1)]),
        ],
      ),
    ),

    // Step 5: King Promotion
    TutorialStep(
      title: l10n.tutorialStepPromotionTitle,
      description: l10n.tutorialStepPromotionDesc,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(1, 4): Piece(id: 'w1', color: PieceColor.white),
          const BoardPosition(2, 7): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(5, 2): Piece(id: 'w2', color: PieceColor.white),
        }, PieceColor.white),
        gameMode: GameMode.turkish,
      ),
      moveToShow: const Move(
        from: BoardPosition(1, 4),
        to: BoardPosition(0, 4),
        becomesKing: true,
      ),
    ),

    // Step 6: Flying King Movement and Capturing
    TutorialStep(
      title: l10n.tutorialStepKingMoveTitle,
      description: l10n.tutorialStepKingMoveDescTurkish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(3, 3): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(3, 5): Piece(id: 'b1', color: PieceColor.black),
          const BoardPosition(5, 3): Piece(id: 'b2', color: PieceColor.black),
          // Decorative pieces
          const BoardPosition(7, 0): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(1, 1): Piece(id: 'b3', color: PieceColor.black),
          const BoardPosition(0, 7): Piece(id: 'b4', color: PieceColor.black, type: PieceType.king),
        }, PieceColor.white),
        gameMode: GameMode.turkish,
      ),
      moveToShow: const Move(
        from: BoardPosition(3, 3),
        to: BoardPosition(3, 6),
        capturedPieces: [BoardPosition(3, 5)],
      ),
    ),

    // Step 7: Draw Rules
    TutorialStep(
      title: l10n.tutorialStepDrawTitle,
      description: l10n.tutorialStepDrawDescTurkish,
      initialState: GameState(
        board: _createBoardFromMap({
          const BoardPosition(0, 0): Piece(id: 'w1', color: PieceColor.white, type: PieceType.king),
          const BoardPosition(2, 1): Piece(id: 'b1', color: PieceColor.black, type: PieceType.king),
          const BoardPosition(7, 7): Piece(id: 'w2', color: PieceColor.white),
          const BoardPosition(6, 6): Piece(id: 'b2', color: PieceColor.black),
        }, PieceColor.white),
        gameMode: GameMode.turkish,
      ),
    ),
  ],
);

/// A helper function that creates a 2D board array from a map of [BoardPosition] and [Piece].
/// This is used to set up specific scenarios for Turkish tutorial steps.
List<List<Piece?>> _createBoardFromMap(Map<BoardPosition, Piece> pieces, PieceColor currentPlayer, {int boardSize = 8}) {
  final board = List.generate(boardSize, (_) => List<Piece?>.filled(boardSize, null));
  for (var entry in pieces.entries) {
    board[entry.key.row][entry.key.col] = entry.value;
  }
  return board;
}
