import 'package:chat_app_flutter/pages/story_view/story_view_ctl.dart';
import 'package:chat_app_flutter/pages/story_view/story_view_repo.dart';
import 'package:get/get.dart';

class StoryViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StoryViewRepo());
    Get.put(StoryViewCtl());
  }

}