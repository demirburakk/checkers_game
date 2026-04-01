// lib/presentation/utils/player_type.dart
import 'package:json_annotation/json_annotation.dart';

/// Defines the types of players that can participate in a game.
@JsonEnum()
enum PlayerType {
  /// A human player controlled by user input.
  human,
  /// An artificial intelligence player.
  ai,
}