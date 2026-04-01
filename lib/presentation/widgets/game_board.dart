import 'package:checkers_game/domain/models/board_position.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/move.dart';
import 'package:checkers_game/presentation/widgets/animated_game_piece.dart';
import 'package:checkers_game/presentation/widgets/shared_game_board.dart';
import 'package:checkers_game/providers/game_provider.dart';
import 'package:checkers_game/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// GameBoard is a "smart" container widget that manages the game state 
/// from providers, handles interaction logic, and feeds the "dumb" 
/// SharedGameBoard with the necessary data for rendering.
class GameBoard extends StatelessWidget {
  /// Creates a [GameBoard] widget.
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the game and theme providers for changes.
    final game = context.watch<GameProvider>();
    final theme = context.watch<ThemeProvider>();

    final GameState resolvedGameState = game.gameState;
    final boardSize = resolvedGameState.rules.boardSize;

    // The main board widget wrapped in a LayoutBuilder to determine available space.
    final boardWidget = LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;
        final squareSize = size / boardSize;

        // RepaintBoundary helps optimize performance by limiting the area that needs repainting.
        return RepaintBoundary(
          child: SharedGameBoard(
            size: size,
            boardSize: boardSize,
            boardAssetPath: theme.getBoardAssetPath(theme.selectedBoardTheme, boardSize),
            onSquareTapped: game.onSquareTapped,
            // Prepare overlay widgets (highlights, hints, etc.) and pieces for the dumb component.
            overlayWidgets: _buildOverlayWidgets(context, game, size),
            pieceWidgets: _buildPieceWidgets(game.gameState, game.moveBeingAnimated, game.capturedPiecePositions, squareSize, game.isBoardFlipped),
          ),
        );
      },
    );

    // Show or hide the coordinate frame based on user settings.
    if (game.showCoordinates) {
      return _BoardFrame(
        boardSize: boardSize,
        isFlipped: game.isBoardFlipped,
        child: boardWidget,
      );
    } else {
      return boardWidget;
    }
  }

  /// Builds all game piece widgets currently present on the board.
  /// 
  /// Handles logical to visual position transformation and piece animations.
  List<Widget> _buildPieceWidgets(GameState gameState, AnimatedMove? animatedMove, Set<BoardPosition> capturedPositions, double squareSize, bool isFlipped) {
    final List<Widget> pieces = [];
    final boardSize = gameState.rules.boardSize;

    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        final logicalPos = BoardPosition(r, c);
        var piece = gameState.board[logicalPos.row][logicalPos.col];

        // If a piece is currently being animated (moving), don't draw it at its source position.
        if (animatedMove != null && animatedMove.move.from == logicalPos) {
          piece = null;
        }

        if (piece != null) {
          final visualPos = _transformPosition(logicalPos, isFlipped, boardSize);
          pieces.add(
            AnimatedGamePiece(
              key: ValueKey(piece.id),
              piece: piece,
              top: visualPos.row * squareSize,
              left: visualPos.col * squareSize,
              size: squareSize,
              isSelected: gameState.selectedPosition == logicalPos,
              isCaptured: capturedPositions.contains(logicalPos),
            ),
          );
        }
      }
    }

    // Add the piece that is currently moving as an animated widget.
    if (animatedMove != null) {
      final visualPos = _transformPosition(animatedMove.move.finalDestination, isFlipped, boardSize);
      pieces.add(
        AnimatedGamePiece(
          key: ValueKey(animatedMove.piece.id),
          piece: animatedMove.piece,
          top: visualPos.row * squareSize,
          left: visualPos.col * squareSize,
          size: squareSize,
        ),
      );
    }
    return pieces;
  }

  /// Builds all overlay effects like selection highlights, move hints, and last move indicators.
  List<Widget> _buildOverlayWidgets(BuildContext context, GameProvider game, double boardSizePx) {
    final state = game.gameState;
    final rules = state.rules;
    final squareSize = boardSizePx / rules.boardSize;
    final isFlipped = game.isBoardFlipped;

    final List<Widget> overlays = [];

    // Highlight the last move made.
    if (game.lastMove != null) {
      overlays.addAll(_buildLastMoveHighlights(game.lastMove!, squareSize, isFlipped, rules.boardSize));
    }

    // Show visual feedback for an invalid selection.
    if (game.invalidSelectionPosition != null) {
      final visualPos = _transformPosition(game.invalidSelectionPosition!, isFlipped, rules.boardSize);
      overlays.add(Positioned(
        key: ValueKey('invalid_${game.invalidSelectionPosition}'),
        top: visualPos.row * squareSize, left: visualPos.col * squareSize, width: squareSize, height: squareSize,
        child: const IgnorePointer(child: _InvalidSelectionAnimator()),
      ));
    }

    // Highlight possible destinations for the selected piece.
    if (state.selectedPosition != null) {
      final nextDestinations = <BoardPosition>{};
      final possibleMovesFromSelection = state.possibleMoves.where((move) => move.from == state.selectedPosition);
      for (final move in possibleMovesFromSelection) {
        if (move.sequence.isNotEmpty) {
          // For multi-jump moves, show all intermediate steps as well.
          for (final step in move.sequence) {
            nextDestinations.add(step.to);
          }
        } else {
          // Simple move.
          nextDestinations.add(move.to);
        }
      }
      for (final dest in nextDestinations) {
        final visualDest = _transformPosition(dest, isFlipped, rules.boardSize);
        overlays.add(Positioned(
          key: ValueKey('possible_$dest'),
          top: visualDest.row * squareSize, left: visualDest.col * squareSize, width: squareSize, height: squareSize,
          child: IgnorePointer(child: _PulsingCircleIndicator(size: squareSize, color: CupertinoColors.white)),
        ));
      }
    }

    // Show a move hint if requested by the user or AI.
    if (game.hintMove != null) {
      final hintBorderColor = CupertinoTheme.of(context).primaryColor;
      final visualFrom = _transformPosition(game.hintMove!.from, isFlipped, rules.boardSize);
      final visualTo = _transformPosition(game.hintMove!.finalDestination, isFlipped, rules.boardSize);
      overlays.add(Positioned(
        key: ValueKey('hint_from_${game.hintMove!.from}'), top: visualFrom.row * squareSize, left: visualFrom.col * squareSize, width: squareSize, height: squareSize,
        child: IgnorePointer(child: Container(decoration: BoxDecoration(border: Border.all(color: hintBorderColor, width: 3)))),
      ));
      overlays.add(Positioned(
        key: ValueKey('hint_to_${game.hintMove!.to}'), top: visualTo.row * squareSize, left: visualTo.col * squareSize, width: squareSize, height: squareSize,
        child: IgnorePointer(child: _PulsingCircleIndicator(size: squareSize, color: hintBorderColor)),
      ));
    }

    return overlays;
  }

  /// Transforms a logical board position to a visual one based on whether the board is flipped.
  BoardPosition _transformPosition(BoardPosition logicalPos, bool isFlipped, int boardSize) {
    if (!isFlipped) return logicalPos;
    return BoardPosition(boardSize - 1 - logicalPos.row, boardSize - 1 - logicalPos.col);
  }

  /// Builds highlight indicators for the start and end positions of the last move.
  List<Widget> _buildLastMoveHighlights(Move lastMove, double squareSize, bool isFlipped, int boardSize) {
    final fromPos = _transformPosition(lastMove.from, isFlipped, boardSize);
    final toPos = _transformPosition(lastMove.to, isFlipped, boardSize);
    return [
      Positioned(
        key: ValueKey('from_${lastMove.from}'), top: fromPos.row * squareSize, left: fromPos.col * squareSize, width: squareSize, height: squareSize,
        child: IgnorePointer(child: Container(decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: const Color(0xFFFFFDE7).withAlpha(120), blurRadius: 12.0, spreadRadius: 2.0)]))),
      ),
      Positioned(
        key: ValueKey('to_${lastMove.to}'), top: toPos.row * squareSize, left: toPos.col * squareSize, width: squareSize, height: squareSize,
        child: IgnorePointer(child: Container(decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: const Color(0xFFFFF59D).withAlpha(160), blurRadius: 16.0, spreadRadius: 2.0)]))),
      ),
    ];
  }
}

