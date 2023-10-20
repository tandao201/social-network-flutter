import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/utils/extensions/double_bmi_extension.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_names.dart';
import '../../utils/shared/colors.dart';
import 'health_info_result_ctl.dart';

class HealthInfoResultPage extends BaseView<HealthInfoResultCtl> {
  final bool showLeading;

  const HealthInfoResultPage({super.key, this.showLeading = true});

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "BMI",
        isShowLeading: showLeading,
        onClickLeading: () {
          Get.back();
        },
        actions: [
          GestureDetector(
            onTap: () {
              controller.toPage(routeUrl: RouteNames.addHealthInfo);
            },
            child: const Icon(
              Icons.edit_note_rounded,
              size: 28,
            ),
          )
        ]
      ),
      body: SafeArea(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32,),
                      Text(
                        controller.bmi.value.toStringAsFixed(2),
                        style: BaseTextStyle(
                            fontSize: 48,
                            fontWeight:
                            FontWeight.bold,
                            color: controller.bmi.value.getColor()
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        controller.bmi.value.getBodyShapeString(),
                        style: BaseTextStyle(
                            fontSize: 18,
                            color: controller.bmi.value.getColor()
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48,),
                      buildRisk(),
                      const SizedBox(height: 16,),
                      buildShouldDo(),
                      const SizedBox(height: 16,),
                    ],
                  ),
                ),
              ),
              if (showLeading)
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      controller.toPagePopUtil(routeUrl: RouteNames.home);
                    },
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: AppColor.gradientPrimary,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Text("Bắt đầu", style:  BaseTextStyle(color: AppColor.white, fontSize: 15))),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRisk() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        border: Border.all(
          color: Colors.red,
          width: 1
        ),
        borderRadius: BorderRadius.circular(6)
      ),
      child: Column(
        children: [
          const Text(
            "Nguy cơ",
            style: BaseTextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 6,),
          Text(
            controller.bmi.value.getRiskString(),
            style: const BaseTextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  Widget buildShouldDo() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2),
          border: Border.all(
              color: Colors.green,
              width: 1
          ),
          borderRadius: BorderRadius.circular(6)
      ),
      child: Column(
        children: [
          const Text(
            "Lời khuyên",
            style: BaseTextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 6,),
          Text(
            controller.bmi.value.getThingShouldDo(),
            style: const BaseTextStyle(
              fontSize: 14,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }

}