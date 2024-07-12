import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

class ProductTestData {
  ProductTestData._();
  static List<ProductEntity> getProductsTestData() {
    List<ProductEntity> lstProducts = [
      ProductEntity(
        name: "Generic Steel Pants",
        description: "Nemo sed vel est nihil.",
        category: "Refined",
        imageUrl: "products/76f1e37dc3673df5015194e4afd3ff50.jpeg",
        sku: "lime",
      ),
      ProductEntity(
        name: "Sleek Rubber Tuna",
        description:
            "Quia dolore possimus explicabo laudantium facilis unde minima dolorum voluptatum.",
        category: "Incredible",
        imageUrl: "products/0d2b7c702920951b5991c9543d721e5a.jpeg",
        sku: "contingency",
      ),
      ProductEntity(
        name: "Generic Cotton Salad",
        description: "Voluptas molestiae assumenda quam.",
        category: "Licensed",
        imageUrl: "products/fe6e4594ebf356844afa993861d53bcc.jpeg",
        sku: "mesh",
      ),
      ProductEntity(
        name: "Generic Plastic Car",
        description:
            "Sint et reprehenderit rerum dignissimos excepturi itaque quis.",
        category: "Gorgeous",
        imageUrl: "products/19cf7aaed556ffc1240ef137de148867.jpeg",
        sku: "plug-and-play",
      ),
    ];
    return lstProducts;
  }
}
