import 'package:chat_app_flutter/pages/auth/login/login_ctl.dart';
import 'package:chat_app_flutter/pages/auth/login/login_repo.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginRepo());
    Get.put(LoginCtl());
  }
}