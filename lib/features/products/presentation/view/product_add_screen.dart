import 'package:flutter/material.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _qrCodeController = TextEditingController();
  final String _selectedImage = '';

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _skuController.dispose();
    _qrCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Product Price',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Product Description',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Product Quantity',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _skuController,
              decoration: const InputDecoration(
                labelText: 'SKU',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _qrCodeController,
              decoration: const InputDecoration(
                labelText: 'QR Code',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                double price = double.tryParse(_priceController.text) ?? 0.0;
                String description = _descriptionController.text;
                int quantity = int.tryParse(_quantityController.text) ?? 0;
                String sku = _skuController.text;
                String qrCode = _qrCodeController.text;
                ProductEntity newProduct = ProductEntity(
                  name: name,
                  price: price,
                  category: 'Uncategorized',
                  description: description,
                  quantity: quantity,
                  sku: sku,
                  barcode: qrCode,
                  imageUrl: _selectedImage,
                );
                // TODO: Add logic to save the new product
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
