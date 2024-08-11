import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/products/data/data_source/remote/product_data_source.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';
import 'package:sajilo_sales/features/products/domain/repository/product_repository.dart';

final productRemoteRepositoryProvider = Provider<IProductRepository>(
    (ref) => ProductRemoteRepository(ref.read(productDataSourceProvider)));

class ProductRemoteRepository implements IProductRepository {
  final ProductDataSource _productDataSource;

  ProductRemoteRepository(this._productDataSource);
  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProduct(int page) {
    return _productDataSource.getAllProduct(page);
  }

  @override
  Future<Either<Failure, String>> deleteProduct(String id) {
    return _productDataSource.deleteProduct(id);
  }
}
