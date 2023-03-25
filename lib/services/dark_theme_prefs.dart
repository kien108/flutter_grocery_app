import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(THEME_STATUS, value);
  }

  // Future (uncomplecated/complecated) -> work like promise in js

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}
