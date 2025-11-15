import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constants.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/data/models/reset_password_request_body.dart';
import 'package:retrofit/retrofit.dart';

part 'reset_password_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ResetPasswordApiService {
  factory ResetPasswordApiService(Dio dio, {String baseUrl}) =
      _ResetPasswordApiService;

  @POST(ApiConstants.resetPassword)
  Future<String> resetPassword(
    @Body() ResetPasswordRequestBody resetPasswordRequestBody,
  );
}
