// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      barcode: json['barcode'] as String?,
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String,
      brand: json['brand'] as String?,
      sku: json['sku'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'barcode': instance.barcode,
      'unit': instance.unit,
      'price': instance.price,
      'quantity': instance.quantity,
      'imageUrl': instance.imageUrl,
      'brand': instance.brand,
      'sku': instance.sku,
      'tags': instance.tags,
    };
