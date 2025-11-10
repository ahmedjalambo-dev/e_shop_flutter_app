import 'package:e_shop_flutter_app/core/di/injection.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/features/auth/forget_password/ui/forgot_password_screen.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/cubit/verify_email_cubit.dart';
import 'package:e_shop_flutter_app/features/home/home_screen.dart';
import 'package:e_shop_flutter_app/features/auth/login/cubit/login_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/login/ui/login_screen.dart';
import 'package:e_shop_flutter_app/features/onboarding/onboarding_screen.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/ui/reset_password_screen.dart';
import 'package:e_shop_flutter_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/signup/ui/sginup_screen.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/ui/verify_email_screen.dart';
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
          builder: (context) => const ForgotPasswordScreen(),
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
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        );

      case MyRoutes.home:
        final String firstName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => HomeScreen(firstName: firstName),
        );
      default:
        return null;
    }
  }
}
