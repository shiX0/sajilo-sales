import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/customers/presentation/viewmodel/customer_view_model.dart';

class CustomerView extends ConsumerStatefulWidget {
  const CustomerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerViewState();
}

class _CustomerViewState extends ConsumerState<CustomerView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(customerViewModelProvider.notifier).refreshCustomers();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(customerViewModelProvider.notifier).refreshCustomers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerViewModelProvider);
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 160,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Customers"),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
            child: Center(
              child: Text('Scroll to see the SliverAppBar in effect.'),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
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
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                height: 100.0,
                child: Center(
                  child: Text(customer.name,
                      textScaler: const TextScaler.linear(5)),
                ),
              );
            },
            childCount: state.customers.length + 1,
          ),
        ),
      ],
    );
  }
}
