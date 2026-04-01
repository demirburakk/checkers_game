import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/models/rank.dart';
import 'package:checkers_game/domain/models/draw_reason.dart'; 
import 'package:checkers_game/domain/rules/game_rules.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/screens/settings_screen.dart';
import 'package:checkers_game/presentation/utils/player_type.dart';
import 'package:checkers_game/presentation/widgets/game_board.dart';
import 'package:checkers_game/providers/game_provider.dart';
import 'package:checkers_game/providers/rank_provider.dart';
import 'package:checkers_game/providers/theme_provider.dart';
import 'package:checkers_game/utils/game_saver.dart';
import 'package:checkers_game/utils/sound_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// The main screen where the checkers game is played.
/// 
/// It manages the game lifecycle, interacts with the [GameProvider] to handle moves,
/// and displays the board, player information, and game controls.
class GameScreen extends StatefulWidget {
  /// The selected ruleset for the game.
  final GameMode gameMode;
  /// Whether to resume a previously saved game.
  final bool loadFromSave;
  /// Whether the opponent is AI or a local Human.
  final PlayerType opponentType;
  /// The difficulty level of the AI opponent.
  final int aiLevel;

  const GameScreen({
    super.key,
    required this.gameMode,
    required this.opponentType,
    this.loadFromSave = false,
    this.aiLevel = 1,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameProvider _gameProvider;

  @override
  void initState() {
    super.initState();
    // Retrieve the GameProvider and start listening to game state changes.
    _gameProvider = Provider.of<GameProvider>(context, listen: false);
    _gameProvider.addListener(_gameListener);
    
    // Initialize the game state after the widget is built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gameProvider.initializeGame(
        gameMode: widget.gameMode,
        loadFromSave: widget.loadFromSave,
        opponentType: widget.opponentType,
        aiLevel: widget.aiLevel,
      );
    });
  }

  @override
  void dispose() {
    // Clean up listeners and reset provider state when leaving the game screen.
    _gameProvider.removeListener(_gameListener);
    _gameProvider.isDialogShowing = false;
    super.dispose();
  }

  /// Listens to provider changes and triggers game-over handling if needed.
  void _gameListener() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if the game has ended and if a dialog is not already being shown.
      if (mounted && _gameProvider.isGameOver && !_gameProvider.isDialogShowing) {
        _gameProvider.isDialogShowing = true;
        _handleGameOver();
      }
    });
  }

  /// Handles the hardware or software back button press.
  /// 
  /// Prompts the user to save the game or discard progress before exiting.
  Future<void> _handlePop() async {
    final l10n = AppLocalizations.of(context)!;
    // If the game is already over or no moves have been made, exit immediately.
    if (_gameProvider.isGameOver || !_gameProvider.canUndo() || !mounted) {
      if (mounted) Navigator.of(context).pop();
      return;
    }

    // Show a confirmation dialog with options to save or discard.
    final result = await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(l10n.gameScreenConfirmExitTitle),
        message: Text(l10n.gameScreenConfirmExitBody),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(l10n.gameScreenSaveAndExit),
            onPressed: () => Navigator.pop(context, 'save'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            child: Text(l10n.gameScreenExitWithoutSaving),
            onPressed: () => Navigator.pop(context, 'discard'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          child: Text(l10n.dialogCancel),
          onPressed: () => Navigator.pop(context, 'cancel'),
        ),
      ),
    );

    if (!mounted) return;

    // Execute the action chosen by the user.
    switch (result) {
      case 'save':
        await _gameProvider.saveCurrentGame();
        if (mounted) Navigator.of(context).pop();
        break;
      case 'discard':
        if (mounted) Navigator.of(context).pop();
        break;
      case 'cancel':
      default:
        break;
    }
  }

  /// Determines the winner or draw reason and shows the game over dialog.
  Future<void> _handleGameOver() async {
    final l10n = AppLocalizations.of(context)!;
    final game = _gameProvider;
    final rankProvider = context.read<RankProvider>();
    final soundManager = context.read<SoundManager>();
    Rank? newRank;
    String title;
    String message;

    // Priority: Handle Draw cases first.
    if (game.isDraw) {
      soundManager.playDrawSound();
      title = l10n.gameOverDrawTitle;
      // Resolve the localized draw reason.
      message = game.drawReason?.aklama ?? "";
      // Remove saved game since it's finished.
      await GameSaver.deleteGame(game.gameState.gameMode, widget.opponentType);

      if (mounted) {
        await _showStyledGameOverDialog(
          title: title,
          message: message,
          isDraw: true,
          newRank: newRank,
        );
      }
      if (mounted) {
        game.isDialogShowing = false;
      }
      return; 
    }

    // Handle Win/Loss logic.
    final winner = game.gameState.rules.checkForWinner(game.gameState)!;
    await GameSaver.deleteGame(game.gameState.gameMode, widget.opponentType);
    final isAiGame = widget.opponentType == PlayerType.ai;
    final humanColor = game.gameState.whitePlayerType == PlayerType.human ? PieceColor.white : PieceColor.black;
    final winnerColor = winner == Player.white ? PieceColor.white : PieceColor.black;

    if (isAiGame && humanColor == winnerColor) {
      // Human won against AI.
      soundManager.playWinSound();
      title = l10n.gameOverWinTitle;
      message = l10n.gameOverWinBody;
      // Update rank and check if a new rank is unlocked.
      newRank = await rankProvider.onLevelCompleted(widget.gameMode, widget.aiLevel);
      if (newRank != null) {
        message = l10n.gameOverNewRankBody;
      }
    } else if (isAiGame && humanColor != winnerColor) {
      // AI won against human.
      soundManager.playLoseSound();
      title = l10n.gameOverLoseTitle;
      message = l10n.gameOverLoseBody;
    } else {
      // Local PvP game finished.
      soundManager.playWinSound();
      title = l10n.gameOverTitle;
      message = l10n.gameOverWinner(winner == Player.white ? l10n.playerWhite : l10n.playerBlack);
    }

    if (mounted) {
      await _showStyledGameOverDialog(title: title, message: message, newRank: newRank);
    }
    if (mounted) {
      game.isDialogShowing = false;
    }
  }

  /// Presents a stylized dialog announcing the game result.
  Future<void> _showStyledGameOverDialog({
    required String title,
    required String message,
    Rank? newRank,
    bool isDraw = false,
  }) async {
    // Brief delay to allow the final move animation to finish.
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _GameOverDialog(
        title: title,
        message: message,
        newRank: newRank,
        isDraw: isDraw, 
        onNewGame: () {
          if (mounted) Navigator.of(context).pop();
          if (newRank != null) {
            // Start next level if player ranked up.
            _gameProvider.resetGame(aiLevel: newRank.level);
          } else {
            _gameProvider.resetGame();
          }
        },
        onMainMenu: () {
          if (mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  /// Shows the pause menu containing game actions and settings.
  void _showPauseMenu() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _PauseMenu(gameProvider: _gameProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Re-build when loading state changes.
    final isLoading = context.select((GameProvider g) => g.isLoading);
    if (isLoading) {
      return const CupertinoPageScaffold(child: Center(child: CupertinoActivityIndicator()));
    }

    final isDarkMode = CupertinoTheme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF161618) : const Color(0xFFf0f0f0);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic _) {
        if (didPop) return;
        _handlePop();
      },
      child: CupertinoPageScaffold(
        backgroundColor: backgroundColor,
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return _GameLayout(
              constraints: constraints,
              onPause: _showPauseMenu,
            );
          }),
        ),
      ),
    );
  }
}

