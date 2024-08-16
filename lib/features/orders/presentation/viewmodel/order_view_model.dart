import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/common/custom_snackbar.dart';
import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';
import 'package:sajilo_sales/features/orders/domain/entity/order_entity.dart';
import 'package:sajilo_sales/features/orders/domain/usecases/order_usecase.dart';
import 'package:sajilo_sales/features/orders/presentation/state/order_state.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, OrderState>((ref) {
  final orderUsecase = ref.read(orderUsecaseProvider);
  return OrderViewModel(orderUsecase);
});

class OrderViewModel extends StateNotifier<OrderState> {
  OrderUsecase orderUsecase;
  OrderViewModel(this.orderUsecase) : super(OrderState());

  Future<void> getOrders() async {
    if (state.isLoading || state.hasReachedMax) return;
    state = state.copyWith(isLoading: true);
    final page = state.page + 1;
    final result = await orderUsecase.getAllOrder(page);
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
          debugPrint(data.toString());
          state = state.copyWith(
            isLoading: false,
            orderEntity: [...state.orderEntity, ...data],
            page: page,
            error: null,
          );
        }
      },
    );
  }

  Future<void> refreshOrders() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, orderEntity: []);
    final result = await orderUsecase.getAllOrder(1);
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
            orderEntity: data,
            page: 1,
            hasReachedMax: false,
            error: null,
          );
        }
      },
    );
  }

  Future<void> deleteOrder(String id) async {
    final result = await orderUsecase.deleteOrder(id);
    result.fold(
      (failure) => state = state.copyWith(error: failure.error),
      (data) {
        state = state.copyWith(
          orderEntity:
              state.orderEntity.where((element) => element.id != id).toList(),
          error: null,
        );
        showMySnackBar(message: 'Order deleted successfully');
      },
    );
    refreshOrders();
  }

  Future<void> addOrder(order) async {
    final result = await orderUsecase.addOrder(order);
    result.fold(
      (failure) {
        state = state.copyWith(error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (data) {
        state = state.copyWith(
          error: null,
        );
        showMySnackBar(message: 'Order added successfully');
      },
    );
  }

  addToCart(ProductEntity order, int quantity) {
    if (state.products.contains(order)) {
      state.quantity[state.products.indexOf(order)] += quantity;
      calculateAll();
      return;
    }
    state = state.copyWith(products: [...state.products, order]);
    state = state.copyWith(quantity: [...state.quantity, quantity]);

    calculateAll();
  }

  editQuantity(ProductEntity order, int quantity) {
    state.quantity[state.products.indexOf(order)] = quantity;
    calculateAll();
  }

  removeProductFromCart(ProductEntity order) {
    state.copyWith(
        products:
            state.products.where((element) => element.id != order.id).toList());
    state.products.removeAt(state.products.indexOf(order));
  }

  clearCart() {
    state = state.copyWith(products: []);
    state = state.copyWith(quantity: []);
    state = state.copyWith(subtotal: 0);
    state = state.copyWith(total: 0);
    state = state.copyWith(discount: 0);
    state = state.copyWith(tax: 0);
  }

  addCustomer(customer) {
    state = state.copyWith(customerEntity: customer);
  }

  clearCustomer() {
    state = state.copyWith(removeCustomerEntity: true);
  }

  prepareOrder() {
    calculateAll();
    if (state.customerEntity == null ||
        state.customerEntity!.id == '' ||
        state.products.isEmpty ||
        state.total == 0 ||
        state.paymentMethod == null) {
      {
        showMySnackBar(message: "Some feilds are empty", color: Colors.red);
        throw Exception('Customer is required');
      }
    } else {
      addOrder(OrderEntity(
        customer: state.customerEntity!.id,
        items: state.products
            .map((e) => OrderItemEntity(
                id: e.id!,
                quantity: state.quantity.elementAt(state.products.indexOf(e))))
            .toList(),
        total: state.total!,
        discount: state.discount ?? 0,
        tax: state.tax ?? 0,
        paymentMethod: state.paymentMethod ?? 'Cash',
      ));
      clearCart();
      clearCustomer();
    }
  }

  setDiscount(double discount) {
    state = state.copyWith(discount: discount);
  }

  setTax(double tax) {
    state = state.copyWith(tax: tax);
  }

  calculateSubtotal() {
    double subtotal = 0;
    for (int i = 0; i < state.products.length; i++) {
      subtotal += state.products[i].price! * state.quantity[i];
    }
    state = state.copyWith(subtotal: subtotal);
  }

  calculateTotal() {
    double total = state.subtotal ?? 0;
    total -= state.discount ?? 0;
    total += state.tax ?? 0;
    state = state.copyWith(total: total);
  }

  calculateAll() {
    calculateSubtotal();
    calculateTotal();
  }

  setPaymentMethod(String method) {
    state = state.copyWith(paymentMethod: method);
  }

  // void openOrderDetail(order) {
  //   orderNavigator.openOrderDetailView(order);
  // }
}
