import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/orders/presentation/viewmodel/order_view_model.dart';
import 'package:sajilo_sales/features/products/presentation/viewmodel/product_view_model.dart';

class ProductSelect extends ConsumerWidget {
  const ProductSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productViewModelProvider);

    return NotificationListener<Notification>(
      onNotification: (notification) {
        ref.read(productViewModelProvider.notifier).getProducts();
        return true;
      },
      child: SizedBox(
        height: 400,
        child: ListView.builder(
          itemCount: state.productList.length,
          itemBuilder: (context, index) {
            final product = state.productList[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text(product.price.toString()),
              onTap: () {
                ref.read(orderViewModelProvider.notifier).addToCart(product, 1);
                Navigator.pop(context);
              },
              tileColor: index % 2 == 0
                  ? Colors.transparent
                  : const Color.fromARGB(29, 255, 255, 255),
            );
          },
        ),
      ),
    );
  }
}
