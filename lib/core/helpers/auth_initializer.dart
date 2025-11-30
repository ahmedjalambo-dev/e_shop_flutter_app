import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:e_shop_flutter_app/core/db/shared_pref_helper.dart';
import 'package:e_shop_flutter_app/core/helpers/session_manager.dart';
// Note: You can now remove 'package:jwt_decoder/jwt_decoder.dart';

class AuthInitializer {
  static Future<bool> isUserLoggedIn() async {
    // 1. Check for token existence (still mandatory)
    final accessToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.accessToken,
    );
    if (accessToken == null || accessToken.isEmpty) {
      return false;
    }

    // 2. Get the expiration timestamp
    final expirationString = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.accessTokenExpiration,
    );

    // If expiration time is missing, we must assume the token is bad.
    if (expirationString == null || expirationString.isEmpty) {
      await SessionManager.clearSession();
      return false;
    }

    // 3. Compare current time with expiration time
    try {
      final expirationTime = DateTime.parse(expirationString).toLocal();
      final now = DateTime.now();

      // Check if the current time is BEFORE the expiration time
      bool isExpired = now.isAfter(expirationTime);

      if (!isExpired) {
        // Token is valid based on the expiration time, let them in
        return true;
      }
    } catch (e) {
      // Failed to parse the date string (corrupted data). Force logout.
      await SessionManager.clearSession();
      return false;
    }

    // 4. Token expired, try to refresh
    return await SessionManager.refreshSession();
  }

  static Future<bool> isFirstTimeUser() async {
    // Check if the user is first time by checking the shared preferences
    final isFirstTime = await SharedPrefHelper.getBool(
      SharedPrefKeys.isFirstTime,
    );
    return isFirstTime ?? true; // Default to true if not set
  }
}
