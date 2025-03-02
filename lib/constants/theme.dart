import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    colorScheme: const ColorScheme.light(
      primary: Colors.red,
      onPrimary: Colors.white,
      secondary: Colors.redAccent,
      onSecondary: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      color: Colors.red,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red.shade900,
    scaffoldBackgroundColor: Colors.black87,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    colorScheme: ColorScheme.dark(
      primary: Colors.red.shade900, // ✅ Properly assigned
      onPrimary: Colors.white,
      secondary: Colors.redAccent,
      onSecondary: Colors.white,
    ),

    appBarTheme: AppBarTheme(
      color: Colors.red.shade900,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
