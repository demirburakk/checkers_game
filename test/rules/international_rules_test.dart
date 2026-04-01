import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/international_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InternationalRules Tests', () {
    late InternationalRules rules;

    setUp(() {
      rules = InternationalRules();
    });

    test('Board Initialization should be correct for 10x10', () {
      final board = rules.initializeBoard();
      int whitePieces = 0;
      int blackPieces = 0;

      for (var row in board) {
        for (var piece in row) {
          if (piece != null) {
            if (piece.color == PieceColor.white) {
              whitePieces++;
            } else {
              blackPieces++;
            }
          }
        }
      }

      // 10x10 tahtada 20'şer taş olmalı.
      expect(whitePieces, 20);
      expect(blackPieces, 20);
      // Taşların ilk ve son 4 sırada olduğunu kontrol et.
      expect(board[0].where((p) => p != null).length, 5);
      expect(board[9].where((p) => p != null).length, 5);
    });

    test('Man CAN capture backward', () {
      // Senaryo: Beyaz piyon, normalde hareket edemeyeceği geriye doğru bir yeme hamlesi yapabilmeli.
      var board = List.generate(10, (_) => List<Piece?>.filled(10, null));
      const piecePos = BoardPosition(3, 4);
      board[piecePos.row][piecePos.col] = Piece(id: 'w1', color: PieceColor.white);

      board[4][5] = Piece(id: 'b1', color: PieceColor.black); // Arkadaki taş

      final gameState = GameState(board: board, gameMode: GameMode.international, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      // Geriye doğru yeme hamlesi tek olası hamle olmalı.
      expect(moves.length, 1);
      expect(moves.first.isCapture, isTrue);
      expect(moves.first.finalDestination, const BoardPosition(5, 6));
      expect(moves.first.capturedPieces.first, const BoardPosition(4, 5));
    });

    test('Max capture rule must be enforced', () {
      // Senaryo: 1 taş yeme ve 2 taş yeme seçeneği var. 2'li yol zorunlu olmalı.
      var board = List.generate(10, (_) => List<Piece?>.filled(10, null));
      const piecePos = BoardPosition(7, 4);
      board[piecePos.row][piecePos.col] = Piece(id: 'w1', color: PieceColor.white);

      // 2'li yeme yolu (ileri - geri)
      board[6][3] = Piece(id: 'b1', color: PieceColor.black);
      board[6][5] = Piece(id: 'b2', color: PieceColor.black);

      // 1'li yeme yolu
      board[6][1] = Piece(id: 'b3', color: PieceColor.black);

      final gameState = GameState(board: board, gameMode: GameMode.international, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      expect(moves.length, 1);
      expect(moves.first.capturedPieces.length, 2);
    });

    test('King should fly over empty squares diagonally', () {
      var board = List.generate(10, (_) => List<Piece?>.filled(10, null));
      const kingPos = BoardPosition(5, 4);
      board[kingPos.row][kingPos.col] = Piece(id: 'w_king', color: PieceColor.white, type: PieceType.king);

      final gameState = GameState(board: board, gameMode: GameMode.international, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      // Köşelere uçuş hamlelerini içerdiğini kontrol et
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(1, 0)))); // Sol-Yukarı
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(0, 9)))); // Sağ-Yukarı
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(9, 0)))); // Sol-Aşağı
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(9, 8)))); // Sağ-Aşağı

      // Toplam hamle sayısı, her yöndeki boş kare sayısı kadardır.
      // (4+4+4+5) = 17
      expect(moves.length, 17);
    });

    test('King should perform flying capture', () {
      var board = List.generate(10, (_) => List<Piece?>.filled(10, null));
      const kingPos = BoardPosition(9, 0);
      board[kingPos.row][kingPos.col] = Piece(id: 'w_king', color: PieceColor.white, type: PieceType.king);
      board[4][5] = Piece(id: 'b1', color: PieceColor.black);

      final gameState = GameState(board: board, gameMode: GameMode.international, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      // Dama, yediği taşın arkasındaki herhangi bir boş kareye konabilir.
      // Bu nedenle 4 olası hamle (3,6), (2,7), (1,8), (0,9) vardır. Hepsi yeme hamlesidir.
      expect(moves.length, 4);
      expect(moves.every((move) => move.isCapture), isTrue);
      expect(moves.every((move) => move.capturedPieces.first == const BoardPosition(4, 5)), isTrue);

      // Olası iniş noktalarından birini içeriyor mu diye kontrol et.
      expect(moves, contains(isA<Move>().having((m) => m.finalDestination, 'destination', const BoardPosition(2, 7))));
    });
  });
}