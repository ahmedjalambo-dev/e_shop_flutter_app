import 'package:e_shop_flutter_app/core/netowoks/api_error_handler.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/home/data/models/products_request_body.dart';
import 'package:e_shop_flutter_app/features/home/data/models/products_response.dart';
import 'package:e_shop_flutter_app/features/home/data/services/products_api_service.dart';

class ProductsRepo {
  final ProductsApiService _productsApiService;
  ProductsRepo(this._productsApiService);

  Future<ApiResult<ProductsResponse>> getProdcuts(
    ProductsRequestBody productsRequestBody,
  ) async {
    try {
      final response = await _productsApiService.getProdcuts(
        productsRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
