import 'package:chat_app_flutter/base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'health_info_ctl.dart';

class HealthInfoPage extends BaseView<HealthInfoCtl> {
  const HealthInfoPage({super.key});



  @override
  Widget viewBuilder(BuildContext context) {
    RxString text = "helo".obs;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text(text.value),
        ),
      ),
    );
  }

}