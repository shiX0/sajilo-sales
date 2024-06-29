import 'package:flutter/material.dart';
import 'package:sajilo_sales/app/constants/api_endpoint.dart';
import 'package:sajilo_sales/features/products/domain/entity/product_entity.dart';

class CustomProductTile extends StatelessWidget {
  final ProductEntity product;

  const CustomProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 120, // Increased height for the tile
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15), // Radius of 20
            child: SizedBox(
              height: 100, // Adjusted size to fit within the new tile height
              width: 100, // Adjusted size to fit within the new tile height
              child: Image.network(
                ApiEndpoints.imgUrl + product.imageUrl,
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
          const SizedBox(width: 16), // Space between the image and the text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16, // Adjusted font size
                  ),
                ),
                const SizedBox(
                    height: 8), // Space between the title and subtitle
                Text(
                  "Rs.${product.price}",
                  style: const TextStyle(
                    fontSize: 14, // Adjusted font size
                    color: Colors.grey, // Optional: subtitle color
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.category,
                  style: const TextStyle(
                    fontSize: 14, // Adjusted font size
                    color: Colors.grey, // Optional: subtitle color
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
