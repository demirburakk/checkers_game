import 'package:checkers_game/app/locale_config.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/screens/loading_screen.dart';
import 'package:checkers_game/providers/game_provider.dart';
import 'package:checkers_game/providers/rank_provider.dart';
import 'package:checkers_game/providers/settings_provider.dart';
import 'package:checkers_game/providers/theme_provider.dart';
import 'package:checkers_game/utils/sound_manager.dart';
import 'package:checkers_game/utils/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

/// The entry point of the application.
/// 
/// It initializes the Flutter framework, hides system UI for an immersive experience,
/// retrieves the saved language preference, and runs the [MyApp] widget.
Future<void> main() async {
  // Ensure that plugin services are initialized so that they can be used before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Set the system UI to immersive mode (hides status bar and navigation bar).
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Retrieve the saved language code from SharedPreferences to initialize the locale.
  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('languageCode');
  final initialLocale = languageCode != null ? Locale(languageCode) : null;

  // Launch the application.
  runApp(MyApp(initialLocale: initialLocale));
}

/// The root widget of the Checkers Game application.
/// 
/// It configures the global state using [MultiProvider] and sets up the [CupertinoApp].
class MyApp extends StatelessWidget {
  /// The initial locale of the application, potentially loaded from storage.
  final Locale? initialLocale;
  
  const MyApp({super.key, this.initialLocale});

  /// Resolves the current theme based on the application's theme settings and system brightness.
  /// 
  /// [themeManager] provides the user-selected theme mode.
  /// [platformBrightness] is the system's current brightness setting.
  CupertinoThemeData _resolveTheme(
      ThemeManager themeManager, Brightness platformBrightness) {
    const lightBaseTheme = CupertinoThemeData(brightness: Brightness.light);
    const darkBaseTheme = CupertinoThemeData(brightness: Brightness.dark);

    final selectedThemeMode = themeManager.themeMode;
    
    // Logic to decide between light and dark theme based on user preference or system setting.
    if (selectedThemeMode == AppThemeMode.light ||
        (selectedThemeMode == AppThemeMode.system &&
            platformBrightness == Brightness.light)) {
      return lightBaseTheme;
    }
    return darkBaseTheme;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Manages theme-related state.
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        // Manages application settings and localizations.
        ChangeNotifierProvider(
            create: (context) =>
                SettingsProvider(initialLocale: initialLocale)..init()),
        // Manages visual theme elements (board, pieces, etc.).
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Manages player rank and statistics.
        ChangeNotifierProvider(create: (_) => RankProvider()),
        // Provides sound management capabilities, depending on settings.
        ProxyProvider<SettingsProvider, SoundManager>(
          update: (context, settingsProvider, previousSoundManager) =>
              SoundManager(settingsProvider),
        ),
        // Manages the core game logic, depending on settings and sound manager.
        ChangeNotifierProxyProvider<SettingsProvider, GameProvider>(
          create: (context) => GameProvider(
            settingsProvider: context.read<SettingsProvider>(),
            soundManager: context.read<SoundManager>(),
          ),
          update: (context, settings, game) => game!..updateSettings(settings),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          final themeManager = context.watch<ThemeManager>();

          // Using CupertinoApp for an iOS-styled interface.
          return CupertinoApp(
            debugShowCheckedModeBanner: false,
            title: 'World of Checkers',
            theme: _resolveTheme(
                themeManager, MediaQuery.of(context).platformBrightness),
            locale: settingsProvider.appLocale,
            // Custom locale resolution strategy.
            localeResolutionCallback: LocaleConfig.localeResolutionCallback,
            // Localization support delegates.
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            // List of supported locales.
            supportedLocales: LocaleConfig.supportedLocales,
            // The initial screen of the app.
            home: const LoadingScreen(),
          );
        },
      ),
    );
  }
}
