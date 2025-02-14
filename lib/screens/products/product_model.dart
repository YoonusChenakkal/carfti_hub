import 'dart:convert';

class ProductModel {
  final int id;
  final int vendor;
  final String vendorName;
  final int category;
  final String categoryName;
  final String productName;
  final String productDescription;
  final String price;
  final String offerPrice;
  final String discount;
  final bool isOfferProduct;
  final bool popularProducts;
  final bool newArrival;
  final bool trendingOne;
  final List<ProductImage> imageUrls;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.vendor,
    required this.vendorName,
    required this.category,
    required this.categoryName,
    required this.productName,
    required this.productDescription,
    required this.price,
    required this.offerPrice,
    required this.discount,
    required this.isOfferProduct,
    required this.popularProducts,
    required this.newArrival,
    required this.trendingOne,
    required this.imageUrls,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      vendor: json['vendor'],
      vendorName: json['vendor_name'],
      category: json['category'],
      categoryName: json['category_name'],
      productName: json['product_name'],
      productDescription: json['product_description'],
      price: json['price'],
      offerPrice: json['offerprice'],
      discount: json['discount'],
      isOfferProduct: json['isofferproduct'],
      popularProducts: json['Popular_products'],
      newArrival: json['newarrival'],
      trendingOne: json['trending_one'],
      imageUrls: (json['image_urls'] as List)
          .map((img) => ProductImage.fromJson(img))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor': vendor,
      'vendor_name': vendorName,
      'category': category,
      'category_name': categoryName,
      'product_name': productName,
      'product_description': productDescription,
      'price': price,
      'offerprice': offerPrice,
      'discount': discount,
      'isofferproduct': isOfferProduct,
      'Popular_products': popularProducts,
      'newarrival': newArrival,
      'trending_one': trendingOne,
      'image_urls': imageUrls.map((img) => img.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  static List<ProductModel> fromJsonList(String str) =>
      List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));
}

class ProductImage {
  final int id;
  final int product;
  final String productImage;

  ProductImage({
    required this.id,
    required this.product,
    required this.productImage,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      product: json['product'],
      productImage: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'product_image': productImage,
    };
  }
}
