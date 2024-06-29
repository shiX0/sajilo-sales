import 'package:flutter/material.dart';
import 'package:sajilo_sales/app/navigator_key/navigator_key.dart';

import 'package:sajilo_sales/features/splash/presentation/view/splash_view.dart';
import 'package:sajilo_sales/app/themes/theme_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Sajilo Sales',
      theme: getApplicationTheme(),
      home: const SplashView(),
    );
  }
}
