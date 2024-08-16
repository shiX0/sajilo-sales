import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator_key/navigator_key.dart';
import 'package:sajilo_sales/app/themes/theme_data.dart';
import 'package:sajilo_sales/core/shared_prefs/app_theme_prefs.dart';
import 'package:sajilo_sales/features/auth/presentation/view/login_view.dart';
import 'package:sajilo_sales/features/splash/presentation/view/splash_view.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current theme preference (dark or light mode)
    final isDarkMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Sajilo Sales',
      theme: getApplicationTheme(isDarkMode), // Apply the dynamic theme
      home: const SplashView(),
    );
  }
}
