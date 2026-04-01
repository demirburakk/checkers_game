// lib/presentation/screens/main_menu_screen.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:checkers_game/app/app_settings.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/game_state.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/models/rank.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/screens/game_screen.dart';
import 'package:checkers_game/presentation/screens/settings_screen.dart';
import 'package:checkers_game/presentation/screens/store_screen.dart';
import 'package:checkers_game/presentation/tutorial/models/tutorial.dart';
import 'package:checkers_game/presentation/tutorial/screens/tutorial_screen.dart';
import 'package:checkers_game/presentation/tutorial/tutorials/export_tutorials.dart';
import 'package:checkers_game/presentation/utils/game_mode_helper.dart';
import 'package:checkers_game/presentation/utils/player_type.dart';
import 'package:checkers_game/presentation/utils/preferred_color.dart';
import 'package:checkers_game/providers/rank_provider.dart';
import 'package:checkers_game/providers/settings_provider.dart';
import 'package:checkers_game/providers/theme_provider.dart';
import 'package:checkers_game/utils/game_saver.dart';
import 'package:checkers_game/utils/sound_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// The main entry point of the game's user interface.
/// 
/// This screen allows players to select game modes, choose opponents (AI or Human),
/// access the store, view settings, and continue saved games.
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});
  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> with TickerProviderStateMixin {
  // --- State Variables ---
  
  /// The currently selected game mode (e.g., International, Turkish, English).
  GameMode _selectedMode = GameMode.international;
  
  /// The type of opponent selected (AI or Local Human).
  PlayerType _opponentType = PlayerType.ai;
  
  /// Tracks which game modes have saved games available.
  Map<String, bool> _savedGamesStatus = {};
  
  /// Stores a preview of the board state for each game mode.
  Map<GameMode, GameState?> _allPreviews = {};
  
  /// Indicates if the board previews are still being loaded.
  bool _arePreviewsLoading = true;
  
  /// Controller for the PageView that allows swiping between game modes.
  PageController? _pageController;
  
  /// Tracks the overall loading state of the screen.
  bool _isLoading = true;

  // --- App Settings ---
  
  /// Helper to manage application-wide settings like persistent storage.
  final AppSettings _appSettings = AppSettings();

  // --- Animation Controllers ---
  
  /// Controller for the initial entrance animations.
  late final AnimationController _introController;
  
  /// Animation for the board preview's scale and appearance.
  late final Animation<double> _boardAnimation;
  
  /// Animation for the control buttons' appearance.
  late final Animation<double> _controlsAnimation;

  /// Mapping of game modes to their respective tutorial generators.
  Map<GameMode, Tutorial Function(AppLocalizations)> get _tutorialGetters => {
    GameMode.turkish: turkishTutorial,
    GameMode.english: englishTutorial,
    GameMode.international: internationalTutorial,
    GameMode.spanish: spanishTutorial,
    GameMode.russian: russianTutorial,
    GameMode.antiCheckers: losingTutorial,
  };

  @override
  void initState() {
    super.initState();
    // Load the last used game mode and initialize previews.
    _loadInitialMode();

    // Setup entrance animations.
    _introController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _boardAnimation = CurvedAnimation(parent: _introController, curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack));
    _controlsAnimation = CurvedAnimation(parent: _introController, curve: const Interval(0.3, 1.0, curve: Curves.easeOut));
    _introController.forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  /// Loads the game mode that was last selected by the user.
  Future<void> _loadInitialMode() async {
    final lastMode = await _appSettings.getLastGameMode();
    if (mounted) {
      setState(() {
        _selectedMode = lastMode;
        _pageController = PageController(initialPage: _selectedMode.index);
      });
    }
    await _loadAllPreviews();
    if (mounted) {
      setState(() {
        _isLoading = false; // Initial loading is complete.
      });
    }
  }

  /// Fetches saved game states for all modes to display as board previews.
  Future<void> _loadAllPreviews() async {
    if (mounted) {
      setState(() {
        _arePreviewsLoading = true;
      });
    }

    final status = await GameSaver.getSavedGamesStatus();
    if (!mounted) return;
    setState(() {
      _savedGamesStatus = status.map((key, value) => MapEntry(key, true));
    });

    final previews = <GameMode, GameState?>{};
    for (final mode in GameMode.values) {
      final savedGameKey = GameSaver.generateKey(mode, _opponentType);
      GameState? loadedState;
      if (_savedGamesStatus[savedGameKey] ?? false) {
        loadedState = await GameSaver.loadGame(mode, _opponentType);
      }
      previews[mode] = loadedState;
    }

    if (mounted) {
      setState(() {
        _allPreviews = previews;
        _arePreviewsLoading = false;
      });
    }
  }

  /// Handles changes to the selected opponent type (AI vs Human).
  void _onOpponentTypeChanged(PlayerType? type) {
    if (type != null && type != _opponentType) {
      setState(() {
        _opponentType = type;
      });
      // Refresh previews as they depend on the opponent type.
      _loadAllPreviews();
    }
  }

  /// Synchronizes the selected mode state when the user swipes the PageView.
  void _onPageChanged(int page) {
    final newMode = GameMode.values[page];
    if (newMode != _selectedMode) {
      context.read<SoundManager>().playClickSound();
      setState(() {
        _selectedMode = newMode;
      });
      _appSettings.saveLastGameMode(newMode);
    }
  }

  /// Navigates to the Game Screen to start or resume a match.
  /// 
  /// [mode] determines the ruleset.
  /// [loadFromSave] specifies if it should resume a previous game.
  /// [aiLevel] specifies the difficulty when playing against the AI.
  void _startGame({required GameMode mode, bool loadFromSave = false, int? aiLevel}) {
    context.read<SoundManager>().playClickSound();
    HapticFeedback.mediumImpact();

    int levelToPlay = aiLevel ?? 1;
    if (loadFromSave && _allPreviews[mode] != null) {
      // Determine level based on progression if resuming.
      final rankProvider = context.read<RankProvider>();
      levelToPlay = rankProvider.getUnlockedLevelForMode(mode);
    }

    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => GameScreen(
        gameMode: mode,
        loadFromSave: loadFromSave,
        opponentType: _opponentType,
        aiLevel: levelToPlay,
      ),
    )).then((_) {
      // Refresh previews when returning from a game.
      _loadAllPreviews();
    });
  }

  /// Displays a dialog for selecting AI difficulty before starting a new game.
  void _showAiLevelDialog(GameMode mode) async {
    context.read<SoundManager>().playClickSound();
    HapticFeedback.lightImpact();

    final selectedLevel = await showCupertinoModalPopup<int>(
      context: context,
      builder: (context) => AiLevelSelectionDialog(gameMode: mode),
    );

    if (selectedLevel != null && mounted) {
      _startGame(mode: mode, aiLevel: selectedLevel);
    }
  }

  /// Permanently removes a saved game for a specific mode and opponent type.
  Future<void> _deleteSavedGame(GameMode mode) async {
    await GameSaver.deleteGame(mode, _opponentType);
    _loadAllPreviews();
  }

  /// Navigates to the tutorial screen for the currently selected game mode.
  void _showRulesDialog() {
    context.read<SoundManager>().playClickSound();
    final l10n = AppLocalizations.of(context)!;
    final tutorialGetter = _tutorialGetters[_selectedMode];
    if (tutorialGetter != null) {
      final tutorial = tutorialGetter(l10n);
      Navigator.push(context, CupertinoPageRoute(builder: (context) => TutorialScreen(tutorial: tutorial)));
    }
  }

  /// Shows options to continue, start new, or delete a saved game.
  void _showGameActionsDialog(GameMode mode) {
    final l10n = AppLocalizations.of(context)!;
    context.read<SoundManager>().playClickSound();
    HapticFeedback.lightImpact();

    final newGameButtonText = _opponentType == PlayerType.ai ? l10n.mainMenuPlayButtonAI : l10n.mainMenuPlayButtonHuman;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return _GameActionsDialog(
          l10n: l10n,
          gameModeName: GameModeHelper.getName(mode, l10n),
          newGameButtonText: newGameButtonText,
          onContinue: () {
            Navigator.pop(context);
            _startGame(mode: mode, loadFromSave: true);
          },
          onNewGame: () {
            Navigator.pop(context);
            _opponentType == PlayerType.ai ? _showAiLevelDialog(mode) : _startGame(mode: mode);
          },
          onDelete: () {
            Navigator.pop(context);
            HapticFeedback.lightImpact();
            _deleteSavedGame(mode);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        bottom: false,
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : LayoutBuilder(
          builder: (context, constraints) {
            // Adaptive layout based on device orientation.
            final isPortrait = constraints.maxHeight > constraints.maxWidth;
            return AnimatedBuilder(
              animation: _introController,
              builder: (context, _) {
                return isPortrait
                    ? _buildPortraitLayout(context, settingsProvider, l10n)
                    : _buildLandscapeLayout(context, settingsProvider, l10n);
              },
            );
          },
        ),
      ),
    );
  }

  /// Builds the vertical layout optimized for portrait mode.
  Widget _buildPortraitLayout(BuildContext context, SettingsProvider settingsProvider, AppLocalizations l10n) {
    return Column(
      children: [
        _TopBar(onRulesTap: _showRulesDialog, l10n: l10n),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: GameMode.values.length,
            itemBuilder: (context, index) {
              final mode = GameMode.values[index];
              final previewState = _allPreviews[mode];
              final savedGameKey = GameSaver.generateKey(mode, _opponentType);
              final hasSavedGame = _savedGamesStatus[savedGameKey] ?? false;

              // Determine if the preview board should be flipped (black at bottom).
              bool isBoardFlippedForPage = false;
              if (previewState != null) {
                isBoardFlippedForPage = previewState.whitePlayerType == PlayerType.ai && previewState.blackPlayerType == PlayerType.human;
              } else if (_opponentType == PlayerType.ai && settingsProvider.preferredColor == PreferredColor.black) {
                isBoardFlippedForPage = true;
              }

              return ScaleTransition(
                scale: _boardAnimation,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: _GameBoardPreview(
                    mode: mode,
                    savedGameState: previewState,
                    isBoardFlipped: isBoardFlippedForPage,
                    isLoading: _arePreviewsLoading,
                    onTap: () {
                      if (hasSavedGame) {
                        _showGameActionsDialog(mode);
                      } else {
                        _opponentType == PlayerType.ai ? _showAiLevelDialog(mode) : _startGame(mode: mode);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
        FadeTransition(
          opacity: _controlsAnimation,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(_controlsAnimation),
            child: Column(
              children: [
                const SizedBox(height: 8),
                _PageIndicator(
                  count: GameMode.values.length,
                  currentIndex: _selectedMode.index,
                ),
                const SizedBox(height: 16),
                _GameSetupControls(
                  selectedMode: _selectedMode,
                  opponentType: _opponentType,
                  onOpponentTypeChange: _onOpponentTypeChanged,
                  l10n: l10n,
                ),
                const SizedBox(height: 16),
                _ThemeStoreButton(l10n: l10n),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the horizontal layout optimized for landscape mode.
  Widget _buildLandscapeLayout(BuildContext context, SettingsProvider settingsProvider, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: GameMode.values.length,
            itemBuilder: (context, index) {
              final mode = GameMode.values[index];
              final previewState = _allPreviews[mode];
              final savedGameKey = GameSaver.generateKey(mode, _opponentType);
              final hasSavedGame = _savedGamesStatus[savedGameKey] ?? false;

              bool isBoardFlippedForPage = false;
              if (previewState != null) {
                isBoardFlippedForPage = previewState.whitePlayerType == PlayerType.ai && previewState.blackPlayerType == PlayerType.human;
              } else if (_opponentType == PlayerType.ai && settingsProvider.preferredColor == PreferredColor.black) {
                isBoardFlippedForPage = true;
              }

              return ScaleTransition(
                scale: _boardAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: _GameBoardPreview(
                    mode: mode,
                    savedGameState: previewState,
                    isBoardFlipped: isBoardFlippedForPage,
                    isLoading: _arePreviewsLoading,
                    onTap: () {
                      if (hasSavedGame) {
                        _showGameActionsDialog(mode);
                      } else {
                        _opponentType == PlayerType.ai ? _showAiLevelDialog(mode) : _startGame(mode: mode);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 4,
          child: FadeTransition(
            opacity: _controlsAnimation,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0.5, 0), end: Offset.zero).animate(_controlsAnimation),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    _TopBar(onRulesTap: _showRulesDialog, isLandscape: true, l10n: l10n),
                    const SizedBox(height: 24),
                    _PageIndicator(
                      count: GameMode.values.length,
                      currentIndex: _selectedMode.index,
                    ),
                    const SizedBox(height: 16),
                    _GameSetupControls(
                      selectedMode: _selectedMode,
                      opponentType: _opponentType,
                      onOpponentTypeChange: _onOpponentTypeChanged,
                      l10n: l10n,
                    ),
                    const Spacer(),
                    _ThemeStoreButton(l10n: l10n),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// --- Sub-Widgets for MainMenuScreen ---

/// A dialog presented when a user attempts to start a game mode that already has a saved game.
class _GameActionsDialog extends StatelessWidget {
  final AppLocalizations l10n;
  final String gameModeName;
  final String newGameButtonText;
  final VoidCallback onContinue;
  final VoidCallback onNewGame;
  final VoidCallback onDelete;

  const _GameActionsDialog({
    required this.l10n,
    required this.gameModeName,
    required this.newGameButtonText,
    required this.onContinue,
    required this.onNewGame,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = CupertinoTheme.of(context).brightness == Brightness.dark;

    return Container(
      color: CupertinoColors.black.withAlpha((255 * 0.4).round()),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: isDarkMode
                ? CupertinoColors.darkBackgroundGray
                : CupertinoColors.extraLightBackgroundGray,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.black.withAlpha((255 * 0.2).round()),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 4.0, left: 16, right: 16),
                child: Text(
                  gameModeName,
                  textAlign: TextAlign.center,
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 12.0),
                child: Text(
                  l10n.savedGameDialogTitle,
                  textAlign: TextAlign.center,
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoButton.filled(
                      onPressed: onContinue,
                      child: Text(l10n.mainMenuContinue, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 12),
                    CupertinoButton(
                      onPressed: onNewGame,
                      child: Text(newGameButtonText),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                onPressed: onDelete,
                child: Text(l10n.deleteAction, style: const TextStyle(color: CupertinoColors.destructiveRed)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(height: 0.5, color: CupertinoColors.separator.resolveFrom(context)),
              ),
              CupertinoButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.close, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

/// A row of dots indicating the current page in the game mode PageView.
class _PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  const _PageIndicator({required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool isSelected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isSelected ? 10 : 8,
          height: isSelected ? 10 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? CupertinoTheme.of(context).primaryColor
                : CupertinoColors.secondarySystemFill.resolveFrom(context),
          ),
        );
      }),
    );
  }
}

/// A dialog for selecting the AI difficulty level.
/// 
/// Shows which levels are unlocked based on player rank.
class AiLevelSelectionDialog extends StatelessWidget {
  final GameMode gameMode;

  const AiLevelSelectionDialog({super.key, required this.gameMode});

  void _onLevelSelected(BuildContext context, int level) {
    context.read<SoundManager>().playStartSound();
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop(level);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rankProvider = context.watch<RankProvider>();
    final unlockedLevel = rankProvider.getUnlockedLevelForMode(gameMode);
    final allRanks = rankProvider.allRanksList;
    final isDarkMode = CupertinoTheme.of(context).brightness == Brightness.dark;

    return Container(
      color: CupertinoColors.black.withAlpha((255 * 0.4).round()),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: isDarkMode
                ? CupertinoColors.darkBackgroundGray
                : CupertinoColors.extraLightBackgroundGray,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.black.withAlpha((255 * 0.2).round()),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
                child: Text(
                  GameModeHelper.getName(gameMode, l10n),
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(height: 0.5, color: CupertinoColors.separator.resolveFrom(context)),
              ),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.all(12),
                  child: rankProvider.isLoading
                      ? const Center(child: CupertinoActivityIndicator())
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: allRanks.length,
                    itemBuilder: (context, index) {
                      final rank = allRanks[index];
                      final isLocked = rank.level > unlockedLevel;
                      final isCompleted = rank.level < unlockedLevel;

                      return _LevelTile(
                        rank: rank,
                        isLocked: isLocked,
                        isCompleted: isCompleted,
                        onTap: isLocked ? null : () => _onLevelSelected(context, rank.level),
                        l10n: l10n,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(height: 0.5, color: CupertinoColors.separator.resolveFrom(context)),
              ),
              CupertinoButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.close, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single row representing an AI level in the selection dialog.
class _LevelTile extends StatelessWidget {
  final Rank rank;
  final bool isLocked;
  final bool isCompleted;
  final VoidCallback? onTap;
  final AppLocalizations l10n;

  const _LevelTile({required this.rank, required this.isLocked, required this.isCompleted, this.onTap, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final tileColor = CupertinoColors.secondarySystemGroupedBackground.resolveFrom(context);

    final localizedRankName = rank.getLocalizedName(l10n);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        key: ValueKey(isLocked),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isLocked
                ? CupertinoColors.transparent
                : (isCompleted
                ? CupertinoColors.systemGreen
                : theme.primaryColor),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            _RankIcon(icon: rank.icon, isLocked: isLocked),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.levelNumber(rank.level),
                      style: theme.textTheme.textStyle.copyWith(
                          fontSize: 13,
                          color: theme.textTheme.textStyle.color
                              ?.withAlpha((255 * (isLocked ? 0.4 : 0.7)).round()))),
                  Text(
                    localizedRankName,
                    style: theme.textTheme.navTitleTextStyle.copyWith(
                        fontSize: 17,
                        color: theme.textTheme.navTitleTextStyle.color
                            ?.withAlpha((255 * (isLocked ? 0.5 : 1.0)).round())),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _StatusIcon(isLocked: isLocked, isCompleted: isCompleted),
          ],
        ),
      ),
    );
  }
}

/// Visual representation of the rank icon, showing a lock if it's not yet unlocked.
class _RankIcon extends StatelessWidget {
  final IconData icon;
  final bool isLocked;
  const _RankIcon({required this.icon, required this.isLocked});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isLocked
        ? CupertinoColors.secondaryLabel.resolveFrom(context)
        : CupertinoTheme.of(context).textTheme.textStyle.color!;

    final Widget actualIconWidget = Icon(icon, size: 30, color: iconColor);

    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        key: ValueKey(isLocked),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isLocked
                ? CupertinoColors.systemGrey5.resolveFrom(context)
                : CupertinoColors.systemGrey4.resolveFrom(context)),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: ScaleTransition(scale: animation, child: child)),
          child: isLocked ? Icon(CupertinoIcons.lock_fill, key: const ValueKey('lock'), size: 28, color: iconColor) : actualIconWidget,
        ));
  }
}

/// Indicates the status of a level (Locked, Completed, or Playable).
class _StatusIcon extends StatelessWidget {
  final bool isLocked;
  final bool isCompleted;
  const _StatusIcon({required this.isLocked, required this.isCompleted});
  @override
  Widget build(BuildContext context) {
    final IconData iconData;
    final Color iconColor;
    if (isLocked) {
      iconData = CupertinoIcons.lock_fill;
      iconColor = CupertinoColors.secondaryLabel.resolveFrom(context);
    } else if (isCompleted) {
      iconData = CupertinoIcons.checkmark_seal_fill;
      iconColor = CupertinoColors.systemGreen;
    } else {
      iconData = CupertinoIcons.play_arrow_solid;
      iconColor = CupertinoTheme.of(context).primaryColor;
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
      child: Icon(iconData, key: ValueKey(iconData), color: iconColor),
    );
  }
}

/// A interactive preview of a checkers board for the main menu.
class _GameBoardPreview extends StatelessWidget {
  final GameMode mode;
  final VoidCallback? onTap;
  final GameState? savedGameState;
  final bool isBoardFlipped;
  final bool isLoading;
  const _GameBoardPreview({required this.mode, this.onTap, this.savedGameState, required this.isBoardFlipped, required this.isLoading});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _StaticGameBoard(
          key: ValueKey('${mode.name}_${savedGameState?.boardHash ?? 'initial'}_$isBoardFlipped'),
          mode: mode,
          initialGameState: savedGameState,
          isBoardFlipped: isBoardFlipped,
          isLoading: isLoading,
        ),
      ),
    );
  }
}

/// Renders a non-interactive checkers board with pieces.
class _StaticGameBoard extends StatelessWidget {
  final GameMode mode;
  final GameState? initialGameState;
  final bool isBoardFlipped;
  final bool isLoading;

  const _StaticGameBoard({super.key, required this.mode, this.initialGameState, required this.isBoardFlipped, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final rules = initialGameState?.rules ?? GameModeHelper.getRules(mode);
    final board = initialGameState?.board ?? rules.initializeBoard();
    final boardSize = rules.boardSize;
    final themeProvider = context.watch<ThemeProvider>();

    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: CupertinoColors.black.withAlpha((255 * 0.2).round()),
                  blurRadius: 25,
                  spreadRadius: -5,
                  offset: const Offset(0, 10)
              )
            ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background board image.
              Positioned.fill(
                child: Image.asset(
                  themeProvider.getBoardAssetPath(themeProvider.selectedBoardTheme, boardSize),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: CupertinoColors.systemBrown),
                ),
              ),
              // Layer containing the pieces.
              _BoardPiecesPreview(board: board, boardSize: boardSize, isBoardFlipped: isBoardFlipped),
              // Loading overlay.
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    color: CupertinoColors.black.withAlpha((255 * 0.2).round()),
                    child: const Center(child: CupertinoActivityIndicator(color: CupertinoColors.white)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Renders the pieces on top of the preview board using a GridView.
class _BoardPiecesPreview extends StatelessWidget {
  final List<List<Piece?>> board;
  final int boardSize;
  final bool isBoardFlipped;

  const _BoardPiecesPreview({required this.board, required this.boardSize, required this.isBoardFlipped});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: boardSize),
      itemCount: boardSize * boardSize,
      itemBuilder: (context, index) {
        final visualRow = index ~/ boardSize;
        final visualCol = index % boardSize;
        // Flip the logical coordinates if the board is flipped visually.
        final logicalRow = isBoardFlipped ? boardSize - 1 - visualRow : visualRow;
        final logicalCol = isBoardFlipped ? boardSize - 1 - visualCol : visualCol;
        final piece = board[logicalRow][logicalCol];
        return piece == null
            ? const SizedBox.shrink()
            : Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image(
            image: themeProvider.getPieceImageProvider(piece, themeProvider.selectedPieceTheme),
          ),
        );
      },
    );
  }
}

/// The header of the main menu, containing the app title and navigation buttons.
class _TopBar extends StatelessWidget {
  final VoidCallback onRulesTap;
  final bool isLandscape;
  final AppLocalizations l10n;
  const _TopBar({required this.onRulesTap, this.isLandscape = false, required this.l10n});
  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final title = Text(
      l10n.appName,
      textAlign: TextAlign.center,
      style: theme.textTheme.navTitleTextStyle.copyWith(
        fontSize: isLandscape ? 32 : 28,
        fontWeight: FontWeight.w700,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: isLandscape
          ? Column(children: [
              title,
              const SizedBox(height: 16),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _MenuIconButton(
                      icon: CupertinoIcons.settings,
                      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => const SettingsScreen())),
                    ),
                    const SizedBox(width: 16),
                    _MenuIconButton(icon: CupertinoIcons.question_circle, onTap: onRulesTap),
                  ])
            ])
          : Row(
              children: [
                _MenuIconButton(
                    icon: CupertinoIcons.settings,
                    onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => const SettingsScreen()))),
                Expanded(child: title),
                _MenuIconButton(icon: CupertinoIcons.question_circle, onTap: onRulesTap),
              ],
            ),
    );
  }
}

/// Controls for selecting the opponent type and displaying the current rank for the mode.
class _GameSetupControls extends StatelessWidget {
  final GameMode selectedMode;
  final PlayerType opponentType;
  final Function(PlayerType?) onOpponentTypeChange;
  final AppLocalizations l10n;
  const _GameSetupControls({required this.selectedMode, required this.opponentType, required this.onOpponentTypeChange, required this.l10n});
  @override
  Widget build(BuildContext context) {
    // Access RankProvider to show player progression.
    final rankProvider = context.watch<RankProvider>();
    final unlockedLevel = rankProvider.getUnlockedLevelForMode(selectedMode);
    final rank = rankProvider.allRanksList.firstWhere(
      (r) => r.level == unlockedLevel,
      orElse: () => rankProvider.allRanksList.first, // Fallback for safety.
    );
    final theme = CupertinoTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: ScaleTransition(scale: animation, child: child)),
            // Group mode name and rank indicator.
            child: Column(
              key: ValueKey(selectedMode),
              children: [
                Text(
                  GameModeHelper.getName(selectedMode, l10n),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.navTitleTextStyle.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                // Player Rank Indicator.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(rank.icon, size: 16, color: theme.primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      rank.getLocalizedName(l10n),
                      style: theme.textTheme.textStyle.copyWith(
                        fontSize: 16,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Toggle between playing against AI or another human locally.
          CupertinoSlidingSegmentedControl<PlayerType>(
            children: {
              PlayerType.ai: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(l10n.mainMenuOpponentAI)),
              PlayerType.human: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(l10n.mainMenuOpponentHuman)),
            },
            onValueChanged: onOpponentTypeChange,
            groupValue: opponentType,
          ),
        ],
      ),
    );
  }
}

