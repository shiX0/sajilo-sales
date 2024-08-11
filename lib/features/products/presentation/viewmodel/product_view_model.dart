import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/common/custom_snackbar.dart';
import 'package:sajilo_sales/features/products/domain/usecases/product_usecase_repository.dart';
import 'package:sajilo_sales/features/products/presentation/navigator/product_navigator.dart';
import 'package:sajilo_sales/features/products/presentation/state/product_state.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>((ref) =>
        ProductViewModel(ref.read(productUsecaseProvider),
            ref.read(productRouteNavigatorProvider)));

class ProductViewModel extends StateNotifier<ProductState> {
  final ProductUsecase productUsecase;
  final ProductNavigator productNavigator;

  ProductViewModel(this.productUsecase, this.productNavigator)
      : super(ProductState.initial());

  Future<void> getProducts() async {
    if (state.isLoading || state.hasReachedMax) return;
    state = state.copyWith(isLoading: true);
    final page = state.page + 1;

    final result = await productUsecase.getAllProduct(page);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
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

  void openProductDetail(product) {
    productNavigator.openProductDetailView(product);
  }

  Future<void> deleteProduct(String productId) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);

    final result = await productUsecase.deleteProduct(productId);
    result.fold(
      (failure) {
        // Show error message if deletion fails
        showMySnackBar(
            message: "Failed to delete product: ${failure.error}",
            color: Colors.red);
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
      },
      (successMessage) {
        // Show success message if deletion is successful
        showMySnackBar(message: "Product deleted successfully");

        // Remove the deleted product from the list
        final updatedProductList = state.productList
            .where((product) => product.id != productId)
            .toList();

        state = state.copyWith(
          isLoading: false,
          error: null,
          products: updatedProductList,
        );
      },
    );
  }
}
