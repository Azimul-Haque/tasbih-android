import 'package:flutter/material.dart';
import 'package:tasbih/theme/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  set themData()
}
