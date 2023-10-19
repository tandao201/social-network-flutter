import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/utils/shared/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/shared/colors.dart';
import '../../utils/shared/enums.dart';
import '../../utils/themes/text_style.dart';
import 'health_info_ctl.dart';
import 'items/gender_select_item.dart';

class HealthInfoPage extends BaseView<HealthInfoCtl> {
  const HealthInfoPage({super.key});

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48,),
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      buildImageGender(),
                      const SizedBox(width: 16,),
                      Column(
                        children: [
                          buildGender(),
                          const SizedBox(height: 32,),
                          buildAge(),
                          const SizedBox(height: 32,),
                          buildHeight(),
                          const SizedBox(height: 32,),
                          buildWeight(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () {
                    controller.onClickCalculate();
                  },
                  child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: AppColor.gradientPrimary,
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: const Text("Tính toán", style:  BaseTextStyle(color: AppColor.white, fontSize: 15))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageGender() {
    return Transform.scale(
      scale: 0.9,
      child: Image.asset(
        controller.gender.value == Gender.male
            ? Assets.menImage
            : Assets.womenImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildGender () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Giới tính",
          style: BaseTextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            GenderSelectItem(
              isSelected: controller.gender.value == Gender.male,
              gender: Gender.male,
              onPressItem: () {
                controller.gender.value = Gender.male;
              },
            ),
            const SizedBox(width: 24,),
            GenderSelectItem(
              isSelected: controller.gender.value == Gender.female,
              gender: Gender.female,
              onPressItem: () {
                controller.gender.value = Gender.female;
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildAge () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tuổi",
          style: BaseTextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          width: Get.width * 0.3,
          height: 48,
          child: textFormFieldLogin(
            controller: controller.ageCtl,
            keyboardType: TextInputType.number
          ),
        )
      ],
    );
  }

  Widget buildHeight () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Chiều cao (cm)",
          style: BaseTextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          width: Get.width * 0.3,
          height: 48,
          child: textFormFieldLogin(
              controller: controller.heightCtl,
              keyboardType: TextInputType.number
          ),
        )
      ],
    );
  }

  Widget buildWeight () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cân nặng (kg)",
          style: BaseTextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          width: Get.width * 0.3,
          height: 48,
          child: textFormFieldLogin(
              controller: controller.weightCtl,
              keyboardType: TextInputType.number
          ),
        )
      ],
    );
  }
}