import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/auth/presentation/widget/custom_formfield.dart';
import 'package:sajilo_sales/features/products/presentation/viewmodel/product_view_model.dart';
import 'package:sajilo_sales/features/products/presentation/widgets/custom_product_tile.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();

  Future<bool?> showConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModelProvider);

    return NotificationListener(
      onNotification: (notification) {
        if (_scrollController.position.extentAfter == 0) {
          ref.read(productViewModelProvider.notifier).getProducts();
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomFormField(
                  icon: const Icon(Icons.search),
                  inputType: TextInputType.text,
                  textEditingController: textEditingController,
                  labelText: 'Search',
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'All Products',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(productViewModelProvider.notifier)
                        .refreshProducts();
                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    controller: _scrollController,
                    itemCount: state.productList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = state.productList[index];
                      return Dismissible(
                        key: ValueKey(
                            product.id), // Use a unique key for each item
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          final result = await showConfirmDialog(context);
                          if (result == true) {
                            ref
                                .read(productViewModelProvider.notifier)
                                .deleteProduct(product.id!);
                          }
                          return result;
                        },
                        child: CustomProductTile(product: product),
                      );
                    },
                  ),
                ),
              ),
              if (state.isLoading)
                const CircularProgressIndicator(color: Colors.red),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    ref
                        .read(productViewModelProvider.notifier)
                        .openAddProductView();
                  },
                  child: const Text('Add Product')),
            ],
          ),
        ),
      ),
    );
  }
}