/// Adaptive layout widget that switches between portrait and landscape arrangements.
class _GameLayout extends StatelessWidget {
  final BoxConstraints constraints;
  final VoidCallback onPause;
  const _GameLayout({required this.constraints, required this.onPause});

  @override
  Widget build(BuildContext context) {
    final orientation = constraints.maxWidth > constraints.maxHeight ? Orientation.landscape : Orientation.portrait;
    
    // Determine player orientations based on whether the board is flipped.
    final opponentColor = context.select((GameProvider g) => g.isBoardFlipped ? PieceColor.white : PieceColor.black);
    final playerColor = context.select((GameProvider g) => g.isBoardFlipped ? PieceColor.black : PieceColor.white);
    
    final opponentPanel = _PlayerPanel(playerColor: opponentColor);
    final playerPanel = _PlayerPanel(playerColor: playerColor);
    final controls = _ActionControls(onPause: onPause);

    final boardArea = Expanded(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withAlpha(20),
                    blurRadius: 30,
                    spreadRadius: -8,
                    offset: const Offset(0, 15),
                  )
                ]
            ),
            child: const GameBoard(),
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          color: CupertinoTheme.of(context).barBackgroundColor.withAlpha((255 * 0.8).round()),
          child: orientation == Orientation.portrait
              ? Column(children: [opponentPanel, const _Divider(), boardArea, const _Divider(), playerPanel, const _Divider(), controls])
              : Row(children: [
            SizedBox(
              width: 280,
              child: Column(children: [opponentPanel, const Spacer(), controls, const Spacer(), playerPanel]),
            ),
            Container(width: 0.5, color: CupertinoColors.separator.resolveFrom(context)),
            boardArea,
          ]),
        ),
      ),
    );
  }
}

