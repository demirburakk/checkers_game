import 'package:flutter/cupertino.dart';

/// A simplified, non-interactive checkers board widget.
/// 
/// Used for theme selection previews or decorative purposes.
class MiniBoard extends StatelessWidget {
  /// Color used for the light squares.
  final Color lightSquareColor;
  
  /// Color used for the dark squares.
  final Color darkSquareColor;
  
  /// The number of squares along one side of the board (e.g., 8 for 8x8).
  final int boardSize;

  /// Creates a [MiniBoard] with specified colors and size.
  const MiniBoard({
    super.key,
    required this.lightSquareColor,
    required this.darkSquareColor,
    this.boardSize = 8, // Default is 8x8 board.
  });

  @override
  Widget build(BuildContext context) {
    // Renders the board as a grid of colored containers.
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: boardSize,
      ),
      itemCount: boardSize * boardSize,
      itemBuilder: (context, index) {
        // Calculate the row and column from the flat index.
        int row = index ~/ boardSize;
        int col = index % boardSize;
        
        // In checkers, squares alternate colors. 
        // A square is dark if the sum of its row and column indices is odd.
        bool isDark = (row + col).isOdd;
        
        return Container(
          color: isDark ? darkSquareColor : lightSquareColor,
        );
      },
    );
  }
}
