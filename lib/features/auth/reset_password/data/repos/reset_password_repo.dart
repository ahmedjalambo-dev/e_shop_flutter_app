import 'package:e_shop_flutter_app/core/netowoks/api_error_handler.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/data/models/reset_password_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/data/services/reset_password_api_service.dart';

class ResetPasswordRepo {
  final ResetPasswordApiService _resetPasswordApiService;

  ResetPasswordRepo(this._resetPasswordApiService);

  Future<ApiResult<String>> resetPassword(
    ResetPasswordRequestBody resetPasswordRequestBody,
  ) async {
    try {
      final response = await _resetPasswordApiService.resetPassword(
        resetPasswordRequestBody,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
