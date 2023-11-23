import 'dart:io';

import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/shared/colors.dart';
import 'create_group_ctl.dart';

class CreateGroupPage extends BaseView<CreateGroupCtl> {
  const CreateGroupPage({super.key});

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
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
              GestureDetector(
                onTap: () => Get.back(),
                child: const Text('Hủy', style: ThemeTextStyle.body16,),
              ),
              const Text('Tạo nhóm', style: ThemeTextStyle.heading16,),
              GestureDetector(
                onTap: () {
                  controller.createGroup();
                },
                child: const Text('Xong', style: BaseTextStyle(fontSize: 16, color: AppColor.blueTag, fontWeight: FontWeight.w600),),
              )
            ],
          ),
        ),
        divider(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.requestPermission(toDo: controller.pickImage);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: !controller.avatarUrl.value.contains("http") && controller.avatarUrl.value.isNotEmpty
                                ? imageFile(
                                height: 95.w,
                                width: 95.w,
                                file: File(controller.avatarUrl.value),
                              fit: BoxFit.cover
                            )
                                : cacheImage(
                                isAvatar: false,
                                fit: BoxFit.contain,
                                imgUrl: controller.avatarUrl.value,
                                width: Get.width,
                                height: 95.w
                            ),
                          )
                      ),
                      const SizedBox(height: 12,),
                      GestureDetector(
                          onTap: () {
                            controller.requestPermission(toDo: controller.pickImage);
                          },
                          child: const Text("Chọn ảnh bìa", style: ThemeTextStyle.heading13Blue,)
                      ),
                    ],
                  ),
                ),
                divider(),
                Column(
                  children: [
                    _itemInfo(title: 'Tên nhóm', editCtl: controller.nameCtl),
                    _itemInfo(title: 'Chủ đề', editCtl: controller.topicCtl),
                    _itemInfo(title: 'Mô tả', editCtl: controller.bioCtl, isShowBorder: false, maxLines: 4),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
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
                  divider(),
                ]
            ),
        ],
      ),
    );
  }

}