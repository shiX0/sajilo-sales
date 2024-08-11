import 'package:sajilo_sales/app/navigator/navigator.dart';

import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';
import 'package:sajilo_sales/features/products/presentation/view/product_detail_screen.dart';

mixin ProductDetailViewRoute {
  openProductDetailView(ProductEntity product) {
    NavigateRoute.pushRoute(ProductDetailsScreen(product: product));
  }
}
