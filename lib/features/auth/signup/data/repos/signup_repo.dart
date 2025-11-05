import 'package:e_shop_flutter_app/core/netowoks/api_error_handler.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/auth/signup/data/models/signup_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/signup/data/models/signup_response.dart';
import 'package:e_shop_flutter_app/features/auth/signup/data/services/signup_api_service.dart';

class SignupRepo {
  final SignupApiService _apiService;

  SignupRepo(this._apiService);

  Future<ApiResult<SignupResponse>> signUp(
    SignupRequestBody signUpRequestBody,
  ) async {
    try {
      final response = await _apiService.signup(signUpRequestBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
