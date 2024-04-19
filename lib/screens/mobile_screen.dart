import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onboarding_yuktidea/notifiers/user_notifier.dart';
import 'package:onboarding_yuktidea/services/user_service.dart';
import 'package:onboarding_yuktidea/utils/colors.dart';
import 'package:onboarding_yuktidea/widgets/back_button.dart';
import 'package:onboarding_yuktidea/widgets/body_text.dart';
import 'package:onboarding_yuktidea/widgets/custom_button.dart';
import 'package:onboarding_yuktidea/widgets/title_text.dart';

class MobileNumber extends ConsumerStatefulWidget {
  const MobileNumber({
    super.key,
  });

  @override
  ConsumerState<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends ConsumerState<MobileNumber> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  String error = "";
  double opacity = 0.4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(Constants.background),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    const CustomBackButton(),
                    SizedBox(
                      height: 20.h,
                    ),
                    const CustomTitle(
                      text: "Enter Phone Number",
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const CustomBodyText(
                      text:
                          "Please enter your 10 digit mobile number to receive OTP",
                      color: Color(Constants.formIconColor),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(Constants.inputBorderColor),
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 23.h,
                            child: SvgPicture.network(ref
                                .watch(userNotifierProvider.notifier)
                                .getMobileCountry()["flag"]),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            ref
                                .watch(userNotifierProvider.notifier)
                                .getMobileCountry()["tel_code"],
                            style: const TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _numberController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value.isNotEmpty && value.length >= 10) {
                                  setState(() {
                                    opacity = 1;
                                  });
                                } else {
                                  setState(() {
                                    opacity = 0.4;
                                  });
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    error = "Please Enter Number";
                                    opacity = 0.4;
                                  });
                                } else if (value.length < 10) {
                                  setState(() {
                                    error = "Please enter valid Number";
                                    opacity = 0.4;
                                  });
                                } else {
                                  setState(() {
                                    error = "";
                                  });
                                }
                                return null;
                              },
                              cursorColor: Colors.white,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "9999999999",
                                hintStyle: TextStyle(
                                  color: Color(
                                    Constants.inputBorderColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (error != "")
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    SizedBox(
                      height: 300.h,
                    ),
                    CustomButton(
                      color: Color.fromRGBO(249, 211, 180, opacity),
                      text: "Get OTP",
                      width: 214,
                      method: opacity == 0.4
                          ? () {}
                          : () {
                              if (_key.currentState!.validate() &&
                                  error == "") {
                                var data = ref
                                    .read(userNotifierProvider.notifier)
                                    .getState();
                                ref
                                    .read(userNotifierProvider.notifier)
                                    .setMobileNumber(_numberController.text);
                                ref
                                    .read(userServiceProvider)
                                    .login(
                                        data.role,
                                        data.mobileCountry["tel_code"],
                                        _numberController.text)
                                    .then((value) => {
                                          if (value["status"] == true)
                                            {
                                              Navigator.of(context)
                                                  .pushNamed("/verify-otp")
                                            }
                                          else
                                            {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "OOPS",
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            color: Colors
                                                                .red[700]),
                                                      ),
                                                      Text(
                                                        value["data"],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            }
                                        });
                              }
                            },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
