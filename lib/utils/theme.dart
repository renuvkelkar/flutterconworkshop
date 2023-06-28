import 'package:flutter/material.dart';

class AppTheme {
  ThemeData themedata = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 238, 122, 161),
        foregroundColor:
            Color.fromARGB(255, 10, 10, 10) //here you can give the text color
        ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          color: Color.fromARGB(255, 254, 255, 255),
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 16, 16, 16),
          fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: Color.fromARGB(255, 239, 223, 223),
      ),
      contentPadding: EdgeInsets.only(top: 12, left: 10),
    ),
    primarySwatch: Colors.teal,
    brightness: Brightness.light,
  );
}
