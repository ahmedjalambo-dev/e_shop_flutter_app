import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:e_shop_flutter_app/core/db/shared_pref_helper.dart';
import 'package:e_shop_flutter_app/core/helpers/session_manager.dart';

class AuthInitializer {
  static Future<bool> isUserLoggedIn() async {
    final accessToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.accessToken,
    );

    if (accessToken == null || accessToken.isEmpty) {
      return false;
    }

    bool isExpired = JwtDecoder.isExpired(accessToken);

    if (!isExpired) {
      return true;
    }

    // Token expired? Use our new shared manager to refresh
    return await SessionManager.refreshSession();
  }

  static Future<bool> isFirstTimeUser() async {
    final isFirstTime = await SharedPrefHelper.getBool(
      SharedPrefKeys.isFirstTime,
    );
    return isFirstTime ?? true;
  }
}
