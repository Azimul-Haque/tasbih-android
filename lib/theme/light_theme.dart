import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
  ),
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade100,
    secondary: Colors.grey.shade200,
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
