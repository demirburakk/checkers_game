// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piece.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Piece _$PieceFromJson(Map<String, dynamic> json) => Piece(
      id: json['id'] as String,
      color: $enumDecode(_$PieceColorEnumMap, json['color']),
      type: $enumDecodeNullable(_$PieceTypeEnumMap, json['type']) ??
          PieceType.man,
    );

Map<String, dynamic> _$PieceToJson(Piece instance) => <String, dynamic>{
      'id': instance.id,
      'color': _$PieceColorEnumMap[instance.color]!,
      'type': _$PieceTypeEnumMap[instance.type]!,
    };

const _$PieceColorEnumMap = {
  PieceColor.black: 'black',
  PieceColor.white: 'white',
};

const _$PieceTypeEnumMap = {
  PieceType.man: 'man',
  PieceType.king: 'king',
};
