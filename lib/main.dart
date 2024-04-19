import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_yuktidea/screens/countries_screen.dart';
import 'package:onboarding_yuktidea/screens/home_screen.dart';
import 'package:onboarding_yuktidea/screens/mobile_screen.dart';
import 'package:onboarding_yuktidea/screens/select_country.dart';
import 'package:onboarding_yuktidea/screens/terms_and_conditions.dart';
import 'package:onboarding_yuktidea/screens/verify_otp.dart';
import 'package:onboarding_yuktidea/screens/welcome.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 770),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rishabh Bajpai',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute:"/welcome",
          routes: {
            "/verify-otp": (context) => const VerifyOtp(),
            "/mobile": (context) => const MobileNumber(),
            "/countries-list": (context) => const CountriesScreen(),
            "/t&c": (context) => const TermsAndConditions(),
            "/homescreen": (context) => const HomeScreen(),
            "/select-country": (context) => const SelectCountry(),
            "/welcome": (context) => const WelcomeScreen(),
          },
        );
      },
    );
  }
}
