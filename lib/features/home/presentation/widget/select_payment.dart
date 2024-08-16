// sleect payment option widget
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:sajilo_sales/features/orders/presentation/viewmodel/order_view_model.dart';

class SelectPayment extends ConsumerWidget {
  const SelectPayment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> paymentOptions = [
      'Cash',
      'Credit Card',
      'Debit Card',
      'Mobile Payment'
    ];
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          const Text(
            'Select Payment Method',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: paymentOptions.length,
              itemBuilder: (context, index) {
                final paymentOption = paymentOptions[index];
                return ListTile(
                  title: Text(paymentOption),
                  onTap: () {
                    ref
                        .read(orderViewModelProvider.notifier)
                        .setPaymentMethod(paymentOption);
                    Navigator.pop(context);
                  },
                  tileColor: index % 2 == 0
                      ? Colors.transparent
                      : const Color.fromARGB(29, 255, 255, 255),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
