import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/features/auth/presentation/widget/custom_formfield.dart';
import 'package:sajilo_sales/features/products/presentation/viewmodel/product_view_model.dart';
import 'package:sajilo_sales/features/products/presentation/widgets/custom_product_tile.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModelProvider);
    var textEditingController = TextEditingController();
    return NotificationListener(
      onNotification: (notifivation) {
        if (_scrollController.position.extentAfter == 0) {
          ref.read(productViewModelProvider.notifier).getProducts();
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomFormField(
                  icon: const Icon(Icons.search),
                  inputType: TextInputType.text,
                  textEditingController: textEditingController,
                  labelText: 'Search',
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  controller: _scrollController,
                  itemCount: state.productList.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = state.productList[index];
                    return CustomProductTile(product: product);
                  },
                ),
              ),
              if (state.isLoading)
                const CircularProgressIndicator(color: Colors.red),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
