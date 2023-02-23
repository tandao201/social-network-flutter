import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/shared/colors.dart';

abstract class BaseView<T extends BaseCtl> extends StatelessWidget with WidgetUtils {
  Widget viewBuilder(BuildContext context);

  const BaseView({Key? key}) : super(key: key);

  T get controller => GetInstance().find<T>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        color: AppColor.white,
        child: viewBuilder(context),
      ),
    ));
  }

}