import 'package:flutter/material.dart';
import 'package:sajilo_sales/features/orders/domain/entity/order_entity.dart';

class OrderDetailView extends StatelessWidget {
  final OrderEntity order;
  const OrderDetailView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensures the height is minimal
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invoice #${order.id}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Date: 06/08/2024',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Invoice Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...order.items.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${e.id} x ${e.quantity}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 32),
                  _invoiceSummaryRow('Subtotal',
                      'रु${order.total - order.tax + order.discount}'),
                  _invoiceSummaryRow(
                      'Tax', 'रु${order.tax.toStringAsFixed(2)}'),
                  _invoiceSummaryRow(
                      'Discount', '-रु${order.discount.toStringAsFixed(2)}'),
                  const Divider(height: 32),
                  _invoiceSummaryRow(
                    'Total',
                    'रु${order.total.toStringAsFixed(2)}',
                    isBold: true,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Customer Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _customerInfoRow('Customer', order.customer!),
                  // _customerInfoRow('Email', order.email),
                  // _customerInfoRow('Phone', order.phone),
                  const Divider(height: 32),
                  const Text(
                    'Payment Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    order.paymentMethod,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateTime.now().toString(),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _invoiceSummaryRow(String title, String amount,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customerInfoRow(String title, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            info,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
