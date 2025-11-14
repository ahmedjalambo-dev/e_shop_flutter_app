import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/db/shared_pref_helper.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/onboarding/widgets/onboarding_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 0,
              maxWidth: double.infinity,
              minHeight: 0,
              maxHeight: 705.h,
            ),
            child: PageView(
              children: [
                const OnboardingContent(),
                const OnboardingContent(),
                const OnboardingContent(),
              ],
            ),
          ),
          const VerticalSpace(32),
          MyTextButton(
            text: 'Get Started',
            onPressed: () async {
              await SharedPrefHelper.setData(SharedPrefKeys.isFirstTime, false);
              if (context.mounted) {
                context.pushReplacementNamed(MyRoutes.login);
              }
            },
            backgroundColor: MyColors.highlight.darkest,
            horizontalPadding: 24.w,
          ),
        ],
      ),
    );
  }
}
