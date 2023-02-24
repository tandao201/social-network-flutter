import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../base/base_ctl.dart';
import 'comment_post_repo.dart';

class CommentPostCtl extends BaseCtl<CommentPostRepo> {
  TextEditingController commentCtl = TextEditingController();
  ItemScrollController itemScrollController = ItemScrollController();
  FocusNode commentFocus = FocusNode();
  RxBool enabledComment = false.obs;
  RxBool isReply = false.obs;
  RxString replyTo = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void commentPost() {
    print('Comment post: ${commentCtl.text}');
    commentCtl.text = "";
    clearReplyComment();
    hideKeyboard();
  }

  void onTapReplyComment(String username, int index) {
    isReply.value = true;
    replyTo.value = username;
    commentCtl.text = "@$username ";
    commentFocus.requestFocus();
    scrollToIndex(index);
  }

  void clearReplyComment() {
    isReply.value = false;
    replyTo.value = "";
    commentCtl.text = "";
  }

  void scrollToIndex(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
      alignment: 0.05
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentCtl.dispose();
  }
}