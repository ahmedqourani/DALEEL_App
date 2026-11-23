import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ---------------------------------------------------------------------------
/// ThemeProvider - light/dark toggle for the whole app.
/// The choice is persisted with SharedPreferences, so the app reopens in
/// the same mode the user left it in.
/// ---------------------------------------------------------------------------
class ThemeProvider extends ChangeNotifier {
  static const _key = 'dark_mode';

  bool isDark = false;

  ThemeProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> toggle() async {
    isDark = !isDark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDark);
  }
}
