import 'package:chat_app_flutter/pages/edit_profile/edit_profile_ctl.dart';
import 'package:chat_app_flutter/pages/edit_profile/edit_profile_repo.dart';
import 'package:get/get.dart';

class EditProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>EditProfileRepo());
    Get.lazyPut(() => EditProfileCtl());
  }

}