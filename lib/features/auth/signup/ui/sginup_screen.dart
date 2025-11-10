import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/signup/ui/widgets/i_have_account_login_now.dart';
import 'package:e_shop_flutter_app/features/auth/signup/ui/widgets/signup_bloc_listener.dart';
import 'package:e_shop_flutter_app/features/auth/signup/ui/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VerticalSpace(24.h),
                    Text('Signup', style: MyTextStyle.heading.h3),
                    Text(
                      'Create an account to get started',
                      style: MyTextStyle.body.s.copyWith(
                        color: MyColors.neutral.dark.light,
                      ),
                    ),
                    const VerticalSpace(24),
                    const SignupForm(),
                    const VerticalSpace(24),
                    MyTextButton(
                      text: 'Signup',
                      textStyle: MyTextStyle.action.m.copyWith(
                        color: MyColors.neutral.light.lightest,
                      ),
                      onPressed: () {
                        // signup
                        signup(context);
                      },
                      backgroundColor: MyColors.highlight.darkest,
                    ),
                    const SignupBlocListener(),
                    const VerticalSpace(16),
                    IHaveAnAccountLoginNow(
                      onTap: () => context.pushReplacementNamed(MyRoutes.login),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void signup(BuildContext context) {
  context.read<SignupCubit>().emitSignupStates();
}
