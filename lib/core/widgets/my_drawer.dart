import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileInfoRow(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Dark Mode Toggle
                  ListTile(
                    leading: const Icon(Icons.brightness_6_rounded),
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          _isDarkMode = value;
                          // TODO: add theme-switching logic here
                        });
                      },
                    ),
                  ),
                  // Other Menu Items
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    title: 'Account Information',
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                      // Navigate or perform action
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Password',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildMenuItem(
                    icon: CupertinoIcons.bag,
                    title: 'Order',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    title: 'Wishlist',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            // Logout
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              color: MyColors.support.error.dark,
              onTap: () {
                Navigator.pop(context);
                // TODO: Handle logout logic
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile info row
          // Row(
          //   children: [
          //     // Profile Picture
          //     const CircleAvatar(
          //       radius: 24,
          //       backgroundImage: NetworkImage(
          //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_R2SBa_HY3-SDok8d6qfgujQFK6tJbvLxHtkRs4mjTJC-qIvRH8_aMLnFwfPbrfFoCss&usqp=CAU',
          //       ), // Placeholder image
          //     ),
          //     const HorizontalSpace(12),
          //     // Name and Verified Status
          //     Text('Ahmed Jalambo', style: MyTextStyle.heading.h2),
          //   ],
          // ),
          Row(
            children: [
              Icon(
                Icons.shopping_cart_checkout_outlined,
                color: MyColors.highlight.darkest,
                size: 40,
              ),
              const HorizontalSpace(12),
              Text('eShop', style: MyTextStyle.body.xl),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color, // Optional color for icon and text
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}
