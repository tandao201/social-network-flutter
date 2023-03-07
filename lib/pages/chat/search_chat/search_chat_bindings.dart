import 'package:chat_app_flutter/pages/chat/search_chat/search_chat_ctl.dart';
import 'package:get/get.dart';

class SearchChatBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchChatCtl());
  }

}