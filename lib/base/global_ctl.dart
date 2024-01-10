import 'dart:convert';

import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/models/commons/health_entity.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../models/responses/auth_responses/login_response.dart';

class GlobalController extends GetxService {
  RxBool isLogin = false.obs;
  Rx<UserInfo> userInfo = UserInfo().obs;
  int specificIndexTabHome = -1;
  String healthApiToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRhbi4yNi4xMGEyQGdtYWlsLmNvbSIsInJvbGUiOiJVc2VyIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvc2lkIjoiMTA2NDEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3ZlcnNpb24iOiIxMDkiLCJodHRwOi8vZXhhbXBsZS5vcmcvY2xhaW1zL2xpbWl0IjoiMTAwIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9tZW1iZXJzaGlwIjoiQmFzaWMiLCJodHRwOi8vZXhhbXBsZS5vcmcvY2xhaW1zL2xhbmd1YWdlIjoiZW4tZ2IiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2V4cGlyYXRpb24iOiIyMDk5LTEyLTMxIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9tZW1iZXJzaGlwc3RhcnQiOiIyMDIzLTExLTI2IiwiaXNzIjoiaHR0cHM6Ly9hdXRoc2VydmljZS5wcmlhaWQuY2giLCJhdWQiOiJodHRwczovL2hlYWx0aHNlcnZpY2UucHJpYWlkLmNoIiwiZXhwIjoxNzA0ODU5MjY3LCJuYmYiOjE3MDQ4NTIwNjd9.aeZNBoaKmWtZ0F-z1nYTg5bd8kKX7To2dSz6JeZhgYE";
  final translator = GoogleTranslator();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // isLogin.value = HelperFunctions.getBool(HelperFunctions.isLoginKey);
    // LoginData? loginData = await HelperFunctions.readLoginData();
    // if (loginData != null) {
    //   userInfo.value = loginData.userInfo!;
    // }
    healthApiToken = Constants.healthApiToken;
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