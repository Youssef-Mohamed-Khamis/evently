import 'package:flutter/material.dart';
import 'ColorManager.dart';

class AppStyle{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.lightBackgroundColor,
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,

    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.primaryColor,
      primary: ColorManager.primaryColor,
      secondary: ColorManager.blackColor,
      onPrimary: ColorManager.whiteColor,
      outline: ColorManager.greyColor

    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
          fontWeight: FontWeight.w700,
          color: ColorManager.primaryColor,
          fontSize: 20
      ),
        bodySmall: TextStyle(
            color: ColorManager.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500
        ),
      titleMedium: TextStyle(
        color: ColorManager.greyColor,
        fontSize: 16,
        fontWeight: FontWeight.w500
      )
    )
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.darkBackgroundColor,
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,

    ),
      textTheme: TextTheme(
          titleSmall: TextStyle(
              fontWeight: FontWeight.w700,
              color: ColorManager.primaryColor,
              fontSize: 20
          ),
          bodySmall: TextStyle(
              color: ColorManager.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
          titleMedium: TextStyle(
              color: ColorManager.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w500
          )
      ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.primaryColor,
        primary: ColorManager.primaryColor,
        secondary: ColorManager.whiteColor,
        onPrimary: ColorManager.blackColor,
        outline: ColorManager.primaryColor


    )
  );
}