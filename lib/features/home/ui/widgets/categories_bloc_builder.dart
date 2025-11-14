import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/features/home/cubit/categories_cubit.dart';
import 'package:e_shop_flutter_app/features/home/cubit/categories_state.dart';
import 'package:e_shop_flutter_app/features/home/ui/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBlocBuilder extends StatelessWidget {
  const CategoriesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (previous, current) =>
          current is Loading || current is Success || current is Failure,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (errorHandler) => Center(
            child: Text(
              errorHandler,
              style: MyTextStyle.caption.m.copyWith(
                color: MyColors.support.error.dark,
              ),
            ),
          ),
          success: (categoriesResponse) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 12,
              children: List.generate(categoriesResponse.categories.length, (
                index,
              ) {
                return CategoryCard(
                  brandLogoUrl:
                      categoriesResponse.categories[index].coverPictureUrl,
                );
              }),
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
