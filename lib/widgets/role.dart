import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_yuktidea/utils/colors.dart';

class RoleWidget extends StatefulWidget {
  final String? src;
  final String? roleText;
  final VoidCallback? callback;
  const RoleWidget({super.key, this.src, this.roleText, this.callback});

  @override
  State<RoleWidget> createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<RoleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.callback,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(-1.w, -1.h),
                      color: const Color.fromRGBO(255, 255, 255, 0.4),
                      blurRadius: 10),
                  BoxShadow(
                      offset: Offset(2.w, 2.h),
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      blurRadius: 12),
                ],
                color: const Color(Constants.background),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xff272727), width: 10)),
            width: 158.w,
            height: 123.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(widget.src!, fit: BoxFit.cover,),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          widget.roleText!,
          style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
