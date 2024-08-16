import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/orders/data/repository/order_remote_repository.dart';
import 'package:sajilo_sales/features/orders/domain/entity/order_entity.dart';

final orderRepositoryProvider = Provider<IOrderRepository>((ref) {
  return ref.read(orderRemoteRepositoryProvider);
});

abstract class IOrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getAllOrder(int page);
  Future<Either<Failure, String>> deleteOrder(String id);
  Future<Either<Failure, String>> addOrder(OrderEntity order);
}