import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/customers/presentation/viewmodel/customer_view_model.dart';
import 'package:sajilo_sales/features/orders/presentation/viewmodel/order_view_model.dart';

class CustomerSelect extends ConsumerWidget {
  const CustomerSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customerViewModelProvider);

    return NotificationListener<Notification>(
      onNotification: (notification) {
        ref.read(customerViewModelProvider.notifier).getCustomers();
        return true;
      },
      child: SizedBox(
        height: 300,
        child: ListView.builder(
            itemCount: state.customers.length,
            itemBuilder: (context, index) {
              final customer = state.customers[index];
              return ListTile(
                title: Text(customer.name),
                subtitle: Text(customer.email),
                onTap: () {
                  ref
                      .read(orderViewModelProvider.notifier)
                      .addCustomer(customer);
                  Navigator.pop(context);
                },
                tileColor: index % 2 == 0
                    ? Colors.transparent
                    : const Color.fromARGB(29, 255, 255, 255),
              );
            }),
      ),
    );
  }
}
