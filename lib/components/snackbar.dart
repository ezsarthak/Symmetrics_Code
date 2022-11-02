import 'package:flutter/material.dart';
import 'package:main_symmetrics/components/custom_text.dart';
import 'package:main_symmetrics/constants/app_colors.dart';

void getSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        duration: const Duration(seconds: 1),
        padding: const EdgeInsets.all(20),
        content: CustomText(
          textColor: AppColors.secondaryLight,
          textName: title,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
}
