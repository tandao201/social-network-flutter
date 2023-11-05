import 'package:chat_app_flutter/pages/home/groups/list_group_ctl.dart';
import 'package:get/get.dart';

import 'list_group_repo.dart';

class ListGroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ListGroupRepo());
    Get.put(ListGroupCtl());
  }

}