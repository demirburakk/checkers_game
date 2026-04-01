// lib/presentation/screens/settings_screen.dart

import 'package:checkers_game/presentation/utils/preferred_color.dart';
import 'package:checkers_game/providers/rank_provider.dart';
import 'package:checkers_game/providers/settings_provider.dart';
import 'package:checkers_game/utils/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// A screen that provides various configuration options for the application.
/// 
/// Users can adjust language settings, visual themes, game experience preferences,
/// and manage their game progress.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  /// Stores the version and build number of the application.
  String _versionInfo = '';

  @override
  void initState() {
    super.initState();
    // Load the application version information on initialization.
    _loadVersionInfo();
  }

  /// Retrieves the application version information using the PackageInfo plugin.
  Future<void> _loadVersionInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _versionInfo = 'v${packageInfo.version} (${packageInfo.buildNumber})';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.settingsTitle),
      ),
      child: ListView(
        children: [
          _buildLanguageSection(context, l10n),
          _buildAppearanceSection(context, l10n),
          _buildExperienceSection(context, l10n),
          _buildPreferencesSection(context, l10n),
          _buildAboutSection(context, l10n), 
          _buildProgressSection(context, l10n),
        ],
      ),
    );
  }

  /// Builds the 'About' section containing version information.
  Widget _buildAboutSection(BuildContext context, AppLocalizations l10n) {
    return CupertinoListSection.insetGrouped(
      header: Text(l10n.aboutHeader),
      children: [
        CupertinoListTile(
          title: Text(l10n.version),
          leading: const _SettingsIcon(
            backgroundColor: CupertinoColors.systemBlue,
            icon: CupertinoIcons.info_circle_fill,
          ),
          additionalInfo: Text(_versionInfo),
        ),
      ],
    );
  }

  /// Builds the language selection section.
  Widget _buildLanguageSection(BuildContext context, AppLocalizations l10n) {
    final settingsProvider = context.watch<SettingsProvider>();

    /// Helper to get the display name of a locale.
    String languageName(Locale? locale) {
      if (locale == null) {
        return l10n.languageSystem;
      }
      switch (locale.languageCode) {
        case 'en':
          return l10n.languageEnglish;
        case 'tr':
          return l10n.languageTurkish;
        case 'ru':
          return l10n.languageRussian;
        case 'de':
          return l10n.languageGerman;
        case 'pt':
          return l10n.languagePortuguese;
        case 'fr':
          return l10n.languageFrench;
        default:
          return l10n.languageSystem;
      }
    }

    return CupertinoListSection.insetGrouped(
      header: Text(l10n.languageHeader),
      children: [
        CupertinoListTile(
          title: Text(l10n.language),
          leading: const _SettingsIcon(
            backgroundColor: CupertinoColors.systemBlue,
            icon: CupertinoIcons.globe,
          ),
          additionalInfo: Text(languageName(settingsProvider.appLocale)),
          trailing: const CupertinoListTileChevron(),
          onTap: () => _showLanguagePicker(context, l10n),
        ),
      ],
    );
  }

  /// Displays a modal popup for selecting the application language.
  void _showLanguagePicker(BuildContext context, AppLocalizations l10n) {
    final settingsProvider = context.read<SettingsProvider>();
    if (settingsProvider.hapticsEnabled) HapticFeedback.selectionClick();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext modalContext) => CupertinoActionSheet(
        title: Text(l10n.languageSelectionTitle),
        actions: [
          CupertinoActionSheetAction(
            child: Text(l10n.languageSystem),
            onPressed: () {
              settingsProvider.setAppLocale(null);
              Navigator.pop(modalContext);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('English'),
            onPressed: () {
              settingsProvider.setAppLocale(const Locale('en'));
              Navigator.pop(modalContext);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Türkçe'),
            onPressed: () {
              settingsProvider.setAppLocale(const Locale('tr'));
              Navigator.pop(modalContext);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Italiano'),
            onPressed: () {
              settingsProvider.setAppLocale(const Locale('it'));
              Navigator.pop(modalContext);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Русский'),
            onPressed: () {
              settingsProvider.setAppLocale(const Locale('ru'));
              Navigator.pop(modalContext);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Deutsch'),
            onPressed: () {
              settingsProvider.setAppLocale(const Locale('de'));
              Navigator.pop(modalContext);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Español'),
            onPressed: () {
              settingsProvider.setAppLocale(const Locale('es'));
              Navigator.pop(modalContext);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Português'),
            onPressed: () {
              settingsProvider.setAppLocale(const Locale('pt'));
              Navigator.pop(modalContext);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Français'),
            onPressed: () {
              settingsProvider.setAppLocale(const Locale('fr'));
              Navigator.pop(modalContext);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(l10n.dialogCancel),
          onPressed: () => Navigator.pop(modalContext),
        ),
      ),
    );
  }

  /// Builds the appearance section for toggling between light, dark, and system themes.
  Widget _buildAppearanceSection(BuildContext context, AppLocalizations l10n) {
    final themeManager = context.watch<ThemeManager>();
    return CupertinoListSection.insetGrouped(
      header: Text(l10n.appearanceHeader),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: CupertinoSlidingSegmentedControl<AppThemeMode>(
            groupValue: themeManager.themeMode,
            onValueChanged: (AppThemeMode? newValue) {
              if (newValue != null) {
                if (context.read<SettingsProvider>().hapticsEnabled) HapticFeedback.selectionClick();
                context.read<ThemeManager>().setThemeMode(newValue);
              }
            },
            children: {
              AppThemeMode.light: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(l10n.themeLight)),
              AppThemeMode.system: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(l10n.themeSystem)),
              AppThemeMode.dark: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(l10n.themeDark)),
            },
          ),
        ),
      ],
    );
  }

  /// Builds the section for haptics, sound effects, and UI coordinate display.
  Widget _buildExperienceSection(BuildContext context, AppLocalizations l10n) {
    final settingsProvider = context.watch<SettingsProvider>();
    return CupertinoListSection.insetGrouped(
      header: Text(l10n.gameExperienceHeader),
      children: [
        CupertinoListTile(
          title: Text(l10n.haptics),
          leading: const _SettingsIcon(
            backgroundColor: CupertinoColors.systemGreen,
            icon: CupertinoIcons.hand_raised,
          ),
          trailing: CupertinoSwitch(
            value: settingsProvider.hapticsEnabled,
            onChanged: (value) {
              if (settingsProvider.hapticsEnabled) HapticFeedback.selectionClick();
              context.read<SettingsProvider>().setHapticsEnabled(value);
            },
          ),
        ),
        CupertinoListTile(
          title: Text(l10n.soundEffects),
          leading: const _SettingsIcon(
            backgroundColor: CupertinoColors.systemIndigo,
            icon: CupertinoIcons.speaker_2_fill,
          ),
          trailing: CupertinoSwitch(
            value: settingsProvider.soundEffectsEnabled,
            onChanged: (value) {
              if (settingsProvider.hapticsEnabled) HapticFeedback.selectionClick();
              context.read<SettingsProvider>().setSoundEffectsEnabled(value);
            },
          ),
        ),
        CupertinoListTile(
          title: Text(l10n.showCoordinates),
          leading: const _SettingsIcon(
            backgroundColor: CupertinoColors.systemGrey,
            icon: CupertinoIcons.number,
          ),
          trailing: CupertinoSwitch(
            value: settingsProvider.showCoordinates,
            onChanged: (value) {
              if (settingsProvider.hapticsEnabled) HapticFeedback.selectionClick();
              context.read<SettingsProvider>().setShowCoordinates(value);
            },
          ),
        ),
      ],
    );
  }

  /// Builds the section for game-specific preferences like preferred player color.
  Widget _buildPreferencesSection(BuildContext context, AppLocalizations l10n) {
    final settingsProvider = context.watch<SettingsProvider>();
    return CupertinoListSection.insetGrouped(
      header: Text(l10n.gamePreferencesHeader),
      footer: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(l10n.gamePreferencesDescription),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: CupertinoSlidingSegmentedControl<PreferredColor>(
            groupValue: settingsProvider.preferredColor,
            onValueChanged: (PreferredColor? newValue) {
              if (newValue != null) {
                if (settingsProvider.hapticsEnabled) HapticFeedback.selectionClick();
                context.read<SettingsProvider>().setPreferredColor(newValue);
              }
            },
            children: {
              PreferredColor.white: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(l10n.colorWhite)),
              PreferredColor.random: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(l10n.colorRandom)),
              PreferredColor.black: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(l10n.colorBlack)),
            },
          ),
        ),
      ],
    );
  }

  /// Builds the section for managing player progress and data.
  Widget _buildProgressSection(BuildContext context, AppLocalizations l10n) {
    return CupertinoListSection.insetGrouped(
      header: Text(l10n.progressHeader),
      children: [
        CupertinoListTile(
          title: Text(l10n.resetAllRanks, style: const TextStyle(color: CupertinoColors.destructiveRed)),
          leading: const _SettingsIcon(
            backgroundColor: CupertinoColors.destructiveRed,
            icon: CupertinoIcons.trash_fill,
          ),
          onTap: () {
            if (context.read<SettingsProvider>().hapticsEnabled) HapticFeedback.selectionClick();
            _showResetConfirmationDialog(context);
          },
        ),
      ],
    );
  }

  /// Displays a confirmation dialog before resetting all player progress.
  void _showResetConfirmationDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) => CupertinoAlertDialog(
        title: Text(l10n.resetProgressConfirmationTitle),
        content: Text(l10n.resetProgressConfirmationBody),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.dialogCancel),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(l10n.dialogReset),
            onPressed: () {
              if (context.read<SettingsProvider>().hapticsEnabled) HapticFeedback.heavyImpact();
              context.read<RankProvider>().resetAllRanks();
              Navigator.of(dialogContext).pop();
              // Show a success message after resetting.
              showCupertinoModalPopup(
                context: context,
                builder: (modalContext) => CupertinoActionSheet(
                  title: Text(l10n.progressResetSuccess),
                  cancelButton: CupertinoActionSheetAction(
                    child: Text(l10n.dialogOK),
                    onPressed: () => Navigator.of(modalContext).pop(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// A custom widget for displaying icons in the settings list with a rounded background.
class _SettingsIcon extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;

  const _SettingsIcon({required this.backgroundColor, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 29,
      height: 29,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: CupertinoColors.white,
        size: 19,
      ),
    );
  }
}
