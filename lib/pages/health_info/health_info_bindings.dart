import 'package:chat_app_flutter/pages/health_info/health_info_ctl.dart';
import 'package:chat_app_flutter/pages/health_info/health_info_repo.dart';
import 'package:get/get.dart';

class HealthInfoBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HealthInfoRepo());
    Get.put(HealthInfoCtl());
  }

}