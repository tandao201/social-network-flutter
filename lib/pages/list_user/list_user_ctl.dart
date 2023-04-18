import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/list_user/list_user_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/responses/auth_responses/login_response.dart';
import '../../models/responses/list_user_response.dart';
import '../../utils/shared/colors.dart';
import '../../utils/shared/constants.dart';
import '../../utils/shared/enums.dart';

class ListUserCtl extends BaseCtl<ListUserRepo> with GetSingleTickerProviderStateMixin {
  TabController? tabController;

  RxList<UserInfo> followers = <UserInfo>[].obs;
  RxList<UserInfo> followings = <UserInfo>[].obs;
  RxList<UserInfo> requestsFollow = <UserInfo>[].obs;

  RxInt currentTab = 0.obs;
  UserInfo currentUser = UserInfo();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    currentTab.value = getArguments('index');
    currentUser = globalController!.userInfo.value;
    tabController = TabController(
        length: 3,
        vsync: this,
        animationDuration: const Duration(milliseconds: 500)
    );
    animateToPage(currentTab.value);
  }

  Future initData() async {
    await getListUser();
  }

  Future getListUser() async {
    isLoading.value = true;
    String url = getUrlByTab();
    try {
      ListUserResponse? listUserResponse = await api.getList(url: url);
      if (listUserResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (listUserResponse.errorCode!.isEmpty) {
        setData(listUserResponse);
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(listUserResponse.errorCode!)
        );
      }
    } catch (e) {
      print("Ex: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future animateToPage(int index) async {
    tabController?.animateTo(index);
    currentTab.value = index;
    initData();
    print('Change index: $index');
  }

  String getUrlByTab() {
    switch(currentTab.value) {
      case 0:
        return Constants.listFollowers;
      case 1:
        return Constants.listFollowing;
      case 2:
        return Constants.listRequestFollow;
      default:
        return "";
    }
  }

  void setData(ListUserResponse listUserResponse) {
    switch(currentTab.value) {
      case 0:
        followers.value = listUserResponse.data?.data ?? [];
        break;
      case 1:
        followings.value = listUserResponse.data?.data ?? [];
        break;
      case 2:
        requestsFollow.value = listUserResponse.data?.data ?? [];
        break;
      default:
        break;
    }
  }

  void onClickActionUser(UserInfo userInfo, int status) {
    if ( status == FriendStatus.request.index) {
      var response = api.receiveFriend(userInfo.id.toString()).then((value) => {
        if (value!.errorCode!.isEmpty) {
          requestsFollow.remove(userInfo)
        } else {
          showSnackBar(
          Get.context!,
          AppColor.red,
          ErrorCode.getMessageByError(value.errorCode!))
        }
      });
    }
    if ( status == FriendStatus.cancel.index) {
      var response = api.cancelFriend(userInfo.id.toString()).then((value) => {
        if (value!.errorCode!.isEmpty) {
          followers.remove(userInfo)
        } else {
          showSnackBar(
              Get.context!,
              AppColor.red,
              ErrorCode.getMessageByError(value.errorCode!))
        }
      });
    }
  }
}