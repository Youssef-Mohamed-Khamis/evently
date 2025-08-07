import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager{
  static late SharedPreferences preferences;

  static Future<void> init()async{
    preferences = await SharedPreferences.getInstance();// 3s
  }

  static saveThemeMode(ThemeMode themeMode){
    preferences.setString("theme", themeMode==ThemeMode.dark?"dark":"light");// "light","dark"
  }
  static ThemeMode getThemeMode(){
    String themeMode = preferences.getString("theme")??"light";
    if(themeMode == "dark"){
      return ThemeMode.dark;
    }else{
      return ThemeMode.light;
    }
  }
}