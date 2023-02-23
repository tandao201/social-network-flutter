import 'dart:io';

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
import '../../utils/shared/constants.dart';
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
                      controller.changeProfile();
                    },
                    child: const Text('Xong', style: BaseTextStyle(fontSize: 16, color: AppColor.blueTag, fontWeight: FontWeight.w600),),
                  )
                ],
              ),
            ),
            Divider(
              color: AppColor.lightGrey,
              height: 1,
            ),
            Expanded(
              child: controller.isLoading.value
                  ? Container()
                  : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.w),
                              child: controller.avatarUrl.value.isNotEmpty
                                ? imageFile(
                                    height: 95.w,
                                    width: 95.w,
                                    borderRadius: 60,
                                    file: File(controller.avatarUrl.value)
                                  )
                                : cacheImage(
                                      imgUrl: "",
                                      width: 95.w,
                                      height: 95.w
                                  ),
                            )
                          ),
                          const SizedBox(height: 12,),
                          GestureDetector(
                            onTap: () {
                              // controller.pickImage();
                              showDialogCustom(
                                onClickAction: () {
                                  print('Click');
                                      }
                              );

                            },
                            child: const Text("Thay đổi ảnh đại diện", style: ThemeTextStyle.heading13Blue,)
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColor.lightGrey,
                      height: 1,
                    ),
                    Column(
                      children: [
                        _itemInfo(title: 'Tên', editCtl: controller.nameCtl),
                        _itemInfo(title: 'Username', editCtl: controller.userNameCtl),
                        _itemInfo(title: 'Tiểu sử', editCtl: controller.bioCtl, isShowBorder: false, maxLines: 4),
                      ],
                    ),
                    Divider(
                      color: AppColor.lightGrey,
                      height: 1,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
                        child: Text('Thông tin cá nhân', style: BaseTextStyle(
                            fontSize: 15, color: AppColor.blueTag, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    _itemInfo(title: 'Email', editCtl: controller.emailCtl, textInputType: TextInputType.emailAddress),
                    _itemInfo(title: 'Điện thoại', editCtl: controller.phoneCtl, textInputType: TextInputType.number),
                    GestureDetector(
                      onTap: () {
                        print('Change giới tính.......');
                        controller.selectGender();
                      },
                      child: _itemInfo(title: 'Giới tính', editCtl: controller.genderCtl, enabled: false),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemInfo({
    required String title,
    required TextEditingController editCtl,
    bool isShowBorder = true,
    bool enabled = true,
    TextInputType textInputType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(83.w)
        },
        children: [
          TableRow(
              children: [
                Text(title, style: ThemeTextStyle.body15,),
                editTextChangeProfile(
                  controller: editCtl,
                  hintText: title,
                  enabled: enabled,
                  textInputType: textInputType,
                  maxLines: maxLines
                ),
              ]
          ),
          const TableRow(
              children: [
                SizedBox(height: 12,),
                SizedBox(height: 12,),
              ]
          ),
          if (isShowBorder )
          TableRow(
              children: [
                const SizedBox(),
                Divider(
                  color: AppColor.lightGrey,
                  height: 1,
                ),
              ]
          ),
        ],
      ),
    );
  }

}

class SelectGenderUI extends StatelessWidget {
  final EditProfileCtl controller;

  const SelectGenderUI({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16,8,16,16),
      color: AppColor.lightGrey,
      height: Constants.heightScreen/3,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text("Chọn giới tính", style: ThemeTextStyle.body15,),
          ),
          Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: controller.indexGender),
                onSelectedItemChanged: (int value) {
                  controller.indexGender = value;
                },
                itemExtent: 40,
                children: controller.genders.map((gender) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(gender, style: ThemeTextStyle.body14,)
                )).toList(),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                        height: 30,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColor.grey,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Text("Hủy", style: BaseTextStyle(color: AppColor.white, fontSize: 15))),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.genderCtl.text = controller.genders[controller.indexGender];
                      Get.back();
                    },
                    child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: AppColor.gradientPrimary,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Text("Chọn", style:  BaseTextStyle(color: AppColor.white, fontSize: 15))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}