import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/models/responses/post_responses/newsfeed_response.dart';
import 'package:chat_app_flutter/pages/chat/chat_home_page.dart';
import 'package:chat_app_flutter/utils/extensions/string_extension.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_ctl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/commons/user.dart';
import '../../../routes/route_names.dart';
import '../../../utils/shared/assets.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/shared/constants.dart';
import '../../../utils/themes/text_style.dart';

class NewsFeedPage extends BaseView<NewsFeedCtl> {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {

    return PageView(
      controller: controller.pageController,
      physics: const BouncingScrollPhysics(),
      children: [
        homeNewsFeed(context),
        const ChatHomePage(),
      ],
    );
  }
  Widget homeNewsFeed(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: AppBar().preferredSize.height-8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(Assets.svgLogo, width: 95.w,),
              GestureDetector(
                onTap: () {
                  controller.animateToIndex(1);
                },
                child: SvgPicture.asset(Assets.message, ),
              )
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => controller.initData(),
            child: SingleChildScrollView(
              controller: controller.scrollCtl,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(controller.listStory.length, (index) {
                          return InkWell(
                            onTap: () {
                              if (index != 0) {
                                controller.toPage(routeUrl: RouteNames.story);
                              } else {
                                Get.toNamed(RouteNames.createPost, arguments: {
                                  'from': 'homeStory'
                                });
                              }
                            },
                            child: Hero(
                              tag: "tag$index",
                              child: _itemStory(
                                user: controller.listStory[index],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  divider(),
                  controller.isLoading.value
                    ? loadingList()
                    : buildNewsfeed(context),
                  controller.isLoadMore.value
                    ? const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 12),
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                    : const SizedBox(width: 0,)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget loadingList() {
    return Column(
      children: [
        _loadingNewsfeed(),
        _loadingNewsfeed(),
        _loadingNewsfeed(),
      ],
    );
  }

  Widget buildNewsfeed(BuildContext context) {
    return controller.newsFeeds.isNotEmpty
      ? Column(
      children: List.generate(controller.newsFeeds.length, (index) => itemNewsFeed(
        isShowFollow: controller.newsFeeds[index].userId != controller.globalController?.userInfo.value.id,
        context: context,
        width: Constants.widthScreen,
        newsfeed: controller.newsFeeds[index],
        onClickComment: () {
          controller.toPage(routeUrl: RouteNames.commentPost);
        },
        onRequestFriend: () {
          controller.api.requestFriend(controller.newsFeeds[index].userId.toString());
        },
        onClickProfile: () {
          controller.toProfilePage(userId: controller.newsFeeds[index].userId!);
        }
      )),
    )
      : noData(type: "bài viết");
  }

  Widget _itemStory({
    UserFirebase? user,
    String username = "User",
    String imgUrl = "",
    bool isRead = false,
    bool isLast = false,
  }) {
    RxBool isCurrentUser = (user!.name == controller.currentUser.username).obs;
    if (isCurrentUser.value) {
      imgUrl = controller.currentUser.avatar ?? "";
    }
    return Obx(() => Container(
      margin: EdgeInsets.only(right: isLast ? 0 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: !isCurrentUser.value && user.stories!.isNotEmpty,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: isRead ? AppColor.gradientReaded : AppColor.gradientPrimary,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: 67.w,
                  height: 67.w,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: isCurrentUser.value ? null : user.stories!.isNotEmpty ? Border.all(
                    width: 3,
                    color: AppColor.white,
                  ) : null,
                  color: AppColor.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: cacheImage(
                      imgUrl: imgUrl,
                      width: 56.w,
                      height: 56.w
                  ),
                ),
              ),
              Visibility(
                visible: isCurrentUser.value,
                child: Positioned(
                  right: 0,
                  bottom: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 23.w,
                        width: 23.w,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(60)
                        ),
                      ),
                      Container(
                        height: 17.w,
                        width: 17.w,
                        // padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColor.blueTag,
                            border: Border.all(
                                color: AppColor.white,
                                width: 3,
                                style: BorderStyle.none
                            )
                        ),
                        child: const Icon(Icons.add, color: AppColor.white, size: 12,),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 5.h,),
          Text(isCurrentUser.value ? 'Tin của bạn' : user.name!, style: ThemeTextStyle.body12,)
        ],
      ),
    ));
  }

  Widget _loadingNewsfeed({
    double width = 375,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          color: Colors.white,
                          height: 32.w,
                          width: 32.w
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 20.w,
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                            ),
                        )
                      ],
                    )
                  ],
                ),
                SvgPicture.asset(Assets.moreOption)
              ],
            ),
          ),
          Container(
              height: width,
              width: width,
              color: Colors.white,
          ),
          const SizedBox(height: 8,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20.w,
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4,),
                Container(
                  height: 20.w,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4,),
              ],
            ),
          )
        ],
      ),
    );
  }
}