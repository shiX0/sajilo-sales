import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';
import 'package:sajilo_sales/features/customers/domain/repository/customer_repository.dart';

final customerUsecaseProvider = Provider<CustomerUsecase>((ref) {
  return CustomerUsecase(ref.read(customerRepositoryProvider));
});

class CustomerUsecase {
  final ICustomerRepository repository;

  CustomerUsecase(this.repository);

  Future<Either<Failure, List<CustomerEntity>>> getAllCustomer(int page) {
    return repository.getAllCustomer(page);
  }

  Future<Either<Failure, bool>> deleteCustomer(String id) {
    return repository.deleteCustomer(id);
  }

  Future<Either<Failure, bool>> addCustomer(CustomerEntity customer) {
    return repository.addCustomer(customer);
  }

  Future<Either<Failure, bool>> updateCustomer(CustomerEntity customer) {
    return repository.updateCustomer(customer);
  }
}
