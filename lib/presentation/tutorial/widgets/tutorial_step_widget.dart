// lib/presentation/tutorial/widgets/tutorial_step_widget.dart

import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial_step.dart';
import 'package:checkers_game/presentation/widgets/game_board.dart';
import 'package:checkers_game/providers/game_provider.dart';
import 'package:checkers_game/providers/tutorial_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// A widget that represents a single step in the tutorial.
/// It displays the game board for the step and a description area with
/// navigation/action buttons.
class TutorialStepWidget extends StatelessWidget {
  /// The [TutorialStep] data to be displayed in this widget.
  final TutorialStep step;

  const TutorialStepWidget({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    // We create a TutorialProvider specifically for this step and provide it 
    // as a GameProvider. This allows the GameBoard and other widgets to 
    // consume it normally through the standard GameProvider interface.
    return ChangeNotifierProvider<GameProvider>(
      create: (context) => TutorialProvider(step),
      child: const _TutorialStepView(),
    );
  }
}

/// The internal view of a tutorial step, handling layout based on orientation.
class _TutorialStepView extends StatelessWidget {
  const _TutorialStepView();

  @override
  Widget build(BuildContext context) {
    // Watch the GameProvider, which in this context is actually a TutorialProvider instance.
    final provider = context.watch<GameProvider>();

    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    // The game board widget, wrapped in padding and aspect ratio to keep it square.
    const gameBoard = Padding(
      padding: EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: GameBoard(),
      ),
    );

    // The description area uses information from the TutorialProvider.
    // We cast it back to TutorialProvider to access tutorial-specific properties.
    final tutorialProvider = provider as TutorialProvider;
    final descriptionArea = _DescriptionArea(
      title: tutorialProvider.title,
      description: tutorialProvider.description,
    );

    // Provide a scrollable vertical layout for portrait and a side-by-side layout for landscape.
    if (isPortrait) {
      return SingleChildScrollView(
        child: Column(
          children: [
            gameBoard,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: descriptionArea,
            ),
          ],
        ),
      );
    } else {
      return Row(
        children: [
          const Expanded(flex: 5, child: gameBoard),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: descriptionArea,
            ),
          ),
        ],
      );
    }
  }
}

/// A private widget that displays the title, description, and control buttons
/// for a tutorial step.
class _DescriptionArea extends StatelessWidget {
  /// The title of the tutorial step.
  final String title;
  /// The detailed instruction or explanation for the step.
  final String description;

  const _DescriptionArea({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Use 'read' because we only need to call methods on the provider here, not listen for changes.
    final tutorialProvider = context.read<GameProvider>() as TutorialProvider;
    final moveToShow = tutorialProvider.moveToShow;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
        // If the step has an associated animation (move to show), display Reset and Play buttons.
        if (moveToShow != null) ...[
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button to reset the step to its initial state.
              CupertinoButton(
                child: const Icon(CupertinoIcons.backward_end_alt_fill),
                onPressed: () => tutorialProvider.reset(),
              ),
              const SizedBox(width: 16),
              // Button to play the animated move demonstration.
              CupertinoButton.filled(
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.play_arrow_solid),
                    const SizedBox(width: 8),
                    Text(l10n.tutorialPlay),
                  ],
                ),
                onPressed: () => tutorialProvider.playAnimation(),
              ),
            ],
          )
        ]
      ],
    );
  }
}