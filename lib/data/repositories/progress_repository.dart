// lib/data/repositories/progress_repository.dart

import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository for managing and persisting player progress.
/// 
/// This class handles saving and loading the highest unlocked difficulty level
/// for each game mode using shared preferences.
class ProgressRepository {
  /// Prefix used for the keys in SharedPreferences to avoid collisions.
  static const String _progressKeyPrefix = 'rank_progress';

  /// Saves the highest unlocked level for a specific game mode.
  /// 
  /// [mode] The game mode for which progress is being saved.
  /// [level] The highest level (difficulty) reached or unlocked.
  Future<void> saveUnlockedLevel(GameMode mode, int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${_progressKeyPrefix}_${mode.name}', level);
  }

  /// Loads the progress (highest unlocked levels) for all game modes.
  /// 
  /// Returns a [Map] where the key is the game mode's name and the value
  /// is the highest unlocked level for that mode.
  Future<Map<String, int>> loadUnlockedLevels() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, int> progressMap = {};

    for (final mode in GameMode.values) {
      final key = '${_progressKeyPrefix}_${mode.name}';
      if (prefs.containsKey(key)) {
        // If progress exists for this mode, retrieve it; otherwise, default to level 1.
        progressMap[mode.name] = prefs.getInt(key) ?? 1;
      }
    }
    return progressMap;
  }
}
