import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/home/account/account_page.dart';
import 'package:chat_app_flutter/pages/home/home_repo.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_page.dart';
import 'package:chat_app_flutter/pages/home/notification/notification_page.dart';
import 'package:chat_app_flutter/pages/home/search/search_ctl.dart';
import 'package:chat_app_flutter/pages/home/search/search_page.dart';
import 'package:chat_app_flutter/pages/home/search/search_repo.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'notification/notification_ctl.dart';
import 'notification/notification_repo.dart';

class HomeCtl extends BaseCtl<HomeRepo> {

  List<Widget> listHome = [
    const NewsFeedPage(),
    const SearchPage(),
    Container(),
    const NotificationPage(),
    const AccountPage(),
  ];

  PageController pageController = PageController();
  Rx<int> pageIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController();
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
    if (index == 3) {
      Get.put(NotificationRepo());
      Get.put(NotificationCtl());
    }
    pageIndex.value = index;
    pageController.jumpToPage(index);
  }
}