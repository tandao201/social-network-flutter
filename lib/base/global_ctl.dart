import 'dart:convert';

import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/models/commons/health_entity.dart';
import 'package:get/get.dart';

import '../models/responses/auth_responses/login_response.dart';

class GlobalController extends GetxService {
  RxBool isLogin = false.obs;
  Rx<UserInfo> userInfo = UserInfo().obs;
  int specificIndexTabHome = -1;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // isLogin.value = HelperFunctions.getBool(HelperFunctions.isLoginKey);
    // LoginData? loginData = await HelperFunctions.readLoginData();
    // if (loginData != null) {
    //   userInfo.value = loginData.userInfo!;
    // }
  }

  Future<GlobalController> initData() async {
    isLogin.value = HelperFunctions.getBool(HelperFunctions.isLoginKey);
    LoginData? loginData = await HelperFunctions.readLoginData();
    if (loginData != null) {
      userInfo.value = loginData.userInfo!;
    }
    return this;
  }

  Future saveUser(UserInfo userInfo) async {
    HealthEntity? healthEntity = this.userInfo.value.healthEntity;
    userInfo.healthEntity = healthEntity;
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