/// Displays information for a single player, including their avatar, name, turn status, and captured pieces.
class _PlayerPanel extends StatelessWidget {
  final PieceColor playerColor;
  const _PlayerPanel({required this.playerColor});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Select only relevant data to minimize rebuilds.
    final panelData = context.select((GameProvider g) {
      final state = g.gameState;
      return (
      playerType: playerColor == PieceColor.white ? state.whitePlayerType : state.blackPlayerType,
      capturedCount: state.rules.getCapturedPiecesCount(state.board, playerColor == PieceColor.white ? PieceColor.black : PieceColor.white),
      isCurrentTurn: state.currentPlayer == playerColor,
      isAiThinking: g.isAiThinking
      );
    });

    final themeProvider = context.watch<ThemeProvider>();
    final isHuman = panelData.playerType == PlayerType.human;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: panelData.isCurrentTurn ? CupertinoColors.systemGrey5.resolveFrom(context) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Player avatar based on piece theme.
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.systemGrey4.resolveFrom(context),
                  image: DecorationImage(image: themeProvider.getPieceImageProvider(
                      Piece(id: 'avatar', color: playerColor, type: PieceType.man),
                      themeProvider.selectedPieceTheme)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isHuman ? l10n.playerYou : l10n.playerComputer, style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
                  _TurnIndicator(isCurrentTurn: panelData.isCurrentTurn, isAiThinking: panelData.isAiThinking && panelData.isCurrentTurn),
                ],
              ),
            ],
          ),
          _CapturedPiecesBadge(capturedCount: panelData.capturedCount),
        ],
      ),
    );
  }
}

/// Action buttons for undo, flip board, hints, and pausing.
class _ActionControls extends StatelessWidget {
  final VoidCallback onPause;
  const _ActionControls({required this.onPause});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Undo last move.
          CupertinoButton(onPressed: game.canUndo() ? game.undoMove : null, child: const Icon(CupertinoIcons.arrow_turn_up_left)),
          // Toggle board orientation.
          CupertinoButton(onPressed: game.isAiThinking ? null : game.flipBoard, child: const Icon(CupertinoIcons.switch_camera)),
          // Get a move suggestion.
          CupertinoButton(onPressed: game.isAiThinking ? null : () {
            if (game.hintMove != null) {
              game.clearHint();
            } else {
              game.getHint();
            }
          }, child: const Icon(CupertinoIcons.lightbulb)),
          // Open pause menu.
          CupertinoButton(onPressed: onPause, child: const Icon(CupertinoIcons.pause)),
        ],
      ),
    );
  }
}

