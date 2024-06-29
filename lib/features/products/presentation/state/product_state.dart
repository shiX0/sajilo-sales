import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

class ProductState {
  final bool isLoading;
  final bool hasReachedMax;
  final String? error;
  final List<ProductEntity> productList;
  final int page;

  const ProductState(
      {required this.isLoading,
      required this.error,
      required this.productList,
      required this.page,
      required this.hasReachedMax});

  factory ProductState.initial() => const ProductState(
        isLoading: false,
        hasReachedMax: false,
        error: null,
        productList: [],
        page: 0,
      );

  ProductState copyWith({
    bool? isLoading,
    bool? hasReachedMax,
    String? error,
    List<ProductEntity>? products,
    int? page,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      productList: products ?? productList,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
