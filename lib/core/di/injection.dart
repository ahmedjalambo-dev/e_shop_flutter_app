import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/dio_factory.dart';
import 'package:e_shop_flutter_app/features/auth/login/cubit/login_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/repos/login_repo.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/services/login_api_service.dart';
import 'package:e_shop_flutter_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/signup/data/repos/signup_repo.dart';
import 'package:e_shop_flutter_app/features/auth/signup/data/services/signup_api_service.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/cubit/verify_email_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/repos/verify_email_repo.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/services/verify_email_api_service.dart';
import 'package:e_shop_flutter_app/features/home/cubit/categories_cubit.dart';
import 'package:e_shop_flutter_app/features/home/cubit/products_cubit.dart';
import 'package:e_shop_flutter_app/features/home/data/repos/categories_repo.dart';
import 'package:e_shop_flutter_app/features/home/data/repos/products_repo.dart';
import 'package:e_shop_flutter_app/features/home/data/services/categories_api_service.dart';
import 'package:e_shop_flutter_app/features/home/data/services/products_api_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

  // login
  getIt.registerLazySingleton<LoginApiService>(() => LoginApiService(dio));
  getIt.registerLazySingleton(() => LoginRepo(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupApiService>(() => SignupApiService(dio));
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // verify email
  getIt.registerLazySingleton<VerifyEmailApiService>(
    () => VerifyEmailApiService(dio),
  );
  getIt.registerLazySingleton(() => VerifyEmailRepo(getIt()));
  getIt.registerFactoryParam<VerifyEmailCubit, String, void>(
    (email, _) => VerifyEmailCubit(getIt(), email),
  );

  // // forgot password
  // getIt.registerLazySingleton(() => ForgotPasswordRepo(getIt()));
  // getIt.registerFactory(() => ForgotPasswordCubit(getIt()));

  // // reset password
  // getIt.registerLazySingleton(() => ResetPasswordRepo(getIt()));
  // getIt.registerFactoryParam<ResetPasswordCubit, String, void>(
  //   (email, _) => ResetPasswordCubit(getIt(), email),
  // );

  // home
  getIt.registerLazySingleton<CategoriesApiService>(
    () => CategoriesApiService(dio),
  );
  getIt.registerLazySingleton<CategoriesRepo>(() => CategoriesRepo(getIt()));
  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit(getIt()));

  getIt.registerLazySingleton<ProductsApiService>(
    () => ProductsApiService(dio),
  );
  getIt.registerLazySingleton<ProductsRepo>(() => ProductsRepo(getIt()));
  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));


  // // Add Cart
  // getIt.registerLazySingleton<CartService>(() => CartService(dio));
  // getIt.registerLazySingleton<CartRepo>(() => CartRepo(getIt()));
  // getIt.registerFactory<CartCubit>(() => CartCubit(getIt()));
}
