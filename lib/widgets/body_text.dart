import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBodyText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  const CustomBodyText(
      {super.key, this.color = Colors.white, this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text!,
      style: TextStyle(color: color, fontSize: fontSize ?? 14.sp),
    );
  }
}
