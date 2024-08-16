import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

class OrderEntity {
  final String? id;
  final String? customer;
  final List<OrderItemEntity> items;
  final double total;
  final double tax;
  final double discount;
  final String paymentMethod;

  const OrderEntity({
    this.id,
    this.customer,
    required this.items,
    required this.total,
    required this.tax,
    required this.discount,
    required this.paymentMethod,
  });
}

class OrderItemEntity {
  final String id;
  final int quantity;

  const OrderItemEntity({
    required this.id,
    required this.quantity,
  });
}
