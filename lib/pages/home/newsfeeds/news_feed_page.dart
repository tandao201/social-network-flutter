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
      children: List.generate(controller.newsFeeds.length, (index) => _itemNewsFeed(
        context: context,
        width: Constants.widthScreen,
        newsfeed: controller.newsFeeds[index],
      )),
    )
      : noData(type: "bài viết");
  }

  Widget _itemStory({
    User? user,
    String username = "User",
    String imgUrl = "",
    bool isRead = false,
    bool isLast = false,
  }) {
    bool isCurrentUser = user!.name == 'Tan';
    return Container(
      margin: EdgeInsets.only(right: isLast ? 0 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: !isCurrentUser && user.stories.isNotEmpty,
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
                  border: isCurrentUser ? null : user.stories.isNotEmpty ? Border.all(
                    width: 3,
                    color: AppColor.white,
                  ) : null,
                  color: AppColor.grey,
                ),
                child: cacheImage(
                    imgUrl: imgUrl,
                    width: 56.w,
                    height: 56.w
                ),
              ),
              Visibility(
                visible: isCurrentUser,
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
          Text(isCurrentUser ? 'Tin của bạn' : user.name, style: ThemeTextStyle.body12,)
        ],
      ),
    );
  }

  Widget _itemNewsFeed({
    required BuildContext context,
    required Newsfeed newsfeed,
    double width = 375,
  }) {
    Rx<bool> isShowHeart = false.obs;
    Rx<bool> isLike = false.obs;
    Rx<double> scale = 1.0.obs;
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: cacheImage(
                        imgUrl: newsfeed.image ?? "",
                        height: 32.w,
                        width: 32.w
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${newsfeed.userId}' , style: ThemeTextStyle.heading13,),
                      const SizedBox(height: 1,),
                      Text('Hà Nội, Việt Nam' , style: ThemeTextStyle.body11,),
                    ],
                  )
                ],
              ),
              Visibility(
                child: InkWell(
                  onTap: () {
                    controller.api.requestFriend(newsfeed.userId.toString());
                    print('Click follow....................');
                  },
                  child: const Text('Theo dõi', style: ThemeTextStyle.heading13Blue,),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            isShowHeart.value = true;
            Future.delayed(const Duration(milliseconds: 1000), () {
              isShowHeart.value = false;
            });
            if (!isLike.value) {
              isLike.value = !isLike.value;
            }
          },
          child: Stack(
            children: [
              cacheImage(
                  imgUrl: newsfeed.image ?? "",
                  height: width,
                  width: width,
                  isAvatar: false
              ),
              Visibility(
                visible: isShowHeart.value,
                child: const Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Icon(Icons.favorite_rounded, size: 120, color: AppColor.white,),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.toPage(routeUrl: RouteNames.commentPost);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: AppColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              scale.value = 1.05;
                              Future.delayed(const Duration(milliseconds: 200), () {
                                scale.value = 1.0;
                              });
                              isLike.value = !isLike.value;
                            },
                            child: AnimatedScale(
                              scale: scale.value,
                              duration: const Duration(microseconds: 50),
                              child: !isLike.value
                                  ? SvgPicture.asset(Assets.like)
                                  : const Icon(Icons.favorite_rounded, color: AppColor.red,size: 28,) ,
                            ),
                          ),
                          const SizedBox(width: 17,),
                          SvgPicture.asset(Assets.comment)
                        ],
                      ),
                      Container(),
                      SvgPicture.asset(Assets.saveNewsFeed)
                    ],
                  ),
                ),
                Text('3.123.233 lượt thích', style: ThemeTextStyle.heading13,),
                const SizedBox(height: 5,),
                Visibility(
                  visible: true,
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: '${newsfeed.userId}', style: ThemeTextStyle.heading13),
                          TextSpan(text: '  ${newsfeed.content}', style: ThemeTextStyle.body13),
                        ]
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Text('${newsfeed.createdTime}'.timeAgo(), style: BaseTextStyle(fontSize: 12, color: AppColor.grey),),
                const SizedBox(height: 8,),
              ],
            ),
          ),
        )
      ],
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