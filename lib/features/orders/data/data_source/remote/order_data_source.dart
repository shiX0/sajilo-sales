import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/constants/api_endpoint.dart';
import 'package:sajilo_sales/core/Networking/remote/http_service.dart';
import 'package:sajilo_sales/core/failure/failure.dart';
import 'package:sajilo_sales/features/orders/data/dto/order_dto.dart';
import 'package:sajilo_sales/features/orders/data/model/order_model.dart';
import 'package:sajilo_sales/features/orders/domain/entity/order_entity.dart';

final orderDataSourceProvider = Provider<OrderDataSource>((ref) {
  return OrderDataSource(
      ref.read(httpServiceProvider), ref.read(orderModelProvider));
});

class OrderDataSource {
  final Dio _dio;
  OrderModel orderModel;
  OrderDataSource(this._dio, this.orderModel);

  Future<Either<Failure, List<OrderEntity>>> getAllOrder(int page) async {
    try {
      final response =
          await _dio.get(ApiEndpoints.getAllOrders, queryParameters: {
        'page': page,
        'limit': 10,
      });
      debugPrint(response.data['orders'].toString());
      List<OrderModel> orders = response.data['orders'].map<OrderModel>((e) {
        return OrderModel.fromJson(e);
      }).toList();
      return Right(OrderModel.toEntityList(orders));
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, String>> deleteOrder(String id) async {
    try {
      await _dio.delete(ApiEndpoints.deleteOrder.replaceFirst("{id}", id));
      return const Right('Success');
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, String>> addOrder(OrderEntity order) async {
    try {
      await _dio.post(ApiEndpoints.createOrder,
          data: OrderModel.fromEntity(order).toJson());
      return const Right('Success');
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
