import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_yuktidea/notifiers/user_notifier.dart';
import 'package:onboarding_yuktidea/services/user_service.dart';
import 'package:onboarding_yuktidea/utils/colors.dart';
import 'package:onboarding_yuktidea/widgets/back_button.dart';
import 'package:onboarding_yuktidea/widgets/body_text.dart';
import 'package:onboarding_yuktidea/widgets/custom_button.dart';
import 'package:onboarding_yuktidea/widgets/title_text.dart';
import 'package:pinput/pinput.dart';

class VerifyOtp extends ConsumerStatefulWidget {
  final dynamic country;
  const VerifyOtp({super.key, this.country});

  @override
  ConsumerState<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends ConsumerState<VerifyOtp> {
  final TextEditingController _pinputcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? counterText;
  Timer? _timer;
  Timer? _enableresendTimer;
  int _start = 0;
  int _enableresendcounter = 30;
  double opacity = 0.4;

  @override
  void initState() {
    _startResendTimer();
    super.initState();
  }

  @override
  void dispose() {
    if(_timer!=null){
      _timer!.cancel();
    }
    _enableresendTimer!.cancel();
    super.dispose();
  }

  _startResendTimer() {
    const oneSec = Duration(seconds: 1);
    _enableresendTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_enableresendcounter == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _enableresendcounter--;
          });
        }
      },
    );
  }

  void startTimer() {
    _start = 10;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          ref.read(userServiceProvider).resendOtp(
              ref
                  .watch(userNotifierProvider.notifier)
                  .getMobileCountry()["tel_code"],
              ref.watch(userNotifierProvider.notifier).getMobileNumber());
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
            counterText = _start > 1 ? "$_start seconds" : "$_start second";
          });
        }
      },
    );
  }

  final defaultPinTheme = PinTheme(
    width: 30.w,
    height: 30.h,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 1.h,
          color: const Color(
            Constants.inputBorderColor,
          ),
        ),
      ),
    ),
  );

  _resendingWidget() {
    if (_start == 0) {
      return GestureDetector(
        onTap: _enableresendcounter == 0
            ? () {
                startTimer();
              }
            : () {},
        child: Text(
          "Resend OTP",
          style: TextStyle(
              color: Color(_enableresendcounter == 0
                  ? Constants.formIconColor
                  : Constants.inputBorderColor),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: counterText,
              style: TextStyle(
                color: const Color(Constants.formIconColor),
                fontSize: 18.sp,
              ),
            ),
          ],
          text: "Resending OTP in ",
          style: TextStyle(
            color: const Color(Constants.inputBorderColor),
            fontSize: 18.sp,
          ),
        ),
      );
    }
  }

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
                key: _formKey,
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
                      text: "Verify Number",
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const CustomBodyText(
                      text:
                          "Please enter the OTP received to verify your number",
                      color: Color(Constants.formIconColor),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Pinput(
                      controller: _pinputcontroller,
                      errorTextStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.red,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && value.length == 4) {
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
                            opacity = 0.4;
                          });
                          return "Please Enter OTP";
                        } else if (value.length < 4) {
                          opacity = 0.4;
                          return "Please Enter Valid OTP";
                        } else {
                          return null;
                        }
                      },
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    const CustomBodyText(
                      text: "Didn't receive OTP?",
                      color: Color(Constants.inputBorderColor),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    _resendingWidget(),
                    SizedBox(
                      height: 150.h,
                    ),
                    CustomButton(
                      text: "Verify",
                      method: (_pinputcontroller.text.isNotEmpty &&
                              _pinputcontroller.text.length == 4)
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(userServiceProvider)
                                    .verifyOtp(
                                        _pinputcontroller.text,
                                        ref
                                            .watch(
                                                userNotifierProvider.notifier)
                                            .getMobileCountry()["tel_code"],
                                        ref
                                            .watch(
                                                userNotifierProvider.notifier)
                                            .getMobileNumber())
                                    .then((value) => {
                                          if (value["status"] == true)
                                            {
                                              Navigator.of(context)
                                                  .pushNamed("/select-country")
                                            }
                                          else
                                            {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "OOPS",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color:
                                                              Colors.red[700]),
                                                    ),
                                                    Text(
                                                      value["data"],
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                )),
                                              )
                                            }
                                        });
                              }
                            }
                          : null,
                      width: 192,
                      color: Color.fromRGBO(249, 211, 180, opacity),
                    ),
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
