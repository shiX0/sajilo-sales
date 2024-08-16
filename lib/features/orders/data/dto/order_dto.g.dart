// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
      orderModel: (json['order'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
      'order': instance.orderModel,
    };
