import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade800,
    // primary: Colors.grey[700]!,
    // onPrimary: Colors.grey[50]!,
    // secondary: Colors.grey[500]!,
    // onSecondary: Colors.white,
    // error: Colors.black,
    // onError: Colors.white,
    // onBackground: Colors.white,
    // surface: Colors.grey[300]!,
    // onSurface: Colors.grey[850]!,
  ),
);
