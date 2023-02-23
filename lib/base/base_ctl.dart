import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:chat_app_flutter/base/global_ctl.dart';
import 'package:chat_app_flutter/helper/utilities.dart';
import 'package:get/get.dart';

class BaseCtl<T extends BaseRepo> extends GetxController with Utilities {
  T get api => Get.find<T>();
  GlobalController? globalController;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    globalController = Get.find<GlobalController>();
  }
}