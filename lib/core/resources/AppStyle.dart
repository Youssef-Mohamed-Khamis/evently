import 'package:flutter/material.dart';

import 'ColorManager.dart';

class AppStyle{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.lightBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.primaryColor,
        shape: StadiumBorder(
            side: BorderSide(
                color: ColorManager.whiteColor,
                width: 5
            )
        )
    ),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: ColorManager.blackColor
      )
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.primaryColor,
      primary: ColorManager.primaryColor,
      secondary: ColorManager.blackColor,
      onPrimary: ColorManager.whiteColor,
      outline: ColorManager.greyColor,
      tertiary: ColorManager.primaryColor

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.primaryColor,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: ColorManager.whiteColor,
      selectedItemColor: ColorManager.whiteColor,
        selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700
        ),
        unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700
        )
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
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorManager.whiteColor,
        fontSize: 24
      )
    )
  );
  static ThemeData darkTheme = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.darkBackgroundColor,
        shape: StadiumBorder(
          side: BorderSide(
            color: ColorManager.whiteColor,
              width: 5

          )
        )

      ),
    scaffoldBackgroundColor: ColorManager.darkBackgroundColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorManager.darkBackgroundColor,
        type: BottomNavigationBarType.fixed,
          unselectedItemColor: ColorManager.whiteColor,
          selectedItemColor: ColorManager.whiteColor,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700
          ),
        unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700
        )
      ),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: ColorManager.primaryColor
        )

    ),
      textTheme: TextTheme(
          headlineMedium: TextStyle(
              fontWeight: FontWeight.w700,
              color: ColorManager.whiteColor,
              fontSize: 24
          ),
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
        outline: ColorManager.primaryColor,
        tertiary: ColorManager.darkBackgroundColor



    )
  );
}