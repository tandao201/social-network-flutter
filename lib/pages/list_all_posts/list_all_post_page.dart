import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';
import '../../base/base_view.dart';
import '../../routes/route_names.dart';
import '../../utils/shared/assets.dart';
import '../../utils/shared/colors.dart';
import '../../utils/shared/constants.dart';
import '../../utils/themes/text_style.dart';
import 'list_all_post_ctl.dart';

class ListAllPostsPage extends BaseView<ListAllPostsCtl> {
  const ListAllPostsPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: AppBar().preferredSize.height-8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${controller.currentUser.username}', style: ThemeTextStyle.heading13.copyWith(color: AppColor.grey),),
                      const Text('Bài viết', style: ThemeTextStyle.heading15,),
                    ],
                  ),
                  const SizedBox()
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.initData(),
                child: SingleChildScrollView(
                  controller: controller.autoController,
                  child: controller.isLoading.value
                      ? loadingList()
                      : buildPosts(context),
                ),
              ),
            ),
          ],
        ),
      ),
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

  Widget buildPosts(BuildContext context) {
    return Obx(() => controller.posts.isNotEmpty
        ? Column(
      children: List.generate(controller.posts.length, (index) => AutoScrollTag(
          controller: controller.autoController,
          index: index,
          key: ValueKey(index),
          child: Hero(
            tag: 'postTag$index}',
            child: itemNewsFeed(
                isShowFollow: controller.currentUser.id != controller.globalController?.userInfo.value.id,
                context: context,
                width: Constants.widthScreen,
                newsfeed: controller.posts[index],
                onClickComment: () {
                  controller.toPage(routeUrl: RouteNames.commentPost);
                },
                onRequestFriend: () {
                  controller.api.requestFriend(controller.posts[index].userId.toString());
                },
                onClickLike: () {
                  controller.api.likePost(controller.posts[index].id.toString());
                }
            ),
          )
      )),
    )
        : noData(type: "bài viết"));
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