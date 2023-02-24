import 'dart:convert';

import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../models/responses/auth_responses/login_response.dart';
import '../../../utils/shared/colors.dart';
import 'login_repo.dart';

class LoginCtl extends BaseCtl<LoginRepo> {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final TextEditingController usernameCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();
  RxString errorInfoLogin = "".obs;

  @override
  void onInit() {
    super.onInit();

  }

  bool isValidateInfoLogin() {
    if (usernameCtl.text.isEmpty || passwordCtl.text.isEmpty) {
      errorInfoLogin.value = "Nhập tài khoản và mật khẩu.";
      btnController.stop();
      return false;
    }
    if (passwordCtl.text.length < 8) {
      errorInfoLogin.value = "Mật khẩu phải lớn hơn 8 kí tự.";
      btnController.stop();
      return false;
    }
    return true;
  }

  Future login() async {
    Map<String, String> bodyData = {
      'email': usernameCtl.text.trim(),
      'password': passwordCtl.text.trim(),
    };
    try {
      LoginResponse loginResponse = await api.login(bodyData: bodyData);
      if (loginResponse == null) {
        debugPrint('Response null');
        return ;
      } 
      if (loginResponse.errorCode!.isEmpty) {
        showSnackBar(
            Get.context!,
            AppColor.grey,
            "Đăng nhập thành công"
        );
        HelperFunctions.setString(
            HelperFunctions.loginKey,
            jsonEncode(loginResponse.data?.toJson())
        );
        HelperFunctions.setBool(
            HelperFunctions.isLoginKey,
            true
        );
        toPagePopUtil(routeUrl: RouteNames.home);
      }

      btnController.stop();
    } catch (e) {
      btnController.stop();
    }
  }

  Future register() async {
    print('Register...........');
  }
}