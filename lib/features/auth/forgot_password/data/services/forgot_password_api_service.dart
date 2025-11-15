import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constants.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/data/models/forgot_password_request_body.dart';
import 'package:retrofit/retrofit.dart';

part 'forgot_password_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ForgotPasswordApiService {
  factory ForgotPasswordApiService(Dio dio, {String baseUrl}) =
      _ForgotPasswordApiService;

  @POST(ApiConstants.forgotPassword)
  Future<String> forgotPassword(
    @Body() ForgotPasswordRequestBody forgotPasswordRequestBody,
  );
}
