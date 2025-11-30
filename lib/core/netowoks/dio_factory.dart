import 'dart:async';

import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:e_shop_flutter_app/core/helpers/session_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../db/shared_pref_helper.dart';
import 'api_constants.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? _dio;
  static bool _isRefreshing = false;
  static Completer<void>? _refreshCompleter;

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
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    // Handle 401 (Unauthorized)
    if (statusCode == 401) {
      // If the refresh token endpoint itself failed, we are doomed. Logout.
      if (err.requestOptions.path.endsWith(ApiConstants.refreshToken)) {
        await SessionManager.clearSession();
        return handler.next(err);
      }

      // If not currently refreshing, start the process
      if (!DioFactory._isRefreshing) {
        DioFactory._isRefreshing = true;
        DioFactory._refreshCompleter = Completer<void>();

        try {
          // CALL THE SHARED LOGIC
          final bool refreshed = await SessionManager.refreshSession();

          if (refreshed) {
            // Retry original request with new token
            final newToken = await SharedPrefHelper.getSecuredString(
              SharedPrefKeys.accessToken,
            );
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';

            // Repeat the request with the main Dio instance
            final response = await DioFactory.getDio().fetch(options);

            DioFactory._refreshCompleter?.complete();
            return handler.resolve(response);
          } else {
            // Refresh failed
            DioFactory._refreshCompleter?.completeError("Refresh failed");
            return handler.next(err);
          }
        } catch (e) {
          DioFactory._refreshCompleter?.completeError(e);
          return handler.next(err);
        } finally {
          DioFactory._isRefreshing = false;
          DioFactory._refreshCompleter = null;
        }
      } else {
        // Wait for the other refresh to finish, then retry
        try {
          await DioFactory._refreshCompleter?.future;

          final newToken = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.accessToken,
          );
          if (newToken != null && newToken.isNotEmpty) {
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';
            final response = await DioFactory.getDio().fetch(options);
            return handler.resolve(response);
          }
        } catch (_) {
          // If the primary refresh failed, this one fails too
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }
}
