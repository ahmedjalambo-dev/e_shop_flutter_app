import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  final List<Product> items;

  ProductsResponse({required this.items});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);
}

@JsonSerializable()
class Product {
  final String id;
  final String productCode;
  final String name;
  final String description;
  final String arabicName;
  final String arabicDescription;
  final String coverPictureUrl;
  final double price;
  final int stock;
  final double weight;
  final String color;
  final double rating;
  final int reviewsCount;
  final double discountPercentage;
  final String sellerId;
  final List<String> categories;

  Product({
    required this.id,
    required this.productCode,
    required this.name,
    required this.description,
    required this.arabicName,
    required this.arabicDescription,
    required this.coverPictureUrl,
    required this.price,
    required this.stock,
    required this.weight,
    required this.color,
    required this.rating,
    required this.reviewsCount,
    required this.discountPercentage,
    required this.sellerId,
    required this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
