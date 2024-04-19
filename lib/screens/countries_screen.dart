import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_yuktidea/services/country_service.dart';
import 'package:onboarding_yuktidea/utils/colors.dart';
import 'package:onboarding_yuktidea/widgets/back_button.dart';
import 'package:onboarding_yuktidea/widgets/country_list_item.dart';
import 'package:onboarding_yuktidea/widgets/title_text.dart';

class CountriesScreen extends ConsumerStatefulWidget {
  const CountriesScreen({super.key});

  @override
  ConsumerState<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends ConsumerState<CountriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List countriesList = [];
  List filteredCountries = [];
  @override
  void initState() {
    _getCountriesList();
    super.initState();
  }

  _getCountriesList() async {
    final countriesListResponse =
        await ref.read(countryServiceProvider).getCountriesList();
    setState(() {
      countriesList = countriesListResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(Constants.background),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                const CustomBackButton(),
                SizedBox(
                  height: 20.h,
                ),
                const CustomTitle(
                  text: "Select Your Country",
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 300.w,
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color(
                      Constants.placeholder,
                    ),
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (String value) {
                      final filtered = countriesList
                          .where((element) => element["name"]
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      setState(() {
                        filteredCountries = filtered;
                      });
                    },
                    style: const TextStyle(
                        color: Colors.white, decorationThickness: 0),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: Color(Constants.formIconColor),
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    cursorColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredCountries.isEmpty
                      ? countriesList.length
                      : filteredCountries.length,
                  itemBuilder: (context, index) {
                    return CountryListItem(
                      countryItem: filteredCountries.isEmpty
                          ? countriesList[index]
                          : filteredCountries[index],
                    );
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
