import 'package:chat_app_flutter/models/commons/common_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/create_comment_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../base/base_ctl.dart';
import '../../models/responses/post_responses/create_post_response.dart';
import '../../models/responses/post_responses/list_comment_response.dart';
import '../../utils/shared/colors.dart';
import '../../utils/shared/constants.dart';
import 'comment_post_repo.dart';

class CommentPostCtl extends BaseCtl<CommentPostRepo> {
  TextEditingController commentCtl = TextEditingController();
  ItemScrollController itemScrollController = ItemScrollController();
  FocusNode commentFocus = FocusNode();
  RxBool enabledComment = false.obs;
  RxBool isReply = false.obs;
  RxString replyTo = "".obs;
  Post? selectedPost;
  RxList<Comment> comments = <Comment>[].obs;
  RxBool isCommenting = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedPost = getArguments("post");
    getListComment();
  }

  Future initData() async {
    getListComment();
  }

  Future getListComment() async {
    isLoading.value = true;
    Map<String, dynamic> bodyData = {
      'post_id': selectedPost?.id ?? -1,
      'order_by': 'amount_like',
      'second_order': 'updated_time'
    };
    try {
      ListCommentResponse? listCommentResponse = await api.listComment(bodyData: bodyData);
      if (listCommentResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (listCommentResponse.errorCode!.isEmpty) {
        comments.value = listCommentResponse.data?.data ?? [];
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(listCommentResponse.errorCode!)
        );
      }
    } catch (e) {
      print('Ex: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void commentPost() async {
    isCommenting.value = true;

    Map<String, dynamic> bodyData = {
      'post_id': selectedPost?.id ?? -1,
      'content': commentCtl.text.trim()
    };
    try {
      CreateCommentResponse? createCommentResponse = await api.createComment(bodyData: bodyData);
      if (createCommentResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (createCommentResponse.errorCode!.isEmpty) {
        commentCtl.text = "";
        var data = createCommentResponse.data;
        Comment comment = Comment(
          content: data?.content ?? "",
          userComment: UserComment(
            id: globalController?.userInfo.value.id ?? -1,
            avatar: globalController?.userInfo.value.avatar ?? "",
            username: globalController?.userInfo.value.username ?? "",
          ),
          createdTime: data?.createdTime ?? ""
        );
        comments.insert(0, comment);
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(createCommentResponse.errorCode!)
        );
      }
    } catch (e) {
      print('Ex: ${e.toString()}');
    } finally {
      isCommenting.value = false;
    }
    hideKeyboard();
  }

  void deletePost({required int commentId, required int index}) async {
    Map<String, dynamic> bodyData = {
      'comment_id': commentId,
    };
    try {
      CommonResponse? commonResponse = await api.deleteComment(bodyData: bodyData);
      if (commonResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (commonResponse.errorCode!.isEmpty) {
        comments.removeAt(index);
        showSnackBar(
            Get.context!,
            AppColor.red,
            "Đã xóa bình luận."
        );
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(commonResponse.errorCode!)
        );
      }
    } catch (e) {
      print('Ex: ${e.toString()}');
    } finally {
      isCommenting.value = false;
    }
    hideKeyboard();
  }

  void likeComment({required int commentId}) async {
    try {
      CommonResponse? commonResponse = await api.likeComment(commentId);
    } catch (e) {
      print('Ex: ${e.toString()}');
    }
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