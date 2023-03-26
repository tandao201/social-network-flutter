import 'package:get/get.dart';
import 'list_all_post_ctl.dart';

class ListAllPostsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ListAllPostsCtl());
  }

}