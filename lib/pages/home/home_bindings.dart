import 'package:chat_app_flutter/pages/home/home_ctl.dart';
import 'package:chat_app_flutter/pages/home/home_repo.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_ctl.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_repo.dart';
import 'package:get/get.dart';

import '../health_info_result/health_info_result_ctl.dart';
import '../health_info_result/health_info_result_repo.dart';
import 'account/account_ctl.dart';
import 'account/account_repo.dart';
import 'health_prediction/health_prediction_ctl.dart';
import 'health_prediction/health_prediction_repo.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeRepo());
    Get.put(NewsFeedRepo());
    Get.put(HealthInfoResultRepo());
    Get.put(AccountRepo());
    Get.put(HealthPredictionRepo());

    Get.put(HomeCtl());
    Get.put(NewsFeedCtl());
    Get.put(HealthInfoResultCtl());
    Get.put(AccountCtl());
    Get.put(HealthPredictionCtl());
  }

}