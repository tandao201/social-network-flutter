import 'package:chat_app_flutter/utils/extensions/string_extension.dart';
import 'package:chat_app_flutter/utils/shared/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../base/base_view.dart';
import '../../utils/shared/colors.dart';
import '../../utils/shared/constants.dart';
import '../../utils/themes/text_style.dart';
import 'comment_post_ctl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CommentPostPage extends BaseView<CommentPostCtl> {
  const CommentPostPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              width: double.infinity,
              height: AppBar().preferredSize.height-8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19,),
                    ),
                  ),
                  const Text('Bình luận', style: ThemeTextStyle.heading16,),
                  const SizedBox(),
                ],
              ),
            ),
            divider(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.initData();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _itemComment(
                        isShowLike: false,
                        avatar: controller.selectedPost?.user?.avatar ?? "",
                        userComment: controller.selectedPost?.user?.username ?? "",
                        content: controller.selectedPost?.content ?? "",
                        timeAgo: '${controller.selectedPost?.createdTime}'.timeAgo()
                      ),
                      controller.isLoading.value
                        ? Container(
                            height: Constants.heightScreen-180.w,
                            alignment: Alignment.center,
                            child: const CupertinoActivityIndicator(),
                          )
                        : Column(
                        children: List.generate(controller.comments.length, (index) {
                          var comment = controller.comments[index];
                          return Slidable(
                            key: ValueKey(index),
                            endActionPane: comment.userComment?.id == controller.globalController?.userInfo.value.id
                              ? ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    const SlidableAction(
                                      spacing: 0,
                                      onPressed: null,
                                      backgroundColor: Color(0xFFfafafa),
                                      foregroundColor: Color(0xFFfafafa),
                                      icon: null,
                                      label: "",
                                    ),
                                    SlidableAction(
                                      spacing: 0,
                                      onPressed: (context) {
                                        controller.deletePost(
                                            commentId: comment.id!,
                                            index: index
                                        );
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: const Color(0xFFfafafa),
                                      icon: Icons.delete,
                                      label: 'Xóa',
                                    ),
                                  ],
                                )
                              : null,
                            child: _itemComment(
                                avatar: comment.userComment?.avatar ?? "",
                                userComment: comment.userComment?.username ?? "Người dùng",
                                content: comment.content ?? "",
                                timeAgo: '${comment.createdTime}'.timeAgo(),
                                likeStatus: comment.likeStatus ?? LikeStatus.dislike.index,
                                commentId: comment.id ?? -1,
                                likeAmount: comment.likeAmount
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  avatar(
                      imgUrl: controller.globalController?.userInfo.value.avatar ?? "",
                      height: 37.w,
                      width: 37.w
                  ),
                  const SizedBox(width: 4,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: AppColor.grey,
                            width: 1
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: editTextChangeProfile(
                                hintText: "Thêm bình luận...",
                                maxLines: null,
                                textInputType: TextInputType.multiline,
                                controller: controller.commentCtl,
                                focusNode: controller.commentFocus,
                                onTextChange: (value) {
                                  if (value.isEmpty) {
                                    controller.enabledComment.value = false;
                                  } else {
                                    controller.enabledComment.value = true;
                                  }
                                }
                            ),
                          ),
                          const SizedBox(width: 4,),
                          InkWell(
                            onTap: () {
                              if (controller.commentCtl.text.isNotEmpty) {
                                controller.commentPost();
                              }
                            },
                            child: controller.isCommenting.value
                              ? const CupertinoActivityIndicator()
                              : Text('Thêm', style: BaseTextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: !controller.enabledComment.value
                                      ? AppColor.blueTag.withOpacity(0.3)
                                      : AppColor.blueTag),
                                ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemComment({
    bool isShowLike = true,
    int? index,
    String avatar = "",
    String userComment = "",
    String timeAgo = "",
    String content = "",
    int? likeStatus,
    int commentId = -1,
    int? likeAmount
  }) {
    RxBool liked = (likeStatus == LikeStatus.like.index).obs;
    return GestureDetector(
      onDoubleTap: () {
        if (isShowLike && !liked.value) {
          liked.value = true;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: cacheImage(
                              imgUrl: avatar,
                              width: 30.w,
                              height: 30.w
                          ),
                        ),
                        const SizedBox(width: 6,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(text: userComment, style: ThemeTextStyle.heading13),
                                      TextSpan(text: ' $timeAgo', style: BaseTextStyle(color: AppColor.grey, fontSize: 12)),
                                    ]
                                ),
                              ),
                              const SizedBox(height: 2,),
                              Text(content, style: ThemeTextStyle.body13,),
                              const SizedBox(height: 8,),
                              if (isShowLike && (likeAmount ?? 0) > 0)
                                Text("${likeAmount} Lượt thích", style: BaseTextStyle(color: AppColor.grey, fontSize: 12, fontWeight: FontWeight.w600),)
                              // if (isShowLike)
                              //   GestureDetector(
                              //     onTap: () {
                              //       controller.onTapReplyComment("username1", index!);
                              //     },
                              //     child: Text("Trả lời", style: BaseTextStyle(color: AppColor.grey, fontSize: 12, fontWeight: FontWeight.w600),),
                              //   )
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                const SizedBox(width: 10,),
                if (isShowLike)
                  Obx(() => IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      liked.value = !liked.value;
                      controller.likeComment(commentId: commentId);
                    },
                    icon: !liked.value
                        ? const Icon(Icons.favorite_outline_rounded, color: AppColor.black,size: 16,)
                        : const Icon(Icons.favorite_rounded, color: AppColor.red,size: 16,),
                  )),
              ],
            ),
          ),
          if (!isShowLike)
            divider(),
        ],
      ),
    );
  }
}