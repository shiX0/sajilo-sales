import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sajilo_sales/core/common/custom_snackbar.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';
import 'package:sajilo_sales/features/products/presentation/viewmodel/product_view_model.dart';

class ProductAddScreen extends ConsumerStatefulWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends ConsumerState<ProductAddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _qrCodeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final _tagsController = TextEditingController();
  final List<String> categoryList = [
    "Electronics",
    "Clothing",
    "Home & Kitchen",
    "Books",
    "Beauty",
    "Sports & Outdoors",
    "Toys & Games",
    "Automotive",
    "Grocery",
    "Health & Personal Care",
    "Baby",
    "Office Products",
    "Pet Supplies",
    "Industrial & Scientific",
    "Handmade"
  ];
  File? img;

  // check camera permission
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future browseImage(WidgetRef ref, ImageSource imageSource) async {
    checkCameraPermission();
    try {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      if (pickedFile != null) {
        img = File(pickedFile.path);
        setState(() {
          img = img!;
        });
      } else {
        showMySnackBar(message: 'No image selected', color: Colors.red);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final formKey = GlobalKey<FormState>();

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
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // square image container when clicked it will open camera or gallery bottom sheet
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 130,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Camera'),
                                onTap: () {
                                  browseImage(ref, ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text('Gallery'),
                                onTap: () {
                                  browseImage(ref, ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: img != null
                        ? Image.file(
                            img!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.add_a_photo,
                            size: 50,
                          ),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  value: categoryList[0],
                  onChanged: (String? value) {
                    setState(() {
                      _categoryController.text = value!;
                    });
                  },
                  items: categoryList
                      .map((String category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Product Price',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Product Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _skuController,
                  decoration: const InputDecoration(
                    labelText: 'SKU',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a SKU';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _qrCodeController,
                  decoration: const InputDecoration(
                    labelText: 'QR Code',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a QR code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _tagsController,
                  decoration: const InputDecoration(
                    labelText: 'Tags',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a tag';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final product = ProductEntity(
                        name: _nameController.text,
                        category: _categoryController.text,
                        price: double.parse(_priceController.text),
                        description: _descriptionController.text,
                        quantity: int.parse(_quantityController.text),
                        sku: _skuController.text,
                        barcode: _qrCodeController.text,
                        tags: _tagsController.text.split(','),
                        imageUrl: "imageurl",
                      );
                      // call add product usecase
                      ref
                          .read(productViewModelProvider.notifier)
                          .addProduct(product, img!);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
