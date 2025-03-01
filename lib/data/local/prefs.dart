import 'package:book_finder/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _prefs;

  Preferences._();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool getDarkMode() {
    _ensureInitialized();
    return _prefs!.getBool(AppConstants.themeModeKey) ?? false;
  }

  static Future<void> setDarkMode(bool value) async {
    _ensureInitialized();
    await _prefs!.setBool(AppConstants.themeModeKey, value);
  }

  static void _ensureInitialized() {
    if (_prefs == null) {
      throw Exception('Preferences not initialized! Call Preferences.init() first');
    }
  }
}