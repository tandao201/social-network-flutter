import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/story_view/story_view_ctl.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
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
            ? Container()
            : PageView(
                controller: controller.pageController,
                children: [
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: "tag1",
                        child: StoryView(
                          storyItems: controller.storyItems,
                          controller: controller.storyCtl,
                          onComplete: () {
                            controller.stopMusic();
                            Get.back();
                          },
                          onVerticalSwipeComplete: (v) {
                            if (v == Direction.down) {
                              controller.stopMusic();
                              Get.back();
                            }
                          },
                          onStoryShow: (storyItem) async {
                            await controller.playMusic('https://p.scdn.co/mp3-preview/6ff25287b4b077010aacc6324022ef727187a0f5?cid=3b1b5d4a77e644c2929b10626bb85e4d');
                          },
                        ),
                      ),
                      Container(
                        height: 60.w,
                        padding:
                        const EdgeInsets.only(top: 25, left: 16, right: 16),
                        child: _buildProfileView(),
                      )
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: "tag2",
                        child: StoryView(
                          storyItems: controller.storyItems,
                          controller: controller.storyCtl,
                          onComplete: () {
                            controller.stopMusic();
                            Get.back();
                          },
                          onVerticalSwipeComplete: (v) {
                            if (v == Direction.down) {
                              controller.stopMusic();
                              Get.back();
                            }
                          },
                          onStoryShow: (storyItem) async {
                            await controller.playMusic('https://p.scdn.co/mp3-preview/6ff25287b4b077010aacc6324022ef727187a0f5?cid=3b1b5d4a77e644c2929b10626bb85e4d');
                          },
                        ),
                      ),
                      Container(
                        height: 60.w,
                        padding:
                        const EdgeInsets.only(top: 25, left: 16, right: 16),
                        child: _buildProfileView(),
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }

  Widget _buildProfileView() {
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
                        "https://www.wyzowl.com/wp-content/uploads/2022/04/img_624d8245533d8.jpg",
                    width: 30.w,
                    height: 30.w),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Tan dao",
                    style: BaseTextStyle(
                        fontSize: 15,
                        color: AppColor.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '2 giờ trước',
                    style: BaseTextStyle(fontSize: 12, color: Colors.white38),
                  )
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
