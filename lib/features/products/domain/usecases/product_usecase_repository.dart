import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';
import 'package:sajilo_sales/features/products/domain/repository/product_repository.dart';

final productUsecaseProvider = Provider<ProductUsecase>((ref) {
  return ProductUsecase(ref.read(productRepositoryProvider));
});

class ProductUsecase {
  final IProductRepository _productRepository;

  ProductUsecase(this._productRepository);

  Future<Either<Failure, List<ProductEntity>>> getAllProduct(int page) {
    return _productRepository.getAllProduct(page);
  }

  Future<Either<Failure, String>> deleteProduct(String id) {
    return _productRepository.deleteProduct(id);
  }
}
