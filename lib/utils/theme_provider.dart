import 'package:flutter/material.dart';

import 'shared_preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  UserSimplePrefs darkThemePreference = UserSimplePrefs();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
