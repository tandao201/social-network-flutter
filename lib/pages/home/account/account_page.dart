import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/auth/change_password/change_password_page.dart';
import 'package:chat_app_flutter/pages/home/account/account_ctl.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:chat_app_flutter/utils/widgets/expandable_pageview.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/shared/assets.dart';
import '../../../utils/shared/colors.dart';

class AccountPage extends BaseView<AccountCtl> {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    // TODO: implement viewBuilder
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          width: double.infinity,
          height: AppBar().preferredSize.height-8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(),
              Text(controller.username.value, style: ThemeTextStyle.heading18,),
              GestureDetector(
                onTap: () {
                  // controller.logout();
                  controller.selectMenu();
                  print('Click menu account.............');
                },
                child: SvgPicture.asset(Assets.menu),
              )
            ],
          ),
        ),
        Expanded(
          child: controller.isLoading.value
              ? Container()
              : RefreshIndicator(
                  onRefresh: () => controller.initData(),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              avatar(
                                width: 86.w,
                                height: 86.w,
                                imgUrl: controller.avatarUrlImg.value
                              ),
                              SizedBox(width: 30.w,),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Text('54', style: ThemeTextStyle.heading15,),
                                        SizedBox(height: 5,),
                                        Text('Bài viết', style: ThemeTextStyle.body11,),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Text('1402', style: ThemeTextStyle.heading15,),
                                        SizedBox(height: 5,),
                                        Text('Người theo dõi', style: ThemeTextStyle.body11,),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Text('1402', style: ThemeTextStyle.heading15,),
                                        SizedBox(height: 5,),
                                        Text('Đang theo dõi', style: ThemeTextStyle.body11,),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 12,),
                          Text(controller.name.value, style: ThemeTextStyle.heading12,),
                          if (controller.bio.value.isNotEmpty)
                            Text(controller.bio.value, style: ThemeTextStyle.body11,),
                          const SizedBox(height: 15,),
                          GestureDetector(
                            onTap: () {
                              controller.toPage(
                                  routeUrl: RouteNames.editProfile,
                                  arguments: {
                                      "username" : controller.username,
                                      "name" : controller.name,
                                      "bio" : controller.bio,
                                      "avatar" : controller.avatarUrlImg
                                  }
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: AppColor.lightGrey1,
                                      width: 1
                                  )
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text("Chỉnh sửa", style: ThemeTextStyle.heading13,),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: AppColor.lightGrey, width: 1)
                              )
                            ),
                            child: TabBar(
                                controller: controller.tabController,
                                tabs: [
                                  Tab(icon: SvgPicture.asset(
                                    Assets.grid,
                                    color: controller.currentTab.value == 0 ? AppColor.black : AppColor.grey,)
                                  ),
                                  Tab(icon: SvgPicture.asset(Assets.tag,color: controller.currentTab.value == 1 ? AppColor.black : AppColor.grey)),
                                ],
                                indicatorColor: AppColor.black,
                                indicatorWeight: 1,
                              onTap: (index) {
                                  controller.animateToPage(index);
                              },
                            )
                          ),
                          SingleChildScrollView(
                            child: ExpandablePageView(
                              controller: controller.pageController,
                              onPageChanged: (index) {
                                controller.animateToPage(index);
                                controller.tabController?.animateTo(index);
                              },
                              children: [
                                listPost(),
                                noContent(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }

  Widget listPost() {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColor.white, width: 1),
              right: BorderSide(color: AppColor.white, width: 1),
            )
          ),
          child: cacheImage(
              imgUrl: 'https://cdn.tgdd.vn/Files/2014/06/07/548830/8-luu-y-de-co-duoc-mot-buc-anh-dep-bang-smartphone-2.jpg',
              width: (Constants.widthScreen-36)/3,
              height: (Constants.widthScreen-36)/3,
              isAvatar: false
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.white, width: 1),
                right: BorderSide(color: AppColor.white, width: 1),
              )
          ),
          child: cacheImage(
              imgUrl: 'https://cdn.tgdd.vn/Files/2014/06/07/548830/8-luu-y-de-co-duoc-mot-buc-anh-dep-bang-smartphone-2.jpg',
              width: (Constants.widthScreen-36)/3,
              height: (Constants.widthScreen-36)/3,
              isAvatar: false
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.white, width: 1),
                right: BorderSide(color: AppColor.white, width: 1),
              )
          ),
          child: cacheImage(
              imgUrl: 'https://cdn.tgdd.vn/Files/2014/06/07/548830/8-luu-y-de-co-duoc-mot-buc-anh-dep-bang-smartphone-2.jpg',
              width: (Constants.widthScreen-36)/3,
              height: (Constants.widthScreen-36)/3,
              isAvatar: false
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.white, width: 1),
                right: BorderSide(color: AppColor.white, width: 1),
              )
          ),
          child: cacheImage(
              imgUrl: 'https://cdn.tgdd.vn/Files/2014/06/07/548830/8-luu-y-de-co-duoc-mot-buc-anh-dep-bang-smartphone-2.jpg',
              width: (Constants.widthScreen-36)/3,
              height: (Constants.widthScreen-36)/3,
              isAvatar: false
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.white, width: 1),
                right: BorderSide(color: AppColor.white, width: 1),
              )
          ),
          child: cacheImage(
              imgUrl: 'https://cdn.tgdd.vn/Files/2014/06/07/548830/8-luu-y-de-co-duoc-mot-buc-anh-dep-bang-smartphone-2.jpg',
              width: (Constants.widthScreen-36)/3,
              height: (Constants.widthScreen-36)/3,
              isAvatar: false
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.white, width: 1),
                right: BorderSide(color: AppColor.white, width: 1),
              )
          ),
          child: cacheImage(
              imgUrl: 'https://cdn.tgdd.vn/Files/2014/06/07/548830/8-luu-y-de-co-duoc-mot-buc-anh-dep-bang-smartphone-2.jpg',
              width: (Constants.widthScreen-36)/3,
              height: (Constants.widthScreen-36)/3,
              isAvatar: false
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.white, width: 1),
                right: BorderSide(color: AppColor.white, width: 1),
              )
          ),
          child: cacheImage(
              imgUrl: 'https://cdn.tgdd.vn/Files/2014/06/07/548830/8-luu-y-de-co-duoc-mot-buc-anh-dep-bang-smartphone-2.jpg',
              width: (Constants.widthScreen-36)/3,
              height: (Constants.widthScreen-36)/3,
              isAvatar: false
          ),
        ),
      ],
    );
  }

  Widget noContent() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(height: 20,),
          Text('Ảnh và video của bạn.', style: ThemeTextStyle.heading18),
          SizedBox(height: 20,),
          Text('Khi mọi người nhắc đến bạn trong ảnh và video, chúng sẽ xuất hiện ở đây.', textAlign: TextAlign.center,)
        ],
      ),
    );
  }
  
}

class MenuAccount extends StatelessWidget with WidgetUtils {
  final AccountCtl controller;

  const MenuAccount({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(top: 24),
      color: AppColor.lightGrey,
      height: Constants.heightScreen/3,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.back();
              Get.to(() => ChangePasswordPage(), transition: Transition.rightToLeftWithFade);
            },
            child: _itemMenu("Đổi mật khẩu", Icons.key_sharp),
          ),
        ],
      ),
    );
  }

  Widget _itemMenu(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColor.black, size: 20,),
          const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: ThemeTextStyle.body16,),
                const SizedBox(height: 10,),
                divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}