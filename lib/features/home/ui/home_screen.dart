import 'package:e_shop_flutter_app/core/widgets/my_drawer.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/home/ui/widgets/categories_bloc_builder.dart';
import 'package:e_shop_flutter_app/features/home/ui/widgets/products_bloc_builder.dart';
import 'package:e_shop_flutter_app/features/home/ui/widgets/title_view_all.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const VerticalSpace(12),
            TitleSeeMore(title: 'Choose Brand', onPressed: () {}),
            const VerticalSpace(8),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 24, end: 24),
                child: CategoriesBlocBuilder(),
              ),
            ),
            const VerticalSpace(12),
            TitleSeeMore(title: 'For You', onPressed: () {}),
            const VerticalSpace(8),
            const Padding(
              padding: EdgeInsetsDirectional.only(start: 24, end: 24),
              child: ProductsBlocBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