/// Internal widget that adds a border frame with coordinates (a-h, 1-8) around the board.
class _BoardFrame extends StatelessWidget {
  final Widget child;
  final int boardSize;
  final bool isFlipped;

  const _BoardFrame({
    required this.child,
    required this.boardSize,
    required this.isFlipped,
  });

  @override
  Widget build(BuildContext context) {
    const double frameSize = 20.0;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(frameSize),
          child: child,
        ),
        IgnorePointer(
          child: CustomPaint(
            size: Size.infinite,
            painter: _CoordinatePainter(
              boardSize: boardSize,
              frameSize: frameSize,
              isFlipped: isFlipped,
              theme: CupertinoTheme.of(context),
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom painter for drawing board coordinates (letters and numbers).
class _CoordinatePainter extends CustomPainter {
  final int boardSize;
  final double frameSize;
  final bool isFlipped;
  final CupertinoThemeData theme;

  _CoordinatePainter({
    required this.boardSize,
    required this.frameSize,
    required this.isFlipped,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: theme.textTheme.textStyle.color?.withAlpha(180),
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
    );
    final double squareSize = (size.width - frameSize * 2) / boardSize;
    List<String> ranks = List.generate(boardSize, (i) => (boardSize - i).toString());
    List<String> files = List.generate(boardSize, (i) => String.fromCharCode('a'.codeUnitAt(0) + i));

    if (isFlipped) {
      ranks = ranks.reversed.toList();
      files = files.reversed.toList();
    }

    for (int i = 0; i < boardSize; i++) {
      // Draw Rank numbers on both sides.
      final rankText = TextPainter(text: TextSpan(text: ranks[i], style: textStyle), textDirection: TextDirection.ltr,)..layout();
      final rankY = frameSize + (i * squareSize) + (squareSize / 2) - (rankText.height / 2);
      rankText.paint(canvas, Offset(frameSize / 2 - rankText.width / 2, rankY));
      rankText.paint(canvas, Offset(size.width - frameSize / 2 - rankText.width / 2, rankY));

      // Draw File letters on top and bottom.
      final fileText = TextPainter(text: TextSpan(text: files[i], style: textStyle), textDirection: TextDirection.ltr,)..layout();
      final fileX = frameSize + (i * squareSize) + (squareSize / 2) - (fileText.width / 2);
      fileText.paint(canvas, Offset(fileX, frameSize / 2 - fileText.height / 2));
      fileText.paint(canvas, Offset(fileX, size.height - frameSize / 2 - fileText.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _CoordinatePainter oldDelegate) {
    return oldDelegate.isFlipped != isFlipped || oldDelegate.theme != theme;
  }
}

/// A pulsing circle animation used to indicate possible move destinations or hints.
class _PulsingCircleIndicator extends StatefulWidget {
  final double size;
  final Color color;
  const _PulsingCircleIndicator({required this.size, required this.color});

  @override
  State<_PulsingCircleIndicator> createState() => _PulsingCircleIndicatorState();
}

class _PulsingCircleIndicatorState extends State<_PulsingCircleIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.7, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animation,
        child: Container(
          width: widget.size * 0.35,
          height: widget.size * 0.35,
          decoration: BoxDecoration(
            color: widget.color.withAlpha(150),
            shape: BoxShape.circle,
            border: Border.all(color: widget.color, width: 2),
          ),
        ),
      ),
    );
  }
}

/// An animation that flashes a red overlay when an invalid move or selection is attempted.
class _InvalidSelectionAnimator extends StatefulWidget {
  const _InvalidSelectionAnimator();

  @override
  State<_InvalidSelectionAnimator> createState() => _InvalidSelectionAnimatorState();
}

class _InvalidSelectionAnimatorState extends State<_InvalidSelectionAnimator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  int _cycleCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _opacity = Tween<double>(begin: 1.0, end: 0.4).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_cycleCount < 3) { _controller.reverse(); _cycleCount++; }
      } else if (status == AnimationStatus.dismissed) {
        if (_cycleCount < 3) { _controller.forward(); }
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        decoration: BoxDecoration(color: CupertinoColors.systemRed.withAlpha(120), border: Border.all(color: CupertinoColors.systemRed, width: 2)),
      ),
    );
  }
}
