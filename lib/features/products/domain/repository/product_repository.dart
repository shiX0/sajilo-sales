import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/products/data/repository/product_remote_repository.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

final productRepositoryProvider = Provider<IProductRepository>((ref) {
  return ref.read(productRemoteRepositoryProvider);
});

abstract class IProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProduct(int page);
  Future<Either<Failure, String>> deleteProduct(String id);
}
