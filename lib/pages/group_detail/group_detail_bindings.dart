import 'package:chat_app_flutter/pages/group_detail/group_detail_ctl.dart';
import 'package:chat_app_flutter/pages/group_detail/group_detail_repo.dart';
import 'package:get/get.dart';

class GroupDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GroupDetailRepo());
    Get.put(GroupDetailCtl());
  }

}