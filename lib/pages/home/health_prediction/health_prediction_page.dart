import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/home/health_prediction/health_prediction_ctl.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../utils/shared/assets.dart';
import '../../../utils/shared/colors.dart';
import 'items/predict_result_item.dart';
import 'items/symptom_item_widget.dart';

class HealthPredictionPage extends BaseView<HealthPredictionCtl> {

  const HealthPredictionPage({super.key});

  @override
  Widget viewBuilder(BuildContext context) {
    return controller.isLoading.value
      ? const Center(child: CircularProgressIndicator(),)
      : Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: AppBar().preferredSize.height-8,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.w),
                    child: Image.asset(Assets.loginBanner, width: 50.w, height: 50.w,),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildBody(),
              ),
            ),
          ],
        );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () => controller.initData(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Hôm nay bạn cảm thấy thế nào?",
                style: ThemeTextStyle.heading16,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: Get.height * 0.3
              ),
              child: IntrinsicHeight(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: List.generate(controller.symptoms.length, (index) {
                      var item = controller.symptoms[index];
                      return SymptomItem(
                          text: item.name ?? "",
                          isSelect: controller.selectedSymptoms.contains(item.id ?? -1),
                          onPressed: () => controller.onPressedSymptom(item.id ?? -1)
                      );
                    }),
                  ),
                ),
              ),
            ),
            _buildSelectGender(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              width: Get.width,
              height: 50.h,
              child: RoundedLoadingButton(
                  borderRadius: 16,
                  width: Get.width,
                  color: AppColor.black,
                  successColor: AppColor.green,
                  controller: controller.btnController,
                  onPressed: () {
                    controller.healthPrediction();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Text('Chuẩn đoán', style: ThemeTextStyle.heading14White,),
                  )
              ),
            ),
            _buildPrediction()
          ],
        ),
      ),
    );
  }

  Widget _buildSelectGender() {
    return Container();
  }

  Widget _buildPrediction() {
    return Obx(() {
      if (controller.predictionsList.isEmpty && !controller.isLoadingPredict.value) return const SizedBox();
      return Column(
        children: List.generate(controller.predictionsList.length, (index) {
          var item = controller.predictionsList[index];
          return PredictResultItem(
            predictEntity: item,
            onPressed: () {
              controller.onPressedIssue(item.Issue?.ID ?? -1);
            },
          );
        }),
      );
    });
  }

}