import 'package:get/get.dart';

import 'create_group_ctl.dart';
import 'create_group_repo.dart';

class CreateGroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateGroupRepo());
    Get.put(CreateGroupCtl());
  }

}