import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';
part 'product_model.g.dart';

final productModelProvider =
    Provider<ProductModel>((ref) => ProductModel.empty());

@JsonSerializable()
class ProductModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String description;
  final String category;
  final String? barcode;
  final String? unit;
  final double? price;
  final int? quantity;
  final String imageUrl;
  final String? brand;
  final String sku;
  final List<String>? tags;

  const ProductModel(
      {this.id,
      required this.name,
      required this.description,
      required this.category,
      this.barcode,
      this.unit,
      this.price,
      this.quantity,
      required this.imageUrl,
      this.brand,
      required this.sku,
      this.tags});

  ProductModel.empty()
      : id = "",
        name = "",
        description = "",
        category = "",
        barcode = "",
        unit = "",
        price = 0,
        quantity = 0,
        imageUrl = "",
        brand = "",
        sku = "",
        tags = List.empty();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity(ProductModel product) {
    return ProductEntity(
        name: product.name,
        description: product.description,
        category: product.category,
        imageUrl: product.imageUrl,
        sku: product.sku,
        id: product.id,
        barcode: product.barcode,
        unit: product.unit,
        price: product.price,
        quantity: product.quantity,
        brand: product.brand,
        tags: product.tags);
  }

  List<ProductEntity> toEntityList(List<ProductModel> productList) {
    return productList.map((product) => product.toEntity(product)).toList();
  }

  //  factory from entity
  factory ProductModel.fromEntity(ProductEntity product) {
    return ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        category: product.category,
        imageUrl: product.imageUrl,
        sku: product.sku,
        barcode: product.barcode,
        unit: product.unit,
        price: product.price,
        quantity: product.quantity,
        brand: product.brand,
        tags: product.tags);
  }
  @override
  List<Object?> get props => [
        name,
        id,
        description,
        category,
        imageUrl,
        sku,
        id,
        barcode,
        unit,
        price,
        quantity,
        brand,
        tags
      ];
}
