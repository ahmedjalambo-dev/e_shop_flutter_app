import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAnAccountSignup extends StatelessWidget {
  final void Function()? onTap;
  const DontHaveAnAccountSignup({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'Don\'t have an account? ',
          style: MyTextStyle.body.s.copyWith(
            color: MyColors.neutral.dark.light,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Signup',
              style: MyTextStyle.action.m.copyWith(
                color: MyColors.highlight.darkest,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
