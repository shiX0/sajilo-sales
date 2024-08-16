import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/orders/data/data_source/remote/order_data_source.dart';
import 'package:sajilo_sales/features/orders/domain/entity/order_entity.dart';
import 'package:sajilo_sales/features/orders/domain/repository/order_repository.dart';

final orderRemoteRepositoryProvider = Provider<IOrderRepository>(
    (ref) => OrderRemoteRepository(ref.read(orderDataSourceProvider)));

class OrderRemoteRepository implements IOrderRepository {
  final OrderDataSource _orderDataSource;

  OrderRemoteRepository(this._orderDataSource);

  @override
  Future<Either<Failure, String>> addOrder(OrderEntity order) {
    return _orderDataSource.addOrder(order);
  }

  @override
  Future<Either<Failure, String>> deleteOrder(String id) {
    return _orderDataSource.deleteOrder(id);
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getAllOrder(int page) {
    return _orderDataSource.getAllOrder(page);
  }
}
