// FILE: lib/domain/ai/ai_isolate_manager.dart
import 'dart:async';
import 'dart:isolate';
import 'package:checkers_game/domain/ai/ai_player.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/providers/zobrist_hash.dart';
import 'package:flutter/foundation.dart';

/// Data structure passed to the AI Isolate to perform move calculations.
class AiIsolateData {
  /// The port through which the Isolate communicates back to the main thread.
  final SendPort sendPort;
  
  /// The current state of the game for which the best move needs to be calculated.
  final GameState gameState;
  
  /// The search depth or difficulty level for the AI.
  final int level;
  
  /// Zobrist Hash instance used for efficient board state representation and caching.
  final ZobristHash zobristHash;

  AiIsolateData(this.sendPort, this.gameState, this.level, this.zobristHash);
}

/// The entry point for the AI Isolate.
/// 
/// This function runs in a separate thread to avoid blocking the UI.
/// It calculates the best move using [AiPlayer.findBestMove] and sends the result back.
void aiIsolateEntry(AiIsolateData data) {
  try {
    // Perform the heavy move calculation.
    final bestMove = AiPlayer.findBestMove(data.gameState, data.level, data.zobristHash);
    
    // Send the calculated best move back to the main thread.
    data.sendPort.send(bestMove);
  } catch(e, stacktrace) {
    // If an error occurs during calculation, wrap it and send it back.
    data.sendPort.send(IsolateError(e, stacktrace));
  }
}

/// Represents an error that occurred within an Isolate.
class IsolateError {
  /// The error object thrown.
  final Object error;
  
  /// The stack trace associated with the error.
  final StackTrace stackTrace;
  
  IsolateError(this.error, this.stackTrace);
}

/// Manager class responsible for spawning and managing AI Isolates.
class AiIsolateManager {
  /// Spawns a new Isolate to find the best move for the given game state.
  /// 
  /// Returns a [Future] that completes with the best [Move] found.
  /// This prevents the UI from freezing during deep AI search operations.
  static Future<Move> findBestMoveInIsolate(GameState gameState, int level, ZobristHash zobristHash) async {
    final completer = Completer<Move>();
    
    // ReceivePort used to listen for the result from the Isolate.
    final receivePort = ReceivePort();

    final isolateData = AiIsolateData(receivePort.sendPort, gameState, level, zobristHash);

    try {
      // Spawn a new isolate to execute the AI logic.
      final isolate = await Isolate.spawn(
        aiIsolateEntry,
        isolateData,
        // Errors during isolate spawning or execution can be piped back here.
        onError: receivePort.sendPort,
      );

      // Listen for messages from the isolate.
      receivePort.listen((message) {
        if (message is Move) {
          // Calculation completed successfully.
          completer.complete(message);
        } else if (message is IsolateError) {
          // A known error occurred during move finding.
          debugPrint("Error from Isolate: ${message.error}\n${message.stackTrace}");
          completer.completeError(message.error, message.stackTrace);
        } else {
          // Unexpected message format, possibly an unhandled exception or platform error.
          debugPrint("Unexpected message from AI isolate: $message");
          completer.completeError(Exception("AI isolate terminated with an unknown error."));
        }

        // Cleanup: close the port and terminate the isolate once the work is done.
        receivePort.close();
        isolate.kill(priority: Isolate.immediate);
      });

    } catch(e) {
      // Failed to spawn the isolate.
      completer.completeError(Exception("Failed to create Isolate: $e"));
      receivePort.close();
    }

    return completer.future;
  }
}
