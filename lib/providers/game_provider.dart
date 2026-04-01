import 'dart:async';
import 'dart:math';
import 'package:checkers_game/domain/ai/ai_isolate_manager.dart';
import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/models/draw_reason.dart';
import 'package:checkers_game/domain/rules/game_rules.dart';
import 'package:checkers_game/presentation/utils/game_mode_helper.dart';
import 'package:checkers_game/presentation/utils/player_type.dart';
import 'package:checkers_game/presentation/utils/preferred_color.dart';
import 'package:checkers_game/providers/settings_provider.dart';
import 'package:checkers_game/providers/zobrist_hash.dart';
import 'package:checkers_game/utils/game_saver.dart';
import 'package:checkers_game/utils/sound_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:vibration/vibration.dart';

/// Represents a move currently being animated on the board.
class AnimatedMove {
  final Piece piece;
  final Move move;
  AnimatedMove(this.piece, this.move);
}

/// The central state manager for the checkers game.
/// 
/// This provider handles the game loop, user interactions, AI turn management,
/// animations, sound effects, and haptic feedback.
class GameProvider with ChangeNotifier {
  SettingsProvider settingsProvider;
  final SoundManager soundManager;

  late GameState _gameState;
  late ZobristHash _zobristHash;
  final List<GameState> _history = [];
  int _aiLevel = 3;

  bool _isLoading = true;
  bool _isAiThinking = false;
  bool _isDisposed = false;

  // Draw-related state
  bool _isDraw = false;
  DrawReason? _drawReason;

  Move? _lastMove;
  Set<BoardPosition> _capturedPiecePositions = {};
  Timer? _captureAnimationTimer;
  bool isDialogShowing = false;
  PieceColor _viewpoint = PieceColor.white;

  BoardPosition? _invalidSelectionPosition;
  Timer? _invalidSelectionTimer;

  AnimatedMove? _moveBeingAnimated;

  // --- Getters ---

  GameState get gameState => _gameState;
  bool get isLoading => _isLoading;
  bool get isAiThinking => _isAiThinking;
  bool get isDraw => _isDraw;
  DrawReason? get drawReason => _drawReason;

  /// Returns true if the game has ended due to a win or a draw.
  bool get isGameOver {
    if (_isLoading) return false;
    if (_isDraw) return true;
    
    // Check for a winner using variant-specific rules.
    final winner = _gameState.rules.checkForWinner(_gameState);
    if (winner != null) return true;
    
    return false;
  }

  /// Returns true if the board is flipped (Black at the bottom).
  bool get isBoardFlipped => _viewpoint == PieceColor.black;
  
  /// Positions of pieces that were just captured, used for highlight animations.
  Set<BoardPosition> get capturedPiecePositions => _capturedPiecePositions;
  
  /// The most recent move made in the game.
  Move? get lastMove => _lastMove;
  
  /// Whether to show board coordinates (A1, B2, etc.).
  bool get showCoordinates => settingsProvider.showCoordinates;
  
  /// The position of an invalid user tap, used for a shake animation.
  BoardPosition? get invalidSelectionPosition => _invalidSelectionPosition;
  
  /// The move currently being animated across the board.
  AnimatedMove? get moveBeingAnimated => _moveBeingAnimated;

  GameProvider({required this.settingsProvider, required this.soundManager});

  /// Updates the reference to settings when they change.
  void updateSettings(SettingsProvider newSettingsProvider) {
    settingsProvider = newSettingsProvider;
  }

  /// Triggers a brief vibration if haptics are enabled.
  void _vibrate({int duration = 20, int amplitude = 128}) {
    if (settingsProvider.hapticsEnabled) {
      Vibration.vibrate(duration: duration, amplitude: amplitude);
    }
  }

  /// Triggers a complex vibration pattern if haptics are enabled.
  void _vibratePattern() {
    if (settingsProvider.hapticsEnabled) {
      Vibration.vibrate(pattern: [50, 100, 50, 100], amplitude: 255);
    }
  }

