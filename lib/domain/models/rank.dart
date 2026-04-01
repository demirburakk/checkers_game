import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

/// Represents a player's rank or achievement level in the game.
@immutable
class Rank {
  /// The numeric level of the rank.
  final int level;
  
  /// The key used for looking up the localized name of the rank.
  final String nameKey;
  
  /// The icon representing this rank in the UI.
  final IconData icon;

  /// Creates a new [Rank] instance.
  const Rank({
    required this.level,
    required this.nameKey,
    required this.icon,
  });

  /// Retrieves the localized name of the rank using the provided [AppLocalizations].
  /// 
  /// This mapping connects [nameKey] strings to their translated counterparts.
  String getLocalizedName(AppLocalizations l10n) {
    switch (nameKey) {
      case 'rankNovice':
        return l10n.rankNovice;
      case 'rankApprentice':
        return l10n.rankApprentice;
      case 'rankJourneyman':
        return l10n.rankJourneyman;
      case 'rankMaster':
        return l10n.rankMaster;
      case 'rankExpert':
        return l10n.rankExpert;
      case 'rankVirtuoso':
        return l10n.rankVirtuoso;
      case 'rankGrandmaster':
        return l10n.rankGrandmaster;
      default:
        // Fallback to showing the key itself if no translation is found.
        return nameKey;
    }
  }
}

/// A comprehensive list of all possible ranks in the game.
/// These use translation keys rather than hardcoded strings to support localization.
const List<Rank> allRanks = [
  Rank(level: 1, nameKey: 'rankNovice', icon: CupertinoIcons.tortoise),
  Rank(level: 2, nameKey: 'rankApprentice', icon: CupertinoIcons.ant),
  Rank(level: 3, nameKey: 'rankJourneyman', icon: CupertinoIcons.hammer),
  Rank(level: 4, nameKey: 'rankMaster', icon: CupertinoIcons.eyeglasses),
  Rank(level: 5, nameKey: 'rankExpert', icon: CupertinoIcons.lightbulb),
  Rank(level: 6, nameKey: 'rankVirtuoso', icon: CupertinoIcons.star),
  Rank(level: 7, nameKey: 'rankGrandmaster', icon: CupertinoIcons.book),
];