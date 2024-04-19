import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? method;
  final int? width;
  final Color? color;

  const CustomButton(
      {super.key, this.text, this.method, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: method,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromRGBO(255, 255, 255, 0.02), width: 2),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-1.w, -1.h),
                  color: const Color.fromRGBO(255, 255, 255, 0.4),
                  blurRadius: 10),
              BoxShadow(
                  offset: Offset(1.w, 1.h),
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  blurRadius: 12),
            ],
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xff212426)),
        width: width!.w,
        child: Text(
          text!,
          style: TextStyle(color: color, fontSize: 18.sp),
        ),
      ),
    );
  }
}
