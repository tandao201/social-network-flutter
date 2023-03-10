import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/commons/user.dart';
import 'package:chat_app_flutter/pages/home/account/account_page.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_page.dart';
import 'package:chat_app_flutter/pages/home/home_repo.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_page.dart';
import 'package:chat_app_flutter/pages/home/search/search_ctl.dart';
import 'package:chat_app_flutter/pages/home/search/search_page.dart';
import 'package:chat_app_flutter/pages/home/search/search_repo.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'create_post/create_post_ctl.dart';
import 'create_post/create_post_repo.dart';

class HomeCtl extends BaseCtl<HomeRepo> {

  List<Widget> listHome = [
    const NewsFeedPage(),
    const SearchPage(),
    Container(),
    Container(),
    const AccountPage(),
  ];

  PageController pageController = PageController();
  Rx<int> pageIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future initData() async {

  }

  void clickBottomNavItem(int index) {
    debugPrint("Nav index: $index");
    if (index == 2) {
      toPage(routeUrl: RouteNames.createPost);
      return ;
    }
    if (index == 1) {
      Get.put(SearchRepo());
      Get.put(SearchCtl());
    }
    pageIndex.value = index;
    pageController.jumpToPage(index);
  }
}