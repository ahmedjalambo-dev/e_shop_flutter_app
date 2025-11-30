import 'package:e_shop_flutter_app/core/di/injection.dart';
import 'package:e_shop_flutter_app/core/helpers/auth_initializer.dart';
import 'package:e_shop_flutter_app/core/routes/my_router.dart';
import 'package:e_shop_flutter_app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependency injection
  await setupGetIt();
  final bool isLoggedIn = await AuthInitializer.isUserLoggedIn();
  final bool isFirstTime = await AuthInitializer.isFirstTimeUser();
  runApp(
    MyApp(
      myRouter: MyRouter(),
      isLoggedIn: isLoggedIn,
      isFirstTime: isFirstTime,
    ),
  );
}
