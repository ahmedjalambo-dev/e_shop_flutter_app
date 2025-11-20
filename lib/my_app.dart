import 'package:e_shop_flutter_app/core/di/injection.dart';
import 'package:e_shop_flutter_app/core/routes/my_router.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final MyRouter myRouter;
  final bool isLoggedIn;
  final bool isFirstTime;

  const MyApp({
    super.key,
    required this.myRouter,
    required this.isLoggedIn,
    required this.isFirstTime,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FavoriteCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Gaza Tech Market',
            theme: ThemeData(
              fontFamily: kFontFamily,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
              colorScheme: ColorScheme.fromSeed(
                seedColor: MyColors.highlight.darkest,
              ).copyWith(primary: MyColors.highlight.darkest),
            ),
            onGenerateRoute: myRouter.generateRoute,
            initialRoute: isFirstTime
                ? MyRoutes.onboarding
                : isLoggedIn
                ? MyRoutes.root
                : MyRoutes.login,
          );
        },
      ),
    );
  }
}
