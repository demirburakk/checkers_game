import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart'; // GameMode'u import etmeliyiz.
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/turkish_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TurkishRules Tests', () {
    late TurkishRules rules;

    setUp(() {
      rules = TurkishRules();
    });

    test('Board Initialization should be correct', () {
      final board = rules.initializeBoard();

      int whitePieces = 0;
      int blackPieces = 0;

      for (var row in board) {
        for (var piece in row) {
          if (piece != null) {
            if (piece.color == PieceColor.white) whitePieces++;
            if (piece.color == PieceColor.black) blackPieces++;
          }
        }
      }

      expect(whitePieces, 16);
      expect(blackPieces, 16);
      expect(board[5].every((p) => p?.color == PieceColor.white), isTrue);
      expect(board[6].every((p) => p?.color == PieceColor.white), isTrue);
    });

    test('Man should move forward and sideways, but not backward', () {
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const piecePos = BoardPosition(4, 3); // INFO DÜZELTMESİ: 'const' eklendi
      board[piecePos.row][piecePos.col] = Piece(id: 'w1', color: PieceColor.white);

      // HATA DÜZELTMESİ: rules.gameMode yerine doğrudan GameMode.turkish kullanıyoruz.
      final gameState = GameState(board: board, gameMode: GameMode.turkish, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      expect(moves, contains(const Move(from: piecePos, to: BoardPosition(3, 3)))); // İleri
      expect(moves, contains(const Move(from: piecePos, to: BoardPosition(4, 2)))); // Sol
      expect(moves, contains(const Move(from: piecePos, to: BoardPosition(4, 4)))); // Sağ

      expect(moves, isNot(contains(const Move(from: piecePos, to: BoardPosition(5, 3))))); // Geri
      expect(moves, isNot(contains(const Move(from: piecePos, to: BoardPosition(3, 2))))); // Çapraz

      expect(moves.length, 3);
    });

    test('Max capture rule must be enforced', () {
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const piecePos = BoardPosition(4, 3); // INFO DÜZELTMESİ: 'const' eklendi
      board[piecePos.row][piecePos.col] = Piece(id: 'w1', color: PieceColor.white);

      board[3][3] = Piece(id: 'b1', color: PieceColor.black);
      board[1][3] = Piece(id: 'b2', color: PieceColor.black);
      board[4][2] = Piece(id: 'b3', color: PieceColor.black);

      // HATA DÜZELTMESİ: rules.gameMode yerine doğrudan GameMode.turkish kullanıyoruz.
      final gameState = GameState(board: board, gameMode: GameMode.turkish, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      expect(moves.length, 1);
      expect(moves.first.capturedPieces.length, 2);
      expect(moves.first.finalDestination, const BoardPosition(0, 3)); // INFO DÜZELTMESİ: 'const' eklendi
    });

    test('King should fly over empty squares orthogonally', () {
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const kingPos = BoardPosition(3, 3); // INFO DÜZELTMESİ: 'const' eklendi
      board[kingPos.row][kingPos.col] = Piece(id: 'w_king', color: PieceColor.white, type: PieceType.king);

      // HATA DÜZELTMESİ: rules.gameMode yerine doğrudan GameMode.turkish kullanıyoruz.
      final gameState = GameState(board: board, gameMode: GameMode.turkish, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(0, 3)))); // Yukarı
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(7, 3)))); // Aşağı
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(3, 0)))); // Sol
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(3, 7)))); // Sağ
      expect(moves.length, (3+4+3+4));
    });
  });
}