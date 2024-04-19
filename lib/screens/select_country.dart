import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_yuktidea/services/country_service.dart';
import 'package:onboarding_yuktidea/utils/colors.dart';
import 'package:onboarding_yuktidea/widgets/back_button.dart';
import 'package:onboarding_yuktidea/widgets/body_text.dart';
import 'package:onboarding_yuktidea/widgets/custom_button.dart';
import 'package:onboarding_yuktidea/widgets/title_text.dart';

class SelectCountry extends ConsumerStatefulWidget {
  const SelectCountry({
    super.key,
  });

  @override
  ConsumerState<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends ConsumerState<SelectCountry> {
  List countriesList = [];
  dynamic selectedCountry;
  dynamic selectedIndex;

  @override
  void initState() {
    _getCountriesList();
    super.initState();
  }

  _getCountriesList() async {
    final list =
        await ref.read(countryServiceProvider).getSelectCountriesList();
    setState(() {
      countriesList = list;
    });
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
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  const CustomBackButton(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Select Country",
                    style: TextStyle(color: Colors.white, fontSize: 24.sp),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Please select the country where you want to study",
                    style: TextStyle(
                        color: const Color(Constants.formIconColor),
                        fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  SizedBox(
                    height: 300.h,
                    child: GridView.builder(
                      itemCount: countriesList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: selectedIndex == index
                                        ? BorderRadius.circular(10)
                                        : BorderRadius.zero,
                                    border: selectedIndex == index
                                        ? Border.all(
                                            color: Colors.white, width: 2)
                                        : null),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                    countriesList[index]["image"],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomBodyText(
                                text: countriesList[index]["name"],
                                color: const Color(Constants.inputBorderColor),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  CustomButton(
                    text: "Proceed",
                    width: 213,
                    method: selectedIndex == null
                        ? null
                        : () {
                            ref
                                .read(countryServiceProvider)
                                .sendSelectedCountry(
                                    countriesList[selectedIndex]["id"])
                                .then((value) => {
                                      if (value == true)
                                        {
                                          Navigator.of(context)
                                              .pushNamed("/homescreen")
                                        }
                                      else
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Column(
                                                children: [
                                                  Text(
                                                    "OOPS",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "Some error ocurred. Please try again!",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        }
                                    });
                          },
                    color: Color.fromRGBO(
                        249, 211, 180, selectedIndex == null ? 0.4 : 1),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const CustomBodyText(
                    text: "Can’t see the country of your interest?",
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const CustomTitle(
                    text: "Consult with us",
                    color: Color(Constants.formIconColor),
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
