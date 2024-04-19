import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_yuktidea/notifiers/user_notifier.dart';
import 'package:onboarding_yuktidea/utils/colors.dart';
import 'package:onboarding_yuktidea/widgets/body_text.dart';
import 'package:onboarding_yuktidea/widgets/role.dart';
import 'package:onboarding_yuktidea/widgets/title_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  void initState() {
    _getToken().then((value) => {
      if(value!=null){
        Navigator.of(context).pushReplacementNamed("/homescreen")
      }
    });
    super.initState();
  }

  Future<dynamic>_getToken() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString("token");
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(Constants.background),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Image.asset(
              "assets/welcome.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xff292929),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              width: 375.w,
              
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTitle(
                        text: "Welcome to Study Lancer",
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const CustomBodyText(
                        text: "Please select your role to get registered",
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoleWidget(
                            src: "assets/student.png",
                            roleText: "Student",
                            callback: () => {
                              ref
                                  .read(userNotifierProvider.notifier)
                                  .setRole("student"),
                              Navigator.of(context).pushNamed("/countries-list")
                            },
                          ),
                          RoleWidget(
                            src: "assets/counsellor.png",
                            roleText: "Agent",
                            callback: () => {
                              ref
                                  .read(userNotifierProvider.notifier)
                                  .setRole("counsellor"),
                              Navigator.of(context).pushNamed("/countries-list")
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "By continuing you agree to our ",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.of(context).pushNamed("/t&c"),
                                text: " Terms and Conditions",
                                style: const TextStyle(
                                    color: Color(
                                      0xffD9896A,
                                    ),
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
