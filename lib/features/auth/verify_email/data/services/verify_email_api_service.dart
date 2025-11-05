import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constant.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/models/verify_email_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/models/verify_email_response.dart';
import 'package:retrofit/retrofit.dart';
part 'verify_email_api_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class VerifyEmailApiService {
  factory VerifyEmailApiService(Dio dio, {String baseUrl}) =
      _VerifyEmailApiService;

  @POST(ApiConstant.verifyEmail)
  Future<VerifyEmailResponse> verifyEmail(
    @Body() VerifyEmailRequestBody verifyEmailRequestBody,
  );
}
