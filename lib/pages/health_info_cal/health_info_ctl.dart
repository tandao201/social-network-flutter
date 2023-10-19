import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/commons/health_entity.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../routes/route_names.dart';
import '../../utils/shared/enums.dart';
import 'health_info_repo.dart';

class HealthInfoCtl extends BaseCtl<HealthInfoRepo> {
  Rx<Gender> gender = Gender.male.obs;
  RxInt age = 20.obs;
  RxDouble height = (160.0).obs;
  RxDouble weight = (50.0).obs;
  TextEditingController ageCtl = TextEditingController();
  TextEditingController heightCtl = TextEditingController();
  TextEditingController weightCtl = TextEditingController();

  void onClickCalculate() {
    globalController?.userInfo.value.healthEntity = HealthEntity(
      age: int.tryParse(ageCtl.text) ?? 0,
      height: double.tryParse(heightCtl.text) ?? (0.0),
      weight: double.tryParse(weightCtl.text) ?? (0.0),
    );
    // globalController?.userInfo.value.;
    globalController?.saveUser(globalController?.userInfo.value ?? UserInfo());

    toPage(routeUrl: RouteNames.addHealthInfoResult, arguments: {
      "gender": gender.value,
      "age": ageCtl.text,
      "height": heightCtl.text,
      "weight": weightCtl.text,
    });
  }
}