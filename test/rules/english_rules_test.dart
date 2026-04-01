import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/rules/english_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnglishRules Tests', () {
    late EnglishRules rules;

    setUp(() {
      rules = EnglishRules();
    });

    test('Board Initialization should be correct for 8x8', () {
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
      expect(whitePieces, 12);
      expect(blackPieces, 12);
    });

    test('Any capture is mandatory (not max capture)', () {
      // Senaryo: Beyaz'ın iki farklı 1'li yeme seçeneği var.
      // İngiliz Daması'nda en çok yeme kuralı olmadığı için ikisi de geçerli olmalı.
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const piecePos = BoardPosition(5, 4);
      board[piecePos.row][piecePos.col] = Piece(id: 'w1', color: PieceColor.white);

      // Seçenek 1
      board[4][3] = Piece(id: 'b1', color: PieceColor.black);
      // Seçenek 2
      board[4][5] = Piece(id: 'b2', color: PieceColor.black);

      final gameState = GameState(board: board, gameMode: GameMode.english, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      // İki olası yeme hamlesi de listede olmalı.
      expect(moves.length, 2);

      // İki hamlenin de yeme hamlesi olduğunu ve doğru pozisyonları içerdiğini doğrula
      final move1 = moves.firstWhere((m) => m.finalDestination == const BoardPosition(3, 2));
      final move2 = moves.firstWhere((m) => m.finalDestination == const BoardPosition(3, 6));

      expect(move1.isCapture, isTrue);
      expect(move1.capturedPieces.first, const BoardPosition(4, 3));

      expect(move2.isCapture, isTrue);
      expect(move2.capturedPieces.first, const BoardPosition(4, 5));
    });

    test('Man cannot capture backward', () {
      // Senaryo: Beyaz piyonun arkasında yenilebilecek bir taş var, ama İngiliz kuralı buna izin vermez.
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const piecePos = BoardPosition(3, 4);
      board[piecePos.row][piecePos.col] = Piece(id: 'w1', color: PieceColor.white);

      board[4][5] = Piece(id: 'b1', color: PieceColor.black); // Arkadaki taş

      final gameState = GameState(board: board, gameMode: GameMode.english, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      // Geriye doğru yeme hamlesi olmamalı. Bu durumda hiç yeme hamlesi olamaz.
      // getPossibleMoves bu durumda normal hareket hamlelerini döndürmeli.
      expect(moves.every((move) => move.isCapture), isFalse);
    });

    test('King moves only one square diagonally (short range)', () {
      var board = List.generate(8, (_) => List<Piece?>.filled(8, null));
      const kingPos = BoardPosition(3, 4);
      board[kingPos.row][kingPos.col] = Piece(id: 'w_king', color: PieceColor.white, type: PieceType.king);

      final gameState = GameState(board: board, gameMode: GameMode.english, currentPlayer: PieceColor.white);
      final moves = rules.getPossibleMoves(gameState);

      // Sadece 4 yöne tek karelik hamleleri içermeli
      expect(moves.length, 4);
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(2, 3))));
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(2, 5))));
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(4, 3))));
      expect(moves, contains(const Move(from: kingPos, to: BoardPosition(4, 5))));

      // Uçuş hamlesi içermemeli
      expect(moves, isNot(contains(const Move(from: kingPos, to: BoardPosition(1, 6)))));
    });
  });
}