import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:e_shop_flutter_app/core/di/injection.dart';
import 'package:e_shop_flutter_app/core/helpers/shared_pref_helper.dart';
import 'package:e_shop_flutter_app/core/routes/my_router.dart';
import 'package:e_shop_flutter_app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  final accessToken = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.accessToken,
  );
  final bool isLoggedIn = accessToken != null && accessToken.isNotEmpty;
  runApp(MyApp(myRouter: MyRouter(), isLoggedIn: isLoggedIn));
}
