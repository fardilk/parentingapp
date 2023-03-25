import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  Future<bool> removeAllData() async {
    final int lastUserId =
        _sharedPreference.getInt(Preferences.current_user_id) ?? 0;
    await _sharedPreference.clear();
    return _sharedPreference.setInt(Preferences.last_user_id, lastUserId);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<int> get currentUserId async {
    return _sharedPreference.getInt(Preferences.current_user_id) ?? 0;
  }

  Future<bool> get isFirstTimeShowcase async {
    final int? lastUserId = _sharedPreference.getInt(Preferences.last_user_id);
    if (lastUserId != null) {
      final int currentUserId = await this.currentUserId;
      if (currentUserId == lastUserId) {
        this.saveFirstTimeShowcase(false);
        return false;
      } else {
        return _sharedPreference.getBool(Preferences.is_first_time_showcase) ??
            true;
      }
    } else {
      return _sharedPreference.getBool(Preferences.is_first_time_showcase) ??
          true;
    }
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  Future<bool> saveCurrentUserId(int value) async {
    return _sharedPreference.setInt(Preferences.current_user_id, value);
  }

  Future<bool> saveFirstTimeShowcase(bool value) async {
    return _sharedPreference.setBool(Preferences.is_first_time_showcase, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }
}
