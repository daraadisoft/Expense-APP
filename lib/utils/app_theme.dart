import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';
import 'app_size.dart';

class AppTheme {
  static ThemeData get appLightTheme => _appLightTheme;


  static TextStyle getTextStyle({double fontSize = 12 , FontWeight fontWeight = FontWeight.w400 , Color color = Colors.black , TextDecoration? decoration}){
    return GoogleFonts.battambang(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration);
  }

  static final ThemeData _appLightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
      useMaterial3: false,
      scaffoldBackgroundColor: AppColor.white,
      primaryColor: AppColor.primaryColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primaryColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            size: 24,
            color: Colors.white,
          )
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColor.primaryColor,
        splashColor: AppColor.primaryColor
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              return AppColor.white;
            }),
            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return AppColor.primaryColor
                    .withOpacity(0.8); // Darker color when pressed
              }

              if (states.contains(WidgetState.disabled)) {
                return AppColor.grey;
              }

              return AppColor.primaryColor; // Default color
            }),
            minimumSize: WidgetStateProperty.all(const Size(100, 48)),
            padding: WidgetStateProperty.all(
                const EdgeInsets.all(AppSize.defaultPadding)),
            elevation: WidgetStateProperty.all(4),
            textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
              if (states.contains(WidgetState.disabled)) {
                return const TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14);
              }

              return const TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14);
            })),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        iconColor: AppColor.primaryColor,
        contentPadding: const EdgeInsets.all(AppSize.defaultPadding),
        outlineBorder: const BorderSide(color: Colors.black),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.grey, width: 1),
          borderRadius: BorderRadius.circular(AppSize.defaultPadding),
        ),
        errorStyle: const TextStyle(
            color: AppColor.errorColor,
            fontSize: 12,
            fontWeight: FontWeight.w600),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.errorColor, width: 1),
          borderRadius: BorderRadius.circular(AppSize.defaultPadding),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.grey, width: 1),
          borderRadius: BorderRadius.circular(AppSize.defaultPadding),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(AppSize.defaultPadding),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.errorColor, width: 1),
          borderRadius: BorderRadius.circular(AppSize.defaultPadding),
        ),
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      )),
      snackBarTheme: SnackBarThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.defaultPadding),
          ),

          insetPadding: const EdgeInsets.all(AppSize.defaultPadding * 2)
      ),
      bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      elevation: 4,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: AppColor.grey,
      selectedIconTheme: const IconThemeData(
        color: AppColor.primaryColor,
        weight: 2
      ),
      unselectedIconTheme: const IconThemeData(
          color: AppColor.grey,
          weight: 1
      ),
      unselectedLabelStyle: getTextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColor.black
      ),
      selectedLabelStyle: getTextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColor.primaryColor
      )
    ),
      navigationRailTheme:  NavigationRailThemeData(
      elevation: 4,
      backgroundColor: AppColor.primaryColor,
        labelType: NavigationRailLabelType.selected,
        selectedIconTheme: const IconThemeData(
            color: AppColor.white,
            weight: 2
        ),
        unselectedIconTheme: const IconThemeData(
            color: AppColor.grey,
            weight: 1
        ),
        unselectedLabelTextStyle: getTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColor.grey
        ),
        selectedLabelTextStyle: getTextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColor.white
        )
    ),
      datePickerTheme: const DatePickerThemeData(
        headerBackgroundColor: AppColor.primaryColor,
        rangeSelectionBackgroundColor: AppColor.primaryColor,
        rangePickerHeaderForegroundColor: AppColor.white,
        todayBorder: BorderSide(
          color: AppColor.primaryColor,
        ),
        cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStatePropertyAll(TextStyle(color: AppColor.primaryColor))
        ),
        confirmButtonStyle:  ButtonStyle(
            textStyle: WidgetStatePropertyAll(TextStyle(color: AppColor.primaryColor))
        ),
        rangePickerBackgroundColor: AppColor.white,
      ),
  );
}
