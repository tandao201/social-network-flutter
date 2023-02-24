import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:get/get.dart';

import '../../base/base_ctl.dart';

class SplashCtl extends BaseCtl {

  @override
  void onInit() async {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 1000),(){
      if (globalController!.isLogin.value) {
        toPagePopUtil(routeUrl: RouteNames.home);
      } else {
        toPagePopUtil(routeUrl: RouteNames.login);
      }
    });

  }
}