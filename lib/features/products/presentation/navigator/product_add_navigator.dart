import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/features/products/presentation/view/product_add_screen.dart';

mixin ProductAddRoute {
  openProductAdd() {
    NavigateRoute.pushRoute(const ProductAddScreen());
  }
}
