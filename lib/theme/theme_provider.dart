import 'package:flutter/material.dart';
import 'package:tasbih/theme/dark_theme.dart';
import 'package:tasbih/theme/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  set themData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }
  }
}
