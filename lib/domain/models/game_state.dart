import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/rules/game_rules.dart';
import 'package:checkers_game/presentation/utils/game_mode_helper.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:checkers_game/presentation/utils/player_type.dart';

part 'game_state.g.dart';

/// Represents the complete state of a checkers game at a specific point in time.
@JsonSerializable(explicitToJson: true)
class GameState {
  /// The current state of the board, represented as a 2D list of pieces.
  /// Null represents an empty square.
  final List<List<Piece?>> board;
  
  /// The color of the player whose turn it is to move.
  final PieceColor currentPlayer;
  
  /// The variant of checkers being played.
  final GameMode gameMode;

  /// The type (human or AI) of the white player.
  @JsonKey(defaultValue: PlayerType.human)
  final PlayerType whitePlayerType;

  /// The type (human or AI) of the black player.
  @JsonKey(defaultValue: PlayerType.human)
  final PlayerType blackPlayerType;

  /// Counter for moves since the last capture or pawn move.
  /// Used for draw rules (like the 50-move rule).
  @JsonKey(defaultValue: 0)
  final int movesSinceSignificantEvent;

  /// Tracks how many times each board configuration has occurred.
  /// Used for detecting threefold repetition draws.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<int, int> positionHistory;

  /// A hash representing the current board state.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int boardHash;

  /// Retrieves the specific rules associated with the current [gameMode].
  @JsonKey(includeFromJson: false, includeToJson: false)
  GameRules get rules => GameModeHelper.getRules(gameMode);

  /// The currently selected board position, if any.
  final BoardPosition? selectedPosition;

  /// A list of all legal moves for the [currentPlayer] in the current state.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<Move> possibleMoves;

  /// The last move performed if it was part of a jump sequence.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Move? lastMoveInSequence;

  /// Creates a new [GameState] instance.
  GameState({
    required this.board,
    required this.gameMode,
    this.currentPlayer = PieceColor.white,
    this.selectedPosition,
    this.possibleMoves = const [],
    this.whitePlayerType = PlayerType.human,
    this.blackPlayerType = PlayerType.human,
    this.movesSinceSignificantEvent = 0,
    this.positionHistory = const {},
    this.boardHash = 0,
    this.lastMoveInSequence,
  });

  /// Creates a deep copy of another [GameState] instance.
  GameState.from(GameState other)
      : board = other.board.map((row) => List<Piece?>.from(row)).toList(),
        gameMode = other.gameMode,
        currentPlayer = other.currentPlayer,
        selectedPosition = other.selectedPosition,
        possibleMoves = List<Move>.from(other.possibleMoves),
        whitePlayerType = other.whitePlayerType,
        blackPlayerType = other.blackPlayerType,
        movesSinceSignificantEvent = other.movesSinceSignificantEvent,
        positionHistory = Map<int, int>.from(other.positionHistory),
        boardHash = other.boardHash,
        lastMoveInSequence = other.lastMoveInSequence;

  /// Returns a new [GameState] with some properties updated.
  /// 
  /// Uses [ValueGetter] for nullable fields that can be set to null.
  GameState copyWith({
    List<List<Piece?>>? board,
    PieceColor? currentPlayer,
    GameMode? gameMode,
    ValueGetter<BoardPosition?>? selectedPosition,
    List<Move>? possibleMoves,
    PlayerType? whitePlayerType,
    PlayerType? blackPlayerType,
    int? movesSinceSignificantEvent,
    Map<int, int>? positionHistory,
    int? boardHash,
    ValueGetter<Move?>? lastMoveInSequence,
  }) {
    return GameState(
      board: board ?? this.board.map((row) => List.of(row)).toList(),
      currentPlayer: currentPlayer ?? this.currentPlayer,
      gameMode: gameMode ?? this.gameMode,
      selectedPosition: selectedPosition != null ? selectedPosition() : this.selectedPosition,
      possibleMoves: possibleMoves ?? List<Move>.from(this.possibleMoves),
      whitePlayerType: whitePlayerType ?? this.whitePlayerType,
      blackPlayerType: blackPlayerType ?? this.blackPlayerType,
      movesSinceSignificantEvent: movesSinceSignificantEvent ?? this.movesSinceSignificantEvent,
      positionHistory: positionHistory ?? Map<int, int>.from(this.positionHistory),
      boardHash: boardHash ?? this.boardHash,
      lastMoveInSequence: lastMoveInSequence != null ? lastMoveInSequence() : this.lastMoveInSequence,
    );
  }

  /// Creates a [GameState] instance from a JSON map.
  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
  
  /// Converts this [GameState] instance to a JSON map.
  Map<String, dynamic> toJson() => _$GameStateToJson(this);
}