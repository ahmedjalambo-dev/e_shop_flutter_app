import 'package:e_shop_flutter_app/core/netowoks/api_error_handler.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/models/verify_email_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/models/verify_email_response.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/services/verify_email_api_service.dart';

class VerifyEmailRepo {
  final VerifyEmailApiService _apiService;
  VerifyEmailRepo(this._apiService);

  Future<ApiResult<VerifyEmailResponse>> verifyEmail(
    VerifyEmailRequestBody verifyEmailRequestBody,
  ) async {
    try {
      final response = await _apiService.verifyEmail(verifyEmailRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
