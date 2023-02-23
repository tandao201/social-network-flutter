import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/auth/login/login_ctl.dart';
import 'package:chat_app_flutter/utils/shared/assets.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../utils/shared/colors.dart';

class LoginPage extends BaseView<LoginCtl> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    // TODO: implement viewBuilder
    return Scaffold(
      appBar: appBar(
        onClickLeading: () => Get.back(),
      ),
      body: SafeArea(
        child: controller.isLoading.value
            ? Container()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80.h,),
                      SvgPicture.asset(Assets.svgLogo),
                      SizedBox(height: 40.h,),
                      textFormFieldLogin(
                        hintText: "Username",
                        controller: controller.usernameCtl,
                      ),
                      SizedBox(height: 12.h,),
                      textFormFieldLogin(
                        hintText: "Password",
                        controller: controller.passwordCtl,
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          GestureDetector(
                            onTap: () {
                              debugPrint('Forget pass');
                            },
                            child: const Text('Quên mật khẩu?', style: ThemeTextStyle.body13Tag,),
                          )
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50.h,
                        child: RoundedLoadingButton(
                            borderRadius: 5,
                            width: MediaQuery.of(context).size.width,
                            color: AppColor.blueTag,
                            controller: controller.btnController,
                            onPressed: controller.login,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              child: Text('Đăng nhập', style: ThemeTextStyle.heading14White,),
                            )
                        ),
                      ),
                      SizedBox(height: 40.h,),
                      Row(
                        children: [
                          Expanded(child: Divider(
                            height: 1,
                            color: AppColor.lightGrey,
                          )),
                          SizedBox(width: 30.w,),
                          Text('HOẶC', style: TextStyle(fontSize: 12, color: AppColor.grey, fontWeight: FontWeight.bold),),
                          SizedBox(width: 30.w,),
                          Expanded(child: Divider(
                            height: 1,
                            color: AppColor.lightGrey,
                          )),
                        ],
                      ),
                      SizedBox(height: 40.h,),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Chưa có tài khoản? ',
                                style: TextStyle(fontSize: 14, color: AppColor.grey)
                            ),
                            TextSpan(
                              text: 'Đăng kí.',
                              style: const TextStyle(fontSize: 14, color: AppColor.blueTag),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  controller.register();
                                }
                            )
                          ]
                        ),
                      )
                    ],
                  ),
                ),
              ),
      )
    );
  }



}