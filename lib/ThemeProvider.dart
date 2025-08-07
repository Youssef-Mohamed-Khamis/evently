import 'package:evently/core/remote/local/PrefsManager.dart';
import 'package:flutter/material.dart';
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