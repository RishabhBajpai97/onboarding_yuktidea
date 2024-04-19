import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 29.w,
            height: 29.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(-1.w, -1.h),
                    color: const Color.fromRGBO(255, 255, 255, 0.4),
                    blurRadius: 5),
                BoxShadow(
                    offset: Offset(1.w, 1.h),
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    blurRadius: 12),
              ],
              shape: BoxShape.circle,
              color: const Color(
                0xff282828,
              ),
            ),
            child: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 24,
            ),
          ),
        ));
  }
}
