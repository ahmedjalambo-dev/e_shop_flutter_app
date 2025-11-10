import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_form_field.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fogot Password', style: MyTextStyle.heading.h1),
            Text(
              'Enter your email and we\'ll send you OTP to reset your password',
              style: MyTextStyle.body.s.copyWith(
                color: MyColors.neutral.dark.light,
              ),
            ),
            const VerticalSpace(24),
            MyTextFormField(
              textInputType: TextInputType.emailAddress,
              hintText: 'Email Address',
              controller: TextEditingController(),
              validator: (value) {
                return null;
              },
              hintStyle: MyTextStyle.body.m.copyWith(
                color: MyColors.neutral.dark.light,
              ),
              inputTextStyle: MyTextStyle.body.m.copyWith(
                color: MyColors.neutral.dark.darkest,
              ),
            ),

            const VerticalSpace(24),
            MyTextButton(
              text: 'Send',
              textStyle: MyTextStyle.action.m.copyWith(
                color: MyColors.neutral.light.lightest,
              ),
              onPressed: () {
                // TODO: Navigate to validate OTP screen with eamil address value
                context.pushNamedAndRemoveUntil(
                  MyRoutes.validateOtp,
                  predicate: (route) => false,
                );
              },
              backgroundColor: MyColors.highlight.darkest,
            ),
          ],
        ),
      ),
    );
  }
}
