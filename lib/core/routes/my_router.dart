import 'package:e_shop_flutter_app/core/di/injection.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/ui/forgot_password_screen.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/cubit/reset_password_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/ui/reset_password_screen.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/cubit/validate_otp_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/ui/validate_otp_screen.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/cubit/verify_email_cubit.dart';
import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:e_shop_flutter_app/features/home/cubit/categories_cubit.dart';
import 'package:e_shop_flutter_app/features/home/cubit/products_cubit.dart';
import 'package:e_shop_flutter_app/features/home/data/models/products_response.dart';
import 'package:e_shop_flutter_app/features/home/ui/home_screen.dart';
import 'package:e_shop_flutter_app/features/auth/login/cubit/login_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/login/ui/login_screen.dart';
import 'package:e_shop_flutter_app/features/home/ui/product_details_screen.dart';
import 'package:e_shop_flutter_app/features/onboarding/onboarding_screen.dart';
import 'package:e_shop_flutter_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/signup/ui/sginup_screen.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/ui/verify_email_screen.dart';
import 'package:e_shop_flutter_app/my_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoutes.onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case MyRoutes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case MyRoutes.signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );
      case MyRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        );
      case MyRoutes.validateOtp:
        final email = settings.arguments as String;
        final otp = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<ValidateOtpCubit>(param1: email, param2: otp),
            child: ValidateOtpScreen(email: email),
          ),
        );
      case MyRoutes.verifyEmail:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<VerifyEmailCubit>(
            create: (context) => getIt<VerifyEmailCubit>(param1: email),
            child: VerifyEmailScreen(email: email),
          ),
        );
      case MyRoutes.resetPassword:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(param1: args),
            child: const ResetPasswordScreen(),
          ),
        );
      case MyRoutes.root:
        return MaterialPageRoute(builder: (context) => const MyRoot());
      case MyRoutes.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<CategoriesCubit>()..emitCategoriesStates(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<ProductsCubit>()..emitProductsStates(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );
      case MyRoutes.productDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final product = args['product'] as Product;
        final heroTag = args['heroTag'] as String;
        return MaterialPageRoute(
          builder: (context) =>
              ProductDetailsScreen(product: product, heroTag: heroTag),
        );
      default:
        return null;
    }
  }
}
