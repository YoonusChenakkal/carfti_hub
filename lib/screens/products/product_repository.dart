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
    required String productName,
    required String productDescription,
    required String price,
    required String offerPrice,
    required int categoryId,
    required List<File> images,
  }) async {
    try {
      // Convert images to MultipartFile
      List<MultipartFile> multipartImages = await Future.wait(
        images.map((image) async => await MultipartFile.fromFile(image.path)),
      );

      FormData formData = FormData.fromMap({
        "vendor": 5,
        "category_id": categoryId,
        "product_name": productName,
        "product_description": productDescription,
        "price": price,
        "offer_price": offerPrice,
        "images": multipartImages, // Send as MultipartFile list
        "isofferproduct": true,
        "Popular_products": false,
        "newarrival": true,
        "trending_one": false,
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
}
