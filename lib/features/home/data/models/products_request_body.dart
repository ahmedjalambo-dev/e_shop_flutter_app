import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_request_body.g.dart';

@JsonSerializable()
class ProductsRequestBody {
  final String? searchTerm;
  final String? category;
  final int? minPrice;
  final int? maxPrice;
  final bool? isInStock;
  final String? sortBy;
  final String? sortOrder;
  final int? page;
  final int? pageSize;

  ProductsRequestBody({
    this.searchTerm = '',
    this.category = '',
    this.minPrice = 0,
    this.maxPrice = 100000,
    this.isInStock = false,
    this.sortBy = '',
    this.sortOrder = 'asc',
    this.page = 1,
    this.pageSize = 100,
  });

  Map<String, dynamic> toJson() => _$ProductsRequestBodyToJson(this);
}
