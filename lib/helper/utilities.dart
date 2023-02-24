import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

}