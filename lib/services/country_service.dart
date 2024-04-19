import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding_yuktidea/services/api_service.dart';

class CountryService extends APiService {
  getCountriesList() async {
    final response = await get("countries");
    return response["data"];
  }

  getSelectCountriesList() async {
    final response = await get(
      "select/country",
    );
    return response["data"]["countries"];
  }

  Future<dynamic>sendSelectedCountry(countryid) async {
    final response = await post("select/country", {"country_id": "$countryid"});
    return response["status"];
  }
}

final countryServiceProvider = Provider((ref) {
  return CountryService();
});
