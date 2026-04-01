import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial.dart';
import 'package:checkers_game/presentation/tutorial/widgets/tutorial_step_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// A screen that displays a sequence of tutorial steps using a [PageView].
/// It supports both portrait and landscape layouts and provides navigation
/// controls to move between steps.
class TutorialScreen extends StatefulWidget {
  /// The [Tutorial] model containing the title and list of steps to be displayed.
  final Tutorial tutorial;

  const TutorialScreen({super.key, required this.tutorial});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

/// The state for [TutorialScreen], managing the current page and navigation logic.
class _TutorialScreenState extends State<TutorialScreen> {
  /// Controller for the [PageView] that manages the tutorial steps.
  /// Used to programmatically jump between tutorial steps.
  final PageController _pageController = PageController();

  /// The zero-based index of the currently displayed tutorial step.
  int _currentPage = 0;

  @override
  void dispose() {
    // Ensure the PageController is disposed when the screen is removed from the tree.
    _pageController.dispose();
    super.dispose();
  }

  /// Callback function triggered when the user swipes or navigates to a new page.
  /// It triggers haptic feedback and updates the local state to reflect the new page index.
  void _onPageChanged(int page) {
    HapticFeedback.selectionClick();
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // Displays the localized tutorial title in the center of the navigation bar.
        middle: Text(l10n.tutorialTitle(widget.tutorial.title)),
      ),
      child: SafeArea(
        // Responsive design using LayoutBuilder to handle orientation changes dynamically.
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check if the current orientation is portrait based on available space.
            final isPortrait = constraints.maxHeight > constraints.maxWidth;

            // PageView widget containing the steps. Common to both layouts.
            final pageView = PageView.builder(
              controller: _pageController,
              itemCount: widget.tutorial.steps.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                // Each step is rendered using a TutorialStepWidget.
                // ValueKey(index) ensures that each page maintains its unique state
                // and is properly rebuilt when navigating.
                return TutorialStepWidget(
                  key: ValueKey(index),
                  step: widget.tutorial.steps[index],
                );
              },
            );

            // Navigation controls (Next/Previous buttons and page indicator).
            // This widget abstracts the navigation logic and button states.
            final navigationControls = _NavigationControls(
              currentPage: _currentPage,
              totalPages: widget.tutorial.steps.length,
              onNext: () {
                // Animate to the next page with a standard duration and curve.
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              onPrevious: () {
                // Animate to the previous page.
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            );

            // Choose the appropriate layout structure based on the current orientation.
            return isPortrait
                ? _buildPortraitLayout(pageView, navigationControls)
                : _buildLandscapeLayout(pageView, navigationControls);
          },
        ),
      ),
    );
  }

  /// Builds the vertical layout optimized for portrait orientation.
  /// The [pageView] takes up most of the space, with [navigationControls] at the bottom.
  Widget _buildPortraitLayout(Widget pageView, Widget navigationControls) {
    return Column(
      children: [
        Expanded(child: pageView),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: navigationControls,
        ),
      ],
    );
  }

  /// Builds the horizontal layout optimized for landscape orientation.
  /// The [pageView] (game board) is on the left, and [navigationControls] (controls) is on the right.
  Widget _buildLandscapeLayout(Widget pageView, Widget navigationControls) {
    return Row(
      children: [
        Expanded(
          flex: 5, // The board area takes up more horizontal space (5/7th of the width).
          child: pageView,
        ),
        Expanded(
          flex: 2, // The control area is narrower (2/7th of the width).
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: navigationControls,
          ),
        ),
      ],
    );
  }
}

/// A private widget that provides navigation controls for the tutorial steps.
/// It displays "Previous" and "Next" buttons along with a page counter.
class _NavigationControls extends StatelessWidget {
  /// The current active page index.
  final int currentPage;
  /// Total number of steps in the tutorial.
  final int totalPages;
  /// Callback for when the "Next" button is pressed.
  final VoidCallback onNext;
  /// Callback for when the "Previous" button is pressed.
  final VoidCallback onPrevious;

  const _NavigationControls({
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    // The controls are arranged horizontally in portrait and vertically in landscape
    // to make better use of the available screen space.
    if (isPortrait) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // "Previous" button - disabled on the first page.
          CupertinoButton(
            onPressed: currentPage > 0 ? onPrevious : null,
            child: Text(l10n.tutorialPrevious),
          ),
          // Centered page indicator showing "Current / Total".
          Expanded(
            child: Text(
              '${currentPage + 1} / $totalPages',
              textAlign: TextAlign.center,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: CupertinoColors.secondaryLabel),
            ),
          ),
          // "Next" button - disabled on the last page.
          CupertinoButton(
            onPressed: currentPage < totalPages - 1 ? onNext : null,
            child: Text(l10n.tutorialNext),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // "Previous" button (Up arrow in landscape).
          CupertinoButton(
            onPressed: currentPage > 0 ? onPrevious : null,
            child: const Icon(CupertinoIcons.chevron_up),
          ),
          const SizedBox(height: 16),
          // Vertical page indicator for landscape.
          Text('${currentPage + 1}\n—\n$totalPages',
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: CupertinoColors.secondaryLabel, height: 1.2),
          ),
          const SizedBox(height: 16),
          // "Next" button (Down arrow in landscape).
          CupertinoButton(
            onPressed: currentPage < totalPages - 1 ? onNext : null,
            child: const Icon(CupertinoIcons.chevron_down),
          ),
        ],
      );
    }
  }
}