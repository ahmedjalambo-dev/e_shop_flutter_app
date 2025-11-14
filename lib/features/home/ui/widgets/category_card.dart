import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatelessWidget {
  final String brandLogoUrl;
  const CategoryCard({super.key, required this.brandLogoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 120.w,
      decoration: BoxDecoration(
        color: MyColors.highlight.light,
        borderRadius: BorderRadius.circular(12.dg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.network(
          brandLogoUrl,
          color: MyColors.highlight.darkest,
        ),
      ),
    );
  }
}
