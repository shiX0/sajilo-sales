import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/constants/api_endpoint.dart';
import 'package:sajilo_sales/core/Networking/remote/http_service.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/products/data/dto/product_dto.dart';
import 'package:sajilo_sales/features/products/data/model/product_model.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

final productDataSourceProvider = Provider<ProductDataSource>((ref) {
  return ProductDataSource(
      ref.read(httpServiceProvider), ref.read(productModelProvider));
});

class ProductDataSource {
  final Dio _dio;
  ProductModel productModel;

  ProductDataSource(this._dio, this.productModel);

  Future<Either<Failure, List<ProductEntity>>> getAllProduct(int page) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getProduct,
        queryParameters: {
          'page': page,
          'limit': ApiEndpoints.limit,
        },
      );
      ProductDto getAllProductDto = ProductDto.fromJson(response.data);
      return Right(productModel.toEntityList(getAllProductDto.products));
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
