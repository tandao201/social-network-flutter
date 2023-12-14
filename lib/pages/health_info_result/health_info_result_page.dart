import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_names.dart';
import '../../utils/shared/colors.dart';
import 'items/bmi_page.dart';
import 'health_info_result_ctl.dart';
import 'items/water_page.dart';

class HealthInfoResultPage extends BaseView<HealthInfoResultCtl> {
  final bool showLeading;

  const HealthInfoResultPage({super.key, this.showLeading = true});

  @override
  Widget viewBuilder(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffF4F8FB),
        appBar: appBar(
            title: controller.title.value,
            isShowLeading: showLeading,
            centerTitle: showLeading,
            onClickLeading: () {
              Get.back();
            },
            actions: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    RouteNames.addHealthInfo,
                    arguments: {"showAppBar": true}
                  )?.then((value) {
                    if (value != null && value) controller.initData();
                  });
                },
                child: const Icon(
                  Icons.edit_note_rounded,
                  size: 28,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8,)
            ]
        ),
        body: SafeArea(
          child: SizedBox(
            width: Get.width,
            child: Column(
              children: [
                if (!showLeading)
                  TabBar(
                    controller: controller.tabController,
                    tabs: const [
                      Tab(text: "Uống nước",),
                      Tab(text: "BMI",),
                    ],
                  ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      if (!showLeading)
                        WaterPage(),
                      BmiPage(),
                    ],
                  ),
                ),
                if (showLeading)
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      ),
    );
  }

}