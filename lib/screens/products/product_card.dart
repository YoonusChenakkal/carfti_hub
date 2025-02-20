import 'package:craftify_vendor/screens/products/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double offerPrice = product.offerPrice ?? 0.0;
    double price = (product.price) ?? 0.0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Adjusted container height from 200 to 150
            SizedBox(
                height: 150, // Changed to 150 to prevent overflow
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: product.imageUrls.isNotEmpty
                        ? Image.network(
                            product.imageUrls[0].productImage,
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                            errorBuilder: (_, __, ___) => const Center(
                                child: Icon(
                              Icons.broken_image,
                              size: 60,
                              color: Colors.grey,
                            )),
                          )
                        : const Center(
                            child: Icon(
                            Icons.image_not_supported,
                            size: 60,
                            color: Colors.grey,
                          )),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.vendorName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹${offerPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (offerPrice < price)
                            Text(
                              '₹${price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      // Adjusted IconButton size to reduce space
                      IconButton(
                        iconSize: 24, // Smaller icon
                        constraints: BoxConstraints(
                          maxHeight: 36, // Reduced button size
                          maxWidth: 36,
                        ),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => '',
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
