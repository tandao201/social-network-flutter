import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/home/account/account_page.dart';
import 'package:chat_app_flutter/pages/home/groups/list_group_page.dart';
import 'package:chat_app_flutter/pages/home/home_repo.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_page.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../health_info_result/health_info_result_page.dart';

class HomeCtl extends BaseCtl<HomeRepo> {

  List<Widget> listHome = [
    const NewsFeedPage(),
    const ListGroupPage(),
    Container(),
    const HealthInfoResultPage(showLeading: false,),
    const AccountPage(),
  ];

  PageController pageController = PageController();
  Rx<int> pageIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController();
    if (globalController?.specificIndexTabHome != -1) {
      clickBottomNavItem(globalController?.specificIndexTabHome ?? 0);
      globalController?.specificIndexTabHome = -1;
    }
  }

  Future initData() async {

  }

  void clickBottomNavItem(int index) {
    debugPrint("Nav index: $index");
    if (index == 2) {
      toPage(routeUrl: RouteNames.createPost);
      return ;
    }
    pageIndex.value = index;
    pageController.jumpToPage(index);
  }
}