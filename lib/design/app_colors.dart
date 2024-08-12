import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFFFD12D);
  static const Color secondaryColor = Color(0xFFFFF0BB);
  static const Color accentColor = Color(0xFFFFFAEA);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF03384F);
  static const Color disabledColor = Color(0xFFF5F5F5);
  static const Color dividerColor = Color(0xFFE1DDDD);

  static const MaterialColor customSwatch = MaterialColor(
    0xFFFFD12D,
    <int, Color>{
      50: Color(0xFFFFFDF2), // 5% shade
      100: Color(0xFFFFFAEA), // 10% shade
      200: Color(0xFFFFF0BB), // 20% shade
      300: Color(0xFFFFE58B), // 30% shade
      400: Color(0xFFFFDB5C), // 40% shade
      500: Color(0xFFFFD12D), // 60% shade (base)
      600: Color(0xFFDDB21B), // 70% shade
      700: Color(0xFFB38A16), // 80% shade
      800: Color(0xFF8A6210), // 90% shade
      900: Color(0xFF704F0D), // 100% shade
    },
  );
}
