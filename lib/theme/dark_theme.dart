import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      background: Colors.grey[850]!,
      primary: Colors.grey[850]!,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      error: error,
      onError: onError,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface),
);
