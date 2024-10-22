// ignore_for_file: must_be_immutable

import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function()? onPressed;
  Color backgroundColor;
  Widget child;

  CustomButton(
      {super.key, required this.child,
      this.onPressed,
      this.backgroundColor = AppColor.primaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            return AppColor.white;
          }),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.pressed)) {
              return backgroundColor.withOpacity(0.8); // Darker color when pressed
            }

            if (states.contains(WidgetState.disabled)) {
              return AppColor.grey;
            }

            return backgroundColor; // Default color
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
      child: child,
    );
  }
}