  /// Initializes a new game or loads an existing one.
  Future<void> initializeGame({
    required GameMode gameMode, 
    required PlayerType opponentType,
    bool loadFromSave = false, 
    int aiLevel = 3,
  }) async {
    _isLoading = true;
    _resetState();
    _aiLevel = aiLevel;
    notifyListeners();

    final rules = GameModeHelper.getRules(gameMode);
    _zobristHash = ZobristHash(rules.boardSize);

    GameState? loadedState = loadFromSave ? await GameSaver.loadGame(gameMode, opponentType) : null;

    if (loadedState != null) {
      _gameState = loadedState;
    } else {
      _gameState = _createNewGame(gameMode, opponentType, rules);
      // Initialize Zobrist hash and position history for the new game.
      final initialHash = _zobristHash.calculateFullHash(_gameState.board, _gameState.currentPlayer);
      _gameState = _gameState.copyWith(
        boardHash: initialHash,
        positionHistory: {initialHash: 1},
      );
    }

    _updateViewpoint();
    _gameState = _recalculateState(_gameState);

    _isLoading = false;
    notifyListeners();
    _checkAiTurn();
  }

  /// Creates a fresh GameState for a new game session.
  GameState _createNewGame(GameMode gameMode, PlayerType opponentType, GameRules rules) {
    PlayerType whitePlayerType = PlayerType.human;
    PlayerType blackPlayerType = PlayerType.human;

    if (opponentType == PlayerType.ai) {
      var humanColor = settingsProvider.preferredColor;
      if (humanColor == PreferredColor.random) {
        humanColor = Random().nextBool() ? PreferredColor.white : PreferredColor.black;
      }
      if (humanColor == PreferredColor.white) {
        blackPlayerType = PlayerType.ai;
      } else {
        whitePlayerType = PlayerType.ai;
      }
    }
    return GameState(
        board: rules.initializeBoard(), 
        gameMode: gameMode,
        whitePlayerType: whitePlayerType, 
        blackPlayerType: blackPlayerType
    );
  }

  /// Handles user interaction when a square is tapped.
  void onSquareTapped(int row, int col) {
    if (_isCurrentPlayerAi() || _isAiThinking || isGameOver || _moveBeingAnimated != null) return;

    clearHint();
    final tappedPos = isBoardFlipped
        ? BoardPosition(_gameState.rules.boardSize - 1 - row, _gameState.rules.boardSize - 1 - col)
        : BoardPosition(row, col);
    final piece = _gameState.board[tappedPos.row][tappedPos.col];
    final selectedPos = _gameState.selectedPosition;

    if (selectedPos != null) {
      // Try to execute a move to the tapped square.
      final move = _findMoveTo(selectedPos, tappedPos);
      if (move != null) {
        _executeHumanMove(move);
        return;
      }
      // If tapping another of the player's pieces, change selection.
      if (piece != null && piece.color == _gameState.currentPlayer) {
        _updateSelection(tappedPos);
        return;
      }
      _clearSelection();
    } else {
      // Select the piece at the tapped position if it belongs to the current player.
      if (piece != null && piece.color == _gameState.currentPlayer) {
        _updateSelection(tappedPos);
      } else {
        _showInvalidSelection(tappedPos);
      }
    }
  }

  /// Records history and starts the move execution process for a human player.
  void _executeHumanMove(Move move) {
    _history.add(GameState.from(_gameState));
    _animateAndApplyMove(move);
  }

