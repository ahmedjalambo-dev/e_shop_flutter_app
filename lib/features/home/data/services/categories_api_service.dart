import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constants.dart';
import 'package:e_shop_flutter_app/features/home/data/models/categories_response.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CategoriesApiService {
  factory CategoriesApiService(Dio dio, {String baseUrl}) =
      _CategoriesApiService;

  @GET(ApiConstants.categories)
  Future<CategoriesResponse> getCategories();
}
