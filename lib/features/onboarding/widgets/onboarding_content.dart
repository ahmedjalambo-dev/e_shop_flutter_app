import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/image-palceholder.png',
          fit: BoxFit.cover,
          height: 506.h,
        ),
        const VerticalSpace(72),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Text(
                'Create a prototype in just a few minutes',
                style: MyTextStyle.heading.h1,
              ),
              const VerticalSpace(24),
              Text(
                'Enjoy these pre-made components and worry only about creating the best product ever.',
                style: MyTextStyle.body.s.copyWith(
                  color: MyColor.neutral.dark.light,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
