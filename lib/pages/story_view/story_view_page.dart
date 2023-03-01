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
            : Stack(
                children: <Widget>[
                  Hero(
                    tag: "tag3",
                    child: StoryView(
                      storyItems: controller.storyItems,
                      controller: controller.storyCtl,
                      onComplete: () {
                        Get.back();
                      },
                      onVerticalSwipeComplete: (v) {
                        if (v == Direction.down) {
                          Navigator.pop(context);
                        }
                      },
                      onStoryShow: (storyItem) {},
                    ),
                  ),
                  Container(
                    height: 60.w,
                    // width: Constants.widthScreen,
                    padding:
                        const EdgeInsets.only(top: 25, left: 16, right: 16),
                    child: _buildProfileView(),
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
          onPressed: () => Get.back(),
        )
      ],
    );
  }
}
