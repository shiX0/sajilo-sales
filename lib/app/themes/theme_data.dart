import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    primaryColorDark: Colors.deepPurple,
    fontFamily: "Manrope",
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18, fontFamily: 'Manrope bold'),
    )),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurpleAccent,
      centerTitle: true,
      titleTextStyle: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(15),
      border: OutlineInputBorder(),
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
  );
}
