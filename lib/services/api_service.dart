import "dart:convert";

import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

abstract class APiService {
  static const baseUrl = "https://studylancer.yuktidea.com/api";
  getToken() async {
    final sp = await SharedPreferences.getInstance();
    final token = await sp.getString("token");
    return token;
  }

  get(String path) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$path"),
        headers: {
          "Accept":"application/json",
          "Authorization": "Bearer ${await getToken()}",
        },
      );
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  post(
    String path,
    dynamic body,
  ) async {
    try {
      final response =
          await http.post(Uri.parse("$baseUrl/$path"), body: body, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${await getToken()}",
      });
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
