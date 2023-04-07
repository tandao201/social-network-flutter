import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/home/search/search_ctl.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/responses/auth_responses/login_response.dart';
import '../../../utils/shared/constants.dart';

class SearchPage extends BaseView<SearchCtl> {
  const SearchPage({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: textFormFieldLogin(
                    borderRadius: 10,
                    leadingIcon: const Icon(Icons.search_rounded),
                    hintText: "Tìm kiếm...",
                    controller: controller.searchCtl,
                    focusNode: controller.searchFocus,
                    onFieldSubmitted: (value) {
                      print('search..............$value');
                      controller.searchByKey();
                    }
                ),
              ),
            ],
          ),
        ),
        divider(),
        TabBar(
          isScrollable: true,
          controller: controller.tabController,
          tabs: [
            Tab(icon: Text(
              'Tài khoản',
              style: ThemeTextStyle.heading13.copyWith(color: controller.currentTab.value == 0 ? AppColor.black : AppColor.grey),
            )),
            Tab(icon: Text(
              'Bài viết',
              style: ThemeTextStyle.heading13.copyWith(color: controller.currentTab.value == 1 ? AppColor.black : AppColor.grey),
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
              ? _buildListUser()
              : _buildListPost(),
        )
    );
  }

  Widget _buildListUser() {
    return controller.isLoading.value
      ? buildLoadingUser()
      : SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(controller.usersSearch.length, (index) {
              var userInfo = controller.usersSearch[index];
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

  Widget _buildListPost() {
    return controller.isLoading.value
        ? loadingPost()
        : listPost();
  }

  Widget listPost() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Wrap(
        children: List.generate(controller.postsSearch.length, (index) {
          var post = controller.postsSearch[index];
          return InkWell(
            onTap: () {
              controller.onClickPost(
                selectedPost: post,
                postIndex: index
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColor.white, width: 1),
                    right: BorderSide(color: AppColor.white, width: 1),
                  )
              ),
              child: cacheImage(
                  imgUrl:  post.image ?? "",
                  width: (Constants.widthScreen-3)/3,
                  height: (Constants.widthScreen-3)/3,
                  isAvatar: false
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget loadingPost() {
    return SingleChildScrollView(
      child: Wrap(
        children: List.generate(15, (index) {
          // var post = controller.postsSearch[index];
          return itemLoadingPost();
        }),
      ),
    );
  }

  Widget itemLoadingPost() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColor.white, width: 1),
              right: BorderSide(color: AppColor.white, width: 1),
            ),
        ),
        child: Container(
          color: AppColor.white,
          width: (Constants.widthScreen-3)/3,
          height: (Constants.widthScreen-3)/3,
        ),
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
        ],
      ),
    );
  }

}