import 'package:flutter/material.dart';
import '../constants/dimensions.dart';
import 'custom_text.dart';

class CustomSettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final double? borderRadius;
  final double? titleSize, subtitleSize;
  final VoidCallback? onTap;
  const CustomSettingsTile(
      {Key? key,
      required this.title,
      this.subtitle,
      this.trailing,
      this.borderRadius,
      this.onTap,
      this.titleSize,
      this.subtitleSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius border =
        BorderRadius.circular(borderRadius ?? Dimensions.smallCornerRadius);
    return Material(
      color: Colors.transparent,
      child: ListTile(
        tileColor: Theme.of(context).cardColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // minVerticalPadding: 2,
        enableFeedback: true,

        /// Shape
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: border,
        ),

        /// Elements
        title: CustomText(
          textName: title,
          fontSize: titleSize ?? 18,
          textColor: Theme.of(context).textTheme.titleMedium!.color,
          fontWeight: FontWeight.w600,
        ),
        subtitle: subtitle != null
            ? CustomText(
                textName: subtitle ?? '',
                fontSize: subtitleSize ?? 13,
                fontWeight: FontWeight.w500,
                textColor: Theme.of(context).textTheme.titleSmall!.color,
              )
            : null,
        trailing: trailing,

        /// On Tap
        onTap: onTap ?? () {},
      ),
    );
  }
}
