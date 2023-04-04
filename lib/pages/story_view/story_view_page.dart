import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/stories_response.dart';
import 'package:chat_app_flutter/pages/story_view/story_view_ctl.dart';
import 'package:chat_app_flutter/utils/extensions/string_extension.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

import '../../utils/shared/colors.dart';

class StoryViewPage extends BaseView<StoryViewCtl> {
  const StoryViewPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    // TODO: implement viewBuilder
    return Scaffold(
      body: SafeArea(
        child: controller.isLoading.value
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : PageView.builder(
                controller: controller.pageController,
                itemCount: controller.listStory.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: <Widget>[
                      Hero(
                        tag: "tag${index+1}",
                        child: StoryView(
                          storyItems: controller.storiesItem[index],
                          controller: controller.storyCtl,
                          onComplete: () {
                            controller.currentStory.value++;
                            controller.stopMusic();
                            if (controller.currentStory.value >= controller.listStory.length) {
                              Get.back();
                            } else {
                              controller.pageController.animateToPage(
                                  controller.currentStory.value,
                                  duration: const Duration(milliseconds: 700),
                                  curve: Curves.easeInOut
                              );
                            }
                          },
                          onVerticalSwipeComplete: (v) {
                            if (v == Direction.down) {
                              controller.stopMusic();
                              Get.back();
                            }
                          },
                          onStoryShow: (storyItem) async {
                            controller.seenStory(storyItem.id);
                            controller.currentTime.value = storyItem.createdTime;
                            if (storyItem.usersView.isNotEmpty) {
                              // test
                              controller.usersView.value = storyItem.usersView as List<UserInfo>;
                            }
                            await controller.playMusic(storyItem.music);
                          },
                        ),
                      ),
                      Container(
                        height: 60.w,
                        padding:
                        const EdgeInsets.only(top: 25, left: 16, right: 16),
                        child: _buildProfileView(controller.listStory[index], ),
                      ),
                      Visibility(
                        visible: controller.listStory[index].userId == controller.globalController?.userInfo.value.id,
                        child: Positioned(
                          bottom: 20,
                          left: 20,
                          child: InkWell(
                            onTap: () {
                              controller.showUserView();
                            },
                            child: Obx(()=>Text('▲ ${controller.usersView.length} lượt xem', style: ThemeTextStyle.heading13.copyWith(color: AppColor.white),)),
                          ),
                        ),
                      )
                    ],
                  );
                },
                onPageChanged: (index) {
                  controller.currentStory.value = index;
                },
              ),
      ),
    );
  }

  Widget _buildProfileView(StoriesData storiesData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: cacheImage(
                    imgUrl:
                    storiesData.avatar ?? "",
                    width: 30.w,
                    height: 30.w),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storiesData.username ?? "",
                    style: const BaseTextStyle(
                        fontSize: 15,
                        color: AppColor.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Obx(() => Text(
                    controller.currentTime.value.timeAgo(),
                    style: const BaseTextStyle(fontSize: 12, color: Colors.white38),
                  ))
                ],
              ),
            ],
          ),
        ),
        IconButton(
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.close,
            color: AppColor.white,
          ),
          onPressed: () {
            controller.stopMusic();
            Get.back();
          },
        )
      ],
    );
  }
}

class StoryViewer extends StatelessWidget with WidgetUtils {
  final StoryViewCtl controller;

  StoryViewer({Key? key, required this.controller}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${controller.usersView.length} lượt xem', style: ThemeTextStyle.heading18,),
              const SizedBox(height: 8,),
              Column(
                children: List.generate(controller.usersView.length, (index) {
                  var user = controller.usersView[index];
                  if (user.id == controller.globalController?.userInfo.value.id)  return const SizedBox();
                  return _itemUser(userInfo: user);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemUser({
    required UserInfo userInfo,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatar(
              imgUrl: userInfo.avatar ?? "",
              height: 25.w,
              width: 25.w
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInfo.username ?? "Người dùng",
                  style: ThemeTextStyle.body13,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}
