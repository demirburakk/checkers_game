// lib/providers/settings_provider.dart

import 'package:checkers_game/presentation/utils/preferred_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages user preferences and application settings.
/// 
/// This provider handles persistence of settings like language, 
/// piece color preference, haptics, and sound effects using SharedPreferences.
class SettingsProvider with ChangeNotifier {
  Locale? _appLocale;
  PreferredColor _preferredColor = PreferredColor.random;
  bool _showCoordinates = false;
  bool _hapticsEnabled = true;
  bool _soundEffectsEnabled = true;
  bool _isLoading = true;

  Locale? get appLocale => _appLocale;
  PreferredColor get preferredColor => _preferredColor;
  bool get showCoordinates => _showCoordinates;
  bool get hapticsEnabled => _hapticsEnabled;
  bool get soundEffectsEnabled => _soundEffectsEnabled;
  bool get isLoading => _isLoading;

  /// Constructor accepts an [initialLocale] which is typically loaded 
  /// in main.dart before the app starts to prevent language flickering.
  SettingsProvider({Locale? initialLocale}) {
    _appLocale = initialLocale;
  }

  /// Initializes settings by loading them from local storage.
  Future<void> init() async {
    _isLoading = true;
    final prefs = await SharedPreferences.getInstance();

    // Note: Language reading logic is handled in main.dart for better UX.

    final colorString = prefs.getString('preferredColor') ?? PreferredColor.random.name;
    _preferredColor = PreferredColor.values.firstWhere(
      (e) => e.name == colorString, 
      orElse: () => PreferredColor.random
    );
    
    _showCoordinates = prefs.getBool('showCoordinates') ?? false;
    _hapticsEnabled = prefs.getBool('hapticsEnabled') ?? true;
    _soundEffectsEnabled = prefs.getBool('soundEffectsEnabled') ?? true;
    _isLoading = false;

    // Notify listeners so the UI can reflect the loaded settings.
    notifyListeners();
  }

  /// Updates the application locale and persists it.
  Future<void> setAppLocale(Locale? locale) async {
    if (_appLocale == locale) return;
    _appLocale = locale;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove('languageCode');
    } else {
      await prefs.setString('languageCode', locale.languageCode);
    }
  }

  /// Updates the user's preferred piece color and persists it.
  Future<void> setPreferredColor(PreferredColor color) async {
    if (_preferredColor == color) return;
    _preferredColor = color;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferredColor', color.name);
  }

  /// Toggles visibility of board coordinates and persists the setting.
  Future<void> setShowCoordinates(bool value) async {
    if (_showCoordinates == value) return;
    _showCoordinates = value;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showCoordinates', value);
  }

  /// Toggles haptic feedback (vibration) and persists the setting.
  Future<void> setHapticsEnabled(bool value) async {
    if (_hapticsEnabled == value) return;
    _hapticsEnabled = value;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hapticsEnabled', value);
  }

  /// Toggles sound effects and persists the setting.
  Future<void> setSoundEffectsEnabled(bool value) async {
    if (_soundEffectsEnabled == value) return;
    _soundEffectsEnabled = value;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEffectsEnabled', value);
  }
}

// Note: For full functionality, ensure that the language is read from 
// SharedPreferences in main.dart and passed to the SettingsProvider constructor.
// Example:
// final languageCode = prefs.getString('languageCode');
// final initialLocale = languageCode != null ? Locale(languageCode) : null;
// ... SettingsProvider(initialLocale: initialLocale) ...
