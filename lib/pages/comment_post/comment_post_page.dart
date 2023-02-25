import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../base/base_view.dart';
import '../../utils/shared/assets.dart';
import '../../utils/shared/colors.dart';
import '../../utils/themes/text_style.dart';
import 'comment_post_ctl.dart';

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
              child: controller.isLoading.value
                  ? Container()
                  : ScrollablePositionedList.builder(
                      physics: const BouncingScrollPhysics(),
                      itemScrollController: controller.itemScrollController,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        if (index == 0) return _itemComment(isShowLike: false);
                        return _itemComment(index: index);
                      },
                    ),
            ),
            divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: controller.isReply.value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    width: double.infinity,
                    color: AppColor.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trả lời tới ${controller.replyTo}",
                          style: const BaseTextStyle(fontSize: 12, color: AppColor.white),),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            controller.clearReplyComment();
                          },
                          icon: const Icon(Icons.close, color: AppColor.white, size: 16,),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      avatar(
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
                                child: Text('Thêm', style: BaseTextStyle(
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemComment({
    bool isShowLike = true,
    int? index,
  }) {
    RxBool liked = false.obs;
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
                        cacheImage(
                            imgUrl: "",
                            width: 30.w,
                            height: 30.w
                        ),
                        const SizedBox(width: 6,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(text: 'username1', style: ThemeTextStyle.heading13),
                                      TextSpan(text: ' 7w', style: BaseTextStyle(color: AppColor.grey, fontSize: 12)),
                                    ]
                                ),
                              ),
                              const SizedBox(height: 2,),
                              Text('Trang và Nhi – 2 cô gái 9x tự tin nghỉ việc khi có 100 triệu tiết kiệm trong tay, tự tin sống tốt dù thất nghiệp trong 1 năm tới', style: ThemeTextStyle.body13,),
                              const SizedBox(height: 8,),
                              if (isShowLike)
                                GestureDetector(
                                  onTap: () {
                                    controller.onTapReplyComment("username1", index!);
                                  },
                                  child: Text("Trả lời", style: BaseTextStyle(color: AppColor.grey, fontSize: 12, fontWeight: FontWeight.w600),),
                                )
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
                    },
                    icon: !liked.value
                        ? const Icon(Icons.favorite_outline_rounded, color: AppColor.black,size: 16,)
                        : Icon(Icons.favorite_rounded, color: AppColor.red,size: 16,),
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