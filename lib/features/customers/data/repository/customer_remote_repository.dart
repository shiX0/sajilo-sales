import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/customers/data/data_source/remote/customer_data_source.dart';
import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';
import 'package:sajilo_sales/features/customers/domain/repository/customer_repository.dart';

final customerRemoteRepositoryProvider = Provider<ICustomerRepository>(
    (ref) => CustomerRemoteRepository(ref.read(customerDataSourceProvider)));

class CustomerRemoteRepository extends ICustomerRepository {
  final CustomerDataSource _customerDataSource;

  CustomerRemoteRepository(this._customerDataSource);
  @override
  Future<Either<Failure, bool>> addCustomer(CustomerEntity customer) {
    return _customerDataSource.createCustomer(customer);
  }

  @override
  Future<Either<Failure, bool>> deleteCustomer(String id) {
    return _customerDataSource.deleteCustomer(id);
  }

  @override
  Future<Either<Failure, List<CustomerEntity>>> getAllCustomer(int page) {
    return _customerDataSource.getCustomers(page);
  }

  @override
  Future<Either<Failure, bool>> updateCustomer(CustomerEntity customer) {
    return _customerDataSource.updateCustomer(customer);
  }
}
