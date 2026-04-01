import 'package:flutter/cupertino.dart';

/// SharedGameBoard is a "dumb" UI component that focuses solely on rendering the game board.
/// 
/// It does not contain any game logic or state management. It receives 
/// all necessary data (pieces, overlays, asset paths) from its parent.
class SharedGameBoard extends StatelessWidget {
  /// The total pixel size (width and height) of the board.
  final double size;
  
  /// The number of squares along one side of the board (e.g., 8, 10, 12).
  final int boardSize;
  
  /// The asset path for the board image.
  final String boardAssetPath;
  
  /// Callback function triggered when a square is tapped.
  final void Function(int row, int col)? onSquareTapped;

  /// Pre-built overlay widgets (highlights, indicators) provided by the parent.
  final List<Widget> overlayWidgets;
  
  /// Pre-built game piece widgets provided by the parent.
  final List<Widget> pieceWidgets;

  /// Creates a [SharedGameBoard].
  const SharedGameBoard({
    super.key,
    required this.size,
    required this.boardSize,
    required this.boardAssetPath,
    this.onSquareTapped,
    this.overlayWidgets = const [],
    this.pieceWidgets = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Layer 1: The Board Image
          Positioned.fill(
            child: Image.asset(
              boardAssetPath,
              fit: BoxFit.fill,
              gaplessPlayback: true,
              // Show a fallback painter if the asset fails to load.
              errorBuilder: (context, error, stackTrace) => CustomPaint(
                size: Size.infinite,
                painter: _FallbackBoardPainter(boardSize: boardSize),
              ),
            ),
          ),

          // Layer 2: Transparent tap detection areas.
          if (onSquareTapped != null)
            _buildTapDetector(context),

          // Layer 3: Overlay effects and indicators (pre-rendered for performance).
          ...overlayWidgets,

          // Layer 4: Game pieces (pre-rendered for performance).
          ...pieceWidgets,
        ],
      ),
    );
  }

  /// Helper method to create a grid of invisible tap detectors.
  Widget _buildTapDetector(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: boardSize),
      itemCount: boardSize * boardSize,
      itemBuilder: (context, index) {
        // Note: Logic for valid squares is handled by the GameProvider, 
        // so we don't need to check for dark squares here.
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            final int r = index ~/ boardSize;
            final int c = index % boardSize;
            onSquareTapped?.call(r, c);
          },
        );
      },
    );
  }
}

/// A fallback painter used to draw a simple checkered board if the asset image fails.
class _FallbackBoardPainter extends CustomPainter {
  final int boardSize;
  _FallbackBoardPainter({required this.boardSize});

  @override
  void paint(Canvas canvas, Size size) {
    final double squareSize = size.width / boardSize;
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        // Simple alternating grey squares.
        final paint = Paint()..color = (r + c).isOdd ? CupertinoColors.systemGrey2 : CupertinoColors.systemGrey5;
        canvas.drawRect(Rect.fromLTWH(c * squareSize, r * squareSize, squareSize, squareSize), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
