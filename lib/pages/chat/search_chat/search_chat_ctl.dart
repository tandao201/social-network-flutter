import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../models/commons/user.dart';

class SearchChatCtl extends BaseCtl {
  DatabaseService databaseService = DatabaseService();
  TextEditingController searchCtl = TextEditingController();
  RxList<String> listUser = <String>[].obs;
  RxList<UserFirebase> users = <UserFirebase>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future searchByKey() async {
    isLoading.value = true;
    listUser.value = [];
    var filterFirebase = await databaseService.userCollection.where(
        'fullName',
        isGreaterThanOrEqualTo: searchCtl.text,
        isLessThan: '${searchCtl.text}z'
    ).get();
    for(var user in filterFirebase.docs) {
      Map<String, dynamic> data = user.data() as Map<String, dynamic> ;
      users.add(UserFirebase.fromJson(data));
      listUser.add('${data['uid']}_${data['fullName']}');
    }
    isLoading.value = false;
  }
}