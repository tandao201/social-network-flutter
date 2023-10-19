import 'package:get/get.dart';

import 'health_info_ctl.dart';
import 'health_info_repo.dart';

class HealthInfoBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HealthInfoRepo());
    Get.put(HealthInfoCtl());
  }

}