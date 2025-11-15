import 'package:e_shop_flutter_app/core/netowoks/api_error_handler.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/data/models/forgot_password_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/data/services/forgot_password_api_service.dart';

class ForgotPasswordRepo {
  final ForgotPasswordApiService _forgotPasswordApiService;

  ForgotPasswordRepo(this._forgotPasswordApiService);

  Future<ApiResult<String>> forgotPassword(String email) async {
    try {
      final response = await _forgotPasswordApiService.forgotPassword(
        ForgotPasswordRequestBody(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
