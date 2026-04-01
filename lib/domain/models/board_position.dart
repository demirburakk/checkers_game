import 'package:json_annotation/json_annotation.dart';

part 'board_position.g.dart';

/// Represents a position on the checkers board with row and column coordinates.
@JsonSerializable()
class BoardPosition {
  /// The row index of the position (0-indexed).
  final int row;
  
  /// The column index of the position (0-indexed).
  final int col;

  /// Creates a new [BoardPosition] instance.
  /// 
  /// The [row] and [col] are required to identify the position.
  /// This is a const constructor, which allows the compiler to create these 
  /// objects at compile time, improving performance.
  const BoardPosition(this.row, this.col);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BoardPosition &&
              runtimeType == other.runtimeType &&
              row == other.row &&
              col == other.col;

  @override
  int get hashCode => row.hashCode ^ col.hashCode;

  @override
  String toString() => '($row, $col)';

  /// Creates a [BoardPosition] instance from a JSON map.
  factory BoardPosition.fromJson(Map<String, dynamic> json) => _$BoardPositionFromJson(json);
  
  /// Converts this [BoardPosition] instance to a JSON map.
  Map<String, dynamic> toJson() => _$BoardPositionToJson(this);
}