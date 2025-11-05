import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constant.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/models/login_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/models/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String baseUrl}) = _LoginApiService;

  @POST(ApiConstant.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);
}
