import 'package:craftify_vendor/common/button.dart';
import 'package:craftify_vendor/common/custom%20_app_bar.dart';
import 'package:craftify_vendor/screens/products/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    ProductModel product = args as ProductModel;
    print(
      product.imageUrls.length,
    );

    final double originalPrice = double.parse(product.price);
    final double savings = originalPrice - double.parse(product.offerPrice);
    final bool hasDiscount = double.parse(product.offerPrice) < originalPrice;

    return Scaffold(
      appBar: customAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Product Image Carousel
                  SizedBox(
                    height: 300,
                    child: product.imageUrls.isNotEmpty
                        ? PageView.builder(
                            itemCount: product.imageUrls.length,
                            itemBuilder: (_, index) => Image.network(
                              product.imageUrls[index].productImage,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                              errorBuilder: (_, __, ___) => const Center(
                                  child: Icon(
                                Icons.broken_image,
                                size: 100,
                                color: Colors.grey,
                              )),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  // Product Details
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Row(
                          children: [
                            Text(
                              product.productName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                // : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'In Stock',
                                // : 'Out Of Stock',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  // : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Price Section
                        Row(
                          children: [
                            Text(
                              '₹${product.offerPrice}',
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '/ ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        // Savings and Discount
                        if (hasDiscount) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '₹${product.price}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Save ₹${savings.toStringAsFixed(2)} (${product.discount}% off)',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),
                        // Product Description
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.productDescription,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add to Cart Bar
          Padding(
              padding: EdgeInsets.all(15),
              child: customButton(
                  onPressed: () {},
                  buttonName: 'Edit Product',
                  color: Colors.cyan))
        ],
      ),
    );
  }

  Widget _buildAddToCartBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'ADD TO CART',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
