import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  SharedPreferences? sharedPreferences;

  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';

  String get backgroundImageName =>
      themeMode == ThemeMode.light ? "default_bg" : "dark_bg";

  void changeTheme(ThemeMode selctedTheme) {
    themeMode = selctedTheme;
    saveTheme(themeMode);
    notifyListeners();
  }

  Future<void> saveTheme(ThemeMode themeMode) async {
    String newTheme = themeMode == ThemeMode.dark ? "dark" : "light";
    await sharedPreferences!.setString('theme', newTheme);
  }

  String? getTheme() {
    return sharedPreferences!.getString('theme');
  }

  Future<void> loadThemeData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? oldTheme = getTheme();
    if (oldTheme != null) {
      themeMode = oldTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void changeLanguage(String selctedLanguage) {
    if (selctedLanguage == languageCode) return;
    languageCode = selctedLanguage;
    saveLanguage(languageCode);
    notifyListeners();
  }
  Future<void> saveLanguage( String language) async {

    await sharedPreferences!.setString('language', language);
  }

  String? getLanguage() {
    return sharedPreferences!.getString('language');
  }

  Future<void> loadLanguage() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? language = getLanguage();
    if (language != null) {
      languageCode = language;
      notifyListeners();
    }
  }
}
