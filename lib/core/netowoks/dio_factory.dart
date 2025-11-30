import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../db/shared_pref_helper.dart';
import 'api_constants.dart';
import '../../features/auth/refresh_token/data/models/refresh_token_request_body.dart';
import '../../features/auth/login/data/models/login_response.dart';

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

    // Only handle 401 errors (unauthorized)
    if (statusCode == 401) {
      // If the failed request was the refresh endpoint itself, don't try to refresh again
      if (err.requestOptions.path.endsWith(ApiConstants.refreshToken)) {
        await SharedPrefHelper.clearAllSecuredData();
        return handler.next(err);
      }

      final dio = DioFactory.getDio();

      // If not currently refreshing, start refresh flow
      if (!DioFactory._isRefreshing) {
        DioFactory._isRefreshing = true;
        DioFactory._refreshCompleter = Completer<void>();

        // Note: not using Dio's internal locks to remain compatible
        // with different Dio versions; we coordinate using a completer.

        try {
          final refreshToken = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.refreshToken,
          );

          if (refreshToken == null || refreshToken.isEmpty) {
            await SharedPrefHelper.clearAllSecuredData();
            return handler.next(err);
          }

          // Use a temporary Dio instance without interceptors to call refresh
          final refreshDio = Dio(
            BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              headers: {'Accept': 'application/json'},
            ),
          );

          final body = RefreshTokenRequestBody(
            refreshToken: refreshToken,
          ).toJson();
          final refreshResponse = await refreshDio.post(
            ApiConstants.refreshToken,
            data: body,
          );

          if (refreshResponse.statusCode == 200 ||
              refreshResponse.statusCode == 201) {
            final data = refreshResponse.data;
            Map<String, dynamic> json;
            if (data is String) {
              json = jsonDecode(data) as Map<String, dynamic>;
            } else if (data is Map) {
              json = Map<String, dynamic>.from(data);
            } else {
              json = {};
            }

            final loginResponse = LoginResponse.fromJson(json);
            if (loginResponse.isSuccess) {
              await SharedPrefHelper.setSecuredString(
                SharedPrefKeys.accessToken,
                loginResponse.accessToken ?? '',
              );
              if (loginResponse.refreshToken != null &&
                  loginResponse.refreshToken!.isNotEmpty) {
                await SharedPrefHelper.setSecuredString(
                  SharedPrefKeys.refreshToken,
                  loginResponse.refreshToken!,
                );
              }

              // Retry the original request with new token
              final options = err.requestOptions;
              options.headers['Authorization'] =
                  'Bearer ${loginResponse.accessToken ?? ''}';
              final response = await dio.fetch(options);

              DioFactory._refreshCompleter?.complete();
              return handler.resolve(response);
            }
          }

          // If refresh failed, clear secured storage so user will be logged out
          await SharedPrefHelper.clearAllSecuredData();
        } catch (e) {
          print('Token refresh failed: $e');
          await SharedPrefHelper.clearAllSecuredData();
        } finally {
          DioFactory._isRefreshing = false;
          DioFactory._refreshCompleter?.complete();
          DioFactory._refreshCompleter = null;
        }
      } else {
        // Refresh already in progress: wait for it to complete and retry
        try {
          await DioFactory._refreshCompleter?.future;
          final accessToken = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.accessToken,
          );
          if (accessToken != null && accessToken.isNotEmpty) {
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $accessToken';
            final response = await DioFactory.getDio().fetch(options);
            return handler.resolve(response);
          }
        } catch (_) {
          // fall through to next
        }
      }
    }

    return handler.next(err);
  }
}
