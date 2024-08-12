import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/core/common/custom_alert.dart';
import 'package:sajilo_sales/features/customers/domain/entity/customerENtity.dart';
import 'package:sajilo_sales/features/customers/presentation/viewmodel/customer_view_model.dart';
import 'package:sajilo_sales/features/customers/presentation/widgets/customer_bottomsheet.dart';

class CustomerDetailView extends ConsumerWidget {
  final CustomerEntity customer;

  const CustomerDetailView({super.key, required this.customer});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                customer.name.substring(0, 1),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${customer.name}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${customer.email}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone: ${customer.phone}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    CustomerBottomSheet(customer: customer);
                  },
                  child: const Text('Edit'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    CustomAlertDialog.showAlertDialog(
                      title: 'Delete Customer',
                      message: 'Are you sure you want to delete this customer?',
                      onConfirm: () {
                        ref
                            .read(customerViewModelProvider.notifier)
                            .deleteCustomer(customer.id!);
                        NavigateRoute.pop();
                      },
                    );
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
