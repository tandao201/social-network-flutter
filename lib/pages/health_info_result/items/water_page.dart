import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../health_info_result_ctl.dart';

class WaterPage extends StatelessWidget {
  WaterPage({super.key});

  final controller = Get.put(HealthInfoResultCtl());

  static const _backgroundColor = Colors.white;
  static const _colors = [
    Color(0x993BB8ED),
    Color(0x9350BEFC),
  ];

  static const _durations = [
    5000,
    4000,
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.initData();
          },
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32,),
                  _buildWaterAmount(),
                  const SizedBox(height: 32,),
                  _buildGoal(),
                  const SizedBox(height: 32,),
                  _buildAmountSelect()
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildWaterAmount() {
    double percentDone = controller.inDayWaterAmount.value / controller.waterAmount.value;
    double percent = 1 - percentDone;
    if (percent <= 0) percent = 0;

    return Stack(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              border: Border.all(
                  color: const Color(0xffADE5FC),
                  width: 8
              ),
              borderRadius: BorderRadius.circular(150)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Stack(
              fit: StackFit.expand,
              children: [
                WaveWidget(
                  config: CustomConfig(
                    colors: _colors,
                    durations: _durations,
                    heightPercentages: [
                      percent,
                      percent+0.01,
                    ],
                  ),
                  // backgroundColor: _backgroundColor,
                  size: const Size(200, 200),
                  waveAmplitude: 0,
                  heightPercentage: controller.inDayWaterAmount.value / controller.waterAmount.value,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${(percentDone * 100).toInt()} %",
                        style: const BaseTextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xFF0C8AE4)
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        "${(controller.inDayWaterAmount.value * 1000).toInt()} ml",
                        style: const BaseTextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF0C8AE4)
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoal() {
    return Row(
      children: [
        Expanded(
          child: _buildGoalItem(
              title: "Đã hoàn thành",
              value: "${(controller.inDayWaterAmount.value * 1000).toInt()}"
          ),
        ),
        const SizedBox(width: 16,),
        Expanded(
          child: _buildGoalItem(
              title: "Mục tiêu trong ngày",
              value: "${(controller.waterAmount.value * 1000).toInt()}"
          ),
        ),
      ],
    );
  }

  Widget _buildGoalItem({
    String title = "",
    String value = "",
  }) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: const Color(0xffEAF8FE),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: const BaseTextStyle(fontSize: 12, color: Colors.blue),),
          const SizedBox(height: 4,),
          Text("$value ml", style: ThemeTextStyle.heading14.copyWith(fontWeight: FontWeight.bold, color: Colors.blue),)
        ],
      ),
    );
  }

  Widget _buildAmountSelect() {
    return Column(
      children: [
        const Text("Chọn lượng nước vừa hoàn thành: ", style: ThemeTextStyle.heading18,),
        const SizedBox(height: 8,),
        Row(
          children: [
            Expanded(
              child: _buildWaterLevel(
                amount: 100,
                leadingIcon: FontAwesomeIcons.glassWaterDroplet,
                color: const Color(0xffa7a2b6),
                onPressed: () {
                  controller.addDayWaterAmount(0.1);
                }
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: _buildWaterLevel(
                  amount: 180,
                  leadingIcon: FontAwesomeIcons.glassWater,
                  color: const Color(0xffeeeeff),
                  onPressed: () {
                    controller.addDayWaterAmount(0.18);
                  }
              ),
            ),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            Expanded(
              child: _buildWaterLevel(
                  amount: 250,
                  leadingIcon: FontAwesomeIcons.water,
                  color: const Color(0xfffff8ed),
                  onPressed: () {
                    controller.addDayWaterAmount(0.25);
                  }
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: _buildWaterLevel(
                  amount: 500,
                  leadingIcon: FontAwesomeIcons.bottleWater,
                  color: const Color(0xfff8e9e5),
                  onPressed: () {
                    controller.addDayWaterAmount(0.5);
                  }
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWaterLevel({
    int amount = 100,
    required IconData leadingIcon,
    Color color = const Color(0xfff8e9e5),
    Function? onPressed,
  }) {
    return InkWell(
      onTap: () => onPressed?.call(),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 3,
              color: color
            )
        ),
        child: ListTile(
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0,
          minVerticalPadding: 0,
          dense: true,
          leading: Icon(
            leadingIcon,
          ),
          title: Text("$amount ml", style: ThemeTextStyle.body12,),
        ),
      ),
    );
  }
}