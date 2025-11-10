import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    required this.controller,
    this.validator,
    required this.textInputType,
  });
  final EdgeInsets? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => validator!(value),
      keyboardType: textInputType,
      decoration: InputDecoration(
        isDense: true,
        visualDensity: const VisualDensity(vertical: 0),
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColors.highlight.darkest,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.dg),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.neutral.light.darkest),
              borderRadius: BorderRadius.circular(12.dg),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.support.error.medium),
          borderRadius: BorderRadius.circular(12.dg),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.support.error.medium),
          borderRadius: BorderRadius.circular(12.dg),
        ),

        hintText: hintText,
        hintStyle: MyTextStyle.body.m,

        suffixIcon: suffixIcon,
        suffixIconColor: MyColors.neutral.dark.lightest,

        fillColor: MyColors.neutral.light.lightest,
        filled: true,
        hoverColor: MyColors.highlight.darkest,
      ),

      obscureText: isObscureText ?? false,
      style: MyTextStyle.body.m,
      cursorColor: MyColors.highlight.darkest,
    );
  }
}
