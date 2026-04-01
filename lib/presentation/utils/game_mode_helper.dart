// FILE: lib/presentation/utils/game_mode_helper.dart
import 'package:checkers_game/domain/models/game_mode.dart';
import 'package:checkers_game/domain/rules/export_rules.dart';
import 'package:checkers_game/domain/rules/game_rules.dart';
import 'package:checkers_game/l10n/app_localizations.dart';

/// This class contains all static data and helper functions related to [GameMode].
/// It provides localized names, descriptions, and specific rules for each game mode.
class GameModeHelper {
  GameModeHelper._();

  /// Returns the localized name of the given [mode].
  static String getName(GameMode mode, AppLocalizations l10n) {
    switch (mode) {
      case GameMode.turkish:
        return l10n.gameModeTurkishName;
      case GameMode.english:
        return l10n.gameModeEnglishName;
      case GameMode.international:
        return l10n.gameModeInternationalName;
      case GameMode.russian:
        return l10n.gameModeRussianName;
      case GameMode.spanish:
        return l10n.gameModeSpanishName;
      case GameMode.antiCheckers:
        return l10n.gameModeAntiCheckersName;
    }
  }

  /// Returns the localized description of the given [mode].
  static String getDescription(GameMode mode, AppLocalizations l10n) {
    switch (mode) {
      case GameMode.turkish:
        return l10n.gameModeTurkishDescription;
      case GameMode.english:
        return l10n.gameModeEnglishDescription;
      case GameMode.international:
        return l10n.gameModeInternationalDescription;
      case GameMode.russian:
        return l10n.gameModeRussianDescription;
      case GameMode.spanish:
        return l10n.gameModeSpanishDescription;
      case GameMode.antiCheckers:
        return l10n.gameModeAntiCheckersDescription;
    }
  }

  /// Returns a list of [RuleItem]s that represent the detailed rules for the given [mode].
  /// These rules are used to display information to the user about how to play each mode.
  static List<RuleItem> getDetailedRules(GameMode mode, AppLocalizations l10n) {
    // Common rule items
    final manMovesForward = RuleItem(l10n.ruleTitleManMove, l10n.ruleDescManMoveForward);
    final manCapturesBackward = RuleItem(l10n.ruleTitleManCapture, l10n.ruleDescManCaptureBackward);
    final kingIsShort = RuleItem(l10n.ruleTitleKingMove, l10n.ruleDescKingShort);
    final kingIsFlying = RuleItem(l10n.ruleTitleKingMove, l10n.ruleDescKingFlying);
    final mandatoryCapture = RuleItem(l10n.ruleTitleMandatoryCapture, l10n.ruleDescMandatoryCapture);
    final maxCapture = RuleItem(l10n.ruleTitleMaxCapture, l10n.ruleDescMaxCapture);

    // Turkish specific rule items
    final turkishManMoves = RuleItem(l10n.ruleTitleTurkishManMove, l10n.ruleDescTurkishManMove);
    final turkishCapture = RuleItem(l10n.ruleTitleTurkishCapture, l10n.ruleDescTurkishCapture);

    switch(mode) {
      case GameMode.english:
        return [
          manMovesForward,
          RuleItem(l10n.ruleTitleManCapture, l10n.ruleDescManCaptureForward),
          kingIsShort,
          mandatoryCapture,
          RuleItem(l10n.ruleTitlePromotion, l10n.ruleDescPromotionStops),
        ];
      case GameMode.international:
        return [
          manMovesForward,
          manCapturesBackward,
          kingIsFlying,
          mandatoryCapture,
          maxCapture,
        ];
      case GameMode.turkish:
        return [
          turkishManMoves,
          turkishCapture,
          kingIsFlying,
          mandatoryCapture,
          maxCapture,
        ];
      case GameMode.russian:
        return [
          manMovesForward,
          manCapturesBackward,
          kingIsFlying,
          mandatoryCapture,
          RuleItem(l10n.ruleTitlePromotion, l10n.ruleDescPromotionContinues),
        ];
      case GameMode.spanish:
        return [
          manMovesForward,
          RuleItem(l10n.ruleTitleManCapture, l10n.ruleDescManCaptureForward),
          kingIsFlying,
          mandatoryCapture,
          maxCapture,
        ];
      case GameMode.antiCheckers:
        return [
          RuleItem(l10n.ruleTitleAntiCheckersAim, l10n.ruleDescAntiCheckersAim),
          manMovesForward,
          RuleItem(l10n.ruleTitleManCapture, l10n.ruleDescManCaptureForward),
          kingIsShort,
          mandatoryCapture,
        ];
    }
  }

  /// Returns the asset image path representing the given [mode].
  static String getImagePath(GameMode mode) {
    if (mode == GameMode.antiCheckers) {
      return 'assets/images/losing_checkers.png';
    }
    return 'assets/images/${mode.name}_checkers.png';
  }

  /// Returns the [GameRules] implementation corresponding to the given [mode].
  static GameRules getRules(GameMode mode) {
    switch (mode) {
      case GameMode.international: return InternationalRules();
      case GameMode.turkish: return TurkishRules();
      case GameMode.english: return EnglishRules();
      case GameMode.russian: return RussianRules();
      case GameMode.spanish: return SpanishRules();
      case GameMode.antiCheckers: return LosingRules();
    }
  }
}

/// A simple model to hold a rule's title and description for UI display.
class RuleItem {
  /// The title of the rule.
  final String title;
  /// A detailed description of the rule.
  final String description;

  RuleItem(this.title, this.description);
}