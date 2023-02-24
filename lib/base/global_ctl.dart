import 'dart:convert';

import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:get/get.dart';

import '../models/responses/auth_responses/login_response.dart';

class GlobalController extends GetxController {
  RxBool isLogin = false.obs;
  Rx<UserInfo> userInfo = UserInfo().obs;

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    isLogin.value = HelperFunctions.getBool(HelperFunctions.isLoginKey);
    String data = HelperFunctions.getString(HelperFunctions.loginKey);
    if (data.isNotEmpty) {
      userInfo.value = LoginData.fromJson(jsonDecode(data)).userInfo!;
    }
  }

  void clearUserAndLoginState() {
    isLogin.value = false;
    userInfo.value = UserInfo();
    HelperFunctions.deleteData(HelperFunctions.isLoginKey);
    HelperFunctions.deleteData(HelperFunctions.loginKey);
  }
}