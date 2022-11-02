import 'package:flutter/material.dart';
import 'custom_text.dart';

class SettingsPanel extends StatelessWidget {
  final String panelName;
  final double? paddingBottom;
  final List<Widget> items;
  const SettingsPanel(
      {Key? key,
      required this.panelName,
      required this.items,
      this.paddingBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets panelNamePadding =
        EdgeInsets.only(left: 8, bottom: paddingBottom ?? 12);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: panelNamePadding,
          child: CustomText(
            textName: panelName,
            fontSize: 20,
            textColor: Theme.of(context).textTheme.labelLarge!.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
