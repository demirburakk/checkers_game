import 'package:json_annotation/json_annotation.dart';

part 'piece.g.dart';

/// Represents the color of a checkers piece.
enum PieceColor { 
  /// Black pieces, typically controlled by the second player.
  black, 
  
  /// White pieces, typically controlled by the first player.
  white, 
  
  /// Used in some variants or for specific king coloring if different from base.
  king 
}

/// Represents the type of a checkers piece.
enum PieceType { 
  /// A regular pawn piece.
  man, 
  
  /// A piece that has been promoted to a king.
  king 
}

/// Represents a single piece on the checkers board.
@JsonSerializable(explicitToJson: true)
class Piece {
  /// A unique identifier for this piece. 
  /// This ensures each piece has a predictable and stable identity.
  final String id;
  
  /// The color of the piece.
  final PieceColor color;
  
  /// The current rank of the piece (either a regular man or a king).
  final PieceType type;

  /// Creates a new [Piece] instance.
  /// 
  /// The [id] and [color] are required, while [type] defaults to [PieceType.man].
  Piece({required this.id, required this.color, this.type = PieceType.man});

  /// Returns a new [Piece] with some properties updated, preserving ID and color.
  /// 
  /// This makes state-altering operations like promotion safer.
  Piece copyWith({PieceType? type}) {
    return Piece(
      id: id,
      color: color,
      type: type ?? this.type,
    );
  }

  /// Promotes this piece to a King if it isn't already one.
  Piece promote() {
    if (type == PieceType.king) return this;
    return copyWith(type: PieceType.king);
  }

  /// Creates a [Piece] instance from a JSON map.
  factory Piece.fromJson(Map<String, dynamic> json) => _$PieceFromJson(json);
  
  /// Converts this [Piece] instance to a JSON map.
  Map<String, dynamic> toJson() => _$PieceToJson(this);
}