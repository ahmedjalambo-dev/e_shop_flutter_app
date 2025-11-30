import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:e_shop_flutter_app/core/di/injection.dart';
import 'package:e_shop_flutter_app/core/db/shared_pref_helper.dart';
import 'package:e_shop_flutter_app/core/helpers/auth_initializer.dart'; // Import the new helper
import 'package:e_shop_flutter_app/core/routes/my_router.dart';
import 'package:e_shop_flutter_app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependency injection
  await setupGetIt();
  // Check if the user is logged in using the AuthInitializer
  final bool isLoggedIn = await AuthInitializer.isUserLoggedIn();
  // Check if it's the user's first time opening the app
  final bool isFirstTime = await AuthInitializer.isFirstTimeUser();
  runApp(
    MyApp(
      myRouter: MyRouter(),
      isLoggedIn: isLoggedIn,
      isFirstTime: isFirstTime,
    ),
  );
}
