import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/constants/api_endpoint.dart';
import 'package:sajilo_sales/core/Networking/remote/http_service.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/customers/data/model/customer_model.dart';
import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';

final customerDataSourceProvider = Provider<CustomerDataSource>((ref) {
  return CustomerDataSource(
      ref.read(httpServiceProvider), ref.read(customerModelProvider));
});

class CustomerDataSource {
  final Dio _dio;
  CustomerModel customerModel;
  CustomerDataSource(this._dio, this.customerModel);

  Future<Either<Failure, List<CustomerEntity>>> getCustomers(int page) async {
    try {
      final Response response = await _dio.get(ApiEndpoints.getAllCustomers,
          queryParameters: {'page': page, 'limit': ApiEndpoints.limit});
      if (response.statusCode == 200) {
        final customers = customerModel.toEntities(response.data);
        if (customers.isEmpty) {
          return Left(Failure(error: "No customers found"));
        }
        return Right(customers);
      } else if (response.statusCode == 404) {
        return Left(Failure(error: "Customers not found"));
      } else {
        return Left(Failure(
            error:
                "Failed to load customers. Status code: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(Failure(error: "Error fetching customers: ${e.toString()}"));
    }
  }

  Future<Either<Failure, bool>> createCustomer(CustomerEntity customer) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.createCustomer,
        data: customerModel.fromEntity(customer),
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(Failure(error: 'Failed to create customer'));
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> updateCustomer(CustomerEntity customer) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.updateCustomer.replaceFirst('{id}', customer.id!),
        data: customerModel.fromEntity(customer),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(error: 'Failed to update customer'));
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteCustomer(String id) async {
    try {
      final response = await _dio
          .delete(ApiEndpoints.deleteCustomer.replaceFirst('{id}', id));
      if (response.statusCode == 204) {
        return const Right(true);
      } else {
        return Left(Failure(error: 'Failed to delete customer'));
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
