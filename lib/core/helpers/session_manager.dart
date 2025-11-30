import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:e_shop_flutter_app/core/db/shared_pref_helper.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constants.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/models/login_response.dart';
import 'package:e_shop_flutter_app/features/auth/refresh_token/data/models/refresh_token_request_body.dart';
import 'package:flutter/foundation.dart';

class SessionManager {
  /// Attempts to refresh the user session using the stored refresh token.
  /// Returns [true] if successful, [false] if failed.
  static Future<bool> refreshSession() async {
    final refreshToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.refreshToken,
    );

    if (refreshToken == null || refreshToken.isEmpty) {
      await clearSession();
      return false;
    }

    // Use a basic Dio instance to avoid interceptor loops
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {'Accept': 'application/json'},
        // Shorter timeout for refresh attempts
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    try {
      final body = RefreshTokenRequestBody(refreshToken: refreshToken).toJson();

      final response = await dio.post(ApiConstants.refreshToken, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginResponse.fromJson(response.data);

        if (loginResponse.isSuccess) {
          await _saveTokens(loginResponse);
          return true;
        }
      }

      // If server returns anything else (e.g. 400, 403), refresh failed
      await clearSession();
      return false;
    } catch (e) {
      debugPrint("Session refresh failed: $e");
      // Only clear session if it's strictly an auth error (401/403).
      // Network errors (no internet) shouldn't log the user out immediately.
      if (e is DioException &&
          (e.response?.statusCode == 401 || e.response?.statusCode == 403)) {
        await clearSession();
      }
      return false;
    }
  }

  static Future<void> clearSession() async {
    await SharedPrefHelper.clearAllSecuredData();
    // Keep 'isFirstTime' flag, but clear auth data
  }

  static Future<void> _saveTokens(LoginResponse response) async {
    // Save Access Token
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.accessToken,
      response.accessToken ?? '',
    );

    // Save Refresh Token (if provided)
    if (response.refreshToken != null) {
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.refreshToken,
        response.refreshToken!,
      );
    }

    // Save the Expiration Time
    if (response.expiresAtUtc != null) {
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.accessTokenExpiration,
        response.expiresAtUtc!,
      );
    }
  }
}
