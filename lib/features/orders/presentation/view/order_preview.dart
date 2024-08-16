import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/core/common/custom_sheet.dart';
import 'package:sajilo_sales/features/home/presentation/widget/customer_select.dart';
import 'package:sajilo_sales/features/home/presentation/widget/select_payment.dart';
import 'package:sajilo_sales/features/orders/presentation/viewmodel/order_view_model.dart';
import 'package:sajilo_sales/features/orders/presentation/widgets/custom_product_widget.dart';

class OrderPreview extends ConsumerWidget {
  const OrderPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderViewModelProvider);
    final subtotal = state.subtotal ?? 0;
    final discount = state.discount ?? 0;
    final tax = state.tax ?? 0;
    final total = state.total ?? 0;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: false,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              if (state.customerEntity != null)
                ListTile(
                  title: Text(state.customerEntity!.name),
                  subtitle: Text(state.customerEntity!.email),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      ref.read(orderViewModelProvider.notifier).clearCustomer();
                    },
                  ),
                )
              else
                GestureDetector(
                  onTap: () {
                    CustomSheet.showBottomSheet(
                        content: const CustomerSelect());
                  },
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Add Customer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              const Text(
                'Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (state.products.isEmpty)
                const Text(
                  'No products added',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              else
                SizedBox(
                  height: 200, // Set a specific height of 200
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomProductWidget(
                            product: product,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Subtotal:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtotal.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discount:',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                  Text(
                    discount.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tax:',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red[800]),
                  ),
                  Text(
                    tax.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    total.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Button for opening payment dialog
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    CustomSheet.showBottomSheet(content: const SelectPayment());
                  },
                  label: Text(
                    state.paymentMethod ?? 'Payment',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  icon: const Icon(Icons.payment),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    //  Remove cart logic here
                    ref.read(orderViewModelProvider.notifier).clearCart();
                  },
                  label: const Text(
                    'Remove Cart',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  icon: const Icon(Icons.delete_rounded),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      //  Checkout logic here
                      ref.read(orderViewModelProvider.notifier).prepareOrder();
                      NavigateRoute.pop();
                    },
                    icon: const Icon(Icons.shopping_cart_checkout_rounded),
                    label: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ),
            ],
          ),
        )));
  }
}
