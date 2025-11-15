import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_otp_form_field.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_form_field.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/cubit/reset_password_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/ui/widgets/reset_password_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final ResetPasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ResetPasswordCubit>();
    _cubit.newPasswordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(50),
                  Text(
                    'Enter the OTP and your new password.',
                    style: MyTextStyle.body.m,
                  ),
                  const VerticalSpace(30),
                  MyTextFormField(
                    controller: _cubit.otpController,
                    textInputType: TextInputType.number,
                    hintText: 'OTP',
                    validator: (otp) {
                      if (otp == null || otp.isEmpty) return 'OTP is required';
                      return null;
                    },
                  ),
                  const VerticalSpace(20),
                  MyTextFormField(
                    controller: _cubit.newPasswordController,
                    textInputType: TextInputType.text,

                    hintText: 'New Password',
                    validator: (password) => null,
                    // ValidatorHelper.validatePassword(password),
                  ),
                  const VerticalSpace(20),

                  // PasswordValidations(
                  //   hasMinLength: _cubit.hasMinLength,
                  //   hasUpperCaseLetter: _cubit.hasUpperCaseLetter,
                  //   hasLowerCaseLetter: _cubit.hasLowerCaseLetter,
                  //   hasDigit: _cubit.hasDigit,
                  //   hasSpecialCharacter: _cubit.hasSpecialCharacter,
                  // ),
                  const VerticalSpace(40),
                  MyTextButton(
                    text: 'Reset Password',
                    backgroundColor: MyColors.highlight.darkest,
                    textStyle: MyTextStyle.action.m.copyWith(
                      color: MyColors.neutral.light.lightest,
                    ),
                    onPressed: () => validateAndSubmit(context),
                  ),
                  const ResetPasswordBlocListener(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateAndSubmit(BuildContext context) {
    if (_cubit.formKey.currentState!.validate()) {
      _cubit.emitResetPasswordState();
    }
  }

  @override
  void dispose() {
    _cubit.newPasswordController.removeListener(() {});
    super.dispose();
  }
}
