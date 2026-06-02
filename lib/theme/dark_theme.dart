// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

import '../util/dimensions.dart';

ThemeData dark = ThemeData(
  fontFamily: 'FKGroteskNeueTrial',
  primaryColor: const Color(0xFFFC8200),
  scaffoldBackgroundColor: const Color(0xFF232531),
  disabledColor: const Color(0xFF6f7275),
  brightness: Brightness.dark,
  indicatorColor: const Color(0xFFF3F5F7),
  hintColor: const Color(0xFFbebebe),
  cardColor: const Color(0xFF333645),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFFC8200),
    secondary: Color(0xFFFC8200),
    error: Color(0xFFE84D4F),
  ),
  primarySwatch: AppColor.primarySwatchValueColor,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'FKGroteskNeueTrial',
      fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: 'FKGroteskNeueTrial',
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      fontWeight: FontWeight.bold,
      color: Colors.white70,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'FKGroteskNeueTrial',
      fontSize: Dimensions.FONT_SIZE_LARGE,
      fontWeight: FontWeight.normal,
      color: Colors.white70,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'FKGroteskNeueTrial',
      fontSize: Dimensions.FONT_SIZE_DEFAULT,
      fontWeight: FontWeight.normal,
      color: Colors.white54,
    ),
    bodySmall: TextStyle(
      fontFamily: 'FKGroteskNeueTrial',
      fontSize: Dimensions.FONT_SIZE_SMALL,
      fontWeight: FontWeight.normal,
      color: Colors.white38,
    ),
  ),
);

class AppColor {
  // Brand Colors
  static const Color primaryColor = Color(0xFF232F3E);
  static const Color secondaryColor = Color(0xFFFF9900);

  // Background
  static const Color scaffoldBackground = Color(0xFFF5F6FA);
  static const Color cardColor = Color(0xFFFFFFFF);

  // Text Colors
  static const Color titleColor = Color(0xFF1A1A1A);
  static const Color bodyColor = Color(0xFF666666);
  static const Color hintColor = Color(0xFF999999);

  // Status Colors
  static const Color successColor = Color(0xFF2ECC71);
  static const Color warningColor = Color(0xFFF39C12);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color infoColor = Color(0xFF3498DB);

  // Product UI
  static const Color discountColor = Color(0xFFE53935);
  static const Color ratingColor = Color(0xFFFFC107);
  static const Color favoriteColor = Color(0xFFFF4D6D);

  // Border & Divider
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color dividerColor = Color(0xFFF0F0F0);

  // Buttons
  static const Color buttonColor = primaryColor;
  static const Color buttonTextColor = Colors.white;

  // Misc
  static const Color disabledColor = Color(0xFFBDBDBD);
  static const Color shadowColor = Color(0x14000000);

  static const int primarySwatchValue = 0xFFFC8200;
  static const MaterialColor primarySwatchValueColor =
      MaterialColor(primarySwatchValue, <int, Color>{
        50: Color(primarySwatchValue),
        100: Color(primarySwatchValue),
        200: Color(primarySwatchValue),
        300: Color(primarySwatchValue),
        400: Color(primarySwatchValue),
        500: Color(primarySwatchValue),
        600: Color(primarySwatchValue),
        700: Color(primarySwatchValue),
        800: Color(primarySwatchValue),
        900: Color(primarySwatchValue),
      });
}
