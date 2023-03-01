import 'package:chat_app_flutter/pages/home/create_post/create_post_ctl.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_repo.dart';
import 'package:get/get.dart';

class CreatePostBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CreatePostRepo());
    Get.put(CreatePostCtl());
  }

}