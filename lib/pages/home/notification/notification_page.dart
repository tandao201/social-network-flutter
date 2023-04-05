import 'package:chat_app_flutter/models/responses/notification_response.dart';
import 'package:chat_app_flutter/pages/home/notification/notification_ctl.dart';
import 'package:chat_app_flutter/utils/extensions/string_extension.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../base/base_view.dart';
import '../../../utils/themes/text_style.dart';

class NotificationPage extends BaseView<NotificationCtl> {
  const NotificationPage({Key? key}) : super(key: key);

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Thông báo', style: ThemeTextStyle.heading16,),
                    SizedBox(),
                  ],
                ),
              ),
              Expanded(
                child: controller.isLoading.value
                  ? _buildLoading()
                  : _buildNotification(),
              )
            ],
          )
      ),
    );
  }
  
  Widget _buildNotification() {
    return RefreshIndicator(
      onRefresh: () => controller.initData(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: controller.notifications.isNotEmpty
          ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(controller.notifications.length, (index) {
            var noti = controller.notifications[index];
            return InkWell(
              onTap: () {
                controller.clickNotification(noti.type ?? -1, noti.targetId ?? -1);
              },
              child: _itemNotification(noti),
            );
          }),
        )
          : noData(type: "thông báo"),
      ),
    );
  }

  Widget _buildLoading() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(8, (index) => _itemNotificationLoading()),
      ),
    );
  }

  Widget _itemNotification(NotiData notification) {
    String title = notification.listNoti?[0].title ?? "";
    if (notification.listNoti!.length > 1) {
      title = '${notification.listNoti!.length-1} người khác và $title';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatar(
              imgUrl: notification.listNoti?[0].avatar ?? "",
              height: 40.w,
              width: 40.w
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ThemeTextStyle.body13,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4,),
                Text('${notification.listNoti?[0].createdTime}'.timeAgo(), style: ThemeTextStyle.body12.copyWith(color: AppColor.grey),)
              ],
            ),
          ),
          // const SizedBox(width: 12,),
          // cacheImage(
          //     imgUrl: "https://img-global.cpcdn.com/recipes/dc40cc82f880e0a7/680x482cq70/bun-d%E1%BA%ADu-m%E1%BA%AFm-tom-n%C6%B0%E1%BB%9Bc-ch%E1%BA%A5m-d%E1%BA%ADm-v%E1%BB%8B-ngon-h%C6%A1n-ngoai-hang-recipe-main-photo.webp",
          //     height: 40.w,
          //     width: 40.w,
          //     isAvatar: false
          // ),
        ],
      ),
    );
  }

  Widget _itemNotificationLoading() {
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
            const SizedBox(width: 12,),
            Container(
              height: 40.w,
              width: 40.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.white
              ),
            )
          ],
        ),
      ),
    );
  }
  
}