import 'package:flutter/material.dart';
import 'package:main_symmetrics/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget buttonContent;
  final double? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsets? padding;
  final Border? border;
  final VoidCallback? onPressed;
  const CustomButton(
      {Key? key,
      required this.buttonContent,
      this.borderRadius,
      this.backgroundColor,
      this.padding,
      this.onPressed,
      this.margin,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double defaultBorderRadius = 16;
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        margin: margin ?? const EdgeInsets.all(0),
        padding: padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: border ?? Border.all(width: 0, color: Colors.transparent),
          borderRadius:
              BorderRadius.circular(borderRadius ?? defaultBorderRadius),
          color: backgroundColor ?? AppColors.secondaryLight,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed ?? () {},
            borderRadius:
                BorderRadius.circular(borderRadius ?? defaultBorderRadius),
            child: buttonContent,
          ),
        ),
      ),
    );
  }
}
