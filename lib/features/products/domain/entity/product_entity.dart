class ProductEntity {
  String? id;
  String name;
  String description;
  String category;
  String? barcode;
  String? unit;
  double? price;
  int? quantity;
  String imageUrl;
  String? brand;
  String sku;
  List<String>? tags;

  ProductEntity(
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
}
