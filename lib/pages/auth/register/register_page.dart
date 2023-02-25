import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/auth/login/login_ctl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/themes/text_style.dart';
import '../../../utils/widgets/expandable_section.dart';
import '../../../utils/widgets/widget_utils.dart';

class RegisterPage extends BaseView<LoginCtl> {
  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textFormFieldLogin(
            hintText: "Tài khoản",
            controller: controller.usernameRegisCtl!,
            onTextChange: (value) {
              controller.errorInfoRegister.value = "";
            }
        ),
        SizedBox(height: 12.h,),
        textFormFieldLogin(
            hintText: "Username",
            controller: controller.usernameInAppRegisCtl!,
            onTextChange: (value) {
              controller.errorInfoRegister.value = "";
            }
        ),
        SizedBox(height: 12.h,),
        PasswordEditText(controller: controller, hintText: "Mật khẩu", editingController: controller.passwordRegisCtl!,),
        SizedBox(height: 12.h,),
        PasswordEditText(controller: controller, hintText: "Nhập lại mật khẩu", editingController: controller.rePasswordRegisCtl!,),
        SizedBox(height: 20.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ExpandedSection(
              axis: Axis.vertical,
              expand: controller.errorInfoRegister.value.isNotEmpty,
              child: Text(controller.errorInfoRegister.value, style: ThemeTextStyle.body12Red,),
            ),
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
                if (controller.isValidateInfoRegister()) {
                  controller.register();
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text('Đăng kí', style: ThemeTextStyle.heading14White,),
              )
          ),
        ),
        SizedBox(height: 40.h,),
      ],
    );
  }

}
class PasswordEditText extends StatefulWidget with WidgetUtils {
  String hintText;
  final LoginCtl controller;
  TextEditingController editingController;
  PasswordEditText({Key? key, required this.controller, required,required this.hintText, required this.editingController}) : super(key: key);

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
            hintText: widget.hintText,
            controller: widget.editingController,
            obscureText: !isShowPass,
            onTextChange: (value) {
              widget.controller.errorInfoRegister.value = "";
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
