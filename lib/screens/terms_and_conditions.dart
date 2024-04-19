import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_yuktidea/services/user_service.dart';
import 'package:onboarding_yuktidea/utils/colors.dart';
import 'package:onboarding_yuktidea/widgets/body_text.dart';

class TermsAndConditions extends ConsumerStatefulWidget {
  const TermsAndConditions({super.key});

  @override
  ConsumerState<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends ConsumerState<TermsAndConditions> {
  dynamic data;

  @override
  void initState() {
    _getTermsAndConditions();
    super.initState();
  }

  _getTermsAndConditions() async {
    var response = await ref.read(userServiceProvider).getTermsAndConditions();
    setState(() {
      data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(Constants.background),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: data == null
                ? const CircularProgressIndicator(
                    color: Color(Constants.formIconColor),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
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
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 0.4),
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
                                  Icons.close,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        if (data != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 65.h,
                                width: 55.w,
                                child: Image.asset(
                                  "assets/t&c.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                children: [
                                  Text(
                                    data["title"],
                                    style: TextStyle(
                                        color: const Color(
                                          0xffD9896A,
                                        ),
                                        fontSize: 18.sp),
                                  ),
                                  SizedBox(height: 10.h,),
                                  const CustomBodyText(
                                    text: "Update 16/03/2023 ",
                                    color: Color(Constants.placeholder),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Html(
                          data: data["content"],
                          style: {
                            "p": Style(
                                color: Colors.white,
                                fontSize: FontSize(12.sp),
                                textAlign: TextAlign.justify),
                            "h1": Style(
                                color: const Color(Constants.formIconColor),
                                fontSize: FontSize(14.sp)),
                            "li": Style(
                                color: Colors.white, fontSize: FontSize(12.sp))
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
