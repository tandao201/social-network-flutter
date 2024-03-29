import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/commons/common_response.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/create_post_response.dart';
import 'package:chat_app_flutter/pages/home/account/account_ctl.dart';
import 'package:chat_app_flutter/pages/user_profile/user_profile_page.dart';
import 'package:chat_app_flutter/service/database_service.dart';
import 'package:chat_app_flutter/utils/shared/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../routes/route_names.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/shared/constants.dart';
import '../../utils/widgets/widgets.dart';
import '../chat/chat_page.dart';
import '../home/account/account_repo.dart';

class UserProfileCtl extends BaseCtl<AccountRepo> with GetSingleTickerProviderStateMixin {

  TabController? tabController;
  PageController pageController = PageController();
  AccountCtl? accountCtl;

  int userId = -1;
  Rx<UserInfo> userInfo = UserInfo().obs;
  Rx<int> currentTab = 0.obs;
  RxString username = "Người dùng".obs;
  RxList<Post> userPosts = <Post>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    accountCtl = Get.find<AccountCtl>();
    userId = getArguments("userId");
    tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 500)
    );
    initData();
  }

  Future initData() async {
    isLoading.value = true;
    await getUserDetail();
  }

  Future getUserDetail() async {
    Map<String, dynamic> bodyData = {
      'user_id': userId,
    };
    try {
      CommonResponse<UserInfo>? commonResponse = await api.getUserDetail(bodyData: bodyData);
      if (commonResponse == null) {
        debugPrint('Response null');
        isLoading.value = false;
        return ;
      }
      if (commonResponse.errorCode!.isEmpty) {
        userInfo.value = commonResponse.data!;
        userPosts.value = userInfo.value.posts!;
        username.value = commonResponse.data!.username!;
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(commonResponse.errorCode!)
        );
      }
      isLoading.value = false;
    } catch (e) {
      print('Ex: ${e.toString()}');
      isLoading.value = false;
    }
  }

  void onClickFollow() {
    if (userInfo.value.friend == FriendStatus.accept.index) {
      showBarModalBottomSheet(
          context: Get.context!,
          builder: (context) {
            return FollowBottomSheet(controller: this);
          }
      );
    } else {
      api.requestFriend('$userId').then((value) {
        userInfo.value.friend = FriendStatus.request.index;
        userInfo.refresh();
      });
    }
  }

  void unFollow() {
    api.requestFriend('$userId', status: FriendStatus.unfollow.index).then((value) {
      userInfo.value.friend = FriendStatus.unfollow.index;
      userInfo.refresh();
      userPosts.value = [];
      userPosts.refresh();
      Get.back();
    });
  }

  Future animateToPage(int index) async {
    currentTab.value = index;
    pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut
    );
  }

  void onClickAllPost(int postIndex) {
    toPage(routeUrl: RouteNames.allPosts, arguments: {
      'type': 'all',
      'postIndex': postIndex,
      'currentUser': userInfo.value,
      'posts': userPosts
    });
  }

  void onClickMessage() async {
    // if(userInfo.value.id == globalController?.userInfo.value.id) {
    //   showDialogCustom(
    //     content: 'Bạn không thể nhắn tin cho chính mình'
    //   );
    // }

    String groupId = 'new';
    bool isStop = false;
    var snapshot = await DatabaseService().gettingUserData(globalController?.userInfo.value.email ?? "");
    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      if ((data['groups'] as List).isNotEmpty) {
        for (var group in data['groups']) {
          if( userInfo.value.username! == getName(group)) {
            groupId = getId(group);
            isStop = true;
            break;
          }
        }
      }
      if (isStop) break;
    }
    print('group id: $groupId');
    nextScreen(
        Get.context,
        ChatPage(
          groupId: groupId,
          avatarImg: userInfo.value.avatar ?? "",
          groupName: userInfo.value.username ?? "",
          userName: globalController?.userInfo.value.username ?? "",
          colorPage: AppColor.pink,
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
    pageController.dispose();
  }
}