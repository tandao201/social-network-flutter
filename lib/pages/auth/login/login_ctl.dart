import 'dart:convert';

import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/models/commons/common_response.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../models/responses/auth_responses/login_response.dart';
import '../../../utils/shared/colors.dart';
import '../register/register_page.dart';
import 'login_repo.dart';

class LoginCtl extends BaseCtl<LoginRepo> with GetSingleTickerProviderStateMixin {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TabController? tabController;
  PageController pageController = PageController();

  final TextEditingController usernameCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();
  TextEditingController? usernameRegisCtl;
  TextEditingController? usernameInAppRegisCtl;
  TextEditingController? passwordRegisCtl;
  TextEditingController? rePasswordRegisCtl;

  RxString errorInfoLogin = "".obs;
  RxString errorInfoRegister = "".obs;
  Rx<int> currentTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    usernameCtl.text = HelperFunctions.getString(HelperFunctions.userNameKey);
    passwordCtl.text = HelperFunctions.getString(HelperFunctions.passwordKey);

    tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 500)
    );
  }

  bool isValidateInfoLogin() {
    if (usernameCtl.text.isEmpty || passwordCtl.text.isEmpty) {
      errorInfoLogin.value = ErrorCode.infoLoginEmpty;
      btnController.stop();
      return false;
    }
    if (passwordCtl.text.length < 8) {
      errorInfoLogin.value = ErrorCode.passwordSmall;
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
      LoginResponse? loginResponse = await api.login(bodyData: bodyData);
      if (loginResponse == null) {
        debugPrint('Response null');
        btnController.stop();
        return ;
      }
      if (loginResponse.errorCode!.isEmpty) {
        showSnackBar(
            Get.context!,
            AppColor.green,
            "Đăng nhập thành công."
        );
        saveInfoLogin(loginResponse);
        toPagePopUtil(routeUrl: RouteNames.home);
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(loginResponse.errorCode!)
        );
      }

      btnController.stop();
    } catch (e) {
      btnController.stop();
    }
  }

  void saveInfoLogin(LoginResponse loginResponse) {
    globalController?.saveUser(loginResponse.data!.userInfo!);
    HelperFunctions.setString(
        HelperFunctions.loginKey,
        jsonEncode(loginResponse.data?.toJson())
    );
    HelperFunctions.setString(
      HelperFunctions.passwordKey,
      passwordCtl.text,
    );
    HelperFunctions.setString(
      HelperFunctions.userNameKey,
      usernameCtl.text,
    );
    HelperFunctions.setBool(
        HelperFunctions.isLoginKey,
        true
    );
  }

  Future navigateToRegister() async {
    usernameRegisCtl = TextEditingController();
    usernameInAppRegisCtl = TextEditingController();
    passwordRegisCtl = TextEditingController();
    rePasswordRegisCtl = TextEditingController();
  }

  Future register() async {
    Map<String, String> bodyData = {
      'email': usernameRegisCtl!.text.trim(),
      'password': passwordRegisCtl!.text.trim(),
      'username' : usernameInAppRegisCtl!.text.trim(),
    };
    try {
      CommonResponse? commonResponse = await api.register(bodyData: bodyData);
      if (commonResponse == null) {
        debugPrint('Response null');
        btnController.stop();
        return ;
      }
      if (commonResponse.errorCode!.isEmpty) {
        showSnackBar(
            Get.context!,
            AppColor.green,
            "Đăng kí thành công."
        );
        usernameCtl.text = usernameRegisCtl!.text;
        passwordCtl.text = passwordRegisCtl!.text;
        animateToPage(0);
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(commonResponse.errorCode!)
        );
      }
      btnController.stop();
    } catch (e) {
      btnController.stop();
    }
  }

  bool isValidateInfoRegister() {
    if (usernameRegisCtl!.text.isEmpty || passwordRegisCtl!.text.isEmpty ||
        rePasswordRegisCtl!.text.isEmpty || usernameInAppRegisCtl!.text.isEmpty) {
      errorInfoRegister.value = ErrorCode.inputFullInfo;
      btnController.stop();
      return false;
    }
    if (passwordRegisCtl!.text.length < 8) {
      errorInfoRegister.value = ErrorCode.passwordSmall;
      btnController.stop();
      return false;
    }
    if (passwordRegisCtl!.text != rePasswordRegisCtl!.text) {
      errorInfoRegister.value = ErrorCode.rePasswordFalse;
      btnController.stop();
      return false;
    }
    return true;
  }

  Future animateToPage(int index) async {
    hideKeyboard();
    await navigateToRegister();
    currentTab.value = index;
    pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut
    );
  }
}