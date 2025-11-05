import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// The font family specified in the design.
const String kFontFamily = 'Inter';

/// A class that holds the text styles from the Figma design.
///
/// This class is not meant to be instantiated. It provides static access
/// to the app's text styles, organized by category.
///
/// Example:
/// ```
/// Text(
///   'Hello World',
///   style: MyTextStyle.Heading.h1,
/// )
/// ```
class MyTextStyle {
  // Private consructor to prevent instantiation.
  MyTextStyle._();

  /// 'Heading' text styles (H1-H5).
  static AppHeadingStyles heading = AppHeadingStyles._();

  /// 'Body' text styles (XL-XS).
  static AppBodyStyles body = AppBodyStyles._();

  /// 'Action' text styles (L-S).
  static AppActionStyles action = AppActionStyles._();

  /// 'Caption' text styles (M).
  static AppCaptionStyles caption = AppCaptionStyles._();
}

/// Helper class for 'Heading' text styles.
class AppHeadingStyles {
  AppHeadingStyles._();

  final TextStyle h1 = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w800, // Extra bold
    fontSize: 24.0.sp,
  );

  final TextStyle h2 = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w800, // Extra bold
    fontSize: 18.0.sp,
  );

  final TextStyle h3 = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w800, // Extra bold
    fontSize: 16.0.sp,
  );

  final TextStyle h4 = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w700, // Bold
    fontSize: 14.0.sp,
  );

  final TextStyle h5 = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w700, // Bold
    fontSize: 12.0.sp,
  );
}

/// Helper class for 'Body' text styles.
class AppBodyStyles {
  AppBodyStyles._();

  final TextStyle xl = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w400, // Regular
    fontSize: 18.0.sp,
  );

  final TextStyle l = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w400, // Regular
    fontSize: 16.0.sp,
  );

  final TextStyle m = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w400, // Regular
    fontSize: 14.0.sp,
  );

  final TextStyle s = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w400, // Regular
    fontSize: 12.0.sp,
  );

  final TextStyle xs = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w500, // Medium
    fontSize: 10.0.sp,
  );
}

/// Helper class for 'Action' text styles.
class AppActionStyles {
  AppActionStyles._();

  final TextStyle l = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w600, // Semi Bold
    fontSize: 14.0.sp,
  );

  final TextStyle m = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w600, // Semi Bold
    fontSize: 12.0.sp,
  );

  final TextStyle s = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w600, // Semi Bold
    fontSize: 10.0.sp,
  );
}

/// Helper class for 'Caption' text styles.
class AppCaptionStyles {
  AppCaptionStyles._();

  final TextStyle m = TextStyle(
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w600, // Semi Bold
    fontSize: 10.0.sp,
  );
}
