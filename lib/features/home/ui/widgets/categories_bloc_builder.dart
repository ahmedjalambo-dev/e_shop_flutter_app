import 'package:e_shop_flutter_app/features/home/cubit/categories_cubit/categories_cubit.dart';
import 'package:e_shop_flutter_app/features/home/cubit/categories_cubit/categories_state.dart';
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
          failure: (errorHandler) => const SizedBox.shrink(),
          success: (categoriesResponse) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
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
