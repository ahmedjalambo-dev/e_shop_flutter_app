import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:e_shop_flutter_app/core/helpers/shared_pref_helper.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constant.dart';
import 'package:e_shop_flutter_app/core/netowoks/dio_factory.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/models/login_response.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/models/refresh_token_request_body.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Get the current refresh token
      final refreshToken = await SharedPrefHelper.getString(
        SharedPrefKeys.refreshToken,
      );
      if (refreshToken.isEmpty) {
        // If no refresh token, proceed with the error
        return super.onError(err, handler);
      }

      try {
        // Request a new access token
        final newTokens = await _getNewAccessToken(refreshToken);

        // Update stored tokens
        await SharedPrefHelper.setData(
          SharedPrefKeys.accessToken,
          newTokens.accessToken,
        );
        await SharedPrefHelper.setData(
          SharedPrefKeys.refreshToken,
          newTokens.refreshToken,
        );
        DioFactory.setTokenIntoHeader(newTokens.accessToken!);

        // Retry the original request with the new token
        final originalRequest = err.requestOptions;
        originalRequest.headers['Authorization'] =
            'Bearer ${newTokens.accessToken}';

        final response = await DioFactory.getDio().fetch(originalRequest);
        return handler.resolve(response);
      } catch (e) {
        // If refreshing fails, clear tokens and proceed with the error
        await SharedPrefHelper.removeData(SharedPrefKeys.accessToken);
        await SharedPrefHelper.removeData(SharedPrefKeys.refreshToken);
        // Here you might want to navigate the user to the login screen
        return super.onError(err, handler);
      }
    }
    super.onError(err, handler);
  }

  Future<LoginResponse> _getNewAccessToken(String refreshToken) async {
    final dio = Dio(); // Create a new Dio instance to avoid interceptor loop
    final response = await dio.post(
      '${ApiConstant.baseUrl}${ApiConstant.refreshToken}',
      data: RefreshTokenRequestBody(refreshToken: refreshToken).toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }
}
