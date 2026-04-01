// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameState _$GameStateFromJson(Map<String, dynamic> json) => GameState(
      board: (json['board'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) =>
                  e == null ? null : Piece.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      gameMode: $enumDecode(_$GameModeEnumMap, json['gameMode']),
      currentPlayer:
          $enumDecodeNullable(_$PieceColorEnumMap, json['currentPlayer']) ??
              PieceColor.white,
      selectedPosition: json['selectedPosition'] == null
          ? null
          : BoardPosition.fromJson(
              json['selectedPosition'] as Map<String, dynamic>),
      whitePlayerType:
          $enumDecodeNullable(_$PlayerTypeEnumMap, json['whitePlayerType']) ??
              PlayerType.human,
      blackPlayerType:
          $enumDecodeNullable(_$PlayerTypeEnumMap, json['blackPlayerType']) ??
              PlayerType.human,
      movesSinceSignificantEvent:
          (json['movesSinceSignificantEvent'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'board': instance.board
          .map((e) => e.map((e) => e?.toJson()).toList())
          .toList(),
      'currentPlayer': _$PieceColorEnumMap[instance.currentPlayer]!,
      'gameMode': _$GameModeEnumMap[instance.gameMode]!,
      'whitePlayerType': _$PlayerTypeEnumMap[instance.whitePlayerType]!,
      'blackPlayerType': _$PlayerTypeEnumMap[instance.blackPlayerType]!,
      'movesSinceSignificantEvent': instance.movesSinceSignificantEvent,
      'selectedPosition': instance.selectedPosition?.toJson(),
    };

const _$GameModeEnumMap = {
  GameMode.international: 'international',
  GameMode.turkish: 'turkish',
  GameMode.english: 'english',
  GameMode.russian: 'russian',
  GameMode.spanish: 'spanish',
  GameMode.antiCheckers: 'antiCheckers',
};

const _$PieceColorEnumMap = {
  PieceColor.black: 'black',
  PieceColor.white: 'white',
};

const _$PlayerTypeEnumMap = {
  PlayerType.human: 'human',
  PlayerType.ai: 'ai',
};
