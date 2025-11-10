import 'package:e_shop_flutter_app/features/home/ui/widgets/category_card.dart';
import 'package:flutter/widgets.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: List.generate(10, (index) {
        return const CategoryCard(
          brandLogoUrl:
              'https://upload.wikimedia.org/wikipedia/commons/c/c5/Gucci_logo.svg',
        );
      }),
    );
  }
}
