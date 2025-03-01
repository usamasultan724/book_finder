import 'package:book_finder/data/local/prefs.dart';
import 'package:flutter/foundation.dart';

class ThemeController extends ValueNotifier<bool> {
  ThemeController() : super(false) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    value = Preferences.getDarkMode();
  }

  Future<void> toggleTheme() async {
    value = !value;
    await Preferences.setDarkMode(value);
  }
}