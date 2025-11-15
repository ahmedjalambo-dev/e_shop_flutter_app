import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_otp_form_field.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/cubit/validate_otp_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/ui/widgets/validate_opt_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidateOtpScreen extends StatefulWidget {
  final String email;
  const ValidateOtpScreen({super.key, required this.email});

  @override
  State<ValidateOtpScreen> createState() => _ValidateOtpScreenState();
}

class _ValidateOtpScreenState extends State<ValidateOtpScreen> {
  bool isOtpComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validate OTP')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(50),
              Text(
                'Enter the OTP code sent to your email.',
                style: MyTextStyle.body.m,
              ),
              const VerticalSpace(8),
              Text(
                widget.email,
                style: MyTextStyle.heading.h5.copyWith(
                  color: MyColors.highlight.darkest,
                ),
              ),
              const VerticalSpace(30),
              MyOtpFormField(
                length: 6,
                onChanged: (value) {
                  context.read<ValidateOtpCubit>().otpCode = value;
                  setState(() {
                    isOtpComplete = value.length == 6;
                  });
                },
                onCompleted: (value) {
                  context.read<ValidateOtpCubit>().otpCode = value;
                  setState(() {
                    isOtpComplete = true;
                  });
                },
              ),
              const VerticalSpace(40),
              MyTextButton(
                text: 'Validate OTP',
                backgroundColor: isOtpComplete
                    ? MyColors.highlight.darkest
                    : MyColors.neutral.light.dark,
                textStyle: MyTextStyle.action.l.copyWith(
                  color: MyColors.neutral.light.lightest,
                ),
                onPressed: isOtpComplete ? () => validateOtp(context) : () {},
              ),
              const ValidateOtpBlocListener(),
            ],
          ),
        ),
      ),
    );
  }

  void validateOtp(BuildContext context) {
    context.read<ValidateOtpCubit>().emitValidateOtpState();
  }
}
