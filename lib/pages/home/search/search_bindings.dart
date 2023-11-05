import 'package:chat_app_flutter/pages/home/search/search_ctl.dart';
import 'package:chat_app_flutter/pages/home/search/search_repo.dart';
import 'package:get/get.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchRepo());
    Get.put(SearchCtl());
  }

}