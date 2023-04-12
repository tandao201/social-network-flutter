import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/list_user/list_user_ctl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../models/responses/auth_responses/login_response.dart';
import '../../utils/shared/colors.dart';
import '../../utils/themes/text_style.dart';

class ListUserPage extends BaseView<ListUserCtl> {
  const ListUserPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildBody()
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: AppBar().preferredSize.height-6,
          color: AppColor.white,
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
                  Text('${controller.currentUser.username}', style: ThemeTextStyle.heading13,),
                ],
              ),
              const SizedBox()
            ],
          ),
        ),
        divider(),
        TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(icon: Text(
              'Người theo dõi',
              style: ThemeTextStyle.heading13.copyWith(color: controller.currentTab.value == 0 ? AppColor.black : AppColor.grey),
            )),
            Tab(icon: Text(
              'Đang theo dõi',
              style: ThemeTextStyle.heading13.copyWith(color: controller.currentTab.value == 1 ? AppColor.black : AppColor.grey),
            )),
            Tab(icon: Text(
              'Yêu cầu theo dõi',
              style: ThemeTextStyle.heading13.copyWith(color: controller.currentTab.value == 2 ? AppColor.black : AppColor.grey),
            )),
          ],
          indicatorColor: AppColor.black,
          indicatorWeight: 1,
          onTap: (index) {
            controller.animateToPage(index);
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.initData();
          },
          child: controller.currentTab.value == 0
            ? _buildListUser(controller.followers)
            : controller.currentTab.value == 1
              ? _buildListUser(controller.followings)
              : _buildListUser(controller.requestsFollow)
        )
    );
  }

  Widget _buildListUser(RxList<UserInfo> users) {
    return controller.isLoading.value
        ? buildLoadingUser()
        : SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(users.length, (index) {
              var userInfo = users[index];
              return InkWell(
                onTap: () {
                  controller.toProfilePage(userId: userInfo.id ?? -1);
                },
                child: _itemUser(userInfo: userInfo),
              );
            }),
          ),
        );
  }

  Widget _itemUser({
    required UserInfo userInfo,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatar(
              imgUrl: userInfo.avatar ?? "",
              height: 40.w,
              width: 40.w
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
                const SizedBox(height: 4,),
                Text(userInfo.bio ?? "", style: ThemeTextStyle.body12.copyWith(color: AppColor.grey), maxLines: 2, overflow: TextOverflow.ellipsis,)
              ],
            ),
          ),
          const SizedBox(width: 12,),
          InkWell(
            onTap: () {
              controller.onClickActionUser(userInfo);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.grey
              ),
              child: Text(getFriendStatus(userInfo.status ?? -1), style: ThemeTextStyle.body11.copyWith(color: AppColor.white),),
            ),
          )
        ],
      ),
    );
  }
}