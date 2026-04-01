// lib/presentation/screens/loading_screen.dart

import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/screens/main_menu_screen.dart';
import 'package:checkers_game/providers/rank_provider.dart';
import 'package:checkers_game/providers/settings_provider.dart';
import 'package:checkers_game/providers/theme_provider.dart';
import 'package:checkers_game/utils/prewarming_service.dart';
import 'package:checkers_game/utils/sound_manager.dart';
import 'package:checkers_game/utils/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// Enum to represent the various stages of the application's initialization process.
/// 
/// This approach is safer than using raw strings for tracking the loading state.
enum LoadingStatus { initializing, settings, ui, ready }

/// A screen that displays a loading indicator while the application initializes its services and assets.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  /// The current state of the initialization process.
  /// 
  /// We store the enum state here and resolve the localized text during the build phase.
  LoadingStatus _status = LoadingStatus.initializing;

  @override
  void initState() {
    super.initState();
    // Start the initialization process after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeAndNavigate());
  }

  /// Handles the sequential initialization of all necessary app services.
  Future<void> _initializeAndNavigate() async {
    if (!mounted) return;

    // 1. Obtain references to the necessary providers.
    final settingsProvider = context.read<SettingsProvider>();
    final themeManager = context.read<ThemeManager>();
    final themeProvider = context.read<ThemeProvider>();
    context.read<SoundManager>(); // Ensures sound manager is ready.
    final rankProvider = context.read<RankProvider>();

    // 2. Wait for the asynchronous initialization of each provider.
    if (mounted) setState(() => _status = LoadingStatus.settings);
    await Future.wait([
      settingsProvider.init(),
      themeManager.init(),
      themeProvider.init(),
      rankProvider.init(),
    ]);

    // 3. Pre-warm shaders and other UI assets to ensure smooth performance.
    if (mounted) {
      setState(() => _status = LoadingStatus.ui);
      await Future.wait([
        PrewarmingService.prewarmShaders(context),
      ]);
    }

    if (!mounted) return;
    
    // Finalizing initialization.
    setState(() => _status = LoadingStatus.ready);
    // Brief delay for a smoother visual transition.
    await Future.delayed(const Duration(milliseconds: 300));

    // 4. Safely transition to the Main Menu screen once initialization is complete.
    if (mounted) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => const MainMenuScreen()),
      );
    }
  }

  /// Maps the current [LoadingStatus] to its corresponding localized string.
  /// 
  /// [l10n] provides access to localized strings.
  String _getLocalizedStatusText(AppLocalizations l10n) {
    switch (_status) {
      case LoadingStatus.initializing:
        return l10n.loadingStatusInitializing;
      case LoadingStatus.settings:
        return l10n.loadingStatusSettings;
      case LoadingStatus.ui:
        return l10n.loadingStatusUI;
      case LoadingStatus.ready:
        return l10n.loadingStatusReady;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Localization is performed on every build call to ensure it uses the most up-to-date locale.
    final localizedStatus = _getLocalizedStatusText(l10n);

    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Standard Cupertino loading indicator.
            const CupertinoActivityIndicator(radius: 20.0),
            const SizedBox(height: 24),
            // App name display.
            Text(l10n.appName, style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
            const SizedBox(height: 12),
            // Smoothly animate between different status messages.
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                localizedStatus, // Display the localized status text.
                key: ValueKey(localizedStatus), // Necessary for AnimatedSwitcher to identify changes.
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
