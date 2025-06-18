import 'package:flutter/material.dart';

class ResponsiveLayout {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1200;


  // Grid configurations
  static const int mobileColumns = 2;
  static const int tabletColumns = 4;
  static const int desktopColumns = 8;

  // Get columns based on screen width
  static int getColumns(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < mobileBreakpoint) {
      return mobileColumns;
    } else if (screenWidth < tabletBreakpoint) {
      return tabletColumns;
    } else {
      return desktopColumns;
    }
  }

  // Get responsive spacing
  static int getCrossAxisItemCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < mobileBreakpoint) {
      return 2;
    } else if (screenWidth < tabletBreakpoint) {
      return 4;
    } else {
      return 8;
    }
  }

  // Get responsive padding
  static EdgeInsets getPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < mobileBreakpoint) {
      return const EdgeInsets.all(8.0);
    } else if (screenWidth < tabletBreakpoint) {
      return const EdgeInsets.all(16.0);
    } else {
      return const EdgeInsets.all(24.0);
    }
  }

  // Get aspect ratio based on device type
  static double getAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < mobileBreakpoint) {
      return 1.0; // Square for mobile
    } else if (screenWidth < tabletBreakpoint) {
      return 1.2; // Slightly rectangular for tablet
    } else {
      return 1.3; // More rectangular for desktop
    }
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= mobileBreakpoint;
  }
}