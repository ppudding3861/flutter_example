import 'package:flutter/material.dart';

class Numbertheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      color: Color(0xFF00BFA5),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 16.0, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
      bodyLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: Colors.amber, textTheme: ButtonTextTheme.primary),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blueGrey,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 16.0, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 16.0, color: Colors.white70),
      bodyLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blueGrey, textTheme: ButtonTextTheme.primary),
    iconTheme: const IconThemeData(color: Colors.white), // 아이콘 색상 지정
  );
}
