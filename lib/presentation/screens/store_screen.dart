// lib/presentation/screens/store_screen.dart

import 'package:checkers_game/domain/models/piece.dart';
import 'package:checkers_game/domain/models/theme_base.dart';
import 'package:checkers_game/domain/models/theme_model.dart';
import 'package:checkers_game/l10n/app_localizations.dart';
import 'package:checkers_game/presentation/utils/localization_helper.dart';
import 'package:checkers_game/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// A screen that allows users to browse and select different visual themes for the game.
/// 
/// It supports switching between board themes and piece themes, searching for specific themes,
/// and previewing them before selection.
class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  /// The currently selected tab index (0 for Boards, 1 for Pieces).
  int _selectedTab = 0;
  
  /// Controller for the search text field.
  final TextEditingController _searchController = TextEditingController();
  
  /// A notifier that holds the current search query string.
  final ValueNotifier<String> _searchQuery = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    // Update the search query notifier whenever the text in the search field changes.
    _searchController.addListener(() {
      _searchQuery.value = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(l10n.themeStoreTitle)),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top section containing the search bar and category selector.
            _TopBarSection(
              selectedTab: _selectedTab,
              searchController: _searchController,
              onTabChanged: (newValue) {
                if (newValue != null) setState(() => _selectedTab = newValue);
              },
              l10n: l10n,
            ),
            // The main list area displaying themes in categories.
            Expanded(
              child: _ThemeGridSection(
                selectedTab: _selectedTab,
                searchQuery: _searchQuery,
                l10n: l10n,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget representing the search and tab control section at the top of the store.
class _TopBarSection extends StatelessWidget {
  final int selectedTab;
  final TextEditingController searchController;
  final ValueChanged<int?> onTabChanged;
  final AppLocalizations l10n;

  const _TopBarSection({
    required this.selectedTab,
    required this.searchController,
    required this.onTabChanged,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Standard Cupertino search bar.
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
          child: CupertinoSearchTextField(
            controller: searchController,
            placeholder: selectedTab == 0
                ? l10n.searchBoardPlaceholder
                : l10n.searchPiecePlaceholder,
          ),
        ),
        // Segmented control to switch between board and piece categories.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CupertinoSlidingSegmentedControl<int>(
            groupValue: selectedTab,
            onValueChanged: onTabChanged,
            children: {
              0: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(l10n.boards),
              ),
              1: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(l10n.pieces),
              ),
            },
          ),
        ),
      ],
    );
  }
}

/// A section that filters and displays themes based on the current tab and search query.
class _ThemeGridSection extends StatelessWidget {
  final int selectedTab;
  final ValueNotifier<String> searchQuery;
  final AppLocalizations l10n;

  const _ThemeGridSection({
    required this.selectedTab,
    required this.searchQuery,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: searchQuery,
      builder: (context, query, _) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, __) {
            final isBoardThemes = selectedTab == 0;
            // Get themes categorized by their type (e.g., Classic, Retro).
            final filteredCategorizedThemes = _getFilteredThemes(
              themeProvider,
              isBoardThemes,
              query,
              l10n,
            );

            return filteredCategorizedThemes.isEmpty
                ? Center(child: Text(l10n.noResults))
                : _CategorizedThemesList(
              categorizedThemes: filteredCategorizedThemes,
              isBoardThemes: isBoardThemes,
              l10n: l10n,
            );
          },
        );
      },
    );
  }

  /// Filters themes by the search query and groups them by category.
  Map<String, List<ThemeBase>> _getFilteredThemes(
      ThemeProvider provider,
      bool isBoardThemes,
      String query,
      AppLocalizations l10n,
      ) {
    final Map<String, List<ThemeBase>> result = {};
    final categories = provider.categories;

    for (final category in categories) {
      final themes = isBoardThemes
          ? provider.getBoardThemesByCategory(category)
          : provider.getPieceThemesByCategory(category);

      if (query.isEmpty) {
        // If no search query, show all themes in the category.
        if (themes.isNotEmpty) result[category] = themes;
      } else {
        // Perform case-insensitive search on the localized theme names.
        final filtered = themes.where((theme) {
          final localizedName = LocalizationHelper.getLocalizedThemeName(theme.nameKey, l10n);
          return localizedName.toLowerCase().contains(query.toLowerCase());
        }).toList();

        if (filtered.isNotEmpty) result[category] = filtered;
      }
    }
    return result;
  }
}

/// Renders a vertically scrollable list of theme categories.
class _CategorizedThemesList extends StatelessWidget {
  final Map<String, List<ThemeBase>> categorizedThemes;
  final bool isBoardThemes;
  final AppLocalizations l10n;

