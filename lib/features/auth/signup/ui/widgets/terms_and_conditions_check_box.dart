import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsCheckbox extends StatefulWidget {
  const TermsAndConditionsCheckbox({super.key});

  @override
  State<TermsAndConditionsCheckbox> createState() =>
      _TermsAndConditionsCheckboxState();
}

class _TermsAndConditionsCheckboxState
    extends State<TermsAndConditionsCheckbox> {
  bool _isChecked = false;

  late TapGestureRecognizer _termsRecognizer;
  late TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();

    _termsRecognizer = TapGestureRecognizer()
      ..onTap = () {
        // TODO: Tapped terms and conditions
      };

    _privacyRecognizer = TapGestureRecognizer()
      ..onTap = () {
        // TODO: Tapped Privacy Policy
      };
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: MyColor.highlight.dark,
          value: _isChecked,
          onChanged: (bool? newValue) =>
              setState(() => _isChecked = newValue ?? false),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0.dg),
            side: const BorderSide(width: 24),
          ),
          side: BorderSide(width: 1.5, color: MyColor.neutral.light.darkest),
        ),
        const HorizontalSpace(12),
        Flexible(
          child: Text.rich(
            TextSpan(
              text: "I've read and agree with the ",
              style: MyTextStyle.body.s.copyWith(
                color: MyColor.neutral.dark.light,
              ),
              children: [
                TextSpan(
                  text: 'Terms and Conditions',
                  style: MyTextStyle.action.m.copyWith(
                    color: MyColor.highlight.darkest,
                  ),
                  recognizer: _termsRecognizer,
                ),
                TextSpan(
                  text: ' and the ',
                  style: MyTextStyle.body.s.copyWith(
                    color: MyColor.neutral.dark.light,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: MyTextStyle.action.m.copyWith(
                    color: MyColor.highlight.darkest,
                  ),
                  recognizer: _privacyRecognizer,
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
