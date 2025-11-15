import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constants.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/models/verify_email_request_body.dart';
import 'package:retrofit/retrofit.dart';

part 'verify_email_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class VerifyEmailApiService {
  factory VerifyEmailApiService(Dio dio, {String baseUrl}) =
      _VerifyEmailApiService;

  // Changed return type to String to handle plain text response
  @POST(ApiConstants.verifyEmail)
  Future<String> verifyEmail(
    @Body() VerifyEmailRequestBody verifyEmailRequestBody,
  );
}