  const _CategorizedThemesList({
    required this.categorizedThemes,
    required this.isBoardThemes,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final categories = categorizedThemes.keys.toList();

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final category = categories[index];
              final themes = categorizedThemes[category]!;
              return _ThemeCategorySection(
                category: LocalizationHelper.getLocalizedCategoryName(category, l10n),
                themes: themes,
                isBoardThemes: isBoardThemes,
              );
            },
            childCount: categories.length,
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
      ],
    );
  }
}

/// A section representing a single category and its horizontally scrollable theme cards.
class _ThemeCategorySection extends StatelessWidget {
  final String category;
  final List<ThemeBase> themes;
  final bool isBoardThemes;

  const _ThemeCategorySection({
    required this.category,
    required this.themes,
    required this.isBoardThemes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: category),
        _HorizontalThemesGrid(themes: themes, isBoardThemes: isBoardThemes),
      ],
    );
  }
}

/// A simple text header for theme categories.
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 24.0, 16.0, 8.0),
      child: Text(
        title,
        style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(fontSize: 20),
      ),
    );
  }
}

/// A horizontally scrolling list of theme cards.
class _HorizontalThemesGrid extends StatelessWidget {
  static const double _cardHeight = 180.0;
  static const double _cardWidth = 140.0;

  final List<ThemeBase> themes;
  final bool isBoardThemes;

  const _HorizontalThemesGrid({
    required this.themes,
    required this.isBoardThemes,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _cardHeight,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: themes.length,
        itemBuilder: (context, index) {
          final theme = themes[index];
          return SizedBox(
            width: _cardWidth,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _ThemeCardItem(
                theme: theme,
                isBoardThemes: isBoardThemes,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A card widget that displays a specific theme and handles selection.
class _ThemeCardItem extends StatelessWidget {
  final ThemeBase theme;
  final bool isBoardThemes;

  const _ThemeCardItem({
    required this.theme,
    required this.isBoardThemes,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localizedThemeName = LocalizationHelper.getLocalizedThemeName(theme.nameKey, l10n);

    // Use a selector to rebuild only when this specific theme's selection status changes.
    return Selector<ThemeProvider, bool>(
      selector: (_, provider) => isBoardThemes
          ? provider.selectedBoardTheme.nameKey == theme.nameKey
          : provider.selectedPieceTheme.nameKey == theme.nameKey,
      builder: (context, isSelected, __) {
        final themeProvider = context.read<ThemeProvider>();
        return _ThemeCard(
          label: localizedThemeName,
          isSelected: isSelected,
          onTap: () => isBoardThemes
              ? themeProvider.setBoardTheme(theme as BoardTheme)
              : themeProvider.setPieceTheme(theme as PieceTheme),
          child: isBoardThemes
              ? Image.asset(
            themeProvider.getBoardAssetPath(theme as BoardTheme, 8),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(CupertinoIcons.exclamationmark_triangle),
            ),
          )
              : _PieceThemePreview(theme: theme as PieceTheme),
        );
      },
    );
  }
}

/// The visual representation of a theme card, showing its preview and label.
class _ThemeCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  const _ThemeCard({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cupertinoTheme = CupertinoTheme.of(context);
    final primaryColor = cupertinoTheme.primaryColor;
    final textColor = cupertinoTheme.textTheme.textStyle.color;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? primaryColor
                      : CupertinoColors.separator.resolveFrom(context),
                  width: isSelected ? 3.0 : 1.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: child,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? primaryColor : textColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A custom preview widget for piece themes, showing both white and black pieces.
class _PieceThemePreview extends StatelessWidget {
  final PieceTheme theme;

  const _PieceThemePreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    final bgColor = CupertinoColors.secondarySystemGroupedBackground.resolveFrom(context);

    return Container(
      color: bgColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Subtle background gradient for aesthetic appeal.
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, 0.4),
                radius: 0.8,
                colors: [Color(0x2DFFFFFF), Color(0x00FFFFFF)],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                _PieceImage(theme: theme, color: PieceColor.white),
                const SizedBox(width: 8),
                _PieceImage(theme: theme, color: PieceColor.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders a single piece image for the preview.
class _PieceImage extends StatelessWidget {
  final PieceTheme theme;
  final PieceColor color;

  const _PieceImage({
    required this.theme,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image(
        image: context.read<ThemeProvider>().getPieceImageProvider(
          Piece(id: color == PieceColor.white ? 'w' : 'b', color: color),
          theme,
        ),
      ),
    );
  }
}
