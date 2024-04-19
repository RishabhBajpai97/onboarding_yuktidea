import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_yuktidea/services/user_service.dart';
import 'package:onboarding_yuktidea/utils/colors.dart';
import 'package:onboarding_yuktidea/widgets/custom_button.dart';
import 'package:onboarding_yuktidea/widgets/title_text.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(Constants.background),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomTitle(
                text: "Welcome",
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                text: "Logout",
                method: () {
                  ref.read(userServiceProvider).logout().then((value) => {
                        if (value == true)
                          {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/welcome", (route) => false)
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Column(
                                  children: [
                                    Text(
                                      "OOPS",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.red[700]),
                                    ),
                                    const Text(
                                      "Error in deleteing the account",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          }
                      });
                },
                width: 202,
                color: const Color.fromRGBO(249, 211, 180, 1),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                text: "Delete User",
                method: () {
                  ref.read(userServiceProvider).deleteUser().then((value) => {
                        if (value == true)
                          {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/welcome", (route) => false)
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Column(
                                  children: [
                                    Text(
                                      "OOPS",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.red[700]),
                                    ),
                                    const Text(
                                      "Error in deleteing the account",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          }
                      });
                },
                width: 242,
                color: const Color.fromRGBO(249, 211, 180, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
