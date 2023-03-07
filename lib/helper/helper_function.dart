import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/responses/auth_responses/login_response.dart';

class HelperFunctions {
  //keys
  static const String userLoggedInKey = "LOGGEDINKEY";
  static const String userNameKey = "USERNAMEKEY";
  static const String userEmailKey = "USEREMAILKEY";
  static const String loginKey = "userKey";
  static const String isLoginKey = "isLoginKey";
  static const String passwordKey = "passwordKey";
  static const String usernameKey = "usernameKey";
  static const String tokenKey = "tokenKey";

  // init singleton
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key) {
    String value = _prefsInstance?.getString(key) ?? "";
    print('Get string: $key with value: $value');
    return value;
  }

  static Future<bool> setString(String key, String value) async {
    print('Save String: $key with value: $value');
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static bool getBool(String key) {
    bool value = _prefsInstance?.getBool(key) ?? false;
    print('Get bool: $key with value: $value');
    return value;
  }

  static Future<bool> setBool(String key, bool value) async {
    print('Save bool: $key with value: $value');
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }
  static Future<bool> deleteData(String key) async {
    print('Delete data key: $key');
    var prefs = await _instance;
    return prefs.remove(key);
  }

  static Future readLoginData() async {
    String data = getString(HelperFunctions.loginKey);
    if (data.isNotEmpty) {
      return LoginData.fromJson(jsonDecode(data));
    }
    return null;
  }

  static Future saveUserInfo(UserInfo data) async {
    LoginData? loginData = await readLoginData();
    if (loginData == null) return null;
    loginData.userInfo = data;
    setString(loginKey, jsonEncode(loginData.toJson()));
  }


  // --------------- Test -----------
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  // getting the data from SF

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }
}