import 'package:craftify_vendor/common/form_field_features.dart';
import 'package:craftify_vendor/screens/products/product_Provider.dart';
import 'package:craftify_vendor/screens/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                  onChanged: (value) {
                    productProvider.setSearchQuery(
                        value); // Using provider for state management
                  },
                  decoration: textFormFieldDecoration(
                      hinttext: "Search Products...",
                      prefixIcon: Icons.search)),
            ),

            // Product List
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await productProvider.fetchProducts(context);
                },
                child: Consumer<ProductProvider>(
                  builder: (context, provider, _) {
                    final filteredProducts = provider.filteredProducts;

                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return filteredProducts.isEmpty
                        ? const Center(
                            child: Text(
                              "No products found",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) => ProductCard(
                              product: filteredProducts[index],
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/productDetails',
                                arguments: filteredProducts[index],
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
