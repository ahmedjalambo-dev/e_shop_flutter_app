import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_state.dart'; // Import the state
import 'package:e_shop_flutter_app/features/home/data/models/products_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double horizontalPadding;
  final double verticalPadding;

  const ProductCard({
    super.key,
    required this.product,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.dg)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.dg),
                  child: CachedNetworkImage(
                    imageUrl: product.coverPictureUrl,
                    width: double.maxFinite,
                    height: 180.h,
                    fit: BoxFit.cover,
                  ),
                ),
                // --- FAVORITE BUTTON ADDED HERE ---
                Positioned(
                  top: 8,
                  right: 8,
                  // We need to listen for state changes
                  child: BlocBuilder<FavoriteCubit, FavoriteState>(
                    builder: (context, state) {
                      // Get the simple boolean from the cubit
                      final isFav = context.watch<FavoriteCubit>().isFavorite(
                        product.id,
                      );
                      return CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white.withOpacity(0.85),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 20,
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav
                                ? MyColors.support.error.dark
                                : MyColors.neutral.dark.dark,
                          ),
                          onPressed: () {
                            // Call the cubit's toggle method
                            context.read<FavoriteCubit>().toggleFavorite(
                              product,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                // --- END OF FAVORITE BUTTON ---
              ],
            ),
            const VerticalSpace(5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.categories.first.toUpperCase(),
                  style: MyTextStyle.heading.h5,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.name,
                  style: MyTextStyle.body.m,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const VerticalSpace(2),
                Text(
                  '\$${product.price.toInt()}',
                  style: MyTextStyle.heading.h4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
