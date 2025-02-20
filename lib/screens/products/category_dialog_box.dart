import 'package:craftify_vendor/screens/products/category_model.dart';
import 'package:craftify_vendor/screens/products/product_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDialogBox extends StatelessWidget {
  const CategoryDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
      final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
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
  }
}