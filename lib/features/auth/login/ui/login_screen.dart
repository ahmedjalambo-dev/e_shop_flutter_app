import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/auth/login/cubit/login_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/login/ui/widgets/login_bloc_listener.dart';
import 'package:e_shop_flutter_app/features/auth/login/ui/widgets/login_form.dart';
import 'package:e_shop_flutter_app/features/auth/login/ui/widgets/not_member_register_now.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/image-palceholder.png',
              height: 321.h,
              fit: BoxFit.cover,
            ),
            const VerticalSpace(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome!', style: MyTextStyle.heading.h1),
                  const VerticalSpace(24),
                  const LoginForm(),
                  const VerticalSpace(16),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(MyRoutes.forgotPassword);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.highlight.darkest,
                      ),
                    ),
                  ),
                  const VerticalSpace(24),
                  MyTextButton(
                    text: 'Login',
                    textStyle: MyTextStyle.action.m.copyWith(
                      color: MyColors.neutral.light.lightest,
                    ),
                    onPressed: () {
                      // login
                      login(context);
                    },
                    backgroundColor: MyColors.highlight.darkest,
                  ),
                  const LoginBlocListener(),
                  const VerticalSpace(16),
                  DontHaveAnAccountSignup(
                    onTap: () => context.pushReplacementNamed(MyRoutes.signup),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) {
    context.read<LoginCubit>().emitLoginStates();
  }
}
