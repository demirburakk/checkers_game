/// Represents the possible reasons for a game of checkers ending in a draw.
enum DrawReason {
  /// The same board position has occurred three times during the game.
  threefoldRepetition,
  
  /// 50 consecutive moves have been made without a capture or a piece becoming a king.
  fiftyMoveRule,
  
  /// 40 consecutive moves have been made without a capture or a piece becoming a king.
  fortyMoveRule,
  
  /// 25 consecutive moves have been made without a capture or a piece becoming a king.
  twentyFiveMoveRule,
  
  /// 15 consecutive moves have been made without a capture or a piece becoming a king.
  fifteenMoveRule,
  
  /// Neither player has enough pieces left to force a win.
  insufficientMaterial,
  
  /// A situation where a player whose turn it is to move is not in check but has no legal move.
  stalemate,
}

/// Provides extension methods for the [DrawReason] enum.
extension DrawReasonExtension on DrawReason {
  /// Returns a user-friendly explanation of why the game ended in a draw.
  String get explanation {
    switch (this) {
      case DrawReason.threefoldRepetition:
        return 'The same position was repeated three times.';
      case DrawReason.fiftyMoveRule:
        return 'No captures or kinging for 50 moves.';
      case DrawReason.fortyMoveRule:
        return 'No captures or kinging for 40 moves.';
      case DrawReason.twentyFiveMoveRule:
        return 'No captures or kinging for 25 moves.';
      case DrawReason.fifteenMoveRule:
        return 'No captures or kinging for 15 moves.';
      case DrawReason.insufficientMaterial:
        return 'Remaining pieces are insufficient to win the game.';
      case DrawReason.stalemate:
        return 'Neither player has any valid moves left.';
    }
  }
}