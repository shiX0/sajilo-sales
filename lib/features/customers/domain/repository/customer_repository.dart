import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/customers/data/repository/customer_remote_repository.dart';
import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';

final customerRepositoryProvider = Provider<ICustomerRepository>((ref) {
  return ref.read(customerRemoteRepositoryProvider);
});

abstract class ICustomerRepository {
  Future<Either<Failure, List<CustomerEntity>>> getAllCustomer(int page);
  Future<Either<Failure, bool>> deleteCustomer(String id);
  Future<Either<Failure, bool>> addCustomer(CustomerEntity customer);
  Future<Either<Failure, bool>> updateCustomer(CustomerEntity customer);
}
