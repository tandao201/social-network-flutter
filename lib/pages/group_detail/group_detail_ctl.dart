import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/responses/list_group_response.dart';
import 'package:chat_app_flutter/pages/group_detail/group_detail_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/responses/auth_responses/login_response.dart';
import '../../models/responses/post_responses/create_post_response.dart';

class GroupDetailCtl extends BaseCtl<GroupDetailRepo> {
  int groupId = -1;
  Rx<GroupEntity> group = GroupEntity().obs;
  RxList<UserInfo> groupMembers = <UserInfo>[].obs;
  UserInfo myInfo = UserInfo();
  RxList<Post> newsFeeds = <Post>[].obs;
  RxBool isLoadingFeeds = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    myInfo = globalController?.userInfo.value ?? UserInfo();
    isLoading.value = true;
    if (isHasArguments("id")) {
      groupId = getArguments("id");
      initData();
      getNewsfeed();
    }
  }

  Future initData({bool ignoreLoading = false}) async {
    getNewsfeed(ignoreLoading: ignoreLoading);
    await Future.wait([
      getGroupInfo(),
      getGroupMember()
    ]);
    isLoading.value = false;
  }

  Future getGroupInfo() async {
    try {
      Map<String, dynamic> params = {
        "group_id": groupId
      };
      var response = await api.getGroupInfo(params: params);
      group.value = GroupEntity();
      group.value = response ?? GroupEntity();
    } catch (e) {
      print("Ex: ${e.toString()}");
    }
  }

  Future getGroupMember() async {
    try {
      Map<String, dynamic> params = {
        "group_id": groupId
      };
      var response = await api.getGroupMember(params: params);
      groupMembers.clear();
      groupMembers.addAll(response ?? []);
    } catch (e) {
      print("Ex: ${e.toString()}");
    }
  }

  Future getNewsfeed({bool ignoreLoading = false}) async {
    if (!ignoreLoading) isLoadingFeeds.value = true;
    Map<String, dynamic> bodyData = {
      'group_id': groupId,
    };
    try {
      var newsFeedResponse = await api.getNewsFeed(bodyData: bodyData);
      newsFeeds.clear();
      newsFeeds.addAll(newsFeedResponse ?? []);
    } catch (e) {
      debugPrint('Ex: ${e.toString()}');
    } finally {
      isLoadingFeeds.value = false;
    }
  }
}