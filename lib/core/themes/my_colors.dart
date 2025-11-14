import 'package:flutter/material.dart';

/// A class that holds the color palette from the Figma design.
///
/// This class is not meant to be instantiated. It provides static access
/// to the app's colors, organized by category.
///
/// Example:
/// ```
/// Container(
///   color: MyColor.Highlight.dark,
/// )
/// ```
class MyColors {
  // Private constructor to prevent instantiation.
  MyColors._();

  /// The 'Highlight' color group.
  static const AppHighlightColors highlight = AppHighlightColors._();

  /// The 'Neutral' color group, split into Light and Dark themes.
  static const AppNeutralColors neutral = AppNeutralColors._();

  /// The 'Support' color group for states like success, warning, and error.
  static const AppSupportColors support = AppSupportColors._();
}

/// Helper class for 'Highlight' colors.
class AppHighlightColors {
  const AppHighlightColors._();
  // final Color darkest = const Color(0xFF006FFD);
  // final Color dark = const Color(0xFF2897FF);
  // final Color medium = const Color(0xFF6FB4FF);
  // final Color light = const Color(0xFFB4DBFF);
  // final Color lightest = const Color(0xFFEAF2FF);

  final Color darkest = const Color(0xFFC45A00);
  final Color dark = const Color(0xFFFF8C00);
  final Color medium = const Color(0xFFFFB760);
  final Color light = const Color(0xFFFFD5A5);
  final Color lightest = const Color(0xFFFFEFE0);
}

/// Helper class for 'Neutral' colors.
class AppNeutralColors {
  const AppNeutralColors._();
  final AppNeutralLightColors light = const AppNeutralLightColors._();
  final AppNeutralDarkColors dark = const AppNeutralDarkColors._();
}

/// Helper class for 'Orange Light' colors.
class AppNeutralLightColors {
  const AppNeutralLightColors._();
  final Color darkest = const Color(0xFFFFD5A5); // Lightest Orange-Yellow
  final Color dark = const Color(0xFFFFE3C7);
  final Color medium = const Color(0xFFFFECEF);
  final Color light = const Color(0xFFFFF7F0);
  final Color lightest = const Color(0xFFFFFFFF); // White (for background)
}

/// Helper class for 'Orange Dark' colors.
class AppNeutralDarkColors {
  const AppNeutralDarkColors._();
  final Color darkest = const Color(0xFF6F3300); // Very Dark Brownish Orange
  final Color dark = const Color(0xFF8F4400);
  final Color medium = const Color(0xFFB05700);
  final Color light = const Color(0xFFC45A00); // Deep Burnt Orange
  final Color lightest = const Color(0xFFFF8C00); // Standard Bright Orange
}

/// Helper class for 'Support' colors.
class AppSupportColors {
  const AppSupportColors._();
  final AppSupportSuccessColors success = const AppSupportSuccessColors._();
  final AppSupportWarningColors warning = const AppSupportWarningColors._();
  final AppSupportErrorColors error = const AppSupportErrorColors._();
}

/// Helper class for 'Support Success' colors.
class AppSupportSuccessColors {
  const AppSupportSuccessColors._();
  final Color dark = const Color(0xFF298267);
  final Color medium = const Color(0xFF3AC0A0);
  final Color light = const Color(0xFFE7F4EB);
}

/// Helper class for 'Support Warning' colors.
class AppSupportWarningColors {
  const AppSupportWarningColors._();
  final Color dark = const Color(0xFFE86339);
  final Color medium = const Color(0xFFFFB37C);
  final Color light = const Color(0xFFFFF4E4);
}

/// Helper class for 'Support Error' colors.
class AppSupportErrorColors {
  const AppSupportErrorColors._();
  final Color dark = const Color(0xFFED3241);
  final Color medium = const Color(0xFFFF816D);
  final Color light = const Color(0xFFFFE2E5);
}
