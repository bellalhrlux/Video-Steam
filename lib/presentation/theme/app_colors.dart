import 'package:flutter/material.dart';


class AppColors {
  // Static colors that don't change
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Light theme colors
  static const Color primaryLight = Color(0xFF6200EE);
  static const Color primaryLightVariant = Color(0xFF3700B3);
  static const Color secondaryLight = Color(0xFF03DAC6);
  static const Color secondaryLightVariant = Color(0xFF018786);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color errorLight = Color(0xFFB00020);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFF000000);
  static const Color onBackgroundLight = Color(0xFF000000);
  static const Color onSurfaceLight = Color(0xFF000000);
  static const Color onErrorLight = Color(0xFFFFFFFF);

  // Dark theme colors
  static const Color primaryDark = Color(0xFFBB86FC);
  static const Color primaryDarkVariant = Color(0xFF3700B3);
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color secondaryDarkVariant = Color(0xFF03DAC6);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color onPrimaryDark = Color(0xFF000000);
  static const Color onSecondaryDark = Color(0xFF000000);
  static const Color onBackgroundDark = Color(0xFFFFFFFF);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);
  static const Color onErrorDark = Color(0xFF000000);

  // Grey colors
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color greyDark = Color(0xFF424242);

  // SOLUTION 1: Context-aware color getters
  static Color primary(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color onPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  static Color secondary(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color surface(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color onSurface(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  static Color background(BuildContext context) {
    return Theme.of(context).colorScheme.background;
  }

  static Color onBackground(BuildContext context) {
    return Theme.of(context).colorScheme.onBackground;
  }

  static Color error(BuildContext context) {
    return Theme.of(context).colorScheme.error;
  }

  // Custom semantic colors that adapt to theme
  static Color cardBackground(BuildContext context) {
    return Theme.of(context).cardColor;
  }

  static Color divider(BuildContext context) {
    return Theme.of(context).dividerColor;
  }

  static Color disabled(BuildContext context) {
    return Theme.of(context).disabledColor;
  }
}

// 2. Theme Extensions for custom colors
extension CustomColorScheme on ColorScheme {
  Color get gradientStart => brightness == Brightness.light
      ? AppColors.primaryLight
      : AppColors.primaryDark;

  Color get gradientEnd => brightness == Brightness.light
      ? AppColors.primaryLightVariant
      : AppColors.primaryDarkVariant;

  Color get cardShadow => brightness == Brightness.light
      ? AppColors.black.withOpacity(0.1)
      : AppColors.black.withOpacity(0.3);

  Color get iconColor => brightness == Brightness.light
      ? AppColors.onSurfaceLight
      : AppColors.onSurfaceDark;
}

/*
class AppColors {
  // Light Theme Colors
  static const Color primaryLight = Color(0xFF2196F3);
  static const Color primaryLightVariant = Color(0xFF0D47A1);
  static const Color secondaryLight = Color(0xFFFF9800);
  static const Color secondaryLightVariant = Color(0xFFE65100);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color errorLight = Color(0xFFB00020);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFF000000);
  static const Color onBackgroundLight = Color(0xFF000000);
  static const Color onSurfaceLight = Color(0xFF000000);
  static const Color onErrorLight = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryDarkVariant = Color(0xFF0D47A1);
  static const Color secondaryDark = Color(0xFFFF9800);
  static const Color secondaryDarkVariant = Color(0xFFE65100);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color onPrimaryDark = Color(0xFFFFFFFF);
  static const Color onSecondaryDark = Color(0xFF000000);
  static const Color onBackgroundDark = Color(0xFFFFFFFF);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);
  static const Color onErrorDark = Color(0xFF000000);

  // Common Colors
  static const Color transparent = Colors.transparent;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color greyDark = Color(0xFF757575);
}*/
