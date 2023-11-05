import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/responses/list_group_response.dart';
import 'package:chat_app_flutter/pages/home/groups/list_group_repo.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:get/get.dart';

class ListGroupCtl extends BaseCtl<ListGroupRepo> {
  RxList<GroupEntity> myGroups = <GroupEntity>[].obs;
  RxList<GroupEntity> groups = <GroupEntity>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading.value = true;
    initData();
  }

  Future initData() async {
    await Future.wait([
      getMyGroups(),
      getGroups()
    ]);
    isLoading.value = false;
  }

  Future getMyGroups() async {
    try {
      var response = await api.getMyGroups();
      myGroups.clear();
      myGroups.addAll(response ?? []);
    } catch (e) {
      print("Ex: ${e.toString()}");
    }
  }

  Future getGroups() async {
    try {
      var response = await api.getGroups();
      groups.clear();
      groups.addAll(response ?? []);
    } catch (e) {
      print("Ex: ${e.toString()}");
    }
  }

  void onPressed({required int groupId}) {
    toPage(routeUrl: RouteNames.groupDetail, arguments: {
      "id": groupId
    });
  }

  Future joinGroup(int groupId, int index) async {
    try {
      var response = await api.joinGroup(groupId);
      if ((response?.data ?? false)) {
        var groupEntity = groups.removeAt(index);
        myGroups.add(groupEntity);
        myGroups.refresh();
        groups.refresh();
      }
    } catch (e) {
      print('Ex: ${e.toString()}');
    }
  }
}