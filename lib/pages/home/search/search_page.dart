import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/home/search/search_ctl.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

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
      ? _buildLoadingUser()
      : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  print('Click notification');
                },
                child: _itemUser(),
              ),
              InkWell(
                onTap: () {
                  print('Click notification');
                },
                child: _itemUser(),
              ),
              InkWell(
                onTap: () {
                  print('Click notification');
                },
                child: _itemUser(),
              ),
              InkWell(
                onTap: () {
                  print('Click notification');
                },
                child: _itemUser(),
              ),
              InkWell(
                onTap: () {
                  print('Click notification');
                },
                child: _itemUser(),
              ),
              InkWell(
                onTap: () {
                  print('Click notification');
                },
                child: _itemUser(),
              ),
            ],
          ),
      );
  }

  Widget _buildListPost() {
    return controller.isLoading.value
        ? loadingPost()
        : listPost();
  }

  Widget _buildLoadingUser() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(8, (index) => _itemLoadingUser()),
      ),
    );
  }

  Widget listPost() {
    return SingleChildScrollView(
      child: Wrap(
        children: List.generate(10, (index) {
          // var post = controller.postsSearch[index];
          return Container(
            decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.white, width: 1),
                  right: BorderSide(color: AppColor.white, width: 1),
                )
            ),
            child: cacheImage(
                imgUrl:  "",
                width: (Constants.widthScreen-3)/3,
                height: (Constants.widthScreen-3)/3,
                isAvatar: false
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

  Widget _itemUser() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          cacheImage(
              imgUrl: "",
              height: 40.w,
              width: 40.w
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đây là nội dung kjashd ajskd asjdh asjkd jashd aks djkas djkas djhas djkhas kjd",
                  style: ThemeTextStyle.body13,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4,),
                Text('Tên', style: ThemeTextStyle.body12.copyWith(color: AppColor.grey),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemLoadingUser() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40.w,
              width: 40.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColor.white
              ),
            ),
            const SizedBox(width: 12,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16.w,
                    width: 200.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColor.white
                    ),
                  ),
                  const SizedBox(height: 4,),
                  Container(
                    height: 10.w,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColor.white
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}