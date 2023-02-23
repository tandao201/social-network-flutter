import 'package:get/get.dart';

class Utilities {

  Future toPage({required String routeUrl, Map<String, dynamic>? arguments}) async {
    Get.toNamed(routeUrl, arguments: arguments);
  }

}