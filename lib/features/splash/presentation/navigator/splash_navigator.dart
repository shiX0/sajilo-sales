import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/auth/presentation/navigator/login_navigator.dart';
import 'package:sajilo_sales/features/home/presentation/navigator/home_navigator.dart';

final splashViewNavigatorProvider =
    Provider<SplashViewNavigator>((ref) => SplashViewNavigator());

// This class will be used to navigate to LoginView
class SplashViewNavigator with LoginViewRoute, HomeViewRoute {}

mixin SplashViewRoute {}
