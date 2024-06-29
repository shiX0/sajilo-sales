import 'package:json_annotation/json_annotation.dart';
import 'package:sajilo_sales/features/products/data/model/product_model.dart';
part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  final bool success;
  final String message;
  final List<ProductModel> products;

  ProductDto({
    required this.success,
    required this.message,
    required this.products,
  });

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
}
