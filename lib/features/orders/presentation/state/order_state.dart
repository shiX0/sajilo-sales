import 'package:dartz/dartz.dart';
import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';
import 'package:sajilo_sales/features/orders/data/model/order_model.dart';
import 'package:sajilo_sales/features/orders/domain/entity/order_entity.dart';
import 'package:sajilo_sales/features/products/data/model/product_model.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

class OrderState {
  final bool isLoading;
  final List<OrderModel> orders;
  final List<OrderEntity> orderEntity;
  final String error;
  final bool hasReachedMax;
  final String searchQuery = '';
  final int page;
  // for cart
  final List<ProductEntity> products;
  CustomerEntity? customerEntity;
  List<int> quantity = [];
  double? total;
  double? discount;
  double? tax;
  double? subtotal;
  String? paymentMethod;

  OrderState(
      {this.products = const [],
      this.isLoading = false,
      this.orders = const [],
      this.hasReachedMax = false,
      this.page = 1,
      this.orderEntity = const [],
      this.quantity = const [],
      this.customerEntity,
      this.discount,
      this.tax,
      this.total,
      this.paymentMethod,
      this.subtotal,
      this.error = ''});

  OrderState copyWith(
      {bool? isLoading,
      List<OrderModel>? orders,
      String? error,
      bool? hasReachedMax,
      int? page,
      CustomerEntity? customerEntity,
      List<OrderEntity>? orderEntity,
      List<int>? quantity,
      double? total,
      double? discount,
      String? paymentMethod,
      double? tax,
      double? subtotal,
      bool removeCustomerEntity = false,
      List<ProductEntity>? products}) {
    return OrderState(
        isLoading: isLoading ?? this.isLoading,
        orders: orders ?? this.orders,
        products: products ?? this.products,
        quantity: quantity ?? this.quantity,
        customerEntity:
            removeCustomerEntity ? null : customerEntity ?? this.customerEntity,
        page: page ?? this.page,
        orderEntity: orderEntity ?? this.orderEntity,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        total: total ?? this.total,
        discount: discount ?? this.discount,
        tax: tax ?? this.tax,
        subtotal: subtotal ?? this.subtotal,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        error: error ?? this.error);
  }
}
