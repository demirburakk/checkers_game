// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardPosition _$BoardPositionFromJson(Map<String, dynamic> json) =>
    BoardPosition(
      (json['row'] as num).toInt(),
      (json['col'] as num).toInt(),
    );

Map<String, dynamic> _$BoardPositionToJson(BoardPosition instance) =>
    <String, dynamic>{
      'row': instance.row,
      'col': instance.col,
    };
