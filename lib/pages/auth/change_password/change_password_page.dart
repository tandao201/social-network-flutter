import 'package:chat_app_flutter/utils/shared/utilities.dart';
import 'package:chat_app_flutter/pages/auth/login/login_ctl.dart';
import 'package:chat_app_flutter/pages/auth/login/login_repo.dart';
import 'package:chat_app_flutter/utils/shared/assets.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../utils/shared/colors.dart';
import '../../../utils/shared/constants.dart';
import '../../../utils/themes/text_style.dart';
import '../../../utils/widgets/expandable_section.dart';
import '../register/register_page.dart';

class ChangePasswordPage extends StatelessWidget with WidgetUtils, Utilities {

  ChangePasswordPage({Key? key}) : super(key: key);
  final repo = Get.put(LoginRepo());
  final controller = Get.put(LoginCtl());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
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
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19,),
                        ),
                      ),
                      const Text('Đổi mật khẩu', style: ThemeTextStyle.heading16,),
                      const SizedBox(),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                            height: Constants.widthScreen/2+30,
                            width: Constants.widthScreen/2,
                            child: Image.asset(Assets.changePassImage, fit: BoxFit.fill,),
                          ),
                          PasswordEditText(controller: controller, hintText: "Mật khẩu cũ", editingController: controller.passwordCtl,),
                          SizedBox(height: 12.h,),
                          PasswordEditText(controller: controller, hintText: "Mật khẩu mới", editingController: controller.passwordRegisCtl!,),
                          SizedBox(height: 12.h,),
                          PasswordEditText(controller: controller, hintText: "Nhập lại mật khẩu", editingController: controller.rePasswordRegisCtl!,),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => ExpandedSection(
                                axis: Axis.vertical,
                                expand: controller.errorInfoRegister.value.isNotEmpty,
                                child: Text(controller.errorInfoRegister.value, style: ThemeTextStyle.body12Red,),
                              )),
                            ],
                          ),
                          SizedBox(height: 30.h,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50.h,
                            child: RoundedLoadingButton(
                                borderRadius: 5,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor.black,
                                controller: controller.btnController,
                                onPressed: () {
                                  if(controller.isValidateInfoChangePass()) {
                                    controller.changePass();
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 14),
                                  child: Text('Đổi mật khẩu', style: ThemeTextStyle.heading14White,),
                                )
                            ),
                          ),
                          SizedBox(height: 40.h,),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

}