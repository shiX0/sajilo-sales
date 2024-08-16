import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/core/common/custom_sheet.dart';
import 'package:sajilo_sales/features/customers/presentation/viewmodel/customer_view_model.dart';
import 'package:sajilo_sales/features/customers/presentation/widgets/customer_bottomsheet.dart';
import 'package:sajilo_sales/features/customers/presentation/widgets/customer_detail_view.dart';

class CustomerView extends ConsumerWidget {
  CustomerView({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customerViewModelProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[200]!, Colors.purple[200]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "All Customers",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.person_add_alt_1),
                    label: const Text("Add Customer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      CustomSheet.showBottomSheet(
                        content: const CustomerBottomSheet(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          NotificationListener(
            onNotification: (notification) {
              if (_scrollController.position.extentAfter == 0) {
                ref.read(customerViewModelProvider.notifier).getCustomers();
              }
              return false;
            },
            child: Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await ref
                      .read(customerViewModelProvider.notifier)
                      .refreshCustomers();
                },
                child: ListView.separated(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.customers.length + 1,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == state.customers.length) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }

                    final customer = state.customers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(
                          customer.name.isNotEmpty
                              ? customer.name[0].toUpperCase()
                              : '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(customer.name),
                      subtitle: Text(customer.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {
                          NavigateRoute.pushRoute(
                              CustomerDetailView(customer: customer));
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
