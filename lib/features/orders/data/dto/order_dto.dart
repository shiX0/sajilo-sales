import 'package:json_annotation/json_annotation.dart';
import 'package:sajilo_sales/features/orders/data/model/order_model.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  @JsonKey(name: 'order')
  final List<OrderModel> orderModel;

  OrderDto({required this.orderModel});

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
}
