/// Represents the different variants of checkers that can be played.
enum GameMode {
  /// International Checkers (10x10 board, 20 pieces each).
  international,
  
  /// Turkish Draughts (8x8 board, 16 pieces each).
  turkish,
  
  /// English Draughts (also known as American Checkers, 8x8 board, 12 pieces each).
  english,
  
  /// Russian Draughts (8x8 board, 12 pieces each).
  russian,
  
  /// Spanish Draughts (8x8 board, 12 pieces each).
  spanish,
  
  /// Anti-Checkers (where the goal is to lose all your pieces).
  antiCheckers,
}