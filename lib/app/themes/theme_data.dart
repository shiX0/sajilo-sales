import 'package:flutter/material.dart';

ThemeData getApplicationTheme(bool isDarkMode) {
  return ThemeData(
    useMaterial3: true,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    primaryColor: Colors.deepPurple,
    fontFamily: "Manrope",
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18, fontFamily: 'Manrope'),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkMode ? Colors.deepPurpleAccent : Colors.deepPurple,
      centerTitle: true,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(15),
      border: OutlineInputBorder(),
      labelStyle: TextStyle(fontSize: 20),
    ),
  );
}
