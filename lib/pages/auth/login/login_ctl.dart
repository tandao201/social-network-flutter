import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'login_repo.dart';

class LoginCtl extends BaseCtl<LoginRepo> {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final TextEditingController usernameCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();

  @override
  void onInit() {
    super.onInit();

  }

  Future login() async {
    print('Login...........');
    btnController.stop();
    toPage(routeUrl: RouteNames.home);
  }

  Future register() async {
    print('Register...........');
  }
}