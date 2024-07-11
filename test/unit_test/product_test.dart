import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';
import 'package:sajilo_sales/features/products/domain/usecases/product_usecase.repository.dart';
import 'package:sajilo_sales/features/products/presentation/viewmodel/product_view_model.dart';

import 'product_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductUsecase>()])
void main() {
  late ProductUsecase mockProductUsecase;
  late ProviderContainer container;
  late List<ProductEntity> lstProducts;

  setUp(() {
    mockProductUsecase = MockProductUsecase();
    container = ProviderContainer(overrides: [
      productViewModelProvider
          .overrideWith((ref) => ProductViewModel(mockProductUsecase))
    ]);
  });

  test("Initial product state test", () {
    container.read(productViewModelProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });
}
