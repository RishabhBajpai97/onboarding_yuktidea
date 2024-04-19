import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding_yuktidea/models/user_model.dart';

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier()
      : super(UserModel(role: "", mobileNumber: "", mobileCountry: {}));
  setMobileCountry(value) {
    state.mobileCountry = value;
  }

  setRole(value) {
    state.role = value;
  }

  setMobileNumber(value) {
    state.mobileNumber = value;
  }

  getMobileNumber() {
    return state.mobileNumber != "" ? state.mobileNumber : "";
  }

  getMobileCountry() {
    return state.mobileCountry;
  }

  getRole() {
    return state.role != "" ? state.role : "";
  }

  UserModel getState() {
    return state;
  }
}

final userNotifierProvider = StateNotifierProvider((ref) => UserNotifier());
