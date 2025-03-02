import 'package:book_finder/presentation/controllers/book_controller.dart';
import 'package:book_finder/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';

class SearchBarWithThemeToggle extends StatefulWidget {
  final TextEditingController controller;
  final BookController bookController;
  final ThemeController themeController;

  const SearchBarWithThemeToggle({
    super.key,
    required this.controller,
    required this.bookController,
    required this.themeController,
  });

  @override
  State<SearchBarWithThemeToggle> createState() =>
      _SearchBarWithThemeToggleState();
}

class _SearchBarWithThemeToggleState extends State<SearchBarWithThemeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final containerColor = theme.colorScheme.primary.withOpacity(0.15);
    final iconColor = theme.colorScheme.onPrimary;

    return Row(
      children: [
        // Search Bar
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: widget.bookController.searchBooks,
                    controller: widget.controller,
                    decoration: const InputDecoration(
                      hintText: 'Search books...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: iconColor),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    widget.bookController.searchBooks(widget.controller.text);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),

        // Theme Toggle Button
        GestureDetector(
          onTap: widget.themeController.toggleTheme,
          child: Container(
            height: 50, // Same height as search bar
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ValueListenableBuilder<bool>(
              valueListenable: widget.themeController,
              builder: (context, isDarkMode, _) {
                return Row(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return RotationTransition(
                            turns: _animation, child: child);
                      },
                      child: Icon(
                        isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        key: ValueKey(isDarkMode),
                        color: iconColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
