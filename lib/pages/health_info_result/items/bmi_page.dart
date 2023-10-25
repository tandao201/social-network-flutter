import 'package:chat_app_flutter/utils/extensions/double_bmi_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/themes/text_style.dart';
import '../health_info_result_ctl.dart';

class BmiPage extends StatelessWidget {

  BmiPage({super.key});

  final controller = Get.put(HealthInfoResultCtl());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Obx(() {
          return Column(
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
              if (controller.bmi.value.needRisk()) ... {
                buildRisk(),
                const SizedBox(height: 16,),
              },
              buildShouldDo(),
              const SizedBox(height: 16,),
            ],
          );
        }),
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