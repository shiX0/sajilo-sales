import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/core/common/custom_alert.dart';
import 'package:sajilo_sales/core/common/custom_sheet.dart';
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
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blueAccent, Colors.purpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.6),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: Text(
                                customer.name.substring(0, 1),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            customer.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  customer.email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              Text(
                                customer.id!.characters.take(5).toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Phone: ${customer.phone}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          CustomSheet.showBottomSheet(
                            content: CustomerBottomSheet(
                              customer: customer,
                            ),
                          );
                        },
                        child: const Text('Edit'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          CustomAlertDialog.showAlertDialog(
                            title: 'Delete Customer',
                            message:
                                'Are you sure you want to delete this customer?',
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
          ],
        ),
      ),
    );
  }
}
