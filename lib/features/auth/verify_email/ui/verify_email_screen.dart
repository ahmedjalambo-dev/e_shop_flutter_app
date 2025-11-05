import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/ui/widget/otp_input.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
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
              'A 4-digit code was sent to\nlucasscott3@email.com', // TODO: add email value form forgot password screen
              style: MyTextStyle.body.s.copyWith(
                color: MyColor.neutral.dark.light,
              ),
            ),
            const VerticalSpace(24),
            OtpInputWidget(
              length: 4,
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
                // TODO: Check if OTP is validate with email
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
              text: 'Continue',
              textStyle: MyTextStyle.action.m.copyWith(
                color: MyColor.neutral.light.lightest,
              ),
              onPressed: () {
                // TODO: Navigate to reset password screen
                context.pushNamed(MyRoutes.resetPassword);
              },
              backgroundColor: MyColor.highlight.darkest,
            ),
          ],
        ),
      ),
    );
  }
}
