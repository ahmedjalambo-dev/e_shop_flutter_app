import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_form_field.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/ui/widgets/forgot_password_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(50),
              Text(
                'Enter your email to receive a OTP code for password reset link.',
                style: MyTextStyle.body.s,
              ),
              const VerticalSpace(30),
              Form(
                key: context.read<ForgotPasswordCubit>().formKey,
                child: MyTextFormField(
                  textInputType: TextInputType.emailAddress,
                  controller: context
                      .read<ForgotPasswordCubit>()
                      .emailController,
                  hintText: 'Email Address',
                  validator: (email) {
                    return null;
                  },
                ),
              ),
              const VerticalSpace(40),
              MyTextButton(
                text: 'Send OTP',
                backgroundColor: MyColors.highlight.darkest,
                textStyle: MyTextStyle.action.l.copyWith(
                  color: MyColors.neutral.light.lightest,
                ),
                onPressed: () {
                  validateAndSubmit(context);
                },
              ),
              const ForgotPasswordBlocListener(),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndSubmit(BuildContext context) {
    if (context.read<ForgotPasswordCubit>().formKey.currentState!.validate()) {
      context.read<ForgotPasswordCubit>().emitForgotPasswordState();
    }
  }
}
