import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_state.dart';
import 'package:e_shop_flutter_app/features/home/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // No need to provide FavoriteCubit here, it's provided in MyRouter
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Favorites')),
            loading: () => Center(
              child: CircularProgressIndicator(
                color: MyColors.highlight.darkest,
              ),
            ),
            loaded: (favorites, favoriteIds) {
              if (favorites.isEmpty) {
                return Center(
                  child: Text(
                    'No favorites yet.',
                    style: MyTextStyle.body.l.copyWith(
                      color: MyColors.neutral.dark.light,
                    ),
                  ),
                );
              }
              // We use GridView.builder for performance
              return GridView.builder(
                padding: const EdgeInsets.all(24.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio:
                      0.5, // Matches the aspect ratio on HomeScreen
                ),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  // We already have the full Product object
                  return ProductCard(product: favorites[index]);
                },
              );
            },
            error: (message) => Center(
              child: Text(
                message,
                style: MyTextStyle.body.l.copyWith(
                  color: MyColors.support.error.dark,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
