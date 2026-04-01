// lib/providers/rank_provider.dart

import 'package:checkers_game/data/repositories/progress_repository.dart';
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/models/rank.dart';
import 'package:flutter/cupertino.dart';

/// Manages player progression, ranks, and unlocked AI levels.
/// 
/// This provider tracks which AI difficulty levels have been defeated 
/// across different game modes and handles rank promotion logic.
class RankProvider extends ChangeNotifier {
  final ProgressRepository _repository = ProgressRepository();
  
  /// A map where the key is the game mode name and the value is the highest unlocked AI level.
  Map<String, int> _unlockedLevels = {};
  
  /// The list of all possible ranks a player can achieve.
  final List<Rank> _allRanks = allRanks;
  
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  List<Rank> get allRanksList => _allRanks;

  RankProvider();

  /// Initializes the provider by loading progress from local storage.
  Future<void> init() async {
    await _loadUnlockedLevels();
    _isLoading = false;
  }

  /// Loads the map of unlocked levels from the repository.
  Future<void> _loadUnlockedLevels() async {
    // Calling the repository to fetch persisted level data.
    _unlockedLevels = await _repository.loadUnlockedLevels();
    notifyListeners();
  }

  /// Returns the highest unlocked AI level for a specific game mode.
  /// Defaults to level 1 if no progress is found.
  int getUnlockedLevelForMode(GameMode mode) {
    return _unlockedLevels[mode.name] ?? 1;
  }

  /// Handles logic when a player defeats the AI.
  /// 
  /// If the [completedAiLevel] matches the current highest unlocked level, 
  /// the next level is unlocked and the corresponding [Rank] is returned.
  Future<Rank?> onLevelCompleted(GameMode mode, int completedAiLevel) async {
    final currentUnlockedLevel = getUnlockedLevelForMode(mode);

    if (completedAiLevel == currentUnlockedLevel) {
      final int nextLevelToUnlock = completedAiLevel + 1;
      
      // Check if there is a higher level/rank available to unlock.
      if (nextLevelToUnlock <= _allRanks.length) {
        await _repository.saveUnlockedLevel(mode, nextLevelToUnlock);
        await _loadUnlockedLevels();
        
        // Return the newly achieved rank.
        return _allRanks[nextLevelToUnlock - 1];
      }
    }
    return null;
  }

  /// Resets all progress across all game modes to level 1.
  Future<void> resetAllRanks() async {
    for (final mode in GameMode.values) {
      await _repository.saveUnlockedLevel(mode, 1);
    }
    await _loadUnlockedLevels();
  }
}
