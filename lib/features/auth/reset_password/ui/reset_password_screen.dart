import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_form_field.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reset Password', style: MyTextStyle.heading.h1),
            Text(
              'Please enter your new password below.',
              style: MyTextStyle.body.s.copyWith(
                color: MyColor.neutral.dark.light,
              ),
            ),
            const VerticalSpace(24),
            MyTextFormField(
              textInputType: TextInputType.text,
              hintText: 'New Password',
              controller: TextEditingController(),
              hintStyle: MyTextStyle.body.m.copyWith(
                color: MyColor.neutral.dark.light,
              ),
              inputTextStyle: MyTextStyle.body.m.copyWith(
                color: MyColor.neutral.dark.darkest,
              ),
              isObscureText: true,
              suffixIcon: const Icon(Icons.visibility_off, size: 16),
            ),

            const VerticalSpace(24),
            MyTextButton(
              text: 'Submit',
              textStyle: MyTextStyle.action.m.copyWith(
                color: MyColor.neutral.light.lightest,
              ),
              onPressed: () {
                // TODO: Navigate to validate OTP screen with eamil address value
                context.pushNamedAndRemoveUntil(
                  MyRoutes.login,
                  predicate: (route) => false,
                );
              },
              backgroundColor: MyColor.highlight.darkest,
            ),
          ],
        ),
      ),
    );
  }
}
