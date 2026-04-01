// lib/utils/theme_manager.dart

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported application-wide theme modes.
enum AppThemeMode {
  /// Respects the user's device system setting (Light or Dark).
  system,
  /// Forces the application into Light Mode.
  light,
  /// Forces the application into Dark Mode.
  dark,
}

/// Utility class for managing and persisting the user's preferred theme mode.
/// 
/// Notifies listeners whenever the theme changes so the UI can rebuild immediately.
class ThemeManager with ChangeNotifier {
  /// The current theme mode of the application. Defaults to [AppThemeMode.system].
  AppThemeMode _themeMode = AppThemeMode.system;
  AppThemeMode get themeMode => _themeMode;

  /// Default constructor for [ThemeManager].
  /// Note: [init] must be called separately to load saved preferences.
  ThemeManager();

  /// Asynchronously initializes the theme by loading the saved preference from local storage.
  /// 
  /// This should be called before the app starts to ensure the correct theme is applied.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode');
    
    if (themeModeString != null) {
      // Map the stored string back to an AppThemeMode enum value.
      _themeMode = AppThemeMode.values.firstWhere(
            (e) => e.toString() == 'AppThemeMode.$themeModeString',
        orElse: () => AppThemeMode.system,
      );
    }
    // No need to notify listeners during initial setup as the UI hasn't rendered yet.
  }

  /// Updates the application's theme mode and persists the choice to [SharedPreferences].
  /// 
  /// Triggers [notifyListeners] to update any widgets observing this theme state.
  Future<void> setThemeMode(AppThemeMode mode) async {
    // Avoid unnecessary updates if the mode hasn't changed.
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    
    // Persist the enum's simple name (e.g., "light", "dark", "system").
    await prefs.setString('themeMode', mode.toString().split('.').last);
    
    // Broadcast the change to the UI.
    notifyListeners();
  }

  /// Resolves the current [Brightness] based on the selected [AppThemeMode].
  /// 
  /// If [AppThemeMode.system] is selected, it returns the current platform brightness.
  Brightness get brightness {
    switch (_themeMode) {
      case AppThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
      case AppThemeMode.light:
        return Brightness.light;
      case AppThemeMode.dark:
        return Brightness.dark;
    }
  }
}
