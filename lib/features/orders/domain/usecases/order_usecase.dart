import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/orders/domain/entity/order_entity.dart';
import 'package:sajilo_sales/features/orders/domain/repository/order_repository.dart';

final orderUsecaseProvider = Provider<OrderUsecase>((ref) {
  return OrderUsecase(ref.read(orderRepositoryProvider));
});

class OrderUsecase {
  final IOrderRepository _iOrderRepository;

  OrderUsecase(this._iOrderRepository);

  Future<Either<Failure, List<OrderEntity>>> getAllOrder(int page) {
    return _iOrderRepository.getAllOrder(page);
  }

  Future<Either<Failure, String>> deleteOrder(String id) {
    return _iOrderRepository.deleteOrder(id);
  }

  Future<Either<Failure, String>> addOrder(OrderEntity order) {
    return _iOrderRepository.addOrder(order);
  }
}
