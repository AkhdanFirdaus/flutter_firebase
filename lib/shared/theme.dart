import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    primarySwatch: Colors.blue,
    inputDecorationTheme: defaultInputTheme,
  );

  static InputDecorationTheme defaultInputTheme = InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.pink,
        width: 2,
      ),
    ),
  );
}
