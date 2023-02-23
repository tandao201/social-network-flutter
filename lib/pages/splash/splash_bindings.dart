import 'package:chat_app_flutter/pages/splash/splash_ctl.dart';
import 'package:get/get.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashCtl());
  }

}