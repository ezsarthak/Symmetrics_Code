import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePrefs {
  static SharedPreferences? _preferences;
  static const _keyFavoriteId = 'keyFavoriteId';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setFavoriteIDs(List<String> favoritesIds) async =>
      await _preferences!.setStringList(_keyFavoriteId, favoritesIds);
  static List<String>? getfavoritesIdsPrefs() =>
      _preferences!.getStringList(_keyFavoriteId) ?? [];

  static const themeStatus = "themeStatus";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? true;
  }
}
