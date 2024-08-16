import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/orders/domain/entity/order_entity.dart';
import 'package:sajilo_sales/features/products/data/model/product_model.dart';

final orderModelProvider = Provider<OrderModel>((ref) => OrderModel.empty());

class OrderModel extends Equatable {
  final String? id;
  final String? customerId;
  final List<OrderItemModel> items;
  final double total;
  final double tax;
  final double discount;
  final String paymentMethod;

  const OrderModel({
    required this.id,
    required this.customerId,
    required this.items,
    required this.total,
    required this.tax,
    required this.discount,
    required this.paymentMethod,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      customerId: json['customerId'],
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      total: json['total'].toDouble(),
      tax: json['tax'].toDouble(),
      discount: json['discount'].toDouble(),
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'customer': customerId,
      'items': items.map((e) => e.toJson()).toList(),
      'total': total,
      'tax': tax,
      'discount': discount,
      'paymentMethod': paymentMethod,
    };
  }

//  ordermodel empty
  factory OrderModel.empty() {
    return const OrderModel(
      id: '',
      customerId: '',
      items: [],
      total: 0,
      tax: 0,
      discount: 0,
      paymentMethod: '',
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id ?? '',
      customer: customerId ?? "deleted customer",
      items: items.map((e) => e.toEntity()).toList(),
      total: total,
      tax: tax,
      discount: discount,
      paymentMethod: paymentMethod,
    );
  }

  factory OrderModel.fromEntity(OrderEntity order) {
    return OrderModel(
      id: order.id,
      customerId: order.customer,
      items: order.items.map((e) => OrderItemModel.fromEntity(e)).toList(),
      total: order.total,
      tax: order.tax,
      discount: order.discount,
      paymentMethod: order.paymentMethod,
    );
  }

  static List<OrderEntity> toEntityList(List<OrderModel> orders) {
    return orders.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props =>
      [id, customerId, items, total, tax, discount, paymentMethod];
}

class OrderItemModel extends Equatable {
  final String id;
  final int quantity;

  const OrderItemModel({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product': id,
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['product'],
      quantity: json['quantity'],
    );
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      id: id,
      quantity: quantity,
    );
  }

  factory OrderItemModel.fromEntity(OrderItemEntity orderItem) {
    return OrderItemModel(
      id: orderItem.id,
      quantity: orderItem.quantity,
    );
  }

  @override
  List<Object?> get props => [id, quantity];
}
