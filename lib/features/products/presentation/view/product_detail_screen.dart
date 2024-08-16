import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/constants/api_endpoint.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/core/common/custom_snackbar.dart';
import 'package:sajilo_sales/features/orders/presentation/viewmodel/order_view_model.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                ApiEndpoints.imgUrl + product.imageUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.brand ?? 'Unknown Brand',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(product.description),
                    const SizedBox(height: 16),
                    _buildInfoRow('Category', product.category),
                    _buildInfoRow('SKU', product.sku),
                    _buildInfoRow('Barcode', product.barcode ?? 'N/A'),
                    _buildInfoRow('Unit', product.unit ?? 'N/A'),
                    _buildInfoRow(
                        'Price',
                        product.price != null
                            ? 'रु${product.price!.toStringAsFixed(2)}'
                            : 'N/A'),
                    _buildInfoRow(
                        'Quantity', product.quantity?.toString() ?? 'N/A'),
                    const SizedBox(height: 16),
                    if (product.tags != null && product.tags!.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.tags!
                            .map((tag) => Chip(label: Text(tag)))
                            .toList(),
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(orderViewModelProvider.notifier)
                      .addToCart(product, 1);
                  showMySnackBar(message: "Added to cart");
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40, // Adjust top position if needed
            left: 16,
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                NavigateRoute.pop();
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
