import 'package:flutter/material.dart';
import 'package:news/services/dark_theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreferences themePreferences = ThemePreferences();
  bool _isDarkTheme = false;

  bool get getIsDarkTheme => _isDarkTheme;

  set setDarkTheme(bool value) {
    _isDarkTheme = value;
    themePreferences.setDarkTheme(value);
    notifyListeners();
  }
}
