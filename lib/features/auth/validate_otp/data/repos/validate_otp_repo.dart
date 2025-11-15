import 'package:e_shop_flutter_app/core/netowoks/api_error_handler.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/data/models/validate_otp_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/data/models/validate_otp_response.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/data/services/validate_otp_api_service.dart';

class ValidateOtpRepo {
  final ValidateOtpApiService _validateOtpApiService;

  ValidateOtpRepo(this._validateOtpApiService);

  Future<ApiResult<ValidateOtpResponse>> validateOtp(
    ValidateOtpRequestBody validateOtpRequestBody,
  ) async {
    try {
      // API returns a plain string, so we wrap it in ValidateOtpResponse
      final response = await _validateOtpApiService.validateOtp(
        validateOtpRequestBody,
      );

      // Create ValidateOtpResponse from the string
      final validateOtpResponse = ValidateOtpResponse(message: response);

      return ApiResult.success(validateOtpResponse);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
