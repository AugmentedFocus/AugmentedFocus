import 'package:flutter/material.dart';
import 'package:augmentedfocus/config/theme/app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    final MaterialColor primarySwatch = MaterialColor(
      AppColors.primaryColor.value,
      {
        50: AppColors.primaryColor.withOpacity(0.1),
        100: AppColors.primaryColor.withOpacity(0.2),
        200: AppColors.primaryColor.withOpacity(0.3),
        300: AppColors.primaryColor.withOpacity(0.4),
        400: AppColors.primaryColor.withOpacity(0.5),
        500: AppColors.primaryColor.withOpacity(0.6),
        600: AppColors.primaryColor.withOpacity(0.7),
        700: AppColors.primaryColor.withOpacity(0.8),
        800: AppColors.primaryColor.withOpacity(0.9),
        900: AppColors.primaryColor.withOpacity(1),
      },
    );

    final MaterialColor secondarySwatch = MaterialColor(
      AppColors.secondaryColor.value,
      {
        50: AppColors.secondaryColor.withOpacity(0.1),
        100: AppColors.secondaryColor.withOpacity(0.2),
        200: AppColors.secondaryColor.withOpacity(0.3),
        300: AppColors.secondaryColor.withOpacity(0.4),
        400: AppColors.secondaryColor.withOpacity(0.5),
        500: AppColors.secondaryColor.withOpacity(0.6),
        600: AppColors.secondaryColor.withOpacity(0.7),
        700: AppColors.secondaryColor.withOpacity(0.8),
        800: AppColors.secondaryColor.withOpacity(0.9),
        900: AppColors.secondaryColor.withOpacity(1),
      },
    );

    final MaterialColor backgroundColor = MaterialColor(
      AppColors.backgroundColor.value,
      {
        50: AppColors.backgroundColor.withOpacity(0.1),
        100: AppColors.backgroundColor.withOpacity(0.2),
        200: AppColors.backgroundColor.withOpacity(0.3),
        300: AppColors.backgroundColor.withOpacity(0.4),
        400: AppColors.backgroundColor.withOpacity(0.5),
        500: AppColors.backgroundColor.withOpacity(0.6),
        600: AppColors.backgroundColor.withOpacity(0.7),
        700: AppColors.backgroundColor.withOpacity(0.8),
        800: AppColors.backgroundColor.withOpacity(0.9),
        900: AppColors.backgroundColor.withOpacity(1),
      },
    );

    final MaterialColor surfaceColor = MaterialColor(
      AppColors.surfaceColor.value,
      {
        50: AppColors.surfaceColor.withOpacity(0.1),
        100: AppColors.surfaceColor.withOpacity(0.2),
        200: AppColors.surfaceColor.withOpacity(0.3),
        300: AppColors.surfaceColor.withOpacity(0.4),
        400: AppColors.surfaceColor.withOpacity(0.5),
        500: AppColors.surfaceColor.withOpacity(0.6),
        600: AppColors.surfaceColor.withOpacity(0.7),
        700: AppColors.surfaceColor.withOpacity(0.8),
        800: AppColors.surfaceColor.withOpacity(0.9),
        900: AppColors.surfaceColor.withOpacity(1),
      },
    );

    final MaterialColor accentColor = MaterialColor(
      AppColors.accentColor.value,
      {
        50: AppColors.accentColor.withOpacity(0.1),
        100: AppColors.accentColor.withOpacity(0.2),
        200: AppColors.accentColor.withOpacity(0.3),
        300: AppColors.accentColor.withOpacity(0.4),
        400: AppColors.accentColor.withOpacity(0.5),
        500: AppColors.accentColor.withOpacity(0.6),
        600: AppColors.accentColor.withOpacity(0.7),
        700: AppColors.accentColor.withOpacity(0.8),
        800: AppColors.accentColor.withOpacity(0.9),
        900: AppColors.accentColor.withOpacity(1),
      },
    );

    final MaterialColor onPrimaryColor = MaterialColor(
      AppColors.onPrimaryColor.value,
      {
        50: AppColors.onPrimaryColor.withOpacity(0.1),
        100: AppColors.onPrimaryColor.withOpacity(0.2),
        200: AppColors.onPrimaryColor.withOpacity(0.3),
        300: AppColors.onPrimaryColor.withOpacity(0.4),
        400: AppColors.onPrimaryColor.withOpacity(0.5),
        500: AppColors.onPrimaryColor.withOpacity(0.6),
        600: AppColors.onPrimaryColor.withOpacity(0.7),
        700: AppColors.onPrimaryColor.withOpacity(0.8),
        800: AppColors.onPrimaryColor.withOpacity(0.9),
        900: AppColors.onPrimaryColor.withOpacity(1),
      },
    );

    final MaterialColor errorColor = MaterialColor(
      AppColors.errorColor.value,
      {
        50: AppColors.errorColor.withOpacity(0.1),
        100: AppColors.errorColor.withOpacity(0.2),
        200: AppColors.errorColor.withOpacity(0.3),
        300: AppColors.errorColor.withOpacity(0.4),
        400: AppColors.errorColor.withOpacity(0.5),
        500: AppColors.errorColor.withOpacity(0.6),
        600: AppColors.errorColor.withOpacity(0.7),
        700: AppColors.errorColor.withOpacity(0.8),
        800: AppColors.errorColor.withOpacity(0.9),
        900: AppColors.errorColor.withOpacity(1),
      },
    );

    return ThemeData(
      primarySwatch: primarySwatch,
    );
  }
}