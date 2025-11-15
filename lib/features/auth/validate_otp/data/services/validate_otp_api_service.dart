import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constants.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/data/models/validate_otp_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/data/models/validate_otp_response.dart';
import 'package:retrofit/retrofit.dart';

part 'validate_otp_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ValidateOtpApiService {
  factory ValidateOtpApiService(Dio dio, {String baseUrl}) =
      _ValidateOtpApiService;

  // Changed return type to String to handle plain text response
  @POST(ApiConstants.validateOtp)
  Future<String> validateOtp(
    @Body() ValidateOtpRequestBody validateOtpRequestBody,
  );
}
