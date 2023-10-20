import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/models/responses/post_responses/stories_response.dart';
import 'package:chat_app_flutter/pages/chat/chat_home_page.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_ctl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
            children: [
              SvgPicture.asset(Assets.svgLogo, width: 95.w,),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  controller.toPage(routeUrl: RouteNames.notification);
                },
                child: const Icon(
                  Icons.favorite_border_sharp,
                  size: 28,
                ),
              ),
              const SizedBox(width: 8,),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildListStories(),
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

  Widget buildListStories() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: controller.isLoadingStory.value
          ? _listLoadingStories()
          : Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(controller.listStory.length, (index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Get.toNamed(RouteNames.createPost, arguments: {
                    'from': 'homeStory'
                  });
                },
                child: _itemStory(
                  story: controller.listStory[index],
                ),
              );
            }
            return InkWell(
              onTap: () {
                controller.toPage(
                  routeUrl: RouteNames.story,
                  arguments: {
                    "stories": controller.listStory
                  }
                );
              },
              child: Hero(
                tag: "tag$index",
                child: _itemStory(
                  story: controller.listStory[index],
                ),
              ),
            );
          }).toList(),
        ),
      ),
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
          controller.toPage(routeUrl: RouteNames.commentPost, arguments: {
            'post': controller.newsFeeds[index]
          });
        },
        onRequestFriend: () {
          controller.api.requestFriend(controller.newsFeeds[index].userId.toString());
        },
        onClickProfile: () {
          controller.toProfilePage(userId: controller.newsFeeds[index].userId!);
        },
        onClickLike: () {
          controller.api.likePost(controller.newsFeeds[index].id.toString());
        }
      )),
    )
      : noData(type: "bài viết");
  }

  Widget _itemStory({
    StoriesData? story,
    String imgUrl = "",
    bool isRead = false,
    bool isLast = false,
  }) {
    RxBool isCurrentUser = (story!.userId == controller.currentUser.id).obs;
    if (isCurrentUser.value) {
      imgUrl = controller.currentUser.avatar ?? "";
    } else {
      imgUrl = story.avatar ?? "";
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
                visible: story.listStory != null,
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
                  border: story.listStory != null ? Border.all(
                    width: 1,
                    color: AppColor.white,
                  ) : null,
                  color: AppColor.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: cacheImage(
                      imgUrl: imgUrl,
                      width: 60.w,
                      height: 60.w
                  ),
                ),
              ),
              Visibility(
                visible: isCurrentUser.value && story.listStory == null,
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
          Text(isCurrentUser.value && story.listStory == null ? 'Tạo tin mới' : story.username!, style: ThemeTextStyle.body12,)
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

  Widget _loadingStory() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: AppColor.white,
        ),
        height: 60.w,
        width: 60.w,
      ),
    );
  }

  Widget _listLoadingStories() {
    return Row(
      children: [
        for (int i=0 ; i<10 ; i++)
          _loadingStory()
      ],
    );
  }
}