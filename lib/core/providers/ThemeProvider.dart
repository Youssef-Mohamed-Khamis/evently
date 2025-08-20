import 'package:flutter/material.dart';

import '../remote/local/PrefsManager.dart';
// observable
// publisher
class ThemeProvider extends ChangeNotifier{
  late ThemeMode themeMode;

  initTheme(){
    themeMode = ThemeMode.light;
  }
  changeTheme(ThemeMode newTheme){
    if(newTheme==themeMode) return;
    themeMode = newTheme;
    PrefsManager.saveThemeMode(themeMode);
    notifyListeners();
  }

}