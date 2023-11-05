import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/group_detail/group_detail_ctl.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_names.dart';
import '../../utils/shared/constants.dart';
import '../home/newsfeeds/items/newsfeed_loading.dart';
import 'items/stacked_widget.dart';

class GroupDetailPage extends BaseView<GroupDetailCtl> {
  const GroupDetailPage({super.key});

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        onClickLeading: () => Get.back(),
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: const Icon(
              Icons.menu_rounded,
              size: 28,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 16,)
        ]
      ),
      body: SafeArea(
        child: controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _buildGroup(context),
      ),
    );
  }

  Widget _buildGroup(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.initData(ignoreLoading: true),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cacheImage(
                imgUrl: controller.group.value.banner ?? "",
                width: Get.width,
                height: Get.height * 0.25,
                fit: BoxFit.fill
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(controller.group.value.name ?? "", style: ThemeTextStyle.heading18,),
            ),
            const SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("${controller.groupMembers.length + 1} thành viên", style: ThemeTextStyle.body14,),
            ),
            const SizedBox(height: 16,),
            _buildPreviewMembers(),
            const SizedBox(height: 8,),
            const Divider(height: 1,),
            const SizedBox(height: 8,),
            _buildCreatePost(),
            const SizedBox(height: 8,),
            const Divider(height: 1,),
            const SizedBox(height: 16,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Trao đổi", style: ThemeTextStyle.heading16,),
            ),
            const SizedBox(height: 8,),
            buildNewsfeed(context)
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewMembers() {
    if (controller.groupMembers.isEmpty)  return const SizedBox();

    var items = List.generate(controller.groupMembers.length, (index) {
      var member = controller.groupMembers[index];
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: cacheImage(
            width: 28,
            height: 28,
            imgUrl: member.avatar ?? "",
          ),
        ),
      );
    });
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StackedWidgets(
        direction: TextDirection.ltr,
        items: [...items],
        size: 28,
        xShift: 6,
        label: "",
      ),
    );
  }

  Widget _buildCreatePost() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              avatar(
                  imgUrl: controller.myInfo.avatar ?? ""
              ),
              const SizedBox(width: 8,),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    toPage(routeUrl: RouteNames.createPost, arguments: {
                      "from": "group",
                      "group_id": controller.groupId
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(32)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Text("Viết gì đó...", style: ThemeTextStyle.body11.copyWith(color: Colors.grey),),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNewsfeed(BuildContext context) {
    if (controller.isLoadingFeeds.value)  return const NewsfeedLoading();
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

}