  /// Executes a move sequence calculated by the AI.
  Future<void> _executeAiMoveSequence(Move fullMove) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_isDisposed) return;
    _animateAndApplyMove(fullMove, isAiMove: true);
  }

  /// Orchestrates the visual animation of a move and updates the game state.
  Future<void> _animateAndApplyMove(Move move, {bool isAiMove = false}) async {
    final initialGameState = _gameState;
    final pieceToMove = initialGameState.board[move.from.row][move.from.col];
    if (pieceToMove == null) return;

    _lastMove = move;

    // Create a temporary board for the animation phase.
    var tempBoard = initialGameState.board.map((row) => List<Piece?>.from(row)).toList();
    _gameState = initialGameState.copyWith(board: tempBoard, selectedPosition: () => null);

    final steps = move.sequence.isNotEmpty ? move.sequence : [move];

    // Animate each step of the move (e.g., multiple captures).
    for (final step in steps) {
      if (_isDisposed) return;

      for (var capturedPos in step.capturedPieces) {
        tempBoard[capturedPos.row][capturedPos.col] = null;
      }

      _performMoveEffects(step);
      _moveBeingAnimated = AnimatedMove(pieceToMove, step);
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 380));

      tempBoard[step.from.row][step.from.col] = null;
      tempBoard[step.to.row][step.to.col] = pieceToMove;
    }

    if (!_isDisposed) {
      // 1. Apply the move logic to get the final board state.
      var nextState = initialGameState.rules.applyMove(initialGameState, move, _zobristHash);

      // 2. Update draw-tracking data.
      final newPositionHistory = Map<int, int>.from(initialGameState.positionHistory);
      newPositionHistory.update(nextState.boardHash, (value) => value + 1, ifAbsent: () => 1);

      // Reset move counter if a significant event (capture or promotion) occurred.
      final isSignificantMove = move.isCapture || (pieceToMove.type == PieceType.man && move.becomesKing);
      final newMoveCounter = isSignificantMove ? 0 : initialGameState.movesSinceSignificantEvent + 1;

      nextState = nextState.copyWith(
        positionHistory: newPositionHistory,
        movesSinceSignificantEvent: newMoveCounter,
      );

      // 3. Check for draw conditions.
      _drawReason = nextState.rules.checkForDraw(nextState);
      if (_drawReason != null) {
        _isDraw = true;
      }

      // 4. Update the main game state and UI.
      _gameState = nextState;
      _moveBeingAnimated = null;

      if (isAiMove) {
        _isAiThinking = false;
        if (!_isCurrentPlayerAi()) {
          _vibrate(duration: 30, amplitude: 80);
        }
      }

      notifyListeners();

      // 5. Trigger AI turn if applicable.
      _checkAiTurn();
    }
  }

  /// Searches for a legal move from [from] to [to] in the current state.
  Move? _findMoveTo(BoardPosition from, BoardPosition to) {
    for (final move in _gameState.possibleMoves) {
      if (move.from == from) {
        // Handle multi-step move sequence start.
        if (move.sequence.isNotEmpty && move.sequence.first.to == to) {
          return move.sequence.first;
        }
        // Handle single-step move.
        if (move.finalDestination == to) {
          return move;
        }
      }
    }
    return null;
  }

  /// Updates the selected piece on the board, respecting mandatory capture rules.
  void _updateSelection(BoardPosition tappedPos) {
    final bool isForcedCapture = _gameState.possibleMoves.isNotEmpty && _gameState.possibleMoves.every((m) => m.isCapture);
    final bool canSelect = _gameState.possibleMoves.any((m) => m.from == tappedPos);
    
    if (canSelect) {
      _gameState = _gameState.copyWith(selectedPosition: () => tappedPos);
      soundManager.playClickSound();
      _vibrate(duration: 5, amplitude: 40);
      notifyListeners();
    } else if (!isForcedCapture) {
      _clearSelection();
    } else {
      _showInvalidSelection(tappedPos);
    }
  }

  /// Deselects the currently selected piece.
  void _clearSelection() {
    if (_gameState.selectedPosition != null) {
      _gameState = _gameState.copyWith(selectedPosition: () => null);
      soundManager.playClickSound();
      _vibrate(duration: 5, amplitude: 40);
      notifyListeners();
    }
  }

  /// Shows a brief visual indication (and vibration) for an invalid move/selection.
  void _showInvalidSelection(BoardPosition pos) {
    _invalidSelectionTimer?.cancel();
    _invalidSelectionPosition = pos;
    _vibrate(duration: 150, amplitude: 200);
    notifyListeners();
    _invalidSelectionTimer = Timer(const Duration(milliseconds: 400), () {
      if(!_isDisposed) {
        _invalidSelectionPosition = null;
        notifyListeners();
      }
    });
  }

  /// Checks if it is the AI's turn and starts the calculation in a separate isolate.
  void _checkAiTurn() {
    if (isGameOver || !_isCurrentPlayerAi() || _isAiThinking || _moveBeingAnimated != null) return;

    _isAiThinking = true;
    notifyListeners();

    AiIsolateManager.findBestMoveInIsolate(_gameState, _aiLevel, _zobristHash).then((bestMove) {
      if (_isDisposed) return;
      _executeAiMoveSequence(bestMove);
    }).catchError((error, stackTrace) {
      debugPrint("AI Isolate Error: $error:$stackTrace");
      if (!_isDisposed) { _isAiThinking = false; notifyListeners(); }
    });
  }

  /// Plays sounds and triggers haptics based on move effects.
  void _performMoveEffects(Move move) {
    if (move.isCapture) {
      soundManager.playCaptureSound();
      _vibrate(duration: 50, amplitude: 255);
      _showCaptureAnimation(move.capturedPieces);
    } else {
      soundManager.playMoveSound();
      _vibrate(duration: 30, amplitude: 128);
    }
    if (move.becomesKing) {
      Future.delayed(const Duration(milliseconds: 300), (){
        if (_isDisposed) return;
        soundManager.playPromoteSound();
        _vibratePattern();
      });
    }
  }

  /// Recalculates legal moves for the given state.
  GameState _recalculateState(GameState state) {
    final moves = state.rules.getPossibleMoves(state);
    return state.copyWith(
        possibleMoves: moves,
        selectedPosition: () => state.selectedPosition
    );
  }

  /// Returns true if the current turn belongs to an AI player.
  bool _isCurrentPlayerAi() {
    final type = _gameState.currentPlayer == PieceColor.white ? _gameState.whitePlayerType : _gameState.blackPlayerType;
    return type == PlayerType.ai;
  }

  /// Adjusts the camera/board viewpoint based on player configuration.
  void _updateViewpoint() {
    if (_gameState.blackPlayerType == PlayerType.human && _gameState.whitePlayerType == PlayerType.ai) {
      _viewpoint = PieceColor.black;
    } else {
      _viewpoint = PieceColor.white;
    }
  }

  /// Temporarily highlights positions where pieces were captured.
  void _showCaptureAnimation(List<BoardPosition> positions) {
    _captureAnimationTimer?.cancel();
    _capturedPiecePositions = positions.toSet();
    notifyListeners();
    _captureAnimationTimer = Timer(const Duration(milliseconds: 400), () {
      if(!_isDisposed){ _capturedPiecePositions = {}; notifyListeners(); }
    });
  }

  /// Resets internal state variables before a new game or undo.
  void _resetState({bool resetHistory = true}) {
    isDialogShowing = false; 
    _isAiThinking = false; 
    _isDraw = false; 
    _drawReason = null;
    _capturedPiecePositions = {}; 
    _captureAnimationTimer?.cancel();
    _lastMove = null;
    _invalidSelectionPosition = null;
    _invalidSelectionTimer?.cancel();
    _moveBeingAnimated = null;
    if (resetHistory) _history.clear();
  }

  /// Checks if undoing a move is currently possible.
  bool canUndo() => !isGameOver && !_isAiThinking && _history.isNotEmpty && _moveBeingAnimated == null;

  /// Reverts the game state to the previous turn.
  void undoMove() {
    if (!canUndo()) return;
    soundManager.playClickSound();
    _gameState = _history.removeLast();
    _resetState(resetHistory: false);
    notifyListeners();
  }

  /// Restarts the current game with the same settings.
  void resetGame({int? aiLevel}) {
    soundManager.playStartSound();
    final opponentType = (_gameState.whitePlayerType == PlayerType.ai || _gameState.blackPlayerType == PlayerType.ai)
        ? PlayerType.ai
        : PlayerType.human;
    initializeGame(
        gameMode: _gameState.gameMode,
        opponentType: opponentType,
        aiLevel: aiLevel ?? _aiLevel);
  }

  /// Rotates the board view 180 degrees.
  void flipBoard() {
    if (isGameOver) return;
    _viewpoint = (_viewpoint == PieceColor.white) ? PieceColor.black : PieceColor.white;
    notifyListeners();
  }

  Move? _hintMove;
  
  /// The move recommended by the AI as a hint.
  Move? get hintMove => _hintMove;

  /// Clears the current AI hint from the UI.
  void clearHint() {
    if (isGameOver) return;
    if (_hintMove != null) { _hintMove = null; notifyListeners(); }
  }

  /// Asks the AI to calculate the best move for the current player to provide a hint.
  Future<void> getHint() async {
    if (_isAiThinking || isGameOver || _moveBeingAnimated != null) return;
    _isAiThinking = true;
    notifyListeners();
    try {
      const int hintLevel = 4;
      _hintMove = await AiIsolateManager.findBestMoveInIsolate(_gameState, hintLevel, _zobristHash);
    } catch(e) {
      debugPrint("Hint error: $e");
      _hintMove = null;
    } finally {
      if (!_isDisposed) { _isAiThinking = false; notifyListeners(); }
    }
  }

  /// Persists the current game state to local storage.
  Future<void> saveCurrentGame() async => await GameSaver.saveGame(_gameState);

  @override
  void dispose() {
    _isDisposed = true;
    _captureAnimationTimer?.cancel();
    _invalidSelectionTimer?.cancel();
    super.dispose();
  }
}
