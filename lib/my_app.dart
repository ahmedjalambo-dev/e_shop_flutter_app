import 'package:e_shop_flutter_app/core/routes/my_router.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final MyRouter myRouter;

  const MyApp({super.key, required this.myRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Gaza Tech Market',
          theme: ThemeData(
            fontFamily: kFontFamily,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: MyColor.highlight.darkest,
            ).copyWith(primary: MyColor.highlight.darkest),
          ),
          onGenerateRoute: myRouter.generateRoute,
          initialRoute: MyRoutes.login,
        );
      },
    );
  }
}
