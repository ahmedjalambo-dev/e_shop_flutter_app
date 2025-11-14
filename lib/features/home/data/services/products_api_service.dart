import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constants.dart';
import 'package:e_shop_flutter_app/features/home/data/models/products_request_body.dart';
import 'package:e_shop_flutter_app/features/home/data/models/products_response.dart';
import 'package:retrofit/retrofit.dart';

part 'products_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio, {String baseUrl}) = _ProductsApiService;

  @GET(ApiConstants.products)
  Future<ProductsResponse> getProdcuts(
    @Body() ProductsRequestBody produtsRequestBody,
  );
}