/// A standard circular button used in the top bar.
class _MenuIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MenuIconButton({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final color = CupertinoTheme.of(context).textTheme.textStyle.color;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CupertinoColors.secondarySystemFill.resolveFrom(context),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }
}

/// A prominent button at the bottom that leads to the Theme Store.
class _ThemeStoreButton extends StatelessWidget {
  final AppLocalizations l10n;
  const _ThemeStoreButton({required this.l10n});

  /// Displays an alert if there is no internet connection when trying to access the store.
  Future<void> _showNoConnectionDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    return showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(l10n.noInternetConnection),
        content: Text(l10n.noInternetConnectionMessage),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(l10n.dialogOK),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = CupertinoTheme.of(context).brightness == Brightness.dark;
    final List<Color> gradientColors;
    final Color textColor;

    // Theme-based styling for the button.
    if (isDarkMode) {
      gradientColors = [
        const Color(0xFF6D4C41),
        const Color(0xFF4E342E),
      ];
      textColor = CupertinoColors.white;
    } else {
      gradientColors = [
        const Color(0xFFA1887F),
        const Color(0xFF8D6E63),
      ];
      textColor = CupertinoColors.white;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          // Check for internet connectivity before proceeding to the store.
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (!context.mounted) return;
          if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
            context.read<SoundManager>().playClickSound();
            Navigator.push(context, CupertinoPageRoute(builder: (_) => const StoreScreen()));
          } else {
            _showNoConnectionDialog(context);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: gradientColors.last.withAlpha((255 * 0.4).round()),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.paintbrush_fill, color: textColor),
              const SizedBox(width: 12),
              Text(
                l10n.mainMenuExploreThemes,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
