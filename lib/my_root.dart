import 'package:e_shop_flutter_app/core/di/injection.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_drawer.dart';
import 'package:e_shop_flutter_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:e_shop_flutter_app/features/favorite/ui/favorite_screen.dart';
import 'package:e_shop_flutter_app/features/home/cubit/categories_cubit.dart';
import 'package:e_shop_flutter_app/features/home/cubit/products_cubit.dart';
import 'package:e_shop_flutter_app/features/home/ui/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyRoot extends StatefulWidget {
  const MyRoot({super.key});

  @override
  State<MyRoot> createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
  static final List<Widget> _screens = <Widget>[
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CategoriesCubit>()..emitCategoriesStates(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductsCubit>()..emitProductsStates(),
        ),
      ],
      child: const HomeScreen(),
    ),
    const Text('Cart', style: optionStyle),
    const FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          const Padding(
            padding: EdgeInsetsDirectional.only(end: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_R2SBa_HY3-SDok8d6qfgujQFK6tJbvLxHtkRs4mjTJC-qIvRH8_aMLnFwfPbrfFoCss&usqp=CAU',
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      drawer: const MyDrawer(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GNav(
              tabBorderRadius: 16.sp,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: MyColors.highlight.darkest,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: MyColors.highlight.lightest,
              color: MyColors.neutral.light.dark,
              tabs: [
                GButton(
                  icon: Icons.home_filled,
                  text: 'Home',
                  textStyle: MyTextStyle.heading.h5.copyWith(
                    color: MyColors.highlight.darkest,
                  ),
                ),

                GButton(
                  icon: Icons.shopping_bag_rounded,
                  text: 'Cart',
                  textStyle: MyTextStyle.heading.h5.copyWith(
                    color: MyColors.highlight.darkest,
                  ),
                ),
                GButton(
                  icon: Icons.favorite_rounded,
                  text: 'Favorite',
                  textStyle: MyTextStyle.heading.h5.copyWith(
                    color: MyColors.highlight.darkest,
                  ),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) => setState(() => _selectedIndex = index),
            ),
          ),
        ),
      ),
    );
  }
}
