import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/constants/api_endpoint.dart';
import 'package:sajilo_sales/features/orders/presentation/viewmodel/order_view_model.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';
import 'package:sajilo_sales/features/products/presentation/viewmodel/product_view_model.dart';

class CustomProductWidget extends ConsumerStatefulWidget {
  final ProductEntity product;
  const CustomProductWidget({super.key, required this.product});

  @override
  ConsumerState<CustomProductWidget> createState() =>
      _CustomProductWidgetState();
}

class _CustomProductWidgetState extends ConsumerState<CustomProductWidget> {
  int itemCount = 1;

  void incrementCount() {
    setState(() {
      itemCount++;
    });
    ref
        .read(orderViewModelProvider.notifier)
        .editQuantity(widget.product, itemCount);
  }

  void decrementCount() {
    if (itemCount > 1) {
      setState(() {
        itemCount--;
      });
      ref
          .read(orderViewModelProvider.notifier)
          .editQuantity(widget.product, itemCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                ApiEndpoints.imgUrl + widget.product.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  // make it wrap in first line
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "रु.${widget.product.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.product.category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: decrementCount,
                icon: const Icon(Icons.remove),
              ),
              Text(
                '$itemCount',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: incrementCount,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
