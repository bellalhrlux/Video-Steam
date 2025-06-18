import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.light);

  static ValueNotifier<ThemeMode> get themeNotifier => _themeNotifier;

  static ThemeMode get currentTheme => _themeNotifier.value;

  static bool get isDarkMode => _themeNotifier.value == ThemeMode.dark;

  static void toggleTheme() {
    _themeNotifier.value = _themeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    _saveTheme();
  }

  static void setTheme(ThemeMode themeMode) {
    _themeNotifier.value = themeMode;
    _saveTheme();
  }

  static void initialize() async {
    await _loadTheme();
  }

  static Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme_mode');
    if (theme != null) {
      _themeNotifier.value = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  static void _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_mode', _themeNotifier.value == ThemeMode.dark ? 'dark' : 'light');
  }

  static void dispose() {
    _themeNotifier.dispose();
  }
}