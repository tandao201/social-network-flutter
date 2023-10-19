import 'package:chat_app_flutter/pages/health_info_result/health_info_result_ctl.dart';
import 'package:get/get.dart';

import 'health_info_result_repo.dart';

class HealthInfoResultBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HealthInfoResultRepo());
    Get.put(HealthInfoResultCtl());
  }

}