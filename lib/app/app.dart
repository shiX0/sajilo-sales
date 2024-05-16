import 'package:flutter/material.dart';
import 'package:sajilo_sales/screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple,
      hintColor: Colors.amber,
      scaffoldBackgroundColor: Colors.black,
      // Customize more properties as needed
    );
    return MaterialApp(
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
