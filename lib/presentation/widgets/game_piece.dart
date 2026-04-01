import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

/// A widget that renders a single checkers piece using a raw [ui.Image].
/// 
/// This is a low-level widget used for direct image rendering of pieces.
class GamePiece extends StatelessWidget {
  /// The raw image of the piece to be rendered.
  final ui.Image? image;

  /// Creates a [GamePiece] widget.
  const GamePiece({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // If there is no image to display, return an empty box.
    if (image == null) {
      return const SizedBox.shrink();
    }

    // FIX: We add padding around the piece to make it appear smaller 
    // relative to the board square, which is more visually appealing.
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: RawImage(
        image: image,
        fit: BoxFit.contain,
      ),
    );
  }
}
