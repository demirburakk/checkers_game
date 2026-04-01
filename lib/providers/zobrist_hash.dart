// FILE: lib/providers/zobrist_hash.dart
import 'dart:math';
import 'package:checkers_game/domain/models/piece.dart';

/// [ZobristHash] implements Zobrist hashing for the checkers game board.
/// This technique is used to represent a game state with a single 64-bit integer,
/// which is essential for transposition tables in AI search.
class ZobristHash {
  /// The size of the game board (e.g., 8, 10, or 12).
  final int boardSize;

  /// A 3D table storing random 64-bit integers for each square and piece type.
  /// Structure: [row][col][pieceIndex]
  late final List<List<List<int>>> _zobristTable;

  /// A random 64-bit integer used to represent whose turn it is.
  late final int playerHash;

  /// Random number generator with a fixed seed to ensure consistent hashes across sessions.
  final _random = Random(12345);

  /// Generates a random 64-bit integer.
  /// Dart's `nextInt` is limited to 32 bits on web. This method combines
  /// two 32-bit integers to reliably produce a 64-bit value.
  int _next64BitInt() {
    final int part1 = _random.nextInt(1 << 32); // Lower 32 bits
    final int part2 = _random.nextInt(1 << 32); // Upper 32 bits
    return (part2 << 32) | part1; // Combine by shifting and ORing.
  }

  /// Initializes the Zobrist table with random values for all possible piece placements.
  ZobristHash(this.boardSize) {
    // 4 possible piece types: white man, white king, black man, black king
    _zobristTable = List.generate(
      boardSize,
          (_) => List.generate(
        boardSize,
        // Fill table with 64-bit random numbers using our helper method.
            (_) => List.generate(4, (_) => _next64BitInt()),
        growable: false,
      ),
      growable: false,
    );
    // Generate a 64-bit hash for the player turn indicator.
    playerHash = _next64BitInt();
  }

  /// Returns the hash value for a specific piece at a specific board position.
  int getPieceHash(int row, int col, Piece piece) {
    // 0: white man, 1: white king, 2: black man, 3: black king
    int pieceIndex = piece.color == PieceColor.white ? 0 : 2;
    if (piece.type == PieceType.king) {
      pieceIndex++;
    }
    return _zobristTable[row][col][pieceIndex];
  }

  /// Calculates the full Zobrist hash for the entire board state.
  int calculateFullHash(List<List<Piece?>> board, PieceColor currentPlayer) {
    int hash = 0;
    
    // XOR the player hash if it's the black player's turn.
    if (currentPlayer == PieceColor.black) {
      hash ^= playerHash;
    }

    // XOR the hash values for all pieces currently on the board.
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        final piece = board[r][c];
        if (piece != null) {
          hash ^= getPieceHash(r, c, piece);
        }
      }
    }
    return hash;
  }
}