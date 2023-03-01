import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/widgets/widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Utilities {

  Future toPage({required String routeUrl, Map<String, dynamic>? arguments}) async {
    Get.toNamed(routeUrl, arguments: arguments);
  }

  Future toPagePopUtil({required String routeUrl, Map<String, dynamic>? arguments}) async {
    Get.offAndToNamed(routeUrl, arguments: arguments);
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future requestPermission({Function? toDo}) async {
    PermissionStatus request;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt <= 32) {
      request = await Permission.storage.request();
    }  else {
      request = await Permission.photos.request();
    }

    if (request.isGranted) {
      toDo!();
    } else {
      showSnackbar(
          Get.context!,
          AppColor.grey,
          'Yêu cầu bị từ chối.',
          const Duration(seconds: 3)
      );
    }
  }

}