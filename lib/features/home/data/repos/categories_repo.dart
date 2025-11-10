import 'package:e_shop_flutter_app/core/netowoks/api_error_handler.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/home/data/models/categories_response.dart';
import 'package:e_shop_flutter_app/features/home/data/services/categories_api_service.dart';

class CategoriesRepo {
  final CategoriesApiService _categoriesApiService;

  CategoriesRepo(this._categoriesApiService);

  Future<ApiResult<CategoriesResponse>> getCategories() async {
    try {
      final response = await _categoriesApiService.getCategories();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
