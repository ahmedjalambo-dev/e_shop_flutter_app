import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/features/home/cubit/products_cubit.dart';
import 'package:e_shop_flutter_app/features/home/cubit/products_state.dart';
import 'package:e_shop_flutter_app/features/home/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBlocBuilder extends StatelessWidget {
  const ProductsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
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
          success: (prodcutResponse) => GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              childAspectRatio: 0.5,
            ),
            itemCount: prodcutResponse.items.length,
            itemBuilder: (context, index) {
              return ProductCard(product: prodcutResponse.items[index]);
            },
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
