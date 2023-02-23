import 'package:chat_app_flutter/pages/home/home_ctl.dart';
import 'package:chat_app_flutter/pages/home/home_repo.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_ctl.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_repo.dart';
import 'package:get/get.dart';

import 'account/account_ctl.dart';
import 'account/account_repo.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeRepo());
    Get.put(NewsFeedRepo());
    Get.put(AccountRepo());

    Get.put(HomeCtl());
    Get.put(NewsFeedCtl());
    Get.put(AccountCtl());
  }

}