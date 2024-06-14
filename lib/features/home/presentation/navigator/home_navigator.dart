import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/features/home/presentation/view/home_screen.dart';

mixin HomeViewRoute {
  openHomeView() {
    NavigateRoute.pushRoute(const HomeScreen());
  }
}
