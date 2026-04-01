import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service class for managing application-wide settings and persistence.
/// Currently handles the storage and retrieval of the last selected game mode.
class AppSettings {
  /// Key used to store the last game mode index in [SharedPreferences].
  static const String _lastGameModeKey = 'last_game_mode';

  /// Retrieves the last used [GameMode] from persistent storage.
  /// 
  /// Returns [GameMode.international] as a default if:
  /// - No game mode has been saved previously.
  /// - An error occurs during retrieval.
  Future<GameMode> getLastGameMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final gameModeIndex = prefs.getInt(_lastGameModeKey);
      if (gameModeIndex != null) {
        // Retrieve the GameMode using its index stored in SharedPreferences.
        return GameMode.values[gameModeIndex];
      }
    } catch (e) {
      // In case of an error, fall back to the default mode.
    }
    // Default to international checkers if no saved mode exists or an error occurs.
    return GameMode.international;
  }

  /// Saves the specified [GameMode] to persistent storage.
  /// 
  /// This allows the app to remember the user's last preference across sessions.
  Future<void> saveLastGameMode(GameMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Persist the GameMode by saving its index.
      await prefs.setInt(_lastGameModeKey, mode.index);
    } catch (e) {
      // Since saving the last game mode is not a critical operation,
      // any error during this process can be safely ignored.
    }
  }
}
