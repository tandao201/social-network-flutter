import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/commons/health_entity.dart';
import 'package:get/get.dart';

import '../../utils/shared/enums.dart';
import 'health_info_result_repo.dart';

class HealthInfoResultCtl extends BaseCtl<HealthInfoResultRepo> {
  Gender gender = Gender.male;
  int age = 0;
  double height = 0.0;
  double weight = 0.0;
  RxDouble bmi = (0.0).obs;
  RxDouble waterMount = (0.0).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
    waterMount.value = weight * factor;
  }

  double calculateFactor() {
    if (age < 10) return 0.01;
    if (age < 55) return 0.375;
    return 0.03;
  }
}