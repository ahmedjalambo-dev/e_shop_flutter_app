// lib/features/home/ui/product_details_screen.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_button.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_state.dart';
import 'package:e_shop_flutter_app/features/home/data/models/products_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar with Back Button and Favorite
          SliverAppBar(
            expandedHeight: 350.h,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            // ✅ FORCE SHOW LEADING WIDGET
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: MyColors.neutral.dark.darkest,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    final isFav = context.watch<FavoriteCubit>().isFavorite(
                      product.id,
                    );
                    return GestureDetector(
                      onTap: () {
                        context.read<FavoriteCubit>().toggleFavorite(product);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav
                              ? MyColors.support.error.dark
                              : MyColors.neutral.dark.dark,
                          size: 22,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product_${product.id}',
                child: CachedNetworkImage(
                  imageUrl: product.coverPictureUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: MyColors.highlight.darkest,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),

          // Product Details Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.dg),
                  topRight: Radius.circular(24.dg),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.categories.map((category) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: MyColors.highlight.lightest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category.toUpperCase(),
                            style: MyTextStyle.body.xs.copyWith(
                              color: MyColors.highlight.darkest,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const VerticalSpace(16),

                    // Product Name
                    Text(product.name, style: MyTextStyle.heading.h1),
                    const VerticalSpace(8),

                    // Rating and Reviews
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const HorizontalSpace(4),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: MyTextStyle.body.m.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const HorizontalSpace(8),
                        Text(
                          '(${product.reviewsCount} reviews)',
                          style: MyTextStyle.body.s.copyWith(
                            color: MyColors.neutral.dark.light,
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpace(16),

                    // Price and Discount
                    Row(
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: MyTextStyle.heading.h2.copyWith(
                            color: MyColors.highlight.darkest,
                          ),
                        ),
                        if (product.discountPercentage > 0) ...[
                          const HorizontalSpace(12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.support.error.light,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '-${product.discountPercentage.toInt()}%',
                              style: MyTextStyle.body.xs.copyWith(
                                color: MyColors.support.error.dark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const VerticalSpace(24),

                    // Stock Status
                    _buildInfoRow(
                      icon: Icons.inventory_2_outlined,
                      label: 'Stock',
                      value: product.stock > 0
                          ? '${product.stock} available'
                          : 'Out of stock',
                      valueColor: product.stock > 0
                          ? MyColors.support.success.dark
                          : MyColors.support.error.dark,
                    ),
                    const VerticalSpace(12),

                    // Color
                    _buildInfoRow(
                      icon: Icons.palette_outlined,
                      label: 'Color',
                      value: product.color,
                    ),
                    const VerticalSpace(12),

                    // Weight
                    _buildInfoRow(
                      icon: Icons.scale_outlined,
                      label: 'Weight',
                      value: '${product.weight}kg',
                    ),
                    const VerticalSpace(12),

                    // Product Code
                    _buildInfoRow(
                      icon: Icons.qr_code_outlined,
                      label: 'Product Code',
                      value: product.productCode,
                    ),
                    const VerticalSpace(24),

                    // Description Section
                    Text('Description', style: MyTextStyle.heading.h3),
                    const VerticalSpace(12),
                    Text(
                      product.description,
                      style: MyTextStyle.body.m.copyWith(
                        color: MyColors.neutral.dark.light,
                        height: 1.5,
                      ),
                    ),
                    const VerticalSpace(24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Add to Cart Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Quantity Selector (Optional - can be expanded)
              Expanded(
                child: MyTextButton(
                  text: 'Add to Cart',
                  backgroundColor: MyColors.highlight.darkest,
                  textStyle: MyTextStyle.action.l.copyWith(color: Colors.white),
                  onPressed: () {
                    // TODO: Implement add to cart functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart!'),
                        backgroundColor: MyColors.support.success.dark,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: MyColors.neutral.dark.light),
        const HorizontalSpace(8),
        Text(
          '$label: ',
          style: MyTextStyle.body.m.copyWith(
            color: MyColors.neutral.dark.light,
          ),
        ),
        Text(
          value,
          style: MyTextStyle.body.m.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? MyColors.neutral.dark.darkest,
          ),
        ),
      ],
    );
  }
}
