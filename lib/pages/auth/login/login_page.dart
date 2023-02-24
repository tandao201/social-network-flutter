import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/auth/login/login_ctl.dart';
import 'package:chat_app_flutter/utils/shared/assets.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/widgets/expandable_section.dart';

class LoginPage extends BaseView<LoginCtl> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    // TODO: implement viewBuilder
    return Scaffold(
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
                      SizedBox(height: 120.h,),
                      SvgPicture.asset(Assets.svgLogo),
                      SizedBox(height: 40.h,),
                      textFormFieldLogin(
                        hintText: "Username",
                        controller: controller.usernameCtl,
                        onTextChange: (value) {
                          controller.errorInfoLogin.value = "";
                        }
                      ),
                      SizedBox(height: 12.h,),
                      PasswordEditText(controller: controller),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ExpandedSection(
                            axis: Axis.vertical,
                            expand: controller.errorInfoLogin.value.isNotEmpty,
                            child: Text(controller.errorInfoLogin.value, style: ThemeTextStyle.body12Red,),
                          ),
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
                            color: AppColor.black,
                            controller: controller.btnController,
                            onPressed: () {
                              if (controller.isValidateInfoLogin()) {
                                controller.login();
                              }
                            },
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

class PasswordEditText extends StatefulWidget with WidgetUtils {
  final LoginCtl controller;
  const PasswordEditText({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordEditText> createState() => _PasswordEditTextState();
}

class _PasswordEditTextState extends State<PasswordEditText> {
  bool isShowPass = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.textFormFieldLogin(
          hintText: "Password",
          controller: widget.controller.passwordCtl,
          obscureText: !isShowPass,
          onTextChange: (value) {
            widget.controller.errorInfoLogin.value = "";
          }
        ),
        Positioned(
          top: 12,
          right: 10,
          child: InkWell(
            onTap: () {
              setState(() {
                isShowPass = !isShowPass;
              });
            },
            child: !isShowPass
              ? const Icon(Icons.visibility_rounded)
              : const Icon(Icons.visibility_off_rounded),
          ),
        )
      ],
    );
  }
}