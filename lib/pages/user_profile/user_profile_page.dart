import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/user_profile/user_profile_ctl.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:chat_app_flutter/utils/widgets/expandable_pageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/shared/assets.dart';
import '../../../utils/shared/colors.dart';

class UserProfilePage extends BaseView<UserProfileCtl> {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    // TODO: implement viewBuilder
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              width: double.infinity,
              height: AppBar().preferredSize.height-8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19,),
                  ),
                  const SizedBox(width: 10,),
                  Text(controller.username.value, style: ThemeTextStyle.heading18,),
                ],
              ),
            ),
            Expanded(
              child: controller.isLoading.value
                  ? const ProfileLoading()
                  : RefreshIndicator(
                      onRefresh: () => controller.initData(),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
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
                                      imgUrl: controller.userInfo.value.avatar ?? ""
                                  ),
                                  SizedBox(width: 30.w,),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('${controller.userPosts.length}', style: ThemeTextStyle.heading15,),
                                            const SizedBox(height: 5,),
                                            const Text('Bài viết', style: ThemeTextStyle.body11,),
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
                              Text(controller.userInfo.value.username ?? "Người dùng", style: ThemeTextStyle.heading12,),
                              // if (controller.userInfo.value..isNotEmpty)
                              //   Text(controller.bio.value, style: ThemeTextStyle.body11,),
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.api.requestFriend('${controller.userId}');
                                      },
                                      child: Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              gradient: AppColor.gradientPrimary,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: const Text("Theo dõi", style:  BaseTextStyle(color: AppColor.white, fontSize: 15))),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.onClickMessage();
                                      },
                                      child: Container(
                                          height: 30,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppColor.grey,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: const Text("Nhắn tin", style: BaseTextStyle(color: AppColor.white, fontSize: 15))),
                                    ),
                                  ),
                                ],
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
        ),
      )
    );
  }

  Widget listPost() {
    return controller.userPosts.isNotEmpty
      ? Wrap(
          children: List.generate(controller.userPosts.length, (index) {
            var post = controller.userPosts[index];
            return InkWell(
              onTap: () {
                controller.onClickAllPost(index);
              },
              child: Hero(
                tag: 'postTag$index',
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColor.white, width: 1),
                        right: BorderSide(color: AppColor.white, width: 1),
                      )
                  ),
                  child: cacheImage(
                      imgUrl: post.image ?? "",
                      width: (Constants.widthScreen-36)/3,
                      height: (Constants.widthScreen-36)/3,
                      isAvatar: false
                  ),
                ),
              ),
            );
          }),
        )
    : noContent(isMine: true);
  }

  Widget noContent({bool isMine = false}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          Text(isMine
              ? 'Bài viết của họ.'
              : 'Ảnh và video của họ.'
              , style: ThemeTextStyle.heading18),
          const SizedBox(height: 20,),
          Text(isMine
            ? 'Có vẻ như chưa có nội dung nào.'
            : 'Khi mọi người nhắc đến họ trong ảnh và video, chúng sẽ xuất hiện ở đây.',
            textAlign: TextAlign.center,)
        ],
      ),
    );
  }
  
}

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 86.w,
                          width: 86.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: AppColor.white
                          ),
                        ),
                        SizedBox(width: 30.w,),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i=0 ; i<3 ; i++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 10.w,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: AppColor.white
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                    Container(
                                      height: 10.w,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: AppColor.white
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12,),
                    SingleChildScrollView(
                      child: Wrap(
                        children: List.generate(15, (index) {
                          return Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.black, width: 1),
                                  right: BorderSide(color: Colors.black, width: 1),
                                )
                            ),
                            child: Container(
                                width: (Constants.widthScreen-35)/3,
                                height: (Constants.widthScreen-35)/3,
                                color: AppColor.white
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
