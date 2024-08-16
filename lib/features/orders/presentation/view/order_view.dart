import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/features/orders/presentation/viewmodel/order_view_model.dart';
import 'package:sajilo_sales/features/orders/presentation/widgets/order_detail_view.dart';

class OrderView extends ConsumerWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderViewModelProvider);
    final scrollController = ScrollController();

    if (state.orderEntity.isEmpty && !state.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(orderViewModelProvider.notifier).refreshOrders();
      });
    }
    scrollController.addListener(() {
      if (scrollController.position.extentAfter == 0 &&
          !state.isLoading &&
          !state.hasReachedMax) {
        ref.read(orderViewModelProvider.notifier).getOrders();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            )),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(orderViewModelProvider.notifier).refreshOrders();
        },
        child: ListView.builder(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: state.orderEntity.length + 1,
          itemBuilder: (context, index) {
            if (index == state.orderEntity.length) {
              return state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.hasReachedMax
                      ? const Center(child: Text('No more orders'))
                      : const SizedBox.shrink();
            }
            final order = state.orderEntity[index];
            return Dismissible(
              key: ValueKey(order.id),
              background: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content: const Text(
                          'Are you sure you want to delete this order?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(orderViewModelProvider.notifier)
                                .deleteOrder(order.id!);
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Text(
                    'Order #${order.id!.characters.take(5).toString()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Total: रु${order.total.toString()}"),
                  onTap: () {
                    NavigateRoute.pushRoute(OrderDetailView(order: order));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
