import 'package:craftify_vendor/const/urls.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class ProductRepository {
  final Dio dio = Dio();

  //  Fetch Categories
  Future fetchCategories() async {
    try {
      Response response = await dio.get('${baseUrl}vendors/by-category/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data.entries.first.value;
        print('❌ Error: $errorMessage');
        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Fetch categories failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  //  Fetch Products
  Future fetchProducts() async {
    try {
      Response response = await dio.get(
          'https://purpleecommerce.pythonanywhere.com/productsapp/vendors/10/products');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data.entries.first.value;
        print('❌ Error: $errorMessage');
        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Fetch categories failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  //  Add Product API
  Future<void> addProduct({
    required int userId,
    required String productName,
    required String productDescription,
    required String price,
    required String offerPrice,
    required int categoryId,
    required List<File> images,
    required bool isOfferProduct,
    required bool isPopularProduct,
    required bool isNewArrival,
    required bool isTrendingProduct,
  }) async {
    try {
      // Convert images to MultipartFile
      List<MultipartFile> multipartImages = await Future.wait(
        images.map((image) async => await MultipartFile.fromFile(image.path)),
      );

      FormData formData = FormData.fromMap({
        "vendor": userId,
        "category_id": categoryId,
        "product_name": productName,
        "product_description": productDescription,
        "price": price,
        "offer_price": offerPrice,
        "images": multipartImages, // Send as MultipartFile list
        "isofferproduct": isOfferProduct,
        "Popular_products": isPopularProduct,
        "newarrival": isNewArrival,
        "trending_one": isTrendingProduct,
      });

      // Print all data to the console
      print("Data being sent to the API:");
      print("Vendor: 5");
      print("Category ID: $categoryId");
      print("Product Name: $productName");
      print("Product Description: $productDescription");
      print("Price: $price");
      print("Offer Price: $offerPrice");
      print("Images: ${multipartImages}"); // Print image paths
      print("Is Offer Product: true");
      print("Popular Product: false");
      print("New Arrival: true");
      print("Trending One: false");

      Response response = await dio.post(
        'https://purpleecommerce.pythonanywhere.com/productsapp/product/',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Product added successfully');
      } else {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data.entries.first.value;
        print('❌ Error: $errorMessage');
        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Add product failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  //Edit Product

  Future<void> updateProduct({
    required int productId,
    required String productName,
    required String productDescription,
    required String price,
    required String offerPrice,
    required int categoryId,
    required bool isOfferProduct,
    required bool isPopularProduct,
    required bool isNewArrival,
    required bool isTrendingProduct,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "category_id": categoryId,
        "product_name": productName,
        "product_description": productDescription,
        "price": price,
        "offer_price": offerPrice,
        "isofferproduct": isOfferProduct,
        "Popular_products": isPopularProduct,
        "newarrival": isNewArrival,
        "trending_one": isTrendingProduct,
      });
      print(formData);
      // Send PATCH request
      Response response = await dio.patch(
        'https://purpleecommerce.pythonanywhere.com/productsapp/product/$productId/',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Product updated successfully');
      } else {
        throw Exception('❌ Failed to update product: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data.entries.first.value;
        print('❌ API Error: $errorMessage');
        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Edit product failed');
      } else {
        throw Exception('❌ Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('❌ Unexpected error: $e');
    }
  }
}
