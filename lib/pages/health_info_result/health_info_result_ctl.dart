import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/commons/health_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/shared/enums.dart';
import 'health_info_result_repo.dart';

class HealthInfoResultCtl extends BaseCtl<HealthInfoResultRepo> with GetSingleTickerProviderStateMixin {
  Gender gender = Gender.male;
  int age = 0;
  double height = 0.0;
  double weight = 0.0;
  RxDouble bmi = (0.0).obs;
  RxDouble waterAmount = (0.0).obs;
  RxDouble inDayWaterAmount = (2.6).obs;
  RxInt currentPage = 0.obs;
  TabController? tabController;
  RxString title = "Sức khỏe của tôi".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(
      length: 2,
      vsync: this
    );
    initData();
  }

  void initData() {
    if (isHasArguments("gender")) {
      gender = getArguments("gender");
      age = int.tryParse(getArguments("age")) ?? 0;
      height = double.tryParse(getArguments("height")) ?? (0.0);
      weight = double.tryParse(getArguments("weight")) ?? (0.0);
    } else {
      HealthEntity? healthEntity = globalController?.userInfo.value.healthEntity;
      age = healthEntity?.age ?? 0;
      height = healthEntity?.height ?? (0.0);
      weight = healthEntity?.weight ?? (0.0);
    }
    calculateBMI();
    calculateWaterMount();
  }

  void calculateBMI() {
    // height.toStringAsFixed(2);
    double heightM = height/100;
    bmi.value = weight / (heightM * heightM);
  }

  void calculateWaterMount() {
    double factor = calculateFactor();
    waterAmount.value = weight * factor;
  }

  double calculateFactor() {
    if (age < 10) return 0.01;
    if (age < 55) return 0.0375;
    return 0.03;
  }
}