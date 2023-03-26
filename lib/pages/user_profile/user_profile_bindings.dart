import 'package:chat_app_flutter/pages/user_profile/user_profile_ctl.dart';
import 'package:get/get.dart';

class UserProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserProfileCtl());
  }

}