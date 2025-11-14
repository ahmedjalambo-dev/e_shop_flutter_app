// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsRequestBody _$ProductsRequestBodyFromJson(Map<String, dynamic> json) =>
    ProductsRequestBody(
      searchTerm: json['searchTerm'] as String? ?? '',
      category: json['category'] as String? ?? '',
      minPrice: (json['minPrice'] as num?)?.toInt() ?? 0,
      maxPrice: (json['maxPrice'] as num?)?.toInt() ?? 100000,
      isInStock: json['isInStock'] as bool? ?? false,
      sortBy: json['sortBy'] as String? ?? '',
      sortOrder: json['sortOrder'] as String? ?? 'asc',
      page: (json['page'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$ProductsRequestBodyToJson(
  ProductsRequestBody instance,
) => <String, dynamic>{
  'searchTerm': instance.searchTerm,
  'category': instance.category,
  'minPrice': instance.minPrice,
  'maxPrice': instance.maxPrice,
  'isInStock': instance.isInStock,
  'sortBy': instance.sortBy,
  'sortOrder': instance.sortOrder,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
