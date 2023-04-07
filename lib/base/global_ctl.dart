import 'dart:convert';

import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:get/get.dart';

import '../models/responses/auth_responses/login_response.dart';

class GlobalController extends GetxController {
  RxBool isLogin = false.obs;
  Rx<UserInfo> userInfo = UserInfo().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    isLogin.value = HelperFunctions.getBool(HelperFunctions.isLoginKey);
    LoginData? loginData = await HelperFunctions.readLoginData();
    if (loginData != null) {
      userInfo.value = loginData.userInfo!;
    }
  }

  void saveUser(UserInfo userInfo) {
    this.userInfo.value = userInfo;
    HelperFunctions.saveUserInfo(userInfo);
  }

  void clearUserAndLoginState() {
    isLogin.value = false;
    userInfo.value = UserInfo();
    HelperFunctions.deleteData(HelperFunctions.isLoginKey);
    HelperFunctions.deleteData(HelperFunctions.loginKey);
  }
}