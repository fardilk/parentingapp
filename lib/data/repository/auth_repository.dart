import 'package:grouu/data/network/apis/authentication/authentication_api.dart';

import '../sharedpref/shared_preference_helper.dart';

class AuthRepository {
  // api objects
  final AuthenticationApi _authenticationApi;
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  AuthRepository(this._sharedPrefsHelper, this._authenticationApi);

  Future<String?> postLogin(String email, String password) async {
    return await _authenticationApi.postLogin(email, password).then((value) {
      if (value.token != null) {
        _sharedPrefsHelper.saveAuthToken(value.token!);
        return value.token;
      } else {
        throw value.data.toString();
      }
    }).catchError((error) {
      throw error;
    });
  }

  Future<String?> postRegister(String email, String password) async {
    return await _authenticationApi
        .postRegister(email, password)
        .then((value) async {
      if (value.message?.contains("User created sucessfully!") ?? false) {
        return value.message;
      } else {
        throw value.message.toString();
      }
    }).catchError((error) {
      throw error;
    });
  }

  Future<String?> postForgotPassword(String email) async {
    return await _authenticationApi.postForgotPassword(email).then((value) {
      if (value.message?.contains("OTP sent to email") ?? false) {
        return value.message;
      } else {
        throw value.message.toString();
      }
    }).catchError((error) {
      throw error;
    });
  }

  Future<String?> postVerifyEmail(String email) async {
    return await _authenticationApi.postVerifyEmail(email).then((value) {
      if (value.message?.contains("OTP sent to email") ?? false) {
        return value.message;
      } else {
        throw value.message.toString();
      }
    }).catchError((error) {
      throw error;
    });
  }

  Future<bool> postForgotOtp(String otp) async {
    return await _authenticationApi.postForgotOtp(otp).then((value) {
      return value.message?.contains("OTP verification successful!") ?? false;
    }).catchError((error) {
      throw error;
    });
  }

  Future<bool> postVerifyOtp(String otp) async {
    return await _authenticationApi.postVerifyOtp(otp).then((value) {
      return value.message?.contains("OTP verification successful!") ?? false;
    }).catchError((error) {
      throw error;
    });
  }

  Future<bool> postUpdatePassword(String email, String password) async {
    return await _authenticationApi
        .postUpdatePassword(email, password)
        .then((value) async {
      return (value.success ?? 0) == 1;
    }).catchError((error) {
      throw error;
    });
  }
}
