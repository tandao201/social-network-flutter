import 'package:get/get.dart';

import 'health_prediction_ctl.dart';
import 'health_prediction_repo.dart';

class HealthPredictionBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HealthPredictionRepo());
    Get.put(HealthPredictionCtl());
  }

}