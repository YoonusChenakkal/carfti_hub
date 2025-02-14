import 'package:craftify_vendor/common/button.dart';
import 'package:craftify_vendor/common/custom%20_app_bar.dart';
import 'package:craftify_vendor/common/flush_bar.dart';
import 'package:craftify_vendor/common/form_field_features.dart';
import 'package:craftify_vendor/screens/products/category_model.dart';
import 'package:craftify_vendor/screens/products/offer_dialog_box.dart';
import 'package:craftify_vendor/screens/products/image_pick_section.dart';
import 'package:craftify_vendor/screens/products/product_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final productProvider = Provider.of<ProductProvider>(
      context,
    );
    String getSelectedOffers(ProductProvider productProvider) {
      List<String> selectedOffers = [];

      if (productProvider.isOfferProduct) selectedOffers.add('Offer Product');
      if (productProvider.isPopular) selectedOffers.add('Popular Product');
      if (productProvider.isNewArrival) selectedOffers.add('New Arrival');
      if (productProvider.isTrending) selectedOffers.add('Trending Product');

      return selectedOffers.isNotEmpty ? selectedOffers.join(', ') : 'Select';
    }

    return Scaffold(
      appBar:customAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 2.h),

                // Image Upload Section
                ImagePickSection(),

                SizedBox(height: 3.h),

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
                      await productProvider.fetchCategories(
                          context); // Fetch categories before opening the dialog
                      showCategoryDialog(context);
                    }
                  },
                  child: TextFormField(
                    enabled: false,
                    decoration: textFormFieldDecoration(
                      hinttext: productProvider.isLoading
                          ? 'Fetching Categories...'
                          : (productProvider.selectedCategory == null
                              ? 'Select Category'
                              : productProvider.selectedCategory!.categoryName),
                      prefixIcon: Icons.category_outlined,
                    ),
                  ),
                ),

                SizedBox(height: 1.h),

                // selct  Offers
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

                // Add Product Button
                customButton(
                  isLoading: productProvider.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (productProvider.selectedImages.isEmpty) {
                        showFlushbar(
                          context: context,
                          color: Colors.red,
                          icon: Icons.image_not_supported,
                          message: 'Please select at least one product image',
                        );
                        return;
                      } else if (productProvider.selectedCategory == null) {
                        showFlushbar(
                          context: context,
                          color: Colors.red,
                          icon: Icons.category_rounded,
                          message: 'Please select Category',
                        );
                      } else {
                        productProvider.addProduct(context);
                      }
                    }
                  },
                  buttonName: 'Add Product',
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
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Category"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<CategoryModel>(
                value: null,
                hint: Text("Choose a Category"),
                items: productProvider.categories.map((category) {
                  return DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.categoryName),
                  );
                }).toList(),
                onChanged: (CategoryModel? selectedCategory) {
                  if (selectedCategory != null) {
                    productProvider.selectedCategory = selectedCategory;
                    Navigator.pop(context); // Close the dialog
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
