import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/shared_pref_helper.dart';
import 'api_constants.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    // Return the existing instance if it's already created
    if (_dio != null) {
      return _dio!;
    }

    // Create a new Dio instance
    const Duration timeOut = Duration(seconds: 30);
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        headers: {'Accept': 'application/json'},
      ),
    );

    // Add interceptors
    _dio!.interceptors.addAll([
      _AuthInterceptor(),
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    ]);

    return _dio!;
  }
}

/// Private interceptor to handle adding the auth token to requests.
/// This cleanly separates auth logic from the Dio setup.
///
/// It fetches the token from SharedPref on-demand for each request,
/// ensuring the most current token is always used.
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Don't add auth token to auth-related paths
    final noAuthPaths = [
      ApiConstants.login,
      ApiConstants.signup,
      ApiConstants.refreshToken,
      ApiConstants.verifyEmail,
      ApiConstants.resendOtp,
      ApiConstants.forgotPassword,
      ApiConstants.resetPassword,
    ];

    if (noAuthPaths.any((path) => options.path.endsWith(path))) {
      return handler.next(options);
    }

    // Fetch the token
    final String? token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.accessToken,
    );

    // Add the token to the header if it exists
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  // You can also override onResponse and onError here if you need
  // to handle token refreshing (e.g., on 401 errors)
}
