import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/features/dashboard/presentation/view/dashboard_screen.dart';

mixin HomeViewRoute {
  openHomeView() {
    NavigateRoute.popAndPushRoute(const DashboardScreen());
  }
}

mixin DashboardViewRoute {}
