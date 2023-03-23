import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/home/notification/notification_repo.dart';

class NotificationCtl extends BaseCtl<NotificationRepo> {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void initData() {
    isLoading.value = true;
  }
}