import 'package:get/get.dart';
import 'list_user_ctl.dart';
import 'list_user_repo.dart';

class ListUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ListUserRepo());
    Get.put(ListUserCtl());
  }

}