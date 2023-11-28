import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/widgets/widget_utils.dart';
import '../health_prediction_ctl.dart';

class IssueDetailBottomSheet extends StatelessWidget with WidgetUtils  {

  IssueDetailBottomSheet({Key? key,}) : super(key: key);

  final controller = Get.find<HealthPredictionCtl>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingIssue.value)  return const Center(child: CircularProgressIndicator(),);
      var issue = controller.issueEntity.value;
      return Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              contentText(
                title: "Tên gọi: ",
                content: issue.name ?? ""
              ),
              contentText(
                  title: "Mô tả: ",
                  content: issue.description ?? ""
              ),
              contentText(
                  title: "Điều kiện y tế: ",
                  content: issue.medicalCondition ?? ""
              ),
              contentText(
                  title: "Phương pháp chữa trị: ",
                  content: issue.treatmentDescription ?? ""
              ),
            ],
          ),
        ),
      );
    });
  }
}