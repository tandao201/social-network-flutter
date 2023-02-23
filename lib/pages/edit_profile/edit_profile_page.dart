import 'package:chat_app_flutter/pages/edit_profile/edit_profile_ctl.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/base_view.dart';
import '../../utils/shared/assets.dart';
import '../../utils/themes/text_style.dart';

class EditProfilePage extends BaseView<EditProfileCtl> {
  const EditProfilePage({Key? key}) : super(key: key);

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
                children: [
                  // SizedBox(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text('Hủy', style: ThemeTextStyle.body16,),
                  ),
                  const Text('Chỉnh sửa', style: ThemeTextStyle.heading16,),
                  GestureDetector(
                    onTap: () {
                      print('Click done change profile.............');
                      Get.back();
                    },
                    child: const Text('Xong', style: BaseTextStyle(fontSize: 16, color: AppColor.blueTag, fontWeight: FontWeight.w600),),
                  )
                ],
              ),
            ),
            Expanded(
              child: controller.isLoading.value
                  ? Container()
                  : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('Change avatar------------');
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.w),
                                child: cacheImage(
                                    imgUrl: "",
                                    width: 95.w,
                                    height: 95.w
                                ),
                              )
                            ),
                            SizedBox(height: 12,),
                            GestureDetector(
                              onTap: () {
                                print('Change avatar--------------');
                              },
                              child: const Text("Thay đổi ảnh đại diện", style: ThemeTextStyle.heading13Blue,)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}