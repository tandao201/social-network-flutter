import 'package:chat_app_flutter/pages/home/notification/notification_ctl.dart';
import 'package:chat_app_flutter/pages/home/notification/notification_repo.dart';
import 'package:get/get.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationRepo());
    Get.put(NotificationCtl());
  }

}