import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/pages/home/account/account_page.dart';
import 'package:chat_app_flutter/pages/home/account/account_repo.dart';
import 'package:chat_app_flutter/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../routes/route_names.dart';

class AccountCtl extends BaseCtl<AccountRepo> with GetSingleTickerProviderStateMixin {

  TabController? tabController;
  PageController pageController = PageController();
  AuthService authService = AuthService();
  UserInfo? userInfo;
  Rx<int> currentTab = 0.obs;
  Rx<String> username = "Username".obs;
  Rx<String> avatarUrlImg = "".obs;
  Rx<String> name = "Tên".obs;
  Rx<String> bio = "Tiểu sử".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userInfo = globalController?.userInfo.value;
    if (userInfo != null) {
      username.value = userInfo!.username ?? "Người dùng";
      avatarUrlImg.value = userInfo!.avatar ?? "";
    }
    tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 500)
    );
  }

  Future initData() async {
    print('Refresh..........');
  }

  Future animateToPage(int index) async {
    currentTab.value = index;
    pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut
    );
  }

  void logout() {
    globalController?.clearUserAndLoginState();
    authService.signOut();
    toPagePopUtil(routeUrl: RouteNames.login);
  }

  void selectMenu() {
    showBarModalBottomSheet(
        context: Get.context!,
        builder: (context) {
          return MenuAccount(controller: this,);
        }
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
    pageController.dispose();
  }
}