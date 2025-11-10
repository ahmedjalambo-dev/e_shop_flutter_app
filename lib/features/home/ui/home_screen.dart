import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/home/ui/widgets/categories_bloc_builder.dart';
import 'package:e_shop_flutter_app/features/home/ui/widgets/category_cards_list.dart';
import 'package:e_shop_flutter_app/features/home/ui/widgets/title_see_more.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.highlight.darkest,
        title: Text(
          'E-Shop',
          style: MyTextStyle.heading.h2.copyWith(
            color: MyColors.highlight.lightest,
          ),
        ),
      ),
      body: Column(
        children: [
          const VerticalSpace(12),
          TitleSeeMore(title: 'Choose Brand', onPressed: () {}),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 24, end: 24),
              child: CategoriesBlocBuilder(),
            ),
          ),
        ],
      ),
    );
  }
}
