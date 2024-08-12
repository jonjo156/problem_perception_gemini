import 'package:flutter/material.dart';
import 'package:problem_perception_landing/design/app_colors.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    const baseTextTheme = TextTheme(
      titleLarge: TextStyle(
        fontSize: 54,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.textColor,
      ),
    );

    final responsiveTextTheme =
        isSmallScreen ? baseTextTheme.mobile : baseTextTheme;

    return ThemeData(
      // Colors
      primarySwatch: AppColors.customSwatch,
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.accentColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      hoverColor: AppColors.secondaryColor,
      disabledColor: AppColors.disabledColor,
      dividerColor: AppColors.dividerColor,
      // Fonts
      fontFamily: 'Inter',
      textTheme: responsiveTextTheme,
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          textStyle: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
            color: AppColors.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.disabledColor,
        ),
      ),
      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.textColor,
        ),
        titleTextStyle: TextStyle(
          fontSize: isSmallScreen ? 14 : 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}

// Extension for responsive text theme
extension ResponsiveTextTheme on TextTheme {
  TextTheme get mobile {
    return copyWith(
      titleLarge: titleLarge?.copyWith(fontSize: titleLarge!.fontSize! * 0.7),
      titleMedium:
          titleMedium?.copyWith(fontSize: titleMedium!.fontSize! * 0.7),
      titleSmall: titleSmall?.copyWith(fontSize: titleSmall!.fontSize! * 0.7),
      bodyLarge: bodyLarge?.copyWith(fontSize: bodyLarge!.fontSize! * 0.8),
      bodyMedium: bodyMedium?.copyWith(fontSize: bodyMedium!.fontSize! * 0.8),
    );
  }
}
