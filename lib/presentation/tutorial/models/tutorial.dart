import 'package:checkers_game/presentation/tutorial/models/tutorial_step.dart';

/// A class representing a complete tutorial series.
/// 
/// A tutorial consists of a title and a sequence of [TutorialStep] objects.
class Tutorial {
  /// The main title of the tutorial (e.g., "How to Play Checkers").
  final String title;
  
  /// The ordered list of steps that make up this tutorial.
  final List<TutorialStep> steps;

  /// Creates a [Tutorial] with the given title and steps.
  Tutorial({required this.title, required this.steps});
}
