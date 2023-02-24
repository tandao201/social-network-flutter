import 'package:get/get.dart';
import 'comment_post_ctl.dart';
import 'comment_post_repo.dart';

class CommentPostBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommentPostRepo());
    Get.lazyPut(() => CommentPostCtl());
  }

}