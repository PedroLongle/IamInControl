import 'package:flutter/material.dart';

enum appThemesKeys { BLACK, RED }

class appThemes {

  static final ThemeData blackTheme = ThemeData(
    primaryColor: Colors.black,
    appBarTheme: AppBarTheme(color: Colors.black,),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Color(0xff171d49),
      selectionHandleColor: Color(0xff005e91),
    ),
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    highlightColor: Colors.white,
    floatingActionButtonTheme:
      FloatingActionButtonThemeData (backgroundColor: Colors.black,focusColor: Colors.black , splashColor: Colors.black),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),

  );

  static final ThemeData redTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    highlightColor: Colors.white,
    backgroundColor: Colors.black54,
    textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.grey),
  );

  static ThemeData getThemeFromKey(appThemesKeys themeKey) {
    switch (themeKey) {
      case appThemesKeys.BLACK:
        return blackTheme;
      case appThemesKeys.RED:
        return redTheme;
      default:
        return blackTheme;
    }
  }
}