/// Indicates whose turn it is and if the AI is currently calculating a move.
class _TurnIndicator extends StatelessWidget {
  final bool isCurrentTurn;
  final bool isAiThinking;
  const _TurnIndicator({required this.isCurrentTurn, required this.isAiThinking});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (!isCurrentTurn) return const SizedBox(height: 18);
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        isAiThinking ? l10n.aiThinking : l10n.nextMove,
        style: TextStyle(color: isAiThinking ? CupertinoColors.systemOrange : CupertinoColors.systemGreen, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Small badge displaying the number of pieces this player has captured.
class _CapturedPiecesBadge extends StatelessWidget {
  final int capturedCount;
  const _CapturedPiecesBadge({required this.capturedCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5.resolveFrom(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(CupertinoIcons.xmark, size: 12, color: CupertinoColors.secondaryLabel),
          const SizedBox(width: 6),
          Text(
            capturedCount.toString(),
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

/// Visual horizontal separator.
class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(height: 0.5, color: CupertinoColors.separator.resolveFrom(context));
  }
}

/// Dialog displayed when the game concludes via win, loss, or draw.
class _GameOverDialog extends StatelessWidget {
  final String title;
  final String message;
  final Rank? newRank;
  final bool isDraw; 
  final VoidCallback onNewGame;
  final VoidCallback onMainMenu;

  const _GameOverDialog({
    required this.title,
    required this.message,
    this.newRank,
    this.isDraw = false, 
    required this.onNewGame,
    required this.onMainMenu,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoAlertDialog(
        title: Text(title),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              // Display a relevant icon for draws.
              if (isDraw)
                Icon(CupertinoIcons.hand_raised_fill, color: CupertinoColors.systemOrange.resolveFrom(context), size: 40),
              if (isDraw) const SizedBox(height: 12),
              Text(message, textAlign: TextAlign.center),
              // Show rank progression if the player earned a new rank (not applicable for draws).
              if (newRank != null && !isDraw) ...[
                const SizedBox(height: 20),
                Text(l10n.gameOverNewRankTitle, style: const TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.systemGreen)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CupertinoColors.systemGreen.withAlpha(40),
                  ),
                  child: Icon(newRank!.icon, size: 40, color: CupertinoColors.systemGreen),
                ),
                const SizedBox(height: 8),
                Text(newRank!.getLocalizedName(l10n), style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
              ],
            ]
        ),
        actions: [
          CupertinoDialogAction(onPressed: onMainMenu, child: Text(l10n.gameScreenReturnToMenu)),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onNewGame,
            child: Text(l10n.gameOverNewGame),
          ),
        ],
      );
  }
}

/// Modal overlay for pausing the game, allowing resumption, restarting, or exiting.
class _PauseMenu extends StatelessWidget {
  final GameProvider gameProvider;
  const _PauseMenu({required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: CupertinoColors.black.withAlpha(100),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor.withAlpha(240),
              borderRadius: BorderRadius.circular(20)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: 20.0), child: Text(l10n.gameScreenPaused, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            Container(height: 0.5, color: CupertinoColors.separator.resolveFrom(context)),
            _buildMenuActionRow(context: context, text: l10n.gameScreenResume, icon: CupertinoIcons.play_fill, onTap: () => Navigator.of(context).pop()),
            _buildMenuActionRow(context: context, text: l10n.gameScreenRestart, icon: CupertinoIcons.refresh_bold, onTap: () { Navigator.of(context).pop(); gameProvider.resetGame(); }),
            _buildMenuActionRow(context: context, text: l10n.settingsTitle, icon: CupertinoIcons.settings_solid, onTap: () { Navigator.of(context).pop(); Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const SettingsScreen())); }),
            Container(height: 0.5, color: CupertinoColors.separator.resolveFrom(context)),
            _buildMenuActionRow(context: context, text: l10n.gameScreenReturnToMenu, icon: CupertinoIcons.home, isDestructive: true, onTap: () { Navigator.of(context).pop(); Navigator.of(context).maybePop(); }),
          ]),
        ),
      ),
    );
  }
}

/// Helper to build a single row in the pause menu.
Widget _buildMenuActionRow({ required BuildContext context, required String text, required IconData icon, required VoidCallback onTap, bool isDestructive = false }) {
  final color = isDestructive ? CupertinoColors.destructiveRed : CupertinoTheme.of(context).primaryColor;
  return CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    onPressed: onTap,
    child: Row(children: [
      Icon(icon, color: color), const SizedBox(width: 16),
      Expanded(child: Text(text, style: TextStyle(color: CupertinoTheme.of(context).textTheme.textStyle.color))),
    ]),
  );
}