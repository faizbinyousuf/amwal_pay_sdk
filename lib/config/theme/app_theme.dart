import 'package:amwalpay/config/theme/app_colors.dart';
import 'package:amwalpay/core/utils/app_dimensions.dart';
import 'package:amwalpay/core/utils/app_strings.dart';

import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  fontFamily: AppStrings.fontFamily,
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.backgorundColor,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent),
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
    onPrimary: AppColors.whiteColor,
    primaryContainer: AppColors.backgorundColor,
    onPrimaryContainer: AppColors.blackColor,
    secondary: AppColors.lightGrayColor,
    onSecondary: AppColors.darkGrayColor,
    secondaryContainer: AppColors.grayColor,
    tertiary: AppColors.darkBlueColor,
    onTertiary: AppColors.blueColor,
    error: AppColors.darkRedColor,
    onError: AppColors.redColor,
    surface: AppColors.backgorundColor,
    surfaceContainer: AppColors.whiteColor,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: InputDecorationTheme(
    constraints: const BoxConstraints(maxHeight: 40),
    hintStyle: const TextStyle(
        color: AppColors.darkGrayColor, fontWeight: FontWeight.w400),
    contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.appPadding),
    filled: true,
    fillColor: AppColors.lightGrayColor,
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: AppColors.grayColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: AppColors.grayColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: AppColors.grayColor,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: AppColors.grayColor,
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(minWidth: 120),
  dividerTheme: const DividerThemeData(
      indent: 0, space: 0, thickness: 0.1, color: AppColors.grayColor),
  outlinedButtonTheme: const OutlinedButtonThemeData(
    style: ButtonStyle(
      side: WidgetStatePropertyAll(
        BorderSide(color: AppColors.primaryColor),
      ),
      padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
      minimumSize: WidgetStatePropertyAll(
        Size(0, 0),
      ),
    ),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStatePropertyAll(0),
      surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
      padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
      minimumSize: WidgetStatePropertyAll(
        Size(80, 0),
      ),
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    side: BorderSide(color: AppColors.grayColor),
  ),
);
