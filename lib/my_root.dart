import 'package:e_shop_flutter_app/core/di/injection.dart';
import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
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
    const Text('Favorite', style: optionStyle),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: _screens.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: MyColors.highlight.lightest,
              spreadRadius: 0.5,
            ),
          ],
        ),
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
              tabBackgroundColor: MyColors.highlight.light,
              color: MyColors.neutral.light.darkest,
              tabs: [
                const GButton(icon: Icons.home_filled, text: 'Home'),
                const GButton(icon: CupertinoIcons.cart, text: 'Cart'),
                const GButton(
                  icon: Icons.favorite_border_rounded,
                  text: 'Favorite',
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
