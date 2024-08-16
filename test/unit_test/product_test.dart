import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';
import 'package:sajilo_sales/features/products/domain/usecases/product_usecase_repository.dart';
import 'package:sajilo_sales/features/products/presentation/navigator/product_navigator.dart';
import 'package:sajilo_sales/features/products/presentation/viewmodel/product_view_model.dart';

import '../test_data/product_test_data.dart';
import 'product_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductUsecase>(), MockSpec<ProductNavigator>()])
void main() {
  late ProductUsecase mockProductUsecase;
  late ProviderContainer container;
  late List<ProductEntity> lstProducts;
  late ProductNavigator productViewRoute;

  setUp(() {
    mockProductUsecase = MockProductUsecase();
    productViewRoute = MockProductNavigator();
    lstProducts = ProductTestData.getProductsTestData();
    container = ProviderContainer(overrides: [
      productViewModelProvider.overrideWith(
          (ref) => ProductViewModel(mockProductUsecase, productViewRoute))
    ]);
  });

  test('Fetch products on initial and check state', () async {
    when(mockProductUsecase.getAllProduct(1))
        .thenAnswer((_) async => Right(lstProducts));

    // Fetch products
    await container.read(productViewModelProvider.notifier).getProducts();

    // Store the state
    final productState = container.read(productViewModelProvider);

    // Check the state
    expect(productState.isLoading, equals(false));
    expect(productState.error, isNull);
    expect(productState.productList, equals(lstProducts));
  });

  tearDown(() {
    container.dispose();
  });
  // delete product
  test('Delete product', () async {
    final product = lstProducts[1];
    when(mockProductUsecase.deleteProduct(product.id!))
        .thenAnswer((_) async => const Right("Product deleted"));

    // Delete product
    await container
        .read(productViewModelProvider.notifier)
        .deleteProduct(product.id!);

    // Store the state
    final productState = container.read(productViewModelProvider);

    // Check the state
    expect(productState.isLoading, equals(false));
    expect(productState.error, isNull);
    expect(productState.productList, equals(lstProducts));
  });
}
