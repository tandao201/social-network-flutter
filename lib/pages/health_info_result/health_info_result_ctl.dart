import 'dart:convert';

import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/models/commons/health_entity.dart';
import 'package:chat_app_flutter/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/commons/water_amount_entity.dart';
import '../../utils/shared/enums.dart';
import 'health_info_result_repo.dart';

class HealthInfoResultCtl extends BaseCtl<HealthInfoResultRepo> with GetSingleTickerProviderStateMixin {
  Gender gender = Gender.male;
  int age = 0;
  double height = 0.0;
  double weight = 0.0;
  RxDouble bmi = (0.0).obs;
  RxDouble waterAmount = (0.0).obs;
  RxDouble inDayWaterAmount = (0.0).obs;
  RxInt currentPage = 0.obs;
  TabController? tabController;
  RxString title = "Sức khỏe của tôi".obs;
  WaterAmountEntity waterPlans = WaterAmountEntity();
  final notificationService = Get.find<NotificationService>();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(
      length: 2,
      vsync: this
    );
    await initData();
  }

  Future initData() async {
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
    await getWaterPlans();
    initNotification();
  }

  Future getWaterPlans() async {
    try {
      String dataStr = HelperFunctions.getString(HelperFunctions.water);
      if (dataStr.isNotEmpty) {
        var jsonMap = json.decode(dataStr);
        var water = WaterAmountEntity.fromJson(jsonMap);
        var today = DateTime.now();
        String todayStr = DateFormat('yyyy/MM/dd').format(today);
        if (water.date != todayStr) {
          water.date = todayStr;
          water.inDayWaterAmount = 0.0;
          water.waterAmount = waterAmount.value;
          waterPlans = water;
          saveWaterPlans();
        }
        waterPlans = water;
        inDayWaterAmount.value = waterPlans.inDayWaterAmount ?? 0.0;
      }
    } catch (e) {
      print('Ex get water plans: ${e.toString()}');
    }
  }

  Future saveWaterPlans() async {
    try {
      //Convert sampleList to string
      String dataStr = jsonEncode(waterPlans.toJson());
      HelperFunctions.setString(HelperFunctions.water, dataStr);
    } catch (e) {
      print('Ex get water plans: ${e.toString()}');
    }
  }

  void initNotification() {
    if (inDayWaterAmount.value < waterAmount.value) {
      notificationService.scheduleNotification();
    }
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

  void addDayWaterAmount(double amount) {
    inDayWaterAmount.value += amount;
    waterPlans.inDayWaterAmount = inDayWaterAmount.value;
    saveWaterPlans();
  }
}