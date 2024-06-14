import 'package:flutter/material.dart';
import 'package:sajilo_sales/screens/splash_screen.dart';
import 'package:sajilo_sales/app/themes/theme_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
