import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/cubit/verify_email_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/ui/widget/otp_input.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/ui/widget/verify_email_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late TextEditingController otpController;
  String otpCode = '';
  bool isOtpComplete = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enter confirmation code', style: MyTextStyle.heading.h3),
            const VerticalSpace(8),
            Text(
              'A 6-digit code was sent to\n${widget.email}',
              style: MyTextStyle.body.s.copyWith(
                color: MyColor.neutral.dark.light,
              ),
            ),
            const VerticalSpace(24),
            OtpInputWidget(
              length: 6,
              onChanged: (value) {
                setState(() {
                  otpCode = value;
                  isOtpComplete = value.length == 4;
                });
              },
              onCompleted: (value) {
                setState(() {
                  otpCode = value;
                  isOtpComplete = true;
                });
                // Auto-proceed when OTP is complete
              },
            ),
            const VerticalSpace(24),
            GestureDetector(
              onTap: () {
                // TODO: resend otp function
              },
              child: Text(
                'Resend Code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColor.highlight.darkest,
                ),
              ),
            ),
            const VerticalSpace(28),
            MyTextButton(
              text: 'Verify',
              textStyle: MyTextStyle.action.m.copyWith(
                color: MyColor.neutral.light.lightest,
              ),
              onPressed: () => verifyEmail(context),
              backgroundColor: MyColor.highlight.darkest,
            ),
            const VerifyEmailBlocListener(),
          ],
        ),
      ),
    );
  }

  void verifyEmail(BuildContext context) {
    context.read<VerifyEmailCubit>().verifyEmail(widget.email, otpCode);
  }
}
