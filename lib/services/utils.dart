import 'package:flutter/material.dart';
import 'package:hihiienngok/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  set setDarkTheme(bool value) {
    Provider.of<DarkThemeProvider>(context).setDarkTheme = value;
  }

  Color get color => getTheme ? Colors.white : Colors.black;
  Size get screenSize => MediaQuery.of(context).size;
}
