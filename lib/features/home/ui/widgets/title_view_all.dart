import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:flutter/material.dart';

class TitleSeeMore extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const TitleSeeMore({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: MyTextStyle.heading.h4),
          TextButton(
            onPressed: onPressed,
            child: Text('View All', style: MyTextStyle.action.m),
          ),
        ],
      ),
    );
  }
}
