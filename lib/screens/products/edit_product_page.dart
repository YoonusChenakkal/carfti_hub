import 'package:craftify_vendor/common/button.dart';
import 'package:craftify_vendor/common/custom_app_bar.dart';
import 'package:craftify_vendor/common/form_field_features.dart';
import 'package:craftify_vendor/screens/products/category_dialog_box.dart';
import 'package:craftify_vendor/screens/products/category_model.dart';
import 'package:craftify_vendor/screens/products/offer_dialog_box.dart';
import 'package:craftify_vendor/screens/products/product_Provider.dart';
import 'package:craftify_vendor/screens/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    ProductModel product = args as ProductModel;

    final _formKey = GlobalKey<FormState>();
    final productProvider = Provider.of<ProductProvider>(context);

    productProvider.tcProductName.text = product.productName;
    productProvider.tcProductDescription.text = product.productDescription;
    productProvider.selectedCategory = CategoryModel(
      id: product.category,
      categoryName: product.categoryName,
      categoryImage: '',
      createdAt: '',
    );

    productProvider.tcPrice.text = product.price.toString();
    productProvider.tcOfferPrice.text = product.offerPrice.toString();
    productProvider.isOfferProduct = product.isOfferProduct;
    productProvider.isPopular = product.popularProducts;
    productProvider.isNewArrival = product.newArrival;
    productProvider.isTrending = product.trendingOne;

    String getSelectedOffers(ProductProvider productProvider) {
      List<String> selectedOffers = [];
      if (productProvider.isOfferProduct) selectedOffers.add('Offer Product');
      if (productProvider.isPopular) selectedOffers.add('Popular Product');
      if (productProvider.isNewArrival) selectedOffers.add('New Arrival');
      if (productProvider.isTrending) selectedOffers.add('Trending Product');
      return selectedOffers.isNotEmpty ? selectedOffers.join(', ') : 'Select';
    }

    return Scaffold(
      appBar: customAppBar(title: 'Edit Product Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 5.h),

                // Product Name
                TextFormField(
                  controller: productProvider.tcProductName,
                  validator: emptyCheckValidator,
                  decoration: textFormFieldDecoration(
                    hinttext: 'Product Name',
                    prefixIcon: Icons.production_quantity_limits_outlined,
                  ),
                ),
                SizedBox(height: 1.h),

                // Product Description
                TextFormField(
                  controller: productProvider.tcProductDescription,
                  validator: emptyCheckValidator,
                  decoration: textFormFieldDecoration(
                    hinttext: 'Product Description',
                    prefixIcon: Icons.description_outlined,
                  ),
                ),
                SizedBox(height: 1.h),

                // Price
                TextFormField(
                  controller: productProvider.tcPrice,
                  keyboardType: TextInputType.number,
                  validator: emptyCheckValidator,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: textFormFieldDecoration(
                    hinttext: 'Price',
                    prefixIcon: Icons.currency_rupee,
                  ),
                ),
                SizedBox(height: 1.h),

                // Offer Price
                TextFormField(
                  controller: productProvider.tcOfferPrice,
                  validator: emptyCheckValidator,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: textFormFieldDecoration(
                    hinttext: 'Offer Price',
                    prefixIcon: Icons.currency_exchange_rounded,
                  ),
                ),
                SizedBox(height: 1.h),

                // Select Category
                InkWell(
                  onTap: () async {
                    if (!productProvider.isLoading) {
                      await productProvider.fetchCategories(context);
                      showCategoryDialog(context);
                    }
                  },
                  child: TextFormField(
                    enabled: false,
                    decoration: textFormFieldDecoration(
                      hinttext: productProvider.isLoading
                          ? 'Fetching Categories...'
                          : productProvider.selectedCategory?.categoryName ??
                              'Select Category',
                      prefixIcon: Icons.category_outlined,
                    ),
                  ),
                ),

                SizedBox(height: 1.h),

                // Select Offers
                InkWell(
                  onTap: () {
                    showOfferDialogBox(context);
                  },
                  child: TextFormField(
                    enabled: false,
                    decoration: textFormFieldDecoration(
                      hinttext: getSelectedOffers(productProvider),
                      prefixIcon: Icons.local_offer_outlined,
                    ),
                  ),
                ),

                SizedBox(height: 3.h),

                // Update Product Button
                customButton(
                  isLoading: productProvider.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      productProvider.updateProduct(product.id, context);
                    }
                  },
                  buttonName: 'Update Product',
                  color: Colors.cyan,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showOfferDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return OfferDialogBox();
      },
    );
  }

  void showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategoryDialogBox();
      },
    );
  }
}
