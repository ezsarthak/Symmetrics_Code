import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String textName;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? letterSpacing, lineHeight;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  const CustomText({Key? key, required this.textName, this.fontSize, this.textColor, this.fontWeight, this.letterSpacing, this.lineHeight, this.maxLines, this.softWrap, this.textOverflow, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textName,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: textOverflow,
      style: GoogleFonts.inter(
        fontSize: fontSize?? 16,
        color: textColor ?? Colors.black87,
        fontWeight: fontWeight ?? FontWeight.bold,
        letterSpacing: 1,
        height: lineHeight ?? 1.0,
      ),
    );
  }
}
