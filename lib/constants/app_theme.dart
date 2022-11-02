import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      cupertinoOverrideTheme: CupertinoThemeData(
        scaffoldBackgroundColor:
            isDarkTheme ? Colors.black : const Color(0xffF8FDFF),
        barBackgroundColor:
            isDarkTheme ? Colors.black : const Color(0xffF8FDFF),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      primaryColor:
          isDarkTheme ? const Color(0xffD7EAEF) : const Color(0xff273D5E),
      accentColor: isDarkTheme ? Colors.white : const Color(0xffD7EAEF),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: isDarkTheme
              ? Colors.white.withOpacity(0.85)
              : AppColors.primary.withOpacity(0.85),
        ),
        titleSmall: TextStyle(
          color: isDarkTheme
              ? Colors.white.withOpacity(0.45)
              : AppColors.primary.withOpacity(0.45),
        ),
        labelLarge: TextStyle(
          color: isDarkTheme ? Colors.white : const Color(0xff273D5E),
        ),
        labelMedium: TextStyle(
          color: isDarkTheme
              ? Colors.white.withOpacity(0.5)
              : const Color(0xff273D5E).withOpacity(0.33),
        ),
      ),
      primaryColorLight: isDarkTheme ? Colors.black : const Color(0xffF8FDFF),
      primaryColorDark: isDarkTheme ? Colors.black : Colors.white,
      indicatorColor:
          isDarkTheme ? Colors.amber.shade300 : Colors.blueGrey.shade500,
      secondaryHeaderColor:
          isDarkTheme ? const Color(0xff273D5E) : const Color(0xffD7EAEF),
      backgroundColor: isDarkTheme ? Colors.black : const Color(0xffD7EAEF),
      brightness: isDarkTheme ? Brightness.light : Brightness.dark,
      cardColor: isDarkTheme ? Colors.grey.shade900 : const Color(0xffD7EAEF),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor:
            isDarkTheme ? Colors.grey.shade900 : const Color(0xff273D5E),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        foregroundColor:
            isDarkTheme ? const Color(0xffD7EAEF) : const Color(0xff273D5E),
      ),
    );
  }
}
