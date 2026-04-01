import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/spanish_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SpanishRules Tests', () {
    late SpanishRules rules;

    setUp(() {
      rules = SpanishRules();
    });

    test('Man CANNOT capture backward', () {
      // Senaryo: Beyaz piyonun arkasında yenilebilecek bir taş var.
      // İspanyol kuralı buna izin vermemeli.
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const piecePos = BoardPosition(3, 4);
      board[piecePos.row][piecePos.col] = Piece(id: 'w1', color: PieceColor.white);

      board[4][5] = Piece(id: 'b1', color: PieceColor.black); // Arkadaki taş

      final gameState = GameState(board: board, gameMode: GameMode.spanish, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      // Geriye doğru yeme hamlesi olmamalı.
      // Bu durumda hiç yeme hamlesi olmadığı için, getPossibleMoves normal hareketleri döndürmeli.
      expect(moves.every((move) => move.isCapture), isFalse,
          reason: "Piyonlar geriye doğru yiyememeli."
      );
    });

    test('Man CAN capture forward', () {
      // Bir önceki testin tersi: Piyon ileri doğru yiyebilmeli.
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const piecePos = BoardPosition(3, 4);
      board[piecePos.row][piecePos.col] = Piece(id: 'w1', color: PieceColor.white);

      board[2][5] = Piece(id: 'b1', color: PieceColor.black); // Öndeki taş

      final gameState = GameState(board: board, gameMode: GameMode.spanish, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      expect(moves.length, 1);
      expect(moves.first.isCapture, isTrue);
      expect(moves.first.finalDestination, const BoardPosition(1, 6));
    });

    test('Max capture rule must be enforced', () {
      // Senaryo: 1 taş yeme ve 2 taş yeme seçeneği var. 2'li yol zorunlu olmalı.
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const piecePos = BoardPosition(5, 4);
      board[piecePos.row][piecePos.col] = Piece(id: 'w1', color: PieceColor.white);

      // 2'li yeme yolu
      board[4][3] = Piece(id: 'b1', color: PieceColor.black);
      board[2][3] = Piece(id: 'b2', color: PieceColor.black);

      // 1'li yeme yolu
      board[4][5] = Piece(id: 'b3', color: PieceColor.black);

      final gameState = GameState(board: board, gameMode: GameMode.spanish, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      expect(moves.length, 1, reason: "En çok yeme kuralı uygulanmalı");
      expect(moves.first.capturedPieces.length, 2);
    });

    test('King can fly and capture in any direction', () {
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const kingPos = BoardPosition(7, 0);
      board[kingPos.row][kingPos.col] = Piece(id: 'w_king', color: PieceColor.white, type: PieceType.king);
      board[3][4] = Piece(id: 'b1', color: PieceColor.black);

      final gameState = GameState(board: board, gameMode: GameMode.spanish, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      // **** HATA BURADAYDI ****
      // ESKİ HALİ: expect(moves.length, 2, ...
      // YENİ VE DOĞRU HALİ:
      expect(moves.length, 3, reason: "Dama, yediği taşın arkasındaki tüm boş karelere konabilmeli");

      expect(moves.every((move) => move.isCapture), isTrue);
      expect(moves.every((move) => move.capturedPieces.first == const BoardPosition(3, 4)), isTrue);

      // Olası tüm iniş noktalarını içeriyor mu diye kontrol et.
      expect(moves, contains(isA<Move>().having((m) => m.finalDestination, 'destination', const BoardPosition(2, 5))));
      expect(moves, contains(isA<Move>().having((m) => m.finalDestination, 'destination', const BoardPosition(1, 6))));
      // Eksik olan üçüncü kontrolü de ekleyelim:
      expect(moves, contains(isA<Move>().having((m) => m.finalDestination, 'destination', const BoardPosition(0, 7))));
    });
  });
}