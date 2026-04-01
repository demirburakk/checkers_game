import 'package:checkers_game/domain/models/board_position.dart';

/// Represents a single move or a sequence of jumps in a checkers game.
class Move {
  /// The starting position of the piece.
  final BoardPosition from;
  
  /// The ending position of the piece for this specific step.
  final BoardPosition to;
  
  /// A list of board positions of pieces that are captured during this move.
  final List<BoardPosition> capturedPieces;
  
  /// A sequence of moves representing multiple jumps in a single turn.
  /// This is non-nullable to reduce null checks; it defaults to an empty list.
  final List<Move> sequence;
  
  /// Whether this move results in a piece being promoted to a King.
  final bool becomesKing;

  /// Creates a new [Move] instance.
  const Move({
    required this.from,
    required this.to,
    this.capturedPieces = const [],
    this.sequence = const [],
    this.becomesKing = false,
  });

  /// Returns true if this move involves capturing at least one opponent piece.
  bool get isCapture => capturedPieces.isNotEmpty;

  /// Returns the final destination of the piece after all jumps in the sequence.
  /// If there is no sequence, it returns the [to] position.
  BoardPosition get finalDestination => sequence.isNotEmpty ? sequence.last.to : to;

  /// Returns a new [Move] with some properties updated.
  /// 
  /// This allows for safe copying of [Move] objects, which is useful
  /// when managing chained moves in the game logic.
  Move copyWith({
    BoardPosition? from,
    BoardPosition? to,
    List<BoardPosition>? capturedPieces,
    List<Move>? sequence,
    bool? becomesKing,
  }) {
    return Move(
      from: from ?? this.from,
      to: to ?? this.to,
      capturedPieces: capturedPieces ?? this.capturedPieces,
      sequence: sequence ?? this.sequence,
      becomesKing: becomesKing ?? this.becomesKing,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Move &&
              runtimeType == other.runtimeType &&
              from == other.from &&
              to == other.to;

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}