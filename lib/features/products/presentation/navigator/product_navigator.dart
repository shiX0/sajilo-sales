import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';

import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';
import 'package:sajilo_sales/features/products/presentation/navigator/product_add_navigator.dart';
import 'package:sajilo_sales/features/products/presentation/navigator/product_detail_navigator.dart';
import 'package:sajilo_sales/features/products/presentation/view/product_view.dart';

final productRouteNavigatorProvider = Provider((ref) => ProductNavigator());

class ProductNavigator with ProductDetailViewRoute, ProductAddRoute {}

mixin ProductViewRoute {
  openProductView() {
    NavigateRoute.pushRoute(const ProductView());
  }
}
