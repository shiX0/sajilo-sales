import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/products/domain/usecases/product_usecase.repository.dart';
import 'package:sajilo_sales/features/products/presentation/state/product_state.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>(
        (ref) => ProductViewModel(ref.read(productUsecaseProvider)));

class ProductViewModel extends StateNotifier<ProductState> {
  final ProductUsecase productUsecase;

  ProductViewModel(this.productUsecase) : super(ProductState.initial());

  Future<void> getProducts() async {
    if (state.isLoading || state.hasReachedMax) return;

    state = state.copyWith(isLoading: true);
    final page = state.page + 1;

    final result = await productUsecase.getAllProduct(page);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error, // Assuming Failure has a message property
        hasReachedMax: true,
      ),
      (data) {
        if (data.isEmpty) {
          state = state.copyWith(hasReachedMax: true, isLoading: false);
        } else {
          state = state.copyWith(
            isLoading: false,
            products: [...state.productList, ...data],
            page: page,
            error: null,
          );
        }
      },
    );
  }
}
