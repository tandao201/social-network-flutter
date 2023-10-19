import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:get/get.dart';

import '../../utils/shared/enums.dart';
import 'health_info_result_repo.dart';

class HealthInfoResultCtl extends BaseCtl<HealthInfoResultRepo> {
  Gender gender = Gender.male;
  int age = 0;
  double height = 0.0;
  double weight = 0.0;
  RxDouble bmi = (0.0).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (isHasArguments("gender")) {
      gender = getArguments("gender");
      age = int.tryParse(getArguments("age")) ?? 0;
      height = double.tryParse(getArguments("height")) ?? (0.0);
      weight = double.tryParse(getArguments("weight")) ?? (0.0);
    }
    calculateBMI();
  }

  void calculateBMI() {
    // height.toStringAsFixed(2);
    double heightM = height/100;
    bmi.value = weight / (heightM * heightM);
  }
}