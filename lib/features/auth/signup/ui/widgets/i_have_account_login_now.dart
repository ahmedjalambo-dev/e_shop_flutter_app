import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class IHaveAnAccountLoginNow extends StatelessWidget {
  final void Function()? onTap;
  const IHaveAnAccountLoginNow({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'Already have an account? ',
          style: MyTextStyle.body.s.copyWith(color: MyColor.neutral.dark.light),
          children: <TextSpan>[
            TextSpan(
              text: 'Login',
              style: MyTextStyle.action.m.copyWith(
                color: MyColor.highlight.darkest,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
