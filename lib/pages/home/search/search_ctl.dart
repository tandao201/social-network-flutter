import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/commons/common_list_response.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/pages/home/search/search_repo.dart';
import 'package:chat_app_flutter/utils/shared/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/responses/post_responses/create_post_response.dart';
import '../../../routes/route_names.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/shared/constants.dart';

class SearchCtl extends BaseCtl<SearchRepo> with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController searchCtl = TextEditingController();
  FocusNode searchFocus = FocusNode();

  RxBool isSearchUser = false.obs;
  Rx<int> currentTab = 0.obs;
  RxList<Post> postsSearch = <Post>[].obs;
  RxList<UserInfo> usersSearch = <UserInfo>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 500)
    );
  }

  Future initData() async {
    searchByKey();
  }

  Future animateToPage(int index) async {
    hideKeyboard();
    currentTab.value = index;
    print('Change index: $index');
    await searchByKey();
  }

  Future searchByKey() async {
    if (searchCtl.text.isEmpty) {
      showSnackBar(
          Get.context!,
          AppColor.red,
          "Vui lòng nhập tìm kiếm."
      );
      return ;
    }
    isLoading.value = true;
    Map<String, dynamic> bodyData = {
      'text': searchCtl.text.trim(),
      'type': currentTab.value+1,
    };
    try {
      CommonListResponse? commonListResponse;
      if (currentTab.value+1 == SearchType.user.index) {
        commonListResponse = CommonListResponse<UserInfo>();
      } else {
        commonListResponse = CommonListResponse<Post>();
      }
      commonListResponse = await api.searchByKey(bodyData: bodyData);
      if (commonListResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (commonListResponse.errorCode!.isEmpty) {
        if (currentTab.value+1 == SearchType.user.index) {
          usersSearch.value = List<UserInfo>.from(commonListResponse.data!.toList());
        } else {
          postsSearch.value = List<Post>.from(commonListResponse.data!.toList());
        }
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(commonListResponse.errorCode!)
        );
      }
    } catch (e) {
      print("Ex: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void onClickPost({int postIndex = 0,required Post selectedPost}) {
    toPage(routeUrl: RouteNames.allPosts, arguments: {
      'type': 'all',
      'postIndex': postIndex,
      'currentUser': selectedPost.user,
      'posts': [
        selectedPost
      ]
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchCtl.dispose();
  }
}