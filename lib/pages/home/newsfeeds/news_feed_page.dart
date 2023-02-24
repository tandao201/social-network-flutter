import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_ctl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
      physics: const BouncingScrollPhysics(),
      children: [
        homeNewsFeed(context),
        homeNewsFeed(context),
      ],
    );
  }
  Widget homeNewsFeed(BuildContext context) {
    print('Init.....');
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
                  print('to message page........');
                },
                child: SvgPicture.asset(Assets.message, ),
              )
            ],
          ),
        ),
        Expanded(
          child: controller.isLoading.value
              ? const Center(
            child: CupertinoActivityIndicator(),
          )
              : RefreshIndicator(
            onRefresh: () => controller.initData(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                          if (index == controller.listStory.length) {
                            return _itemStory(
                                user: controller.listStory[index], isLast: true
                            );
                          }
                          return _itemStory(
                            user: controller.listStory[index],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: AppColor.lightGrey1,
                  ),
                  _itemNewsFeed(
                      context: context,
                      width: Constants.widthScreen
                  ),
                  _itemNewsFeed(
                      context: context,
                      width: Constants.widthScreen
                  ),
                  _itemNewsFeed(
                      context: context,
                      width: Constants.widthScreen
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
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
                        imgUrl: 'https://cdn.tgdd.vn/Files/2014/06/07/548830/8-luu-y-de-co-duoc-mot-buc-anh-dep-bang-smartphone-2.jpg',
                        height: 32.w,
                        width: 32.w
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Tan' , style: ThemeTextStyle.heading13,),
                      SizedBox(height: 1,),
                      Text('Hà Nội, Việt Nam' , style: ThemeTextStyle.body11,),
                    ],
                  )
                ],
              ),
              SvgPicture.asset(Assets.moreOption)
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
                  imgUrl: 'https://cdn.tgdd.vn/Files/2014/06/07/548830/8-luu-y-de-co-duoc-mot-buc-anh-dep-bang-smartphone-2.jpg',
                  height: width,
                  width: width
              ),
              Positioned(
                top: 14,
                right: 14,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: AppColor.blueDark
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Text('1/3', style: ThemeTextStyle.body12White,),
                ),
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
                                  : Icon(Icons.favorite_rounded, color: AppColor.red,size: 28,) ,
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
                          TextSpan(text: 'Tan ', style: ThemeTextStyle.heading13),
                          TextSpan(text: 'Bạn Tân đẹp zai quá, xứng đáng có 100 người iuu! ', style: ThemeTextStyle.body13),
                        ]
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Text('20 giờ trước', style: BaseTextStyle(fontSize: 12, color: AppColor.grey),),
                const SizedBox(height: 8,),
              ],
            ),
          ),
        )
      ],
    ));
  }

}