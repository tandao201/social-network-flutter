import 'dart:convert';

import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/commons/common_response.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/create_post_response.dart';
import 'package:chat_app_flutter/pages/home/account/account_page.dart';
import 'package:chat_app_flutter/pages/home/account/account_repo.dart';
import 'package:chat_app_flutter/pages/home/home_repo.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_ctl.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_repo.dart';
import 'package:chat_app_flutter/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../routes/route_names.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/shared/constants.dart';
import '../home_ctl.dart';

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
  RxList<Post> userPosts = <Post>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userInfo = globalController?.userInfo.value;
    if (userInfo != null) {
      username.value = userInfo!.username ?? "Người dùng";
      avatarUrlImg.value = userInfo!.avatar ?? "";
      userPosts.value = userInfo!.posts ?? [];
    }
    tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 500)
    );
  }

  Future initData() async {
    await getUserDetail();
  }

  Future getUserDetail() async {
    Map<String, dynamic> bodyData = {
      'user_id': userInfo?.id ?? -1,
    };
    // try {
      CommonResponse<UserInfo>? commonResponse = await api.getUserDetail(bodyData: bodyData);
      if (commonResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (commonResponse.errorCode!.isEmpty) {
        userInfo = commonResponse.data;
        userPosts.value = userInfo!.posts!;
        globalController?.saveUser(userInfo!);
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(commonResponse.errorCode!)
        );
      }
    // } catch (e) {
    //   print('Ex: ${e.toString()}');
    // }
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
    showSnackBar(
        Get.context!,
        AppColor.grey,
        "Đăng xuất thành công."
    );
    Get.delete<NewsFeedRepo>();
    Get.delete<NewsFeedCtl>();
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