import 'package:flutter/material.dart';

import '../remote/local/PrefsManager.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light; // default

  Future<void> initTheme() async {
    final savedTheme = await PrefsManager.getThemeMode();
    themeMode = savedTheme ?? ThemeMode.light;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    if (newTheme == themeMode) return;
    themeMode = newTheme;
    PrefsManager.saveThemeMode(themeMode);
    notifyListeners();
  }
}

