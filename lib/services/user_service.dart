import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding_yuktidea/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends APiService {
  Future<dynamic> deleteUser() async {
    final response = await post("delete", null);
    if (response["status"] == true) {
      final sp = await SharedPreferences.getInstance();
      final value = await sp.remove("token");
      return value;
    }
    return response["status"];
  }

  Future<dynamic> logout() async {
    final response = await post("logout", null);
    if (response["status"] == true) {
      final sp = await SharedPreferences.getInstance();
      final value = await sp.remove("token");
      return value;
    }
    return response["status"];
  }

  Future<dynamic> login(
    role,
    telcode,
    number,
  ) async {
    final response =
        await post("$role/login", {"tel_code": telcode, "phone": number});
    return response;
  }

  Future<dynamic> resendOtp(telcode, number) async {
    final response = await post("resend-otp", {"phone": "$telcode$number"});
    return response;
  }

  Future<dynamic> verifyOtp(code, telcode, number) async {
    final response =
        await post("verify-otp", {"code": code, "phone": "$telcode$number"});
    if (response["status"] == true) {
      final sp = await SharedPreferences.getInstance();
      await sp.setString("token", response["data"]["access_token"]);
    }
    return response;
  }

  getTermsAndConditions() async {
    final response = await get("terms-conditions");
    return response["data"];
  }
}

final userServiceProvider = Provider((ref) {
  return UserService();
});
